Return-Path: <linux-iio+bounces-12844-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0340D9DEDD3
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 01:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88ED6B228D0
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 00:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DECE13AD3F;
	Sat, 30 Nov 2024 00:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSJoHTL8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A827C136671;
	Sat, 30 Nov 2024 00:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732926457; cv=none; b=E3hPbYwKuoiGHSYTGxjRskOU0txZzc8gIBCaZPoTTy859DvwI6E9kehMgtp4MraETxC86EP6o7jPmisp6NALySdX0H74lq6nrT6bhRBljhV+YkegnvHGYgCSJBWXFe1PMNL/GrGl3us0rwFVsFASMUzAIAyKg2/L9EPcvAC7SyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732926457; c=relaxed/simple;
	bh=02QdyCX7x4jDMJ3t/IjMhAORjnOpXGujKs5X1hTXblA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjVeH+usgdnmQWg8d2yudO3tqIy9u8e3gOIEQ5JCdsP9NWWNv8IjoVBHO6r7uIZBmDCRJAXg2zXRQb5YDHHDngqqtfhwei7V+jzreXxa8EJIfC1psuzj11BE8sIt+i16ZSXHz2Z+NOsFpsM8bPqlxVHb01/4X6srGZahUznqW4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSJoHTL8; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385e35912f1so136323f8f.3;
        Fri, 29 Nov 2024 16:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732926454; x=1733531254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1JZkG+mRXjADgwPZalzjZmjrMf0Z2/+XZ6xVW/L86M=;
        b=LSJoHTL8O6SBrL21Iq3pv2uhgfJ79/AU1ABqTePXTzeaX/FFj+uCILaepK/bMZ/zO/
         MP/bTXiDWsUvY23FlohItddpH7N7IckM6qjaeIR87B7pJ/KIz8RPu7h4pCUSjkcUPDRx
         O4nGgprPxJXG0JuHlVcW9RY0VTrcIUW3O5l/F2B9EEu0/PBcYMoxiUZ5Khy8sj3ZeFpR
         h+9ktSmESLtkSPrRX6SaANPfj2e2DWtQBah0Ke/1vM1H6rkEW7+GQPZPPe/aBqiil8IG
         DWW7lG2Ujk+mSpM4PY6fOfxW/sdJuTdx7r3/+4ilzwLjhpJiEQgC1OE6NOKmyGJlnlEN
         4KiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732926454; x=1733531254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1JZkG+mRXjADgwPZalzjZmjrMf0Z2/+XZ6xVW/L86M=;
        b=BfS0et9W94KyDRBq32guUTtI3CstOnaJcu+V2ictZhH+gS4AEWc0gqK30DggBXFvT2
         Fz7DFbAGf2PuNP7xoM250q/Ax0/ypXLdMY60AH1Lxy2BlZFkJHo02Og6TzVPPiuCusUK
         z4vpVXPMq0A7zXumT4gB/VSgRrrZtKiOQQ9W1V+ey2mvfM5sU6zl3K4tHDUNYTK4kDx8
         xwRw78n5j9bgU9WKyiCEx4oGhzBV0X3AqfftcDrwBGKgHwXLaiXnbNqqpzzZH1jQo7au
         817L8f70bsPkSEPDFqy5a8pajZhB+tEK+Wm/NI4cQ21TVLdN0vaZrNH6/8AS1yCm70eO
         NwDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS4nLbfWGLZCoNWl7Gx2j1EFAKPm75pvC5Ab2xUV/U7yGibE6e/ybfi3nK0EqKjf737mPv5Uzapjo=@vger.kernel.org, AJvYcCVn4DuxV7qNGaS8Xoep3k4b3sPUy+d7iezG5pvkDiyCjmTQ0MBlYDMPuNr0/cm6sPkSAqYa+2bsCuoOTarG@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvijz/2++BpF3N/TCYXiasGSrvkHYp+q/lvfzIaIKOaLjKdAn3
	aqkeH8PlwokeViLMmiwCkS8B6CK/VR5Nb0v9pQrGI0djxaulLpsu
X-Gm-Gg: ASbGnct2xN4yKJ/Ae2S+kYNC8DJ/Z8M2CshdqfaRgA4fb1/doDHF1L3fGh2ujpNB0xV
	ftOH3Fsi4fIelm985gEMjKUl2K/yLM6n/rH66XTiv5BlKF+VH9j6Jd4IAqSlCpP5FZiZC92uqzK
	s7CzpB8TwZw9B96niFc1OLYWvyivOtrfYCKZygMTwBuZy2mAYPiRyMtO9T88JoBo9lbbHqQGhQ8
	18I7uRFwHSptPMrEPccIntZpnMyT+5d10c/3R3HrcmYdZl/x+qCFKz7Br2vqA==
X-Google-Smtp-Source: AGHT+IHj2f+0FlSnxxeMcSa4wwwqZ64CRZGfxYBSVQEdU3y1cktiyvOZaODwPtD6SHkVSx06FIB1Tw==
X-Received: by 2002:a5d:64cb:0:b0:382:4a9d:28fb with SMTP id ffacd0b85a97d-385c6ee12c3mr9060909f8f.49.1732926454079;
        Fri, 29 Nov 2024 16:27:34 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:2250:4c83:a8d5:547])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-385ccd2db43sm5873345f8f.7.2024.11.29.16.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 16:27:33 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: krzysztof.kozlowski@linaro.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	abhashkumarjha123@gmail.com,
	jstephan@baylibre.com,
	dlechner@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vassilisamir@gmail.com
Subject: [PATCH RFC 5/6] iio: common: ssp_sensors: make use of iio_is_soft_ts_enabled()
Date: Sat, 30 Nov 2024 01:27:09 +0100
Message-ID: <20241130002710.18615-6-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241130002710.18615-1-vassilisamir@gmail.com>
References: <20241130002710.18615-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the iio_is_soft_ts_enabled() accessor to access the value of the
scan_timestamp. This way, it can be marked as __private when there
are no direct accessors of it.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/common/ssp_sensors/ssp_iio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_iio.c b/drivers/iio/common/ssp_sensors/ssp_iio.c
index 88b8b56bfa51..c38bf1dfb7bd 100644
--- a/drivers/iio/common/ssp_sensors/ssp_iio.c
+++ b/drivers/iio/common/ssp_sensors/ssp_iio.c
@@ -82,7 +82,7 @@ int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
 	 */
 	memcpy(spd->buffer, buf, len);
 
-	if (indio_dev->scan_timestamp) {
+	if (iio_is_soft_ts_enabled(indio_dev)) {
 		memcpy(&time, &((char *)buf)[len], SSP_TIME_SIZE);
 		calculated_time =
 			timestamp + (int64_t)le32_to_cpu(time) * 1000000;
-- 
2.43.0


