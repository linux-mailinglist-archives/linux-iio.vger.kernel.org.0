Return-Path: <linux-iio+bounces-15793-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BCFA3C2FA
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 16:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FEE27A4D28
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 15:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79E81F3BAB;
	Wed, 19 Feb 2025 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipx1Sekk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4B21E8335;
	Wed, 19 Feb 2025 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739977408; cv=none; b=a1gpzsPwFXMCLAS2PxxwQpYVkIp0198Y2R5NkMOd+f7oCw89t3vi2v/9QOsPmazkMnie2F3ldEoGDGZ4oDbdWgzouLr8LBholvuZ2+oJIGgpoiHUEg138U8Ux3W1gLnvXfcM7K5NNBndxvh5AFcNp6uTjSXCKzOc4gKlahT2fMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739977408; c=relaxed/simple;
	bh=gNJuCWWPkn2ogCPdL4vvTsSj8M6+e+4Ld5Z4O5u3VDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1StXEEmspeAfafER+qbHKOVENbhXhIDoMz2uctYqqOzOOn9Rbx+GSa6m3B1quPRFvR/k/Mv6dlv/3KOJXi7AnHX2PrTnEVNRR/NMr2zEBOAvZ1K6+DoO9nASNZiZaHEa+q4JSMAVhSh7aFOwoKgOgyHWrLziyExJkFajU1xMKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipx1Sekk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220d398bea9so96805465ad.3;
        Wed, 19 Feb 2025 07:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739977406; x=1740582206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3nTO5fc7XlQrY1JQWL7gsnfSa3JDTvY1BadSivDT2o=;
        b=ipx1SekkO/VUr4oWcI4m9lTxz4VN3EVM5LLB4U/Qosh+EQZQgtBeKG3OXnsFALbDZx
         HNlk6USTtwFL7tCmCBwYkbDit+rSN4JneS5BBmzczFyrTZQsjGXaRWy87k7kd3ETofTg
         1VsuWY49By9OrQtCbzE6oIlaLIFuTWJ1LQFbqqt1o6x7rV0TqeAJHoVn8gkK8ecNwoye
         1KUKo6fRdwmuVQsujpVCf3IRePQc8hZcKsTN4R6SKBHt9n5QY08xQxdnBtP2zfIf9jSH
         zml0qMWhXWHvFHBwu7TfGBzoLJCNDnuO4n8nfY2JwMCJnO4ri4OaNsvejCQnBrj5SkfL
         fawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739977406; x=1740582206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3nTO5fc7XlQrY1JQWL7gsnfSa3JDTvY1BadSivDT2o=;
        b=O/AEsf/xAkJqTAszBkc7DrKIpBkgLAD8B+cfbXi/ZFBLvJ4C96k9han0MEP7rS/56a
         OqqcgwNZhnbYAGXL3G465U89L/q2XiXRw+8pWvyyy6mOHyMZ5w983FQQkoBP/vdQj7i2
         ER8XqZus86tWF4YnMriWyo2OJW+48A9Ug4fSiCBZfT1FbLTQ2m5iPYQ3Ijj9TdcC0j5+
         RLG6rwqarwxEcE/HOmmcBYZk/A9WUSSuiRWdQipJ6X20Ehg6cHmirB+LwrUeVdVLqLts
         ixSX4o4stYLVzuLivY2h7Kxkij2PRvpscnH1PoxBPZAOnBeP22V+Y9Ezciyst3gFeL/E
         Tmew==
X-Forwarded-Encrypted: i=1; AJvYcCUYK5JdSi3Pv/gct+5oWq5kSPFSb9MwYleUVWnGgvvDWBK9HvmyjzGpN8XKgJjNNsrcGToL+1nfmU/tqT0R@vger.kernel.org, AJvYcCXYUbZLfNAzE/qMuJfBcBCWaSvUGFxiUG/G7b+C2dU7MBXeHB63zidEBTHE1YfkQuoJKN9thgugXQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YykpCxXL/8us/cslzPYXqtFIKALKXAFFhKFxIjwi7AXAIiXyJ9s
	PcXicz5CRtyWrBkR10Jl0Xg6eCNtink5jMVrKPbdD+abcD2vjs/v
X-Gm-Gg: ASbGnctUjWQJg7ePf8eeJjpjprdy3cOOZRN2tWi/9KoNDyaOeZBIUJ8fbvCwYB0V6sQ
	VLZFwEakFOMjTPRTpSHq3HaUl/QhaFnWseuP7JJ1X7xOckV1N7OawYcb/ngtW/AIrEHmCVsiATU
	kOeXhxud5OKemzgmJvI0aSqYLrxSqf+z1uG20U/l6ynKj9VtjL0tpnenBlect/7InoGeaGjP+Bp
	YnxC5Ckak0mn0pLCwgNwnvga2eS4tTjIYj3oQDWtofrCE2c2dMMR5HDZU+HmkYpMO7BBb6Onp1h
	21c4n/bXL8nQZXgC
X-Google-Smtp-Source: AGHT+IEX03nmjYzK0cFa6wZI0ro1+cfpRCqIyK2+pfEY58ZP+zRDt3B3RMAo7cq9uxNEfVRlx4zI7Q==
X-Received: by 2002:a05:6a00:180f:b0:730:98ac:ad79 with SMTP id d2e1a72fcca58-732617d97b8mr28584490b3a.12.1739977406277;
        Wed, 19 Feb 2025 07:03:26 -0800 (PST)
Received: from arch.localdomain ([2a09:bac5:cb26:1541::21e:92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7327367a960sm6888976b3a.150.2025.02.19.07.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:03:25 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH 1/2] iio: gyro: bmg160_spi: add of_match_table
Date: Wed, 19 Feb 2025 23:02:53 +0800
Message-ID: <20250219150254.24664-2-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219150254.24664-1-jerrysteve1101@gmail.com>
References: <20250219150254.24664-1-jerrysteve1101@gmail.com>
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
index fc2e453527b9..dd33b10dc1b3 100644
--- a/drivers/iio/gyro/bmg160_spi.c
+++ b/drivers/iio/gyro/bmg160_spi.c
@@ -41,9 +41,19 @@ static const struct spi_device_id bmg160_spi_id[] = {
 
 MODULE_DEVICE_TABLE(spi, bmg160_spi_id);
 
+static const struct of_device_id bmg160_of_match[] = {
+        { .compatible = "bosch,bmg160" },
+        { .compatible = "bosch,bmi055_gyro" },
+        { .compatible = "bosch,bmi088_gyro" },
+        { }
+};
+
+MODULE_DEVICE_TABLE(of, bmg160_of_match);
+
 static struct spi_driver bmg160_spi_driver = {
 	.driver = {
 		.name	= "bmg160_spi",
+		.of_match_table = bmg160_of_match
 		.pm	= &bmg160_pm_ops,
 	},
 	.probe		= bmg160_spi_probe,
-- 
2.48.1


