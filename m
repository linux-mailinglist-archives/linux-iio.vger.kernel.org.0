Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BB71E67E5
	for <lists+linux-iio@lfdr.de>; Thu, 28 May 2020 18:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405274AbgE1Qzp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 May 2020 12:55:45 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:35479 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405266AbgE1Qzm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 May 2020 12:55:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590684941; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=ZXsN90wErB1JosUSuFzG2gI172jnlE+QOOZyjuivH10=; b=FkUwNe73qBnAmCNPh33J7Cviba2Mjmth5VAEkzSIADDNjj07oRsndxaODGh+9M8Noh4Eqai2
 FSZt+q1DpJQunnOtI+78x72LehAKFCZJXHF/Q/58c2SvdDPDcF8b094li3G/Wpa8ldsBG7iw
 jrjv7hlhibFvzKqas/5y7c6aiMw=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5ecfed0a3ac6f4f603eed307 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 May 2020 16:55:38
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D51CAC433A1; Thu, 28 May 2020 16:55:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jprakash-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 023DAC43387;
        Thu, 28 May 2020 16:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 023DAC43387
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
Subject: [PATCH V6 3/7] iio: adc: Add info property under adc_data
Date:   Thu, 28 May 2020 22:24:25 +0530
Message-Id: <1590684869-15400-4-git-send-email-jprakash@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590684869-15400-1-git-send-email-jprakash@codeaurora.org>
References: <1590684869-15400-1-git-send-email-jprakash@codeaurora.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add info property under adc_data to support adding ADC variants
which may use different iio_info than the one defined for PMIC5.

Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
---
 drivers/iio/adc/qcom-spmi-adc5.c   | 4 +++-
 drivers/iio/adc/qcom-vadc-common.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index 21fdcde..0fa1d37 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -629,6 +629,7 @@ static const struct adc5_data adc5_data_pmic = {
 	.full_scale_code_volt = 0x70e4,
 	.full_scale_code_cur = 0x2710,
 	.adc_chans = adc5_chans_pmic,
+	.info = &adc5_info,
 	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
 				{250, 420, 840},
 	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
@@ -643,6 +644,7 @@ static const struct adc5_data adc5_data_pmic_rev2 = {
 	.full_scale_code_volt = 0x4000,
 	.full_scale_code_cur = 0x1800,
 	.adc_chans = adc5_chans_rev2,
+	.info = &adc5_info,
 	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
 				{256, 512, 1024},
 	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
@@ -777,7 +779,7 @@ static int adc5_probe(struct platform_device *pdev)
 	indio_dev->dev.of_node = node;
 	indio_dev->name = pdev->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->info = &adc5_info;
+	indio_dev->info = adc->data->info;
 	indio_dev->channels = adc->iio_chans;
 	indio_dev->num_channels = adc->nchannels;
 
diff --git a/drivers/iio/adc/qcom-vadc-common.h b/drivers/iio/adc/qcom-vadc-common.h
index e074902a..6a7553f 100644
--- a/drivers/iio/adc/qcom-vadc-common.h
+++ b/drivers/iio/adc/qcom-vadc-common.h
@@ -136,6 +136,7 @@ struct adc5_data {
 	const u32	full_scale_code_volt;
 	const u32	full_scale_code_cur;
 	const struct adc5_channels *adc_chans;
+	const struct iio_info *info;
 	unsigned int	*decimation;
 	unsigned int	*hw_settle_1;
 	unsigned int	*hw_settle_2;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

