Return-Path: <linux-iio+bounces-4507-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 671788B1AE0
	for <lists+linux-iio@lfdr.de>; Thu, 25 Apr 2024 08:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989161C21151
	for <lists+linux-iio@lfdr.de>; Thu, 25 Apr 2024 06:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247103FB96;
	Thu, 25 Apr 2024 06:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEpx4oM5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846665672
	for <linux-iio@vger.kernel.org>; Thu, 25 Apr 2024 06:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714026173; cv=none; b=scvsRY+CN/Rn+v//2JiqUwzEzC0PwGuR46oQcrQS/z/m9260HZhvM0giXJ4FY73iFrDR3dAaP6iIiFnM9lVdLG3/ALMl+b/RSdUEeIuLaHq78WhoPjWVnIN4KQwYOj9gFm1phz7BJmkG6s3iXL7FH+rOECHTbbSketqI8gL6uOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714026173; c=relaxed/simple;
	bh=r4t8wMua0eZmJqQyloGDotqnpFaD3s8BvYUbNku+tgg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B59Ndsr9cY8sIAECuULoQ1wlgS7MtizL3WfwFCjScN+XcXVn4i5kgSmNvVna3j2M6R34AdImF17USmJnGoovJLPcaNpcMk0e75sy+yDkEyW2o2eAfJYLvuCnYYQrCo4Ba0gATKkxrybGIC3mSXv8SgWH5fojTvMZX0DHaT7hPe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEpx4oM5; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ea2ac4607aso331764a34.3
        for <linux-iio@vger.kernel.org>; Wed, 24 Apr 2024 23:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714026171; x=1714630971; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Le+L0VmWNYKumCTM7dvjB/4xTTgUPMbARWZobuCCoUw=;
        b=NEpx4oM5URGsPhgVvzoWTeLnbr5Xshy0KnNc88HDr5pxFAWDBdNGWmlhV9KeD0ZP3M
         9TXE+U1PgY1KiyIkUjZALPdzPqWr3oXI+a/NzGpU8+nJj3QgH+nhUvv6VrCd8/O6aB14
         Jau53zT2g4/G6y+2v6qN+jsLG9c0yndXrJXcswWaAsWZbNTR83KQr+3cloz7D34Iqta2
         nYYFGo/9TNj9tN0HDVpVNIP9ZYubTcv7qSUESZs/hF+4Zqc5mJpgMqrDzQ8IB94J2NyQ
         IFf/4X44pHFwB+xDVpq2RdDnlUYVujPwEzdisDU9TiSsYZ2pz5G/4QzJyb0yD2UKpfZH
         PB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714026171; x=1714630971;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Le+L0VmWNYKumCTM7dvjB/4xTTgUPMbARWZobuCCoUw=;
        b=SdxCMqwFhUHRZ63W4sCNcpJfbgGcT9mSVds0nVQc73+yPxg/l0uZPMftb4XnjxRt+U
         60rK6PN5XMAvC5/oxxXNibSNie4Uc41z7EYW1iqB+kDeN7RVshNGWngPJuoA3HW8gf7E
         1w+P1fYQGERiaDD4CBtiDnM/hx+9d70tTk3JW21YLViVkEkPWTVPo5PP69P+cXMMqUV8
         1SCtN2DQ0n14Xp1eArVpD1VRQPPW0AhXg8SZ2DFgC5GF+2CkQSqstAOiCyxP1xKYHCll
         2kZwv3yI0U8xM/L//TQ/dXHSvDcnhYmde7WwxVQgXYW0vVTutAZb/I956SmZwCGAqPiT
         jYNw==
X-Gm-Message-State: AOJu0YzSbixEglK/zFexVDCsFHsBN74cKFPfhbiwwzRogM0bixw04FPG
	fa2k7jHn/NisL+KjOxuQ0wPcF7JdEKXSXc1IfwGB8gyX9ZGvWlKBZG+y6quL
X-Google-Smtp-Source: AGHT+IHBoRdLH2PWA9qreZOVNHqk3o1Kzvhgqw1S+wQQSlTrR43Qsb+73LJ6K752FUygsEHYUXOYAw==
X-Received: by 2002:a05:6830:2aa2:b0:6eb:ca73:4813 with SMTP id s34-20020a0568302aa200b006ebca734813mr6347513otu.28.1714026171434;
        Wed, 24 Apr 2024 23:22:51 -0700 (PDT)
Received: from adam-asahi.lan ([2605:a601:aa37:b000:4fb9:a9ef:f88:50f6])
        by smtp.gmail.com with ESMTPSA id o22-20020a9d5c16000000b006ebca4a8083sm2370444otk.78.2024.04.24.23.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 23:22:50 -0700 (PDT)
Date: Thu, 25 Apr 2024 01:22:49 -0500
From: Adam Rizkalla <ajarizzo@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Adam Rizkalla <ajarizzo@gmail.com>
Subject: [PATCH] iio: pressure: bmp280: Fix BMP580 temperature reading
Message-ID: <Zin2udkXRD0+GrML@adam-asahi.lan>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix overflow issue when storing BMP580 temperature reading and
properly preserve sign of 24-bit data.

Signed-off-by: Adam Rizkalla <ajarizzo@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index fe8734468ed3..e79c9715bb28 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1393,12 +1393,12 @@ static int bmp580_read_temp(struct bmp280_data *data, int *val, int *val2)
 
 	/*
 	 * Temperature is returned in Celsius degrees in fractional
-	 * form down 2^16. We rescale by x1000 to return milli Celsius
-	 * to respect IIO ABI.
+	 * form down 2^16. We rescale by x1000 to return millidegrees
+	 * Celsius to respect IIO ABI.
 	 */
-	*val = raw_temp * 1000;
-	*val2 = 16;
-	return IIO_VAL_FRACTIONAL_LOG2;
+	raw_temp = sign_extend32(raw_temp, 23);
+	*val = ((s64)raw_temp * 1000) / (1 << 16);
+	return IIO_VAL_INT;
 }
 
 static int bmp580_read_press(struct bmp280_data *data, int *val, int *val2)
-- 
2.40.1


