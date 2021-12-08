Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F11A46C97D
	for <lists+linux-iio@lfdr.de>; Wed,  8 Dec 2021 01:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbhLHAqt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Dec 2021 19:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhLHAqs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Dec 2021 19:46:48 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B17C061574
        for <linux-iio@vger.kernel.org>; Tue,  7 Dec 2021 16:43:17 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id np3so725896pjb.4
        for <linux-iio@vger.kernel.org>; Tue, 07 Dec 2021 16:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cpMDCy7QGlf1/MqLqQ0n7nWFi58YJzR/zpxW1WKFgNk=;
        b=dxDplFrav1jFAo1Tt2s7wV1+DMrhiMvpTGEDhg7By+uE/gcrja+wBGmYaQ79sMUdLe
         S6OztIufEOmXmE4yZF5bcLvKvlU0/Zsz1l3EJBv2zWh5TfHfkBNGgHGGkljDbzJQRnFL
         i+6zkJmA26+AmFymKv7RowrcDA1qFQSnkIE7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cpMDCy7QGlf1/MqLqQ0n7nWFi58YJzR/zpxW1WKFgNk=;
        b=KCPYLD/U3dmWKgeTDQPOYRBgzOYexD44W4P1riDA6erehd/l91IU3sUCRwFZvYjovs
         LZCjf3IhBnZqrVaquQJh3Scvqq26r7AHsPSvqsyUIjisMPmNOCan0YkzWP5I0Rj+3IAr
         FYh8FySbH8TzfGbTZva8nXtTwujt7DwWCEEt0QZhLgMcEWUd2uEIFHHt82vpa9KkdKW9
         da2iKIEI5jRTs9DhfLvnZhXVC11qUsVTja2fW4cRMRP7YLE6fwy4ObcLJ4FhLx6ClNS7
         Zo4m+NfoaxNmXJQ0A/sXQ/VAKIpcYfgymJROlMRZjSf94qDpC8wSiWFMv9RGR6zb00pe
         xp9w==
X-Gm-Message-State: AOAM530sNOs17lw6dMwqaO3sEUgpAABvo+hTCZDDkX2kP3LV/YmZA6IH
        jc6v51c9ZR6lJLcb2uB0i+VCRg==
X-Google-Smtp-Source: ABdhPJx2V8hhDXKHZR+zqiAJQwCMxPQ0yvAltKmiA0SI8fqOHPUGS3bBZQSpVhe9YzjNZs0rlZkzaQ==
X-Received: by 2002:a17:90a:c506:: with SMTP id k6mr3157434pjt.74.1638924196383;
        Tue, 07 Dec 2021 16:43:16 -0800 (PST)
Received: from localhost ([2620:15c:202:201:e4:362a:40f4:7f9f])
        by smtp.gmail.com with UTF8SMTPSA id w1sm992181pfg.11.2021.12.07.16.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 16:43:16 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 1/5] iio: sx9310: Add frequency in read_avail
Date:   Tue,  7 Dec 2021 16:43:07 -0800
Message-Id: <20211208004311.3098571-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
In-Reply-To: <20211208004311.3098571-1-gwendal@chromium.org>
References: <20211208004311.3098571-1-gwendal@chromium.org>
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

