Return-Path: <linux-iio+bounces-26741-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A71CA43E4
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 16:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0375C316D3E8
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 15:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE092E92AB;
	Thu,  4 Dec 2025 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="IBOIDSh3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7902E719C;
	Thu,  4 Dec 2025 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764861208; cv=none; b=exSWD8guYfyoIESAl6CFTlZJXvBgnpvAJcIn6GuBU+tYbjQOYZ61NeioAys/sKnaGfeVjdu3Y7vl346NnynTI+s64CJPFGxy/1o5cPyl5qIPHJFdMP08cBFbdNYfsheOmLlwQcDIG/t95ByxTR64ViZE3ZDCMqBu7P5CJ7qAQN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764861208; c=relaxed/simple;
	bh=kagxY9TEiM5nKEOl0g/Nni+UxnySNbGFQvCbQDgmwtk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sORXiR0XthJD2g7lBZPw+2Bf89zzsN77kefDQK2bZpM2kyTPgIOHeiccUzSrWkMbJVHnYQH2NTPs1EEy8V5hTJPc8Z8VSmATuY+Ve/fvaLz3vF2PECrvugO0RqcSO8Z+sBRzpud4wHoOH/tDOaT1M1pGXpIgL5QdkWhrcl7aKWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=IBOIDSh3; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3402:a400:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id D37AA160209;
	Thu, 04 Dec 2025 17:13:16 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1764861197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0N0KAuf8bD9YhxdHUI82iqs30p4K45fOgYyTYarxIQQ=;
	b=IBOIDSh3UONZC4ZpLC4s5oI5+lvPRFmJgbdJ2S747AwafE7z8NqMVxkdveB2FYX3osXXgZ
	41ngMQaSMvKmSGdogAZYuScOEKfj1HZRDNx9T7MEhMtVsLFCHRpWwvrWDkwr73ly0uExCH
	UZ/AwjYoMg2kVgSemjXPf4sy0RNuJv2XMHPZuIrw1KZmbT2uK0GSoR8mCu8H1+tpBzPNEP
	s1mphGMUS0lD7F1cec2+npApIs8N3w9Ai8YLAmnlSc7cEKi/LxSyRHZhsPYxzAaiCXehUg
	w+y0zEvs2SgPg2luygWIMQvnyE0X1m4PYaxOKow3pzdYuPa0B/CqepehxXLFlQ==
From: Petre Rodan <petre.rodan@subdimension.ro>
Subject: [PATCH v3 0/2] iio: pressure: add Honeywell ABP2 driver
Date: Thu, 04 Dec 2025 17:12:54 +0200
Message-Id: <20251204-honeywell_abp2_driver-v3-0-ad3275bad35e@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPakMWkC/4XOSw7CIBCA4asY1mJg+qB15T2MaVo6WJIKDSjaN
 L270JULjct/kvlmFuLRafTkuFuIw6C9tiZGtt8RObTmilT3sQkwKDgHoIM1OD9xHJu2m6DpnQ7
 oaC1FXaJiMu+AxN3JodKvzT1fYg/a362btzOBp+k/MXDKqGgrhLJQdQni5B9dr29o0osHZ0lyA
 3xa1S8LksWKTORVi1J9sdZ1fQOEnnb9DAEAAA==
X-Change-ID: 20251122-honeywell_abp2_driver-9c796ef0c4b2
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3978;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=kagxY9TEiM5nKEOl0g/Nni+UxnySNbGFQvCbQDgmwtk=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2t4cFFYWUcvbllLVmp4d29MSjBHdTd1TFdPCk9BTzRaUis4YzRqdDE4OW00
 TTAzWklrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcE1hVUZ
 BQW9KRUhRcko2ZGpPa2xqQkh3UC9pK0s2emR1NytaTm8rdUpUYlV1TmFIZ2hZN1hWck1nb3NCTA
 pOcjYyeEZiaEd5eXBzL24wYStOK0Vyak0yM05oTG80S0FtRnF0MkoyYXo2NDZLYVBabEJiUnZqZ
 2JRTFVMb1ZZCmNoU2pKT3hvZ3lRUUQ5KzZhbm8wZmR4TUU3SDBiOSsyRlZ1Nnc2aHdBZUxSRXlG
 clhhMG4vY1dsRTNEVW1TZisKSWRsMDRNVUxzM3hvQWxOb1lUNk5pTUhodGhoT1pLeE5WblRUa0N
 lajdnSnRJY1RjSW9uL1pxWkMzdXh5Q0h0OApVSnhYbytKSVdFRG16d2VNemJqMnRYNnVxMVRkUW
 RvWk5MV0pJRjE3YnhicmpsOVRTTzJOazloVTlQbGkrazZICm04eVFtQy81cTdLMlZTUENVN0FOb
 UlDMmZ6UXpxdUE5WnhvRWNQZk1PVUpkUzV5aFhMMmszT2t6bFlZNGFwOHUKbng0VFR0NC93eW9O
 R29DckpidTI0RU5EK1h3ekNzb0s4d1l1Ym4zRy9SL0N6WHRQdzhycW55S3hmcWJPZDJZUwpZZjZ
 wQVc5VndwU28wZGlrcHR4bTVQd1Y4NXYzem9leDdlUVlQM1B5Ti9idXROR3lhZXN2WmNKaFRpcE
 9ZbnZOClV0RFlhRVUxcG5KTVNTVnVOTm1OdTdlWFpRMDZhRHVxRTZ0dlFMNUxhdHpJQlhwOWZWR
 kY5WWViQXRaZmZ2TmUKUm82K21oZzBCU25KRjdweGRaR2ZPWnBVQVhiTlpBU2wzQ2xVaE1zcU5u
 Z3J5K01QTmhkOGNTOWs1YWN4UkxrNwpibHNPUm1pbVNtZUZKeWJLU3RxZmNGcjB5Y3hYckh5cUp
 MaVZxYkZMdlp1dTh0RktmWFdieTV5L0dNUEo2Y1JYCi8zMGplRnlXbGowcHFBPT0KPVRxNXQKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Adds driver for digital Honeywell ABP2 series of board mount
pressure and temperature sensors.

This driver differs quite a bit from the Honeywell ABP series that
is already present in the kernel:

- many more pressure-triplet variations of pressure ranges and
units
- extra end of conversion interrupt feature
- implements both i2c and SPI interfaces
- uses a bidirectional data retrieving protocol (4 wire SPI instead of 3 wire)
- 24+24bit resolution vs 14+11bit on the ABP

Specific low level i2c and spi data transfer API is used instead
of regmap because the protocol is based on simple commands instead
of on a memory map.

Given the fact that the sensor can perform gage and differential
pressure measurements with a full-scale range of down to 500 pascals
the offset and scale are calculated in such a way to provide a result
in pascals, not kilopascals. Just like the Honeywell MPR driver.
For a kilopascal output the scale representation would lose too much
precision.

Tested on two sensors (ABP2MRRT001PDSA3 and ABP2DANT001BA2A3)

@Jonathan:

v2 moved the SPI tx buffer into the abp2_data struct and that opened a
debate on which buffer needs alignment and which doesn't.
my system is happy either way since it uses PIO mode all the time
even if DMA is implemented.
I've been told in the past [1] that the tx_buf needs to be DMA safe thus needs
to be IIO_DMA_MINALIGNed. also rx_buf has the same requirement.

[1] https://lore.kernel.org/linux-iio/20231220151305.00b4d1f0@jic23-huawei/

following this logic I have used the following code that covers all
requirements (I checked the two buffer's and the timestamp addresses):

--- 8< -----------------

struct abp2_data {
    struct device *dev;
[..]
    struct {
        u32 chan[2];
        aligned_s64 timestamp;
    } scan;
    u8 tx_buf[ABP2_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
    u8 rx_buf[ABP2_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
};
--- >8 -----------------

I am not sure why in many other drivers only one of the buffers is __aligned
and the second one is left dangling at a random alignment dictated by the sizeof
elements that precede it plus padding inside the struct.
how can that random aligned buffer be considered DMA safe?
and we are talking about a sizeable 64_byte_ alignment (for my armv7l arch).
it's very unlikely for a struct element to accidentally end up on a 64_byte_
alignment.

Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/basic-abp2-series/documents/sps-siot-abp2-series-datasheet-32350268-en.pdf
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v2:
 - bindings are unchanged, added tag from Krzysztof
 - driver code changes based on Andy's feedback - detailed list in the respective patch
v2 -> v3:
 - driver code changes based on Andy's feedback - detailed list in the respective patch
 - Link to v2: https://lore.kernel.org/r/20251128-honeywell_abp2_driver-v2-0-7053748aecf7@subdimension.ro

---
Petre Rodan (2):
      dt-bindings: iio: pressure: add honeywell,abp2030pa
      iio: pressure: add Honeywell ABP2 driver

 .../bindings/iio/pressure/honeywell,abp2030pa.yaml | 133 +++++
 MAINTAINERS                                        |   7 +
 drivers/iio/pressure/Kconfig                       |  29 ++
 drivers/iio/pressure/Makefile                      |   3 +
 drivers/iio/pressure/abp2030pa.c                   | 539 +++++++++++++++++++++
 drivers/iio/pressure/abp2030pa.h                   |  75 +++
 drivers/iio/pressure/abp2030pa_i2c.c               |  87 ++++
 drivers/iio/pressure/abp2030pa_spi.c               |  67 +++
 8 files changed, 940 insertions(+)
---
base-commit: f9e05791642810a0cf6237d39fafd6fec5e0b4bb
change-id: 20251122-honeywell_abp2_driver-9c796ef0c4b2

Best regards,
-- 
Petre Rodan <petre.rodan@subdimension.ro>


