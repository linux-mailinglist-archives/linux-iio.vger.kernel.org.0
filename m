Return-Path: <linux-iio+bounces-17207-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA8BA6CB7C
	for <lists+linux-iio@lfdr.de>; Sat, 22 Mar 2025 17:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23AB11889817
	for <lists+linux-iio@lfdr.de>; Sat, 22 Mar 2025 16:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567C122FF58;
	Sat, 22 Mar 2025 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xal+4vcN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC4BF507;
	Sat, 22 Mar 2025 16:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742661229; cv=none; b=SxYCkNK9ySWqM4jYByBCY+WGikT3KHI+b8PBF3h4keJjnYowq7tGn+i/XWYYViYY68e0tr9/X6LYynPFJXzvHQjBZMcBqQ7kfDpJTSeMFWXcvEK85XjD27g4mDSJH76v+NygpmxeSgCI7mGltB9wVswucwBIf2ZY5tK6UEAY85w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742661229; c=relaxed/simple;
	bh=epmdvcBgUanvI6wdPZu88ilV2evqCFFzXuIN1GcCsmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QtlIHZOeqdab6NWVEBFhAHzuCLKJqCvJlF1CkKLIiIPNuslboL7RlSR82b/NLDuXdDFz89CR0T11SafqaDsPIwKt52w+hmt0IAfLgSZrwLwTdfCXEcojMyqKRp9rURKknhaFhPyJFd0BMdhmWV983q7qqJeZeojJOZW/lODQxnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xal+4vcN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-227aaa82fafso1408425ad.2;
        Sat, 22 Mar 2025 09:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742661227; x=1743266027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4lxd+tOwn8e/o7grBip1jXB4LMTIMBCnYXyU0gFmpfs=;
        b=Xal+4vcN7SeLs1+Jxz3fuTqK/DYBOyE3aFkGBRHlmfEZUZ5Ye1xBB1jbGvT2xraJfn
         GiIdMmqJ2NykRuaw0GaKcpLVaCTVV9/ryU5GlLlMYZtEn/tKdnVMwYryYrcU8G2gXW1r
         CPaBMX9n+l9efopbzXfhP9vkRQXLHrCUIX/Vqdf9QHwr3eQuEh9LN2HgzoFzVjKDtrtm
         hpWAIOE2vWG5v/rGku6j7/usOCtdzXasOhhVajwxEzIM3qJFjnqcor0FqEDviMklyzGh
         WgC/g1CFNy/BkroB3Ci1ZnKyO1F7cz9VO0QUAmNwHVqwlHSpko9PyaSWP16S/7NNuXAs
         VYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742661227; x=1743266027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4lxd+tOwn8e/o7grBip1jXB4LMTIMBCnYXyU0gFmpfs=;
        b=JI8uEcKlMDuU8Bk4u0BGH5zO/NUBJQVyR2+r3vei+oCqK4fbn8Jg7UrpBuzdf0QVBc
         YsTGfKIjf6oPG7sJRAj/OY7cZ34fD4Tl1EF8gVHk/SAang1lPr1xpEzcp7rcvHA/0Wr0
         AwdtGhHUxqGdWIfY+tLwvbadtYrUik+KAJV6vedS78u2xCBurqI9xhoXYeKvGBFJl4Dh
         QEJdvnJ2DNuLo3m4Z/ymH/u0UbaUPGXY5NEIP6HAKV3Ai16ufHGGOvPXTsF4YGykpltj
         ex1eeXFuI2LsLW3M47SeIGyaLmqwwZZwwpYdmxbPixS4FtrEc42vxFUn9WFBVpzQKRwh
         XqHA==
X-Gm-Message-State: AOJu0YzPmz0E7emmuxsAx19NZo+NzySUB+rpL6ei+dQNJgNTErB41ixc
	RiriCiwotpJgQUhsMAEz+7hspDVbmpUCUV2Vc9qYRZTJ/sa1Wzf5jxHkmUMHbew=
X-Gm-Gg: ASbGncvAwd+9hnIsKxgJ+L2/cVw9pjN68widwApZr/ooJGophPM0N5AoZdMhdTuYdFy
	vkWx6tscO7hbbPZ5RlnFXUEBvD2wYPv4Enzh1zfyWdy0PsQcpH14sXgPbwtxtgiqubIHSgh6xlx
	lfUWwkCZJANFSKeFR7w4awS8tcZPDQwZVNwaCKYauZ0MGDR4WfGw89sQ042i/6+tBdFe9Y4p2DL
	HL2fpuCfUl//m43/DKMyGXBW8cmrGeXlvjvRc0NkQkVEXmrYYf5re6Cyev3uIwlO9H1kM8qa6x2
	2CPqdv8qekEkAzG9Qm9Bd5kqhEXbUlqXQYO1gq7O2d8=
X-Google-Smtp-Source: AGHT+IH4CHkfGbiwWX4r0WBCSBmcdbIgUSaaT+sHhmfhWqHiDv/CxFN/ZQPy1h/6Ri/ibAktf50eig==
X-Received: by 2002:a05:6a00:3927:b0:736:ab1e:7775 with SMTP id d2e1a72fcca58-7390562ad7fmr13594642b3a.0.1742661226828;
        Sat, 22 Mar 2025 09:33:46 -0700 (PDT)
Received: from fedora.. ([2409:40f3:20df:7495:662f:ad70:6f52:57ff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73906159fa1sm4213634b3a.151.2025.03.22.09.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 09:33:46 -0700 (PDT)
From: Siddharth Menon <simeddon@gmail.com>
To: linux-iio@vger.kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	marcelo.schmitt1@gmail.com,
	Siddharth Menon <simeddon@gmail.com>
Subject: [PATCH v2] iio: frequency: ad9832: devicetree probing support
Date: Sat, 22 Mar 2025 21:58:11 +0530
Message-ID: <20250322163211.253009-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce struct for device match of_device_id to avoid relying on fallback
mechanisms, which could lead to false matches against other AD9832 variants
in the future.

Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 v1->v2:
 - updated commit message to be more informative
 - minor changes to code formatting
 drivers/staging/iio/frequency/ad9832.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 140ee4f9c137..7d4f655f6df1 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -431,6 +431,13 @@ static int ad9832_probe(struct spi_device *spi)
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
+static const struct of_device_id ad9832_of_match[] = {
+	{ .compatible = "adi,ad9832" },
+	{ .compatible = "adi,ad9835" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad9832_of_match);
+
 static const struct spi_device_id ad9832_id[] = {
 	{"ad9832", 0},
 	{"ad9835", 0},
@@ -441,6 +448,7 @@ MODULE_DEVICE_TABLE(spi, ad9832_id);
 static struct spi_driver ad9832_driver = {
 	.driver = {
 		.name	= "ad9832",
+		.of_match_table = ad9832_of_match,
 	},
 	.probe		= ad9832_probe,
 	.id_table	= ad9832_id,
-- 
2.48.1


