Return-Path: <linux-iio+bounces-19658-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4024ABBADC
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 12:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AAC17A6819
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 10:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F9F274FFA;
	Mon, 19 May 2025 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cVNYfRjG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1CC27467F
	for <linux-iio@vger.kernel.org>; Mon, 19 May 2025 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747649737; cv=none; b=gNRI1zISFqo4NoKuZMGPSTi0NMPr69cLnsMEcfgdJJ+pfnaEMX69MrkS3A4VUbWxiRVdZ2TnT9xTFEfm9UGPNIHq48rG6rTOm+JKSSJ+4c/mJk3tI8bYgOcu/cF5vPkfXliUO4KyfjmpbU5YcdTNgKtOXaiog3B5c1hHc8TR1Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747649737; c=relaxed/simple;
	bh=8DecWNX9a+g7ci97Vv7IU6U85+eTrGoiJDNqhMLAwD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DBawGTMjaJnRWClFbk8dkrRY7she57F45abgtlxNQ/KBrckpVDWilV5oBVaXHo3Lzp0Dm7Z9BECycgQOkIDaJbK4MKF/pwWwyYpwQ3imgi7viRtx5vncT1rK+BkWnOPxmYJmTySsGDG0iYdGeMZXxNyIjncKrIcbqJoG50aNueU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cVNYfRjG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so33357735e9.1
        for <linux-iio@vger.kernel.org>; Mon, 19 May 2025 03:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747649733; x=1748254533; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQIoahuutc2qqjFxwM4CJBJC7cg2fQ/5cUj9Q0XSXuA=;
        b=cVNYfRjGHwE+IhXCTshTb2X469FlAdjpiAk5Fmf61Bok9BOYZjqQveTbSA7+hBYxeL
         ce2h/i9kZyXNRPsMZEZUN0P31DAzHsHzkCMHoEi4Ygp6LAq5UZnCRCc/sVkBgDkBeRsY
         rMafzZa4KvXTYCsBmj7Fi+mTKC9d+7dntA+uZNOQFqmHZsLDfNFQabfdnQOpe/+Bd5vl
         5zstXH3PiV8vsYPeTm+bIoETTdpctBDgKaXzjm/q9wHNVmSuqTfW8PzeAl25/qRgz63w
         QTJ8aZxZgau8zS3RgeKsS24CF+aXnmzGAJRolhj0DXnwDz00DVeuAJTqv6pn2VRk/I1S
         CUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747649733; x=1748254533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQIoahuutc2qqjFxwM4CJBJC7cg2fQ/5cUj9Q0XSXuA=;
        b=g+LRZ8thCkJQa6RAB08o295lGeIBLXOXqZzuTnSZ87PH6Qvu0yQXY9jJXBBJnywT3E
         GKin1v1lVfgU072Y/DhFXqHnngCQPK6O0Pndn1g/yrafR5+cSkCsD1TWsyXJLfQy6mNE
         IoPJwSqphJKtj1sHRuSw/DHmbepe4iw2bYQdegRyj4oQmR7BAefYikGrTojJaaHTm6Tw
         crsIeHf1yxknCSVmx4vAf6GyKPvV2tu/USl1oZ/Gk2K6Qamhu/FH4M/fGgVAC5zwA1hp
         Rk8CIVwtWEZkd26uhrs7LCHlhHVgYn8N1LDaVC871cH7YMSCD/6qXMM5vpOuuhZhLGzx
         DpwA==
X-Gm-Message-State: AOJu0YwoH3lJ2uUz+hPrQxq/9t6IbTz9qTvkcFIMO2efitvbaZEU9RPT
	xtbWZ18ogdUcMwaJI/f0zwb2csUkLt88V6LUgZPhnzx7KAnWvkdjH9K3j0yvd8ZhPR4=
X-Gm-Gg: ASbGncu1NO395/RRD1d7jN+w+/rhDOOuuSzMx/D3Ogi7WS/h7I236gL6LxZF+baXO0A
	z43PdcvXGLFyJG9YqMpMt2Vi5lptiYgCi6rBD0MjuVmyMofAryNm5NoJ/oCflmg0dRGsPHeJr1X
	oq1peSwbGnkdZxvxjbfVRVHKnTCHtZqx/899UtKS3DQ7YbrsXovBaRL1WXs58YjmBCwTUZ6LNdN
	94lBzv7gwmMAJ9x7KhdKSq7w5dljHeoMGZOzxZafX2bTEILQZ8c/EU5l+M92UvcpHLc6BTL55BX
	r7sX/xQYpgXvMa2Z+ch/t6JsCxoVdJKGZHD6R6HyWZoRMfneUospGU/fHNqa0oKBdRG4Yku+p5H
	VDtiVPyAF9qJZtavbyFvEDL5HM1ih5N0=
X-Google-Smtp-Source: AGHT+IGu8R0zvZTDHBzZBbCIHqlkqesk+rlx3McpD3Lqxw7BERLyITjAkkGT0uILmEOlJzPwfPVziw==
X-Received: by 2002:a05:6000:18ab:b0:3a3:6e23:3a46 with SMTP id ffacd0b85a97d-3a36e233c0amr3159410f8f.43.1747649733123;
        Mon, 19 May 2025 03:15:33 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d105sm12499021f8f.11.2025.05.19.03.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 03:15:32 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 19 May 2025 12:13:39 +0200
Subject: [PATCH v5 2/5] iio: core: add ADC delay calibration definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250519-wip-bl-ad7606-calibration-v5-2-4054fc7c9f3d@baylibre.com>
References: <20250519-wip-bl-ad7606-calibration-v5-0-4054fc7c9f3d@baylibre.com>
In-Reply-To: <20250519-wip-bl-ad7606-calibration-v5-0-4054fc7c9f3d@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=4Hb5fAw6wk9UOyjGvMGWLBgqM5yKlaYwdF7azoNoMts=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsjQZknWdBb10+eLTHMInXtz9tqvJy6+j11aG8stJiEsd
 4hF+2JoRykLgxgXg6yYIktdYoRJ6O1QKeUFjLNh5rAygQxh4OIUgIkUuTAyrHvpdtLp0sXLfz4k
 96tzf2PaFlshFFHgPVmt3yneJsMul5Hh0+uFbCKH2bPXOywXfOXcYtP3IiGa8dwB7rCipbHWn7/
 zAQA=
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

ADCs as ad7606 implement a phase calibration as a delay.
Add such definition, needed for ad7606.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/industrialio-core.c | 1 +
 include/linux/iio/types.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 178e99b111debc59a247fcc3a6037e429db3bebf..f13c3aa470d774bfe655d6a9fb00c263789db637 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -188,6 +188,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_CALIBAMBIENT] = "calibambient",
 	[IIO_CHAN_INFO_ZEROPOINT] = "zeropoint",
 	[IIO_CHAN_INFO_TROUGH] = "trough_raw",
+	[IIO_CHAN_INFO_CONVDELAY] = "convdelay",
 };
 /**
  * iio_device_id() - query the unique ID for the device
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index d89982c98368cf72c0fc30fa66ab001e48af4e8b..ad2761efcc8315e1f9907d2a7159447fb463333e 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -69,6 +69,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_CALIBAMBIENT,
 	IIO_CHAN_INFO_ZEROPOINT,
 	IIO_CHAN_INFO_TROUGH,
+	IIO_CHAN_INFO_CONVDELAY,
 };
 
 #endif /* _IIO_TYPES_H_ */

-- 
2.49.0


