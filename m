Return-Path: <linux-iio+bounces-10311-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BE099385E
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 22:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFCDCB22665
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 20:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD681DED4B;
	Mon,  7 Oct 2024 20:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMtDiSX1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A331DE8B1;
	Mon,  7 Oct 2024 20:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728333421; cv=none; b=nL8uyBa9iZo5967J8Y7o7Z5X121v9L+u4NxpHzyVoY50Y95N8+lJCR0AW9kRxDAB67KfprHD2ZzZkQ5hwgheDGv7kkDslWjYlPD0so2H1SYhwcjXoJL8DoZYuwX1dyAM8B38X3krgQo+adK8pXUPHHZq14RZ/0BBNoBmUcSbWTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728333421; c=relaxed/simple;
	bh=0g8TwFDtanIN2XC2B0GQ8d8dwsTdPMy2x28iNYCMoGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pmMyw40QAFX2Nnk0zG0abDYv2nQE31lcCFug53ywxH3dq8YsLh6ql+erlu/Ex6tTC247UR4koDlgfGO/zZ2vH8BpwVHjB+K8eoMsHJaowlIReWa/yY+wgS5jkCWiPTzCqpPgkk5gJJVkkcT5qfcOIMlKxHfEz63TxjkKE6MN940=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMtDiSX1; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37cdb42b29dso3083029f8f.0;
        Mon, 07 Oct 2024 13:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728333418; x=1728938218; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fsEp6JbURkIC0sqAA8ljjlQfh1UMQrk51Wr0yDIIrao=;
        b=iMtDiSX1z7vAJE4divroQ/a1poKgakdE+9nlH4uHK4aq4CuYImlGl5ggI/UgcA9MTT
         x5NpLRJDB67cy6PgDaXgYC9ZpzjV8NHnU5c+rseSFvX6+nC8DyIk6dwdn7gwVVrpl0SU
         ur0yocQ+pYOM/v6JaeVQ8TtCojPIz06HVfAAsen9zunVLgIcImGe67oTPOeW/W4wW1c4
         7q055ByGRvjXqSCflXKOA1I+WzHY1qpZ9dBCq78kTxMsgqTxWnvGD9YWHNu8P5B0HruH
         RX1qF6s0y8/G+TToB+LAJafFkA2KMU/aPzW+m3VWj65jN9v7X2rX1r+QXL05qjD4WVwk
         jCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728333418; x=1728938218;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsEp6JbURkIC0sqAA8ljjlQfh1UMQrk51Wr0yDIIrao=;
        b=tbk9HnXh2gQfyDrIdGS+Q8gWqtEEueHBzc4P+9FuMg8ZxXD/oyY5qXYCkbuW0r6WE6
         wAuLcbspqQ2jrB3m4uxoTgKW6owrCXjr9MAhkomIzyimH55+IfeAO1bOhw6TH53nbWsc
         yImATc2U+UgfmjwtiKCVUeB6AxH9QL0K7dHk6uwBcVJnLX7seaF4paGm46RCKsCWAZxH
         UunCMjowCoilS3NAJGfDpxZWm2J351mF8G2mb5dPMhy2Fy9ZZv55aCdul8Rb2DDwhtNa
         ZH2JP/9mejWctpPpggCdtFs3393r62TP6HVn1BbI+PvZkPBfPw8ovdRU6+SHozctoFvb
         siVg==
X-Forwarded-Encrypted: i=1; AJvYcCUBS343G2Hv6blvtURnH4npTiXbU6CGmPOm12uoD4O3g2JQJV58rQ9OwfLXH7jd58GY/p4Aza4yUh/C@vger.kernel.org, AJvYcCX2H+Hf9Dq2oLHxUd8EhxTMGxnHz4mDE4aasKY8mX7MNl5nEnyiE/9Kv50ddHdpFpLRFF0e29S5RKhtt1G8@vger.kernel.org, AJvYcCXNeHvaSDWM1F10dc7WBMrPZKySfZWWBbVL7q6VKxJEARuJK1UwNPOpViMRDyXE1Eg/eo/p0D9jSNZR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8WvWAW7NSO3VCqaT5+VoGEOJhx+Y6oS+YIvjEz/nopabniEo0
	m3RLbopFIFmHubdRI81ThpRNcUORiErfpd1Vs9k014hoHU4XvsJTI3SPGQ==
X-Google-Smtp-Source: AGHT+IHQYP2GNN7cRMNPaTK2X44OXEPNbrJxNlU3BEddKMEMAo1GvAUaeusXAgrzbXv7UqsCeYv1DA==
X-Received: by 2002:adf:ed8d:0:b0:37c:ddab:a626 with SMTP id ffacd0b85a97d-37d0e6d3172mr8116742f8f.7.1728333417527;
        Mon, 07 Oct 2024 13:36:57 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-26cc-001d-7ed0-e346.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:26cc:1d:7ed0:e346])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f75bsm6464315f8f.23.2024.10.07.13.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 13:36:57 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 07 Oct 2024 22:36:37 +0200
Subject: [PATCH 2/3] dt-bindings: iio: light: veml6030: add veml7700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-veml7700-v1-2-fb85dd839d63@gmail.com>
References: <20241007-veml7700-v1-0-fb85dd839d63@gmail.com>
In-Reply-To: <20241007-veml7700-v1-0-fb85dd839d63@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728333411; l=1816;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=0g8TwFDtanIN2XC2B0GQ8d8dwsTdPMy2x28iNYCMoGM=;
 b=hvBUoo/QBGU1eDWfcCAiTRIbollF4Fw/SA+Ay0kup3a+pcPr63u0dZVWLt54DSxn2s47tmBs4
 X0oLKuJjtH4Dcdnw0HDQxV3j+yA3Zwo1ImvumTBjQ2QMJib/gRb3GNL
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The veml7700 contains the same chip as the veml6030 in a different
package with no interrupt line and no pin to select the I2C address,
which makes it suitable to be supported by the same bindings.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/iio/light/vishay,veml6030.yaml   | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
index 6218273b0e86..53b55575efd3 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/light/vishay,veml6030.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: VEML6030 and VEML6035 Ambient Light Sensors (ALS)
+title: VEML6030, VEML6035 and VEML7700 Ambient Light Sensors (ALS)
 
 maintainers:
   - Rishi Gupta <gupt21@gmail.com>
@@ -22,12 +22,14 @@ description: |
   Specifications about the sensors can be found at:
     https://www.vishay.com/docs/84366/veml6030.pdf
     https://www.vishay.com/docs/84889/veml6035.pdf
+    https://www.vishay.com/docs/84286/veml7700.pdf
 
 properties:
   compatible:
     enum:
       - vishay,veml6030
       - vishay,veml6035
+      - vishay,veml7700
 
   reg:
     maxItems: 1
@@ -70,6 +72,18 @@ allOf:
           enum:
             - 0x29
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - vishay,veml7700
+    then:
+      properties:
+        reg:
+          enum:
+            - 0x10
+        interrupts: false
+
 additionalProperties: false
 
 examples:

-- 
2.43.0


