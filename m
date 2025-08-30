Return-Path: <linux-iio+bounces-23494-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E822B3CEC9
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 20:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34997C436E
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 18:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1920A2DCF6F;
	Sat, 30 Aug 2025 18:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RROIBbWH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741552DCF50;
	Sat, 30 Aug 2025 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756579413; cv=none; b=Twc716xUbg2df3mPIRjfbshKwwLhx49G7jF+wWPzraAzC/hX4/W8QK7LORalQnZd22nxbcDfUcD4NT4R9N1EOemwowr4nfpkmlmashgtdHh0jGH8YqNJkLq9a2LrkTAEQyVeLDnkvF+6Ww9yGpM7ldwGLaKlQ8AAQlcwstxwKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756579413; c=relaxed/simple;
	bh=S+oKo2tgTYiLtkAAs/iP4uzBUDKP2L0uoFWdETTsrIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lOHGgeoFLu2+gdKk12Zc8lD+VXD++qTwkTntaxFCocZFuVN4EMcomsz0gRv+AbDmfoPobaQZFE0mtXBIJ09OIHuFY3lN9HpDGmny4x5hiH6mOoePtr83jzPMVhiJoByl6NUtK7jcUQJcJC2eUj5N9aMems0m9uEwixsjVhcy8QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RROIBbWH; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4c8bee055cso1932910a12.2;
        Sat, 30 Aug 2025 11:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756579412; x=1757184212; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KZOnwZekOaDbGKj3yK05lCuGyy6Vu2QerK6bAmRqEcs=;
        b=RROIBbWHD8WVR+u9WPTvPVpROyis+niqiZmjvk1J/CzWb0/FXzZQoB7q0BodVJw/a3
         7hlBmtaeILbWB+UaZ+6l7jYxD+AihUNtmOA0GrinZ2XrLTrGm0A3cIwAaPRwD9cGRCrd
         cVGt3+LrhhcEMxk828eClf7IUl+YE7zY8ZESInxV/UXu+10L3Ao74PfZhU8XNB9PwDIk
         P58sw5bqielQyHjq5ta1tZjOjBB5shzGK8p+PhJbQDqPcb3QgSqRYL4c7HsjaPqo8IM7
         3SbVLtBqfC1n8jGPhfD/aATCuAm4Y/15T+ZJ1WZAne6qDdKLrG4J5J01bXo0LBAHd6jM
         aG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756579412; x=1757184212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZOnwZekOaDbGKj3yK05lCuGyy6Vu2QerK6bAmRqEcs=;
        b=Tg0s3ynjGmMgW62HY7pATuK43MIxKU20cDwRdOj8frYS48WDjDf/AcfpSIoUgjgPta
         Tx96neMkyR3lYKvPxJKLTDmW9JimPV7As9LfVBPx2wlaCi6loTxAsz6a6nP6IQhe9PJm
         d2lLrr04UE2WbKF1kzh+7k1Gf24h/7hj09AwKVvs56uBTRXipnf08AcoPlgqtFPtF73k
         TS1wkSsHBklRV0suW6OfHBP5DUj/R5itJYX5JaA2nO+I4iVByGuGd1lZnJmYmDN6NrPB
         9PK0UG58NeaOxl5roNWK3rwmUyzDi56Y0iczTZ2S3EAy5bBL3F6PU1Ti6K8C1Hm6ub7d
         0N1g==
X-Forwarded-Encrypted: i=1; AJvYcCWOhxd4lb/WfER96eiVsCXvNgn2Vnv9bVHzZojnjBf6e1SWT96zm+snHbHATtCnb58QgUxmo2/hWyTCv1I3@vger.kernel.org, AJvYcCXYaevbHiLfTlKcU0jVQgNlD4Ep6r4p9rqXAVzg4DLG8bleMG3PedO4aF+G20zjQSrShV6U3Ei2Debn@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7X23z0k4IHIaeSXlRGdFdrDxA2oa/0q9U3wfAnJJvAI/TLRXp
	gCTsD03fnvYjqdZgk+vznOl2fGKPAbxlR3u8O5X5IdKPtwqhjoEia4Q3
X-Gm-Gg: ASbGnctPtfFK6WNnewjFStc+3gqoScxa8N/HkYT2iKimg/BA/ALP3DUlYRikCWYinPB
	FfC9vC50Izw/DawVZr5gpHWyEdaSypFrLg8JeHmdUFCE1GFDNPzRAmGnStcKWKxiDOcWUZv8ZCH
	zYPDaY+K0OeBL9TrT8tNubOom/7f9Q/ehc1vbNed3QpnaYQo6t/rp93HLaxTW58iRP1wM1rZngo
	BVjk+tFYQRrimLi0RBvxtHEd061E+AQtQwrwJfguMVbkH2yxbAJU6rrGHKhLv3+vNunyWAWhf2V
	5sLpGCX5SO6vtV3py/poBbn6i5v+RiHRXWfZzeSPjfqNMokIigUzFBLiBj2/iqjDY2HgL/1aa1f
	im87pDnsx7m7VdnQxy80KDAjMnxmJtfevaVuSQM/gv4cBKV4U
X-Google-Smtp-Source: AGHT+IHYGOm5+YbIns6Gdfpp1RfTrqSBfQ1d0sSMr46tzjRBEaCKJ+Lss28VIdCdoXY0y+NbqqF78Q==
X-Received: by 2002:a17:903:2302:b0:24a:a724:717f with SMTP id d9443c01a7336-24aa7247fd3mr7687955ad.47.1756579411724;
        Sat, 30 Aug 2025 11:43:31 -0700 (PDT)
Received: from [192.168.1.19] ([122.177.240.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490658999fsm56821665ad.112.2025.08.30.11.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 11:43:31 -0700 (PDT)
From: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Date: Sun, 31 Aug 2025 00:12:48 +0530
Subject: [PATCH 4/5] MAINTAINERS: add entry for inv_icm20948 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250831-icm20948-v1-4-1fe560a38de4@gmail.com>
References: <20250831-icm20948-v1-0-1fe560a38de4@gmail.com>
In-Reply-To: <20250831-icm20948-v1-0-1fe560a38de4@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, shuah@kernel.org, 
 linux-kernel-mentees@lists.linux.dev, 
 Bharadwaj Raju <bharadwaj.raju777@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756579380; l=899;
 i=bharadwaj.raju777@gmail.com; s=20250830; h=from:subject:message-id;
 bh=S+oKo2tgTYiLtkAAs/iP4uzBUDKP2L0uoFWdETTsrIo=;
 b=6z849XXWAt7R7rAf/Yg/X3SR9rpCOP6A4q9xnBBV8HCU9Hnwm+pGJNaXiAK1ltmo7PYZD+5a0
 wTwk6br0iv1DUfwZl6UqcHQf9G7tzzNloftBTO/ert414NRKjoMKtgl
X-Developer-Key: i=bharadwaj.raju777@gmail.com; a=ed25519;
 pk=s+pP76EgUCC/7pyu4E6Q5AizWQ1T6hUf1jUWrQRl040=

Add MAINTAINERS entry for the InvenSense ICM-20948 driver in IIO.

Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa45799dfe07de2f54de6d6a1ce0615..930c80c1cc40a4cfb4bf270e1ab7680b88d97ff3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12783,6 +12783,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/i2c/isil,isl79987.yaml
 F:	drivers/media/i2c/isl7998x.c
 
+INVENSENSE ICM-20948 IMU DRIVER
+M:	Bharadwaj Raju <bharadwaj.raju777@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/imu/invensense,icm20948.yaml
+F:	drivers/iio/imu/inv_icm20948/
+
 INVENSENSE ICM-426xx IMU DRIVER
 M:	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
 L:	linux-iio@vger.kernel.org

-- 
2.51.0


