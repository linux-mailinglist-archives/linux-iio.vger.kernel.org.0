Return-Path: <linux-iio+bounces-8872-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 002E096449D
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 14:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD601F22A01
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 12:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F3C1AE84C;
	Thu, 29 Aug 2024 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="P9nU2OEB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB01AD410
	for <linux-iio@vger.kernel.org>; Thu, 29 Aug 2024 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934805; cv=none; b=a09uSk1HNBxJ2v+N/dFdU0CSY5I1RPUIgcbAggIcXqHOIXRSzj3Gbf9ZAtrnHKWObukbPFUMt50ktc+EgZ3v7jbJvTZGsxDnMMiQr1r6SxVR7jKHOmDH08FDcOa40eIgrmO2Uhp7egjxIHYeWGQmgdpkhayaQTDj/ZDrect3CFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934805; c=relaxed/simple;
	bh=2seSKUbP20B+v4Da+nrC0RJo+JYqN7HNRn8x6mQUcuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mg0mvPm37D561uIebCMw2uQ+RsOL6UTFBAGeaF7SCiRsiBbahQfh7dP0rpFtwv2fdJ4NdgRBEU6D1m2pVMQ7vsWXEFGCRJjnvwC8FCH4oPUxz3sv8EeYj1MjHrCfmB0KeMllWtgRHHeAonnAOTERr7kljTozKhrdazlA/fezQtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=P9nU2OEB; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-371b098e699so507872f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 29 Aug 2024 05:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724934801; x=1725539601; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5VzDkyGIipqeKFQeDDBEiAGYXukKHwmPdzrDO5GWeU=;
        b=P9nU2OEBgnzrZJGljOiBgOrUSLhSpbwndKa7eustG4XfEWFzoQ4UN25pNDuUiiJ1/S
         xcN2e0nUYgsjlmiw/ovM2ejuZpnZVCGj8uI/2zlvaayRwqkmWbthonT3e1NRC9MmZOVR
         x5g24S0gDrBGwWaTi3os1k/LEYBE3J1No/01ykWkWIKmlckwHYCgBjJgH3FO08IeFeYi
         A49SeD1LRsYr74XW6xF5dYW5kDBhPv6h5/DfIxKYKMfTNj8HOTKf5DjzhuzV6e9Q/HX3
         yrfG0rwHP9kKwpv8njArh/2utnjuD2Aiq9nfGawKSoYuQm+I3OXGOf5u72b3W5f54Yrq
         hl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724934801; x=1725539601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5VzDkyGIipqeKFQeDDBEiAGYXukKHwmPdzrDO5GWeU=;
        b=PvKsAua8fJ2KX0C4tE0tg9CxxdMqgFSL7PkfZEhKcuo1YLa+AdjsVuJl+eah9SRA+4
         4vbbcQSE/gry4InJ7T6ljQoxSC4qkHM2LA9ooONTMl+Xl22r6vEh5TTt0bR7peaSANMF
         Keyrm9/mpdPrU0cW+zTqhAc0WUXzHgc656Uye5AMRS+KfkPM8OEx9pdAsy+XY6z9iAV9
         L+NPubXgGPi8h+Vmy+lc3NDsxC1amWjkg3x3GCwx4ntiDs1Tv/sc26uGot3Zmad5jXs2
         i+1Rwzq/MKY6q9XvXFgvpdmRSLo1guPA9+JhBe6Q+mqHGSLWA9Y0jwqgnWP9p/n4gkFR
         9ykg==
X-Gm-Message-State: AOJu0YxDQ/Ow9eNEr9k0/Orkr6CYg4nFH61YTzvVDKrmE/GAbD4X1FgL
	XD9aGvZDgM2Bu4QPxclTuNMPnGuCQ0Tz50c9TxcRI27a1rmsdjsvYYx5c4EZyc4=
X-Google-Smtp-Source: AGHT+IEUn+XUGbwbcc82Z4ruGRiXJAYhB/DLqIvI8zIDgN4867faLz+fysRvLFTbaujzVS8Mo0daOw==
X-Received: by 2002:a05:6000:cc1:b0:366:f04d:676f with SMTP id ffacd0b85a97d-3749b526222mr2464717f8f.12.1724934801188;
        Thu, 29 Aug 2024 05:33:21 -0700 (PDT)
Received: from [127.0.1.1] (host-95-233-232-76.retail.telecomitalia.it. [95.233.232.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9978bsm1315042f8f.49.2024.08.29.05.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 05:33:20 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 29 Aug 2024 14:32:02 +0200
Subject: [PATCH RFC 4/8] dt-bindings: iio: dac: add adi axi-dac bus
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-wip-bl-ad3552r-axi-v0-v1-4-b6da6015327a@baylibre.com>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
In-Reply-To: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Add bus property.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
index a55e9bfc66d7..a7ce72e1cd81 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
@@ -38,6 +38,15 @@ properties:
   clocks:
     maxItems: 1
 
+  bus-type:
+    maxItems: 1
+    description: |
+      Configure bus type:
+        - 0: none
+        - 1: qspi
+    enum: [0, 1]
+    default: 0
+
   '#io-backend-cells':
     const: 0
 

-- 
2.45.0.rc1


