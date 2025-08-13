Return-Path: <linux-iio+bounces-22682-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96071B25048
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 18:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5059F1B64CA9
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 16:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B541628B40A;
	Wed, 13 Aug 2025 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/mb19eX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32741F582E;
	Wed, 13 Aug 2025 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104088; cv=none; b=VLN6QGAXAffuKqHYlpxdHjuCGsze6GgoqM9y02AOvN8cAQatB0UAythP6Q2pQcYiq1+w2JRPaEPOQurYztTBWe+AZVLlW42Vck7ed7pRueoSKuBczWZf1wC1hW1rUy4iaEuzWyHBAq8T+gVaMUGkj1ByYhTK0XsdxDkya3iTPX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104088; c=relaxed/simple;
	bh=CjEl2QsOtgcKm5deJgBfzbyNiNjIjbZLQb4ZiRU0cHU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=to08ngymCW4t4ZPihjv0yepDnnNjYNhZjVOlc3lwp8Y232PLg/Q90sT8kprEyiOgRUvM9uB/a6QHZ8xCdkPKNrPCKn/6rRhxnhn383D73Gokk2WTgXNpOOFtmCVxSTt8SSsO12WfOrXTVJlY1uhM2JC+acZ2xveEioQRtElCpWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/mb19eX; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb78d5dcbso8031566b.1;
        Wed, 13 Aug 2025 09:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755104085; x=1755708885; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WZWASdh737DJgyNzuiOsyXjLGVNm8Zt08U9XfV9q9lQ=;
        b=e/mb19eX3UzyYDja5xMeOwcEQ18FQbTPiaWKXI71ppVmRVbGEx2cUUFpY57Xd8cwwq
         SI2Vo80bbalQAlrXWcV66upzt+4Ky826SW+gnE+Q7Yw3MOo27b3F1ZWjl9xm7DZp09Au
         50C6L9sxZTDyuXHt4lR3QSPQIA90C9PIYfKKFdxdHraUmIjotlC1Aqnx/5CfzdG1sywM
         yspw3i1VJiHydu4x3H4JBiGS+jH224A/7a/RG8craRg4kF8VFu3OXF8O5AZ1WKXzMdyj
         sauGq2DZYUF/J0KjI0NtmzqApuJNP4zfTcnguClLCiHP+m0LGTyyXZzGAWpjXM7x1qjl
         D57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755104085; x=1755708885;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WZWASdh737DJgyNzuiOsyXjLGVNm8Zt08U9XfV9q9lQ=;
        b=KjTZDtz+LfXTNXiPYyZvOmDWpjF+P+kQr71z+kCfyB6A2GBlEi22Z441XNYhZMg7kv
         H9ywaDMNc7NCPA/JADcjnYGRjMISgslsodt6ZmxH7KhuiNdqNnZhpoWhk8IuhhWn64k0
         0U6y1aWuAgieHEV0lR3ZIDilJCEw3n5clOYn5XoBbtO3fwr4GM4TN8n+sqmitUhqkkPE
         jFxrlKI+BKYI2L66ONBlG2v8R1Q8cqzCWEVGr2FOB3+FBQ5d+bra3P9GEdsa8PINJC1D
         TCODxxaohDDEzjQnmBQE7vEzOste/oy5qpxFo0odrKT7KQ2Vk4ZTtZQbakvcaWH2B6h1
         XFzw==
X-Forwarded-Encrypted: i=1; AJvYcCUz0Swck4GPmWpT3eQ9gbeSG3CbL45Y3dIV3cCasWy7FJPhPHYHWzZU4LxHieCzdBVdGkvi1kay+cKT@vger.kernel.org, AJvYcCXKP5qfvPP9BiZkS5A/OTrq2Pdbe6Y/2FRPZbQ1Ic+UaCdjYka2Jp/9rMB3Ea7hFGmkNPE9xy2Am12D@vger.kernel.org, AJvYcCXmuUsiKAroyQ7Pld4FtP/NLTwi7b2BIPNbYCMBrR3V2HKVGBHiWIxO2KQN4NH3rfKDkQ3GQqQp3JSi2XdH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz38okn3JCsOh+fwq7ur1+xOKjy5i1Y5Uxn4VfFUxoUZ+W7vYun
	lmLoJGpVz/BF9rsFR2CQR9mCOrndOBtbfZnCQhiay0zGt50vvTEL1Hy6yWmcXqkn
X-Gm-Gg: ASbGncsXTYY3G/noK2ptqaoCRlts8LVWBUj7Gt3NQm4mfYzBbRVfs6X1ouaHfaNsZyp
	hlfGhKDykjLGjx1D6TwgWkqGzwyk3OftjPRE/XmCvBIQJtn5uQrmhoIFi8BBfnSn6Tl+tyl69Kk
	eqRozz/wnutRHPM7MwUoUhBirs+L8R3D3aqePgIHYzoSJGEqHlrvMdFIcG2eh9P028f7K7TyjYu
	bIf/6uDlRs91VK7sEfX+nli+oDN0ceQBSVSKIVLwswjt13z3OmYYQ4lNx9nJJapIxAoMWgSlvJo
	EyAFJURt8Pqo08Ck/axQfWShAEKA7AkQJ5IBwfc/oAdtXRmYsrMZGEfDBf6P+AkLp7naQEsUqzH
	h4YkMEVNZOUO7/fz6IosplHhD9TSv
X-Google-Smtp-Source: AGHT+IFknwTp1n2V4Iwq0X2J462ptJw5Vvp398mJ1jBaVaPYCg21cAgS6vbTfWYirw0dW2sE3oYAjw==
X-Received: by 2002:a17:906:fd85:b0:ad8:ae51:d16 with SMTP id a640c23a62f3a-afca4e7c2b9mr403828466b.55.1755104084869;
        Wed, 13 Aug 2025 09:54:44 -0700 (PDT)
Received: from [127.0.1.1] ([185.177.137.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e82a5sm2428573766b.82.2025.08.13.09.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:54:44 -0700 (PDT)
From: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Subject: [PATCH v2 0/4] Add LTC2495 support
Date: Wed, 13 Aug 2025 18:54:28 +0200
Message-Id: <20250813-ltc2495-v2-0-bbaf20f6ba07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEXDnGgC/z3MQQ6CMBCF4auQWVvTDtSiK+9hWGCZwiRASUuIh
 vTuVhJd/i8v3w6RAlOEW7FDoI0j+zkHngqwQzv3JLjLDShRy1opMa4Wq6sW2mCtjFWl60rI7yW
 Q49chPZrcA8fVh/cBb+q7/gz8G5sSUpinq+zFEVmkez+1PJ6tn6BJKX0ASc82RJ4AAAA=
X-Change-ID: 20250811-ltc2495-572817c13fd3
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755104084; l=2552;
 i=y.alperbilgin@gmail.com; s=20250811; h=from:subject:message-id;
 bh=CjEl2QsOtgcKm5deJgBfzbyNiNjIjbZLQb4ZiRU0cHU=;
 b=tAOgmBqLj2BTjFiw6I63dfgpeawDufjx3rsfNVWxFc9Qak8+JuWEU8nUyOO4ddUuv+GQwepwe
 9SklQG7L4C9Dl0IrdLaIdJFZVwa/k132iuxHgBgQOf9K3xMvw+g5k7O
X-Developer-Key: i=y.alperbilgin@gmail.com; a=ed25519;
 pk=FtW2oyQ0+xlYU0XmhYiJYC3lNPtPrgeE6i4WXPwaFnY=

Hi All,

This is the v2 of the patch series to add support for the LTC2495 ADC to
the ltc2497 driver and to enable the internal temperature channel for
the LTC2495 and LTC2499.

Many thanks to Andy Shevchenko and Krzysztof Kozlowski for their
detailed and helpful reviews on v1. I believe I've addressed all
feedbacks in this version.

Best Regards,

Alper

Signed-off-by: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
---
Changes in v2:
  - Rewrote all commit messages to use the imperative mood.
  - Added a justification for the new compatible string to the device
    tree binding commit message.
  - Removed all unrelated whitespace and formatting changes.
  - Removed redundant explicit `false` initializers from structs.
  - Replaced the magic number for Kelvin conversion with a define.
  - Improved comments for defines and temperature scaling constants.
  - Renamed confusing macros and struct fields to be more descriptive.
  - Replaced dynamic channel allocation with a static array approach
    using a shared macro to improve readability.
  - Optimized data structure layouts based on pahole output to remove
    memory holes.
  - Link to v1: https://lore.kernel.org/r/20250812-ltc2495-v1-0-7bf4c6feec2e@gmail.com
---
Implementation Notes
 - checkpatch warning: The new static array approach uses a shared macro
   for the common channels (`LTC2497_CHANNELS`), which triggers a
   checkpatch.pl warning: "Macros with complex values should be enclosed
   in parentheses". However, this will cause a compilitaion error, as an
   initializer list cannot be parenthesized.
 - uV to mV conversion: I could not find a standard macro, so a manual
   division is used for now. This could be a point of future
   improvement.

---
Yusuf Alper Bilgin (4):
      dt-bindings: iio: adc: ltc2497: add lltc,ltc2495 bindings
      iio: adc: ltc2497: add support for LTC2495
      iio: adc: ltc2497: add temperature sensor support
      iio: adc: ltc2497: reorder ltc2497core_driverdata members to remove hole

 .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml  |   3 +
 drivers/iio/adc/ltc2497-core.c                     | 140 +++++++++++++++------
 drivers/iio/adc/ltc2497.c                          |  35 +++++-
 drivers/iio/adc/ltc2497.h                          |  23 +++-
 4 files changed, 158 insertions(+), 43 deletions(-)
---
base-commit: acbbb5a20971089064ca6b271dd251e629be8d4d
change-id: 20250811-ltc2495-572817c13fd3

Best regards,
-- 
Yusuf Alper Bilgin <y.alperbilgin@gmail.com>


