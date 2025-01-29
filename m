Return-Path: <linux-iio+bounces-14695-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C128A21BA9
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 12:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752251882442
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 11:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376451B4121;
	Wed, 29 Jan 2025 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yq/gACss"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3C21B415C
	for <linux-iio@vger.kernel.org>; Wed, 29 Jan 2025 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738148701; cv=none; b=TAi1SyBRcd/ltIfd+RZxCjc56ykV3wKfm1HWQJpNhkEMdbkzyxdJ2+1kEDMBu7JHwmwt7GsEV0WLzOhUY/TSh5dbou3bSYB1g9Go+7jSKyBc/fTwvAK0WPaXiV+E7oqz48l0V9y3nyFR26L9wfWefv9831xGsKPm2hv1+HsgE7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738148701; c=relaxed/simple;
	bh=qTP9VZUeKRuaZ9Hqi5LnAy3vZJvi795fRxc+xbuF8Io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iLWaGUkfNpwMMVlfyiyip/pZTP63Zlh9n21xmJmzifu2QJMpOp1DV2QEsVwk88kyJl+bgDuNnmAzk7pTTIPnywCQBT6I+VIiG1CfgWK/8Xko+uf8hpXCkAkO3GgWptrlFTAlYKazVNElgM9Zp2nqRUiEATLxXMdmIXhBSMIcNuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yq/gACss; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3862f32a33eso3092107f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 29 Jan 2025 03:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738148697; x=1738753497; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vjQqajOlG7CxEKLfZvVkKt1P2pyBeTRvUu/sCOgs0mw=;
        b=yq/gACssKX8rQhDMds6SLHK7d7qPBSLXuWCSIA+BltrjAMGOjRDPkIwLX+nm4tK7dt
         nNifzCSqvgDSHrFzAP7WqsR8VN4j/2nwUvbMZW9+4IPEgHiTyzIJPyH9HBufzxxi7q+h
         te0tHiakS2DZ7nSmIq+RMpur8kqNIQWvSyDSct6L7TSC3qypEU1EVyqnqjRiRYcyCmTk
         EuC1yzHKY352syOFjAZDV8gqwSiB34gYZlj8b/TR6XHqO/cylVpUzWQnsStSDjvtIuvg
         pik3RlgR9FmPDxKNoRHWT4JeYwaSnX7mXQS877HhHMkR5Ows7j8yE/YrjCzCN5PWFDl8
         vrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738148697; x=1738753497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjQqajOlG7CxEKLfZvVkKt1P2pyBeTRvUu/sCOgs0mw=;
        b=shZmgtY4vAueCehvs4+OX/BCi70ynaPXod8FVziKELzYi9Tw+9woKGOT5qM/rK/QsJ
         DLBlT539MfZy427PTWoPjtnAfbHv4Fd4kj/UdJqzyW1WMXRuo5yxlVp0zL7AhsulkZ7w
         +rBRUkOVY9PpeA3mUiFlN3W9MS1Qs9OiebqMb7LvnOxyw+OrTDmIuAKPJnBaAGyrZwrk
         zuc9vbr3myVpm126jTb7WYAbRc0FUxZctoowrMwPu7oXLWDVbrvofvivb8ttiB08QPnq
         6XtMYfVWlbvBs/e2L6s4KAmkMhgmp5yYlGVtIfHqTP4ywt6CAfstmSzwEgnLBx6i9rmS
         kZsg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ2rvyHCn5hv0bzUR3GGp686spC6PfenxwEAp/tGy7SnYeIpAbqcwHGlKJb+3ODfl85Eyy+yDk+nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEG0wy9PAx5HkaPgbAXuaA4637A01KYW8vt+vx7By3L0jD02m2
	hhDSIGKmiCmSIpaDHvDMOvGtT1wc9D7yX5w/qgdlKBmB6pvSjpXrG/gavBsXmmYNGMeT3XP1PsC
	1
X-Gm-Gg: ASbGncsZ0ruc2MQjUpTZqesnmSOZT1zZGwsQNc80E/piDGeShuYSo0vSKHTT3J/z8lb
	fxvC5DluW+Zrme1agSgEixT5B71ocbKtK7aWVNRv5eQsgtiuxjZPKd5CZWc3rc8U/UkDoJZVk5U
	tpIYq7oDbWagE4L/7UdJJDyznPjg+2ZGE/UylYeyKMd1R06A+bGoXRLXyy69KWMjPPN31i6hvCm
	l9UmeKRx1VwA+STg9h8gadgxllV5LdDRL1odk4ipfdqwL1dTyWZX33KAYU8TCaf0BIACTmzXD3j
	/iRTA+jpU4a2v7W4QTbNfLA1tGksAg8LBYmsLfMF7um/vEt7JvnmN3KQ/7Gz1kmZbQoAMLM=
X-Google-Smtp-Source: AGHT+IGuZV55gZIAdwXj62dAal2XvKkGucrO0OnzpAfK3Sa3kD6jA1qfS4afbucGb1xx4G4rVbpYwA==
X-Received: by 2002:a5d:6489:0:b0:38c:246f:b0b3 with SMTP id ffacd0b85a97d-38c52097871mr2095096f8f.51.1738148697140;
        Wed, 29 Jan 2025 03:04:57 -0800 (PST)
Received: from [127.0.1.1] (host-95-245-235-245.retail.telecomitalia.it. [95.245.235.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a17d7a7sm17107364f8f.32.2025.01.29.03.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 03:04:56 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 29 Jan 2025 12:03:02 +0100
Subject: [PATCH v3 01/10] dt-bindings: iio: dac: adi-axi-adc: fix ad7606
 pwm-names
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-1-c3aec77c0ab7@baylibre.com>
References: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-0-c3aec77c0ab7@baylibre.com>
In-Reply-To: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-0-c3aec77c0ab7@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume Stols <gstols@baylibre.com>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Fix make dt_binding_check warning:

DTC [C] Documentation/devicetree/bindings/iio/adc/adi,axi-adc.example.dtb
.../adc/adi,axi-adc.example.dtb: adc@0: pwm-names: ['convst1'] is too short
    from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad7606.yaml#

Add "minItems" to pwm-names, it allows to use one single pwm when
connected to both adc conversion inputs.

Fixes: 7c2357b10490 ("dt-bindings: iio: adc: ad7606: Add iio backend bindings")
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index ab5881d0d017..52d3f1ce3367 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -146,6 +146,7 @@ properties:
     maxItems: 2
 
   pwm-names:
+    minItems: 1
     items:
       - const: convst1
       - const: convst2

-- 
2.47.0


