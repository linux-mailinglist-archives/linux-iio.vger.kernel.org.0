Return-Path: <linux-iio+bounces-9003-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA12968850
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 15:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2E11C229B0
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 13:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025FF20FA9F;
	Mon,  2 Sep 2024 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X96lmF18"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A5C1DAC5B;
	Mon,  2 Sep 2024 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282143; cv=none; b=WU3v2u8Bm71p/LspjKZ0e8lYYvTjRQZJaJf3RYnuAZAI2jcPEp3D+0+NV1N2bXwgPdsgBFdOuCyfm+wEHJ3kvtfjuDc4GQXZYkQ9q1pTHpUz5ugjJXdWPaZX+cbHK0HglKcRUG61ZWpjQNzqAD1d+eviAvUief+xpbn7g6pOPeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282143; c=relaxed/simple;
	bh=iLZMvPxWL/hM07xtESp0zfM5h8Z2IElrY3m6ozv0NZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h9DuobVxXJP3cQbWzD1PjoKSHJCeQwKjPuZm5C9brDEOl2FssuZJ3NFCcxA71yFCsdmIkghOQk0BV3HrR8Zsf2mF0X/Q7jkm+dqNe5xnlz87GYSEx4Y4RwauMnz3Cfauvnw+QXU9nv3KoRnkFA6dEN5PQ0SA342xkugiUi3/YhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X96lmF18; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5bed83488b6so4085896a12.2;
        Mon, 02 Sep 2024 06:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725282140; x=1725886940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISPUB3+TfMJL8WlSN0HaXE5GbA9EGj6rpkzOcqEjHyg=;
        b=X96lmF18RoD2edJLMp1mTIjExzerd7ctRTPKArkk2rFuXQAKatL/UiET2+hGo1thy8
         gzJXtLb/Ak+DibQtBjfUH8YZM34J9yd/UjBf2ADcVkHxDRQdkzdRQPmORNpTHrsS6dS/
         olBC9s8VLpcV12FDkwY6JKaWIPGwH8w8v7KponY0wX5phuHM6lybBiZ1Bo57PXgPBQgk
         c0yMUo2f7ZVopcTTYyNrShxRE1m+opaqVlq9g2Occ+WoWGtTBepFJ3CS5hxAWX2z+TI6
         kOGSRoMp0/TlkVYQWUYhHEcaIyfG79ioXcuXYVxmx3tj5I6VfZo8TnSfWmVRtoLFsUoZ
         FadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725282140; x=1725886940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISPUB3+TfMJL8WlSN0HaXE5GbA9EGj6rpkzOcqEjHyg=;
        b=tjyXOSVGL0nzpECFUP09eLVOnlEUqWX7gBag/1fEtjm+oY6lbSVWI6uWYoBE8qHRYT
         HnqWRQvSsjWoPNNFnxmVilBAdkV+VSjXsPso4ttYXYZVipaRbFM32hJV4genx58QlFhK
         xGEpYO16/YOgcL+qSlYtQ1MGmmEAqOW4lNmhiQncuQQDkx28KiXoPol2trwMVOB0sw1d
         JiJG8xfi8egxAvekzIbdmDF7OLeYviGU+qOYp0oiKi5Cw1Ud148/Esho22wYxx6OC6uq
         le1cUFLrRQOniUH0NyX1lbT2yrwROtMTTgA97fezkF1nCIL1wfypHTlba824nqb7TbSZ
         fsNA==
X-Forwarded-Encrypted: i=1; AJvYcCUS/WNpcv8A/oifETg0+OujYnwdSNgXlRmmbQl7PF7cdOHZOAD8enyReMq4ME72KJPGh9pIWvKi7za8@vger.kernel.org, AJvYcCUmdUDFLcrv5m1GpYw4Q89txptME4x9y9YhZ14kA7dDdg3u/d8CAVr4MC8Whhh1vQp+Lgm4NblKV/Hav5wo@vger.kernel.org, AJvYcCUoaRHC6GGh7j4MH0Zv+Q8Q5Kb0NkAw/HxvGnA9EmnlpeGU6KDAxjoUnN1gB4WdViyRgg/IJP9lG8Cl@vger.kernel.org
X-Gm-Message-State: AOJu0YxOtmRAKUE+42LciIlFdRdqohVoPaUra5iJj2+JBnNnmvgs7z6c
	wGkejD8LSpB2zsXsZg5ZKBY3QxKiq4jdgBOruRZIPHr/x/pnWhkFPLcw8BpPbUAXQw==
X-Google-Smtp-Source: AGHT+IHzdL6H4IGR1sZ7NvQk63I3rQxGhyF/XvlgiQIr88pIt1WNgJPfwXOHq/wo5j8XyiqNrScKgA==
X-Received: by 2002:a17:907:d8c:b0:a86:8863:2bf0 with SMTP id a640c23a62f3a-a897fa74f73mr1138857766b.48.1725282139845;
        Mon, 02 Sep 2024 06:02:19 -0700 (PDT)
Received: from localhost.localdomain ([37.162.182.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989196968sm554979066b.139.2024.09.02.06.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 06:02:19 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org
Cc: pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH 2/2] dt-bindings: iio: temperature: tmp006: document interrupt
Date: Mon,  2 Sep 2024 14:59:49 +0200
Message-Id: <20240902125946.350635-3-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902125946.350635-1-apokusinski01@gmail.com>
References: <20240902125946.350635-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the example with interrupt bindings and add "interrupts" property

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 .../devicetree/bindings/iio/temperature/ti,tmp006.yaml      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml
index d43002b9bfdc..590f50ba3a31 100644
--- a/Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml
@@ -23,6 +23,9 @@ properties:
   vdd-supply:
     description: provide VDD power to the sensor.
 
+  interrupts:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -31,6 +34,7 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -38,5 +42,7 @@ examples:
             compatible = "ti,tmp006";
             reg = <0x40>;
             vdd-supply = <&ldo4_reg>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
         };
     };
-- 
2.25.1


