Return-Path: <linux-iio+bounces-26391-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E32C7D833
	for <lists+linux-iio@lfdr.de>; Sat, 22 Nov 2025 22:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 183174E1AA7
	for <lists+linux-iio@lfdr.de>; Sat, 22 Nov 2025 21:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20145298CA3;
	Sat, 22 Nov 2025 21:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="qzdXPGRj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132C0275114;
	Sat, 22 Nov 2025 21:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763848304; cv=none; b=gfPJyoCvQRXCU24q4Ij1eVy9NZnavOJyQ2Tzu2Bi0hSo3tWJQpDodsCmMfDN5EHVOybjGEjbtOOaW0N2ALi3MlFSne0ttBD2uhfNu+f9l0vFpeu6viyydgoti+xCItvdTuAuR6QLvjeMvEiMmjsKC6zoqW5TGw0+RpbbsypBuh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763848304; c=relaxed/simple;
	bh=thLXfCrTDyhEm2pTU5U01Uq0iCrYisCNN0k4tZMKQ5w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MUI6/Zy8TC3lsbwb0v3/j7yFcipVD042mRixMnhXzSQHY16Rgi+uecvQxb628NVJzsgxfw7NJd0qYlpkTDFIL4+Pb5iozFzx7XUZirJIh0ghWKrtUjjr/ZGH6wXhBhEkg70zu84KuZo3fbmhcAYewTQT364i7Z7fc6HjTP0nji8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=qzdXPGRj; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id A7E75160209;
	Sat, 22 Nov 2025 23:42:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1763847776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dxa9nZvojCKSjTT1DMnUxxV0VIypptAUoO2NwAJzQyg=;
	b=qzdXPGRj3UADRBTbF+yU/3LBKdZKZ0qlzAZdCgtwOQcGlF4m0dWl3wziC+KlFLuRumJ/Km
	NSD36B06QQaxz80e8i1L3oDqzeybUctCq6oLW9ik7mlWAXruViS8uaDdIY+KDdnFrmoGcI
	22ZgFhuGwJ2/aPaIFhPIwW8KxuWyk38uZ+noQaZb1q43/NvjRxbW0PIhYGRgjqB8QnELDu
	91v/HFOOxzAzDlHeAXzF/JRMpN05tWwrUVyRhbiHPGoydMpSJBITqNbGQFGfF+29vWjxRY
	95WUCRQLKfANNXY85zEltkhxmr4JGxLkoGNQNm1KX92HLmK2NhS1pRr3dWXEZA==
From: Petre Rodan <petre.rodan@subdimension.ro>
Subject: [PATCH 0/2] iio: pressure: add Honeywell ABP2 driver
Date: Sat, 22 Nov 2025 23:42:43 +0200
Message-Id: <20251122-honeywell_abp2_driver-v1-0-7a8e265f9627@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFMuImkC/x3MQQqEMBAF0atIrw2YZlScqwwSNH61QaJ0QB3Eu
 xtcvkXVRREqiPTNLlLsEmUNCTbPyM9dmGBkSCYuuLSW2cxrwP/Asriu39gNKjvUNL5uKoyF//R
 Mqd0Uo5zv99fe9wOtfAnRZwAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2195;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=thLXfCrTDyhEm2pTU5U01Uq0iCrYisCNN0k4tZMKQ5w=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2tpTGxiOVZkL3FvTW9aSDgwbkNhWVJDZlFaCnkzU0NMTU1taENzazFYa05o
 SllhWDRrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcElpNVd
 BQW9KRUhRcko2ZGpPa2xqNVdnUC9SdHdkNTNpbHJPTmU4bEZwdUNrVE9iUmQxaU52Sk9rYWFDZw
 paelZSOE4vRWwwOTJFVVJpVUVqbmEyNCtoamdZOVFlUWVCL3gvc2dkUHl4YWFJYW9PVVhka2Vaa
 zRPVnFSS3owCmFxUER6WWljRzZtaTg2OGtFSWMxVGR1NjlCS0F0UFFPMm8xb3J1OHR1MEFtbm1S
 b2Exa2Flb2VEYm9Hdzl3ZVoKZGFzcTk1d0svYVNVZ1dVNVpScDlPUzJjZlE5N2dQNlFydzlTRkp
 iSkwwajdtcGpxT0ZkUDNNUklHQkVTTnQrNQpHZ3h0SWROU3pmQjBkYmtDY2dpOUFicmtjajhqT0
 o1cmhKdVdHUmxrMnhPWnUyRVBrM0V5a3ViU3ppaXlOcTBMCkV2LzdqL1NOVGd2VGczN25oVkRnU
 HdOU28wZTBmdXBreWpIS09meTlya3Bxc0d3cmZmUFJLSGlUVERkT1F5NTQKdkloeGE1ME5OaEFH
 akdac2QwbDd0cktYNzFjS1owVVhBd2p4LzdFUG0yUHZXLytRNjFTbU5VNnJ1OThjK0ZGNQp5OXd
 QVk9uWEhKdEdtTDZjVVo0UWpaQ1NEMzREcGdXOVFmTlpYaFMvOGh6NXhBS0pVVTczQXFDU1dUb0
 w1Ri9nCklqenFpVGdTMEk0OC8raVNEUVdQc3VnMUhsTUR4ZjZYV3pqS1RSTkNEMkZQZWR1ZC8yV
 lY5ZFVRUHJqQzVKM0EKVHp2NkphbEFiWG5yKzRIaytJbHNJNVI0MnpHMEFXRnRYbVB2Z3VOMXRB
 Y0lHTDhBWDdTTDROSk5uays2eGkxVgo5RWhBZmJzRHdQYjRKREFpRGNjdktlNldHTVlLV3lQTWw
 vOU1nOG1MNjVCVkJjVlpMYjg3d3NJWEIxT2xadzVpCmt3bkxBSSs5S0JrYnhRPT0KPVFXQzkKLS
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

datasheet:
https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/basic-abp2-series/documents/sps-siot-abp2-series-datasheet-32350268-en.pdf

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
Petre Rodan (2):
      dt-bindings: iio: pressure: add honeywell,abp2030pa
      iio: pressure: add Honeywell ABP2 driver

 .../bindings/iio/pressure/honeywell,abp2030pa.yaml | 133 +++++
 MAINTAINERS                                        |   7 +
 drivers/iio/pressure/Kconfig                       |  24 +
 drivers/iio/pressure/Makefile                      |   3 +
 drivers/iio/pressure/abp2030pa.c                   | 543 +++++++++++++++++++++
 drivers/iio/pressure/abp2030pa.h                   |  79 +++
 drivers/iio/pressure/abp2030pa_i2c.c               |  93 ++++
 drivers/iio/pressure/abp2030pa_spi.c               |  88 ++++
 8 files changed, 970 insertions(+)
---
base-commit: f9e05791642810a0cf6237d39fafd6fec5e0b4bb
change-id: 20251122-honeywell_abp2_driver-9c796ef0c4b2

Best regards,
-- 
Petre Rodan <petre.rodan@subdimension.ro>


