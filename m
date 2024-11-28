Return-Path: <linux-iio+bounces-12799-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A27EA9DBE1A
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 00:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47FA162E01
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 23:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0FE1CB307;
	Thu, 28 Nov 2024 23:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cru8kqft"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5C31C9DC0;
	Thu, 28 Nov 2024 23:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732836310; cv=none; b=aYHUpqkRQuEElXxglAfJsogtomjFXI8o0lhXjqdPp1Ab0eJkv8RcBtPAnL1HLiQjvXp3XjU8y/o67Z3+gKd1OtJYNm6N1cojfZdNFPJ5yglsnqPdvXdwJbhVS2/Uev390owx8EU/iyU6WtjOecmDVCE0/YXZxCly7w6dEt++uoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732836310; c=relaxed/simple;
	bh=yCz2bEMANU8BAJI6d7k4tpvF4CtTd2lE9JWwo2Rul7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDP1OLn3awWFCFWYXa6IcODSemYp2sOQmyrT0zp5Kb1H1Q2uIMoT4bTV+0WxoKJjbfp5cVryfLjB924CcCIkqq8DwgkMtG5eEP61uwMtWnHsYp2rFuSBymYvfDLILXBczipgjgXzPPVqPa3XKk1vPXIFkNyLs8jvBCuHMCr8sg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cru8kqft; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4349fb56260so11378465e9.3;
        Thu, 28 Nov 2024 15:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732836307; x=1733441107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62cOZRybRIU4PTMZ+LDcmP89/ORe8vWHVhtloqqzP8E=;
        b=Cru8kqftZRiKsBTD5oq9wISfG26JieiTYraDfoDVhNPIzTTkaEsNRajHLGpPWoagQE
         oi8FEdfVhz6TlZIkg04+wMVaf5a46XaZeD5d52cCRcdhngkV4ebV6XY93K01m/6UQj+6
         ydwb6O+H3dOv9SlFIGkPaKjxztlu58wwH8m05tcXTkz9BrtjLDnThq/3W3hY1gSz6KsQ
         7lCfWIl2nO/JVXX1awtW5/RqPEW7dN1T3CtjcWit5GlIFA+RLaEFKPHTXufzaD66QVQA
         ++kCV9ghwqqX2+7wgOVUnqN1chNmZgsls/vJ7EmKB7WavK8WO1kmcWNFCQ+y1gv0d+sv
         MXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732836307; x=1733441107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62cOZRybRIU4PTMZ+LDcmP89/ORe8vWHVhtloqqzP8E=;
        b=VncFB26DSNbmsJLwGg1NnR8QZKCtCIfw5cxoOXo+W9xX64bZHe1azZVnd+iJ8aznf6
         qkdzHvzSZB3Zui6Sbj2Dm1DZdWms8YyZaONvSl1Jx/IYtTFfovjsUg9rTjZzF9jNQZsK
         BOOI7xARM5rb9vVO0x6XJ7oB/7zTRSfcK+5L/LFwsqKPk2/4qklK502MGGB0kDFEyr60
         ubC2wVM5EjMgNBiWw2ZI4leQaWRwatI3aHvqWOlOArLM0qhS+xqe4QtSGuRtT+Gulrod
         FxqgWkWFoIku8yr9CsDTxvWGtOuAarPurdYMvwn2/0muYWI+FBevi1P26E7drVz6cQw/
         AKTw==
X-Forwarded-Encrypted: i=1; AJvYcCUU7fJBa19AvKLhsgu0sn29G1O+2M3RmZZzqx+qpo71ZgQFx9hwfemuQHw/DPJmOUUnw5e0pxpUY7UI@vger.kernel.org, AJvYcCVqJByKz8mApy+jytaQ+YMs8LG0wYJGWwWspCD1c/IcvhQjPTVxQ8Wxgbk26AyNaQWFdl0WASwr0VmV@vger.kernel.org, AJvYcCXhSGKA2ZLAf1L8yHDO8UUpo4IiPtosCfPzranqgHpu7PY3Q2uSZ8MvDv/BqVT5dLgeoictIK/dCRdG30yE@vger.kernel.org
X-Gm-Message-State: AOJu0YzjvpTlc+C30Q2mfPo+ffh/obJ+CqoRHw7HZjwbBR4jbExyyIjQ
	9emKIs+IWq7mMKnZEJ/t7n8WtbaS3kihKwynuVDBPnu/U/MI7tfn
X-Gm-Gg: ASbGncuM+N4091i0YhDj076F8BJj+OYWUW8BsfSsZPUTgiRWQtkG3wiJTD4H4vB2i0d
	cyhysPaiiqHxfaaRHd/FOJdia435J9yu63/XN6nN36BBA6kFJBx0OmOLkArW+ZRCTYB0/ORXefV
	I0DGwP6oqIFvueKymZazF0Wax9XSP1wI4DAMc341T84pZKouqaaiZ/QljfO0M+f7mGh8ot2mzVp
	cvTgMh6drnTi+VnesR9qNZW/YXb8JB/9D/QvyxM3gogHo7JtmmZMmTq2/vwVDs=
X-Google-Smtp-Source: AGHT+IFASptjQfdTDZ415F27fC2FVT6lRlq6Qx6ZmtK0KECj9jnPWy+rEitFHQ09t3B5SqXgEdAilA==
X-Received: by 2002:a05:600c:4fd6:b0:434:a781:f5d2 with SMTP id 5b1f17b1804b1-434a9db8483mr76848245e9.5.1732836306513;
        Thu, 28 Nov 2024 15:25:06 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:a8c6:c7bb:87d7:66dd])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-385ccd3690dsm2765594f8f.35.2024.11.28.15.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 15:25:05 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: ajarizzo@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vassilisamir@gmail.com
Subject: [PATCH v1 2/3] iio: pressure: bmp280: Use sizeof() for denominator
Date: Fri, 29 Nov 2024 00:24:49 +0100
Message-ID: <20241128232450.313862-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128232450.313862-1-vassilisamir@gmail.com>
References: <20241128232450.313862-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of using magic number 2 as a denominator, make it intuitive by
using sizeof().

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 2df1175b6b85..a3631bc0e188 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -470,8 +470,8 @@ struct bmp280_data {
 		/* Sensor data buffer */
 		u8 buf[BME280_BURST_READ_BYTES];
 		/* Calibration data buffers */
-		__le16 bmp280_cal_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
-		__be16 bmp180_cal_buf[BMP180_REG_CALIB_COUNT / 2];
+		__le16 bmp280_cal_buf[BMP280_CONTIGUOUS_CALIB_REGS / sizeof(__le16)];
+		__be16 bmp180_cal_buf[BMP180_REG_CALIB_COUNT / sizeof(__be16)];
 		u8 bme280_humid_cal_buf[BME280_CONTIGUOUS_CALIB_REGS];
 		u8 bmp380_cal_buf[BMP380_CALIB_REG_COUNT];
 		/* Miscellaneous, endianness-aware data buffers */
-- 
2.43.0


