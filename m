Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2AF7204B2E
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jun 2020 09:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbgFWHbI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Jun 2020 03:31:08 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:54402 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731264AbgFWHaz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Jun 2020 03:30:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592897455; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=ZXsN90wErB1JosUSuFzG2gI172jnlE+QOOZyjuivH10=; b=dFD3hKdODQnQ0eILs5mtsS2ml1ZvMayuZY4xVRxpGUpZrsTZGhkVa/DE+YOqU5O93VB9EP9I
 nw/l411/BDeydv4RsUKYUaa6NZTB/JSvHiRfdqyWaULEyV0gbwLz3urbBeqJ1wnAiHPxwFeO
 7soBkkH5RhjrYy7DT5a1Qe/fdec=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5ef1afabfe1db4db89b9ef77 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jun 2020 07:30:51
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AD80DC4339C; Tue, 23 Jun 2020 07:30:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jprakash-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5F42DC433C8;
        Tue, 23 Jun 2020 07:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F42DC433C8
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
Subject: [PATCH V7 3/7] iio: adc: Add info property under adc_data
Date:   Tue, 23 Jun 2020 12:59:55 +0530
Message-Id: <1592897399-24089-4-git-send-email-jprakash@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592897399-24089-1-git-send-email-jprakash@codeaurora.org>
References: <1592897399-24089-1-git-send-email-jprakash@codeaurora.org>
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

