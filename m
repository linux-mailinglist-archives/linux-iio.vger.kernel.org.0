Return-Path: <linux-iio+bounces-15879-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8068A3E19E
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 17:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21D23AA331
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 16:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB6B2147EF;
	Thu, 20 Feb 2025 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoxjQ0A4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F259212B14;
	Thu, 20 Feb 2025 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070221; cv=none; b=emwrFP0e16VJUw0H7DaMCnYHQsGT/RtdFOTAfnfofwU3JoUzPciQ6jJkWpHlqPPstIDNbZxKa5CiVvr57ZmkyfuBrHvTeVQUZZwOWzQXWVO5Zlgl2d9rZropoQFkxpO2e4gyavCO/VXmhqeCLmriBVndQN1lYc+2ee1K/q/FH10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070221; c=relaxed/simple;
	bh=ipPoH8S0BjSG9XvVe/1KcGW8C1EHKPc+8Cdy3yvx2AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4oLUjmld/+s2cPzv6KmyRJrMMzmWxqyempFxpv8hPmYPjsAwP5OCuej85svh7Q2watFg16DKjrXtnm4VrDjJE7JpwkDXsnvgckLUxybTUXV6Tq/mbDiyCjHPC/kyZjiCcBm9+5wv4nvc5/wmGgKy7OdoGDF1aj4e0kpvXVMXM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoxjQ0A4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220c4159f87so16717745ad.0;
        Thu, 20 Feb 2025 08:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740070219; x=1740675019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjwp1wXK2Weef0ACMUHjbcA42X76+40v0Kd27CyeWkg=;
        b=MoxjQ0A4o1iRae4T/K8b90Tc2YVxPVP05uExsjF5+fUruJqspkyHc/o6EGKed5+P1S
         48o+Am6Ug2zli5wjcjeufC7LjOtun4rtHkE+zNiR5npax0EhBwg3eN/NYfXOiWuKkpBD
         247HN3/lOi6fQ71srEW8SYd7kCiKofymmI5DQW5FGEDqCHEgPtgdulPhsRJeQq7+/xp9
         4o5lhtq3JEYXZ4Ti4/pMu5TWrH7uSd3wQBeuPySmq/PTC+n+kS4pX8UwlimWHQ96SN6s
         /e3l7wAX6HQR7uBJ7jz5kvLViJU1aLzQms2RSERBKA7dXivrXT/U8nbl/Zv4hWF5DTS+
         0jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740070219; x=1740675019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjwp1wXK2Weef0ACMUHjbcA42X76+40v0Kd27CyeWkg=;
        b=sm22MEFKffgBkEFYMNibhrY+CvFNdjh6f454K2G6NIxZW3lmfnqN2x9vT8ovbxuKPh
         Kp+QLeOACCSTLqWCsvYJXFgo1RsyYKFgJtx6LwGmbO9C2JNkymXB+jPatTiW5kN70uMK
         KrNW+wOGH5D84YCJZHX9wsz9/ufGxZuNFVV4GAs8DLmNhcvK3LqliNEtyX01JLBjlwZo
         CVPnmD7cHmAc99HNxkwstnXu5HM5BGbBhcTLgsbU8IYWq+znzV5djs0qXYQkYsi4faMk
         9T1YK5uSJIsvcWs3V6jNP0qllMiElxudMOLcwf2kLi4g8V+FVOn2XfYcLIRkykt4bAFW
         071Q==
X-Forwarded-Encrypted: i=1; AJvYcCWALBmRK23mlGUU7PUvHh5/5YIBoXAPlqN0uH+6+NUlMTTgyTfCmgmAi0h9TUKTYAnoFugGl/T8G+fxKzxU@vger.kernel.org, AJvYcCXY0NyV5YbHh7TIbYEOxcWVdtCku2R6u3q4dOncBIUzHCOhOfSLa8GiXvhesHLBat2RVLTn2iBzwGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmzRtD/48Rrq4Jpn1fv7Vf/+jbqWpWlFODjy70np77QUpXuH6S
	HfTCsBrYGbpyQxreRdQpbj4JJbMnyLpTNTapoRgcDaWvipaSHUsk
X-Gm-Gg: ASbGncuK+Nhf5LjBftLfMqVzMJ6xEo9tn/kGr+Vld/46eQHbc2y5Z0MZyCE93HoDbm6
	tUMLALdB2HThbOp81TDARhxDkkCMJ6Xm6zW6FpQMs0Cq6U3rgs2OzombskYYn/lCddnHJlEnzmh
	3egM/EDBsd8Z3oNN+t+UY3Ui/eJuvtI6ZU1HHyT5p7U7O/mT72A1he20oDk/noSkPmqpOKdD6W2
	ggzH77C4O8DFsItcb5JWO/7LvCPSb270FEudFTs5q0cOK1hXImS/H2ChgPj+EDxzGak67Vr6jtR
	1FRleDAHPDco5HW4
X-Google-Smtp-Source: AGHT+IE/81oeFPIizCiQwxykWG8e0rixQqD8kciZkvqjq5xsGZJajOwlXNKAOsgJir5SH7fqxiMf8g==
X-Received: by 2002:a17:902:ea11:b0:220:ea7a:8e63 with SMTP id d9443c01a7336-22103f19fc8mr349472065ad.17.1740070217151;
        Thu, 20 Feb 2025 08:50:17 -0800 (PST)
Received: from arch.localdomain ([2a09:bac5:cb26:1caa::2db:85])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d558fe46sm122454895ad.239.2025.02.20.08.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:50:16 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH v2 1/2] iio: gyro: bmg160_spi: add of_match_table
Date: Fri, 21 Feb 2025 00:50:00 +0800
Message-ID: <20250220165001.273325-2-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220165001.273325-1-jerrysteve1101@gmail.com>
References: <20250220165001.273325-1-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add of_match_table to bmg160_spi driver.

This fixes automatic driver loading by userspace
When using the device tree and the driver is built
as a module, devices can be probed.

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 drivers/iio/gyro/bmg160_spi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/gyro/bmg160_spi.c b/drivers/iio/gyro/bmg160_spi.c
index fc2e453527b9..ac04b3b1b554 100644
--- a/drivers/iio/gyro/bmg160_spi.c
+++ b/drivers/iio/gyro/bmg160_spi.c
@@ -41,9 +41,19 @@ static const struct spi_device_id bmg160_spi_id[] = {
 
 MODULE_DEVICE_TABLE(spi, bmg160_spi_id);
 
+static const struct of_device_id bmg160_of_match[] = {
+	{ .compatible = "bosch,bmg160" },
+	{ .compatible = "bosch,bmi055_gyro" },
+	{ .compatible = "bosch,bmi088_gyro" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, bmg160_of_match);
+
 static struct spi_driver bmg160_spi_driver = {
 	.driver = {
 		.name	= "bmg160_spi",
+		.of_match_table = bmg160_of_match,
 		.pm	= &bmg160_pm_ops,
 	},
 	.probe		= bmg160_spi_probe,
-- 
2.48.1


