Return-Path: <linux-iio+bounces-18363-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ED8A94663
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 03:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCFBA1893F35
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 01:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A10F12B17C;
	Sun, 20 Apr 2025 01:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWnm36w8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC1E34545;
	Sun, 20 Apr 2025 01:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745113755; cv=none; b=ZGZVzFLC0UVfYt+SYM7KtielMWvudtxPU34i2LcUZLWxBb++MG+X0FPjLC17FcK46knP+1FSc+yZ56+mCY2QKIv2+NfoZt2FfJv0E1meCgiPU0+ZWISQhGAoWoZO0PeplK2AA+PV3azEx5dJfRYcgxdjLjCi4u3ix4tXCK9uqso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745113755; c=relaxed/simple;
	bh=nhjNiEws7JDfpSABnQRCrgaV/jVLhmHTd1ukZHOLh3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yq1udvBeo4I5UAJ2s0je4kMbWdfejkjs3F7TGNkcAvfu83Ilr/Wo0ducS3zZ60LtPUhuXiBgVl8VPcgnXad4xjUSbjnLchsQGEJ197BHMpgw496JG3l0xWq7B6MBpqEkylAv5UIwshCn0tZ++r4ikUq7njovEZ8AkVOisRDfFDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWnm36w8; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8f06e13a4so40321216d6.0;
        Sat, 19 Apr 2025 18:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745113752; x=1745718552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gk0TUJMIcvb2/Yt9CvbEI4RZU5fYHN3893YNwk+aijI=;
        b=PWnm36w8rHP+TNs7cNhns2hWCwTQS3WU3VzBdzMDXUDvukZn15meavgYduD+gmaMc1
         cCgXHguZ7Pkn7mB44JGWfpEgvEAIpQx+mSVYTKlLGThq4ShlUb9nJAbwwrEWGCau2Jiw
         M05/QJRUcbLDFJeHgccit3sZqergZin04ZhCtETnLuz7Cf7QrBtAOguh1576jlMOFBcG
         WS3mIEzyLe4XhbwZ4dUvdDc52/uQBWVOeuWDfi+mibRAvKQe9LL8od2pfQOejLZIfksq
         Do6Ym+p3pkjokfbe9CjIjVfrgQRkafUK1dYBb1VoZtXW7/Wn5rSl0wefxJH1Q2gfGbFV
         LWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745113752; x=1745718552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gk0TUJMIcvb2/Yt9CvbEI4RZU5fYHN3893YNwk+aijI=;
        b=c6mnxEnG5+OOf1gOKWTRFpjMk5vEgD/WS+LSTrzApT7p+tVu/r2NGGjt4HFzZ7AoZl
         vBIphYLcbeIt67i8qxtRXTtHjeGbf2oW7Ker1xy9Te1MN98oWicl5LyW71os08FBipKo
         zGlWV/oO9z4VxB0d0OnrObeLX84NhZXs8W7LdYfISuhIjYm+YgPu9dJF57fz3pmLPIc7
         bq3Av0pWqzdT+fMyVh/siKJlXy3K8reSHWapveLDFn0rEXn6/T16nE40Z14rc7KgAkm3
         EQpchhH0dqNRkPWUoirJO3PUGybeaCwtmwxPvpiD+xiwcr6brkdr7BU+HMDWlJH/npl6
         6/9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3ComANWUUP6ukGMdibQUq8wwtY7kyU3gSlxaBESp3iYFbiI7/IytonyoIYeMKE5dJekQJB1Qo@vger.kernel.org, AJvYcCWPCZoy0PhO6j8hMDX1Nii5wwypVW/oJHDve5QSg6WgQaT6kM15SRG+H1i5HvL+mIVrtsbfXRepdMMSHRFc@vger.kernel.org, AJvYcCXR1v50/SQm5HXdx02gNlXNSVx0Vfcg+18t8jH1/mCPmgtWbg2VnrBuiyxck0jCbNGnF6Vr85XD+bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDItOBxUomHGlkadMOtFZPgX5/S1DVJqrJGZ5XDiSqEOlaXE9U
	rCVBM9NKxNCR6+f6DmpTDH5y1yl+D7j6FDBJgfCCtEHgEmUZO0R7
X-Gm-Gg: ASbGnctf2zchmHDrbuj0lygnfJ91l2w0czJAipe2OL7A9Bt2U+v1xqBDiZgX+gLBXt2
	ic2HZWWf9u3wDkygSGrT6to+qQGF9FH68dYo3RSSK2SDA+ayuI/253qU1IBJdORXWol+WXWmyOv
	kUjmRPWNCP7ULOOt5HJ/ZE0NqG7sUfHmJqtKOMVBqJhP/MU7Y58j6j/hcgmNvzqzmVzYW3NevAZ
	SijkafLbOo9StjiQktfSQAbxz8W7tzfLxks5fjUpuCMM0ynIVkUZLUBorDxlOfQPDerd+wER5Yn
	dCuySriqlBW4wc1IZEZ+beQYLwyVRwZZtXDN66fli+MKt3MLUctsDmMSTptaQYgLgHDE51MPMKQ
	xjKgml1zgMlbvgBsIIwM=
X-Google-Smtp-Source: AGHT+IFRsCe5B3DOeaXRGR7WUM1HNURo5facIOltw+5BM63Sm6+YsXazg+DParofxt0X8IJh+8vDZg==
X-Received: by 2002:a05:6214:238e:b0:6e4:5317:64a0 with SMTP id 6a1803df08f44-6f2c2716ceemr122000666d6.13.1745113752465;
        Sat, 19 Apr 2025 18:49:12 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2af1283sm27583846d6.23.2025.04.19.18.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 18:49:12 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Michael.Hennerich@analog.com,
	sonic.zhang@analog.com,
	vapier@gentoo.org
Cc: gshahrouzi@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v5 1/5] staging: iio: adc: ad7816: Allow channel 7 for all devices
Date: Sat, 19 Apr 2025 21:49:06 -0400
Message-ID: <20250420014910.849934-2-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250420014910.849934-1-gshahrouzi@gmail.com>
References: <20250420014910.849934-1-gshahrouzi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the datasheet on page 9 under the channel selection table,
all devices (AD7816/7/8) are able to use the channel marked as 7. This
channel is used for diagnostic purposes by routing the internal 1.23V
bandgap source through the MUX to the input of the ADC.

Modify the channel validation logic to permit channel 7 for all
supported device types.

Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devices")
Cc: stable@vger.kernel.org
Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 6c14d7bcdd675..a44b0c8c82b12 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -190,11 +190,11 @@ static ssize_t ad7816_store_channel(struct device *dev,
 		dev_err(&chip->spi_dev->dev, "Invalid channel id %lu for %s.\n",
 			data, indio_dev->name);
 		return -EINVAL;
-	} else if (strcmp(indio_dev->name, "ad7818") == 0 && data > 1) {
+	} else if (strcmp(indio_dev->name, "ad7818") == 0 && data > 1 && data != AD7816_CS_MASK) {
 		dev_err(&chip->spi_dev->dev,
 			"Invalid channel id %lu for ad7818.\n", data);
 		return -EINVAL;
-	} else if (strcmp(indio_dev->name, "ad7816") == 0 && data > 0) {
+	} else if (strcmp(indio_dev->name, "ad7816") == 0 && data > 0 && data != AD7816_CS_MASK) {
 		dev_err(&chip->spi_dev->dev,
 			"Invalid channel id %lu for ad7816.\n", data);
 		return -EINVAL;
-- 
2.43.0


