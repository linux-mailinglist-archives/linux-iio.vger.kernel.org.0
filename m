Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF7C4797BE
	for <lists+linux-iio@lfdr.de>; Sat, 18 Dec 2021 01:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhLRASC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Dec 2021 19:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhLRASB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Dec 2021 19:18:01 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F997C061574
        for <linux-iio@vger.kernel.org>; Fri, 17 Dec 2021 16:18:01 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id z6so3184595plk.6
        for <linux-iio@vger.kernel.org>; Fri, 17 Dec 2021 16:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n1Ah5Zztvnex632L5hNGE1D5LGM2AwbYrtX8qX3YoWQ=;
        b=ByjVD6D6YtD4wmIf7zMo8eCvhvrUnt++ya9lR98oPsQvCxwvQbNQA9gP2TNihBpyW5
         /AU8k4gjZZPK5JW/pKMkVX7jfk3LvxGmuG7xOpYds0pF8U4KpLo+3UTTycT6OLi007fY
         zX/B6/PzK+d2SqXU5t/8+ERGqIqJm8iBZDlJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n1Ah5Zztvnex632L5hNGE1D5LGM2AwbYrtX8qX3YoWQ=;
        b=bIjRTUJb1d1fgAzfSjJeiC14buNOpayyvegLorBZ+hYI6jZrX58uauHEx+t9FZNdB/
         n5uq8SQH5jlfcBaqktCNe+kmgxle6EnKAkK+79fy5RvCWO32bghPtN3bleCT4XjNpb3F
         wz6BjfMkZSjUBc0D7epLhMxmYknVI0PaM1yY20qCf8PrxhnmvNrIh6JBkIDdlvgbh3It
         m6J9t2WsbN8JzogkMLs9GtCsXpoPs5uHw8oh1luWXyz3549F8sJE32nlBLOKomf+Ju0I
         5Hqs7fw/kXcn1DfzAcsTOXnlVygD4DOl56Ocjnod0Pqg8dwjYZ90PA/qSn3mLPxnTKXm
         CbBw==
X-Gm-Message-State: AOAM530U7l6sRA6C2kbQpUqthZMqMChWLWMTOcDy2mD9MfWD13UcJR+A
        xGzHBceckkMvzuVAT+wgPFP56seqWhIvPw==
X-Google-Smtp-Source: ABdhPJwFSNrDgUV24BPnOu2w3zJKr975wODd2qq90bJPhutSFRYk7lfACMoXSwtBFNjxoAWyfUC7ww==
X-Received: by 2002:a17:903:4041:b0:148:b052:45ba with SMTP id n1-20020a170903404100b00148b05245bamr5394960pla.130.1639786680956;
        Fri, 17 Dec 2021 16:18:00 -0800 (PST)
Received: from localhost ([2620:15c:202:201:2bc8:cefc:f407:829])
        by smtp.gmail.com with UTF8SMTPSA id x6sm9350209pga.14.2021.12.17.16.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 16:18:00 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v8 1/5] iio: sx9310: Add frequency in read_avail
Date:   Fri, 17 Dec 2021 16:17:51 -0800
Message-Id: <20211218001755.3096807-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
In-Reply-To: <20211218001755.3096807-1-gwendal@chromium.org>
References: <20211218001755.3096807-1-gwendal@chromium.org>
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
2.34.1.173.g76aa8bc2d0-goog

