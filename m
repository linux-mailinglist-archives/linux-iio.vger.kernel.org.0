Return-Path: <linux-iio+bounces-16479-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C335DA54E6E
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 15:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A533A579B
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 14:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CF61DDA35;
	Thu,  6 Mar 2025 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEPId+5L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C43502BE;
	Thu,  6 Mar 2025 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273082; cv=none; b=ktNaz4vtthwXqA0VOCxGbKSiepIK7lC+Yes15vw+cjetE+ZmHlriNv2hvZ8t3khcFH5FqNOc+8PFQizavvmvhmzwdqh5HKFDw5jr7jofb+iqybp48RoOFS6Obx1xUjM9kywndvNFOBb0nMRgATxmjzrjHClNm/PEJPKjqMAhHe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273082; c=relaxed/simple;
	bh=X2NWMjY2MfU7Um5qUVTYLTChB8zxNHuXB6rzIgpHL5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TonFWBrVS4W66dWghZtGyjESXFfOQRkSh1oUnVps8bYKcoFTXOmCXi+5wg/YbdcW/io0IGugrBntS1mu/d4dm7P/22VzsLALJcU4jAldAF86hSr23V03BukMIVeEYH120ijqJbYFjiBEl52fMOwGi5FaqJnRyFb4AT/ZANnnbQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEPId+5L; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224171d6826so11809775ad.3;
        Thu, 06 Mar 2025 06:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741273080; x=1741877880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2JDsU2SmORiGfq2sIP5iCkSc98XJuq4voAOv82orYc8=;
        b=WEPId+5LI7hgoP8hpBt8Jd/iO9MahVrYoSJJBZAPSHwlSS0BvKBo9Thdyz6g6KwOmI
         zJF5MmR6AZ2gAxmeLWNgfluAhXcB86V+huWXeGt8WZoYf3c6S0uku3/IiJXEHvWgeWvI
         JzG7xjcbHYsCIkJFY7ISPL63NAWP4M+Kyo7YGFplABSeB8zWG1DoM3jtNRWvCTIMSCyG
         OIiIr8exUxn2HnoMDI0MYPggiNxAryfwFk9B1qsnLdifgPWdurokJQ4TxCsq6lZ37bGi
         c3amQmKxjV7Me25yszVvSD0jQTmj9CCX15pmYmTjpx6SHaKrGyrlSBjVPUWdtiFm88Ua
         G60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741273080; x=1741877880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2JDsU2SmORiGfq2sIP5iCkSc98XJuq4voAOv82orYc8=;
        b=ZxXSfDF1mpLkDgLvDF/4ciHycQuF9u4vhbAKpTZau79VSAJXISruD+kE+NmG2+NFV/
         t99qtYuVmEHR5IvqhJb1OSRz8iYkBx0kNCRrJhBJ1hMG+BW4f+71ackecVQ6hLopEECC
         Ob1sS5cZGq4fnFcb3EAuCOv5yVkkiN1e94VHnicExQppGvk79+2FzuG9G2rKJwlWKkeV
         h8qlIsATXxNzCFWAMVmsIYeTwp2Mg7QfFPFVHNYcOdcuLrm8uIDaMZAF9jhZQAlosSB0
         iu7EU+L88JqjboIXU9+8nvs7VfGjbtStz72pbNU1x2yjczWkAloBJhgXrxsuVk9NMu56
         rthg==
X-Forwarded-Encrypted: i=1; AJvYcCVmHzno3kJe7YbTSQfioMZJK6VgbWmMiDLOdHJcmiUYa1dPXdWlvBmXKtGcS39uhdCcwF6oM39vhsLtuMNj@vger.kernel.org, AJvYcCWocePzMHtzhC789Gtcd9Jq/oWj6nOWKe4H5ZRE7nRyisqGDQZ3IXokU7yf/FKCNrOCmbBKAHSgkHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDAmdOBY1hrn/E3Id67MMLH2pn+b/Lf7C/hJ6wAVhEYB+ATLpz
	TQxfzvhZjPVRwJ7mAH+f2JnVkGZegPphSzWq2mrjJ5MNf5PgPVGU
X-Gm-Gg: ASbGncso+XsmRzP7zu9Kf+DkomPBYjPTX5JZizxHaDS3nsqPEkp5Tbg8vMirJzDOPaK
	U7mkCSZ6jfndOk4mhlEJJKDzxnrc2m9aoslWlLBsXYQSSxpFWNXppvoFhC/B4RXFyMLZjezQrcT
	WVpk7Xn22srCNH3owyeCMOUS7mfqrtTpAylllKrjZ1TWjiYZ0TPIQtNkM0sBQpcdqb/nyyR5x//
	PPIZVnFwHUMgaanea9AnLAvrwm4Et+LP/DyeQLx4STtWebQ1EXVskvDpUkOYzbjvyEVNvqzxre1
	sHuPyB632bGzAsJD/WkEg6TKu1h4GAevcy7LV1IF83PVmw+SBHzbkA==
X-Google-Smtp-Source: AGHT+IHBKKDtkcTGGqRdnysGj/z/1lgBSKY8u2cmOnYSF15Dw9oBipzJjiueaspfIPt6YR4RQc0zqw==
X-Received: by 2002:a05:6a21:32a0:b0:1f0:e746:967d with SMTP id adf61e73a8af0-1f34949f802mr12880702637.10.1741273079733;
        Thu, 06 Mar 2025 06:57:59 -0800 (PST)
Received: from arch.localdomain ([137.220.229.22])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af281286c73sm1319636a12.64.2025.03.06.06.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:57:59 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH v3] iio: gyro: bmg160_spi: add of_match_table
Date: Thu,  6 Mar 2025 22:57:40 +0800
Message-ID: <20250306145740.32687-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing of_match_table to bmg160_spi
driver to enhance device tree compatibility.

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>

---

Changes in v3
- Adjust the content of the commit message; there are no code changes.
- Link to v2: https://lore.kernel.org/linux-iio/20250220165001.273325-1-jerrysteve1101@gmail.com/

Changes in v2
- Fix a syntax error (a missing comma after the .of_match_table = bmg160_of_match).
- Fix the style issues found by checkpatch.pl.
- Link to v1: https://lore.kernel.org/linux-iio/20250219150254.24664-1-jerrysteve1101@gmail.com/

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


