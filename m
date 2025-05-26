Return-Path: <linux-iio+bounces-19934-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F34EAC3DA1
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 12:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D781765A8
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 10:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A181F4C85;
	Mon, 26 May 2025 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="o0jsoBbf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5061F1F8728
	for <linux-iio@vger.kernel.org>; Mon, 26 May 2025 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748253891; cv=none; b=vCy7+YlUXf3VsJy42JrSGXytVeb6lMzPt6BjlKJXrwLyeyN9ymREo4kagz2t4tmGa76qj2D4rKOoGvMnRfA0bYmlG/kxnisA5yNIL6czJm2ZDGHr2oTz7M4O0bqHHL5XW7YdRxcMj/ZSUKxIQlYQfIXt+tnKzyEweEEVcI6bE4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748253891; c=relaxed/simple;
	bh=NtotUFQE861trIH/6KVUMJlh1RHFkSekY2PpGsDNTzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t5iCSYbvWx/QODDYymCi1kJEtIR3OJaHE6xOx381kuOBVQQqQL8uMnrMp6YU7w78KijMGeSuHiJLNtVMZKKoo3q/5oV7+Z+oz8G1pJhBeKItz5dqOb0vjoa2AKyYpqsDFVkNbKOyAvA7KkdQixG7R0+8YgQJQFCeQhEE3eVxokA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=o0jsoBbf; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-44a57d08bbfso15349725e9.2
        for <linux-iio@vger.kernel.org>; Mon, 26 May 2025 03:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748253887; x=1748858687; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SSPYC82OHD2BI/YU/tjmuoLa3AQcRKZBypSGl/10x2A=;
        b=o0jsoBbftCNkm1tWipDjGTD4d77bFelWzlz6BthrIpxIG6KsMoDaXdQIT1nikyuWvC
         KDHJj6/fi+zgd8BDJXYcEJIBVmATe4/oukrqYaf8+9EubpjpOtJepwO5CIexNEsbdNSv
         RShnFJkPu4/FZjJKBucR0E3ABFdCHdxMzXke0AJ4sXjfaoRoTTYdTydYLs+2pSOoWx7M
         qALfEaoRZof6wM1oAWV8KJwSSFVb1L0v0tG6IZ0/jD5KZyE43nfB8+ws1A4bMa75Ij/U
         SEmmX/DxylLJ2XB++C308ZzR2ziFCm8SsCN099n6xhPUTnYD6DYcMfLoUSCguSrrJBjD
         I0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748253887; x=1748858687;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSPYC82OHD2BI/YU/tjmuoLa3AQcRKZBypSGl/10x2A=;
        b=tSVLOwK8Hw+9q7s3EfM18PLU6VfqtnXeBBOMzWqGcBhKEXhJzx/0FdPuOSAPHTFtdP
         BVdIRCR585GMz+PSd3o/AraeTty66S3vzwHFF9ifX1h44oDc8EDQT0ERtjYxmOlgAfKX
         a3HuWkGZRgnqfoleCeDLptnH+NXEZlbCsufePeM2p65jHnYAqjA32R7jKN1B8lawuHCN
         e/lqn+4nzYBmfjKtIQGPIt+1B8vLRagUxVGrun5EGwdLExoQPkZ1wjc/eArUGkvcfyMo
         fbmtSwZhfJ/bNs6YnJ7p8+z2Do4Hk7koUSThdw4PiQdLElOGCgpjcktkLRvHqMDvMCXM
         Wz+g==
X-Gm-Message-State: AOJu0Yw0GpUkHDQrMJoqdXUCmHLXzmoGcke5XTeIxC1wabzAoNlKLJOZ
	9pxXy/Gw83kqNSPhtnbxS/gik2pgjLFHavTK1KIcOQQEgScptesiUZSnV1eERyWPEik=
X-Gm-Gg: ASbGnct1o8kNly/CyKO9Qw+pcr282EX6NpRjtTRlTLzWPjJHJbR0wHdy3Ff8toU94yM
	OEli5DhZ2XA6wPQS7MyFgW15Z1h+BN9BJfD7lxHkT/gh180xjQITXDG8jAJdthmcWfO4LUNLQiK
	XlIrp/Ba01UiQaXikUUx6Y/hAFQJZz8zyCwMYIag/qE8LSqGEjzTAExWoFkhz/QiouE9VtTFqn3
	gBQSA6+Pqdg4wRbLwPrl39cgEAwLjQpgoyivnlc5tiuu14PU1fXZOZB/Kry6G4KPMrjzzT/P2cX
	qyoQaWF0aEA4nYHo8Xv7+eCZkCnGKORY49P48Y7bXe5RYEJtEAqSHuKiYzfJtPsoocFL0ofLB2Q
	E9IdH6xtXbhWWVeV17TBZpK78/2Ovzfg=
X-Google-Smtp-Source: AGHT+IH5plmi/nUPxQdrlk4OSitIClXHq8w8SJjzpUHQhcFP5Y1Dghxteg5xfgt3S0UQCdsVUQLQUg==
X-Received: by 2002:a05:6000:2892:b0:3a4:cf40:ff37 with SMTP id ffacd0b85a97d-3a4cf4101e6mr5909723f8f.6.1748253887401;
        Mon, 26 May 2025 03:04:47 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca888fcsm36141834f8f.78.2025.05.26.03.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 03:04:46 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 26 May 2025 12:03:19 +0200
Subject: [PATCH v7 4/6] dt-bindings: iio: adc: adi,ad7606: add gain
 calibration support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-wip-bl-ad7606-calibration-v7-4-b487022ce199@baylibre.com>
References: <20250526-wip-bl-ad7606-calibration-v7-0-b487022ce199@baylibre.com>
In-Reply-To: <20250526-wip-bl-ad7606-calibration-v7-0-b487022ce199@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2030;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=mK1GoQiX2hS20/yC/1czrPjfc5t1uAwSltJDkMx72Mc=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsgwscn+47Uo1r+qtv2vk92tO4w3d8x6OcNKorl5y4QnR
 2ubFeoqO0pZGMS4GGTFFFnqEiNMQm+HSikvYJwNM4eVCWQIAxenAEzEwJWRYaGo7zPOxheliWcn
 TsxfZdl46eGml/5XFXTnrZvgv6Uo+gMjw2mmFzqCGWf7Jj8V2ivwc2/hjqTVib57YqwV+Da9aZu
 RwQ8A
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add gain calibration support by a per-channel resistor value.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index 29f12d650442b8ff2eb455306ce59a0e87867ddd..6926f5f090ad6bbbe7bfd9327dc5ae17dafcd1fd 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -204,6 +204,15 @@ patternProperties:
           considered a bipolar differential channel. Otherwise it is bipolar
           single-ended.
 
+      adi,rfilter-ohms:
+        description:
+          For ADCs that supports gain calibration, this property must be set to
+          the value of the external RFilter resistor. Proper gain error
+          correction is applied based on this value.
+        default: 0
+        minimum: 0
+        maximum: 64512
+
     required:
       - reg
       - bipolar
@@ -256,6 +265,25 @@ allOf:
       properties:
         adi,oversampling-ratio-gpios: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7605-4
+              - adi,ad7606-4
+              - adi,ad7606-6
+              - adi,ad7606-8
+              - adi,ad7607
+              - adi,ad7608
+              - adi,ad7609
+              - adi,ad7616
+    then:
+      patternProperties:
+        "^channel@[0-9a-f]+$":
+          properties:
+            adi,rfilter-ohms: false
+
   - if:
       properties:
         compatible:
@@ -398,6 +426,7 @@ examples:
                 reg = <8>;
                 diff-channels = <8 8>;
                 bipolar;
+                adi,rfilter-ohms = <2048>;
             };
 
         };

-- 
2.49.0


