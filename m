Return-Path: <linux-iio+bounces-27510-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D525CFDBD2
	for <lists+linux-iio@lfdr.de>; Wed, 07 Jan 2026 13:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D4F7305CA92
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jan 2026 12:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26813191A4;
	Wed,  7 Jan 2026 12:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CoMVBM6m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F113224B0E
	for <linux-iio@vger.kernel.org>; Wed,  7 Jan 2026 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767789325; cv=none; b=aoJAco95YM8bYrIMWMXc7t+iq5reAW2aIowbsM1jqncFSOJBeaF02B8Y+SwAsfhwjMtAWRnkcXVuch4Usn6PbEwLmAAp6n3hdL+CKvmFJtsiD5ihvZzW/g7bCC1Dmo4WY+WUlXx4YE+bxISv37zi6JLoBotHsIav0mHIGeqpAxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767789325; c=relaxed/simple;
	bh=d1+1tYxV6e1B9jnCyyNhU8+JGji3kwpYOsvt504LSP4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=a7mlyu8fSjaO0AgrqHjtvspbeGv+5xv0kOLaK4DbVb1ydTEoFfMadyEjkteOA4tpwPiWs4ia/x+PBxSnogkR+vd/1CBxIXnylpuynsCnr7tfA25+h1FcqfpHhT7KUg82iVXvfZS6csTQggvm/TMp7MiKQmuYTe49Btg552C0uhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CoMVBM6m; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64c893f3a94so1163853a12.0
        for <linux-iio@vger.kernel.org>; Wed, 07 Jan 2026 04:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767789320; x=1768394120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XDAj9bMISg0KaQRd/bCmcd+7rlIQfEqtq0o/sSpleFc=;
        b=CoMVBM6mPRu7KApgdoBxkzGVfX0MgbJ9PDiLzaBJxG9GYAvDsx1tcjhRicZbkiJy0I
         RkJWPdsplTAy3rR5eNW3XH88MsQGpMuNK1I5+QOQsSHmNs738caKfNqMIb3hxTOsox2n
         5UGvT+5UNsPl0YTitbY+6YQ+3g9psTitDPDqRxF2gWXSUZa6p1NytX+bAPSprGCxloiT
         DQyORexWrfgEmxxXVwc7DZG4FDcGGD1VbazOMGvR1xL+pHa8vcT8pdOmfhEjM0ii5HK2
         v79osVUUCL1IFZDq8nehQ4qtsa2OyFK3H2CEpJJjd3paiXCJsk6b/hdq64ZgvYlODjc0
         mgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767789320; x=1768394120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XDAj9bMISg0KaQRd/bCmcd+7rlIQfEqtq0o/sSpleFc=;
        b=jIgmKV5m5ngxplmqc84dAPikwYT279Rb0kmnhpjlNwvQV4v7SbIrQRFpr5q042/zzm
         q7ue6JxC5tbGxfYkKxlrHQ3E3oEn4Q3j1dNNk8JAE/MKBMDWOs1LFXPYCrvsoUlRofz0
         WNIlmh8sl6N8Y4RcvS1ais0Kl+Ez974/hv0rIDFYxQ7lew5qr/XVC8DZx+gWC/+5XHzv
         DsUNBSmC4oqwO9NKqJAhMUP1mPyIK0JAERclb4bs7dxvEGHVf38rpOLO8bT20E7AUsrN
         tzBFXK9YmUHHoHTKPti1Dz6yB26qcuiqBcHl9Kx8P6MFliRnEEfmWCWd+zdL6BdtMlhA
         ZHkA==
X-Forwarded-Encrypted: i=1; AJvYcCUXVrlpCl/7pcz48UqBJaDi9CCdtXo2BBGAf5+IRbfhzsUMSAgOtYbkkQWGb3/TTDGv2yuMsvPQ2nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YweBIsiQDWJSxD5Jn3VM0S+9ST55D1VeeukiP//nPpz8QynsrDO
	fmzjWD6955z/s3kpU97+HoMVciaKscjgY5ULGnt2izd9/U/y3NMGv9htfwdNVyg5Ifg=
X-Gm-Gg: AY/fxX6zjgFPpUQiTipub4ywkcCBY9llm62utqaDwMjVvJqD3wmla19X0d9NpiOBiXF
	Oj4Qdb+484CVblubU8bnjKZGz5RKui3jinCrDe8nLEkJThErXma1g+/a4ESlOx9mIuoW0weVC02
	t6mgeJe0rLr8+yQRS9WVAODFmm41AMwaRhEnLn3DNwx7y/yF3G5uprdiRT9ba1GKtzjYMiDnssL
	7jq9bQoi3CA5zUw27H1EO4NASxGFFd97EnQlZ5+vbuZXdTSw18bKMY7Xcs3Q7bhkZfRUAEcj1/M
	uwENBN8Cik3EZwlk7+Q9MkVROJGuHBUlqwVfSU+wpjUuG66h+SmOVAMAbizuBxZjPTIJqdD8ehG
	ddQm3uYKsefBmp8iLRoiwTN0Hq49LPa6H9/M7zu4B9fMfkLfgXXtsIvZuLN4JLZY4gaJqi56YRD
	yqaOKj/1Dr5YVVhdzJLKNi1ize0I4qRAg8dM6iMD4=
X-Google-Smtp-Source: AGHT+IHzDPLuH3LQKjvFpm2xEyUfl2fEbZbpEsqsnh4eZO2kOW4JC3AzCckjd/s6CNsvSVhhtchbdg==
X-Received: by 2002:a17:907:2595:b0:b80:3205:5af3 with SMTP id a640c23a62f3a-b84299bd25cmr435564866b.15.1767789320278;
        Wed, 07 Jan 2026 04:35:20 -0800 (PST)
Received: from localhost (mob-176-245-211-45.net.vodafone.it. [176.245.211.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a22fa1dsm510894566b.8.2026.01.07.04.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:35:20 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] accel: adxl380: Add support for 1 kHz sampling frequency
Date: Wed,  7 Jan 2026 13:35:16 +0100
Message-Id: <20260107123518.4017292-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=665; i=flavra@baylibre.com; h=from:subject; bh=d1+1tYxV6e1B9jnCyyNhU8+JGji3kwpYOsvt504LSP4=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpXlL8Y6o3O+Q/dxserSI8SfF3/hgTsDNVuk0tP 6rv/yKO/KWJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaV5S/AAKCRDt8TtzzpQ2 X8L/C/9dexOuFZlSCW0RSHCBXXMvO144kPRIG37Jbe0nyUt37cuAtRQvzwqnxUx8xLZPM1NC/jp gQO+tX3fjkXIKrolG/6ceccJYfgYsUCXqdNJAKDwRXIwP7C/Te38/U8WuZPOsBy2Yk1PVnPekpg Xjwof+cJBaQ6MJ1VPtMh+bpqyuND1m6q87xliOVxq6P9VlcWMNA/HDSo8s1Nf2+KCjsJ+05H4uf qksNNxIKZfYDkiKh08S7xuAB72ik8SXa9w3yWy0S3vI5mL33fbVL3XphC+GNimYr6wjUvfw2BDI CGflNO5Am/dNYLnChDIC9tTXxWSvwVseemyrQYi0JbbDwQS4iJsCwfDlrR3vr4zpN/i8/cD+7If qvN8K3V/ZfMUhEEU4PrChnQhwr5+jpiesGxlv7uH1o1enUGR/oWnT1I79U/+Y3gc0HYWfXHlC5K nQT4ANF/BV/+7utoMnuRKVesN7XCCqpNXya1kyA4PB4bX4Y/jU/KLGVdyPskPwA+rTIbs=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

This series adds support for 1kHz sampling frequency for sensor variants
that implement low-power mode.
The first patch is a preparatory step to decouple sampling frequency values
from decimation filter settings, and the second patch adds support for the
new sampling frequency value.
Tested on ADXL382.

Francesco Lavra (2):
  iio: accel: adxl380: Store sampling frequency index in odr struct
    member
  iio: accel: adxl380: Add support for 1 kHz sampling frequency

 drivers/iio/accel/adxl380.c | 62 ++++++++++++++++++++-----------------
 drivers/iio/accel/adxl380.h | 10 +++++-
 2 files changed, 42 insertions(+), 30 deletions(-)

-- 
2.39.5


