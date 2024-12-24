Return-Path: <linux-iio+bounces-13781-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D159FBF2E
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 15:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF0A1884E22
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 14:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5C21BFE06;
	Tue, 24 Dec 2024 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="c9KR7MqE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D807192B69;
	Tue, 24 Dec 2024 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735050637; cv=none; b=VWarIBSlOQpeGm3uNxQv5dFimtP/obTHhAhvyuI1ycWIaTioUmRxQ3iqOD3ySd3ZSrgMGoGbJ3xl/c3uFNJFY425e8ILvQjOgiCJ860zzCymQnGKj0D47YihUL99tNSuoFIZBYHSeEZ2dBHVscKZQAa2fsGiCPb97QXCz6C8eG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735050637; c=relaxed/simple;
	bh=ub1W9Wh5m/5Zd6B8W1zyIhC7IdR2Qxwde4xI0jO3XCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f6/NVDaFvjzPhugthgCKHgbOCgsM1bcfCym3AOkm05+OVl0MuPvLG0zXsSBWi8QSAODm1GGDhFt5NPH0OABarjg3DdxgoOTtkHShrkMhyrbKWPhLMO1N3Q7gn9T5B+AgoN6eRXtJlsaB/f3L1hQ/N7MncW3TieWwSmJ8kEw/obU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=c9KR7MqE; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aab925654d9so939879366b.2;
        Tue, 24 Dec 2024 06:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1735050634; x=1735655434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fJqXDK7LRZXJlrA7vQMLZbR9wNv56Gv8NF82RjcZv4Y=;
        b=c9KR7MqE5vTnp74p7MYdfW87kneJ5bCGuc7i4yHzLaDJqiaD+CJkLdV8WQsC1JXeJJ
         bSv6YknWQNVZZYI2EkbwL66feJ4qKyL7d0+0q0/8vaeApZFZZryTAek5uV1dcHitiBz9
         TqhfGc+Ks0NPvYh4n9TRmclCSbHhuKHucBu6e60O1hi5OnV2XbY+TkiDt6WK+RZ00ol8
         uWJuZDyoYJG7myA0LHriiEPuYlOyKCTWxoLDcCUeJDMipqxF3/cp66cDCJ3kWm+iIjok
         Z6IAgxb2FFJANdxsfDegrXoscuo+ZW7ESZYxrfnUkJZuvVz44RELk7TLeGzNmEySuW8V
         o3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735050634; x=1735655434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJqXDK7LRZXJlrA7vQMLZbR9wNv56Gv8NF82RjcZv4Y=;
        b=bEnLtolp3R6Jy/x7pqWatVl4qM7yW/DEeYvhKgXM9V4Z+h460eS49JnpnUnb/lJ+Zt
         VWOzsXErDdiTgYvWamNEYo+bg6fUC37qTWmMzOsiRALgwfNvUYzZoQGf9sXC86ZU90Uw
         zK112i9/qpWZVklD0A4wxWpBRLQKQQU1hGgp9nupHgH2C4bA99zpz7yYWPxLGsx9DwX4
         R99oWEUYddIoIHb1+4dTvEhxcRl5fKC45x03FUax/BoI02/Fdpw/oTaDLBjW4Y7OofiQ
         um13sulp/FcgwJWRuu3jhDvyn2S5+dGnJVJa7Bkya0VQnSUxUfRBKn/LZDfVoQXB/VYb
         Wmqg==
X-Forwarded-Encrypted: i=1; AJvYcCVdr/5ructGagvhwYP5VTqc7gDQ8PNIVoHTY0YCEobevCAMJQQWbo6dnPsBXPDWEG0uyIOhEAyiwlZ7GVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz28QGrukXOmgom1MZwVsq9C5oKpPFGHww0idxEtAQMVnlaunz4
	SGtTdRjcd/13vLUDP6qhLUhBY0CLvXo0c46U/SICH2eoJLwK9yOrU7BCng==
X-Gm-Gg: ASbGnctBTSYlh1q8GBD4ObuM5VM3+s1YHjIrfM0FaDobhG/S4CSUVarfX6sl2ljW4Bn
	WBut0u0ebB5VHkyLyHX+ea8WzrTAjxnuxCeRt99GJNlnxOeGX03ls5uQV99IeoHUJ4qvbrB928N
	YvMANiWp0Z4lt3LjjvzB/n6tNCHeqimf5l4+RDoyCSIVCvPhrd6ZkVaWeXpMOX7OpcDPAbqnFAL
	vtY0c45QeGhTdN7++cWG7it3g6HZsuXdsBrIn2H/umQUoqgKXdVDu47Ar8SO1eeKZUJb9IV5MKc
	zoPFaqU3PVwVmXkaDHAg4XyGYrudxCFD77m+L/VMRsBBEvTSy0f7+Jx5r5WqzR152+NvMTgHw8F
	dGnmtr5U=
X-Google-Smtp-Source: AGHT+IFNUBSWIPUOtbRSHMETUJeoCqYnm9NCyL9rlebTFDHnHcgX7dU4xV3LQ/s9gviB2dcq3z30jQ==
X-Received: by 2002:a17:907:6091:b0:aab:ee4a:6788 with SMTP id a640c23a62f3a-aac34218829mr1934689166b.57.1735050633572;
        Tue, 24 Dec 2024 06:30:33 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-a5d7-4700-0000-0000-0000-0e63.310.pool.telefonica.de. [2a02:3100:a5d7:4700::e63])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0eae74e4sm658827166b.91.2024.12.24.06.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 06:30:32 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-iio@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	gnstark@salutedevices.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	neil.armstrong@linaro.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/3] iio: adc: meson: a few improvements
Date: Tue, 24 Dec 2024 15:29:38 +0100
Message-ID: <20241224142941.97759-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains three improvements to the meson SAR ADC driver.
None of them are meant to change the existing behavior. The goal is
to make the driver code easier to read and understand.

Changes since v1 at [0]:
- drop the patch 2 "iio: adc: meson: consistently use bool/enum in
  struct meson_sar_adc_param" for now as the purpose of the fields is
  unfortunately still not clarified
- add space to tab conversion from former patch 2 as a separate patch
- Cc linux-iio (which was forgotton in v1)


[0] https://lore.kernel.org/linux-arm-kernel/20240324140429.5484eb54@jic23-huawei/T/#m81d92c2192de1936646543543501d8a62527da8d


Martin Blumenstingl (3):
  iio: adc: meson: fix voltage reference selection field name typo
  iio: adc: meson: use tabs instead of spaces for some REG11 bit fields
  iio: adc: meson: simplify MESON_SAR_ADC_REG11 register access

 drivers/iio/adc/meson_saradc.c | 47 ++++++++++++----------------------
 1 file changed, 17 insertions(+), 30 deletions(-)

-- 
2.47.1


