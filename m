Return-Path: <linux-iio+bounces-5417-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5208D295D
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 02:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443A01C2321B
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 00:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D6CFC1D;
	Wed, 29 May 2024 00:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjT06ONM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2730F107A9;
	Wed, 29 May 2024 00:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716941728; cv=none; b=MYVvgGFbDoa3xEL1SgdcKpPrAH2UP34kC65dTk70OiU3RQX1BUotHoG69zJhvl8fj236b76tImsOzZv1nfNe9NmWE+/gjVqyV10IF1GGwQRpw0XA+BW91ULE2+SIus1O++EKqIiJxrebuCKJrOvJf/cfHy1kkFdQF59OR8v+cHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716941728; c=relaxed/simple;
	bh=TQ2tuFb8KTSWOOE4KcN5SHfR+HSgWv6/oT3CclRh0rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBCMbwnXzxYehwk0HyoYFkDw0eXaEz8mlvb1kiJHLIpDhA/+61Dx0ocxnCY2F/NUjon2AYzuRbW7vvl6Dgl5TauSZQcbxjt575ie82/h6WLMmNnSNk8mph2n4P9Pn9VPrS/E31b8PChrk3TfDAfDYjcZK0tW0NRKwXGLtoaB9Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjT06ONM; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f6911d16b4so1230760b3a.3;
        Tue, 28 May 2024 17:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716941726; x=1717546526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hq3NtQJgJ+mKuwS8MgsQdc8jpUO2tdGTkXq47bqF/Fs=;
        b=hjT06ONMPJKp5Fu2FrIFsUk9kVOGvM1Up3Qj2xlGuc+2Cw9+yEa2zqQpFPrhiDKbqM
         jnEFFRhJhNBe8yRHra0YX3kr/f/FhW22910vJwTL8+q7pws3oBlEVOifV82gGmDtlXqH
         UYP0cyyJLStNAZbtRw0tSvHDbCcdz3tYytvYX2XWikVLmjhCeCAPwQUPbRkSGoqlN9Nq
         wj5st0g9AT6igUaeYMkTJrzbkFzcIbQsHP4aDie38d1hchcCTgIgOAJl+ctSh/0ciNOA
         3txecv4H6igSBca4NKjfl6btjSII4dIw2CcsF9DSDtWaji1CQLe+UJ1S3PD7OoHcN6Vo
         XKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716941726; x=1717546526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hq3NtQJgJ+mKuwS8MgsQdc8jpUO2tdGTkXq47bqF/Fs=;
        b=moLZ3pQPLDmAXRHJ7D7kMPvmL8mUZnAALUd5a4n+HguooDHgDuJu7oJ7xYCgAVKLXX
         LCEBs5F4LqFLnMRj0XLB/0SlZz3tMrzr6kjaoZjLIdiz6VRKLRjM9tUuVLbGODXL5thL
         RNhKhKKPmzPLtg/uT/y/7H2c+9CmkByIy+I8/KMDfT6na2pHvc9bVvj9pJNarnh4TDzF
         U4ndaoGMoJiZ80VjDyl6TYJtQlV8TaShk24Gw/fTMNwu2TIK/X5M5MBPyhLaj8nNzdpE
         5q1QBC1HoIW2fkB2DprUEzegPJVX51yJneLuxa+DamIm0+lYHepqGY4ImMItuZgg9/+5
         ZwMg==
X-Forwarded-Encrypted: i=1; AJvYcCXsAGzatVlP5pALmz1lNvu/dr2FOIaPLOerDjBFkD1Q5YjvlgcdOvplUfU/y/dP3jJ3EYGLqiRgxu+pt1mVzPdabrskW0znZ/a8G8rhhQuezHu7iXyKom/kAmS48RBP30eLmlNL1rYZe5aNXcRqgejNDrnCbd2yPX2nu97ZWb0twhTRNQ==
X-Gm-Message-State: AOJu0Yw9SqlmXupnASucRPHABd4zJYnMPlAvvS//ulJ2GWijZjjCf6Lr
	5iS41evdPuxRmhw1rQuDMn5FlRAQW9w5Wb4EFlkL23ZK1PCteMnP
X-Google-Smtp-Source: AGHT+IFkLpirTq+1BRKb+hkAOJtU99YMtsYJQHPLuur9VJq9pQJm6JGWF2nR4zZNv8iJHUgubDtlhQ==
X-Received: by 2002:a05:6a00:27a7:b0:6f6:94dc:6c4 with SMTP id d2e1a72fcca58-6f8f3928a67mr12815452b3a.20.1716941726415;
        Tue, 28 May 2024 17:15:26 -0700 (PDT)
Received: from localhost.localdomain ([189.101.162.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fbd3dea2sm6941433b3a.24.2024.05.28.17.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 17:15:26 -0700 (PDT)
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
Subject: [PATCH v2 5/6] iio: chemical: ens160: add power management support
Date: Tue, 28 May 2024 21:14:22 -0300
Message-ID: <20240529001504.33648-5-gustavograzs@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240529001504.33648-1-gustavograzs@gmail.com>
References: <20240529001504.33648-1-gustavograzs@gmail.com>
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
no changes in v2
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
index 74ef7f150..dd501e655 100644
--- a/drivers/iio/chemical/ens160_core.c
+++ b/drivers/iio/chemical/ens160_core.c
@@ -215,6 +215,29 @@ static const struct iio_info ens160_info = {
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
index 4bf3c455c..06d2967a9 100644
--- a/drivers/iio/chemical/ens160_i2c.c
+++ b/drivers/iio/chemical/ens160_i2c.c
@@ -49,6 +49,7 @@ static struct i2c_driver ens160_i2c_driver = {
 	.driver = {
 		.name		= "ens160_i2c",
 		.of_match_table	= ens160_of_i2c_match,
+		.pm		= pm_sleep_ptr(&ens160_pm_ops),
 	},
 	.probe = ens160_i2c_probe,
 	.id_table = ens160_i2c_id,
diff --git a/drivers/iio/chemical/ens160_spi.c b/drivers/iio/chemical/ens160_spi.c
index 91528c5e3..f9603f51d 100644
--- a/drivers/iio/chemical/ens160_spi.c
+++ b/drivers/iio/chemical/ens160_spi.c
@@ -49,6 +49,7 @@ static struct spi_driver ens160_spi_driver = {
 	.driver = {
 		.name	= "ens160_spi",
 		.of_match_table = ens160_spi_of_match,
+		.pm = pm_sleep_ptr(&ens160_pm_ops),
 	},
 	.probe		= ens160_spi_probe,
 	.id_table	= ens160_spi_id,
-- 
2.45.1


