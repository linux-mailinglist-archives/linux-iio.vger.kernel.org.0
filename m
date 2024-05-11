Return-Path: <linux-iio+bounces-4940-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBE68C2DFC
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 02:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637C61C214B0
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 00:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AE8D52F;
	Sat, 11 May 2024 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I+AF6YZv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033018F5E
	for <linux-iio@vger.kernel.org>; Sat, 11 May 2024 00:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388599; cv=none; b=Q8pkwFHmKSBj836zCmTIj69EOHFHc3Q6cs1L8gI2tb1OEBDeI/3ilL27RfX+8jA4pJgtIGPfWFQw5Ea+Fpss3Y0/J8sKQSaDSuLVe/eer29BgT6eCFkPBZ1n+yxeBh02K5sLdeKGFgU01LfnmS8qhoShJ7gkzBAt70Pkt1L/Rhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388599; c=relaxed/simple;
	bh=QslN9hiRjif2714MLfUNTy1aeizyH8JMJMB6mPnzuPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDMdBc1ndq+RFSZVDgw3DhTX6DLXUqH0ADd/OSYBb928R243LhQm8Euy5kZwXneQj9FnLHf2b9aZgCM2qCmMZmc6DgR1WgwB2EoawwT9aPwYUNHtCMkSe1tLVW/pYgZuXyXqdsVWpk5o+tTY8ybwlOKw17VAT2frwpnSliWtEDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=I+AF6YZv; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5ac8c73cf88so1420266eaf.2
        for <linux-iio@vger.kernel.org>; Fri, 10 May 2024 17:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715388597; x=1715993397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wm1JDIpGQ3/Aqds3KMjjWWOJUYPSXntTpGvlaeWf3LY=;
        b=I+AF6YZvb0ZGtqfxIrQkw4wQE744NHHGfeUB2+wEHvD43mTYqJ2ZarJQdW3ERqrwVb
         3216460M4XoEsbjvfOhcjNtYa8MFESqGPiOEp3agpE3GpURId0+YTxVSvgIsNrAveWRR
         Kur18iuO86itQz2qZ6VL75LlRHdL3Bw+3dN9qmYJbkW7wLBgxYc/ky5l8GlZegY17jLl
         Czsb9EOBKyWCTJwsUxYGYRWgVsmVsvTNyKmY+40iD3jY3xHkohN1/9uooJy3Y+boag2g
         Y8qUg5Z4Mc1gQODqpnXEPy0eq246RoJX6kKrCtQOc62uR2+2uQkE6q1BS2N5t4XBN4WE
         55iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715388597; x=1715993397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wm1JDIpGQ3/Aqds3KMjjWWOJUYPSXntTpGvlaeWf3LY=;
        b=Q7wMYYV0kuOMQuBmT5Kk77f4RY9IzzHCzm3c79u+SucmWslgrcp0ry1ITdvq6f1Alv
         xkkcXfo8OsxB7QZ+yThkSbA7G28vtx7AbAbww2VRUGu31IaXbD2r5yNE/iX7qGcDptFa
         5o1DMxYABa4YYMEsEWUTuBdL9ceJ4sXXJVRBtlG3tXSIFU85oj9TgSE/iJBm5I3opKsl
         RAbFOMc2oZaDVNoqZCY0Qn4UhiWvrrf5LHYfItm1F4Tkb//j1WbUcV/0CN91XSQdDmDg
         bc52ZMBGMLeZ/6AaxiAML4VAMzZA/q3KKfm48NDQLq2BPF/eYbho6E2/wNuK6NQJ+1Gv
         vBXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZaW0NB7jaeoQ2FOVSM+gKvyUPmkWINtFRXaiCP+OwwCk+9hnWbp18QFOl186Dm7NBEbyVNWBW9ygJTEeM/BgN/ZGmM1RNWvtG
X-Gm-Message-State: AOJu0YzHij1hva6ZgzsxtZ/Y2eUL9I7yLcMs0vs+K55sWZEFw3ImyKcz
	VF3H/aQyzEBRcHnznd+VSdZIaq69ITXDdni+b8YXEFekBcE7vfAGGt9vGHMjJdw=
X-Google-Smtp-Source: AGHT+IHIlPJpLdkHvfVzDbw2X1xtwQanIP+eKehd+NyrLExBkWOAZfON5byOulKnrHpJ4Pdp/WT0fg==
X-Received: by 2002:a4a:907:0:b0:5af:4b39:b7e0 with SMTP id 006d021491bc7-5b2815cd612mr4164258eaf.0.1715388597084;
        Fri, 10 May 2024 17:49:57 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b29015a3dbsm321132eaf.46.2024.05.10.17.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 17:49:56 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH RFC v2 1/8] spi: dt-bindings: spi-peripheral-props: add spi-offloads property
Date: Fri, 10 May 2024 19:44:24 -0500
Message-ID: <20240510-dlech-mainline-spi-engine-offload-2-v2-1-8707a870c435@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
References: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This adds a new property to the spi-peripheral-props binding for use
with peripherals connected to controllers that support offloading.

Here, offloading means that the controller has the ability to perform
complex SPI transactions without CPU intervention in some shape or form.

This property will be used to assign controller offload resources to
each peripheral that needs them. What these resources are will be
defined by each specific controller binding.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:

In v1, instead of generic SPI bindings, there were only controller-
specific bindings, so this is a new patch.

In the previous version I also had an offloads object node that described
what the offload capabilities were but it was suggested that this was
not necessary/overcomplicated. So I've gone to the other extreme and
made it perhaps over-simplified now by requiring all information about
how each offload is used to be encoded in a single u32.

We could of course consider using #spi-offload-cells instead for
allowing encoding multiple parameters for each offload instance if that
would be preferable.

I also considered adding spi-offload-names that could be used as sort
of a compatible string (more of an interface name really) in case some
peripherals may want to support more than 1 specialized type of offload.
---
 .../devicetree/bindings/spi/spi-peripheral-props.yaml          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 15938f81fdce..32991a2d2264 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -113,6 +113,16 @@ properties:
     minItems: 2
     maxItems: 4
 
+  spi-offloads:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Array of controller offload instances that are reserved for use by the
+      peripheral device. The semantic meaning of the values of the array
+      elements is defined by the controller. For example, it could be a simple
+      0-based index of the offload instance, or it could be a bitfield where
+      a few bits represent the assigned hardware trigger, a few bits represent
+      the assigned RX stream, etc.
+
   st,spi-midi-ns:
     description: |
       Only for STM32H7, (Master Inter-Data Idleness) minimum time

-- 
2.43.2


