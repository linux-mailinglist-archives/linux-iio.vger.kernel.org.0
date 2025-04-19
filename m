Return-Path: <linux-iio+bounces-18328-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54704A943CA
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 16:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757028E1FEE
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 14:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701AF1D5166;
	Sat, 19 Apr 2025 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eILa/oh1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE091CA4B;
	Sat, 19 Apr 2025 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745073927; cv=none; b=rgr1E0qSgNRMqVyaqMOe/GfXYXMzGrkGzOF/yNYLaIJwa/MJnLfjG8d5SI768PIbSOnHAni5LiirRh644wD1yvZf471IGrM3Ft74o/tzjiy8WecunjoGlpmvqiNjPy233TPdlz5mFXqch4MpIbUw1j8rBmVsl4wKRaP1M4Bxk8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745073927; c=relaxed/simple;
	bh=/iRpNdeJshI3L30q214V68a98a6RN866jsxqHPWRnZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DofhnMq59AuLJg/DFP3HcUGLnTBPavxwa4Z76fp7PEidy+JwCn6Q+FsCqCXjvEtgfR6gTvKSD42maSVzhsL6x0XZXytPTQ8jdSbItR7DzQ+vQl8m4htb3nJr8NGQd1ggRDPJjOEXZfqdfA1wuxETD8v1Dc6iXeKUBaLu7AmMAeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eILa/oh1; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-477296dce76so22767771cf.3;
        Sat, 19 Apr 2025 07:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745073924; x=1745678724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TZwskAex2BRKK/3gla3QPoANYGHWeVyAoradRHdAXwM=;
        b=eILa/oh15CYd/dRrqtuceD8jJ1ZtpOIbI6yUFPwZ/xPLCYIDxEbaQpVtv8ZFq3o1xJ
         U4JvdwtYRVneFgSAcF+yU52vDdrqFz1vEVyN8NbEaqI5HZGh1Shku6Vp2zAYrmuamNpw
         vobyu2jN8u5vmkEmpm7T5a2oPIS++GGX9HrQ8oPO+Qer+EhVKnXUSDQe/CVYGJDYtlNj
         oPtwdArXOCoyzReT65PDn785IVnuaiWTEWpfQPyQhpyX/iGilELogKrrkC2XZcmzNBOZ
         EnhEfWFH9TVE6AfBZXWVABDR+RMlR71nNDazJKOhvQaN2uBDc9f/SVs3mRH9Fm4aXRQZ
         STXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745073924; x=1745678724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TZwskAex2BRKK/3gla3QPoANYGHWeVyAoradRHdAXwM=;
        b=KOI57os+1vd4pigLPneREVayCcr5ScXT3KzMvW9uOIBvcpjhapfxpWHWE7H4tAhcTj
         FgeC3XPWDr2ye5PrcF8kL6RbEBM/URtM4VGaUEohe9bg0y1twsWw3IPKrtaN83HnW/ds
         UgTQ7Y31rh0hhdMXAqXWri+5OQpgJtiOR7yqHA56QTpS8CWZfetrklXquucMuCQXqMfq
         jE9ungXTHA4Ka8FU4TI9vNsrlKpKydEiHjjY9YA4L1yUa0tvCZk01wLprRapU1BVCoE/
         skxi/doonjayUZqbq2ysIjGcVdpIVVePRo3iL0FaGzmvVIgaWQ4FzOH48zi6lld3UiJv
         IWIg==
X-Forwarded-Encrypted: i=1; AJvYcCW+vdnffOnRLZ98WrFpG6OBrLGNbe2BhmKuUUGyRinzeRor5LB22TLPoBuzxCUfooG8J5QnUt647Ec=@vger.kernel.org, AJvYcCWPBQhtAqqviuz10kiPXb9S1fMsYxFfm5bxZ845Gv3EW+ePsjg9/3AW59px+bNlJNph6Sh55mZNT0+S45z+@vger.kernel.org
X-Gm-Message-State: AOJu0YwKq7TGekRt0sYVhx72rP1Nm8BWg8H+pi2+fO0eLnJeR5NQS+UR
	O3dXH6nPNG9fB7/cS9jRPKlFZFbMBN7IzEWJ7xQS5833l1TAulUV
X-Gm-Gg: ASbGncudY1R+0XJrV/xUbUTeQre32AC5giFqhiXDp3aSpXW0vE0KN91J9c0Y0jv8SRC
	4o5GhXfnzr+SQNIHd66/pQqn/lX7doUDN4ZLLgwRJ6v4sNhO7rDOegk13kapptGlY/IH9rKEs84
	fdqpk7k7wnPPbzks2WO75E1McC3eBontSV77LK56iww1P51NA0e1mCu1wAfYYgh0yKqpxtQBtBb
	Ovd+LYvW/A1QuDgz6s/YCKlZ9eKgFhqi6Gk33m/cuUBcpmZ4aRTqbUPaqXHi0RG9Spw1Qp2z3nT
	CMHa3Aoj78jZf5B19Q5HBGj+zNQQ8vW1SNOpqkD9MCoHpT10G6zXj84=
X-Google-Smtp-Source: AGHT+IFknOo8FgIOBC/pX7zqREnS6alYIVbQbHq3b3MI+c5P0yy/6AQL2yR1JeK4EVgs7lffsPJP6A==
X-Received: by 2002:a05:622a:1349:b0:476:8917:5efe with SMTP id d75a77b69052e-47aec4a117emr101307731cf.42.1745073924534;
        Sat, 19 Apr 2025 07:45:24 -0700 (PDT)
Received: from theriatric.mshome.net ([73.123.232.110])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9cf9f29sm21856141cf.71.2025.04.19.07.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 07:45:24 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael.Hennerich@analog.com
Cc: gshahrouzi@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] iio: adis16201: Correct inclinometer channel resolution
Date: Sat, 19 Apr 2025 10:45:20 -0400
Message-ID: <20250419144520.815198-1-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The inclinometer channels were previously defined with 14 realbits.
However, the ADIS16201 datasheet states the resolution for these output
channels is 12 bits (Page 14, text description; Page 15, table 7).

Correct the realbits value to 12 to accurately reflect the hardware.

Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
Omit fixes tag because it targets driver before it moved out of staging.
---
 drivers/iio/accel/adis16201.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index 982b33f6eccac..dcc8d9f2ee0f1 100644
--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -211,9 +211,9 @@ static const struct iio_chan_spec adis16201_channels[] = {
 			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
 	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, 0, 12),
 	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT_REG, ADIS16201_SCAN_INCLI_X,
-			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
+			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
 	ADIS_INCLI_CHAN(Y, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_Y,
-			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
+			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
 	IIO_CHAN_SOFT_TIMESTAMP(7)
 };
 
-- 
2.43.0


