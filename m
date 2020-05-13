Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0B31D0C01
	for <lists+linux-iio@lfdr.de>; Wed, 13 May 2020 11:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732449AbgEMJYC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 May 2020 05:24:02 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:60474 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732266AbgEMJYB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 May 2020 05:24:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589361841; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=TFrgDbbKZBm6NPQL5mWJzkI/vXhkytHX3yOOZfCUOjo=; b=gxqhuSRd41xZ6NaWKVQgwGT9u/f+c/U9X+UiyKN7HnpS8PZJz1k2PFhAJ64gLEJpYRfGKlKe
 ds821Hy+0oD2Q3E3Ko+5ahkKgrJZt+SYi2THufTzBrPKjLtF/BjbjrYijW3ThnPiocXUxSDE
 dHIWX7zLSwBW9WPwQF9GelQ2F/0=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebbbca4.7f1f1bb1ec70-smtp-out-n04;
 Wed, 13 May 2020 09:23:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5DF85C4478F; Wed, 13 May 2020 09:23:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jprakash-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 217B0C433BA;
        Wed, 13 May 2020 09:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 217B0C433BA
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
Subject: [PATCH V4 4/5] iio: adc: Update error checks and debug prints
Date:   Wed, 13 May 2020 14:52:15 +0530
Message-Id: <1589361736-816-5-git-send-email-jprakash@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589361736-816-1-git-send-email-jprakash@codeaurora.org>
References: <1589361736-816-1-git-send-email-jprakash@codeaurora.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Change pr_err/pr_debug statements to dev_err/dev_dbg for
increased clarity. Also clean up some return value checks.

Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
---
 drivers/iio/adc/qcom-spmi-adc5.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index 6d6b611..974073f 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -249,11 +249,11 @@ static int adc5_read_voltage_data(struct adc5_chip *adc, u16 *data)
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
@@ -304,7 +304,7 @@ static int adc5_configure(struct adc5_chip *adc,
 
 	/* Read registers 0x42 through 0x46 */
 	ret = adc5_read(adc, ADC5_USR_DIG_PARAM, buf, sizeof(buf));
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	/* Digital param selection */
@@ -344,7 +344,7 @@ static int adc7_configure(struct adc5_chip *adc,
 		return ret;
 
 	ret = adc5_read(adc, ADC5_USR_DIG_PARAM, buf, sizeof(buf));
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	/* Digital param selection */
@@ -385,24 +385,24 @@ static int adc5_do_conversion(struct adc5_chip *adc,
 
 	ret = adc5_configure(adc, prop);
 	if (ret) {
-		pr_err("ADC configure failed with %d\n", ret);
+		dev_err(adc->dev, "ADC configure failed with %d\n", ret);
 		goto unlock;
 	}
 
 	if (adc->poll_eoc) {
 		ret = adc5_poll_wait_eoc(adc);
 		if (ret < 0) {
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
 			if (ret < 0) {
-				pr_err("EOC bit not set\n");
+				dev_err(adc->dev, "EOC bit not set\n");
 				goto unlock;
 			}
 		}
@@ -435,7 +435,7 @@ static int adc7_do_conversion(struct adc5_chip *adc,
 	wait_for_completion_timeout(&adc->complete, ADC7_CONV_TIMEOUT);
 
 	ret = adc5_read(adc, ADC5_USR_STATUS1, &status, 1);
-	if (ret < 0)
+	if (ret)
 		goto unlock;
 
 	if (status & ADC5_USR_STATUS1_CONV_FAULT) {
@@ -481,8 +481,8 @@ static int adc7_of_xlate(struct iio_dev *indio_dev,
 	int i, v_channel;
 
 	for (i = 0; i < adc->nchannels; i++) {
-		v_channel = (adc->chan_props[i].sid << ADC_CHANNEL_OFFSET |
-			adc->chan_props[i].channel);
+		v_channel = (adc->chan_props[i].sid << ADC_CHANNEL_OFFSET) |
+			adc->chan_props[i].channel;
 		if (v_channel == iiospec->args[0])
 			return i;
 	}
@@ -728,7 +728,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
 	channel_name = of_get_property(node,
 				"label", NULL) ? : node->name;
 	if (!channel_name) {
-		pr_err("Invalid channel name\n");
+		dev_err(dev, "Invalid channel name\n");
 		return -EINVAL;
 	}
 	prop->datasheet_name = channel_name;
@@ -766,12 +766,12 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
 
 		ret = adc5_read(adc, ADC5_USR_REVISION1, dig_version,
 							sizeof(dig_version));
-		if (ret < 0) {
+		if (ret) {
 			dev_err(dev, "Invalid dig version read %d\n", ret);
 			return ret;
 		}
 
-		pr_debug("dig_ver:minor:%d, major:%d\n", dig_version[0],
+		dev_dbg(dev, "dig_ver:minor:%d, major:%d\n", dig_version[0],
 						dig_version[1]);
 		/* Digital controller >= 5.3 have hw_settle_2 option */
 		if ((dig_version[0] >= ADC5_HW_SETTLE_DIFF_MINOR &&
@@ -975,7 +975,7 @@ static int adc5_probe(struct platform_device *pdev)
 
 	ret = adc5_get_dt_data(adc, node);
 	if (ret) {
-		pr_err("adc get dt data failed\n");
+		dev_err(dev, "adc get dt data failed\n");
 		return ret;
 	}
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
