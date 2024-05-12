Return-Path: <linux-iio+bounces-4996-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 016788C3877
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 23:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 821C6B2128F
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 21:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B4D54BFE;
	Sun, 12 May 2024 21:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQrvGLxN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784ED5490A;
	Sun, 12 May 2024 21:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715547917; cv=none; b=EGogKup43fTd/Mq2K3DUKssOG70VhuUfEmmdavMQ3TlmdDnB8B4AyaFfpIaQPxw/IcYJXYSnmGyBOFbyHtv92tA22bQtxMF578iee1ADyYJD4YEM1SJsELgIrR0iNUdEY2TgqtVS2swBJMJunqnVAtlfm7lg2PvEB7VWiESpP7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715547917; c=relaxed/simple;
	bh=jGDKpFrAGPmHk5HNbWtLFUr1+LFe+uS9ERRt3fYKUFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1kePdMhGU0y+yqPWx+GekYnmG/5rlXUVHH9NYDAGsiqLt8hwItbqE1nq1SAIu69tdoo6JN3w8KKWR20lg6y3RmimPj4qgFbzWQa40ZdYeKTuD7QYOF/czkiuMo8mRNzpkCq4xbauhx5BueNhmfHgE9ALE1kojIoe8YE+8/RIHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQrvGLxN; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f457853950so3148453b3a.0;
        Sun, 12 May 2024 14:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715547916; x=1716152716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+iXakQgu6wyqTFDM8HVPo/Aj4ZtlGQ3P2zA7/rBiHQ=;
        b=PQrvGLxNSKMXcGkuQEoPStnnUGe4DA4YrzIbI25o3wxE/jqvq/j1dagBO3JzItyNQE
         adQM3gHjUb393a+SvTkdZmQUsKD4WyfX9N86vFqV1W0ZgAjLZ8YEycc56Ot1j1Slli74
         vjmmbrHvlBPpsbQJGgmLUms3i0Fmpx0Zj35M4mgmzMPijmCd0jFgmm3MdDG9nPyrB0el
         rO96Vnr8HLOjllQMiSLBhXomNe5OEt7gHzNoSTckERKFwVo+UQOQDyWb+XwTK6JVz6LE
         JieyjFmoxB0XqjRckZ6IwlelVmzUEt4utdZ1/BQWsLmUfb7qZIvEWoeHCuvCNWydRLWF
         CgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715547916; x=1716152716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+iXakQgu6wyqTFDM8HVPo/Aj4ZtlGQ3P2zA7/rBiHQ=;
        b=m38cbq66Oc/7PItvoAIFXXtKDjIyqhtzEsjKQwgx7rjOqfCgHaQNJP3WoK0VyquOxf
         VJ7FhHIJqkNY1JllzBbxyzThSkShU2RL50fGjXySxOmhkO0ujwzW2MOgcJ7eKFou874M
         xGTIx+/iMaKEUywA8ciT4r8T5HntkfLf1lrhPjlEep5LnRc0g+hz61xatxV1v7w7lOtM
         oAl5gVaummK6VaPoUVvPSKtEMzKrzslgcqfcIjA6/JmtxfcY6xiES2kaV1ujpmpFmSeo
         EvwyGVWQWUZGunuPVaJw6rK3QuugG5L1GymzKI9cmAEN13IhlqK0507lPXt57brJaNkE
         BCZA==
X-Forwarded-Encrypted: i=1; AJvYcCWGyR1oFX61CpIrUpiWtct8OikJQoqFF7kyO+YG+pseHYbe4MWqAg1YyigpANmA/s8EMcZHVSr+MiQtWOIeMTGaN555Ds+HPX3vXbKodXCJ/e1StYMF6aqkYMoP8x/mbVS3jPISv9n2+x5iONhtQDdMUed1DoL8Mt2TAZ66uAZ76L1K5g==
X-Gm-Message-State: AOJu0YzQeC1SUdFvN3n7ROyPIrn1RqKLbxw3+y4hOcMQ0xW07pex8fT2
	V79pcXuTd+IijVPn2VCvHgn8J0O4X85jYAGmWV7AWRlM3EhPAcD6
X-Google-Smtp-Source: AGHT+IFgQVVzlV78x6qDXZYn0OtgvWd2RTnrkpSDeGsOjn6fqQrS4+UQIhgn6hjYK5El5YntEK/P4g==
X-Received: by 2002:a05:6a20:5607:b0:1af:b4f4:e73 with SMTP id adf61e73a8af0-1afd14746d4mr16111691637.21.1715547915679;
        Sun, 12 May 2024 14:05:15 -0700 (PDT)
Received: from localhost.localdomain ([189.101.162.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340a447391sm6534865a12.3.2024.05.12.14.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 14:05:15 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
To: jic23@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lars@metafoo.de,
	christophe.jaillet@wanadoo.fr,
	gerald.loacker@wolfvision.net,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] iio: chemical: ens160: add power management support
Date: Sun, 12 May 2024 18:04:41 -0300
Message-ID: <20240512210444.30824-6-gustavograzs@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512210444.30824-1-gustavograzs@gmail.com>
References: <20240512210444.30824-1-gustavograzs@gmail.com>
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
 drivers/iio/chemical/ens160.h      |  2 ++
 drivers/iio/chemical/ens160_core.c | 23 +++++++++++++++++++++++
 drivers/iio/chemical/ens160_i2c.c  |  1 +
 drivers/iio/chemical/ens160_spi.c  |  1 +
 4 files changed, 27 insertions(+)

diff --git a/drivers/iio/chemical/ens160.h b/drivers/iio/chemical/ens160.h
index a8a2f1263..9ed532615 100644
--- a/drivers/iio/chemical/ens160.h
+++ b/drivers/iio/chemical/ens160.h
@@ -6,4 +6,6 @@ int ens160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 		      const char *name);
 void ens160_core_remove(struct device *dev);
 
+extern const struct dev_pm_ops ens160_pm_ops;
+
 #endif
diff --git a/drivers/iio/chemical/ens160_core.c b/drivers/iio/chemical/ens160_core.c
index 4b960ef00..a444034a4 100644
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
 static irqreturn_t ens160_irq_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
diff --git a/drivers/iio/chemical/ens160_i2c.c b/drivers/iio/chemical/ens160_i2c.c
index 28d4988c0..b8785d199 100644
--- a/drivers/iio/chemical/ens160_i2c.c
+++ b/drivers/iio/chemical/ens160_i2c.c
@@ -55,6 +55,7 @@ static struct i2c_driver ens160_i2c_driver = {
 	.driver = {
 		.name		= "ens160_i2c",
 		.of_match_table	= ens160_of_i2c_match,
+		.pm		= pm_sleep_ptr(&ens160_pm_ops),
 	},
 	.probe = ens160_i2c_probe,
 	.remove = ens160_i2c_remove,
diff --git a/drivers/iio/chemical/ens160_spi.c b/drivers/iio/chemical/ens160_spi.c
index 568b9761d..2cf494032 100644
--- a/drivers/iio/chemical/ens160_spi.c
+++ b/drivers/iio/chemical/ens160_spi.c
@@ -56,6 +56,7 @@ static struct spi_driver ens160_spi_driver = {
 	.driver = {
 		.name	= "ens160_spi",
 		.of_match_table = ens160_spi_of_match,
+		.pm = pm_sleep_ptr(&ens160_pm_ops),
 	},
 	.probe		= ens160_spi_probe,
 	.remove		= ens160_spi_remove,
-- 
2.45.0


