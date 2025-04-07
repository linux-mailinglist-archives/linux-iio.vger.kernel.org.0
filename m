Return-Path: <linux-iio+bounces-17739-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8463AA7D8A6
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 10:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9DF118938D5
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 08:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BEF229B1E;
	Mon,  7 Apr 2025 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="USC9vDAd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9B422A81A
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744016017; cv=none; b=TYYH2W+ba63z13erH3XWt/7Nm2kUHIHfDqv/ZUYklbVWTJ7KvU7vvtDgZhQxGynoWh/rhSV4liWpqDI5RR3QZQ3GlE+7J5JXB2L1lLk5fBuFVg9v8qrLNrcbeWnG+oEAj+/3NFcFaaMK3Vs+5q2vwkLpK4jKoMLzifLGA7noojw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744016017; c=relaxed/simple;
	bh=6MNPW5rrCGsNlWsIK2Wq8JZEQeMCM5nkbAYK09UhOio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZwqibMb4TkuTiGWzuLEBL9nV1QeoLB3VI2/CvJPbNGtw2Lf7+OmLZuU6ENZ+1LZTQreBUSi2rnPOd6wrOTWju1IBc4U+BcBqgPHeyLJOOwA7Owfcmh/A/4VZe59wmOdz/m+AeadWq/oImQ3RzZCRvWBAcwmtrCuzNGhEWjLMA4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=USC9vDAd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf257158fso27596815e9.2
        for <linux-iio@vger.kernel.org>; Mon, 07 Apr 2025 01:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744016012; x=1744620812; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojvE6ZCl6dLbOE6EYPUsM9oqTlJu3LxPEQc1vnCPuHU=;
        b=USC9vDAdFLPYKnE9W5UU6HB1tv8qs/jmUUBhbUx9q2A180CdSbDeR5O5xqi4m2rE5p
         kNLveN7bw370a0r9edT8dfudNjzJ+S77dZyfozEoXmWrfG+a+5SCO/4sH/EhgfAIumx5
         Vajry7AcWz6CA1U6TG7JJ73CxyStfYZil4cDCDydXscZqE37MYieFbckEC5EOroOShTX
         qbRNN/e/VNFEZ5Uv8aCXW/NNVZXe+adMFbpxGKBegmSFGXW8JtYqnl+EAgG8RkERu+us
         rBy7Kc9hhqJpaCcT8rWyaoUtE1Sch7AVkzG0KA5YbLNYwZLILxBP9aTGlv1evqTe+O0n
         r3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744016012; x=1744620812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojvE6ZCl6dLbOE6EYPUsM9oqTlJu3LxPEQc1vnCPuHU=;
        b=m4nnIKze/poehjJjDntocY0wdIW2Kb599kak0Q4C2TbVtsT46W5VLdozegy/Xgb9+H
         S9ABOcBnq/xFBix4K1cCb2HOwPq3wXsZXpTliO0W0mGORHw0WV+tMUAvb6n14ema6hoi
         VY4W+GPWyfvncDLvMY0S5O1qpOP49UCfx0bvG65finRfjkrIpt6FbARyorbvIpiaJkp5
         4jMETWnj2lmL71mOAhwG/IJUwrKV9a74kgw0DIUuMKtoOxU235FMYY+b9ZgS4Kca+GTY
         fcSQqyvCwQFJtgdK89BsznaUKAWkL31gj3l5+WEtsTnEWCkG9HC8n+/4TbuvWOoWnP4B
         ynWQ==
X-Gm-Message-State: AOJu0YygsuNJX949Fb0VHEVFlNwYJ5zP7RFOs1csT8fu8Fys/ihVUYl6
	TcItUcFbpZyQhJpGaLxC12YgvouCftnltJHJB2y53gaYNe5NSSlhENE0IPRNNCu80Ov5EzWE9BX
	p
X-Gm-Gg: ASbGncttrbVNq3+qpekwCvo+QKblgT13N6wQOM1b8neIDaGjGdckAhlfcePouO8LkPS
	oriDomKpZXaggiKPlqtxfU0g5/RCeu8kOlRi07EMIcRILDvEMFD9c+ec7qRmt4xbB/Uu3sTMgTM
	5xkt+KLyevOY8s8Tgs/N1UkrBC4yJy9i+kCfTDTQ++C9ouICADT1s16hMR9isiqh7bovjtpt2G5
	UHs2wg+l5EhpHMP7chxxd7/dLKqAmHeVEJub4W2SSiDE5M0ppIRf1rQm4Cj4Yz2PtJx7MURYVjL
	wjNg6Oy38EeuUz4TGyzZUdQ7bZScJaEfzaZf6ssQtaDdBFE/oDzyztmlcK08rvUVgDnsTL6j43x
	TxjAgxlo9VMiex+r0nALL3A==
X-Google-Smtp-Source: AGHT+IHXnI5obqfnDBfnmntpuGohXNyfCrhIkcIEEy62VoAPWUc/7IHAHiJ1xPm8CUemUjAtsBJ8cQ==
X-Received: by 2002:a05:600c:3505:b0:43d:cc9:b0a3 with SMTP id 5b1f17b1804b1-43ecf9fed8fmr75791135e9.22.1744016012605;
        Mon, 07 Apr 2025 01:53:32 -0700 (PDT)
Received: from [192.168.0.2] (host-87-15-70-119.retail.telecomitalia.it. [87.15.70.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec3174cf0sm126966995e9.0.2025.04.07.01.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:53:32 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 07 Apr 2025 10:52:07 +0200
Subject: [PATCH v3 5/5] iio: dac: ad3552r-hs: add support for internal ramp
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-wip-bl-ad3552r-fixes-v3-5-61874065b60f@baylibre.com>
References: <20250407-wip-bl-ad3552r-fixes-v3-0-61874065b60f@baylibre.com>
In-Reply-To: <20250407-wip-bl-ad3552r-fixes-v3-0-61874065b60f@baylibre.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5557;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=JNHqVEoeHIkqaYfOFdlgyU6mu8jM8HeInE2c4jX+SP0=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYkj/PMnGQvrUyjKLz1++Gqy3e3rJ/0HAk5/qXVHBlRsfK
 ZvZy9YxdJSyMIhxMciKKbLUJUaYhN4OlVJewDgbZg4rE8gQBi5OAZjIJkaG/0WyC4q1npWcXHmu
 Qz+65sSZn9Hsh281cxW8ZsvgOvdSrY7hf8o806VJV7UnZy34E27i9t2m01TizRtGu52Fcy1KP1t
 M5gEA
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

The ad3552r can be feeded from the HDL controller by an internally
generated 16bit ramp, useful for debug pourposes. Add debugfs a file
to enable or disable it.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r-hs.c | 124 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 118 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 37397e188f225a8099745ec03f7c604da76960b1..3dcbda23c732f5f5e655bde31c5dab4960554bfc 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/iio/backend.h>
@@ -54,8 +55,13 @@ struct ad3552r_hs_state {
 	struct ad3552r_hs_platform_data *data;
 	/* INTERFACE_CONFIG_D register cache, in DDR we cannot read values. */
 	u32 config_d;
+	/* Protects backend I/O operations from concurrent accesses. */
+	struct mutex lock;
 };
 
+static const char dbgfs_src_iio_buffer[] = "iio-buffer";
+static const char dbgfs_src_backend_ramp_gen[] = "backend-ramp-generator";
+
 static int ad3552r_hs_reg_read(struct ad3552r_hs_state *st, u32 reg, u32 *val,
 			       size_t xfer_size)
 {
@@ -65,6 +71,18 @@ static int ad3552r_hs_reg_read(struct ad3552r_hs_state *st, u32 reg, u32 *val,
 	return st->data->bus_reg_read(st->back, reg, val, xfer_size);
 }
 
+static int ad3552r_hs_set_data_source(struct ad3552r_hs_state *st,
+				      enum iio_backend_data_source type)
+{
+	int ret;
+
+	ret = iio_backend_data_source_set(st->back, 0, type);
+	if (ret)
+		return ret;
+
+	return iio_backend_data_source_set(st->back, 1, type);
+}
+
 static int ad3552r_hs_update_reg_bits(struct ad3552r_hs_state *st, u32 reg,
 				      u32 mask, u32 val, size_t xfer_size)
 {
@@ -483,6 +501,76 @@ static int ad3552r_hs_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 	return st->data->bus_reg_write(st->back, reg, writeval, 1);
 }
 
+static ssize_t ad3552r_hs_show_data_source(struct file *f, char __user *userbuf,
+					   size_t count, loff_t *ppos)
+{
+	struct ad3552r_hs_state *st = file_inode(f)->i_private;
+	enum iio_backend_data_source type;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = iio_backend_data_source_get(st->back, 0, &type);
+	if (ret)
+		return ret;
+
+	switch (type) {
+	case IIO_BACKEND_INTERNAL_RAMP_16BIT:
+		return simple_read_from_buffer(userbuf, count, ppos,
+			dbgfs_src_backend_ramp_gen,
+			strlen(dbgfs_src_backend_ramp_gen));
+	case IIO_BACKEND_EXTERNAL:
+		return simple_read_from_buffer(userbuf, count, ppos,
+			dbgfs_src_iio_buffer, strlen(dbgfs_src_iio_buffer));
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t ad3552r_hs_write_data_source(struct file *f,
+					    const char __user *userbuf,
+					    size_t count, loff_t *ppos)
+{
+	struct ad3552r_hs_state *st = file_inode(f)->i_private;
+	char buf[64];
+	int ret, len;
+
+	guard(mutex)(&st->lock);
+
+	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
+				     count);
+	if (ret < 0)
+		return ret;
+
+	len = strlen(dbgfs_src_iio_buffer);
+	if (count == len && !strncmp(buf, dbgfs_src_iio_buffer, len)) {
+		ret = ad3552r_hs_set_data_source(st, IIO_BACKEND_EXTERNAL);
+		if (ret)
+			return ret;
+		goto exit_ok;
+	}
+
+	len = strlen(dbgfs_src_backend_ramp_gen);
+	if (count == len && !strncmp(buf, dbgfs_src_backend_ramp_gen, len)) {
+		ret = ad3552r_hs_set_data_source(st,
+			IIO_BACKEND_INTERNAL_RAMP_16BIT);
+		if (ret)
+			return ret;
+		goto exit_ok;
+	}
+
+	return -EINVAL;
+
+exit_ok:
+	return count;
+}
+
+static const struct file_operations ad3552r_hs_data_source_fops = {
+	.owner = THIS_MODULE,
+	.write = ad3552r_hs_write_data_source,
+	.read = ad3552r_hs_show_data_source,
+};
+
 static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 {
 	u16 id;
@@ -550,11 +638,7 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 	if (ret)
 		return ret;
 
-	ret = iio_backend_data_source_set(st->back, 0, IIO_BACKEND_EXTERNAL);
-	if (ret)
-		return ret;
-
-	ret = iio_backend_data_source_set(st->back, 1, IIO_BACKEND_EXTERNAL);
+	ret = ad3552r_hs_set_data_source(st, IIO_BACKEND_EXTERNAL);
 	if (ret)
 		return ret;
 
@@ -661,6 +745,24 @@ static const struct iio_info ad3552r_hs_info = {
 	.debugfs_reg_access = &ad3552r_hs_reg_access,
 };
 
+static void ad3552r_hs_debugfs_init(struct iio_dev *indio_dev)
+{
+	struct ad3552r_hs_state *st = iio_priv(indio_dev);
+	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
+
+	if (!IS_ENABLED(CONFIG_DEBUG_FS))
+		return;
+
+	d = iio_get_debugfs_dentry(indio_dev);
+	if (!d) {
+		dev_warn(st->dev, "can't set debugfs in driver dir\n");
+		return;
+	}
+
+	debugfs_create_file("data_source", 0600, d, st,
+			    &ad3552r_hs_data_source_fops);
+}
+
 static int ad3552r_hs_probe(struct platform_device *pdev)
 {
 	struct ad3552r_hs_state *st;
@@ -705,7 +807,17 @@ static int ad3552r_hs_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&pdev->dev, indio_dev);
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_mutex_init(&pdev->dev, &st->lock);
+	if (ret)
+		return ret;
+
+	ad3552r_hs_debugfs_init(indio_dev);
+
+	return ret;
 }
 
 static const struct of_device_id ad3552r_hs_of_id[] = {

-- 
2.49.0


