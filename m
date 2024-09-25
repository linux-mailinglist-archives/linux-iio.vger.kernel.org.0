Return-Path: <linux-iio+bounces-9776-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98728986500
	for <lists+linux-iio@lfdr.de>; Wed, 25 Sep 2024 18:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45CDB1F25BF3
	for <lists+linux-iio@lfdr.de>; Wed, 25 Sep 2024 16:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CE184D34;
	Wed, 25 Sep 2024 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knoIksF4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B2112AAC6;
	Wed, 25 Sep 2024 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282457; cv=none; b=XgPwrk8tT5RBwjF/KqqIgpDo2xW+nHkSLAmwf8ZgsaPPp+mp5Po5IOgx/aE7jaPcFWEok7atZi03kDKHXjt6Eb4jjc8HNRTaH8t/LX3HJpU81lnyNc7n/J7vufcNgvw9UiFADrdihN1l+Fj3T6wKc9u8PMuGeSn8oEoWee1HoAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282457; c=relaxed/simple;
	bh=iIzynT3wxdbNQUAm28xrSi7VcFi+h9bvAP8GS/IJDxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CCN6QyHGuEiL4ZKHluh4y4gVj7sO/3BWS9T+AvIuokJfCuVsytVuC5tq24TxxWJwj36jymBaEawBxaia26pEiRgn10n6A7pV3Y3m/QseFieeXnKQNEGilBsc1od5fyw3Rr/8flKc8WYhlUo6qkXoy8LtbjVxvM5JuI2y8YZRZws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knoIksF4; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b067fcd87so762255ad.1;
        Wed, 25 Sep 2024 09:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727282455; x=1727887255; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YEjrlT0R1aMpt4WYrfhUEccYhF2O0fKOQryN5FZoASQ=;
        b=knoIksF4XT/snxpJy+nySPV0HExDDHOkuyOF1ZgRhJ5MP2eJ92ndE9LNpD0rl6zTCT
         g14k/cz7FuPu44Ra7MXrGOC4aPxfH/7T7c+N9g4UxQypE/TO8ULYZCMIU5hE9wG91BUS
         PtZqVU1O5JilTWjW9VmwyYlK1SdLbkSC6dJcnwOm8k8Pjs1Soa+2pYQiHz8xhKslA2Pr
         IvO1ajYxljdeRsCuov8y5IHDbXUtbI/jgn359Mx5/dC6Bd6OVzTw0FaVp62ALAn/hpt/
         wVdzxQX1daWt92TLqQFvDWfayvJvhS2TKd869djBKZ4MntySTqvTsa3zZ+CnNrSGR59n
         yR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727282455; x=1727887255;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEjrlT0R1aMpt4WYrfhUEccYhF2O0fKOQryN5FZoASQ=;
        b=Zs8hbyP36S720bDGyrmkVPxLFKaWdJ4nzVs/7NiBZCMEkqbuYCMSoLT4XjZs09RWJe
         6JzTt9Eaj6fI/5fWui/9t8bHmHyvtJNf27KObiSWvkGRaGY5s9fKotqeTg0ubuJkQlUA
         BV3K10iy4x4MohXBab3XRL6pQikg9I+QB1+TcEcOjcFZxbpq+QoJaxllMBSB18xJE7oK
         5Zt25vp35TNI34EKzO3w/a2URmL0OE7qYs81T5uWNMfXvUQiO7U5hnBuqGGuo/D3T2//
         0QnWoCk6Wyy0Z8Bz+OWDGDpztcXp3ZCiFSGA+cJipPuoGQ899o7XNPzsT3G9wv0lHkkO
         r73w==
X-Forwarded-Encrypted: i=1; AJvYcCUBVZG5XuSU/noOLHpdxoXWko7GWbMnP3Fuy1Cp9gqAooOVQ8RwtW0b/D6SjTZ6ay+UNLr/S7/mjysyo2mb@vger.kernel.org, AJvYcCUec8e1YF4sqsKKFUG5s0ABX6qkoedaaFIEfEDScKDe+0Y31zFyQSb1JgYYs3alZFVk+j4EMS+WB/U4@vger.kernel.org
X-Gm-Message-State: AOJu0YyhZrJMWxwqn+c46Fckif1CKk8EEN4CfUGyK1K72yFKJfA14Jo5
	cWNYlKU0fGPx4xIswJYkrt7rro2HicOGHqnigfZqYNMRh1eTlTKZ
X-Google-Smtp-Source: AGHT+IGnz29EzyfiIQqPfVAkp62r+SypefBfC4y6IVvB3D3rpFARxRQUwlHaolBdSZXjGDe4h/4qNA==
X-Received: by 2002:a17:902:d481:b0:207:d98:52ec with SMTP id d9443c01a7336-20afc62d0f6mr20761535ad.14.1727282455473;
        Wed, 25 Sep 2024 09:40:55 -0700 (PDT)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e2bbecasm1726346a91.46.2024.09.25.09.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 09:40:54 -0700 (PDT)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Thu, 26 Sep 2024 00:40:17 +0800
Subject: [PATCH v2 1/2] dt-bindings: iio: tyhx,hx9023s: Add performance
 tuning configuration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-add-performance-tuning-configuration-v2-1-fdbb654f5767@gmail.com>
References: <20240926-add-performance-tuning-configuration-v2-0-fdbb654f5767@gmail.com>
In-Reply-To: <20240926-add-performance-tuning-configuration-v2-0-fdbb654f5767@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1728; i=yasin.lee.x@gmail.com;
 h=from:subject:message-id; bh=iIzynT3wxdbNQUAm28xrSi7VcFi+h9bvAP8GS/IJDxs=;
 b=owGbwMvMwCEYyfeRr6Zs90zG02pJDGlfbHkzBAqY33psE6w+fMetWL+MZePE6+f+qBSe/zNvw
 a3juk3BHaUsDIIcDLJiiixnXr9hzVd9uCf4t2sGzBxWJpAhDFycAjCRgmhGhs26095+NJi63ao3
 YPmuZU//qi2XTH1V6n9GIWld07t/398z/I9vjxZ0FmIpFGnNsK9sXZ/oV1dTZOB7fVZIzqJ7q7V
 40gA=
X-Developer-Key: i=yasin.lee.x@gmail.com; a=openpgp;
 fpr=CCEBEC056F25E1BC53FB4568590EF10E7C76BB99

When hardware design introduces significant sensor data noise,
performance can be improved by adjusting register settings.

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 .../bindings/iio/proximity/tyhx,hx9023s.yaml          | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
index 64ce8bc8bd36..0673c40472bd 100644
--- a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
@@ -28,6 +28,18 @@ properties:
 
   vdd-supply: true
 
+  tyhx,performance-tuning:
+    description:
+      Optional, When hardware design introduces significant sensor data noise,
+      performance can be improved by adjusting register settings, including
+      but not limited to sample integration time and average sample count.
+      Performance tuning parameters represented as register address-value pairs.
+      The array consists of 8-bit values, where each pair represents a register
+      address followed by the value to be written to that register.
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    minItems: 2
+    maxItems: 512
+
   "#address-cells":
     const: 1
 
@@ -65,6 +77,13 @@ examples:
         interrupt-parent = <&pio>;
         interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
         vdd-supply = <&pp1800_prox>;
+        tyhx,performance-tuning = [00 00
+        02 17
+        0D 44
+        0E 44
+        0F 04
+        1F 65
+        21 65];
 
         #address-cells = <1>;
         #size-cells = <0>;

-- 
2.43.0


