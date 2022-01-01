Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490FD482877
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jan 2022 21:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiAAUiW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Jan 2022 15:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiAAUiW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Jan 2022 15:38:22 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D21C061574
        for <linux-iio@vger.kernel.org>; Sat,  1 Jan 2022 12:38:22 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id l15so7469228pls.7
        for <linux-iio@vger.kernel.org>; Sat, 01 Jan 2022 12:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XzrUfqxEPheR6rMj42pK3SnvZhc40ozUr1IA/DXbwk0=;
        b=Hc5U6FHR75e3jcu9g55BNzJ0cg6UeQBvlhImBtZjSUgOoTfzsssy2av765hhSwSK4l
         N0psjtY+6MODXhPodHTNuV6/UhDO4d49E1YHCyAg1eTu+UImdjz0kZtwTbKPHa4jxsn9
         qstiGfI1d/aHCuTS+m3PqmdMLOgja6rjrUYHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XzrUfqxEPheR6rMj42pK3SnvZhc40ozUr1IA/DXbwk0=;
        b=TckJK6a0mnHNN1NWTX1SevFrWkkdj/VHq2sbt7GTBnfF6HqucJ1S7CPJ8jMlMWROsd
         D8WypuXXnV4NC8Re7nVDVqLqRCrh7jGJt4fZ/xGs6tzj3YIHjh0/ZhqsoF5ZqDvY4QBZ
         yr4bQvSm5IhQ5hebnoVczRi5NNWY3WIb/w+lR4cFwl21Jxgub+ahjfadYt0Jr1uaVNLZ
         eXL60PRBWRYjvwDHsPbsQPcmtyCiV6qSnvkQ5sGS6LcY1I8dO2UboW9+b8c2s2ejVNqt
         vnt7cOpvK/NjT1Ir73BIgNoZBnYvTXpw1sR5q3XD4cPucWXX0JiBA6dbpicVi1MNsyZk
         TyIw==
X-Gm-Message-State: AOAM531m6s7GkcKE8jQrhVM8pJeuArJPXHg3aq5mEYG0+dTgOjLfA05G
        goe6aKl7qwfO5ihKMtEjrC7Uag==
X-Google-Smtp-Source: ABdhPJx/TdF0kDmUlKQdh6XYYe3OnBDPlyTSqhtUXlhe8qRIlvoyLAoleMs7sX5iqqFnuw1bzBualQ==
X-Received: by 2002:a17:90b:3143:: with SMTP id ip3mr48311081pjb.58.1641069501564;
        Sat, 01 Jan 2022 12:38:21 -0800 (PST)
Received: from localhost ([2620:15c:202:201:df49:1d3f:ae08:999])
        by smtp.gmail.com with UTF8SMTPSA id lb12sm33574958pjb.27.2022.01.01.12.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jan 2022 12:38:21 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v10 1/5] iio: sx9310: Add frequency in read_avail
Date:   Sat,  1 Jan 2022 12:38:13 -0800
Message-Id: <20220101203817.290512-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20220101203817.290512-1-gwendal@chromium.org>
References: <20220101203817.290512-1-gwendal@chromium.org>
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
No changes in v10
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

