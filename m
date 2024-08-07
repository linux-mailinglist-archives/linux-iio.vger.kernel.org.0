Return-Path: <linux-iio+bounces-8307-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C79F994AADA
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 16:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449C0281AB2
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 14:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F438287E;
	Wed,  7 Aug 2024 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKRtRu63"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD2A7B3F3;
	Wed,  7 Aug 2024 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042690; cv=none; b=nvUDdEHUozPBlmOQB0wEVbISPN08gYFLkb0xHFV4SbcmFsZ3TRk8OcRPwGe5/SGQ9RwK4nKn0XXILQN+r5I4Ch8DPZScLWd5Y1Kva1ipfbGcUMCqrippxQpp1MR0eZLo38QlMljfTa5nX0m2rAcOKAJdsMdpzPgP/r4CvWYbny4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042690; c=relaxed/simple;
	bh=0s0PrjcM83z5fbsB4LsplD5/khHSXg5gF3xvH6Kw6pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nua6jBfIj7pt+ka9BzX5JQvok7uUFSciEx2JE2yX56sm5nhXBOlUdlTY7m5zMYdgXLxA2onDgmv/ECjNPlq3A92ccNeGjqtSIs6n1UWJOdY/qFKgOAn6MqnkHBEADb7g0SdT+0PfxXODSu8b6tsk9k3kAImI81bD4S597GN/RJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKRtRu63; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so18267865e9.2;
        Wed, 07 Aug 2024 07:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723042687; x=1723647487; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EF2DlLSnOdk/pKo666emHKjkZPGYV9IYLaoN6XXm07Y=;
        b=EKRtRu63pfhpnNclH+dPYWMNBuYuedewIDQ8bCZ3tITiHheQLyjjOPqm3uS8tA+Bdp
         lFz7CFCreUZ03j8ybdBSvCpIRBA2sKjPiPD1tHFe8kimEv9W35ncCYaTd1GgKOdZXv4A
         QWT7qxGqn6i/ff38Vp5k3is9DoC0MvMn/Ud0Knu0ataO/cfJOjBqdMxGrMlV7LAT5jUm
         doU1vtj9w5vtItRiUVxZcvKF8Jxssb8hBqvJuhCLnltuGzL69k2O3Heg9/Xmx0l9FlIO
         S5wna/scPx+oO5/UUqY0+0EuAzmVRs6nHUDTwDus/0/mQKJ9WtHuh6aP4osh5koy0eH7
         ExXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723042687; x=1723647487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EF2DlLSnOdk/pKo666emHKjkZPGYV9IYLaoN6XXm07Y=;
        b=Eg7x2r2cstcIsd8KU0jnhNnJifUdSMEr5ewZVZ4PXrBFTew6vDSd4ahbQAuxz702on
         ysbIIAtrNPCQARdT4+fIhQYIKCbOiTXg2LaJLK9Mg8HtWHZZrkPlbJr7gscW9NfIhOr0
         BdvQ0Hpqzyr0rnweNyBjciaW9MtxDJHRltvpU+4KZDs0+gx/O9WLycgVzg9tc2NbWkBf
         3/9AYdcsmGIgnwGBA+MfkOogHPsl3eCzebX8uij61z6PleM5aieFuTWz0HclJZoekJkH
         V755x+XU2bR6HvAE5RP2K7jiTNOUA2f7/VPpux/y562nIC7yJCgf3HvMxGAF0KgZ5WYe
         Itvw==
X-Forwarded-Encrypted: i=1; AJvYcCXDTUe/0W2nyMRICX48G33l44Gk8NU6Gd8Ncqz42luykYONAEe8PMaMEA9zKz0IH9gC7OXyWRdbLdM0hWlWTMQo1ODyq9MUXktM0loJpDEvekUGyVdQL7PCsUluzaJpGTr1HQvLhX7VeTpReG3RuWSuCXNKltMbx9rbxoKAefqJQL4f9w==
X-Gm-Message-State: AOJu0Yxq9yR6GOO0B9qh6qMKqQB3Z3bsVvRUVEQ6tqFCfgo9CzZ2Pc4g
	IpV3sA+ow2oS7AhlyHi+WAHlgpvueQIyjyhHmkEZ1XABD2HKlpp9
X-Google-Smtp-Source: AGHT+IFcxYBvFAX9Q25QB9HvsKHSFuSnAuQwh+rvgADOOYrg9ExFofPYxZONBpmwuglFR3cLJbEoiA==
X-Received: by 2002:a05:600c:198d:b0:426:59d3:8cae with SMTP id 5b1f17b1804b1-428e6b043damr161430145e9.13.1723042686232;
        Wed, 07 Aug 2024 07:58:06 -0700 (PDT)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42905971993sm33273055e9.16.2024.08.07.07.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:58:05 -0700 (PDT)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Google-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Date: Wed, 07 Aug 2024 17:58:04 +0300
Subject: [PATCH 1/2] dt-bindings: adc: ad7173: add support for ad4113
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240807-ad4113-v1-1-2d338f702c7b@analog.com>
References: <20240807-ad4113-v1-0-2d338f702c7b@analog.com>
In-Reply-To: <20240807-ad4113-v1-0-2d338f702c7b@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: mitrutz_ceclan@gmail.com, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dumitru Ceclan <dumitru.ceclan@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723042684; l=1645;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=0s0PrjcM83z5fbsB4LsplD5/khHSXg5gF3xvH6Kw6pk=;
 b=TeroV0fI6VLi5JS3WeJTWsMwljxsGPCc1nexNU8ytevlgW22FyIgcAmpFHuoL0sElepfyWb3P
 T4Bs4rathtEA4sw2lZJSSasOnZCgOImTiRkKWBiB26Ps/YqFhQ/jNK6
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=

This commit adds bindings support for AD4113.

The AD4113 is a low power, low noise, 16-bit, Σ-Δ analog-to-digital
converter (ADC) that integrates an analog front end (AFE) for four
fully differential or eight single-ended inputs.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
index 17c5d39cc2c1..ad15cf9bc2ff 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
@@ -28,6 +28,7 @@ description: |
   Datasheets for supported chips:
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD4111.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD4112.pdf
+    <AD4113: not released yet>
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD4114.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD4115.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD4116.pdf
@@ -44,6 +45,7 @@ properties:
     enum:
       - adi,ad4111
       - adi,ad4112
+      - adi,ad4113
       - adi,ad4114
       - adi,ad4115
       - adi,ad4116
@@ -331,6 +333,7 @@ allOf:
             enum:
               - adi,ad4111
               - adi,ad4112
+              - adi,ad4113
               - adi,ad4114
               - adi,ad4115
               - adi,ad4116

-- 
2.43.0


