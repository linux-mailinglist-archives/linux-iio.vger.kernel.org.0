Return-Path: <linux-iio+bounces-18311-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695F3A93F35
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 22:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2378A8716
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 20:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2322472A1;
	Fri, 18 Apr 2025 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cprL+9Rj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAD6253326;
	Fri, 18 Apr 2025 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745009436; cv=none; b=bU207w9HMWnuWofTYSBgvKx1xPba2FnpTZaCtOF1/ShYVg1E1/JDVsRqD7R0Og3OQrFmhXpDjhtU7tPgESL3nJ1/Lm0OW8Vv/bKE7cP//hP0Io+qo60CE0/oA+UYokdKPJmkTp4u344YyLjQN+BIQiRTolrMtH3vY5JPsT+5wZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745009436; c=relaxed/simple;
	bh=6b39M6YtW2A/3eICBTEDNqpUWewC4LsFqtDslsVsEOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zka0b22HjWA2fFJeBC6HrWNW+46IJ8PrrghlAIfcBYT6UjBzFT1YpUlTBfl/sARfby70pC8fHG4DIMjFKOGbknhWNDFlexh4ixE+fvBDzhN/Hsn16mK4bLSIJO+cRZAP22JTNPi7RxoQG7UHvI9YbOlCcchn1Un705i6+yHOy5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cprL+9Rj; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8f8657f29so20583626d6.3;
        Fri, 18 Apr 2025 13:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745009433; x=1745614233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SMPeQ941nuBw4ulrFHaEAxjMcMmjZp4/m3CVTBPiag=;
        b=cprL+9RjFelsJl7m3HXI3g3TUn9fLlIAQ1RLYtyPMcThPs+jZZ4MaxMntOiLK7k9JF
         ynvMofP6FVyPGDjkLg0v3hM48varrl0AMIbnK8ontEsLPvKFURSqWL2T0Iv879OorA94
         U5eLbArjW9CslRGaVUVamT3zqDj31949X4Ouej7kINCKkrxmnOODSprECQwfespHBGnN
         /KMP9Ovfd5h8zUzeKzyd5scHNM5vmGjDLrvEJEwNvxQ4+nRxoGEE3hhumcJ+GpzIL/5x
         NUk/HIncbUnmyIGUprR4mV8c+zX3apsacIcPzmCrFgjTUiLR+9eaxP5+oyEEdGz7Epin
         uemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745009433; x=1745614233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SMPeQ941nuBw4ulrFHaEAxjMcMmjZp4/m3CVTBPiag=;
        b=rhWzDNMFXJzK60EiHSi2k4YHk1WBSbLTaFRWAGzI9hAYt7SQ8wCn3hQuTSo1laQhH9
         tN9qHS//6R4Hb880TUU2k/MaLbnBnQGuK7wWbekPsiVKrvu0uOW7ZEkbuWJImpnp0wl1
         6VBpZDZ3fYaH0HeC/ngFRR7CVKc3n3A4qe+BAU48SR563gvq3+eytBlN6cY8pCfkaTYl
         ZRwC+17eXxdn4Ik14r+y2l7+0xGj8xIj/hd2ZZmGF54k2KC9FpvchwEi8SZIiSFC+KIY
         afHQmw3fMUEZuEdNoOx5bGWTtoQ/IOQcg0C4SbB+CGW08T7PRzhLv8u0PsjpZ7nMOgvA
         vslQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTjx77+sRTd9kqhw3az0ot2LBbwIhF3ByuIxtvcWnvOFdoPAaBa1wyKLOzvZ/6s1thFSTnwgf3znU=@vger.kernel.org, AJvYcCWcuUGce4HIyOnld+RnR0zVa6UNrcGM4r7P2Ok904+2r47uhLdF8KgPTsoUyMY3l7PxHft7QBGCVCzcXS1t@vger.kernel.org
X-Gm-Message-State: AOJu0Yy44rZcQ2+RxB3oG/3JJcPUQa8mYAaz/oOmRpOKOJJUEyDNzr44
	A7r+ZPCv1vKGSb1jbrlBVpkbKMhIFPP/klKjsAKeeSAaeon3jarT
X-Gm-Gg: ASbGncv0eCXH9IyYGbKRkHMh9kxAlW3Fr/JDhpd+Y3GWPySA/plEDqTLXkQCm+cSqtq
	WX93Me9KOOHF3V0eDW/TTH1hNQJYl34U7v9v2eJcN+tlcY2R6ilIBIJkl/D7+K9M6+LI1lYNEtz
	qy6+BJ4Khp7DYmS+2S0LoQynyilePjQ/NlyRLEZmFp2m4gNDq3iIuQZicmRZ1ZPmFQg0U6+140l
	8Igb8U7mFWF0FwfBrDoVdAXtLk0Fesvm58/Fy50//mfk9vLoANVcdFT3hbAXvap63OaTDbYHKRl
	jcZZwIVJCh1SnSzZ7H22Tr8y2cIGLmJ71EFU6CpiVAgAFGr98SVyf469UAddV+6skf2BKjV3+T9
	LSSSWe9kKxXeyHi4dpF0=
X-Google-Smtp-Source: AGHT+IGO6qNyMGRvR963+xpPXWdS16jJx2sEAFk2rlIOtDL+gt1OLO0T5tYCAfYC5Sf+S9gLqrFUKA==
X-Received: by 2002:a05:6214:2389:b0:6e8:9dc9:1c03 with SMTP id 6a1803df08f44-6f2c455f647mr66305356d6.21.1745009433041;
        Fri, 18 Apr 2025 13:50:33 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2af11d7sm14355906d6.6.2025.04.18.13.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 13:50:32 -0700 (PDT)
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
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v3 5/5] staging: iio: adc: ad7816: Simplify channel validation using chip_info
Date: Fri, 18 Apr 2025 16:47:39 -0400
Message-ID: <fad83a7efb12c0f40dc2660cf9dd4c57422ecff9.1745007964.git.gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745007964.git.gshahrouzi@gmail.com>
References: <cover.1745007964.git.gshahrouzi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the channel validation logic within ad7816_store_channel() to
leverage the max_channels field previously introduced in the
ad7816_chip_info structure.

Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index ab7520a8a3da9..b87934aaae581 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -204,19 +204,10 @@ static ssize_t ad7816_store_channel(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (data > AD7816_CS_MAX && data != AD7816_CS_MASK) {
+	if (data > chip->chip_info->max_channels && data != AD7816_CS_MASK) {
 		dev_err(&chip->spi_dev->dev, "Invalid channel id %lu for %s.\n",
-			data, indio_dev->name);
+			data, chip->chip_info->name);
 		return -EINVAL;
-	} else if (strcmp(indio_dev->name, "ad7818") == 0 && data > 1 && data != AD7816_CS_MASK) {
-		dev_err(&chip->spi_dev->dev,
-			"Invalid channel id %lu for ad7818.\n", data);
-		return -EINVAL;
-	} else if (strcmp(indio_dev->name, "ad7816") == 0 && data > 0 && data != AD7816_CS_MASK) {
-		dev_err(&chip->spi_dev->dev,
-			"Invalid channel id %lu for ad7816.\n", data);
-		return -EINVAL;
-	}
 
 	chip->channel_id = data;
 
-- 
2.43.0


