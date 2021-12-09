Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC5E46DFE2
	for <lists+linux-iio@lfdr.de>; Thu,  9 Dec 2021 01:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241744AbhLIBBs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Dec 2021 20:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241701AbhLIBBp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Dec 2021 20:01:45 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C76EC0617A2
        for <linux-iio@vger.kernel.org>; Wed,  8 Dec 2021 16:58:12 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so5051513pjb.1
        for <linux-iio@vger.kernel.org>; Wed, 08 Dec 2021 16:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZMpI3drEu9kDtTftXpvJKjP/xj3idmFlGVDMbNRXkso=;
        b=QGmTmjfZKSn8RY+tC22gsbSFycQ5nRxi0CbXQ2ypCfbUbpMGf/FdXt41gZdNYZr5Z4
         G1Vb+b6WM/MnGDkNbiwtRpYKJQylnceci8T0RHJcbtd2TyTt/nvrJoWkWjSibuXSGNxr
         ckRzA8rjBYVRPIb3vZy9TwWSsXJ1mSo4ziULU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZMpI3drEu9kDtTftXpvJKjP/xj3idmFlGVDMbNRXkso=;
        b=pTKPUo9XDLjW97NNZQ+PncAa3hugYoSHoDcI0PTXWjQztymR3z8GS+GZkchWUFoQra
         J0i5hZydxossbAYxzteyCy1iyiPRd9y/TTEDEPLyrIGC18l6+F7Py3LF1G7rD9w3T2Pv
         a00pJv1ikBpfceQ1L6jYQb/gwNlTXR/DbNTy0Ft53F7fMTwPgoNYLgn6PYlBW35N3nMp
         U3TLzTYirIA/tttS8EOef7nnQY95nzUoDHLdJBFH0d1SqnkML6Tzm7NfZRnWkyMbdf28
         N0a5fxoXCYt2eWn/lU/tqsLGIU5djs6JUbcS9+RfVlZY9JGbgZDG743w1emIKipXbs8k
         pqJQ==
X-Gm-Message-State: AOAM533D9vOU6xKUKuwOJ/CabD26+a9u22LEiOmMqlnKURrnEX52+JaO
        owqAGeEROkNoePpHcCfSljbA75YFfEavIQ==
X-Google-Smtp-Source: ABdhPJz/LWufFNrt3SLPFrVvgz8JcsXiXS5FQpb/Am8rEQ47otQbAiloxF3tx0aEyC1LgtYZBMwrbw==
X-Received: by 2002:a17:90b:615:: with SMTP id gb21mr11785661pjb.10.1639011491803;
        Wed, 08 Dec 2021 16:58:11 -0800 (PST)
Received: from localhost ([2620:15c:202:201:16e0:43f4:4e33:993b])
        by smtp.gmail.com with UTF8SMTPSA id h20sm3392840pgh.13.2021.12.08.16.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 16:58:11 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     robh+dt@kernel.org, jic23@kernel.org, lars@metafoo.de,
        swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v6 1/5] iio: sx9310: Add frequency in read_avail
Date:   Wed,  8 Dec 2021 16:58:02 -0800
Message-Id: <20211209005806.3575399-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
In-Reply-To: <20211209005806.3575399-1-gwendal@chromium.org>
References: <20211209005806.3575399-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Instead of using IIO_DEV_ATTR_SAMP_FREQ_AVAIL sysfs attribute,
add a _FREQ case in read_avail() to display the frequency table.
No change to |sampling_frequency_available| was observed.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
No changes in v6
No changes in v5
No changes in v4
No changes in v3
New in v2.

 drivers/iio/proximity/sx9310.c | 33 +++++++--------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index a3fdb59b06d220..1647268b6471f1 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -196,6 +196,8 @@ static const struct iio_event_spec sx9310_events[] = {
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
 		.info_mask_separate_available =				 \
 			BIT(IIO_CHAN_INFO_HARDWAREGAIN),		 \
+		.info_mask_shared_by_all_available =			 \
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),			 \
 		.indexed = 1,						 \
 		.channel = idx,						 \
 		.extend_name = name,					 \
@@ -251,22 +253,6 @@ static const unsigned int sx9310_scan_period_table[] = {
 	400, 600, 800, 1000, 2000, 3000, 4000, 5000,
 };
 
-static ssize_t sx9310_show_samp_freq_avail(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
-{
-	size_t len = 0;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(sx9310_samp_freq_table); i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%d ",
-				 sx9310_samp_freq_table[i].val,
-				 sx9310_samp_freq_table[i].val2);
-	buf[len - 1] = '\n';
-	return len;
-}
-static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(sx9310_show_samp_freq_avail);
-
 static const struct regmap_range sx9310_writable_reg_ranges[] = {
 	regmap_reg_range(SX9310_REG_IRQ_MSK, SX9310_REG_IRQ_FUNC),
 	regmap_reg_range(SX9310_REG_PROX_CTRL0, SX9310_REG_PROX_CTRL19),
@@ -562,6 +548,11 @@ static int sx9310_read_avail(struct iio_dev *indio_dev,
 		*length = ARRAY_SIZE(sx9310_gain_vals);
 		*vals = sx9310_gain_vals;
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = ARRAY_SIZE(sx9310_samp_freq_table) * 2;
+		*vals = (int *)sx9310_samp_freq_table;
+		return IIO_AVAIL_LIST;
 	}
 
 	return -EINVAL;
@@ -1031,17 +1022,7 @@ static int sx9310_write_event_config(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static struct attribute *sx9310_attributes[] = {
-	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group sx9310_attribute_group = {
-	.attrs = sx9310_attributes,
-};
-
 static const struct iio_info sx9310_info = {
-	.attrs = &sx9310_attribute_group,
 	.read_raw = sx9310_read_raw,
 	.read_avail = sx9310_read_avail,
 	.read_event_value = sx9310_read_event_val,
-- 
2.34.1.400.ga245620fadb-goog

