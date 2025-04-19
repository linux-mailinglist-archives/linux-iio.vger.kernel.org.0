Return-Path: <linux-iio+bounces-18323-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA59A943A0
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 15:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832783BB34A
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 13:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9150A1DDA09;
	Sat, 19 Apr 2025 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQjHYoi+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2131A2390;
	Sat, 19 Apr 2025 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745071004; cv=none; b=CiDFdzbBJp4tVwxaIR7e3uWxHlkJK9lg2eVDFL26EPEJmRcdGukBzRkbDbnGtnL33emFuXLVkjJfUITwid4uzrGHxNR2B/4qFOeBgmGJp1iaRyY0o5Y7a7hKnrexINhWDR+9oE4UmKmSWM3lCXA6CsiZst28rq6+zhAcC78mb8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745071004; c=relaxed/simple;
	bh=nhjNiEws7JDfpSABnQRCrgaV/jVLhmHTd1ukZHOLh3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tN5Veg1CjhTfyyZzd7P5lkFFXQKAXov4oVSyla8LhtYS/px1fYDHpMvZntoqiMdji/GrPixGQg3WfqNTKHFdDcn5U0sdeabxdyRja330CH18gqwDIRP0GZFLBkoowToFQwAG8VTlOKUV8gP1uPDYn8Yn4kZWtOwxD4Wj0aLQMLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQjHYoi+; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c5568355ffso213636085a.0;
        Sat, 19 Apr 2025 06:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745071001; x=1745675801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gk0TUJMIcvb2/Yt9CvbEI4RZU5fYHN3893YNwk+aijI=;
        b=jQjHYoi+O+tliMaVb0U0Ioxo0R45+1fwaMS/W/2mHwj82VorTVR1Hdze6XV4Z4huKG
         +LHalZce+R11sQ+Z7I+aouM+s9WA/2kVwCD8YLoUCeBLDCk3IJ9f+R7cTJpEC7eEfwbx
         RC6Quvp/5RY5Cvgks3yFW+mRKcemEgmJGWyZzVuHIi1iitOG2UIbSZEb9d/VVFfwk8wI
         Y9nCjSFK6oRfZUuzwKEhkLGOVfc28Gxp+fILpvKt/nBoa5ytP3P44G4q7eS0ulW96oQJ
         5hCOQEfq6Vuu9s2t2nvwmrRjbT1UZ7iiOMG+Oh47G0Z7dAUXQxbfy9voDMxSkCmy+elO
         kNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745071001; x=1745675801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gk0TUJMIcvb2/Yt9CvbEI4RZU5fYHN3893YNwk+aijI=;
        b=clJlLrPiTX5VyRwywAEVtLcYbJLwj2qnsmn7duxGBsHjCOFyC3HhMpEESocbbWO2mR
         gzTJa4mzka9yytEQHhSGOAjmYR6yLTJBsc/uY5FUrBo/tyGsi2YCM2PVlpIsrckbMSHX
         NsDUAhCLwOPQgGQHhMGIx5hrVo63A1H182qsvPWM8dOtpgtwLHRqJASMS3qmb+lAmofX
         RqejzR8YjRNJOdq97HRMFeI7bKAtFPgeJEKXfRhhFgunoq6AHfGvBifSLNHfSoSvmFJp
         fLdAcTxiI6XD/sM7duNvywfh8jzJzxW2fMtBEe/9aGnRNTAgBkhPhskh03SRgv/hkMHq
         bNqA==
X-Forwarded-Encrypted: i=1; AJvYcCUX6OWC6iHkYYj+3TVXbLj4mH0NWam8XFK35/8FW7UegHqY1J8GCZGVkAF/E5dNQjY5dsOw7VTtLIQ=@vger.kernel.org, AJvYcCVlUT5aGf+g5UpIU6KGieneeGvq/xCM9OzKC2oo+sGOnY+T38b+d8baRxG/dj7DmbFaU5/Q9efA@vger.kernel.org, AJvYcCXNAX+J2zeAmAxo5FdCQUBza8mpMIPA+ACHacOvsHB9I0P0BIJLWdXazmMw7D63scNgncXuNP9ylACAtp9c@vger.kernel.org
X-Gm-Message-State: AOJu0YxFbQuUSIc0X0BPuNC2v4GIo4F8GeIPUrV75HohZ5ELLJEhqnfl
	SPkb3nwElP51Z0CNWaGiaCpv2OVFteuORMvA8Du/LrVaI13CWE8v
X-Gm-Gg: ASbGncu6xxqGqnkfXKl0I0+NVCd2QlDMeze5AywH9sHJZcnZpvLbGiJL/gAqErNGcE3
	7t0qESE+j5KoJkKy7h+hKtLSn2YZk2FwCFmmj8BxyzZ2imGreYeBQkigdtwEAeToZQNe5/1BoDg
	HUbwQgpAeFCFMx8Nq+9Ra48nRnxhpGetUh+SAPayJQMI/nNJZ49q5odTo7PFVQipA7AuX3iEtUP
	u0A/EVGCBbPHPGMLEQi2cqiRePMOs/ivbWb/GDQB4qvxBtVlYJepfy+a2QdayisfWjynwFHcism
	ZGGDpWOerWLiWQwyfVVzd8khhnxpEO+s9jnQnvh/e1okiW5SMpZ79GrJSN3gf4G+Nw==
X-Google-Smtp-Source: AGHT+IF/z6GEDB37r31F0OmR0P3pDnZmdP9f9ReQJm7FpvmCkWJBHCBmLHMxzR7sz1S46RqTgA3Cew==
X-Received: by 2002:a05:620a:400e:b0:7c7:6543:2018 with SMTP id af79cd13be357-7c927f6b2c4mr926327385a.7.1745071001441;
        Sat, 19 Apr 2025 06:56:41 -0700 (PDT)
Received: from theriatric.mshome.net ([73.123.232.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925ac4749sm214350185a.59.2025.04.19.06.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 06:56:41 -0700 (PDT)
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
Subject: [PATCH 1/5] staging: iio: adc: ad7816: Allow channel 7 for all devices
Date: Sat, 19 Apr 2025 09:56:34 -0400
Message-ID: <20250419135638.810070-2-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250419135638.810070-1-gshahrouzi@gmail.com>
References: <20250419135638.810070-1-gshahrouzi@gmail.com>
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


