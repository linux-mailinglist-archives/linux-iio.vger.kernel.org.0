Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3670B204B3A
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jun 2020 09:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731774AbgFWHb0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Jun 2020 03:31:26 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:48309 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731740AbgFWHbX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Jun 2020 03:31:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592897483; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=FLLyoTMv2qd+bBSzR6F92Az2OsSPwUQMzo3EODrQepg=; b=eXQIobr9KABzsMY7+RtRgIsodRWN6xnBSpTrGQzkoClnSDu8iQNt0AFzoW7NvjDxrKEi9Qon
 DyevTWopswrP5QXJXm5An0EwzGbA4HkEUnqOjvy16d/LeEuDFO8Znj598T5wOSqNIRyNtdKD
 EpjJMP0fV7f73UeixJoWoXcKWOs=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5ef1afbdad153efa34acff35 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jun 2020 07:31:09
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 33709C433C8; Tue, 23 Jun 2020 07:31:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jprakash-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B4F8C433AF;
        Tue, 23 Jun 2020 07:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B4F8C433AF
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
Subject: [PATCH V7 5/7] iio: adc: Update return value checks
Date:   Tue, 23 Jun 2020 12:59:57 +0530
Message-Id: <1592897399-24089-6-git-send-email-jprakash@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592897399-24089-1-git-send-email-jprakash@codeaurora.org>
References: <1592897399-24089-1-git-send-email-jprakash@codeaurora.org>
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

