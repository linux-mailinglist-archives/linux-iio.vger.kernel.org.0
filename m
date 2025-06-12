Return-Path: <linux-iio+bounces-20534-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2693AD6D13
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 12:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1CC170AD4
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 10:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9445C22DA19;
	Thu, 12 Jun 2025 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RM1fvmwJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AD0213252;
	Thu, 12 Jun 2025 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749722932; cv=none; b=EkAS5jdeGe+alPyTfImMiwARJ1qCnw5AM8UYDEfN/SqjFIrdbCQhGI3H+IADz4C5QOw0kRv9RKzzh3Tt16uqL2eqG1R8IM8o5EtB7l4l6OVnLGXqAB43RvpqfFvkmolbM0ZFr9Y10rUAw/XN7tYQ7V5Y/2EU4+v1qrV6zphcl8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749722932; c=relaxed/simple;
	bh=zBPKl4uVirvceKjjgnebtWburYZsTVAOEZuT70SAROo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gg6BzAdR6P2eKj4sX3Fy9p6Ld6N/B476ig/i0tbjnJHlbcIIStLirteHy5R38qC9CfTsLx25ZP6fPIwcUdmIK5MZw7el8eSaZeuLZsWxLRx89F2rQtLany6LGKGJOBAmK5lnoPXBrmBu/NKQcY7qykaCU3aanMenmoBtBztUIlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RM1fvmwJ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742c46611b6so965710b3a.1;
        Thu, 12 Jun 2025 03:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749722930; x=1750327730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mc8BIA9oq8U7lDjk7jNrjHDPE8sAjarcaj1dDakqEDA=;
        b=RM1fvmwJA/G0CG8S/kdFbZnUNkNAaFyiVwMP7HAQNlHFN/Nk4c+zcm0Bs15lpv1Plb
         2oqQIDh7tnnBs0yf1a/u3ZdPbI+MTc5gGLlsUncNiVGD0jjn1vzxIzf5O7nRAoIsQ7Nq
         Zra6CCopHFjW1G+2TA2i8+DhoIvAbKKtXq8uQGxUuzzuCm3fZPfXmt8IPUyJXQzM76fy
         BZv+w6Buz3hkPBFLGxr7cmtochfSmnvobUqVXhhdZVU3+/iRvFMEZ3qO/rEb189M/NyL
         RElEPyNf3q8dZ6Bq2RuxnoIXi33NTLj7E6AHf92+Ry6SDCApFVD03qFag5OWx6qavn8q
         9e/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749722930; x=1750327730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mc8BIA9oq8U7lDjk7jNrjHDPE8sAjarcaj1dDakqEDA=;
        b=ghndDhKAOAR/7VU15vdKFpmGca5UtLjPZ/+lChuxguGUpJ8y52j2XtPolQzok7JeP4
         EU92MLSqBGXF79JujMlj7BZfHsAjhmPktYsvQic1cXQ7DcOjQofOw4z/x67sCw5bYeVJ
         DzFYNghoL9EVfCfsYPauyzuKUEayEJ2eNn8Xf8qQmOpi+UPp2eJxxwOK4oa4Sw4k8cA0
         QICyPp0Whh/N6UI9yrjGSM83T0LNTpq+z5vtl0xutzj/AY8uv7BxB5qud5mWvjVuSQjZ
         BKchROmMKa5vTbmNlSRh4He/vTooTiJDdadk3IaZ3v0eNK/Ndv8KjLl8P3E8kiplcGoN
         3+Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWMAQyRqALZ1xu/fZXxD0dttzitsJZJUXAr5ezSTXlHFMnpVIWyjqvTaMzTR+WQQPIUatFG4sHKQ823@vger.kernel.org, AJvYcCX6GEBhcr2g8ONi1FPNltkMkmVoXiqsbjZt6grVbOtQ9EbO2xovVWJYg/GD4pLPKQ4X1dDY1FliuSn4@vger.kernel.org, AJvYcCXL+9JUyanOOnUW5wDAg2iHcsmCDla+rRWhgwdc6Y7c5k6SVqM7maTHhNSaRCgemmCb8p3zPrd7V5OOAuBo@vger.kernel.org
X-Gm-Message-State: AOJu0YzEY1tvT0oTqFhdhkI76cYf/rz4CFp0EeS3jo7CzTpcf0uDfSs8
	+rcfAe66ZeQTGqdc+//rydKub9apInLXOJWj9NGg7JCGmoVoVFUIn//b
X-Gm-Gg: ASbGncs2TW1zdh0VbU4oK02dEP8Dfz9vAAccuh5qq192vPsS+ATR9kfSZmuVyt4P1Fz
	yCVaUCK92af5VoOZC5w/fMliYpDpGIydugT6i6CzpvL/R7KUPAE722euTfMSFtaJBQFSpIhCqDh
	5wgR9ID1Qq+r5PXu+DPcrCp4RD//sbzd3cAulzlo7nc23E3YY65GrZoHokJicGFV0/+4bypnUBe
	QuH9UdZTdv1bQAeNHbA+F9Mf/0i3jK1NnmBna63vTS1X6+TDVcuC0jeKZV1Hsj+vLR3rxjkzsax
	fLeTZwmhC/Mcy2zIKVsMHVdTqwJga86MUB05FlDiRdz3CU9X0Xl8WccTfugyXY5WjLwQYv0DNQ=
	=
X-Google-Smtp-Source: AGHT+IGRKwxyC+CcZW3usEfTevDdH1XanWPrkfM4At6TwByLkaeDef6rXgD0G+YaSXbhHZK1ikQR1Q==
X-Received: by 2002:a17:902:d4d0:b0:235:27b6:a891 with SMTP id d9443c01a7336-2364ca469aamr50857315ad.28.1749722930165;
        Thu, 12 Jun 2025 03:08:50 -0700 (PDT)
Received: from localhost ([2409:4071:4d30:50e6:899a:ff8f:cff5:9bba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e61b49asm10327025ad.18.2025.06.12.03.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 03:08:49 -0700 (PDT)
From: surajsonawane0215@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	surajsonawane0215@gmail.com
Subject: [PATCH v2 1/3] iio: Add IIO_DENSITY channel type
Date: Thu, 12 Jun 2025 15:37:44 +0530
Message-ID: <20250612100758.13241-2-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250612100758.13241-1-surajsonawane0215@gmail.com>
References: <20250612100758.13241-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit

From: Suraj Sonawane <surajsonawane0215@gmail.com>

Add IIO_DENSITY channel type for particulate matter sensors,
with base units of grams per cubic meter (g/m³). This is needed
for optical dust sensors like the Sharp GP2Y1010AU0F that measure
airborne particle concentration rather than raw voltage.

Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
---
V2: Initial version introducing IIO_DENSITY channel type

 Documentation/ABI/testing/sysfs-bus-iio | 8 ++++++++
 include/uapi/linux/iio/types.h          | 1 +
 2 files changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 190bfcc1e..9b1b538ce 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2383,3 +2383,11 @@ Description:
 		Value representing the user's attention to the system expressed
 		in units as percentage. This usually means if the user is
 		looking at the screen or not.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_density_raw
+KernelVersion:	6.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw reading from an optical dust sensor.
+		This value is proportional to dust density in air,
+		with base units of g/m^3.
+
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 3eb0821af..e7d09ec0b 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -37,6 +37,7 @@ enum iio_chan_type {
 	IIO_DISTANCE,
 	IIO_VELOCITY,
 	IIO_CONCENTRATION,
+	IIO_DENSITY,
 	IIO_RESISTANCE,
 	IIO_PH,
 	IIO_UVINDEX,
-- 
2.43.0


