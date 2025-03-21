Return-Path: <linux-iio+bounces-17189-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1215BA6C437
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 21:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75EA0464A4A
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 20:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D06233723;
	Fri, 21 Mar 2025 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LaHXZn6J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9232309AD
	for <linux-iio@vger.kernel.org>; Fri, 21 Mar 2025 20:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589015; cv=none; b=HQshiUQ8MqB7RBeTeuN2kkxQ+/sXaWE4oob5mTH5w4qtcuL9lb7c+QAj30JqUvC8D7L9UM39WRbfLuPItvSW+am1kiZRHGr9fVMNV30RAPTKSmkYZpYFegovXYUWjrc19tPxjjsB6P43mCtG67J3ToPf7HCUYK775H7EUDGs4Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589015; c=relaxed/simple;
	bh=lzaSJ/be6is8Rty2tbrCLJKH6+jdZRvilPwu+v8J4Cs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VktI/ZclFs3G5hihmwQW8duvZEUXjG2PJzZ2diyD7T7cxdUDacBIMJcxIi1BzxAnr06kDV6/574vQQGb1P2OvnLsHmXgW44o6DS2cgPgdo/12WRqEzetrm4lsB9s74EizQISlihnbLAKAmgSGFgWcYc7pXZVkyf0C4tph5oMoz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LaHXZn6J; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so21867555e9.3
        for <linux-iio@vger.kernel.org>; Fri, 21 Mar 2025 13:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742589010; x=1743193810; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKB6yQ/p4p5H9UdGeKJqY+C71MSKxypTKujViSujDac=;
        b=LaHXZn6JNPGfznqTGqNxxz0/9SWD3RNBiXmugdQJKD4Jt7+TUb/E0jb0uyzm1qpL8u
         dR1utsSXX05dTQ8k23aws3sXkphrbwrbYZGI9CungIA3LyhHmyIffho5rhlDCmt/Xvpl
         jCnuhrQ24TOyW7KfoL8ee8jaYds0Lcjdx9wPj60TlzvzaSOWooxuog6wgScKZ9QIACHM
         I9ogDKrrOJqrdUJQYS6TknGKU2XTFKTw5dbHR4Pp+NEN0Akh4y2UukC/8l/JURVx+nJt
         mvUhbxvXWPM6fCFyX+CUtGbXPdi8QcsHIrNWWSr3ofTg8o/6FmQc/+AmLhpRzhYV/pRi
         Poyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742589010; x=1743193810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKB6yQ/p4p5H9UdGeKJqY+C71MSKxypTKujViSujDac=;
        b=PL7sbAIdog4JZpizBFkzxg0TGQqQLqtyLiF0PQ4MDQORu3dY/468TPSKfa2YITjDJM
         44S9yWEAC0pIYpocVUhcNnYVGKWIY7dGQjxCfCmQp+2+GkuvqCfc1OuKbeKpYekG2SVK
         9ePGjBlU4OETPQC2hgw1aqxyOGZTc+UzCHb8jOdIhXG2Ntt26Ck2dbnvnwiVwizEtBCO
         m0F46A9rJ4oLqk4FtDbI5HXcCUobDhfV3zCFJ+nwVSiCXz/OloHo7d0FhsH3JRGpDMqI
         m8F51XbilL5gjXyTgbdVsAJw9sFaVfpQfJmMEpdXaAXo3dGVfmYQn9RvMtxEGDPdgfw4
         mVog==
X-Gm-Message-State: AOJu0Ywr4CwcLiUOo/PXZw1PmRMh5idaWrGRpJ0NVvm0C9cwU1LIKuNl
	AL+v6QJEkkMMgdMvH15YJNfPVS/nGYpQuDdTbG3VmgJFl/dQESYcW+607UptQ+M=
X-Gm-Gg: ASbGnctBYjpKvRRQQgO70IG1drfqgdJnvXo8X3xtVsq9Uc8TRF77fMk6uZROQwgn9GL
	1uwj+G6n3hfooFJEQBCBbRcR3PIny4+1SNcLwB0k1Kd8Fwu0fkVK5ya0y/CxVTklSgHpJPBa4zA
	6L6/9WeZagSDJBpv8jpoUmuu05wTB7xVXckGf+E+/hauXWbjRAD9vwVF0SAb5AFRf6isYdQEUvn
	4iVTKtAcVYlT+yZ71v8xAzN6z81j6ZgXqzoyOoVteMCzZrZcn97IDn8YmN4Aq/h/MQX/+Qoa3Gl
	IubtDEr3LGhNfQgyIhcUT7pBLk6B+u3+bFaPeK1RUaeqnvyehDMMTg7pVAmU03079yjAcivTTM8
	jAZUbMat9O/pZHg==
X-Google-Smtp-Source: AGHT+IGW0KT9uYhjfvzDuW5HrybppxMZ12fXv96hH0ZZ7RsY03Ppzqsltv2FqtvQ54zHcEEm7eOWKg==
X-Received: by 2002:a5d:588b:0:b0:399:737f:4de6 with SMTP id ffacd0b85a97d-3997f8f8c35mr4323719f8f.3.1742589009965;
        Fri, 21 Mar 2025 13:30:09 -0700 (PDT)
Received: from [127.0.1.1] (host-87-8-62-49.retail.telecomitalia.it. [87.8.62.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9955c0sm3258380f8f.3.2025.03.21.13.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:30:09 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 21 Mar 2025 21:28:51 +0100
Subject: [PATCH 4/4] iio: dac: ad3552r-hs: add support for internal ramp
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-wip-bl-ad3552r-fixes-v1-4-3c1aa249d163@baylibre.com>
References: <20250321-wip-bl-ad3552r-fixes-v1-0-3c1aa249d163@baylibre.com>
In-Reply-To: <20250321-wip-bl-ad3552r-fixes-v1-0-3c1aa249d163@baylibre.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2

From: Angelo Dureghello <adureghello@baylibre.com>

The ad3552r can be feeded from the HDL controller by an internally
generated 16bit ramp, useful for debug pourposes. Add debugfs a file
to enable or disable it.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r-hs.c | 106 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 100 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 37397e188f225a8099745ec03f7c604da76960b1..41fe78d982a68980db059b095fc27b37ea1a461b 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/iio/backend.h>
@@ -65,6 +66,18 @@ static int ad3552r_hs_reg_read(struct ad3552r_hs_state *st, u32 reg, u32 *val,
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
@@ -483,6 +496,66 @@ static int ad3552r_hs_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 	return st->data->bus_reg_write(st->back, reg, writeval, 1);
 }
 
+static ssize_t ad3552r_hs_show_data_source(struct file *f, char __user *userbuf,
+					   size_t count, loff_t *ppos)
+{
+	struct ad3552r_hs_state *st = file_inode(f)->i_private;
+	enum iio_backend_data_source type;
+	int ret;
+
+	ret = iio_backend_data_source_get(st->back, 0, &type);
+	if (ret)
+		return ret;
+
+	switch (type) {
+	case IIO_BACKEND_INTERNAL_RAMP_16BIT:
+		return simple_read_from_buffer(userbuf, count, ppos,
+					       "backend-ramp-generator", 22);
+	case IIO_BACKEND_EXTERNAL:
+		return simple_read_from_buffer(userbuf, count, ppos,
+					       "iio-buffer", 10);
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
+	int ret;
+
+	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
+				     count);
+	if (ret < 0)
+		return ret;
+
+	buf[count] = 0;
+
+	if (count == 10 && !strncmp(buf, "iio-buffer", 10)) {
+		ret = ad3552r_hs_set_data_source(st, IIO_BACKEND_EXTERNAL);
+		if (ret)
+			return ret;
+	} else if (count == 22 && !strncmp(buf, "backend-ramp-generator", 22)) {
+		ret = ad3552r_hs_set_data_source(st,
+			IIO_BACKEND_INTERNAL_RAMP_16BIT);
+		if (ret)
+			return ret;
+	} else {
+		return -EINVAL;
+	}
+
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
@@ -550,11 +623,7 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
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
 
@@ -661,6 +730,24 @@ static const struct iio_info ad3552r_hs_info = {
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
@@ -705,7 +792,14 @@ static int ad3552r_hs_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&pdev->dev, indio_dev);
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
+	if (ret)
+		return ret;
+
+	ad3552r_hs_debugfs_init(indio_dev);
+
+	return ret;
+
 }
 
 static const struct of_device_id ad3552r_hs_of_id[] = {

-- 
2.49.0


