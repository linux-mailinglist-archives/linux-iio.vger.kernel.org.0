Return-Path: <linux-iio+bounces-5799-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 725648FBF6D
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 00:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2ED284963
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 22:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17FC14D70B;
	Tue,  4 Jun 2024 22:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9kdfIDE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F74114EC49;
	Tue,  4 Jun 2024 22:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717541901; cv=none; b=D2FSWp14CXEh1adQ1plVut7XBL/x/4OJbeYDC6+GHYOYHubMvJG6hViHz3Lg+rGbOZsg840T/1nNycK0wnvCoBYzWpfmdQtGou48sf+1OPoke6bwS6APB34yhp+PilaZeGK+d0yXHGlDDKx+woy+GLmfTEjrdgU9GTX7Mgk5MW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717541901; c=relaxed/simple;
	bh=3PbBRRIGCGwbDPONnU11cfvO9liugEEisBeeZgXscYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOl7iUZ6Kxj0FOHjqdlEiHyhG7XEXg4ZVjxSaeR3xCm5H7CfjJ8KZSSph8wPxYvEnVYCD/zf7JJxRTNctWlczUpTZOenGDp7YoKk+YSqxX4GLpB/C1erTfr0khtrfOgs5OCzO7R8Loq0WMWAOkCUYkxI0YVIYkiDrJv26zu0b4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9kdfIDE; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7025b253f64so2648927b3a.3;
        Tue, 04 Jun 2024 15:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717541899; x=1718146699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hj1V63M+srwA2IM19IN3/t8Yj3UqyDWtuebSx4Tuw4w=;
        b=Q9kdfIDE2yEeYnjJU4SziCZIclEfwArQDvmZwopapQpkciWkYeUeV/Jz446w1Sw7vq
         lTjHLlQLrFQ6HZ/g2/rG6+bpQtrR+DJw/mnMjNBJ+63m7/KKOIf9pxmhX/Yn660+Dp3v
         LpD8bloYiu5pDV7HLqGsQcy4B8raDiDJpd8hUD0K7tBRKgLeTOPsUurcTQrp2QhAihIK
         z1oCjCLZAr4sSAelo5zGMOn/r+MUG9qNEgSG/iWPRIQ63NvfKfywKWpsfLPGFEMt4r22
         af8IaYVaGSwuJrmsxZU7syX3NCkU9+FBSw4PENBHqOs/2WDl4cRmubIF9VOHNUExaddz
         CWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717541899; x=1718146699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hj1V63M+srwA2IM19IN3/t8Yj3UqyDWtuebSx4Tuw4w=;
        b=iG7XB466/AUAju+U84x/bJPy0/3vxEtWhxTw/gJWK8i5A5Q8Gwsv6DTVA4IuvxV4ay
         kQeEg+Kyh6hBP8i5EoDAwTogJwZNb7vpvAE99ofhGfo2BEOcZmNw2G5C4bvnUp+7EJWI
         WcVGloPO6Puhpeqd+HOg/jC1Vabe4JBSTgoe5JrsgqMd+Q3aq+V4xP9opBpXKENtZNdI
         +JdF/z4TdOf6y/nnO4wk5W/iXvVYSIDEhhBnhogopw+oHZLy3XlM2fkvZ7jq38Z1bdTX
         HsjKucjHGbYoWl4LgB3y0oxetlXgVweZlWNHiW1jwtZPWGzMV+VpRoabgIBbYqwp0E2x
         0I/w==
X-Forwarded-Encrypted: i=1; AJvYcCWK4TRqi8rcYzzjVPeMP1f+WFMAhfcpmyDmLZfiHfmcXmndWf+2GyF1uSvUgVG0Tplf1ZEnvGhM8bGAtDczJOX+vVuQFFh2qFSZD9SKVyRckjxfSEYdJnsRpRSC4wu+jKDlerufxcZGfV3t/ec0ped9RY5rOZHk8pNlfQgv1+h1EFtwMA==
X-Gm-Message-State: AOJu0YyyEx9gQCQILFr1FTJzAEaaW0mNtdaOzwRkS8oLI5wXmiDaSuZ8
	J+gdbBH1H182Yqd7OMuWU9Bf1If8C+yjlzh+dBBmbtR/NBJz+rso
X-Google-Smtp-Source: AGHT+IF0bDONOHmRx6dYgUqrIamqsqVPVgFk743oOc63+wUMbNu1a3ZdBkz90lTn3CjzDNjHY3rjyQ==
X-Received: by 2002:a05:6a20:244d:b0:1b2:53c5:9e71 with SMTP id adf61e73a8af0-1b2b6fa3436mr1288430637.25.1717541899510;
        Tue, 04 Jun 2024 15:58:19 -0700 (PDT)
Received: from localhost.localdomain ([189.101.166.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7025a955dd1sm5312125b3a.64.2024.06.04.15.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 15:58:19 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
To: jic23@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lars@metafoo.de,
	christophe.jaillet@wanadoo.fr,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] iio: chemical: ens160: add power management support
Date: Tue,  4 Jun 2024 19:57:29 -0300
Message-ID: <20240604225747.7212-6-gustavograzs@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604225747.7212-1-gustavograzs@gmail.com>
References: <20240604225747.7212-1-gustavograzs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ENS160 supports a deep sleep mode for minimal power consumption.
Use it to add PM sleep capability to the driver.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
 drivers/iio/chemical/ens160.h      |  3 +++
 drivers/iio/chemical/ens160_core.c | 23 +++++++++++++++++++++++
 drivers/iio/chemical/ens160_i2c.c  |  1 +
 drivers/iio/chemical/ens160_spi.c  |  1 +
 4 files changed, 28 insertions(+)

diff --git a/drivers/iio/chemical/ens160.h b/drivers/iio/chemical/ens160.h
index e6cc0987a..f9f0575ce 100644
--- a/drivers/iio/chemical/ens160.h
+++ b/drivers/iio/chemical/ens160.h
@@ -4,4 +4,7 @@
 
 int devm_ens160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 			   const char *name);
+
+extern const struct dev_pm_ops ens160_pm_ops;
+
 #endif
diff --git a/drivers/iio/chemical/ens160_core.c b/drivers/iio/chemical/ens160_core.c
index 3da3b1095..c1aa3b498 100644
--- a/drivers/iio/chemical/ens160_core.c
+++ b/drivers/iio/chemical/ens160_core.c
@@ -220,6 +220,29 @@ static const struct iio_info ens160_info = {
 	.read_raw = ens160_read_raw,
 };
 
+static int ens160_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ens160_data *data = iio_priv(indio_dev);
+
+	return ens160_set_mode(data, ENS160_REG_MODE_DEEP_SLEEP);
+}
+
+static int ens160_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ens160_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = ens160_set_mode(data, ENS160_REG_MODE_IDLE);
+	if (ret)
+		return ret;
+
+	return ens160_set_mode(data, ENS160_REG_MODE_STANDARD);
+}
+EXPORT_NS_SIMPLE_DEV_PM_OPS(ens160_pm_ops, ens160_suspend, ens160_resume,
+			    IIO_ENS160);
+
 static irqreturn_t ens160_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
diff --git a/drivers/iio/chemical/ens160_i2c.c b/drivers/iio/chemical/ens160_i2c.c
index f3fb45b75..57a189a4c 100644
--- a/drivers/iio/chemical/ens160_i2c.c
+++ b/drivers/iio/chemical/ens160_i2c.c
@@ -49,6 +49,7 @@ static struct i2c_driver ens160_i2c_driver = {
 	.driver = {
 		.name		= "ens160",
 		.of_match_table	= ens160_of_i2c_match,
+		.pm		= pm_sleep_ptr(&ens160_pm_ops),
 	},
 	.probe = ens160_i2c_probe,
 	.id_table = ens160_i2c_id,
diff --git a/drivers/iio/chemical/ens160_spi.c b/drivers/iio/chemical/ens160_spi.c
index 90e1e8386..10e4f5fd0 100644
--- a/drivers/iio/chemical/ens160_spi.c
+++ b/drivers/iio/chemical/ens160_spi.c
@@ -48,6 +48,7 @@ static struct spi_driver ens160_spi_driver = {
 	.driver = {
 		.name	= "ens160",
 		.of_match_table = ens160_spi_of_match,
+		.pm = pm_sleep_ptr(&ens160_pm_ops),
 	},
 	.probe		= ens160_spi_probe,
 	.id_table	= ens160_spi_id,
-- 
2.45.1


