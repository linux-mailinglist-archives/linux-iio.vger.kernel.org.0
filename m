Return-Path: <linux-iio+bounces-9676-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D098F97D91A
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 19:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC942827B4
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 17:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB19183CDC;
	Fri, 20 Sep 2024 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Zp9r58V4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A6717DFE8
	for <linux-iio@vger.kernel.org>; Fri, 20 Sep 2024 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726853611; cv=none; b=PByp+Tjb1d0+viIcCapvvm4dy+Zso/BtFaYEyAly9DjxKox1lvDSqQYzztSClc5kvW3SAEe5u9I501l26/z8iNoUuq7BYMF/YsZpr0HdftdEUUQiY87x37ENpgsfoodsmRS7TJ4DwbsCTHYUkUFlSL7uBOA8PWGTilhPrUPiMdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726853611; c=relaxed/simple;
	bh=Gpgaed0fCeEh53ecEHuIgZfypb2UgiAkN/j7SoFe7Ho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uc8Lo/D274pFPGmfrYyEepGaukJ8JjjSSFSZoUNmEr00uyl60zG/sOW79Bay3+irPGckFxouDK2J4yUOB1OGppnV6z6xUY4XAzyy9fK9N/sFzigkWT6tOs8sIn5vluhKSX2lmiL+qsYUeoOIOHXVC7/uTaT2Uf+lzXURawaJiXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Zp9r58V4; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374b25263a3so1447525f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Sep 2024 10:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726853607; x=1727458407; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=soKhXp345Ybiw05QPSYeoUiXAWfWKlNlYXV62ASdXho=;
        b=Zp9r58V4Q8fmYYVAPXAam8pOgV/7RyzJoHpvF279dePNF/atVsP40L1jYsgngthjHN
         Rt0nmveF0PAayMq7mRgHdP39JqvC4uceTb8g4YIGmtBqVS8eQMwQjeiiA0UnTQrbZOEh
         bPc/Wp1+rKqPhvA+b3t6YtW35TUvzCFAXsj4t2GNv+mLV99HGVDGDQxs3Pr0Dl9+lH1p
         5t9oy0bWeJClEIbYRGjs55riBwonmZHIZVmXA9QxU+zGcokOynIsJzTnAkdMv6PKi5Kw
         e0Gk7aDRiM5YGazVZH3yDqSsXWGToERgQpW3C2UorEmvypP1GWjZPW/VWKYNfTryyPwY
         MqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726853607; x=1727458407;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soKhXp345Ybiw05QPSYeoUiXAWfWKlNlYXV62ASdXho=;
        b=S9gYUV1XkiQP02hUZ7lqZCI9+olnOBfgD/Fh7MWnF4uKj0cXAzWZp88sXwzS3Bt3s/
         pX8BeviG/DJjhuQJh7srWe7iwXS5n7DASx6caAo9KbH99vesxqcfg21grhasjA04/M3T
         bJPcUoG+smOsR8o8F4iEAdAqH4nN4xv3WZ9oSwIRI7cnSL5UfVSCMzTZ+qvJvZvxWPQv
         Xkark3lVnHMeDa0qMtjkPRBS/+bua31cYJg0iktQsTaljEsJAIlmCObJt7Npjde8Rsdv
         nb2vWFjoZdTGhLbgjBQX56xY/7B9MuMfAOOlhsX9yg5hETM+e1B18Xu0EgDArc380Waa
         pMyw==
X-Forwarded-Encrypted: i=1; AJvYcCWe7THtPxLnOg6PCbz6JaMMYxtsmWFlb5++N9D8Ye9C4wfQP/FJS3QqAq/mM43uScA/9wC16V8yVw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG23VilODaaeYOZ0HnTHdZJEjmbws1RWaJ06qIeNAgdT/a0kZp
	n/BitBILhFjAHMMtyvqFScNfF8Dx/dLDxB9Asv3clC4Yug6sKaPhcxtW4TlBME8=
X-Google-Smtp-Source: AGHT+IFS0VAudrgufhiRxz9sPv6qVkHP+/xZtTSnLoCqZz3k7wAUIqJdrMWQ1+d/n3mYd6QiASe5Sw==
X-Received: by 2002:adf:eccc:0:b0:374:c2cf:c01c with SMTP id ffacd0b85a97d-37a4236df78mr2102447f8f.48.1726853607239;
        Fri, 20 Sep 2024 10:33:27 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780e029sm18111177f8f.116.2024.09.20.10.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 10:33:26 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Fri, 20 Sep 2024 17:33:22 +0000
Subject: [PATCH v2 02/10] dt-bindings: iio: adc: ad7606: Make corrections
 on spi conditions
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-ad7606_add_iio_backend_support-v2-2-0e78782ae7d0@baylibre.com>
References: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
In-Reply-To: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Michal Marek <mmarek@suse.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 aardelean@baylibre.com, dlechner@baylibre.com, 
 Guillaume Stols <gstols@baylibre.com>, jstephan@baylibre.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726853604; l=1644;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=Gpgaed0fCeEh53ecEHuIgZfypb2UgiAkN/j7SoFe7Ho=;
 b=TEO0GprJjLt+G0XFAyfPx9EJ3qWaJ5oHGsul+rDAxLSlHhq8TWpvRCQGyTEd4h7/dIVPUpAw8
 Zk/P+IcUfGLCFSykIPx8R75jfakMwCOfO9gUA8dXFwV8DMP03H/XJLt
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

The SPI conditions are not always required, because there is also a
parallel interface. The way used to detect that the SPI interface is
used is to check if the reg value is between 0 and 256.
There is also a correction on the spi-cpha that is not required when SPI
interface is selected, while spi-cpol is.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml      | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index 75334a033539..12995ebcddc2 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -112,18 +112,32 @@ properties:
       assumed that the pins are hardwired to VDD.
     type: boolean
 
+  parallel-interface:
+    description:
+      If the parallel interface is used, be it directly or through a backend,
+      this property must be defined.
+    type: boolean
+
 required:
   - compatible
   - reg
-  - spi-cpol
   - avcc-supply
   - vdrive-supply
   - interrupts
   - adi,conversion-start-gpios
 
-allOf:
-  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+oneOf:
+  - required:
+      - parallel-interface
+  - allOf:
+      - properties:
+          parallel-interface: false
+          spi-cpol: true
+      - $ref: /schemas/spi/spi-peripheral-props.yaml#
+      - required:
+          - spi-cpol
 
+allOf:
   - if:
       properties:
         compatible:

-- 
2.34.1


