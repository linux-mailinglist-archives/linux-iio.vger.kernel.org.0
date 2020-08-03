Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738EB239E8C
	for <lists+linux-iio@lfdr.de>; Mon,  3 Aug 2020 07:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgHCFEd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 01:04:33 -0400
Received: from smtp50.i.mail.ru ([94.100.177.110]:50338 "EHLO smtp50.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgHCFEd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 3 Aug 2020 01:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=jFClZAitQVX8dfdHAPcgu5CfSDI2b00fr26Sug/Z3ks=;
        b=ZCVckxSlNV45k98X+fjvdwZ/Jf38Gemp0pTnbwyT5WpTguzdcdx4tCXrvfzcluKDt/8nNohXXDCpCrJFaMxIo6zoBoPPeGbQeq1JhkZYRAUR+MTfgqpXeusK2Ua/zr65o4fYHk3x+FXIt1gwv3y6+gr+AVnOk4Vk2K4RqRWtQkc=;
Received: by smtp50.i.mail.ru with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1k2SeE-0002HH-6y; Mon, 03 Aug 2020 08:04:30 +0300
From:   Maxim Kochetkov <fido_max@inbox.ru>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kochetkov <fido_max@inbox.ru>, linux-iio@vger.kernel.org,
        bigunclemax@gmail.com
Subject: [PATCH v4] iio: adc: ti-ads1015: fix conversion when CONFIG_PM is not set
Date:   Mon,  3 Aug 2020 08:04:05 +0300
Message-Id: <20200803050405.6008-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp50.i.mail.ru; auth=pass smtp.auth=fido_max@inbox.ru smtp.mailfrom=fido_max@inbox.ru
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9F6142ABD4516DDC5A2D982546C3CE171B029ED5D454F1AED182A05F5380850406CDB04496B28DDBDC56D621051061BB9045CF3475978C02B2AF3AA84D1BC82F4
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE77EA152918BB9CDE0EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063704C003DD579243BB8638F802B75D45FF5571747095F342E8C7A0BC55FA0FE5FC4F646EA12E97C399509445AF06E0B0EC53B61925EDBDC505389733CBF5DBD5E913377AFFFEAFD269A417C69337E82CC2CC7F00164DA146DAFE8445B8C89999725571747095F342E8C26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE7820CF4CC0E318EFB9FA2833FD35BB23DF004C906525384309383FD4D963104D47B076A6E789B0E975F5C1EE8F4F765FC544D829C8904DC0E3AA81AA40904B5D9CF19DD082D7633A0446828A5085A663B3AA81AA40904B5D98AA50765F7900637337D68F6C54F44F3D81D268191BDAD3D18080C068C56568E156CCFE7AF13BCA413377AFFFEAFD26923F8577A6DFFEA7C53BCA8182662C30C93EC92FD9297F6715571747095F342E857739F23D657EF2BD5E8D9A59859A8B6B1CFA6D474D4A6A4089D37D7C0E48F6C5571747095F342E857739F23D657EF2B6825BDBE14D8E7028C9DFF55498CEFB0BD9CCCA9EDD067B1EDA766A37F9254B7
X-C8649E89: 5EBC1E3F9DBD6DA5A28F9D70ED05EA5D186ABD224CAA768138D56274015788E99D7014CA8465526A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojS4EufNoo6iev+VaXmKSwag==
X-Mailru-Sender: 11C2EC085EDE56FA9C10FA2967F5AB24FFE3706629A605FD5A834DD1BA7C6635CC5E4764E02DF62AEE9242D420CFEBFD3DDE9B364B0DF2891A624F84B2C74EDA4239CF2AF0A6D4F80DA7A0AF5A3A8387
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
Fixes: ecc24e72f437 ("iio: adc: Add TI ADS1015 ADC driver support")
Tested-by: Maxim Kiselev <bigunclemax@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
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

