Return-Path: <linux-iio+bounces-18989-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9B2AA7393
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 15:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB38F171458
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 13:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3B3252905;
	Fri,  2 May 2025 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LA/kn8JS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB75254AF2
	for <linux-iio@vger.kernel.org>; Fri,  2 May 2025 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746192502; cv=none; b=B4vj3TvqSkcxmVImEXK4C1qn3PBEGGi8FRLEUol9Udd4EXBGVh/0XiWFd1WLFKAfop4Z4wo09f9KLnm1VndXN2/FsdznuMXRWq9ubz8vQdta5zyxEp/pej+ueURXzRBUpteH73rChHEhSmbTsYBIUhQwOGUYvqi+ik83vcgt0wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746192502; c=relaxed/simple;
	bh=TQqLWy53nCViEnaTWQFWmvMZdao7mPG4VBPe7jY2JnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IW2VcebP6sIA9aX/I5N0qO4h5h3EIpQ+5LjUQQt2bMePos6mKoUB40xTgC/AjD/chQ3uHKmtkzHybTCZaJUf1keueELVWZ5Y7PoR5t3xjfV8Ljp4a9DUKeglF5y7lYHPWetu02YnL4S4s18ZdLLlEC/0AL7m7V/P5mQTLBj0gPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LA/kn8JS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so11915005e9.2
        for <linux-iio@vger.kernel.org>; Fri, 02 May 2025 06:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746192498; x=1746797298; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PuRbnqMan3w9A4V02ED54xhlqh03UYeyGh90bRtECvU=;
        b=LA/kn8JSHPyd7j+pcfeP1thP2XoDfVBvl3lkd9JfzVuwT+ZFV+YgatosI7yPuGdlqS
         1D1osmh7/IbT/6t4kAEpcpWTQfOABXcmjsw14UCe+RjbZT8m5bAGqCgzf+WvKfHB6//H
         Dfc3I1zF63PahgZ0lMCA/MUNBMtz2w2Uht36wnkZY7STdHJ0x4x1AcLYw59A0T/SZCre
         L7AGS3zVWLRY4vB75/LSB/lBctz9jLrrSVYcdNag9ddo/3h4CWO/h/7We4y0RPHs2tcD
         e56WrqTnY+mQ8lVI6GX4V3nAtZJPu0GgK9UEatwQ+uWHGCBUvgHpG4jBI3PSK61tSDry
         nnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746192498; x=1746797298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuRbnqMan3w9A4V02ED54xhlqh03UYeyGh90bRtECvU=;
        b=uTBLRET+ivtTGt23lbfLg32uSY1kn/SrhX/Fkqbvmgbcn3/u+MKZz8/Gb591XO3YAV
         vuxmWrsFZo8soG5QFZ58/z1Iiy2u2SrW8YcbXWOweNRrN1hLqELeTJvYaoUeDPppbGc9
         BBAYHfVqnUQKPHdDSB+beMylwKnflfg0ygOOP6V19kaBVVz4DSshN8ZXTShH88Dy5Cvj
         XrMrDfeH50BZ7jIg5BaRwNXkQOBUq+j0wZlPultmq2uCTfIWEytszc7Jh1IOWxL8MqJO
         5afzwcwH32IePrUbLZlgMwZnve1bLA2KCBS7kxMdCAWzmyA4P6RvEAzNt9NoDD9k3puJ
         XFRg==
X-Gm-Message-State: AOJu0Yy0DVyTnm3ojYegl3niBhbWpjIIAQacLesZl0AW6Sc90zcQJQ9R
	ZjJCesaG4k9vkRn64glnByp5hDO2kOwKMO6jq/nFDiUmaQ0SALU5lq7qC9gXaNs=
X-Gm-Gg: ASbGncs+YXN/d1cmgiKRuwUPhsU8gZrJfIN71mSu0sldX4MPelafwFwAfw9t2OV4w63
	h7EHX07JD0Qa2DTKPN/BChsLjca7N7P2Fs4Pj2fo7vEe/DQ+zejEyXpt8JVnO2JJQreoxY5lXWV
	6GfO+5Ze3znudyzrYTY8riEy+DQUoQVhYbZn1c8QAIMbxYLdbUmGURU2iQi3tiqa21wCojUMXEg
	ra9answzW8ZFCu/W8R+nbjTRZViPrnRj2F2iyP7i2LPn+GtaGkoj311V3AIk4TjBMVUFYRixJNO
	6ZQo//WujKzpf02j00LXLR+2mhx/yXPQd2jIAMGwVlYZ
X-Google-Smtp-Source: AGHT+IFQANgfE3IS1tRpNJM0Ecgeq6HCN0uHkEtPuAM+ff5mCDruJROS/5GCJdPHvUbt9Mw624sPjg==
X-Received: by 2002:a05:600c:c86:b0:43d:47b7:b32d with SMTP id 5b1f17b1804b1-441bbf2cda5mr22225065e9.25.1746192498501;
        Fri, 02 May 2025 06:28:18 -0700 (PDT)
Received: from [192.168.0.2] ([87.8.31.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89cc50esm45761065e9.8.2025.05.02.06.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 06:28:18 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 02 May 2025 15:26:59 +0200
Subject: [PATCH v2 2/5] iio: core: add ADC delay calibration definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-wip-bl-ad7606-calibration-v2-2-174bd0af081b@baylibre.com>
References: <20250502-wip-bl-ad7606-calibration-v2-0-174bd0af081b@baylibre.com>
In-Reply-To: <20250502-wip-bl-ad7606-calibration-v2-0-174bd0af081b@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1321;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=aRzAUIAqWC4TDqtCS6Lh/5C89FaJdMlDTJtPJeTuUxw=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsgQOaGe4Prlx7WUc/4Pp9hOCv5cc/iEkqbfoeg6N+Ws3
 kae33tMOkpZGMS4GGTFFFnqEiNMQm+HSikvYJwNM4eVCWQIAxenAExEvozhD0+DQLZwyjMe9YyD
 5x88/vjr0Km8p526nJ/q/4sw6Um4bmT4X3w9U2pGx7bNC+yf3OM8UyzpcVIyxS/OcU2BnMo025D
 bTAA=
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
index 178e99b111debc59a247fcc3a6037e429db3bebf..45ce8603959e6d0985904b7feb79872bffde1126 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -188,6 +188,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_CALIBAMBIENT] = "calibambient",
 	[IIO_CHAN_INFO_ZEROPOINT] = "zeropoint",
 	[IIO_CHAN_INFO_TROUGH] = "trough_raw",
+	[IIO_CHAN_INFO_CALIBCONV_DELAY] = "calibconv_delay",
 };
 /**
  * iio_device_id() - query the unique ID for the device
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index d89982c98368cf72c0fc30fa66ab001e48af4e8b..d1137180a8b0bf2e34cb4186dceddad4978ca766 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -69,6 +69,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_CALIBAMBIENT,
 	IIO_CHAN_INFO_ZEROPOINT,
 	IIO_CHAN_INFO_TROUGH,
+	IIO_CHAN_INFO_CALIBCONV_DELAY,
 };
 
 #endif /* _IIO_TYPES_H_ */

-- 
2.49.0


