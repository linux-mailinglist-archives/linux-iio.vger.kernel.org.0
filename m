Return-Path: <linux-iio+bounces-4740-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AAD8B9136
	for <lists+linux-iio@lfdr.de>; Wed,  1 May 2024 23:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A209D1C23171
	for <lists+linux-iio@lfdr.de>; Wed,  1 May 2024 21:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AA716ABC2;
	Wed,  1 May 2024 21:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="KwBizn21"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30445168AF9
	for <linux-iio@vger.kernel.org>; Wed,  1 May 2024 21:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714600674; cv=none; b=loe2OZz/YkdYAOynRHs+9RI4qfQ6f3cQ4FAjIceUFyJsS6dSTFawYfTFRsOFhjimm1jYeSZzJm+wFWCnnYP5PKm7SvkIl9vfX0oF9P9GTPUq4txvq868IyaZLBuWS3yb7rD8eIdfGWzDnyvYLzvGsGYPhuLPmPIlRBf+6GK2048=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714600674; c=relaxed/simple;
	bh=xQBDyYq+q7mrO43UsmzsJAEVIv0sNrh7F1MXl1TVyhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SusPJCAkX+4x9BzNk4VEzS9a5YGdvSDLFqtMef+Btmd4FuFHlYfX/13fRW7uGnapaS6Xq2XzfMVuJQW6pget9+xlolRPQOcvLRDvEPshmNIV+fTJRQSTgKD5CaoxNQMZjXeGicm4c9u0vhvJpOHnp4+OgNeOASwMNYu4WvAXRPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=KwBizn21; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7dee37ea263so94396839f.2
        for <linux-iio@vger.kernel.org>; Wed, 01 May 2024 14:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1714600671; x=1715205471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJ8W7jumY+a3Z7Yvkg0jJPfeRZ8DJgpTlOFfp0kNYS0=;
        b=KwBizn21coqS1sWuzU9/sbZbDflwj0HqI3tO9r+DmMZFKMR7d+FpFXNmLUWmVoucnL
         eu/4oQBbA0PnODSoYNZjn447rY1302gsLrqwe4SyVC83KzFRjPerWvST4lf/UPOGKoVc
         fOnLRtwBQ2+ouXfDfFbGWqbPE9TnE2pGUINVLvwa/R2iDa+Yljs+ePWftPhyXTP1bg29
         vk2zoqZT0+sASw9CSwqcwHM2MG4FHJPaPJkiZXPqWjSl3Q5S97yNq2rzSfTLvQovMrJX
         n2OI6d7TmZ1YokBheQbQYeQynztfHB5fI+T+/Ngt3gRWzC2PNWS49yUE+6fIXdNZL7NA
         IzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714600671; x=1715205471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJ8W7jumY+a3Z7Yvkg0jJPfeRZ8DJgpTlOFfp0kNYS0=;
        b=NzKEMITFtImylQAGFstJcCI3LVOis1LqgyYy3TxTZq8OIV2/EP7qUGWvyaKQwGM7U+
         9veDTyMTlcuTcHivbX9oNw/r4/kIb6WTuFLP04D+qVdBGfNer8oetpeQdKjPpgwjAsyp
         8NaYHoQwJzV8x/X1R48f7qPWfM6BNHiAnHkzaS7LmZc/TiG4N06eg3LKPlrXp33uBw6O
         P8Oie/JIwHoz1F7fzO4FjOEzmdMzzy6ZHpKa5MLJPsKdr5TmBX+8u7cS8EgWFwPfBmrI
         jl6vFbEkB9+u/V2Vaja4NDFtqH4Wn/roHOAE6h1uGII3NeKJDifHPMqMbHcmHgL3Rg5T
         eVJw==
X-Forwarded-Encrypted: i=1; AJvYcCUbLsSrmjfhCy5WZbRN2TKTlkGq5rnyFHauZFbpoqCAWJg/FSPa3q5Z4Lzztn+CzEws3/Ro5uYl0OgDipmq6FuR+tn4Gw+rbkAC
X-Gm-Message-State: AOJu0Yxvmb8acCeet2NILv8I27xsAFauD/+kodj45vramLlbn2cFr8ze
	N2UU6PlhTFx0eKLAO2ZOEscYN/H8CNYPhHr/7SLCCqASuKQQE7NIxLVWCHwS2bQ=
X-Google-Smtp-Source: AGHT+IHqU/KfTKnIiExWiOo0mDLyusJfvwwGprsq5KSU4nxd303ePIGAGM323MyiBXfTrxpmawhTNA==
X-Received: by 2002:a05:6e02:1c2a:b0:36c:5124:eb35 with SMTP id m10-20020a056e021c2a00b0036c5124eb35mr4551489ilh.3.1714600671159;
        Wed, 01 May 2024 14:57:51 -0700 (PDT)
Received: from Rigel.pinscher-bonito.ts.net ([2804:14c:34:2097::6c7])
        by smtp.gmail.com with ESMTPSA id y5-20020a63fa05000000b005cf450e91d2sm22919843pgh.52.2024.05.01.14.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 14:57:50 -0700 (PDT)
From: Jorge Harrisonn <jorge.harrisonn@usp.br>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: Jorge Harrisonn <jorge.harrisonn@usp.br>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	laisnuto@usp.br
Subject: [PATCH 2/2] iio: adc: ad7923: using claim_direct_scoped for code simplification
Date: Wed,  1 May 2024 18:57:24 -0300
Message-Id: <20240501215724.26655-3-jorge.harrisonn@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501215724.26655-1-jorge.harrisonn@usp.br>
References: <20240501215724.26655-1-jorge.harrisonn@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using iio_device_claim_direct_scoped instead of calling `iio_device
_claim_direct_modeand later callingiio_device_release_direct_mode`

This should make code cleaner and error handling easier

Co-authored-by: Lais Nuto <laisnuto@usp.br>
Signed-off-by: Lais Nuto <laisnuto@usp.br>
Signed-off-by: Jorge Harrisonn <jorge.harrisonn@usp.br>
---
 drivers/iio/adc/ad7923.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 9d6bf6d0927a..a646521b2ef3 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -260,22 +260,20 @@ static int ad7923_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
-		ret = ad7923_scan_direct(st, chan->address);
-		iio_device_release_direct_mode(indio_dev);
-
-		if (ret < 0)
-			return ret;
-
-		if (chan->address == EXTRACT(ret, 12, 4))
-			*val = EXTRACT(ret, chan->scan_type.shift,
-				       chan->scan_type.realbits);
-		else
-			return -EIO;
-
-		return IIO_VAL_INT;
+		    iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {         	
+			ret = ad7923_scan_direct(st, chan->address); 
+				
+			if (ret < 0)
+				return ret;
+
+			if (chan->address == EXTRACT(ret, 12, 4))
+				*val = EXTRACT(ret, 0, 12);
+			else
+				return -EIO;
+
+			return IIO_VAL_INT;
+		}
+    	unreachable();
 	case IIO_CHAN_INFO_SCALE:
 		ret = ad7923_get_range(st);
 		if (ret < 0)
-- 
2.34.1


