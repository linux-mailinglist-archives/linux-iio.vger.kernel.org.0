Return-Path: <linux-iio+bounces-18081-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3FBA88541
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 16:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04522567E6D
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 14:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61158288C84;
	Mon, 14 Apr 2025 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjkOl1s3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F6324728E;
	Mon, 14 Apr 2025 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639748; cv=none; b=qkVumnrLLAD3mHYActKhZg0tOoFMU6tieH9vpUOR9CaV6OHoQYrdGHaucYFBBB9t/2ALRlOy/O8ngbdqmnatZXlqzwAB3JUIjmzHy3hnM0NbPOYy1lso6oV4cULJEXjEaYR00v+xoD4rJHxuUKiTR2NC591Vf/TvDpnC6etFjEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639748; c=relaxed/simple;
	bh=B12gaYxryrr/rPJ3pcLrF0Rl7Kt4JWDFN75r8W5U58A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NKMTM4kYavFgopqmQB+qdS8PAHKn1PO/gigGAwfjrP2qzsGi1TYCa0nUV/jpX1AB4CujdY/NXO41vSkAvmjsD+sfEIY4X7dlc4aGRcyjI7b1xTNQz+Vf2odsCUKnbIF/zQ4BFcYWGoDjih5cYiKbJKmTNvuZBGNtJJnKa/s/kGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjkOl1s3; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8f254b875so41522836d6.1;
        Mon, 14 Apr 2025 07:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744639745; x=1745244545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CnhmU/ZILoUaMWGd+8bGeiu5Y0rkdVWKSR+fUdJPinE=;
        b=hjkOl1s3HttoAVOj66Pzj1xcohgenqmy/xhY5T3HloTZdOxAWFpkEdFfIYtNo+XBQv
         0BpTq5jyJbeTRBNTyhiCeIxdr7GRBtWLLfzTvC5w0qFbHlRqpoDJ2NrLWLZjaV7rCSUp
         AMNFylCoVh7R57XPh0vpkwQWVwh5mVt/B90uClG2HZ/rgeCOQiLVd+B1ycI7KvK7lmz0
         kY+bnaEq59HGWzMQiBHkBw5q+3AyLmN7kVpfl3a6MJm3ZA67R4jt1M//7BePLCqBoBDC
         lwx7brRqxGsDAoMxXTfzDXr7CPV4Z2eERK0A8HyHhbCAS+jk2thWK6w2/jxYIH9isNmH
         trVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744639745; x=1745244545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CnhmU/ZILoUaMWGd+8bGeiu5Y0rkdVWKSR+fUdJPinE=;
        b=rjzUAk74KkNkOgP14KgFLkx+Rtmq34S/mJyX/nuT1mXmFe14Wi7yL445cB4z6nckyf
         NE18ySettMJIP89T+sJpbuLSe3M2ChvDM9X/7Lsz45qXf36frcXK+Kg/6SAewt9DW8SF
         4LIuteENe7zhw+6oSK2LXeXEpTYd14p1toC87ERQVnJAjhKI7v4FnjebHDMZvq+0cuYE
         2uSCDpGcuDmNusaYMs7YTX2T0hihYniVBLF/HoAAQfxHT6jxg/R9KkCd2nUm13z5bcgW
         Fpdb8SiQjpehHK24+iu336oxU5B54GBEAGA0nBUGgVZ9nQDMWzHDK4bXR8rwTSiJtcTZ
         C86Q==
X-Forwarded-Encrypted: i=1; AJvYcCULuxJRheCjn8oJ9p+Spx9E6d8exe69xmDQ/jyfMLR8TN32HqTbN6Fw1vwgLDwJjY+D60ERsEXVYBTni1h5@vger.kernel.org, AJvYcCVmf/7rl11QPHe6dh7aKtZaMPVdP4+d4rbaYlh+Cy1e2/IUf/19Z2YLx90ZTXk8/sTRVfyMLOcTiw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+AbNIFU0tETen75dvrsTkd0gHaotJR8E8jXQBqKpuEhvkg4wd
	Ge6ZJcmaJ2gO03cwl406tgR5n79RQf+0aBcamTBIJJOb1KF1tIRt
X-Gm-Gg: ASbGncvdfCo1dZisXWWRAOh9a27oCQ16S6cuPaXILUUSl94c3D2iZxfz/CeGNoWOQx9
	z/sSXqIFRniGNamJpXrlxQ2DbFLPEiTer25zWzwS0LlRCF7P/z1zMIUT8ZNeo0x9bZ/iSLfeDfO
	/RjggLQc/MpK3ogqIn/+ps25ipLaFlkWhCFqIpIyR4bmJpmmfNPPa7sa8awORQMCfMeRmOq0ItY
	smaZ/ZSYgaSGUh6m1DsD/tqfanGLyWoxRdWQSfQQvcxWoRLPtI/HfZPI88TG3jxhpkgPPMUeP/C
	tu5+FewSy3MCmioQ2WDPa18ndNavbjcfw8gsBmtneJGqf0BgIo36qkM9CH5Mc3XkCLHDTpGownA
	cAPuWYga6vTWdNTwKgEw=
X-Google-Smtp-Source: AGHT+IFGRinbFYIbEanUCrc0USF9meGu9XI5hh+1+7w8QKX2Q86t6AvSznRkMwFHVH86Mq5ooeGfGQ==
X-Received: by 2002:a05:6214:d44:b0:6e8:e828:820d with SMTP id 6a1803df08f44-6f23f14bc14mr238912856d6.36.1744639745184;
        Mon, 14 Apr 2025 07:09:05 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de973552sm84019906d6.50.2025.04.14.07.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 07:09:04 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: gshahrozui@gmail.com,
	skhan@linuxfoundation.org,
	kernelmentees@lists.linuxfoundation.org,
	Gabriel Shahrouzi <gshahrouzi@gmail.com>
Subject: [PATCH] iio: adc: Correct conditional logic for store mode
Date: Mon, 14 Apr 2025 10:09:01 -0400
Message-ID: <20250414140901.460719-1-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mode setting logic in ad7816_store_mode was reversed due to
incorrect handling of the strcmp return value. strcmp returns 0 on
match, so the `if (strcmp(buf, "full"))` block executed when the
input was not "full".

This resulted in "full" setting the mode to AD7816_PD (power-down) and
other inputs setting it to AD7816_FULL.

Fix this by checking it against 0 to correctly check for "full" and
"power-down", mapping them to AD7816_FULL and AD7816_PD respectively.

Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 6c14d7bcdd675..6b545547660dd 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -136,7 +136,7 @@ static ssize_t ad7816_store_mode(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
-	if (strcmp(buf, "full")) {
+	if (sysfs_streq(buf, "full")) {
 		gpiod_set_value(chip->rdwr_pin, 1);
 		chip->mode = AD7816_FULL;
 	} else {
-- 
2.43.0


