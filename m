Return-Path: <linux-iio+bounces-9499-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C24A9780ED
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 15:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADCB2282686
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 13:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BE41DB53F;
	Fri, 13 Sep 2024 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TC2vJYUI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCB71DA608;
	Fri, 13 Sep 2024 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233559; cv=none; b=kIZ85RXYv3n4LNb+fCwjbnxB3B89ekjF2bIS+cTp69wiAo45FqMhJOfbQjvmcMMCeIlQaz+PWjCggaHFykKFXbxiVQlHJk8ar6FpLEPmha2Em6aJQL09+uHskOvgRab2oOyAm8uGesdtYj/UQtjRafJHDLWaCqHrswz8wgBasz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233559; c=relaxed/simple;
	bh=+Hq6cocZ/5AtfkYSuQkKBOiTzXaI16eJzX+aMB/nzDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xtm1Bufv/0xJFol6/t0EGbxRWV+1u2QCFi8pWrn1pS9YpcLhDjgXw/LGYbM3tO1J4cApCLVHMren1MlSPfrh/xR8O0DlmsIq/GbfoeQgdoUwIxhL31Kuf+LXZLuGakqu9BMJCbHP2NT3n5Tfhhjozvclg1PUgcde0QKA8H89LgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TC2vJYUI; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9018103214so292049266b.3;
        Fri, 13 Sep 2024 06:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726233556; x=1726838356; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nKGg1JqyQ8tWRXFIr3jOiwTzcFxMss2m/MiwvVX6Dgc=;
        b=TC2vJYUIuSDL62OQ/J5QwdGEC+G3Dhf/xPgZT3RDsFy2GYw3qhnjGBUo/YMo49grnS
         18QH5/Q17TsXLOizrfyzFVp9KYBqrcgJ7a8F9+CRiOCPlOxhlH0h11C1G57mohIfodUt
         P7dwTFggwdKqTn4otGWz+tsXzcPFSlHdnsZ2VDwJjqPr/h/ETsJpREil5hZ5rLk6vCba
         9Cvw5/jXSje04CDgjcceqTmRRijpr6DvgwkIoWQkFbw/Qgsgg7AhJcmXJzW/7P/YExej
         uNEkDYwfT4v/r+oOOoDE5krFi0xbmag7H7h7Z7Vkr49Xj6TkUOOB8sjNfQVNP965YF/h
         4lfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726233556; x=1726838356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKGg1JqyQ8tWRXFIr3jOiwTzcFxMss2m/MiwvVX6Dgc=;
        b=aPj90rQeuggqY0GgwGUa0+dT2e+ERMyCi1LOXZ0aP1B1Ap35H/j45Hf4TK3H4EWIUZ
         l28M5vky8FCjOIzRBbGd7A6nnl5/6uDpPXct8lhsbwPv4xz6+G86kCddQxuBu2nv8Eyr
         rT/fu4PlQi6QjdnN+V4Pa7dAm4jaPguZeBSyygMGzyg1EllvptMQUq+O0ckL4RK3pI1Z
         0tIOyYJHpCS16RgfPis3w4sB20O9a5tMThxzmJXXF6HfrQ8obgp6Ergd51fgIUUYARCc
         q8hj/V2M4Bzkxfth6xBoq9LSZmMGrSpWR+9ZbaaCOb86/coEvrOO2ApZOXxQ9ILSl6p5
         FGeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2c2805A3HT2O1zpbLbRaa87rz/q7nQtsJH/LydL0yuKKarnqwCJEQ+knbrwlfKU51vO2G2koR+nhM@vger.kernel.org, AJvYcCX4BPa4t8TI+1Hhh4L1rDQJTArf/B1B4TfUj6Ma/jH5+HPGnHBOfFPFPjYqDl4NSNOF9ZxRWxK3RS03ADJu@vger.kernel.org
X-Gm-Message-State: AOJu0Yxom66ki/GEPtlhxwpnCMXc1PtV5QyjbLP3mRqRUiuC7OtUfDFI
	xOLCDm623rcrhP0yr2r7WtwBcbtn0BlChHb4tR9ffsKghnq2uFUB
X-Google-Smtp-Source: AGHT+IFr8l1a1r45CMGOdwRmurG37EDnGUOfBcE+5dkkO6Z/OLUikX7U8qjWpRWox28cmPs9IZ+pGw==
X-Received: by 2002:a17:907:868e:b0:a7d:a00a:aa02 with SMTP id a640c23a62f3a-a90293f9003mr524615966b.1.1726233556188;
        Fri, 13 Sep 2024 06:19:16 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a258a3sm865945666b.89.2024.09.13.06.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 06:19:15 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 13 Sep 2024 15:18:56 +0200
Subject: [PATCH 1/7] dt-bindings: iio: light: veml6030: rename to add
 manufacturer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-veml6035-v1-1-0b09c0c90418@gmail.com>
References: <20240913-veml6035-v1-0-0b09c0c90418@gmail.com>
In-Reply-To: <20240913-veml6035-v1-0-0b09c0c90418@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726233553; l=1065;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=+Hq6cocZ/5AtfkYSuQkKBOiTzXaI16eJzX+aMB/nzDg=;
 b=Gjb9se+F8+f1BU+q8vTIi7eghER/+m/DuN3+9/efO08l5hFALil9W+0rO0lx29geG/GidM6qD
 k0lRYHh76/aCNUkHtdPNmd0jMsbDqJcCb7pcSHBfpzlCg48yhHUdyQ3
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Follow the common pattern manufacturer,devicename.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../bindings/iio/light/{veml6030.yaml => vishay,veml6030.yaml}          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/light/veml6030.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
similarity index 95%
rename from Documentation/devicetree/bindings/iio/light/veml6030.yaml
rename to Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
index fb19a2d7a849..7f4995557570 100644
--- a/Documentation/devicetree/bindings/iio/light/veml6030.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/iio/light/veml6030.yaml#
+$id: http://devicetree.org/schemas/iio/light/vishay,veml6030.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: VEML6030 Ambient Light Sensor (ALS)

-- 
2.43.0


