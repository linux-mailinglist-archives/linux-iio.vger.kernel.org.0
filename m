Return-Path: <linux-iio+bounces-18210-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E49CA9231E
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 18:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0338A1767A1
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 16:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0352561D7;
	Thu, 17 Apr 2025 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lOiTv+Uv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818392561DF
	for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744908831; cv=none; b=ESM9p4MjO27iZ5yZ8TzfJPUadrX3VSxJVtty6YnGiRpdU2RLw5Z7bW9s0BS5K76kD8iaXOtVkHB41GS81Q28cVM1K47U4vnIEpzfu6f+DPswqUbLEyIHiZkVP8FehEaoCLVOskWVlDiylGTWtm01530WXVJZI9PCWkdiHuwwJpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744908831; c=relaxed/simple;
	bh=r2Lf6V871r0X8NFwArauQL/aP2ip9vu9Z8iRNi1+BAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VGku3SIfhWfC8mj9B+6WzLlyBdjVpnh9uLT1zPYeojha0amiJgW8tqJn5Qlm1AtlL1B0VEokyvDt78xe/5w3khslyQd42P7EdUlJkf4VS4K/BeqNDfxSIRlenEP2a3HXqp4/NjyKh2GdgKy5WLHcsNCKfF9Cxxc9kBIPCmcJB8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lOiTv+Uv; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2c2bb447e5eso517644fac.0
        for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 09:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744908828; x=1745513628; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9S/SvzijUhAxaY2WkAr6cvZfGG4Ius95xkJsmSTFocc=;
        b=lOiTv+UvUHYpAJBGzONlHmDOu4571hWnaUefOA2jYzitIMUm0lZUGH3fU+uN1GMS4M
         VtXFWdlneZWjEDCysw/V6QerTqT7ax06cTDXvDVlmvsUYbc7aG0uY/C66rIjeUjUr19r
         x/MPZsPm0AhWgZnzO/NXsRac/NgNcYs12HA//yLivKzx3EEs4OozepurYS6lPwMUJxHu
         bRS5nivTB4pYlC2ruuxVRa666HDTLJgKO3Yzmyignw/GOrpLDrAFS1Vunzsl+DsgyDRC
         XIH7pAX8J9FihvPHCVKJ5FMhZ28oI4DPq/ILu93zrKzgZXIEEu6fbEHlHq3aa7ynZ1lW
         fDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744908828; x=1745513628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9S/SvzijUhAxaY2WkAr6cvZfGG4Ius95xkJsmSTFocc=;
        b=JR/JBOpnuopUmHm1DrjjowGd2MYXPEUizhH8Pud5psh2nht7SsXgHs2E3ZOLtrveEP
         9nzikAICIBE9fVdPRRxGOwjHIrCmYykGpDCc2BVYR5UoUp/y7XWk0y5emyCIZ5sKCzr1
         Av+0kmRkj/g4PwhCgLbBtuDQeCDG5ZY02agYfIn/f3kro6DcxUaNlxF1WSLKoPQUxqU7
         crpXwc+cSGEJ7GNvHb09GyiSVO84B8Ocf5H46js0idT05d57jHsygMVePIa/po9v37Rk
         XRNRwm00foT3s0SgEfMjF5zyQ/FLofwiOdCeABv3baatksyxSh27kGz5h3hA8TF/P4vt
         6arA==
X-Gm-Message-State: AOJu0Yy3qSvXExIVtCVhkakOGrZqSdB8tgy21tHekbSiChQtu//DFzZh
	9jJmzFsq0eAs6MFH64vgomoqnyPGrWehlSPo4RYFwPRpOkwZKiMdRCoZWLzDfAfAEFJDwW5sS30
	kmFY=
X-Gm-Gg: ASbGncufwOT2TIgJOUhYcxYht8escwucgOX0sIX1IXQQ5GA0tsAVmU1kVmX0S6cLgWK
	XBJ6HWpIT0Uggtae07EUSvXq0JQ+oOpUshnbMGY7vFdBiqOFP2iNsdyutcgLZ4g+0F1WeG8Sl/l
	XA9KJoIQ283CAkvv1LUxrMcKM62+FWx/vqvE2X9rLWkSz2imN18XgVxPsV6iuETABM11H/rRQJP
	ESS1Cptp2XGowV/aN63mEGw3G8BVnIREZmfAJrRG7ES/mKtcXXqU51yNty4UDkfOmGqCiI7y16P
	/wqqQePVWU6aiZILeh3eFpK7Qliyr/KMfTOu4WePhhQSZq8=
X-Google-Smtp-Source: AGHT+IF2cc6nvhloIatR296bKaZ80w5oIIi+XgsIxUdwxJ2bRiFa0lwjx2pRXiLn6TVPGEuHIrcesg==
X-Received: by 2002:a05:6871:aa10:b0:29e:24c7:2861 with SMTP id 586e51a60fabf-2d4d2aa5915mr3876098fac.13.1744908828514;
        Thu, 17 Apr 2025 09:53:48 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:c91b:eea3:7afd:2dee])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d5218248b7sm15812fac.47.2025.04.17.09.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 09:53:47 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 17 Apr 2025 11:52:39 -0500
Subject: [PATCH 7/8] iio: imu: inv_mpu6050: align buffer for timestamp
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-iio-more-timestamp-alignment-v1-7-eafac1e22318@baylibre.com>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
In-Reply-To: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Tomasz Duszynski <tduszyns@gmail.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Andreas Klinger <ak@it-klinger.de>, 
 Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=865; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=r2Lf6V871r0X8NFwArauQL/aP2ip9vu9Z8iRNi1+BAo=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoATIA+teM+VsDaed33qq9DGEWH0kyRosXw6BwA
 FFyhafZOMSJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAEyAAAKCRDCzCAB/wGP
 wKsAB/49x03HWwW8kibDISBd6Ld/CibPThaqCLxFDvm4mQF6Lwdkjzvmy0QtIyU0hwRJG2fl+Lh
 4pIf4SyMG/WlJYZzS2R6JHm1Dm/WhAw2FYk/K4XAmzvakOcJDp7frIcgxKMgIiS03ab0WkHktkP
 e4iQNzBwOC88d06nrgETtFhtQoZ8nyU6wPWQuq8RMQ+J96hkRf3QYNT6XnuN6j2nFuDNHysfKDR
 RwSoR6I5TUGwsJiiMEIpykJQUvwfGiQpFkxOdvDy51nDD4Izr18DudobB0FWvxwiIC086FaF5OJ
 6kkLPmFBHSgFMmXXVmHKRUa1AJ8QDjp/Iw3muuNM7vA3a9Pr
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Align the buffer used with iio_push_to_buffers_with_timestamp() to
ensure the s64 timestamp is aligned to 8 bytes.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 3d3b27f28c9d1c94aba93678261ce0d63099e1dc..273196e647a2b5a4860e18cfa34a088c773540e4 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -50,7 +50,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	u16 fifo_count;
 	u32 fifo_period;
 	s64 timestamp;
-	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
+	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE] __aligned(8);
 	size_t i, nb;
 
 	mutex_lock(&st->lock);

-- 
2.43.0


