Return-Path: <linux-iio+bounces-9640-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D1E97C6EE
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2024 11:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D79285C90
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2024 09:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E006B19ABCB;
	Thu, 19 Sep 2024 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GruvSxtG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F082B199957
	for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2024 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737701; cv=none; b=VLS+WeBhtxd6w141GF20NGXfAEmDhM2YwPE/XEgS5PHRzTqLjCJWEZPUgREmVmCP6/LnCYjOlAflui/7gsm8HEG+3q2NIBOSNG3hghZEfNdXtAN8Nf8Eq8wr+CcbCPZQmHCDSObOfZMWRuyusK3+isJQu8HK3oA0iO1jo+Ye/B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737701; c=relaxed/simple;
	bh=i5PZepG1aoFBTCiFDPOYVCA2IFjIkELc4/8zmw5imSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eLtX7NRY4ZvrVekWc/yhFU+oNElevLYA/P3LFTkCwaME7Rfkv3pqYrKOIjD2tLNLOV+b9JOYOOuIilTNRnaWbi1q2y/tkP6ZG09vMOqpdYRoJitRaWG+bohGkiICltULxgmMindV5gG4mx9fIZCeVJSiy0VU9tUFAqZ6GadkMEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GruvSxtG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cba0dc922so4590775e9.3
        for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2024 02:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726737698; x=1727342498; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMa/yQ2Im0//zhcPUCeMNBxbg9N98XT4Go0CFqsD1eY=;
        b=GruvSxtGn9TXNzz/DRl1ik8zufhfSeZzIUD1oo/6oGTLyz+0Amwpy6h19B8ylUbj/u
         UOj2km66k6zmq3DpW7vbx7gYYnble0ojqbn+2huTythr84vx44PmoxLps4Q/8na1umR3
         lKXxd04oBz1tKUzKf9d2cyF/iPEWbghnkLdsHPxLEM+8Lzilvi66lYYH+p1E+ZFNEODu
         fz7g8EtlgAPUQ9m7NQ98aBbCDxsnIt3mdXsAWWXrrs0v0yXsHAJLt6AXvXfg/n3Szn1c
         etrEjxtVkOZVB9RfCcBhZBuhxcuFRKKBGCxBIkRDOg/EkmKSvYjWxwBN45p8yht9E3KB
         0Q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726737698; x=1727342498;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMa/yQ2Im0//zhcPUCeMNBxbg9N98XT4Go0CFqsD1eY=;
        b=AyeAhUPnHIxWI26GGCr4czbP+rGJkkdmRjqCYCTjOuB4xX3Uh7EZA/D/2Lb0Lsw7Cf
         JOdLnHiKCFp+G08TyENOjRWuKEeP0JOLXHXF9pdrZkCYlHNaZlrKnTHnSktHIOW4JidF
         dJg/tmdf8QZIiiiK/Z9wA0oroxtK1kkNHet4L24YRojTuGfgO8Xzuty8aTCSuH/OdKr0
         DcyB5PTed9e52z930PG5nupEdGk4OwwHwVfhti9cMrW0P04LKnlsN+RW8fjOoqYypnRn
         0dkfPpPF9LJXKYWyGfC3DOf3z/XGopzKHhHFqhe2aTxX6TVUFfbTPGNBzNIeoUgtv3VM
         P/bQ==
X-Gm-Message-State: AOJu0YyyIibnWGMu3Gud8J0WS8CE7iOQcBiAttA6cI77V1kbuv0XQU3t
	9qOiXK3WEsYhZEnMDdbWGtRXJWcyp8sdouyXuBDFLpMbe8Q9hbEIRki8ycu1gKM=
X-Google-Smtp-Source: AGHT+IFzaSnso6ocrF9emwd2RsWQlvTAmzurK9UZ8AOuiIHpVPVrYdehMMnowjm9qAv3d8lc18uSxQ==
X-Received: by 2002:a05:600c:4e8a:b0:427:abed:3602 with SMTP id 5b1f17b1804b1-42cdb5675f3mr190980895e9.24.1726737698218;
        Thu, 19 Sep 2024 02:21:38 -0700 (PDT)
Received: from [127.0.1.1] (host-80-117-99-70.retail.telecomitalia.it. [80.117.99.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75468413sm16889465e9.45.2024.09.19.02.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 02:21:37 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 19 Sep 2024 11:19:59 +0200
Subject: [PATCH v3 03/10] dt-bindings: iio: dac: ad3552r: fix maximum spi
 speed
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-3-a17b9b3d05d9@baylibre.com>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
In-Reply-To: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, dlechner@baylibre.com, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Fix maximum SPI clock speed, as per datasheet (Rev. B, page 6).

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
index fc8b97f82077..41fe00034742 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
@@ -30,7 +30,7 @@ properties:
     maxItems: 1
 
   spi-max-frequency:
-    maximum: 30000000
+    maximum: 66000000
 
   reset-gpios:
     maxItems: 1

-- 
2.45.0.rc1


