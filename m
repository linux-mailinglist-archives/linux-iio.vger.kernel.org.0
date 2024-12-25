Return-Path: <linux-iio+bounces-13798-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9199FC63E
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 19:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 105B8162AE9
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 18:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B171C3F1B;
	Wed, 25 Dec 2024 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHEfHCyU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220551C3C03;
	Wed, 25 Dec 2024 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735150432; cv=none; b=kaSSchBlpOJnv54vI8qgCeu3DlM6YODCchwy0mQR0CKpRyoNlk1y70Unqr0fY3g1kBocPVj/7sZpuAK51lU3YI5dA2evvyfuZEAXPtX49fDTOxAGpXsd513FViUrEr6Hm17a4Zcy31ZFk2+afQqBaeW4tSnRo12j8Fa5FdSC4NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735150432; c=relaxed/simple;
	bh=65dl+3BrRongku0AWNhcG9naAriQMM5Jtmkrnh/lkBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uugwcod+OSyTPk/j55vdMlvYn27YZv9vmB1YFGK89Gds6RkBe6rHTPWiFH4Gp9CvwvV4BJHFRFRdjBe5EpLP162W43/A9qZZEjT/OH0SaDHRUdnANA6p48gPe4yQCI4jgYbh+SsUg2ez28Q9ql91ejf6oN4jbK66doYKt1hv9gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHEfHCyU; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa67bc91f87so96447566b.1;
        Wed, 25 Dec 2024 10:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735150429; x=1735755229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cO2/4aH5cQSk3uy/JmgG5dJ+8jnFA9jLBVp9LA1IxKo=;
        b=WHEfHCyUKVhkjApdnhL3qEtWq7/9JJ9dxipiT1MaVEV4TJpvZbVxc2oEkds6WBqiBi
         9io1+Wab2Ppm6FXwlFms87P1ooEVLikXoQhNzazgLVXYOAmSLJ/Q2ozzyuLzAg9UPik/
         JkSuigbEUQQd7ftUqZzDVmgxwQepDf9RZmVCkZoIkibLYigcGFMjgrFgOzoicl3NEmDO
         bWRqzd9IUU1XjscAb7z5I/kufVBrYbIuYDb8dfGWM/hmKftCyYBn0f6+ubt9UrJHw7gI
         CJFfpjSdj3HbJmvtTTG5zRTKALN2ZwLuoCXagGUQV13j3oIda9UdSKRRR+u9HE6Coveh
         rDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735150429; x=1735755229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cO2/4aH5cQSk3uy/JmgG5dJ+8jnFA9jLBVp9LA1IxKo=;
        b=NP3WuqLKlcvrgbpfiEukAVxeUc2uiC4pB5eioYl8WjtJAkeBnX32tUbd0uWpdFQpqB
         SXbZoByTooOt4ZofVk326OYLpYVAUSdv2VrxVZ/t4D350xJnsUCWVWnNxaH/xIo9ncR8
         MF1cVKnZbqdbYpM7Vd0Iok0mOKWMiNB8nuTg6jvnCP45d0IRlxIFlqUjgoBne2Vs/EQq
         yXENvg6BJiobO9iBhTWHOifyMCmMtm7H8xxO+x9QEILExPlCcBuiHi+2weOzU0ZqX6z0
         0Khyrf4fVQxDeTypbQYREipRs27wcMjZNTL39lzqkNShZYo8mabQEaajcML2AhIkzhAv
         JBKg==
X-Forwarded-Encrypted: i=1; AJvYcCWNCQQ/RwYMfsRB/FhGD1b9nLbklAooqivTpfTqNC7CHHvIA/x+Gu6Waaipt/cNyqbrpVQ+GhzAvwNgHfjQ@vger.kernel.org, AJvYcCXTkDFzaqDNo9pP5OvUzRJzqehHI1v3V/vp06B7WW5c/7j9RzyTG6rLRLDnOXkAjEjDAI4aMnvdK58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3oq1h5eoNhcbkhizzIl/H1JXP3f5zBOugZRledN9bfPfQH1mf
	dgjVKLobkdR4Dab0DTUzZBsr6339dDoQ6A0C529gRv/Ad60+gDzTxhBPaQ==
X-Gm-Gg: ASbGncs9DVe9jBLT3bUYwr3yqQl0fs8Y0A1NQjP+KM94PrX0SwbC+rsv1uBIzK2BDG9
	fqtkjOd3YEhNmQ/3icToXMFDJXsYeg9rBc3+qnbjaAdbjuLxYP8exRIUCKYDBZ1R/fxJzVM3RJJ
	HKa20b/GfI9NVpA+zYFJiQibpj7diS8SOTxt3SfFzsPsoKvQxlNvpEDX47MqtM1pz10+Ok3QQRh
	Im+M+PsXS3h8VXjHyjxyeezTWhfnfth0xEzzBXxeo4G1zfCEEEE8HivIJRaqoCD6C+1AO6kERDI
	tAxH1zZUrGjbApk5+H91aq8yVfcvvN7q9A0=
X-Google-Smtp-Source: AGHT+IGeJPhjgLl7snfyXVdVE6ESFoZQZetb49VI2ndejO5KMzLMJRsusERhe2r8lf9/NkyGW9r0cQ==
X-Received: by 2002:a05:6402:3550:b0:5d4:35c7:cd70 with SMTP id 4fb4d7f45d1cf-5d81dd9cbebmr7516660a12.4.1735150428998;
        Wed, 25 Dec 2024 10:13:48 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701ca31sm7721141a12.88.2024.12.25.10.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2024 10:13:47 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 2/7] dt-bindings: iio: accel: adxl345: make interrupts not a required property
Date: Wed, 25 Dec 2024 18:13:33 +0000
Message-Id: <20241225181338.69672-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241225181338.69672-1-l.rubusch@gmail.com>
References: <20241225181338.69672-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove interrupts from the list of required properties. The ADXL345
does not need interrupts for basic accelerometer functionality.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
index 280ed479e..bc46ed00f 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
@@ -40,7 +40,6 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
-- 
2.39.5


