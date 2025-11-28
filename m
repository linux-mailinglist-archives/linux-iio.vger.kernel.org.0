Return-Path: <linux-iio+bounces-26526-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A90C90B72
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 04:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4884A34D9CB
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 03:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1595C2C159C;
	Fri, 28 Nov 2025 03:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="28azM7Br"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D54B19CD03;
	Fri, 28 Nov 2025 03:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764299639; cv=none; b=n6lgj5jLI17ulo0UYUY7m8w8O5vGhoyYdTTDEgWQIPBW+JterWAPzkqXGJLrmGhCXYdrpum3gWnJCvnq41Np/8OpTvjISLXBs/LrhNPRZldSLjzw0nBFn9gL7BitBvmgMveEOa7l+690NrugNuF1/NRi08kz/qLWlIEdelUr9Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764299639; c=relaxed/simple;
	bh=JO1Jml6sERt+BxbjT5bn9PB+t1S/42x25xEthBKO35o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qPHqdAsgR9SwDPiZJtx8LiXov1DahLfF0FWCubbjWxXWLzYoSVyL+bp06VgZ0AaAxIFVuMTIKsTacfMSCnHHiOKbC3ioX7ILHlSInUj1523YxSCiDd86WPPmI8PSTgbojqik2mCXnsrD+jgTN/5X/m4rjDnZALD/r4PpRWajYIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=28azM7Br; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3402:a400:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 276E5160209;
	Fri, 28 Nov 2025 05:13:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1764299634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3RjT46CammQJjY/zqhU4/NR/yYAE7/9UQZlB+DHRDAQ=;
	b=28azM7BrONqADIpasMrCJ9JPturqHosFzl533EkPIgI6tRzBRMGM8DtLUoK/GXcMbf7jb7
	4eWOp42TZ9gx+DKFex8v7gM2dmSnmXHWqJZE9YBDsrWs3JVQhARBjECHEFVVdRfsy1orgq
	mU252KmfYMUzJq28SyPCN2CFyNi+Cy4355D2hMRFoaUJwapwz7/oMVBFlHcXCQwxsJDeDU
	7wSzoTRD9A/hGJ19lNB6zojOwYxxULy1AKeVtT3GnSVAPBuzzvFPH5Ubgpj7WsIDNK+N8N
	xp8adWYHoBpXNOqfn9OoPrvQnvysANnePxL7z3gOih53yWDxNTOmYmoHpfj62g==
From: Petre Rodan <petre.rodan@subdimension.ro>
Subject: [PATCH v2 0/2] iio: pressure: add Honeywell ABP2 driver
Date: Fri, 28 Nov 2025 05:13:25 +0200
Message-Id: <20251128-honeywell_abp2_driver-v2-0-7053748aecf7@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFUTKWkC/4WOXQ6CMBCEr0L22Rq6ERCfuIchhJ9FNsGWbLVKS
 O9u4QI+fpPMN7OBI2FycEs2EPLs2JoIeEqgn1rzIMVDZMAUM60R1WQNrR+a56btFmwGYU+iyr4
 ocxrT/tIhxO4iNPL38N7ryBO7l5X1mPF6T/8ZvVapKtorYZ6NZY5F5d7dwE8y+8WzWKhDCD8uS
 GxVwAAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3742;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=JO1Jml6sERt+BxbjT5bn9PB+t1S/42x25xEthBKO35o=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2twRTIzdkp4WXgyYkMvUHdjdHFCTzBKUElJCkFyeG9POS9KVlVkbkxncmQw
 V2RETjRrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcEtSTnR
 BQW9KRUhRcko2ZGpPa2xqUjhnUC8wbkJ3ZUJRd3V1WDJzc09mbEpMbGh5SkQvY3ltcE1IaXpjYg
 pMQXlGdEVSYjY4N2pJQnRsOGRtNGNjWmFETjJYYUlhL3pWMUE2bDZIdnBnTjVHSVFXYnFHd29MS
 k1zQkhxYXNnCnpNbXREUngyUUJpSzZ6cE5MNlNFLzl3b3hkVlAzV3pnNGxBMWNPUGR5SzdYeU4x
 VE9XRVJnYTF4T2pVOFJtNU0KV1ljRDNPZ0NwbTdYWnQvYjA4QkE1T216bGFkVkQzd2xEeU1xY25
 4eWFoSXo3aUIvZ2ZMYmloSE9RaTQ3eEh2Tgo3cDZxcnFRSmRaQklPUy8zRmE2Ry95SUEvaTA1WU
 tmcWM3K1NsNEtRYnNzRjlGc3ZxZTd0QTBGUm5pdUVyd1pCCjVidjl3VHhVY0pZaTM4dEF1S1JFQ
 UhzUklBQ0ZBM0Ntdmcybkc2cGR2NkpydXNHUVM5dmdSNnhzb2k2eU12cUYKckQ3U1kwdjBtN2Ru
 RlVwQXJPOXFvTXpGQmkwYlF6VHkzVHJWZmduVzR3ZVpoV2ExOUlnVTQzUEE4SnVsRmR6TApJS1V
 SeTNiS2xhVVJjclB1emZleGdGY0JoN1Y2N2xhV2x5WTBoVXdRd3NkYlFudUQ5QjhFdU91SnUyMW
 FEWkRFCnNFTWhsWnVhWmRtYU9QQUZtenJwMU9FaytZVUpmYy9IdGVQL01YRVF0WU10TGhKZzBPM
 klrZDhDeUhjYmRIY3EKZjVwZHBvd0tHVEVGMERUYTlFZE41dk93UWd6TytSMjJpRG5vMlpveWtX
 NVNaR0VYQURkSFB3aVNrQUVSNGNsdApmZ01ZcW1lTUNrODkvQk1RWWhLUVRDaGFxL0hCZ3c5QTh
 rUE00Z25DbGNTUWZqbVBHYXpUVjhURUVnd01GR25OCjFCbUxKM0lsNXVrZEtRPT0KPXBYWnoKLS
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

Tested on two different sensors.

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

---
Petre Rodan (2):
      dt-bindings: iio: pressure: add honeywell,abp2030pa
      iio: pressure: add Honeywell ABP2 driver

 .../bindings/iio/pressure/honeywell,abp2030pa.yaml | 133 +++++
 MAINTAINERS                                        |   7 +
 drivers/iio/pressure/Kconfig                       |  31 ++
 drivers/iio/pressure/Makefile                      |   3 +
 drivers/iio/pressure/abp2030pa.c                   | 538 +++++++++++++++++++++
 drivers/iio/pressure/abp2030pa.h                   |  77 +++
 drivers/iio/pressure/abp2030pa_i2c.c               |  87 ++++
 drivers/iio/pressure/abp2030pa_spi.c               |  67 +++
 8 files changed, 943 insertions(+)
---
base-commit: f9e05791642810a0cf6237d39fafd6fec5e0b4bb
change-id: 20251122-honeywell_abp2_driver-9c796ef0c4b2

Best regards,
-- 
Petre Rodan <petre.rodan@subdimension.ro>


