Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D61457CCD
	for <lists+linux-iio@lfdr.de>; Sat, 20 Nov 2021 11:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237265AbhKTKSO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Nov 2021 05:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhKTKSM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Nov 2021 05:18:12 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA8CC061574
        for <linux-iio@vger.kernel.org>; Sat, 20 Nov 2021 02:15:09 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id y7so10108942plp.0
        for <linux-iio@vger.kernel.org>; Sat, 20 Nov 2021 02:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+83Z6L3lQ/9PbdGTabJgLKVipeE6voWaMfZzb9Ivt1Y=;
        b=N0ASWkkRCa1C/gR0A4K0vdHa7ofxcjZQrqQOOd0QJKmykS6NNftTgNbSIxDqZrQkC9
         DxA7YH8pygy2VfvYYGBm9Gp+A3CMoYbjC4EY+MBqDhKeDG4d6GQbKWf/KPNvkR1nfXvA
         /YINylHN+qglGE0rrH95CP3fIr/uEz1nQj/Wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+83Z6L3lQ/9PbdGTabJgLKVipeE6voWaMfZzb9Ivt1Y=;
        b=W40i8H2xJj7h7D6xfJ9mQWZIQlCh4JK/aEaIwFT2MbDUqNaSFjnRMl/DLzH6It7yR9
         o1w9IZq60g+yZNP7p6XIkPVh8H5KlSL77QnZKlhYQVxKFiio6Iy5nYvcYVCxeRluLxyZ
         7UvHsQ77Q4T+XlRBeEkcBJmHv+zASaT8iBuMsOHkswKDPaWcZefkqISTF7EY5AdakTgm
         44tZJ5/jSbxXrhMgCpB07+cMqDx2YNzPfKftYMJuN+XzcLpPznT7K4mpOg6C/3scXrr0
         YamZQTbVnnf0jcrhjqeXZNQB5/Vr+1sE/o/lFE/0hpuaefEVMLofzaQDGxa12tdtrxDY
         UBcw==
X-Gm-Message-State: AOAM532V0urtasQ++EmkjvZWyrqkr8RDkAv4CU0S6gyQFpqXkxZIxeCO
        CuMT6FQp9TdrHHynfbyGmrtH8Ocj+nGhjw==
X-Google-Smtp-Source: ABdhPJydUi8t43ddDNdaRntWv/0UXwR0CFWfaLjBzVE+zz3nT5nsH7SormEKqImUxbcFWDFaD6bv3g==
X-Received: by 2002:a17:90b:2409:: with SMTP id nr9mr8832305pjb.244.1637403308631;
        Sat, 20 Nov 2021 02:15:08 -0800 (PST)
Received: from localhost ([2620:15c:202:201:913f:8f64:e1fa:a751])
        by smtp.gmail.com with UTF8SMTPSA id f4sm2265534pfg.34.2021.11.20.02.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Nov 2021 02:15:08 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 1/5] iio: sx9310: Add frequency in read_avail
Date:   Sat, 20 Nov 2021 02:14:57 -0800
Message-Id: <20211120101501.1659549-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
In-Reply-To: <20211120101501.1659549-1-gwendal@chromium.org>
References: <20211120101501.1659549-1-gwendal@chromium.org>
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
2.34.0.rc2.393.gf8c9666880-goog

