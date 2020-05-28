Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4561E67F6
	for <lists+linux-iio@lfdr.de>; Thu, 28 May 2020 18:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405318AbgE1Q4a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 May 2020 12:56:30 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:45973 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405314AbgE1Q4Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 May 2020 12:56:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590684985; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=AIpbCmMCznCXVtiVrbRFoTwG+u7mFH1W+SY+3jGOkts=; b=mmaoqYcKh90oGJ+pK/soOFBBt7n8EmrXHIbf2h8uaxBNa3iqedmEcm/dUZx1VNchIQec6XIZ
 szLbqYOX/Ess9jwKIJPJL8BG58CFPVyiriQiov7dZRlavmXxUyAFbYzP+pIwWcs3TrJEhdgY
 RFpaHfUcQ81pPmh18LDYmpVVIiE=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5ecfed382dd9e15ae3105ba1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 May 2020 16:56:24
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CA669C433A0; Thu, 28 May 2020 16:56:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jprakash-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E6B3C433AD;
        Thu, 28 May 2020 16:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E6B3C433AD
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
Subject: [PATCH V6 7/7] iio: adc: Add a common read function for PMIC5 and PMIC7
Date:   Thu, 28 May 2020 22:24:29 +0530
Message-Id: <1590684869-15400-8-git-send-email-jprakash@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590684869-15400-1-git-send-email-jprakash@codeaurora.org>
References: <1590684869-15400-1-git-send-email-jprakash@codeaurora.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a common function used for read_raw callback for both PMIC5
and PMIC7 ADCs.

Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
---
 drivers/iio/adc/qcom-spmi-adc5.c | 53 +++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index 0f9af66..fe49741 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -449,6 +449,13 @@ static int adc7_do_conversion(struct adc5_chip *adc,
 	return ret;
 }
 
+struct adc_do_conversion {
+	int (*adc_do_conversion)(struct adc5_chip *adc,
+			struct adc5_channel_prop *prop,
+			struct iio_chan_spec const *chan,
+			u16 *data_volt, u16 *data_cur);
+};
+
 static irqreturn_t adc5_isr(int irq, void *dev_id)
 {
 	struct adc5_chip *adc = dev_id;
@@ -487,9 +494,9 @@ static int adc7_of_xlate(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-static int adc5_read_raw(struct iio_dev *indio_dev,
+static int adc_read_raw_common(struct iio_dev *indio_dev,
 			 struct iio_chan_spec const *chan, int *val, int *val2,
-			 long mask)
+			 long mask, struct adc_do_conversion do_conv)
 {
 	struct adc5_chip *adc = iio_priv(indio_dev);
 	struct adc5_channel_prop *prop;
@@ -500,8 +507,8 @@ static int adc5_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
-		ret = adc5_do_conversion(adc, prop, chan,
-				&adc_code_volt, &adc_code_cur);
+		ret = do_conv.adc_do_conversion(adc, prop, chan,
+					&adc_code_volt, &adc_code_cur);
 		if (ret)
 			return ret;
 
@@ -518,36 +525,26 @@ static int adc5_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
-static int adc7_read_raw(struct iio_dev *indio_dev,
+static int adc5_read_raw(struct iio_dev *indio_dev,
 			 struct iio_chan_spec const *chan, int *val, int *val2,
 			 long mask)
 {
-	struct adc5_chip *adc = iio_priv(indio_dev);
-	struct adc5_channel_prop *prop;
-	u16 adc_code_volt, adc_code_cur;
-	int ret;
-
-	prop = &adc->chan_props[chan->address];
-
-	switch (mask) {
-	case IIO_CHAN_INFO_PROCESSED:
-		ret = adc7_do_conversion(adc, prop, chan,
-					&adc_code_volt, &adc_code_cur);
-		if (ret)
-			return ret;
+	struct adc_do_conversion do_conv;
 
-		ret = qcom_adc5_hw_scale(prop->scale_fn_type,
-			&adc5_prescale_ratios[prop->prescale],
-			adc->data,
-			adc_code_volt, val);
+	do_conv.adc_do_conversion = adc5_do_conversion;
+	return adc_read_raw_common(indio_dev, chan, val, val2,
+				mask, do_conv);
+}
 
-		if (ret)
-			return ret;
+static int adc7_read_raw(struct iio_dev *indio_dev,
+			 struct iio_chan_spec const *chan, int *val, int *val2,
+			 long mask)
+{
+	struct adc_do_conversion do_conv;
 
-		return IIO_VAL_INT;
-	default:
-		return -EINVAL;
-	}
+	do_conv.adc_do_conversion = adc7_do_conversion;
+	return adc_read_raw_common(indio_dev, chan, val, val2,
+				mask, do_conv);
 }
 
 static const struct iio_info adc5_info = {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

