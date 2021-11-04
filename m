Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B227E444F7A
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 08:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhKDHPt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 03:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhKDHPt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Nov 2021 03:15:49 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93769C061714
        for <linux-iio@vger.kernel.org>; Thu,  4 Nov 2021 00:13:11 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id t38so4932164pfg.12
        for <linux-iio@vger.kernel.org>; Thu, 04 Nov 2021 00:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MRIZN7LzNiXGHwJW2GA0fKbWMghY8+I0SxkUXqOZuk4=;
        b=bi5EoXc9JL7GF45w7SIqGRNmQ4nwd0x9LJNJ0qiI/jUQ/cnUf42XENbAeuuencTkoJ
         aJ5C3t56H0elSKuM3ERDBj/9/6YNQQFgeOY2nUKt4mR7NvnGsfkKYs9Xwgvy/9Dghbjy
         Mryj2FCg0pudue2hZm2JfmO6A1GDDVhSSaUaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MRIZN7LzNiXGHwJW2GA0fKbWMghY8+I0SxkUXqOZuk4=;
        b=di99lIxMeDZ1pn4L+F4IiMLxqoecOd/Tpouo69rCgIAVJO/UHmqlJAH/YsjvvFeNi+
         lbujeeMc7sPhnlE+OyWfpUONnWuPt2o1ROTSwBlz4X6i/BAOlNoJYBhXYHYi7nc4EL9D
         cFABioe1J6JmELKQghv7iG/0Jm4T2vA3VxHuxjXRWdq6SSeYt4N8bGdil+J4MtsdjsWI
         Y2lo+gtrGKZoheQEl1VeeMyaTk4seXso5eBCaNRMpobe2KNtsmfGwH2BNJucbQEpEVal
         nDtPcn5hsknQDoBOOQ0IYnXMsY5Ef0Hfpt+550obNIRAgiust7rKbMxjMjY1GSc14FlC
         PXNw==
X-Gm-Message-State: AOAM531FnkB5xhoIs5Tp+Rnevbamr9IcoCER2e4BIbfC0jF139QUToDq
        5jHoSzBiFzE9SN89pt2FotD1IQ==
X-Google-Smtp-Source: ABdhPJydFOfq2ANV46I6CYIU/FhoyUeOkFevUyolRHi7Y2I/9xQfosEUieTKw0W2QQ9wwPfLtQm4BA==
X-Received: by 2002:aa7:990e:0:b0:480:ff8f:d655 with SMTP id z14-20020aa7990e000000b00480ff8fd655mr29992018pff.18.1636009991146;
        Thu, 04 Nov 2021 00:13:11 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:b129:c9aa:6634:6c4c])
        by smtp.gmail.com with UTF8SMTPSA id u21sm1022985pfi.80.2021.11.04.00.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 00:13:10 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 1/5] iio: sx9310: Add frequency in read_avail
Date:   Thu,  4 Nov 2021 00:12:59 -0700
Message-Id: <20211104071303.3604314-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
In-Reply-To: <20211104071303.3604314-1-gwendal@chromium.org>
References: <20211104071303.3604314-1-gwendal@chromium.org>
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
New in v2.

 drivers/iio/proximity/sx9310.c | 33 +++++++--------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index a3fdb59b06d22..1647268b6471f 100644
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
2.33.1.1089.g2158813163f-goog

