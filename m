Return-Path: <linux-iio+bounces-24040-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2543FB556CD
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 21:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C5A1CC53B4
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 19:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B424309EEC;
	Fri, 12 Sep 2025 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Fh9xv9Qh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA07335BC5
	for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757704217; cv=none; b=I+eRnOqeMmDYwUFj4kpxJxv5YKmpm1JWHxdM2/aGvebteSZoPuqcjZWB3hEEK/smlJOXN8O5j0vkkgVzY4YP1Nu5yeS6xqKrsXKsecoCukTpl0q6cCAsCxo+5r2Bv+JyR/K136D8gqNZDXUv/TitXgefFLMnWRaTwDVHfzrMFZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757704217; c=relaxed/simple;
	bh=22rZRQwccdDXCdWucL0md8nKZ5xUlhtkQsl5aauAsOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sjyaeToNtERnC4/n/uYQ3A4N/mfTqrUi+ZeRGJrFbYL6bf1KHqS0rkEsiBnJkstnDR+Eo8xDgWjc1eOsZAvxOpG69eXFepiwmM8Kum8UjtTiJVF2daSO/RFTFDZapzvDJM4qigiKjADx0xZnRt0ugNTI+zMw1tKzNeY78qduZXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Fh9xv9Qh; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-30cce50dfb4so1705397fac.0
        for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 12:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757704213; x=1758309013; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdlmWREl3KGVca0VuH2Pgk1lTP5tsygacI/dk5FYqvU=;
        b=Fh9xv9QhDUtcPb0v2qovXrMRPKHInIIEbWfThs0u6NVMgo//LKC2JM3gYeLq8HUVyD
         roVGjQdN7xx9nQyZD4Dj1ACdrt0HsQ1KqMPSUHtv1wUwlxskrruEg6qBOVXO+5YJQYcU
         LOq4uJfzHdn6DXJD7CSJrakY9G2nDWGRGqCasyXBYn9ez8dbh3gmOJotaGseOAFD9e6N
         TV9aXINt8VOX4hh+R81gyI6UcyxgIFO6h/mX/gNuH9qUDoABRG9FF1fmCMO3bJsicuJV
         RGI+cI6GZn6OF2J2swDUikPjRbYnB6E/vc474M2O8bSBjfjuhX15HvDTgcHIbnaREqWt
         UDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757704213; x=1758309013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdlmWREl3KGVca0VuH2Pgk1lTP5tsygacI/dk5FYqvU=;
        b=dBVg8bkMxbO1HxI8Y+X0WeUpVus8sTqFVYSNTFuljNU9FSuYzZ9qEuRpPU8+WB35i5
         MvSytLftEl3c95XHPqD+lwC3hpVH7NEAvFD+QpaTj62KjWSBDQFvXX0tpz6pcowDMEcT
         IwLHisscP4xKMkO9tPfD6sQZK11PgtMBNow7oiwh0KZhf5u/tVnxoVCq2LbA21VWsUN7
         P+EfSO7TDuzjvDLUx0YBU1T6co1u894KI1CgfkHvWGaZsHZGNTVkGH8UWt98f8LD2QuJ
         FRhoyLl6SzGYF7wKoPKb/Bjb5JCz7xL2tUs2tbma+/uUS/w/et3denwK7W9hxaX59cCz
         TbSg==
X-Gm-Message-State: AOJu0Yw3jsSCBAtGFTmX2YXf/uA2jwiZ5J16mq6fxLR4Rv2Hxuj1GVmG
	74fEmVI84RhA7PM09EThbI4wfs2zzH55iVRPGzeNnGqAV/ShjpOX4h4CVgOu1ODHkK2NR1FV1oM
	+Kp9m+GY=
X-Gm-Gg: ASbGncurWg1oXZoZ3uxFUzFvPhqGGPP7PUCQqcGESxGxasYSoX7lyzm3iPSfQmm0erZ
	MGn5mp2uxUMGjYtJI7mBDL6unneQF2woN+UyktpHaJoZRRokCyrsVn/b8HCowwvkCIZhO+Psf3r
	dYrUIpqnBMALKoNFS6tr8HgQ0vrBIMsLVTrLBrqql89/YN0TEyLRhvK69Pnc1RmpWXQ46suSrMq
	VI4SKdI7ImyqWe05FR2cJDJVk0sPXhnRAvAebYd/3ds88qg31si5C76MTI1upASlaQjYZdr3Mif
	KoQUQiG2/KISs2MiQYaVt6j5UZETNMdWe7b9ydjdttBHFUTgmCQSii62B+ECbyc0keOG7PXAbg0
	mnDBdB8Ms3ntXHL6JJCqVyLoYdC0h
X-Google-Smtp-Source: AGHT+IGfyzjSKeBPxKUtCFxXgNXOtuPFBWMr9b01M1myKuXzLh1KXZkhphCsxl5slJPnH3wGEAUdnA==
X-Received: by 2002:a05:6870:c085:b0:30b:ba5e:3472 with SMTP id 586e51a60fabf-32e552aa8bfmr1913830fac.12.1757704213337;
        Fri, 12 Sep 2025 12:10:13 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524986c872sm1172564a34.15.2025.09.12.12.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:10:13 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 12 Sep 2025 14:09:33 -0500
Subject: [PATCH v2 4/4] iio: ABI: add filter types for ad7173
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250912-iio-adc-ad7137-add-filter-support-v2-4-bd32dfa3d761@baylibre.com>
References: <20250912-iio-adc-ad7137-add-filter-support-v2-0-bd32dfa3d761@baylibre.com>
In-Reply-To: <20250912-iio-adc-ad7137-add-filter-support-v2-0-bd32dfa3d761@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1242; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=22rZRQwccdDXCdWucL0md8nKZ5xUlhtkQsl5aauAsOM=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoxHAKH1jnud58OUFIrZj3B2cZPTbYotYbHhZ9Y
 SFIDafYS8iJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMRwCgAKCRDCzCAB/wGP
 wC5BB/0drW3DCMb2URgt3eb7DLU10MmceSqnl1yxf0jQJr9fVffggOZinYw2vuZeSWNSY5jRyHB
 vVq+rWfRDxLt5o952KzlF3V7f022WCVbpGxvm4AW9xBj4QRRJ2JQ1nEuI4TJzUB3r75YVNg9Mi4
 HzB4ac+qViJnsBaoxup+TGO8mKnMUpc8A4YzpYei4kqOsfkP/M7sGSsdj9/reNTfbPoGTF4E/Mr
 byq3aedZducLSI+cw0zb5kwcErC7SjJp+PqxTlVrPgbMoLPQuA1nCBsHYwaqdD6JXY+n0x00EGW
 6YAfXMKt7sgPd4hYhUtQr+ns+cX19HV/4OlDYUA4I4dd2s+w
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add new filter types used in the ad7173 driver to the IIO ABI
documentation. These chips have a few filter types that haven't been
seen before in other drivers.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 2fb2cea4b19249743398b1ff0b538b03ced0340b..845dd20aab78e5c7afbeb26ba04c295a28aaafa2 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2296,6 +2296,11 @@ Description:
 		  performance
 		* "sinc5+avg" - Sinc5 + averaging by 4.
 		* "sinc5+pf1" - Sinc5 + device specific Post Filter 1.
+		* "sinc5+sinc1" - Sinc5 + Sinc1.
+		* "sinc5+sinc1+pf1" - Sinc5 + Sinc1 + device specific Post Filter 1.
+		* "sinc5+sinc1+pf2" - Sinc5 + Sinc1 + device specific Post Filter 2.
+		* "sinc5+sinc1+pf3" - Sinc5 + Sinc1 + device specific Post Filter 3.
+		* "sinc5+sinc1+pf4" - Sinc5 + Sinc1 + device specific Post Filter 4.
 		* "wideband" - filter with wideband low ripple passband
 		  and sharp transition band.
 

-- 
2.43.0


