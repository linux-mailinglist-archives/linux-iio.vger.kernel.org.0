Return-Path: <linux-iio+bounces-5042-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B166D8C55B3
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 14:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24521C22796
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 12:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E3A6EB45;
	Tue, 14 May 2024 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipCqiPUD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259476D1A1;
	Tue, 14 May 2024 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715688199; cv=none; b=LtnjqU7YMjlhjvIBrzgH8ekr/esX3yAYEJbEVCOdEXpu1BfNphOnB7E328gYuH7j4h5Vevnst3DHod5YMnt/VzYc8L4Hy8GaG2T7cf4UepQ9gztc7ewJoE0A5xLkhoOrAjiBfqLEJYzOU/vOGw7xhEV8o3h+Nab2UPQb0+bec8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715688199; c=relaxed/simple;
	bh=X8r4hIrOJ9C+pyj1LUuZECEONg78eNjz7pRSFpnWAUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uY1Y0pdWj+UhoW6A2WdbVP8jSuGkV8hGxHlNZttdMU/gMPrB4y4Lu3jD4advtEiraHu/TYzytIw6p7xFqbW0tjUFxnAL7OvvV+w0lFE04286IOf/ptgNTmrgKUcU/Y1q3YdjP5i7fCa1EBuZsujl3ldcYnRH4W0T1QnUqNEweZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipCqiPUD; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34db6a299b8so4159502f8f.3;
        Tue, 14 May 2024 05:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715688196; x=1716292996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PswJmJ1fl3Wt97HYv1Mi+7SG4jeTtm76Cj1AvJ081Rk=;
        b=ipCqiPUDO798Ifl0sdHEEbKQSr4neaFSC1765PbCR+kcjsgKpg3rKUgeG9gCHOS92P
         y4AvcK5l5r/YTusGoREzRPamVeLKlJPS2TQiXlOFxSIsjdPQ1YwZmxbxSFNyeN1LuoTQ
         iyy+yg2Drrp/28Z1zmvM522Z71al2hjQncIQNFAMjQ/ZHg7cT7+Jr3P0P39TZo0pNDD2
         KxjWTHbhKnjOGAb6GhD/NmFd7UuGCWb8fkR6zd/t28vGX1KUM0NdY8YuB8gE8jLPjAIt
         cifWXUlpN2730vNvYkVajASVL/8cdt0d0oIUdSo8bkb9zu2jAA9hdukctDEFPJDMExHU
         1Xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715688196; x=1716292996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PswJmJ1fl3Wt97HYv1Mi+7SG4jeTtm76Cj1AvJ081Rk=;
        b=aWpAUq21ROJpkMNpSK124N7EruIb743pN+GjmIFok5WprYQJmVEelPSBFuyLh7ah65
         DmsLOs5hofyTgRx2QrmzetqpkKwF7XkRkQ5C2GSd30/ITctR9Wrr99SHfH68lyXxfZE3
         I81Z1q1uIhWu9ZE99q2cmEu4bvwy55AZgdXvOJbCqSkbJGrG0VFKfbJcw6eAWqJDKMkE
         xdBRa7qebw9ui+++BoDYDnLfcDca6HkrVjDrgcpVExWI564GpVjIseRT54h64ocq3fwU
         gy4Y566/QCPKlNyHEoI4FmB02yqUniBWWQ5uApjdrr9wcEarVm3JSlBHVd8UBfqfJY1X
         k14w==
X-Forwarded-Encrypted: i=1; AJvYcCX/+4Dxxiy79iwsCDl9Lc1WIDLUQsESXr674hJvjMtJyexZvnqbTGDZ1bbkTMqCqnKxVgpoB1J7KTTWBHHmxb+XrJZxXjeNeuGgrSGVwcLaSlvekp3qYUnAeiSeUBmzq8E5CNnRheh9x84r8wiz9jClGl+Wxqm1GM1sjww4GxZjWmGGGg==
X-Gm-Message-State: AOJu0Yy3S9dwmKQEnbOsqAZ3TYeFu9rVzhlipiUjiss2lpU2fnAnIh31
	hBCB1T9fNPXNFwJ25KS/7ioUGDcAavbsxZafPyaMIdrr06c+SKUt
X-Google-Smtp-Source: AGHT+IFrqTl+dhTyyRFP5KW68C8aR4ykId6cwc9RT+MSlr07ZzuvpFvrtwWICJj8yytuM9HhbFBh6A==
X-Received: by 2002:adf:c58a:0:b0:34a:56e7:5cc4 with SMTP id ffacd0b85a97d-351bfd2aa96mr4493095f8f.2.1715688196381;
        Tue, 14 May 2024 05:03:16 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a105:8300:5179:8171:3530:3b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b896a06sm13593927f8f.27.2024.05.14.05.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 05:03:16 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: michael.hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	marcelo.schmitt@analog.com,
	bigunclemax@gmail.com,
	dlechner@baylibre.com,
	okan.sahin@analog.com,
	fr0st61te@gmail.com,
	alisa.roman@analog.com,
	marcus.folkesson@gmail.com,
	schnelle@linux.ibm.com,
	liambeguin@gmail.com
Subject: [PATCH v8 4/6] dt-bindings: iio: adc: Add single-channel property
Date: Tue, 14 May 2024 15:02:20 +0300
Message-Id: <20240514120222.56488-5-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240514120222.56488-1-alisa.roman@analog.com>
References: <20240514120222.56488-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devices that have both single-ended channels and differential channels
cause a bit of confusion when the channels are configured in the
devicetree.

Clarify difference between these two types of channels for such devices
by adding single-channel property alongside diff-channels. They should
be mutually exclusive.

Devices that have only single-ended channels can still use reg property
to reference a channel like before.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 .../devicetree/bindings/iio/adc/adc.yaml      | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index 36775f8f71df..0a77592f7388 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -38,6 +38,14 @@ properties:
       The first value specifies the positive input pin, the second
       specifies the negative input pin.
 
+  single-channel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      When devices combine single-ended and differential channels, allow the
+      channel for a single element to be specified, independent of reg (as for
+      differential channels). If this and diff-channels are not present reg
+      shall be used instead.
+
   settling-time-us:
     description:
       Time between enabling the channel and first stable readings.
@@ -50,4 +58,15 @@ properties:
       device design and can interact with other characteristics such as
       settling time.
 
+anyOf:
+  - oneOf:
+      - required:
+          - reg
+          - diff-channels
+      - required:
+          - reg
+          - single-channel
+  - required:
+      - reg
+
 additionalProperties: true
-- 
2.34.1


