Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7703648195E
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 05:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbhL3Emt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Dec 2021 23:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbhL3Ems (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Dec 2021 23:42:48 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC29C061574
        for <linux-iio@vger.kernel.org>; Wed, 29 Dec 2021 20:42:47 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id g11-20020a17090a7d0b00b001b2c12c7273so1051266pjl.0
        for <linux-iio@vger.kernel.org>; Wed, 29 Dec 2021 20:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sc2Cu+T+JyrHEioGqkdW+9ytQBeyZJIuznN1nZZD7Pg=;
        b=cmi7UiiZ/edFIUHRaGbh70uy9eCOiRKD8EzLvI9s2Mn7CBHjRD5yXEtzv3O8j+9z+Q
         x5lqVr/uJ7ZCYXoD5Ck2VKEV+/N3VwusjhMRs2gVkZN1UBpVSKClsHULlLWXAas3M6Ou
         qhgMsgLgN41GCwfPH68OdLy0z16JIBTeVti8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sc2Cu+T+JyrHEioGqkdW+9ytQBeyZJIuznN1nZZD7Pg=;
        b=itLjAYrJvfQIyi5igI+YNqt8luZ0piDMXHCiVZhQcrRzbmUDebtoDazjyK4oWMjMuy
         79mwcKaXcLVd5EBgpMAcrvMJ7vHQ9bXwopSWd2O4IbnyBjkYWXe/vLKQGWGYuQOxWd8k
         hsIlC4o0B/UTV/d3tti598jsdhuWV3/nWdr713Mv588MsDZMl2nGAaWFKYkkCUMyP1+I
         KIL1Hi2eH42g6Cg1sSHmE8ShYD/KiyG43wenzwccLVFcz4zSWRrmXv4npAicPHbVuvFN
         jBElUhHgDFCrbAgnfU/uOiVR885nN07Bl+A+vqm/08fo4M4rlhqF8PlPIB6FmIPCETe3
         iUJQ==
X-Gm-Message-State: AOAM5312j69RaqTPsRGCIKzdRx5ya362R+i+4YWuQEFsdUWn6DOHyuHD
        osNOjQ8oqv/IvvaqD0JczlDvnw==
X-Google-Smtp-Source: ABdhPJys1EYx1Cn8Kcv0LahTwLCz11u3Hlk9qf2W/5iVTBjckYacq5M38ieCjegoZ7WHgfH0XxrevQ==
X-Received: by 2002:a17:90b:1bc7:: with SMTP id oa7mr35764588pjb.200.1640839367471;
        Wed, 29 Dec 2021 20:42:47 -0800 (PST)
Received: from localhost ([2620:15c:202:201:f2cb:bddc:361b:5398])
        by smtp.gmail.com with UTF8SMTPSA id c18sm27175283pfl.201.2021.12.29.20.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 20:42:47 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v9 1/5] iio: sx9310: Add frequency in read_avail
Date:   Wed, 29 Dec 2021 20:42:38 -0800
Message-Id: <20211230044242.1024940-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20211230044242.1024940-1-gwendal@chromium.org>
References: <20211230044242.1024940-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Instead of using IIO_DEV_ATTR_SAMP_FREQ_AVAIL sysfs attribute,
add a _FREQ case in read_avail() to display the frequency table.
No change to |sampling_frequency_available| was observed.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
No changes in v9
No changes in v8
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
2.34.1.448.ga2b2bfdf31-goog

