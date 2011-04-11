# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'test/unit'
require 'flexmock/test_unit'
require 'solr'


class ProxyConnectionTest < Test::Unit::TestCase 

  def test_with_http_proxy
    ENV['http_proxy'] = 'http://myproxy.com:80'
    conn = Solr::Connection.new("http://localhost:8983/solr")
    assert conn.connection.is_a?(Net::HTTP)
    assert_equal 'myproxy.com', conn.connection.proxy_address
    assert_equal 80, conn.connection.proxy_port
    assert conn.connection.proxy?
  end

  def test_without_http_proxy
    ENV['http_proxy'] = ''
    conn = Solr::Connection.new("http://localhost:8983/solr")
    assert conn.connection.is_a?(Net::HTTP)
    assert_equal nil, conn.connection.proxy_address
    assert_equal nil, conn.connection.proxy_port
    assert !conn.connection.proxy?
  end

end
