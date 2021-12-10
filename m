Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25395470A4C
	for <lists+linux-iio@lfdr.de>; Fri, 10 Dec 2021 20:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245611AbhLJT1O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Dec 2021 14:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343603AbhLJT1N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Dec 2021 14:27:13 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D25C061A72
        for <linux-iio@vger.kernel.org>; Fri, 10 Dec 2021 11:23:35 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id q16so8836981pgq.10
        for <linux-iio@vger.kernel.org>; Fri, 10 Dec 2021 11:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iostcGC7Y0QmkCAVkynGeS5zJyc2ah3P+Zmgo4Ba76E=;
        b=YKpOosudp8610Rb4fvvafNj9DjeRjvpqF+IcG1BGrzZ3jNljtDpOMyDR4A9fiVLKtF
         3x0o2WaX7akjsI5tcpaABFW//cZh8kRDV2SWUVNDiXDsHZJqomtEE3rLKxD6FBIO8Vlt
         a2Tobvuo85WjCb8VL4TefytryVDc+aUliH8fE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iostcGC7Y0QmkCAVkynGeS5zJyc2ah3P+Zmgo4Ba76E=;
        b=GEBTamO4i/SQOWqquouHDg8uVY/FhJ8mow/CR3CiKWZ+q/zDCOyg/r/nVJciJjeY7M
         Qf0oEzWheFAjxGx5DjuP1GwPNeyBfj735WECFZhRTlLhP2B+pBJv5H6M8doC5xLD3vrU
         4Lv0TAh0UVEgX2XXI/IjBoAotgT1BILL4ZuxB5Q5rDgHFa1uxW6aGQSiIKUd3CeKpFVm
         QPqne4vc/g7plAQXHAzXNpg4JD11zL8TPygo4eZBkvfm1aZtftKzPp4UZT0PFqWWNbel
         OrYkS1+ewnddULfL96ta4iPg2wGLbZRZ5ZO3pZgA93I8RtBPgRwKG+LHzTnAlRt6fT/4
         v0PQ==
X-Gm-Message-State: AOAM531C87uy0dxlH+ShSTIQdf2JOFoxwMwk0wspURmr2ul+AaX5dp5p
        W0rGFuh9Nm1+2U/52dxPcRgIYA==
X-Google-Smtp-Source: ABdhPJxIyzchDD7Y+8V11SvR1Mjo1ZR5sCWiy0eeT/oKDJk534b5bYGoN4gMrXfdlZElKZggIMaQxw==
X-Received: by 2002:a63:7d1c:: with SMTP id y28mr40684204pgc.452.1639164215473;
        Fri, 10 Dec 2021 11:23:35 -0800 (PST)
Received: from localhost ([2620:15c:202:201:16de:af23:a52f:63b])
        by smtp.gmail.com with UTF8SMTPSA id mv22sm3409578pjb.36.2021.12.10.11.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 11:23:35 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     robh+dt@kernel.org, jic23@kernel.org, lars@metafoo.de,
        swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 1/5] iio: sx9310: Add frequency in read_avail
Date:   Fri, 10 Dec 2021 11:23:24 -0800
Message-Id: <20211210192328.2844060-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
In-Reply-To: <20211210192328.2844060-1-gwendal@chromium.org>
References: <20211210192328.2844060-1-gwendal@chromium.org>
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
No changes in v7
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
2.34.1.173.g76aa8bc2d0-goog

