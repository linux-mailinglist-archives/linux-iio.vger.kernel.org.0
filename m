Return-Path: <linux-iio+bounces-26865-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA63CAB1CE
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 07:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C025305CF13
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 06:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A5D2E718B;
	Sun,  7 Dec 2025 06:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="5KOQMMbI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C26D195FE8;
	Sun,  7 Dec 2025 06:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765087282; cv=none; b=WbYhbgM94yuNaGt/TYP86s0kXDEjpZAxqo71pHaTkuTvm9/Ysv63CZb5QIKnVxAeoMB1rGDOxjb9FTl0rEVgxiqPZN+Jyys4r9ViGg9HCFjzEYnLPsFcwfDUHko9L5YCu/L19VLC7hx6o0lOryBt4cB8hE+4vhy3oBESIY1vwuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765087282; c=relaxed/simple;
	bh=02FDAX3dgsuypmNO+XsbWk2bLHgHcCY5XbKh9TxGIZA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aqPz44YP/zoG0+eCaIP1poQZnSPFZhaA7pGil/+iOTNXlvE8N0VizvNQ5hr/BOn5xy9YuhTirrAz9scSIXZLmMhmW1pUI8AZ/krPEW9yQEWTt5NmeJu270zHC1KhJKZCbN9MKzNrP8a5l18QmgGoA2K0DIsWxIu7q3fJfHY7RAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=5KOQMMbI; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3402:a400:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 34C97160209;
	Sun, 07 Dec 2025 08:01:09 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1765087270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1m5ozUA6ac7zLjJTDZFykJT1M3hmCiynyhEoeQPdW8A=;
	b=5KOQMMbIvfrl1oyZZ7Y/BGjqRHI8PV4wT32PEPmvKMkReJ54siYSvDIIaCkA0GfatXD/bQ
	VRrVOA1HLOcKMOle3523VIpopm571aQsu1p1CDRa9KEXklcNOw8SNsiRZKRdtABUD7TLCS
	wqF0Chk1tE5gzW7DsEnzmrE/jU1VQ70PyPx1QT1ICZynQS9HGgB0qL8JDghZ4mMnJH1Jb+
	nqcDmx3S0KgfOvEkUbhGAVQL+k+FUGAt+Cet3HHMTHOy7KXeYLJuYbr/aYSFzf7H4DRjs4
	+RkxJEElxGdhg977V76/7dA3nvpChFMQ6y6LHhzZ6dYvm7516tfpKDK1nctSyw==
From: Petre Rodan <petre.rodan@subdimension.ro>
Subject: [PATCH v4 0/2] iio: pressure: add Honeywell ABP2 driver
Date: Sun, 07 Dec 2025 08:00:46 +0200
Message-Id: <20251207-honeywell_abp2_driver-v4-0-b52a4b96bbf7@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA4YNWkC/4XO0QqCMBQG4FeJXbeYx81pV71HhEx3zIE52Wol4
 rs3vSkI6erwH/i/cybi0Rn05LibiMNgvLF9DHy/I3Wr+itSo2MmwEAkCQBtbY/jE7uuVNUApXY
 moKNFLYsMG1bzCkjsDg4b81rd8yXm1vi7deN6JiTL9p8YEsqoVDlCJpoiA3nyj0qbG/bLiwdny
 eIG+LbyLQsWi4lU8lxh3WxY6ccCxresNFpKpyBFFYfAX2ue5zctmzfFWAEAAA==
X-Change-ID: 20251122-honeywell_abp2_driver-9c796ef0c4b2
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Petre Rodan <petre.rodan@subdimension.ro>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2691;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=02FDAX3dgsuypmNO+XsbWk2bLHgHcCY5XbKh9TxGIZA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2sxR0Ivb2JQUFF1ZGVBZEpDTWVwc25Fb1l1CmZaVHp1VUxzRkZPTU45K0xz
 blRMTm9rQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcE5SZ2Z
 BQW9KRUhRcko2ZGpPa2xqbmVVUUFLZWFmSndoa09mTjV0ZloxcnVXcTB4UGNMbndtcVQ5MDRBcw
 pHNGx1SVFFRFZmeUpreTRkd1dvYzFDalRhb1AwQzNnSmM5ZkFtNHNmdEpIMmxmWDdBZmx1UmVra
 DFLYklqL1U4CkhUQitKTCtYRUFUWG5IUkthN3pGT3E1aVg3TWxTQTIrN25tbVRQV2cxSU9ROVZI
 UlIyYm5yOThUZWVyckxrMlIKblEyczZjN0QycEt6L0t1dlMrbW9WcE1JS0JOM2QrTzFIN0dxWHB
 Hek9aYlZ4R0NsQUhwbGVOTmlXM0NzOEQwOApieXE2MjR4UHFOaFJXQ01OSUxrNmJUNGZSUmtFeE
 IrQkdSSEZHc0NSNTBQWDhJeHNQZm0yeVdHR3Z3Z0JlQ1UwCmJONVNxemlSWnpFRTlxZkF1TkZCO
 Wp1S3Z1WVZVYUkyQTNhZGZXRjdEeVczbHNaSUkwR0VaUzZzUEdncENZcloKd3dzTjZSN3lLVDcv
 Vmh6azVYdU5oVlZiUHMyeWVoOTlvcWI1cWpRU0pxeEt4d3A3cUdxUlA2WTZTVWtDbmlpVAp2dmh
 KU0N6d2VzVWFYM3RPUmI2bHFwMnVLU1hTOFhoc2Y1UnZTM2ozRFVmM1dKV1FPNlFpTlBvNmNWOW
 dXWHU5CjRXUVEweEgra0VaTzRoelBzU1VDOWU5dERXeVk4d1NMTWRHZmpPakdJMmtLNVFtWkRBO
 WErTjByWHM1MWNqZmoKU2JzUHpaa1kwVDNpT0d0YUQzeWQvOG9Bc0E0UWdzVjExMlNyZExIRUlk
 Sm9zeUhvSjlSUU9aaXBWbWdzTVV5WgpseFZ2NWw2TU94QVVuZUhEaGhwUjJLakFOeHloOTV6RHJ
 VUHdhS1JTUm5DMnprSnYvVWh3L3AvYmpCYytaYXR5Cm5hNUp5TGU3M0hZaDh3PT0KPUlrclMKLS
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

Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/basic-abp2-series/documents/sps-siot-abp2-series-datasheet-32350268-en.pdf
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v2:
 - bindings are unchanged, added tag from Krzysztof
 - driver code changes based on Andy's feedback - detailed list in the respective patch
v2 -> v3:
 - driver code changes based on Andy's feedback - detailed list in the respective patch
v3 -> v4
 - driver code changes based on Jonathan's feedback - detailed list in the respective patch
 - Link to v3: https://lore.kernel.org/r/20251204-honeywell_abp2_driver-v3-0-ad3275bad35e@subdimension.ro

---
Petre Rodan (2):
      dt-bindings: iio: pressure: add honeywell,abp2030pa
      iio: pressure: add Honeywell ABP2 driver

 .../bindings/iio/pressure/honeywell,abp2030pa.yaml | 132 +++++
 MAINTAINERS                                        |   7 +
 drivers/iio/pressure/Kconfig                       |  29 ++
 drivers/iio/pressure/Makefile                      |   3 +
 drivers/iio/pressure/abp2030pa.c                   | 544 +++++++++++++++++++++
 drivers/iio/pressure/abp2030pa.h                   |  73 +++
 drivers/iio/pressure/abp2030pa_i2c.c               |  90 ++++
 drivers/iio/pressure/abp2030pa_spi.c               |  67 +++
 8 files changed, 945 insertions(+)
---
base-commit: f9e05791642810a0cf6237d39fafd6fec5e0b4bb
change-id: 20251122-honeywell_abp2_driver-9c796ef0c4b2

Best regards,
-- 
Petre Rodan <petre.rodan@subdimension.ro>


