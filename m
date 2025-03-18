Return-Path: <linux-iio+bounces-17050-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49808A68014
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 23:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4F85189423C
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 22:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9952A2147E5;
	Tue, 18 Mar 2025 22:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Zh7JfbqH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28942144B7
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 22:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338347; cv=none; b=NXv+o+A0nNh0enBAus1ocoXrUbpRoA5nnL4OEmRygvaaruJUuIAuylgKlylXSoCs3XtD8z10K9h4jpQ+pzFGvop/iGbPEHHRkfk0xtHLWQ01IMQ7ei/jEnc9J1xK2Ubzk2nKRA39d3/4PedjbwbIYNoWfgJsSjStLmSL+mf60zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338347; c=relaxed/simple;
	bh=CAmnZs2wwABDFC9jlNwO8N4jlwQRTM6tiGxgYLL9RDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sgWLDspMehq1c49HMj0ralWbkJ4h/rmuAJ5OO0B+8dQWbR//nrCSTXYwZBeGFJ9fsU7Ye1sWpNYV+5hk8MqIrwLZkq9YxKL3IKddvezZDjyZgrv8Y9gHcN4d2f0vyFEZonUH5TN8hOcxHwHVbuDYKuSVzR27gCVDXyr7+gui96U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Zh7JfbqH; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-72be60c1d7dso320079a34.0
        for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 15:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742338345; x=1742943145; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VXTB0JSR8YlwP4j7hXd1FzWCYlbD8GNV764HlBgkRx4=;
        b=Zh7JfbqHVtW+WLzOthYt3leFEn+VcZm+mf/fdG1iikn4tmGDMDC66CIy5EDTLxIH/U
         dPbgodYqKzRcr+HR78tNDKDsQnSsgAdPdZvL/OrD7lreDL9QrdZgfsDSxouzDezY5R1b
         wbISJq1Qhk9llMUVQNelM2fA7iDCKErWX+DJ83CTi4PwVXHuPhfi/IKxFCZ0cPilYTT0
         weGfhW7it7e+kDtreJ52dkwMD+ykEpBUeDGVCnQ/5xQ340mxRte+rdK+W+5qCtWtOe76
         IawAsNn8ZXXXoA0DnWebR42wAtabvIMTlZE5NnKukguNuk75a3ByluCx7jPxJcV5UYl1
         fsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338345; x=1742943145;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXTB0JSR8YlwP4j7hXd1FzWCYlbD8GNV764HlBgkRx4=;
        b=M+ZuqwA8OfO6df4Q4r/rl3RlghvP5KswMB7enavTdBMdG+NIvy44Oqw3ehL5BSVBXn
         jf27vI0gFw5JtZ3aPD/PM7uFr74jb9wzrinwYWYrCFOELkvwzZigl9toXlh1PRpNSJ+M
         tFnsc+LPUS03oXeDyXB1XmrNl0A622uykCwxkCU+iJgfAs/FLvZXV+MrG7dzqXZ6gb8W
         XaRKy0gsZrwyRK9n+Sq69JESaqTzbKcO7WyHPm7PCunT2LuVigtrp592SrtHIE7CnRup
         RfGyemED+WVBRVidOV4NH7XA9SaLAZwAnyVCfM8omALY7poSDOHaMR2R25Y+aNrPS6t4
         fRAA==
X-Forwarded-Encrypted: i=1; AJvYcCU8kYoKpVEy578jB0J8i+v1CgOJswuli54HRv7HzeQ2qA78ydWSWLed79L8W6eZUhHg/X9PNfLLgtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLpKq9bU+1dz3jJOSgmkY/yPISKHXJj2q1O9AjV3LQ+9XBEGjq
	tNSsvEz66LnCN2Bhw49l7O14zWirLZM69HDGAKqlatut66+CHMsqwl2eFiDBI48=
X-Gm-Gg: ASbGncuiuCdO4aJruDJcnGJRVOlADH3WE1NQg9Tt9eLGHRgdwSnhDLKX1puslIlssU0
	KorIifQb8Ui3pgqObpz3AxLfaD1PRi1bobebUR0CdKtSbM+FQSfnIrJsaO4oaz81n91gcjShcS3
	2b9ePu1ngbyAJFsFE64OEMKPa5I2bPO2yajSsItggNIKTV9c4+f0VygE6WZHNnCbz5ycP68FNxU
	XlkUCvTMDxOBGWQMZ25N68rNCyE+pDRWKao8cBP7Mv03seZWknwVKb59cvosr1eG6eMRt/8Sjm8
	NjNJBsIiLbK9tv7GvznuuEMemPJ09Ijm/6ZbeV+Nj0NStKeJjLb8vN8NGi15XobSxFkLUKKblv3
	k
X-Google-Smtp-Source: AGHT+IFGsDtBbBpM7Kh7Y6PtGlhqpD/wrlsOJSO5O3uOMFxSFNeRnF80ethVYmcYRI9leCtRh9D9jA==
X-Received: by 2002:a05:6830:2805:b0:72b:9a2e:7828 with SMTP id 46e09a7af769-72bfbf5c717mr325800a34.28.1742338345005;
        Tue, 18 Mar 2025 15:52:25 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb274e95dsm2191690a34.52.2025.03.18.15.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 15:52:23 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 18 Mar 2025 17:52:14 -0500
Subject: [PATCH v2 06/10] iio: adc: ad7606: use kernel identifier name
 style
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250318-iio-adc-ad7606-improvements-v2-6-4b605427774c@baylibre.com>
References: <20250318-iio-adc-ad7606-improvements-v2-0-4b605427774c@baylibre.com>
In-Reply-To: <20250318-iio-adc-ad7606-improvements-v2-0-4b605427774c@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3001; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=CAmnZs2wwABDFC9jlNwO8N4jlwQRTM6tiGxgYLL9RDY=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn2fkcKZdZwyfomU6danzE2GtoHRB3ZbhjsmKPd
 O1X72vcJk2JAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9n5HBUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAMoEQ/+I+kaqJc9/A5uB4ho+raAy+Dt9dUG3Up8eR8Rk0+
 n/apy7QgD9WJ+m47V82jVrbwrLHwhEtYh4QIj1wI7bUb4HaAlKIWx/yc4NZj0RfpdvizencAeMv
 eK7oUU1sfkFFqxLkiMxfq/HxYclvMJhjLKm8FUYltmwV9ePhU1BGmdS8ATz9nlVkj6/51iO4/z8
 NEv/2IPjiMVrerdKvgrmVUMvm9DFgo3GsM4bRU+TD5hx74UmGJbOm36b8dwTximDq4IE2EzFEdT
 9//0zqhfxbL+k4kWDorAqubkCAlS15lcCMIOTB3eAt/WMFcLXjMaYTEAKyLwhZgDV8KqdQGByaR
 BPUmbm3HYQLjZS4LPbUY0cr8v140E4qqMRI26vMf4EP74RboJFFKAMU3g9CbDA9b0eagrEgLQS9
 2jTGfM27uNdfucoRYhVSevYrhXPPWkQlYw9r5ByRZmbgVzYQFaWvTDX1uUFNZgXiLW8bgA22IOr
 dKSuW8ROlz90DQhj/t7d9fwjePUC2l75S7poZDbU1mkrpyo/dSAGaDSFED6AHZe4CTkaRtc/OC/
 YQabaYROR7Gh129/T3aO68moU9QN+2oPF+hv3b/EIe/g4oRMLSAE5iwZGF+JT4pgziB8tjT2lO5
 s1lj1zIFuvdnpGz2q5mmoaJ9LAFkmdw8J/i7yxVi1dZQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use lower_snake_case for the identifier names as that is the usual
kernel code style.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7606.h     |  2 +-
 drivers/iio/adc/ad7606_spi.c | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index dd4ae59dc59ab17e437171caf6d8a5abcce97f74..5ee04e8f4041c75d66b899a9371a75b5d0f31071 100644
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


