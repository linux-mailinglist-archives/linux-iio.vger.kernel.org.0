Return-Path: <linux-iio+bounces-6503-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 725FE90D570
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 16:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183EB1F2423E
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 14:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAFD13DB8D;
	Tue, 18 Jun 2024 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UASmYibB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADB715E5D1;
	Tue, 18 Jun 2024 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720532; cv=none; b=sp9iFP1UZT1h1Jaq5lbYfB0c53T4K0LNscDZVexj2JkCnbjtiGXFO+BQOxnV9oLQJTFhqoEp3Zd1+3/ERPOtRLhpSksgUECR3zSk1rMHeqqounK6j/TalX8ZWn2hrsOwhz7nscKtUmHqW3F88FujBQ6iXAPhTxLGKyS4VzGWvUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720532; c=relaxed/simple;
	bh=nGdM8GDWiw63LfHVRxOgWy1LqXhSACbPaSb3oZ0WBN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bPdw2DvPNZYDjlkG9JHU6//1upWFKYNhT6/re7ZrRSlEqXdMhzUSJZ1VS8wNImh6umKAAz/+c36sDKinoVrnXfKVzp240MDDLCrumZ4Irji+RdoQGZ64/SSvxM0zfhpM9tCoOdh4i1hxLGMgJGzmeEorVzpMZ1e4/cG9AU/8tfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UASmYibB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6f177b78dcso700300366b.1;
        Tue, 18 Jun 2024 07:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718720529; x=1719325329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bHpm4DzuXhkRwqoj5WVlYejCFzKpp5Uqn73d1JkWCI=;
        b=UASmYibBEzigrQBR8iK7+rb3DvYeA3pRZEgBAbib219w9pB/86amNqG012VVRmxSQU
         VDJazxbUFdIeK02ZfdeuZTbK5egJ4/f1bnn/qBhKfMcoYOtoJVD98SJnNsuq+G63OGu6
         NHyjEUSSfTraTBTX5WltcP88CeMSH1A6wtiWj8kuAKVR9lj0TwQdRCP+hlJgIVVRq/a4
         K1lbPNyMvIqD+cymYJogtQSrh/i6YOjqlnH0fMlpMwToN7HaRvvRh9U+o6E9PFc7BR9N
         Ep9gPb6mFTdKxScn8bfDD1nY1qPVIZpyRkesB1IDuUSCy54CP1r2pBAaS/y65+8jGVqJ
         YDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718720529; x=1719325329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bHpm4DzuXhkRwqoj5WVlYejCFzKpp5Uqn73d1JkWCI=;
        b=mkgFuWWaMi8lvHv08inQGTDdp5vASsWmXtmlO7cYfNQaE3y54Elbv/5X+e5Pc93bBZ
         9JwRcSXEGtlh7PwMGykqWqF0lAErDdMWrFO56SWhrp6Ex7MjPYaF2T/obuufOgNIBiXS
         59HUWczw+nQl7TbxXyF77Igtgl7FbRT9jP+V4M8FZQ/84/q+bRxcxlIEwWHLqXtAbD+e
         TYZLnZZXRIs52jvTwubNSpZ5Yg9haEHZVtlM/21G7oy5ogWnmLdF7hIAlIwBDPJbej8f
         h0WZFOz0+rP+F9qX+9bOx2NY7J6P54FLxwTllFC8GYa55XvqRMKzlZVYDsueXqfRRAAY
         Vl0w==
X-Forwarded-Encrypted: i=1; AJvYcCX5qCuBektK7NftonynU30yXdA5NEgU0tQIenYssjWpNTaOpH5U9DDtj0wr/azgGNRBnWOpgGKMHf3z+vTtKs8HOGODgVtgLHTF0G3CXMYo5vcIzXvFyMkOuKaSYfe7GlpZrtj6oOjnka8aXoMqeX55R51iIuzFxsy2glpz3P81xGAtHg==
X-Gm-Message-State: AOJu0YxScn8FdIC7uaU2QBYJlPpoQul+LLoUOm8FE4ONUiqwaCvFh8Pa
	QxJFM9Y6WAyle1z4jHzH2/lS+Ox6fp8WVn7gITrFI8FFTvsZp96g
X-Google-Smtp-Source: AGHT+IHmfs+xDCi8QmMyePuE69HTHQezu3eJCZfCRHQwofBCDVTMM9O4GiL+KlYvc/+3CEI2FJmGdw==
X-Received: by 2002:a17:906:d111:b0:a6f:10d0:fb85 with SMTP id a640c23a62f3a-a6f60d203e1mr761174866b.19.1718720528400;
        Tue, 18 Jun 2024 07:22:08 -0700 (PDT)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db6dfesm618191466b.87.2024.06.18.07.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:22:08 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v5 2/6] dt-bindings: iio: adc: ad7192: Update clock config
Date: Tue, 18 Jun 2024 17:21:34 +0300
Message-Id: <20240618142138.520192-3-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618142138.520192-1-alisa.roman@analog.com>
References: <20240618142138.520192-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are actually 4 configuration modes of clock source for AD719X
devices. Either a crystal can be attached externally between MCLK1 and
MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
pin. The other 2 modes make use of the 4.92MHz internal clock.

To configure external clock as either a crystal or a CMOS-compatible
clock, changing the register settings is necessary. Therefore, add clock
name xtal alongside mclk. By selecting one or the other, the register is
configured.

The presence of an external clock source is optional, not required. When
absent, internal clock is used. Modify required property accordingly.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7192.yaml      | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index a03da9489ed9..67384bed4cd3 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -39,11 +39,15 @@ properties:
 
   clocks:
     maxItems: 1
-    description: phandle to the master clock (mclk)
+    description:
+      Optionally, either a crystal can be attached externally between MCLK1 and
+      MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
+      pin. If absent, internal 4.92MHz clock is used.
 
   clock-names:
-    items:
-      - const: mclk
+    enum:
+      - xtal
+      - mclk
 
   interrupts:
     maxItems: 1
@@ -135,8 +139,6 @@ patternProperties:
 required:
   - compatible
   - reg
-  - clocks
-  - clock-names
   - interrupts
   - dvdd-supply
   - avdd-supply
-- 
2.34.1


