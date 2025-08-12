Return-Path: <linux-iio+bounces-22629-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B415B22E9F
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 19:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE9D3BE4C2
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 17:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A412FAC1E;
	Tue, 12 Aug 2025 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQkQyupD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069101A9FB7;
	Tue, 12 Aug 2025 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018593; cv=none; b=Q9kop5tqxaYcD+/CcNB/KNXj8tPmjQHsxvGd93KVhVmc/C348pBjMtZWWm+AQ9ENUqWWzBanILDH9C/HN9YXEujkIOm4myC7gcnwGr2EmbzwJAeIqZFKejkbD2J2e6PcXfg/hMNy+BdKu5XWKbMJaX/kft+JY9IkbsvvCs3CAOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018593; c=relaxed/simple;
	bh=GJqSwKXrv9kf1Eg8zsDXI1RQAGBzTE4/rWNbVTUC9A0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aXc7BtfmpCJhbsKrtFJ8ebZlHfQpqb+Saiw3KQPMyI2sgYfFOJP9KT5reLzAtv0LG/UavE9cJdCqaaNu+3Tlnb9c5yU4Qw622gaCuYNFhigcIk9nYbBnmYYa+A+QwT8H8AL+JJDNl9TIxXMvFXhijqCpn99Wpa7ddUvSW7kSEIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQkQyupD; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so10040440a12.2;
        Tue, 12 Aug 2025 10:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755018590; x=1755623390; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I2n9q+MzB6DY/bKUzRvh7nOvEqA1CZKBA0NS5WtsojM=;
        b=LQkQyupDaYNOx87ryH+DFII94Fy+rTLhZHVArHyAEQefVuJhKStX/8QlJTkvp4KTPk
         rF8gOpnTR0ZCS7ilibFKPjJeSGUVChYwbKxBgedd2ruk17dwamVhuhBvzDG1uF0YHBP8
         TMSVSREOiiGApkRZ93yprm+e+ivQGXUckOdeZ/VvCe7WJ30GrT7cSkPHMlq1ktI7Wx+v
         1o2hWjS8xjtxt+ZV3hsG3jQU2lvdtuDGEH681hrp0nuYLizY/OzSxtjHfXhJ/r2qS2vX
         CiMtuBwSTL2a/5A1xLGbdIBUvOyqC9QYvVuHzoNJ1q91mG1llNxkf+blfWUjtNa8am2x
         SLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755018590; x=1755623390;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I2n9q+MzB6DY/bKUzRvh7nOvEqA1CZKBA0NS5WtsojM=;
        b=wr+793ZDppRx99P6CInAvrHZZcDhqVaUUpU/4avXcoKL8SnyqFwP/Zj9pT5wRuc9Gk
         teXzOFHs52aqWIgAZMNI1qUNTGFVK9dGxSjmDox5sO4t4f1St8n2GluO2shFUzIWKw7H
         C3cKfTYTAS01lThecIpHIiQ1PRVfHlG+avfPPyp4b06dtFDrJz9BeNPzDJRx9rXe2V3D
         5utRzFiNdjpI++J4sGyILfF0uZ5u08et+aOgQX7kyqSIjmtJMyWTX1ajWHTntk3o2vfs
         uQzKR3vkyupdIwUvy4iqkZTz0mnZEGRDE1FnpxmPg7Kp4UvQrLPPeruCssCSKBcamkEx
         qvjg==
X-Forwarded-Encrypted: i=1; AJvYcCUiZPq3EFQrGzUFViwnglXVkDUyu8w1/mDGHg2SyswzCgt0JzQoe/dQLaNuqLwqWQUaE/volSCzZm5M@vger.kernel.org, AJvYcCVDJ+KZl5m8RtRDIwYDCnid9nvDmXapCUcwFYa/+hAQWL3cCxrLJ+WvuDM11NiEkonZ47IXPfmF2XkQ@vger.kernel.org, AJvYcCXN6PAgs5VLJkgtjKvapzV440Su19yj1WNtnEiy/TYfKaZcRvFNRZwvjMBf2RlZK1h31smiEchNDDjaijLd@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ8PEofV6ZJ7pYUuAWt9BDYnolENsRW0j0/DHXCdfQfoSKEjYq
	OFvfNXyveX0P1AdYdtepQ/H8gYVxbO4bT5Moh2/N68X2CzdTbp/AiX+h
X-Gm-Gg: ASbGncveiNkJmC8SjAVB1P+z6+sUNykV23DR+Vl4oIM505Nssmstk3dYFu65T3ApBI9
	nm92Yw5ebSMP1SdCnIA3QxP095c6Aljmx/9lAMSP3lvIMRTI1aAa5/nYYe3ToIIDsWCAzqlbv91
	TrQ0xg/uDHkuZXqPr4PSKS5kQ454KwkpuMJJbTfibuUVIQtHK8TTWkHYbfKI3UMOMQFOMhm2PTR
	7RWXilDYyK/mCGytRM2hERL9ILw7iteg2qHgF+V+YTLVMS5kJp0+LNHeL70UD4jXwSkjCp5Wao8
	8CDKfmTRgo8EMbMncQjg+tHJhsBtgoFTAqPD38RSNsDQNUJ6ndb0VPS//L/IMFUHlT9NVgvSLj4
	cMmg08B7jHNdhZv6lAjxfPaA+imO3
X-Google-Smtp-Source: AGHT+IGWi0gclXsMRyvIXhVx9dBSCoSZApIbrxrm8VuThflbMnovGdhJ2eD3qjZjNWNT/GrwCXDxFw==
X-Received: by 2002:a05:6402:2690:b0:617:d013:74a with SMTP id 4fb4d7f45d1cf-61866ffc84fmr507117a12.4.1755018590063;
        Tue, 12 Aug 2025 10:09:50 -0700 (PDT)
Received: from [127.0.1.1] ([185.177.137.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a911451csm20060302a12.60.2025.08.12.10.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:09:49 -0700 (PDT)
From: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Subject: [PATCH 0/3] Add LTC2495 support
Date: Tue, 12 Aug 2025 19:04:09 +0200
Message-Id: <20250812-ltc2495-v1-0-7bf4c6feec2e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAl0m2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0ND3ZySZCMTS1NdU3MjC0PzZEPjtBRjJaDqgqLUtMwKsEnRsbW1ADL
 khyNZAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755018589; l=1217;
 i=y.alperbilgin@gmail.com; s=20250811; h=from:subject:message-id;
 bh=GJqSwKXrv9kf1Eg8zsDXI1RQAGBzTE4/rWNbVTUC9A0=;
 b=0D/CA8UbcZLAi8agtjIDtnJihfA/nSRBZQNSmO/yx8XtMXo83TS8dh8W0VxkfVw+GGl23ynum
 EVLpU90atDXD+yiT9kmtiH/NkaiXxaiyVuT+LYWzelXMM9E2AuZ18yu
X-Developer-Key: i=y.alperbilgin@gmail.com; a=ed25519;
 pk=FtW2oyQ0+xlYU0XmhYiJYC3lNPtPrgeE6i4WXPwaFnY=

Hi Maintainers,

This patch series extends the existing LTC2497 driver to add support for
LTC2495 ADC.

In addition to supporting the LTC2495, this series also enables the
reading of the internal temperature sensor channel for both the newly
added LTC2495 and the already supported LTC2499.

Please consider these patches for inclusion.

Thanks and best regards,

Yusuf Alper Bilgin

Signed-off-by: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
---
Yusuf Alper Bilgin (3):
      dt-bindings: iio: adc: ltc2497: add docs for LTC2495
      iio: adc: ltc2497: add support for LTC2495
      iio: adc: ltc2497: add temperature sensor support

 .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml  |   3 +
 drivers/iio/adc/ltc2496.c                          |   1 +
 drivers/iio/adc/ltc2497-core.c                     | 100 +++++++++++++++++----
 drivers/iio/adc/ltc2497.c                          |  40 ++++++++-
 drivers/iio/adc/ltc2497.h                          |   9 +-
 5 files changed, 128 insertions(+), 25 deletions(-)
---
base-commit: acbbb5a20971089064ca6b271dd251e629be8d4d
change-id: 20250811-ltc2495-572817c13fd3

Best regards,
-- 
Yusuf Alper Bilgin <y.alperbilgin@gmail.com>


