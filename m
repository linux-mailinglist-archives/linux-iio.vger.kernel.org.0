Return-Path: <linux-iio+bounces-21079-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFACBAEC98C
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 19:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD143BF35A
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5466A2877D2;
	Sat, 28 Jun 2025 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ReXIuk+F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337AF26FD88
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751133181; cv=none; b=dRuHVJllkY0rAmkugksOJ1Yb4x4eoTSdRCtMHExuZw8/z/Q4Meaf051Y0mT4fXi6olYbdCg5smPN3BRr7ilvLPtfCK1m0A9uFcCUgfbdh0wkKQLM9SR00YoukqTQyfCTGBBKejtqTzy8NmXL0fTVreWqZcmIqkfF7uZ09ZBKblE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751133181; c=relaxed/simple;
	bh=7PWpuEuUAR02Zc52Tm0NH/qgWVIEjwmy9AreWIhhoM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A+Bbqh6AM3yb1D8R8LB0TCl/t+Vt/TPKYuwp47014YNpr3We+/dCrPIBCjtir2BgXyjjzSaORP4agwXRmadvW88lKg/Gs4dCJnkIef7nHY0xuxJwj4zUTuaJlsRg4HbCQ7Mt69bbWiGyfpXVn2P0S2Ycqmk/8rB9DNWwtKNBcr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ReXIuk+F; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2ea65f5a0easo1848005fac.1
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 10:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751133177; x=1751737977; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yyTYXSb0JKXvcs1f1KFZOGpILpYpb2Em3iNzt/vn/qI=;
        b=ReXIuk+FiNwlGP8u1+eynDt23qCkc5ENB6r3oiK64i2VxXtID8dtRoFAQgQAFu8VLD
         lmdSBJJcSsHHSQ2NYMn0Vn7ANtBPnW3nrPtp44JUdEA93tIwIhnDL/mQvrjA/vmVzJ6/
         y2Nj/tGe2yI0zJthWw7Ng0JZAaloVs8mMoPYglUtGgX7QoemXWklltuhEoALYp8StJ8d
         4UjBsWi2BH1E6GyGBsLCINaP6S9otNTZ2fJEViW3Y4SylUkBNMV3brfawUnLbHrBF3PA
         8onheS33+V8J97yyahbqQkwPn/bDswnFUc4R4+O3U2AUl8Eii2QIVYVTeQ73bBgzTnxA
         QMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751133177; x=1751737977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyTYXSb0JKXvcs1f1KFZOGpILpYpb2Em3iNzt/vn/qI=;
        b=O4AFB1fHfEQGo6G0sfWxhMzGOV/i6Poxw6A3UfnLN9SQysqeOeRChhf70UOD4u4IH6
         EtKXtVUpaNhKVRdMBfdsMDdjG2TJd/KTkO9ntYqyjohLCTPIkTyjURLyxA9zIs+Izr+9
         HeUBX1nFIZAairTaZSsHqhB83xsbmdH6OdMFBYPcOyt29rpVeljWRwkiu7PSoEHc+6iA
         DGh4i3rv6Qlw16nXKKzDokKjt9/n+TwOYdN1O9LfSs4XWW5/Pz60d9fpweDlFrGx8J2u
         s9IMcuF8kCLSvJ8GdM3JAJgukXKNfDhpkQif10ya4mJr1w3orKxt8MGQzMDFYdatqlZX
         MM3A==
X-Gm-Message-State: AOJu0YzDDDRMpdahK5bqMFQS6RLh2EFJE735tRxiFDFGlAfE5yELRMVK
	KoG1U1Xr76Fuu1Fs2ksT/gWuBiIdXpwCxTUh6B7m0Tx8nJbQFwuzr5FfPX8WRYIu/1g=
X-Gm-Gg: ASbGncsoIUI40pGt80Uz4KIvkTA1ubF6Tcl+Gb2BQzORUsujalz1GdPIqVkO0HD+FWM
	6iRziLRX4Ca5OrwB89yOa3q0iVTJRb7yBVAdhR2sl2dDn9d7qHM6g3UAepqSFgrOZkIfVm/b34K
	qHk74esO/rRTnnSELml3XnRxBGFZxftdhJ4OD5YZrz7Mj8KkifovMXe5rMcBDUVp+O+JUAjw6BV
	SiUCTxzwIdL7ecCi8uije+dHO/WYVdQpZZwSpOSHnMpErCrSROvJWiGVpsk534a1BSVUTxBZdGy
	6ZVeUO4ahl1j3Z9Kxp5klVSIyjcjKWFrEOJPqAtT6KadC3XZUtHEEeZw+ugvuS6ludaz
X-Google-Smtp-Source: AGHT+IE2sqyL89nUi3xpEnV5UrwmEcMXOrE0zfZYir2RxeiYPi4H5hWHDJc4RWHFIQ7hzbJ9wYDVLg==
X-Received: by 2002:a05:6871:71c8:b0:2e9:8f40:9ea2 with SMTP id 586e51a60fabf-2efceeb94b4mr7838504fac.7.1751133177215;
        Sat, 28 Jun 2025 10:52:57 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd50b4d84sm1593530fac.23.2025.06.28.10.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 10:52:56 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 28 Jun 2025 12:52:31 -0500
Subject: [PATCH 2/2] iio: light: cm3232: make struct cm3232_als_info const
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250628-iio-const-data-20-v1-2-2bf90b03f9f1@baylibre.com>
References: <20250628-iio-const-data-20-v1-0-2bf90b03f9f1@baylibre.com>
In-Reply-To: <20250628-iio-const-data-20-v1-0-2bf90b03f9f1@baylibre.com>
To: Kevin Tsai <ktsai@capellamicro.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1448; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=7PWpuEuUAR02Zc52Tm0NH/qgWVIEjwmy9AreWIhhoM4=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoYCvtwq1KZais2IgqJBuBMO31skW51jTIItbcz
 v1Fa9DINMOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGAr7QAKCRDCzCAB/wGP
 wOBrB/9jhalDH/7TQ3R694lxQ2BsxnLQs9c7X0+o8iS9iOTGcBGJJRKMUC5XG36u6MJfi8lvn4w
 fv4w4Kv9KnNvTYKcWuK8FjBuD19yaAuo/GXTe7oD2lK5nLdxU1AxIUGVuhedidmL26QB1bkQrUo
 xTvsAOBJUHPNGWk8ImypiGtUWKUgZPdC6ESjPIZnk6bkwSXWfXptm/9vhCcqU9AjMx44gTxDY3o
 +kThdoKr6aeP0i0nMCs9T33106mnf0aBQ3rv0f7gNCDxm8DvcLrZTnJGFY6UZtv5s/pxxtiX4v/
 bBkqrZa9L0kcLvY+YpK+HkKwMNZTexmZOohUalnfIgZ7Bn8U
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add const qualifier to struct cm3232_als_info. This is read-only data so
it can be made const.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/light/cm3232.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
index b6823a5a0860a32a65b6e3e76b4e22bc9cd14312..3a3ad6b4c46860cb401e8084c47d3abe1f3f4169 100644
--- a/drivers/iio/light/cm3232.c
+++ b/drivers/iio/light/cm3232.c
@@ -58,7 +58,7 @@ struct cm3232_als_info {
 	int mlux_per_bit_base_it;
 };
 
-static struct cm3232_als_info cm3232_als_info_default = {
+static const struct cm3232_als_info cm3232_als_info_default = {
 	.regs_cmd_default = CM3232_CMD_DEFAULT,
 	.hw_id = CM3232_HW_ID,
 	.mlux_per_bit = CM3232_MLUX_PER_BIT_DEFAULT,
@@ -67,7 +67,7 @@ static struct cm3232_als_info cm3232_als_info_default = {
 
 struct cm3232_chip {
 	struct i2c_client *client;
-	struct cm3232_als_info *als_info;
+	const struct cm3232_als_info *als_info;
 	int calibscale;
 	u8 regs_cmd;
 	u16 regs_als;
@@ -198,7 +198,7 @@ static int cm3232_write_als_it(struct cm3232_chip *chip, int val, int val2)
 static int cm3232_get_lux(struct cm3232_chip *chip)
 {
 	struct i2c_client *client = chip->client;
-	struct cm3232_als_info *als_info = chip->als_info;
+	const struct cm3232_als_info *als_info = chip->als_info;
 	int ret;
 	int val, val2;
 	int als_it;

-- 
2.43.0


