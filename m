Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721831E67EA
	for <lists+linux-iio@lfdr.de>; Thu, 28 May 2020 18:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405284AbgE1Q4B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 May 2020 12:56:01 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:10299 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405280AbgE1Qz7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 May 2020 12:55:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590684959; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=FLLyoTMv2qd+bBSzR6F92Az2OsSPwUQMzo3EODrQepg=; b=Q38lBNgrTH4hf8o+bnsacWAnpAyUoGN3kuqudhGJ2ai4U5ia5kzR9/TuPyvjZPHo9idu8ITv
 OIyPbaI4A1tAFW4wLvUX/ZKxPv4UwzG8/FMHRghMuLP4QkDboML9tBOHs6mO4C2FQBIquA82
 kFVc6dIJ1DGGsx/CW1UtLl72iHM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5ecfed1f50867324816101b8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 May 2020 16:55:59
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2BC72C433B2; Thu, 28 May 2020 16:55:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jprakash-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E6A05C433CA;
        Thu, 28 May 2020 16:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E6A05C433CA
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
Subject: [PATCH V6 5/7] iio: adc: Update return value checks
Date:   Thu, 28 May 2020 22:24:27 +0530
Message-Id: <1590684869-15400-6-git-send-email-jprakash@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590684869-15400-1-git-send-email-jprakash@codeaurora.org>
References: <1590684869-15400-1-git-send-email-jprakash@codeaurora.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Clean up some return value checks to make code more compact.

Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
---
 drivers/iio/adc/qcom-spmi-adc5.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index dcc7599..3022313 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -301,7 +301,7 @@ static int adc5_configure(struct adc5_chip *adc,
 
 	/* Read registers 0x42 through 0x46 */
 	ret = adc5_read(adc, ADC5_USR_DIG_PARAM, buf, sizeof(buf));
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	/* Digital param selection */
@@ -388,7 +388,7 @@ static int adc5_do_conversion(struct adc5_chip *adc,
 
 	if (adc->poll_eoc) {
 		ret = adc5_poll_wait_eoc(adc);
-		if (ret < 0) {
+		if (ret) {
 			pr_err("EOC bit not set\n");
 			goto unlock;
 		}
@@ -398,7 +398,7 @@ static int adc5_do_conversion(struct adc5_chip *adc,
 		if (!ret) {
 			pr_debug("Did not get completion timeout.\n");
 			ret = adc5_poll_wait_eoc(adc);
-			if (ret < 0) {
+			if (ret) {
 				pr_err("EOC bit not set\n");
 				goto unlock;
 			}
@@ -516,8 +516,6 @@ static int adc5_read_raw(struct iio_dev *indio_dev,
 	default:
 		return -EINVAL;
 	}
-
-	return 0;
 }
 
 static int adc7_read_raw(struct iio_dev *indio_dev,
@@ -761,7 +759,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
 
 		ret = adc5_read(adc, ADC5_USR_REVISION1, dig_version,
 							sizeof(dig_version));
-		if (ret < 0) {
+		if (ret) {
 			dev_err(dev, "Invalid dig version read %d\n", ret);
 			return ret;
 		}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

