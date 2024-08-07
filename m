Return-Path: <linux-iio+bounces-8306-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1FC94AAD7
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 16:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97B71F28CFB
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 14:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E465281751;
	Wed,  7 Aug 2024 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H99cg1bS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147E080BF8;
	Wed,  7 Aug 2024 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042688; cv=none; b=INskcQsBhFFJ5tmbyOFSckhx5Cm2IaaHQGZZtTvfc5YFlIJfPt19Gcd6lYJ6aleT2yL6ewGSzDmeRvnxMon3S0qVpzobxfYr3rj929Rrz39zUfrwe709TR9OC/VWLYIkPOzr1pJ8EJrK5wSWVazC3EzevOr0phmMrA95NjHr3H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042688; c=relaxed/simple;
	bh=qVznd9P5OEpZiNYPaWiEPGPDivKEA64oSkps+3rnKOY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AXvCc4n8MCV7h+xWRP5wsaj3wiXVJ7vWuCSPYQ+/XxwElCN58c/nAeZvIblzZGpB35+hGXHUs9Oy6K8r2CI3tIDEIXgyF4HFPoP4GxMKEFArwP/rlK5F+J7VoTQUpnJj3LoHhZVNtwjUxJjRu12AGES5KyvdA9xpGy49ZGnMkFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H99cg1bS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42812945633so14056765e9.0;
        Wed, 07 Aug 2024 07:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723042685; x=1723647485; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KfIk4TSI81SsyrNk2hyW9UN9PuOKnr5OVUU+Hp8oa+E=;
        b=H99cg1bSABOdUPp5KhLoXIUxs/jmAicrvmLly6mTQSEsKDtKNg8r0eLtzehO81zsIY
         VOVj7wA9b1AFDN+c0ZDEF7159l3KF7Mwd8WI1WiGu8NsCmu97nSjjItVetK7dvT9E+VM
         RfUBrlsWI46/4Dua1yN40fPWsGIhT3hz10vNcrCcv8o/xkGnujV0MtprikKZ7aDh7d1t
         1vZwzUrpQ+1c80Aph+jz4jPv2DQRteZ4/aBXV5h9R+TKyvEMxpa0N/34YIsLIUEp0KX9
         BwK02JjtLTxNCs8hXRUHlBv0dUQoP28epdaqcc7r6mRAbfYAFyBEm6SVBcU5e1s+dFR5
         Fxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723042685; x=1723647485;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KfIk4TSI81SsyrNk2hyW9UN9PuOKnr5OVUU+Hp8oa+E=;
        b=GMP3vD0HCBUNwHT77qozCk5Fuvg/YBQs97x48lKsHzEdYIStkXv/UBWNQJfxay/v07
         zKTeWaAcwRhsrJxc/CjfyTLaLexuKX1oQre6/uJxA6ZNnQcMg7kPSBiPc2smof5xJOSW
         CTrmkENx1HNDYfPwpaLdREnoAV0x/133l/1FU/+MAB12t1/G4iss+pTszP4iFLpVGUNm
         e8yIhhBWa2hYkQa+xoX5cUxjNsn//7nR2v8nL1vbdbcDtNkbNSEno8sW9SBDalEc472N
         EbMaE+jUeYP1nzuX4gJm8JRA/4HIUECkJLx5eLMkCeyNjxvJZeFL1JYGPwijDt3rmCsq
         E04A==
X-Forwarded-Encrypted: i=1; AJvYcCUSh/zS+b6o/iuJ3Zwc+cgw46S9vYieUU8T89WctZPzVUMAFTCmrkvs/QOEBcOgfFunZ983GWoVYmcTLInUpDv0yjKzz9iCjNAVMf7wlWPM//iXV754o9aAEN1d45X6Q4mRYb8fjeikDCzS/EdNPBkSiiZHe6NLFXqP1rjVAIvUxSwoLQ==
X-Gm-Message-State: AOJu0YzKC/gx7VCN11YJ57A7MYNiXnrF6gMSvf8O14PtRlPBYnqFUT4d
	FG78tUjFilxjK9kPsJfA28jIhrfG0VE0kAA5srjS9vp7yfKQljyM
X-Google-Smtp-Source: AGHT+IHK7NZ+wqyO67FZRL0zeC+aZ382NHKk9ACDoZwHGgYt4mYBwFHjuKM9bHVwg+jIssleHM7vvQ==
X-Received: by 2002:a05:600c:19ce:b0:428:151b:e8e with SMTP id 5b1f17b1804b1-428e6af0a27mr130317025e9.10.1723042685111;
        Wed, 07 Aug 2024 07:58:05 -0700 (PDT)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42905971993sm33273055e9.16.2024.08.07.07.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:58:04 -0700 (PDT)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Google-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Subject: [PATCH 0/2] Add support for AD4113
Date: Wed, 07 Aug 2024 17:58:03 +0300
Message-Id: <20240807-ad4113-v1-0-2d338f702c7b@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHuLs2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyNT3cQUE0NDY92kxEQz47Q0S0sjE1MloOKCotS0zAqwQdGxtbUAJqs
 OOVgAAAA=
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: mitrutz_ceclan@gmail.com, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dumitru Ceclan <dumitru.ceclan@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723042683; l=1015;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=qVznd9P5OEpZiNYPaWiEPGPDivKEA64oSkps+3rnKOY=;
 b=uI2jy7uHn7y0qemFbnlETVO86UzOgm1aKTHFUfxiIozwS8C0FyOBq6nzWT1d9E+I1t/yNDasB
 PrH586mPdgyCAx2G9vrbNvstf1qpm/kJFJ6T61Q5TzuKV4v7Twh5/bN
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=

This patch series adds support for the AD4113 ADC within the existing
AD7173 driver.

The AD4113 is a low power, low noise, 16-bit, Σ-Δ analog-to-digital
converter (ADC) that integrates an analog front end (AFE) for four
fully differential or eight single-ended inputs.

The part is not released yet and the documentation is not public.
Register map is identical to AD4114. Particularities of this model are
no temperature sensor and 8 VINx inputs.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
Dumitru Ceclan (2):
      dt-bindings: adc: ad7173: add support for ad4113
      iio: adc: ad7173: add support for ad4113

 .../devicetree/bindings/iio/adc/adi,ad7173.yaml    |  3 +++
 drivers/iio/adc/ad7173.c                           | 22 +++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)
---
base-commit: 1c61e13d7dc9003662bd7fd6064dfea67e64b014
change-id: 20240725-ad4113-baa63ff99245

Best regards,
-- 
Dumitru Ceclan <dumitru.ceclan@analog.com>


