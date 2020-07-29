Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18A4231CC8
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jul 2020 12:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgG2KfR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jul 2020 06:35:17 -0400
Received: from smtp29.i.mail.ru ([94.100.177.89]:44080 "EHLO smtp29.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgG2KfR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 29 Jul 2020 06:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=lBqDflUjwLNN/n9jNWFysA0Wl2jJhgI8vRvZ7NwMnRs=;
        b=nXy6s+5oCvOBGY2KKaZEh9xkJD9PmcM8ZhQWQKugStVa1GFR9cwPhhiWGc2KVn5ejo6J4N2jEAIbhYrmqX/xaoPP8lb348FJpv1h7cqh4dO0ENVWWm8Bjcd+4gM+uo6Ikq7c2vmUNZYgUJvrdCVi/Dh6vYbNJ24f92UnpUe4ioo=;
Received: by smtp29.i.mail.ru with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1k0jQY-0001U5-45; Wed, 29 Jul 2020 13:35:14 +0300
From:   Maxim Kochetkov <fido_max@inbox.ru>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kochetkov <fido_max@inbox.ru>, linux-iio@vger.kernel.org,
        bigunclemax@gmail.com
Subject: [PATCH v3] iio: adc: ti-ads1015: fix conversion when CONFIG_PM is not set
Date:   Wed, 29 Jul 2020 13:35:23 +0300
Message-Id: <20200729103523.19073-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp29.i.mail.ru; auth=pass smtp.auth=fido_max@inbox.ru smtp.mailfrom=fido_max@inbox.ru
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD90521F83352E4771D91EDC9CB2778FA1724253D08BDDBD5E3182A05F5380850404D7AB1F70AED0C4891B7B8124841A2AB2CAA3AC3ABB184C65D00F4B69EA2AE5B
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE71E18668C3FD76909EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006373DF18198E8D8384F8638F802B75D45FF5571747095F342E8C7A0BC55FA0FE5FC00DCAC071158455DBDFAFE06ADE581F91CC702DCC10A0FE2389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C0D9442B0B5983000E8941B15DA834481FCF19DD082D7633A0E7DDDDC251EA7DABA471835C12D1D977725E5C173C3A84C353FA85A707D24CADCC7F00164DA146DA6F5DAA56C3B73B235C65C28F1120AF113AA81AA40904B5D9A18204E546F3947C8E520D49DB3894FA9735652A29929C6C4AD6D5ED66289B5218080C068C56568E6136E347CC761E07725E5C173C3A84C378909CBA80AC0BDCBA3038C0950A5D36B5C8C57E37DE458B0B4866841D68ED3567F23339F89546C55F5C1EE8F4F765FCC8FFCCCDEDEF8FF575ECD9A6C639B01BBD4B6F7A4D31EC0BC0CAF46E325F83A522CA9DD8327EE4930A3850AC1BE2E735F43AACC0BCEB2632C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-C8649E89: 8D33B4614B2FDEE57F9E982552BFEE46BB06E5686E4F7616B6D5A61B026C7691C983C15CB8136B21
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbl0bm2lVv3KbDtkI9mun9g==
X-Mailru-Sender: 11C2EC085EDE56FA9C10FA2967F5AB24C75B9FA8522DEDAF594206A75A440F41594FB4C9F0DBF412EE9242D420CFEBFD3DDE9B364B0DF2891A624F84B2C74EDA4239CF2AF0A6D4F80DA7A0AF5A3A8387
X-Mras: Ok
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

To stop conversion ads1015_set_power_state() function call unimplemented
function __pm_runtime_suspend() from pm_runtime_put_autosuspend()
if CONFIG_PM is not set.
In case of CONFIG_PM is not set: __pm_runtime_suspend() returns -ENOSYS,
so ads1015_read_raw() failed because ads1015_set_power_state() returns an
error.

If CONFIG_PM is disabled, there is no need to start/stop conversion.
Fix it by adding return 0 function variant if CONFIG_PM is not set.

Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
Tested-by: Maxim Kiselev <bigunclemax@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/ti-ads1015.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 5ea4f45d6bad..64fe3b2a6ec6 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -316,6 +316,7 @@ static const struct iio_chan_spec ads1115_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(ADS1015_TIMESTAMP),
 };
 
+#ifdef CONFIG_PM
 static int ads1015_set_power_state(struct ads1015_data *data, bool on)
 {
 	int ret;
@@ -333,6 +334,15 @@ static int ads1015_set_power_state(struct ads1015_data *data, bool on)
 	return ret < 0 ? ret : 0;
 }
 
+#else /* !CONFIG_PM */
+
+static int ads1015_set_power_state(struct ads1015_data *data, bool on)
+{
+	return 0;
+}
+
+#endif /* !CONFIG_PM */
+
 static
 int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
 {
-- 
2.27.0

