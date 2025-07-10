Return-Path: <linux-iio+bounces-21555-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF26B00ED7
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 00:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1CFF1CA76F9
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 22:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81D92D2393;
	Thu, 10 Jul 2025 22:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jxS1aYsp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C786F2C1786
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 22:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187244; cv=none; b=iI8/OpVEWkfawPP+hIm6D+vjsSlYwOXfuBNFNF4HDrY395OzgPdpjR5WSGaNYIPzC6+Rwn5mcpxdofqWBuSg+bk0q1/tiOH+fngypXRfeb//LX8K8yZkfAOEeZ/IwtT8JY7SwVACNb8k5tZ1gwDU2HX31/CVH/tuLltsagFbZvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187244; c=relaxed/simple;
	bh=CCj9iOwvg6zzBiEjcAxAf7V65hcOnGTyWH1FdMb4jHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Aa/8o3gS+QdXzLUfwv3st07HVoFq7yuOI1TniOzPKVj+FL4bkCtJ34lbMnnq4ddcefoW1rVSP0I88i0tAuLTgtxtcK8Y5y9spknHFHWXnI9uYNIa+R0DTBzyajZXSt3ZphTJEBiCWFnlaUELJnsUrA084cbvfpVF2Tf06Sfntsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jxS1aYsp; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-60bd30dd387so733069eaf.3
        for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 15:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752187242; x=1752792042; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2xSpg91xD37d6BWc4wU5FsBfQPR8cbxm4QoC+z5aRA=;
        b=jxS1aYsptr+OUi+Opa749Fn2g+cJ5CEbG8j4YbHQd9z2oNOmhlTF9VffOEkP6h9Hf/
         jIbmbgYCRgYySQjIlM7WWc2P0r/wMCZDBNALvvXbNiYxUD3W4EnqbSmik6EWwlUFgD5M
         RMTSRBG+nSAClLHm1MzTqgIqOsnpgLAzKTbDwtbtVkyhYiRwtqz7Viel/ImVKmpVz1Qe
         GDI8klexStBawVBlCo142uSqpxOcHJN9XttNOKtzCsqRdMve+kIpfnH301+0Lh5rLOSL
         zewaEb7nB1YcV4JBlKPY8ZVi/LbcxZ/8mmYZJygJS0lHX2y62JFsFFWz2Xe5d+FFHoJX
         5FoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752187242; x=1752792042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2xSpg91xD37d6BWc4wU5FsBfQPR8cbxm4QoC+z5aRA=;
        b=dCStCu0kP1ss/S4yJD8WgqJDVxFFYXU/8UMkMBZAYidMv4kINRZzq9Qnp9ff90BIPY
         Tr1Sybr8rVQ2s+1Zdc4VYmlpD5bzCgBnEr1bhG2y4H8cx+FENAYed/czeidIDr3RTm1z
         ON00XezYaUQQTN0uhqx6z4z7fwNRmY0XacFbZcXBiVXojcWXiaxLHJsEzIR+WKzZTgdV
         gD5Lw55GA7QU2bpj78hAXeLJubzXjWNRnGgZ6Oj5Mo9D1nTj1uzVK1dcBbDTjKiwwV4S
         YWGov76hkPoYZeqCl6/Yrk6yr1ygi3N2VTMDI+6l/brTOHKFDnFOSmEKjmu+auGq74y6
         IBlg==
X-Gm-Message-State: AOJu0YybsNdglVZ43xe+diNc7gawDbX0m3VyIvywky9q37nlPRnn6uTV
	tFoUdjN4v+nUUdGAq5dW9rmF3iZ/4FbW0GMKmZ9LZqqox+csRae1CRO0v/pX6vB2DBs=
X-Gm-Gg: ASbGncuPwDwI+bfdyir/SQvMfW2y7hpk11ywBqanpeDkqT5QObIQK8SCmeN6t2XKj5n
	jLs1eAjROH8vuTDTK0o7f5s1abf8XdDCyJLTnvGIyXJQTCHcOzYgcd6fOcUun9UbPNE1AdGqAW5
	pXiQc9BMdea/hK4mEXcj/4wurwpOPbcJo2xdt8i0DFWjwTTnFymTVei774s3HNV8TYxqBbC5Ey7
	tXq3nGq7XE4FvX+in6fRCc2hOommxhkuACHX7a+t91G1njMoflW6hM/xuIYanOLerpU0Ek5rM5Z
	0zU0t/by5uQ+pGd4UFqM92gc1LnMLB6DkmNDHYL6HwgD1hrfIey4tCx+wDcfO2byxXkQp6z9Wkx
	kA6WMR80Y5T2dg+EWpzEEY34DSg==
X-Google-Smtp-Source: AGHT+IHJDQiMpjjkeqNdEuJu5mN4++lh2a4XmuyNidTzS9J7M+fjY820BsBEPCbiv8ZDDnnAsrB+NQ==
X-Received: by 2002:a05:6820:984:b0:611:a799:cb65 with SMTP id 006d021491bc7-613e5eee3e5mr686252eaf.2.1752187241855;
        Thu, 10 Jul 2025 15:40:41 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:891b:7836:c92:869])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-613d9d950f1sm305944eaf.18.2025.07.10.15.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 15:40:40 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 10 Jul 2025 17:39:54 -0500
Subject: [PATCH 5/5] iio: ABI: add filter types for ad7173
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-iio-adc-ad7137-add-filter-support-v1-5-acffe401c4d2@baylibre.com>
References: <20250710-iio-adc-ad7137-add-filter-support-v1-0-acffe401c4d2@baylibre.com>
In-Reply-To: <20250710-iio-adc-ad7137-add-filter-support-v1-0-acffe401c4d2@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1198; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=CCj9iOwvg6zzBiEjcAxAf7V65hcOnGTyWH1FdMb4jHw=;
 b=kA0DAAoBwswgAf8Bj8AByyZiAGhwQVmi7U4x7Z81Pd604/fp6tXpK5nHzaYBkLN7GNL2D8fA2
 okBMwQAAQoAHRYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJocEFZAAoJEMLMIAH/AY/AoHEIAJz/
 ZbeF6gEdPUjASRNpVs40nlVt2BK9rtMsxEuaZz/sHASFwBGhP5kFmWGHmCu1kEvWinSHlnJ4sY4
 SSJqglMdg/zM7Vx5HAIO4VoJKFcIMlewpIlWNs3R3CPQu6ZuvEZXdM/DL9GK6sgZnPpTA5sPVtb
 KS6TSsQMSI28YbG5cWIQU6/fzi0kUt2vP8B0ZUD42V/PBLxM/glpM/LzqWj+aqISl4jKMoxkDXf
 TZvAM0ed8kTb4eA/DJEiZkwE/EmTRB4bxVM/xUT7xvGd+EhogjBdPfpwDmLeTawT95nene2QaNu
 czzRRg+j+4O2I9rHycRqyiIs0QkgMEQkYQIwrqo=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add new filter types used in the ad7173 driver to the IIO ABI
documentation. These chips have a few filter types that haven't been
seen before in other drivers.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 3a13596b6eb081483a1f45fb0c446d2ab3b4c708..05ecf0b551698d3c7bf2d225507a1e0ecc253c86 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2322,6 +2322,11 @@ Description:
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


