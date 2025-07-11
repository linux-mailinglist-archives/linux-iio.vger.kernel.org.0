Return-Path: <linux-iio+bounces-21569-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1E9B0207D
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 17:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0561892B4E
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 15:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75282ED142;
	Fri, 11 Jul 2025 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iYJTytre"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1DC2E88B1
	for <linux-iio@vger.kernel.org>; Fri, 11 Jul 2025 15:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248050; cv=none; b=mvYTYeS9QM5lNVLY6D83ixSuRrPeUTxvKs6ZBahYRwy8awvFpQ/F8OVQvMcbiuxb9TOSzsfbwXjjreT9+wfV37kIxV3I1idDRec1HoN7JdDZIYC6zHJf4m6fWSZ71c18pfYMcBKOBbCbeGd8cZzKUWcoChEnfhojNipY60jzeIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248050; c=relaxed/simple;
	bh=ebT2s7nXALqt6/yObzMeAm/ZCc1oP9CJhn5ID/ByeoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RK4L/j0tsVGIooBtRoukhEHKCFJQl9CAXmQs82RbYxVFYDuDCEoZzMAF4t7txzV9hPpwjzrclxIMaJLKdd1EWVIcyQty8zDFAmSPAy71cCWZxVsexmRM+Cq7lWz1r8inSs0nP9SUrjY3HW38pYkjYaHGZna1EvBDCMzf4wBEARA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iYJTytre; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2ef891cd058so1588682fac.1
        for <linux-iio@vger.kernel.org>; Fri, 11 Jul 2025 08:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752248046; x=1752852846; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7hi2TXY2tfoPRf/N/ueDW56lwyKoXrTU9bENTT3dZYo=;
        b=iYJTytreA0rCoV8SP3UalOtwOjJxzlXcTqUxoyGGIVZV0zJHXj5lshblYroLL7KcaN
         bNTCDRWoB7J1UQQX41s2FUOgpirpFFjM2Md344GfNRBgAFyHVy1VZeFymdl19XSj7edF
         MxUCf4MmJEu5gB4GkZIUoSNroKRhLWX+vjp68856i7K3CJx7pG477tfOZ582qZx5Hjfr
         uG/xBjJbCcs/U/9tnZsYN6GUV2wL2DZYB/CbIJ6HwJQSPfv57/ueP2OZmcoBWnMceeRz
         kdiwmHYzsT8H2k9XGwqK0qtEh9PXxX52RwhWUWRd/WyRmBVpb6oAjaPITgff1cIAIleD
         GgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752248046; x=1752852846;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hi2TXY2tfoPRf/N/ueDW56lwyKoXrTU9bENTT3dZYo=;
        b=S9ue/iB3zJOv0fO+ePVnkeqtnuUaopZVN2TGsKaiFVVjMil4DUxZ53DTnyZj7W5cJb
         uVu0UswSkOwk7mYe4uQ3bHIGz909cyiOfEGf5FmtfFN89CG4m+Bd1CHGfrFJPKKT8B+A
         JSXW/kPeqhbf65nKifgKXwhT0NeETvSytR/7YXpz0Fq4XwjTbap2Cd1cHJ3ySure4qtd
         y6iJDo2RkvtaK5dEnTE7kcNiC+xjnY7ZGvpLCvcGQPRlgp2sF8ITRloz0rJMyO2N/WXq
         WLTjJM2QQEMisLrsnwVmvZwyclS2nNJSCGMUKiZpEEBL7fWVKz2KJXxqFOtBKy8IKWiU
         SdHA==
X-Gm-Message-State: AOJu0Yw8+cYBmvW+dnHv/RrdZpaC4Txu9gi+WIyERdv/blDtAMjVw76F
	qR52dv2to600Bxha9Un8bJ7LXVJIuHeufkjmtUh/CXs2g407DvQLDyAmTvYRRh7ck8U=
X-Gm-Gg: ASbGncucYRCgN/X5C6ZU3JZIrLZMM+PBY90WzZh0VPQR2OAdgFyLGDUXXxx1uG6wl2H
	am3q8uefHebQCruzX1bcypg1IUcxTh3fxfi8lc6FiEqtM5vX2RQJHl4ZhuLOukuSzDPNctYS2Se
	MJCVdFm3IM46ONHCCyowDyi3ghUK8h2/+IU7igt5XOF6MCpQzpYeUApWUbo3TAhULFBwU55FxFd
	kOtYDcN/i3t8upQ/grQv+Y3L6JXFqDO7TjQlz560HfANgqn6p0/uD0Z/2KlJRdE1fad4m5xtX1f
	02MOmasYXNvFFXrjQDIvc0pf9ip/IRdbZr1snv79+75TVylCigh5FuqXVC+t21mX626eTOm9Myg
	wluI0scdDlC+Dw+XKKiWFORrRJGRK
X-Google-Smtp-Source: AGHT+IGXbaybHyhrMurjq2yGraWSmf6jCZve3G5yKDCAGdsvXXoxzSSFfEyknCjd809K9bkPjCWepA==
X-Received: by 2002:a05:6870:3e09:b0:2e9:8ed9:16fc with SMTP id 586e51a60fabf-2ff26eac21emr2616277fac.11.1752248046558;
        Fri, 11 Jul 2025 08:34:06 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4601:15f9:b923:d487])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff111c36a0sm762348fac.2.2025.07.11.08.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 08:34:06 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 11 Jul 2025 10:33:55 -0500
Subject: [PATCH] iio: temperature: maxim_thermocouple: use
 IIO_DECLARE_DMA_BUFFER_WITH_TS()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-iio-use-more-iio_declare_buffer_with_ts-3-v1-1-f6dd3363fd85@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAOIucWgC/x3N0QrCMAxA0V8ZeTawdriJvyJSujR1AV0l2VQY+
 3erj+fl3g2MVdjg3Gyg/BKTMle4QwM0xfnGKKkafOuP7eAcihRcjfFRlH8IiekelcO45swa3rJ
 MYTHs0BN1pyH2/ZgIau+pnOXzf12u+/4FEksheHsAAAA=
X-Change-ID: 20250711-iio-use-more-iio_declare_buffer_with_ts-3-2cc387a66bdc
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1723; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=ebT2s7nXALqt6/yObzMeAm/ZCc1oP9CJhn5ID/ByeoY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBocS7msivCC30zn1X+Gu/q9gRTPYZ7F35T4whGE
 IXSZg011mmJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaHEu5gAKCRDCzCAB/wGP
 wEktB/49NdsstQvtK9AX+6VglLicdjumTe23CFtB7TSZO/kAQ5HQv0wtejfGPga0imk9oydYhKl
 IEh7HTAXtU2IkhV+Diu4D4whrsnHfrz+cdx2q1NRsKwa7nPiv4zZ++IUWLeo7AoV+gzLJdPRZRt
 bzIGL9CJ0oimZ6kH4lfCEUHAcv5d754CkK5oaJHldDxmE18yUkApEYKioU2/s6wlmSDJ75V0wbu
 lj/CfzjQ2V4Or2GAW76KauC0wumD54BEFrdciW/AhLINtjzyyLrdc/9arZ3+Uq8YiEugCkZNSH2
 na/Zx2CCmu67rxDeJFejDoSVZA9dtFuKb8+6W/ApZseI5XcM
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_DECLARE_DMA_BUFFER_WITH_TS() to declare the buffer used for
scan data. There was not any documentation explaining the buffer layout
previously, and this makes it self-documenting. The element type is
also changed to __be16 to match the format of the data read from the
device. This way, the count argument to IIO_DECLARE_DMA_BUFFER_WITH_TS()
is just the number of channels rather than needing to calculate the
number of bytes required.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/temperature/maxim_thermocouple.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index cae8e84821d7fd521d59432580d51def939fa4d1..60eaa8140d3e98e10c073c8d18cf01524b1c1816 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -18,6 +18,8 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 
+#include <asm/byteorder.h>
+
 #define MAXIM_THERMOCOUPLE_DRV_NAME	"maxim_thermocouple"
 
 enum {
@@ -121,8 +123,8 @@ struct maxim_thermocouple_data {
 	struct spi_device *spi;
 	const struct maxim_thermocouple_chip *chip;
 	char tc_type;
-
-	u8 buffer[16] __aligned(IIO_DMA_MINALIGN);
+	/* Buffer for reading up to 2 hardware channels. */
+	IIO_DECLARE_DMA_BUFFER_WITH_TS(__be16, buffer, 2);
 };
 
 static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,

---
base-commit: f8f559752d573a051a984adda8d2d1464f92f954
change-id: 20250711-iio-use-more-iio_declare_buffer_with_ts-3-2cc387a66bdc

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


