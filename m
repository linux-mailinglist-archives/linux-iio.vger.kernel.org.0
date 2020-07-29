Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51415231BC9
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jul 2020 11:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgG2JGh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jul 2020 05:06:37 -0400
Received: from smtp37.i.mail.ru ([94.100.177.97]:37460 "EHLO smtp37.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbgG2JGh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 29 Jul 2020 05:06:37 -0400
X-Greylist: delayed 2394 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jul 2020 05:06:36 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=OPJtLwCmhtJ528DKzN4X52a5Q4Ihxk/N1hg3rTpfoNs=;
        b=kpveDm1UfGLUE1pbDUwZnYajfNJS1MSjFYbPdOvg0qyif1+d4bc77EcSxYUg22F4/oRtsyauOh8rFFE1HXD5d9k23MceUDVCEyKUv37uFnPHG9Fmg5xtLmBIrRQF37pc8qqJ99ixotGtrZ5WfH611eaCaICmDZ6dxvLnvNRaCPs=;
Received: by smtp37.i.mail.ru with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1k0i2j-00028M-Nb; Wed, 29 Jul 2020 12:06:34 +0300
From:   Maxim Kochetkov <fido_max@inbox.ru>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kochetkov <fido_max@inbox.ru>, linux-iio@vger.kernel.org,
        bigunclemax@gmail.com
Subject: [PATCH v2] iio: adc: ti-ads1015: fix conversion when CONFIG_PM is not set
Date:   Wed, 29 Jul 2020 12:06:31 +0300
Message-Id: <20200729090631.12910-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp37.i.mail.ru; auth=pass smtp.auth=fido_max@inbox.ru smtp.mailfrom=fido_max@inbox.ru
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD90521F83352E4771D205F14C480ABB2DE8B757DB528ECD9C0182A05F53808504052A7AB3244D4C4E5490E84F56466B953CEFFFDFF211582A819AE0F8E2F86AFC5
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE72791110C931D1596EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637CE3A619BB4CB99268638F802B75D45FF5571747095F342E8C7A0BC55FA0FE5FCB27AF241B871ACA1BF09D87A68ACA97D590BA99DEC7CB8A4389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C0A29E2F051442AF778941B15DA834481FCF19DD082D7633A0E7DDDDC251EA7DABA471835C12D1D977725E5C173C3A84C3CF36E64A7E3F8E58117882F4460429728AD0CFFFB425014E09623437467D3AE276E601842F6C81A19E625A9149C048EE38D4DC57D478E68828765F5520A300B2D8FC6C240DEA76429449624AB7ADAF37B2D370F7B14D4BC40A6AB1C7CE11FEE32F20CBB68F4D2F81AD7EC71F1DB88427C4224003CC8364767A15B7713DBEF166A7F4EDE966BC389F9E8FC8737B5C224934D130362CF5B368089D37D7C0E48F6CCF19DD082D7633A0E7DDDDC251EA7DABAAAE862A0553A39223F8577A6DFFEA7CFA80D66F452D417A43847C11F186F3C5E7DDDDC251EA7DABCC89B49CDF41148FA8EF81845B15A4842623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-C8649E89: 0D8A0E5B7B869BF969F97121D6CF451F79087BB20FBAFB24DBBBBDF0E8B7EE88A60B852709C163EC
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbl0bm2lVv3LZNB6e7aV3dg==
X-Mailru-Sender: 11C2EC085EDE56FA9C10FA2967F5AB2433253BCA9CACB27673793E9A2AFED4AA676C286318BA6720EE9242D420CFEBFD3DDE9B364B0DF2891A624F84B2C74EDA4239CF2AF0A6D4F80DA7A0AF5A3A8387
X-Mras: Ok
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

To stop conversion ads1015_set_power_state function call unimplemented
function __pm_runtime_suspend from pm_runtime_put_autosuspend
if CONFIG_PM is not set.
In case of CONFIG_PM is not set:

static inline int __pm_runtime_suspend(struct device *dev, int rpmflags)
{
	return -ENOSYS;
}

so ads1015_read_raw failed at:
		ret = ads1015_set_power_state(data, false);
		if (ret < 0)
			goto release_direct;

If CONFIG_PM is disabled, there is no need to start/stop conversion.
Fix it by adding return 0 function variant if CONFIG_PM is not set.

Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
Tested-by: Maxim Kiselev <bigunclemax@gmail.com>
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

