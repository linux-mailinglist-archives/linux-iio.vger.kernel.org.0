Return-Path: <linux-iio+bounces-18307-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12580A93F28
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 22:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF15D8A887E
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 20:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA79B243958;
	Fri, 18 Apr 2025 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+r7q4vb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BDC240604;
	Fri, 18 Apr 2025 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745009429; cv=none; b=BoBx2C9z+BzV/wOZDIZdJjG0/nlayDEOijkc/2+t3VxdhgXYWFt1BJpED7T5wFcFeHTFg59uUb3bPhMLBYoxHTKu5+t4AqZnmWv+Kq4FGJ0AMnvDYUuzCADg9pSwgQCydyvYT4s3NBtAAo85PGsD6JhJvlLZhuUFK6iT2Crz51g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745009429; c=relaxed/simple;
	bh=nhjNiEws7JDfpSABnQRCrgaV/jVLhmHTd1ukZHOLh3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouw+PqwIjk7NSCbYIg2eQr3TtlXzH+bWPo1ymNBZ89ei5r/Z1k6EWgWthxnWYAUJSBNOTsljkufM+LlpjdgoBieBa/Qg3AFhdiAhmcJ7/DdE6FRQWRcnpkQatsjkcg3zKSAQUNUMzASQJ3+NREJt/Aj/BxpjB44s0eZ400Y9MrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+r7q4vb; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6eeb7589db4so23675686d6.1;
        Fri, 18 Apr 2025 13:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745009427; x=1745614227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gk0TUJMIcvb2/Yt9CvbEI4RZU5fYHN3893YNwk+aijI=;
        b=l+r7q4vbJekjYwygdQm/7CHUhOwXIPCQGEQ2ZHl6NJ5hHb6FfWTJ9VWTmxLyZtKTkW
         q92penQhTV7Uz+BO3kl2H160a/AwxSJ+fNJ39TS2cbQC8dc3hwd/z2spP76PrO1PCmT/
         h0cwKtvkPagWFlZ/5SZ8s0ssPd3n/WGJK0v/1fVRS9Z4li4B0RqhxUdHwYiFHm6ONhMh
         G/WNQVFrQcnzRwHlCvMr+ucgErVkVfVEjtFHTRJTeLPqjepL831nlXSYDt19uXYIcinR
         52DYa9sUqNTkOG/CRZIPmnOy1UtPxIlja678gW6uzQpUQDioX9AnGKDLHPOA0nq8DXEC
         mQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745009427; x=1745614227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gk0TUJMIcvb2/Yt9CvbEI4RZU5fYHN3893YNwk+aijI=;
        b=r+gEru0uJUJmsfB56u6k8eopji1G19Pw3APRbMmBkxjdx3PQ3KB9a0S0bwPeM29/Wl
         1buu4OwZF3ApG55LvKXM2I6+HGsirAcN41teIPNVg+YTo1/pWjJ4fHVP/4SbwP+dUTIz
         IYj4aTgKSqVUDCjpnpFcLgqy3I9v3ZtFAAO39tAyCFiPvz50GTDmVU+PlWxxllBvcBGd
         wJsJ+NTc92AROCKrZCpZ39ftcNFBjlCOyqilFFSOkuEZjF2mY+IcJRwil0zsL143eult
         rkhwdTTXJNqQJdYvmHZPeWLwqRCBEIDpTqwKqe8K1ziNuFow6srUtpIvZW5T1x+DfX2Z
         LaOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmALTBQQvaX5d8tSD2eGBuBcZx9NNPJn5iYebJb4szam/BHxLZBMgxMt2vkWNzEPLXKcZxIXU5@vger.kernel.org, AJvYcCWd4l9qeDz51iGY/yU0vNgOzLOGx6KUEXvNpY9XAmt81UxiKhx8+3uxxQX1tzVxNNNLVZatQN/jkUgQFVdX@vger.kernel.org, AJvYcCXdgr92Dhlh7SSwoQLhc0Lo+vN13/1RYnMFynO1s+MEb/5DmGjHPjVEeAaGLjO5F0iSbyuAE71/erY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1nbIlFyQERROAgt8v5CP0GDkEuu2w7+lCpRpoGJToGQHpdFq2
	GWLHm9onkkDIyOYneuDsCeeJq2igOR6ABLeoI2w7nseOM7lpcWFk
X-Gm-Gg: ASbGncunhdfvtnjZ1V1K/EANC1uuRWV94CXDp7kA6z0QoVmGVpGRM7AwRh7jCuImiqj
	z06KW6diVn4ztakEglBdl2BbYeh+QtMYk5AO4RzcbVm4cud5YkNcWMuD61rRuUrue3YPf9GsG2I
	RP8eECIke3oWV7zjLWGOUqP57oO8SB/H7jkh1kBS1W2GmgnaCd+/DUTuxxRBXqZr0t2Su3OShA+
	XzoGWZeNkaad9WSz52I0chY2kB8bnrwN41NxUub7+Vak1bezSiVMDHybmRqRERkkL/3Zc5b/WfP
	9j27IwcwUl5K9P0dbaMwNbZOdPJFOUWlPsvlFNEHqLySL+08C2hI5xiu1P4pMwipk9ymSsdm/aN
	irPHZhih+ssgE8i5VtLU=
X-Google-Smtp-Source: AGHT+IG9VgYTosOoLsZ74LQUJV3FY30wheql8pLd081+4mwYIwUcq/Vd77e5NAMewbOoGJBQ0G9b9g==
X-Received: by 2002:a05:6214:2b08:b0:6e6:6a6e:7596 with SMTP id 6a1803df08f44-6f2c466f4d7mr61499376d6.39.1745009426846;
        Fri, 18 Apr 2025 13:50:26 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2af11d7sm14355906d6.6.2025.04.18.13.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 13:50:26 -0700 (PDT)
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
Subject: [PATCH v3 1/5] staging: iio: adc: ad7816: Allow channel 7 for all devices
Date: Fri, 18 Apr 2025 16:47:35 -0400
Message-ID: <a9ff726ecf80ad7df494e6b0244ada95d6d07a73.1745007964.git.gshahrouzi@gmail.com>
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


