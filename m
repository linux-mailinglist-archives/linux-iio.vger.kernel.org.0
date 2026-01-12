Return-Path: <linux-iio+bounces-27653-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3638D14818
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 18:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6FE3F301AFF4
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 17:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C453337FF5A;
	Mon, 12 Jan 2026 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Jo0Qxd+Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AF737F73B
	for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240006; cv=none; b=GihwWTD1s9AP1YZpJ28sio+xxsoJqRsHQZwhtiUdovvDn3dVIu0DVjFAiJRtdPsJB3XMx3k/UTlU5s+dKl+mvwrAU+MRcb+YRL4wCRwCQOKlbe1xqJefKmYvyCtFYjoi4j1LsdOfl+PbFR19qA6/r3pScbcjziQjeste9puE3eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240006; c=relaxed/simple;
	bh=5I7PkElvI/QDjLf0Z/OEy6DcC7qQ3z0STtb9p1MBJUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fv/8OBvpDN4+HGU7xkhpq7y2FmC3bx6P1sxA8k7wG8SmSxHzem6q5j0onBnBTqJnJxTbmNzzpqV7JENxXgbv012fvCqDnendVQqX9MGmt/jRe89b+hD3TnIjQbUBw4Y7PFmMsNNmpV5z6aIzgIguGX6+DOUqusm0FRf14xS/08Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Jo0Qxd+Q; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-65d096dd0ceso1496049eaf.3
        for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 09:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768239999; x=1768844799; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ntRRDJ0mhGxRxJjOCnV3YMsjSIA0lMGQZKt83lwpVw8=;
        b=Jo0Qxd+QnbCd3qu/JOWm6I387Yztrw6N4IC6jyYKVD62PnkRO2npwbzU5b6RPrfpOS
         /1a6xbaHTPsERIdqgby+nn+ACXvIxaor6APIxbk3A8qnFUXNIfU/rZETUUNYzmmQCE69
         yhFlylBLCBDqczUDOwy+YxwMqXpfyFpPhgaWBrRSSWo+pN993QPTUPicmEh8syN+wpYF
         z+zDtaTKMuygK4yghAzlB+HLokckbR38bFJ+i3sE/qHwyRI5eWItLA1X9f4IsbNJQRre
         5PbJ3LUhpWUyEyeIU9HD+pTRheUbkq+9gvoYYtUqwgo5YHhq7WXY4ZIQtxVQl5YeXrUG
         YSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768239999; x=1768844799;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ntRRDJ0mhGxRxJjOCnV3YMsjSIA0lMGQZKt83lwpVw8=;
        b=HTHcUh/wWSEruKZBE7CdK48kN3TicydjgOkDgGJAB8KZkqK4SjfVRmIcqmohRXZrtC
         cELGirkCdWQyq/LebqSyQ2RtanpXSsTSDx9r5+uOBvmrtaIkQjYQkvisbwDOu8MENn53
         iGpRA11dmOaegn4ivYQM5MZhghcN0b8Z3ueFHg4eEN/a3qSGZmDwh3ifQxVEEYN6DwGV
         niO+5C2w+rCfLphxsAWWlqO/j9urhmzd6mQ6Uyr76tU85UwmNMvBrvMjqnIwU2S3rctp
         LI5NXw2PwqxZaDRqE3BdJzOi21jek0sQAnFdtbiOULCRVkPZyTLBXRujPXPU+EAkTYTc
         8vZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZatLaXA4ihwhPG7tYljy4bjAe2SG/CgfayfoUzSrGiaOwMingxVVQytAHoLlGwjef5IYLVVust24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnSNd3zVikcCJtg4je6NtAsPziqYSy1HdyPilrey7rlbt83coe
	K48/la+K6Hn/MVTjGkF5jpfZyMsB9Z8fwCr/nwJiEz4N7A2CDb7N52cYpJGeh7dJeYM=
X-Gm-Gg: AY/fxX6JizuXfyUWc4ZWgCMkz58R8ZHkL2lZ4ujMnTH5BCQHPRsGK2tvDbbWPiUxpuA
	YO7DXJZRB1F8BtBEQxJ4xVeui+E5oxtvJyFNmZ0wznbP1N4mOPEYX2RyJ/pJn4x/9ao4o55ttoo
	w33YljdRIMx8rZKO0DYaQizyXlh9ztKVIHlKgy1WHNkv4iwSsAVu9XJnWuA/3HVzG3Eeonm03QA
	wrAUHgM0uDldx49zpWMDghQUgAgv0RXafAttKHNHqbqpoOl6npsW2BwFf6V8AYSUETt9kqcKgK5
	CHhQL98ZjD85pm5H7Nthnn/1jPqIM9S1h+aZ1X+IVWl0HLhOSH6hZMDtaMeWR204DlseB8eaUxE
	i7J/1ajL5hLUBQ0bGK8KMMG719RFwEOod95VTQzdQqBI9rv113z8/tcFSM67kiuA7BX8d1vBRBE
	TDrqCKmWnov9WslNA=
X-Google-Smtp-Source: AGHT+IFiaftIJ69sOLPq3ixcNVR0VUuOj8vMlHN3HGEdK6z3xQM1GDjxG/0H1AEb4SaXoGIQ8FUbfQ==
X-Received: by 2002:a05:6820:4806:b0:65b:c34c:456a with SMTP id 006d021491bc7-65f54ed5f4emr5816630eaf.8.1768239999314;
        Mon, 12 Jan 2026 09:46:39 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6b4b:49b3:cce5:b58f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4de40bfsm12126941fac.5.2026.01.12.09.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:46:37 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 12 Jan 2026 11:45:26 -0600
Subject: [PATCH v5 8/9] dt-bindings: iio: adc: adi,ad7380: add
 spi-rx-bus-width property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-spi-add-multi-bus-support-v5-8-295f4f09f6ba@baylibre.com>
References: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
In-Reply-To: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2044; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=5I7PkElvI/QDjLf0Z/OEy6DcC7qQ3z0STtb9p1MBJUQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpZTNmhb/Q2l8V/klQBRsZZvQgnvEbEu3F7DNir
 ZbPmDGx0ZWJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaWUzZgAKCRDCzCAB/wGP
 wOnlCACQpsbU1N9NI9THXrV1RGljiU/Rj6uCF+ihMjA1olcu6cpnG/ygNiLcTzRZ7jTYF5inudI
 /U9nmpXb3/9Ir2GaNyVjo0DGTwL1K58GdcAPdwMnOTjflSQ8rTzO+dzrYmHQx5FuYFp6HkVqVIG
 LXg00DeQHNcJlgMBDo4RWqDC4oHX3fAvs32nMxGkR3/WAu2GINNyCnaz/V2dxaObp8anjy1Bq3p
 grreHoX3to6eYu4kpWxhd5hcbTuUx6+VtdY6vAwbEXdhsbFK8byzwqg5j7IaecX3eQHU0AGTJpd
 iLSLhGyXE6MJCBTYuRUPsXfH3q6E/6uRbdrNcD9PhRLMEuZj
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add spi-rx-bus-width property to describe how many SDO lines are wired
up on the ADC. These chips are simultaneous sampling ADCs and have one
SDO line per channel, either 2 or 4 total depending on the part number.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v4 changes:
* Change to use spi-rx-bus-width property instead of spi-lanes.

v3 changes:
* Renamed "buses" to "lanes" to reflect devicetree property name change.
---
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
index b91bfb16ed6b..396e1a1aa805 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -62,6 +62,11 @@ properties:
   spi-cpol: true
   spi-cpha: true
 
+  spi-rx-bus-width:
+    maxItems: 4
+    items:
+      maximum: 1
+
   vcc-supply:
     description: A 3V to 3.6V supply that powers the chip.
 
@@ -160,6 +165,23 @@ patternProperties:
 unevaluatedProperties: false
 
 allOf:
+  # 2-channel chips only have two SDO lines
+  - if:
+      properties:
+        compatible:
+          enum:
+            - adi,ad7380
+            - adi,ad7381
+            - adi,ad7383
+            - adi,ad7384
+            - adi,ad7386
+            - adi,ad7387
+            - adi,ad7388
+    then:
+      properties:
+        spi-rx-bus-width:
+          maxItems: 2
+
   # pseudo-differential chips require common mode voltage supplies,
   # true differential chips don't use them
   - if:
@@ -284,6 +306,7 @@ examples:
             spi-cpol;
             spi-cpha;
             spi-max-frequency = <80000000>;
+            spi-rx-bus-width = <1>, <1>, <1>, <1>;
 
             interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
             interrupt-parent = <&gpio0>;

-- 
2.43.0


