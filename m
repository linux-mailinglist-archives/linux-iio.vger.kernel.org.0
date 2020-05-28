Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAB41E67F1
	for <lists+linux-iio@lfdr.de>; Thu, 28 May 2020 18:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405280AbgE1Q4T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 May 2020 12:56:19 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:35479 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405295AbgE1Q4R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 May 2020 12:56:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590684976; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=PrPh+eMP5+ZYRmG5TKB2ISg2GXa+N21InNQiBC7iQu8=; b=KKhcH5E2Uri3Ggr35Ep1LWynkdXCZQk/oI5yWoZzdNfk6/gJJOi84Iq8CosZFSEv1f87y+sa
 6boMIWgP/R8l29Pg17juZ66VviT+Zrc/1dRb9MH2EFrnESx4fEyz3C+ZTP8Yh/E0M5r4u7Ch
 gtxjE6ta0BxvpHRCLoTY6HB+EHI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ecfed302738686126e5f723 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 May 2020 16:56:16
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B59CFC433CA; Thu, 28 May 2020 16:56:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jprakash-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 52E37C43387;
        Thu, 28 May 2020 16:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52E37C43387
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jprakash@codeaurora.org
From:   Jishnu Prakash <jprakash@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, linus.walleij@linaro.org,
        Jonathan.Cameron@huawei.com, andy.shevchenko@gmail.com,
        amit.kucheria@verdurent.com, smohanad@codeaurora.org,
        kgunda@codeaurora.org, aghayal@codeaurora.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     linux-arm-msm-owner@vger.kernel.org,
        Jishnu Prakash <jprakash@codeaurora.org>
Subject: [PATCH V6 6/7] iio: adc: Update debug prints
Date:   Thu, 28 May 2020 22:24:28 +0530
Message-Id: <1590684869-15400-7-git-send-email-jprakash@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590684869-15400-1-git-send-email-jprakash@codeaurora.org>
References: <1590684869-15400-1-git-send-email-jprakash@codeaurora.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Change pr_err/pr_debug statements to dev_err/dev_dbg for
increased clarity.

Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/qcom-spmi-adc5.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index 3022313..0f9af66 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -246,11 +246,11 @@ static int adc5_read_voltage_data(struct adc5_chip *adc, u16 *data)
 	*data = (rslt_msb << 8) | rslt_lsb;
 
 	if (*data == ADC5_USR_DATA_CHECK) {
-		pr_err("Invalid data:0x%x\n", *data);
+		dev_err(adc->dev, "Invalid data:0x%x\n", *data);
 		return -EINVAL;
 	}
 
-	pr_debug("voltage raw code:0x%x\n", *data);
+	dev_dbg(adc->dev, "voltage raw code:0x%x\n", *data);
 
 	return 0;
 }
@@ -382,24 +382,24 @@ static int adc5_do_conversion(struct adc5_chip *adc,
 
 	ret = adc5_configure(adc, prop);
 	if (ret) {
-		pr_err("ADC configure failed with %d\n", ret);
+		dev_err(adc->dev, "ADC configure failed with %d\n", ret);
 		goto unlock;
 	}
 
 	if (adc->poll_eoc) {
 		ret = adc5_poll_wait_eoc(adc);
 		if (ret) {
-			pr_err("EOC bit not set\n");
+			dev_err(adc->dev, "EOC bit not set\n");
 			goto unlock;
 		}
 	} else {
 		ret = wait_for_completion_timeout(&adc->complete,
 							ADC5_CONV_TIMEOUT);
 		if (!ret) {
-			pr_debug("Did not get completion timeout.\n");
+			dev_dbg(adc->dev, "Did not get completion timeout.\n");
 			ret = adc5_poll_wait_eoc(adc);
 			if (ret) {
-				pr_err("EOC bit not set\n");
+				dev_err(adc->dev, "EOC bit not set\n");
 				goto unlock;
 			}
 		}
@@ -721,7 +721,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
 	channel_name = of_get_property(node,
 				"label", NULL) ? : node->name;
 	if (!channel_name) {
-		pr_err("Invalid channel name\n");
+		dev_err(dev, "Invalid channel name\n");
 		return -EINVAL;
 	}
 	prop->datasheet_name = channel_name;
@@ -764,7 +764,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
 			return ret;
 		}
 
-		pr_debug("dig_ver:minor:%d, major:%d\n", dig_version[0],
+		dev_dbg(dev, "dig_ver:minor:%d, major:%d\n", dig_version[0],
 						dig_version[1]);
 		/* Digital controller >= 5.3 have hw_settle_2 option */
 		if ((dig_version[0] >= ADC5_HW_SETTLE_DIFF_MINOR &&
@@ -966,7 +966,7 @@ static int adc5_probe(struct platform_device *pdev)
 
 	ret = adc5_get_dt_data(adc, node);
 	if (ret) {
-		pr_err("adc get dt data failed\n");
+		dev_err(dev, "adc get dt data failed\n");
 		return ret;
 	}
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

