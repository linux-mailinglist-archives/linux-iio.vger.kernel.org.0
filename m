Return-Path: <linux-iio+bounces-16757-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D79DA5E953
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 02:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4DDE7A9D8B
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 01:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1982D190468;
	Thu, 13 Mar 2025 01:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EO3uNL4P"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF0C189BB1
	for <linux-iio@vger.kernel.org>; Thu, 13 Mar 2025 01:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741828589; cv=none; b=eY9kg0d06bRa4sCNibaHDVEes5qDLFwkNAuY5LmodU+NTvrP/qAGti1rDdox6Lh0WEbQ66bFBXW5KN/MP+2gHJ6+Yw05gOJlaYHaTHLCSnaTcmYOP3a/Pm8rZFtWK4Ag4RvJ0nekb5IPTXcxwsqQ29Nlltyz5YXxHRKtJUq798Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741828589; c=relaxed/simple;
	bh=BXxvhC5h0AzOsTfVrve7Pb4FmR2Y2J/J4eRNQCs5LgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NTQnwqqwyuH63aq9c8gJSH626Y/KX5z95BwfpakhFFCpQ5bLv2eFBsqNmMvHFIv3pXX8dh8vA/7vyWS2Dm3+ZCtN2k5wOj/LujMWXXSVzEvH4i2HCj7N9bDAdMj/2XGfMdMUywjZ9AuwdXZCtGSU/HoLXQ81zPVBEtCi7D3Tk8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EO3uNL4P; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3f682a2c3c8so235129b6e.1
        for <linux-iio@vger.kernel.org>; Wed, 12 Mar 2025 18:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741828587; x=1742433387; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGg77fuJf8u7pd2v1khgNbAaPlfakR6tpz3TWo15l/k=;
        b=EO3uNL4PD5o5AGUda/nLPI2wC+/k91/ITAqVNtLA6AFFf5rewPEuZyAnF9j5wwWUCQ
         hzfRMZPWLeGnX9vPApdSO8FY6fFCZZi7j3auVF8zmOHoBz9vy3dBnYnyQr9l6nSwPEWo
         2ZhdUjWKVStBUld7adwebb3IlSrUbLYcemwqsLtvnjAlPcb4TflLZ5pswY5ZX18pXoND
         R5KIO0TurDTPu4vR+XgQx/qhwGOU5hmLjvGQYOsdIJhpI59fHo3GSMiRcdv2D5e1XyK9
         GH4SgvMn8WzZbRSxuvw0b3emLpKHLGMjVecZ2+3htmslS7kQy11bbb0VV/OsO+Nlky3N
         XTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741828587; x=1742433387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGg77fuJf8u7pd2v1khgNbAaPlfakR6tpz3TWo15l/k=;
        b=SqNR4cIMXy6W3BmtKIbZU6nsBvFHALGXt57nmUOHtV0MrhJKckw4kaR6ZbpEXqtxl/
         w2/laLFS5YKEfhO66B5ysDajHWJ5aJZj9LOo27l2wErDTy3xCoK/VU4tQToG09Nsth+1
         FD15iZ8M4jDAmHkQe8pBbi34Js6g2ntO2qYwldEue6Vi+rpS0FmjgBCHC1A9aD1BVbhh
         YlZQlCT55DCnUvj4BC7dpitlDR0/ul3WAMCEEHbbJehFn2XYQBC1J95FME5MJcYNyVO9
         sxlRFWBr03beB/bMt2Z0Xcr8BReq6B9Fc4jK6dimLUoxPrNQElNEMgSdw60KEpdY8fsv
         iVxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDt4kz4Ajt7TuIj2txx2yi8Vr08M7GbH4uRriUbYruoTkFqQZINtB7o47F9yBz9d9oodV7kKBdnHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5JIgyhq80hXPuPUsM4ptu7FQ5BxDbReQsqferc8dEplEwo4zn
	My5CEHt6fKlanG42QimovtCFBn4ex/3tZ7enhRBY906NT9eCTcj8Q1I8ZseqPb75YekGmcNs7XS
	VdNQ=
X-Gm-Gg: ASbGncuK1yUhL8EzQ0j2pqRZRqjTLVPR+9H84jDIhuA2KxWg9bioyPu8beTRiXS7kyq
	64t5WWR0lHThRhy6Yjx4wwoH5NskGz5nU0hj4/gfzagoGyIlcqhsnS5mM9H9LznifLa7t0VPtSL
	Ep31t2TKAwgj+ESxYKaFnpPtSVj1by7MVp6Rx7U3D15VYBeIzXRGJaMzT0AADdQJUCd1fXfV7HU
	77scOgUIltmY7VcHEDUx7/0TIv4nhKEETTK9QpEH9pC6dx6QZC8aBI6ujYgL668ml7CFqFojCvE
	C1Ck8frxZTVXuV7RjywqqYlAB4kv8A/9MwbdsumcXwOxU8KVA/GClh5v8AU84ZnQ9dbnoWgmVQB
	z
X-Google-Smtp-Source: AGHT+IFF3ucG6AT4ENx14DV/1jOP8xEPl32fTE/2LRKY9G4AxiJc2mp7+lQh8fVzYz9dJAWgQZROgQ==
X-Received: by 2002:a05:6808:1444:b0:3fb:174f:820c with SMTP id 5614622812f47-3fb174f84cfmr3738216b6e.0.1741828587294;
        Wed, 12 Mar 2025 18:16:27 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601db659ad8sm39865eaf.8.2025.03.12.18.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 18:16:26 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 12 Mar 2025 20:15:45 -0500
Subject: [PATCH 07/11] iio: adc: ad7606: use kernel identifier name style
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-iio-adc-ad7606-improvements-v1-7-d1ec04847aea@baylibre.com>
References: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
In-Reply-To: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2957; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=BXxvhC5h0AzOsTfVrve7Pb4FmR2Y2J/J4eRNQCs5LgY=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn0jHbpzZ5OD6Gt8KIxbuLJe2BjzUgY4PeSr1rx
 n7iU9UVq/6JAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9Ix2xUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fANJvg/+IGuaCUn8KZSm3li7iEdEGYmKimcf36FtJQq/J2w
 iT+LLVWRs3PB99TSrBbkAjD+EsY5dh7MSf84/EAFI5noMHgdlRcke72HJ/j29pzLaKLxMwQpWZ9
 ssMKieU+TarO/N8hZZQNrS3xWI2nEvNFxhKnSWbtZ0sFgBu2I17OGEHZlTgGZ76YOx+AVmmUuqQ
 +UE1r4p0X8IOkqWdQgIvLNAac1QLdifcCmlkaVQjTVp6UP9+3XEh8aXnoOpbCpXCbLU+Q3Qa0t4
 7M9UYk/qb6q19EukUh4HFvURCdYakyzwXW2/DIv8b9SLuvUzyMLIpPFQkVpiONurttdwuIpKjf8
 1nPO2pirsH+4JeiYZkJrKVO//iBDSqkPqY5YKIHtkYEog295r86zFHen1A4q3Iyy3HkN+H3H77V
 KO+w2jTZTDtstCuR4CPHUaya9Feuud5oYS+DZW60aFcV4WhWXKr29cws0BKd55dBm4DYNF6dUey
 g8mCAGALgcASI86Zwkl1Fys7U8KHTEvIrJXEyDaA4Sd63zHp4ukfOE0oiKm7rfZBsrjNNqjvCPo
 SR3YXhZ6TY9t0J0W+8haY2o6OB8OStp84h3tqkzhcwSn3rJOcqSPoRshGouDBJ+Ijts2Ip3gAkJ
 6sclWzjh+HCz+SiycVhJw2fzqfhrdzZtjUqXZT+kBIxA=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use lower_snake_case for the identifier names as that is the usual
kernel code style.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7606.h     |  2 +-
 drivers/iio/adc/ad7606_spi.c | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 3da78488c8a247dccbff930023f98717d540081a..01b0e2fcf343a77631fbf20c12ac9d02c80c3455 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -254,7 +254,7 @@ struct ad7606_bus_ops {
 				unsigned int addr,
 				unsigned int val);
 	int (*update_scan_mode)(struct iio_dev *indio_dev, const unsigned long *scan_mask);
-	u16 (*rd_wr_cmd)(int addr, char isWriteOp);
+	u16 (*rd_wr_cmd)(int addr, char is_write_op);
 };
 
 /**
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index c028e08efe2c82cd97249f98eec50a9a9c06471f..1abaf8626206cb30e532cf9f82e0d050706aa1e0 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -59,16 +59,16 @@ static const struct iio_chan_spec ad7606c_18_sw_channels[] = {
 	AD7606_SW_CHANNEL(7, 18),
 };
 
-static u16 ad7616_spi_rd_wr_cmd(int addr, char isWriteOp)
+static u16 ad7616_spi_rd_wr_cmd(int addr, char is_write_op)
 {
 	/*
 	 * The address of register consist of one w/r bit
 	 * 6 bits of address followed by one reserved bit.
 	 */
-	return ((addr & 0x7F) << 1) | ((isWriteOp & 0x1) << 7);
+	return ((addr & 0x7F) << 1) | ((is_write_op & 0x1) << 7);
 }
 
-static u16 ad7606B_spi_rd_wr_cmd(int addr, char is_write_op)
+static u16 ad7606b_spi_rd_wr_cmd(int addr, char is_write_op)
 {
 	/*
 	 * The address of register consists of one bit which
@@ -171,7 +171,7 @@ static int ad7616_sw_mode_config(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static int ad7606B_sw_mode_config(struct iio_dev *indio_dev)
+static int ad7606b_sw_mode_config(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 	int ret;
@@ -195,7 +195,7 @@ static int ad7606c_18_sw_mode_config(struct iio_dev *indio_dev)
 {
 	int ret;
 
-	ret = ad7606B_sw_mode_config(indio_dev);
+	ret = ad7606b_sw_mode_config(indio_dev);
 	if (ret)
 		return ret;
 
@@ -228,15 +228,15 @@ static const struct ad7606_bus_ops ad7606b_spi_bops = {
 	.read_block = ad7606_spi_read_block,
 	.reg_read = ad7606_spi_reg_read,
 	.reg_write = ad7606_spi_reg_write,
-	.rd_wr_cmd = ad7606B_spi_rd_wr_cmd,
-	.sw_mode_config = ad7606B_sw_mode_config,
+	.rd_wr_cmd = ad7606b_spi_rd_wr_cmd,
+	.sw_mode_config = ad7606b_sw_mode_config,
 };
 
 static const struct ad7606_bus_ops ad7606c_18_spi_bops = {
 	.read_block = ad7606_spi_read_block18to32,
 	.reg_read = ad7606_spi_reg_read,
 	.reg_write = ad7606_spi_reg_write,
-	.rd_wr_cmd = ad7606B_spi_rd_wr_cmd,
+	.rd_wr_cmd = ad7606b_spi_rd_wr_cmd,
 	.sw_mode_config = ad7606c_18_sw_mode_config,
 };
 

-- 
2.43.0


