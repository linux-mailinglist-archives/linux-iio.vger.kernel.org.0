Return-Path: <linux-iio+bounces-27469-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 113A9CEFAB8
	for <lists+linux-iio@lfdr.de>; Sat, 03 Jan 2026 05:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E96D9300A9D5
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jan 2026 04:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9051123278D;
	Sat,  3 Jan 2026 04:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="o6sBy1zc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9063D217F33;
	Sat,  3 Jan 2026 04:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767415447; cv=none; b=uuLwxYsuF9/84Xkh+4KETNq1QpOTySSyDRI2yRMD+tD+EkyuJM7Zm14H17uq3YDlo/XmpWNr1fXvtze+0Pxv2KGcxoa3dyhIFM2jrTZN+I0JU7jkT2+QrD/HkTKTD2+x54upcAIvNFNCeztGvTmobm7MScEeTQSUPx7EatXMQEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767415447; c=relaxed/simple;
	bh=GxBgvbFsRkKqxg98JPs4OjclZW2utWoNsOnfjwIfE9Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c4j5AdoT6qfB4xVAG2L7J6nS9ijVq/TxYYVsrUnPSXF/FHdiPdFWuX3iXSx6eXPoaBqXd2vSZJIpY9o5LBFShz+nuFhRHBBRAKuoJzhDV03deJS+vDlF7y703LUjD5A1aMWM4ObXR5QJqp8/IAxs13wsOsDpJY8DP2o/M0IYkyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=o6sBy1zc; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:710:a300:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 853DC160209;
	Sat, 03 Jan 2026 06:35:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1767414955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vZLcTGZfgu8hLJ9SlFctAcPf0u5aXwb88E1Exr5aokY=;
	b=o6sBy1zc8GSVwDOM15lZOWD3nTJyblOJyA0cjE8S+XmXULdAWJkmZaHTI4qjtaddM2O5Xc
	yqmIDaOiBdkzBDj+fYCaiJEsehqE9dkUyIcdD3u9RL4zUWed3A1jI8W35m0tW/cXIITIY8
	1s4p9dIaZHeIMiuLyj3+HTCYGJ7yzF7pGlm4WhH1J12ebVyh3DP9ci3TV0tjQ3EwP7D63R
	aV3uR3LOHx95EXizgm3PEfNtAje3aBTb2KSgJz4NXurQ/IlCvqmr3PCQYnDix+GGllyrCK
	jnJejgr3kAUXuTIQXeYoRpYxLN45Iq7JGzzcFxig/j67bU7bmrLxpzGTsCLLBA==
From: Petre Rodan <petre.rodan@subdimension.ro>
Subject: [PATCH v5 0/2] iio: pressure: add Honeywell ABP2 driver
Date: Sat, 03 Jan 2026 06:35:15 +0200
Message-Id: <20260103-honeywell_abp2_driver-v5-0-0435afcf306d@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIOcWGkC/4XOQQ6CMBAF0KuYrq0pQ0vBlfcwhrQwSBME0mqVE
 O5uYSMLiKvJn2Te/JE4tAYdOR9GYtEbZ7o2BHE8kKJW7R2pKUMmwEBEEQCtuxaHNzZNrnQPeWm
 NR0uzQmYJVqzgGki47S1W5rO411vItXHPzg7LGx/N23+ijyijUqUIiaiyBOTFvXRpHtjOFU+2I
 7PrYW2lexbMFhOx5KnCotqx4p8FjO9ZcbBUGYMUOgyB2xZfW3LP4sHSAhTXWaL1Vq9pmr6Cml3
 9pAEAAA==
X-Change-ID: 20251122-honeywell_abp2_driver-9c796ef0c4b2
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2882;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=GxBgvbFsRkKqxg98JPs4OjclZW2utWoNsOnfjwIfE9Q=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xZbkovaUNVT3BrQjVtNzlKVlhxbGhLRGlpClFBbDZBVy96d3ZpVFBSa2w5
 T0Q5RTRrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFdKeWZ
 BQW9KRUhRcko2ZGpPa2xqNDNRUC9SeElDNFFNY29TU0MvTDBKRVoxQWRwWGlGZjJBNkF3eWlKOQ
 pxOFpGZ2E4ZVZqaEtJQTg1dXp4RUhMRTdQYWU0RCtyMEtUWkVLOXdQNnpvbVdhUmE4NDBoR0VXa
 m5nSjBUb0paClV4RzFPQ3VJR3JaZDdtOUYybUtIZUxQcG9adFNEOU8xNUlDeDd4NkZRa0o1cEZS
 TDZETlBrTXFZSytCeldqMGsKUEYwMVRRMDRsVlZ1VWZpV1JsVEQwSG5sRFBTQ3Z2NzRXbGM2R1h
 HRS9vQURBaFVIZlc3MkNzckhvUFgwaVdJdApUWDl6WDMyZEdDRGZ1N1VIYnZuMGZNTU5Fek43aX
 JFcXVTc2VMM3Q0bGgzTnliclF6RUpCR2ViR3k3enpIcFZmCjlQRU0vOGdFRXkwbit5Qk5vWHFBV
 GVlK3hKeGFySVphVWI5aEdUSjU2Wk9jcEVXOVR2R3hpMVJWaEtObnBSRnkKWUFPcGFnL0UxUzYz
 bFBMNzI2WHlMRFU2MXBvOVJHZHcxNy90TGRMcDM2Wnc1T1dxZFNjbTU2V29YWXYxWEZIcQowRDB
 IV1I4YkNhS1l5c2VDYXIzanh4MmVxb3hDOTA5am5MRS9rdTA0cy9kMm1LR0RHMnlmSUtQbmhIZF
 ZQKzIxCjZObjhuT29DQ0syNzlMZ0xHWUp3blY1Z1ZRaGxKSlUyUlZnbEE2ZE9GaFF5WUFvbEtNR
 U4xUGwyamtEN0NtRFoKbXVkWWd6MUF2SFdVbGp5bFFjc1ZjajBSbGx3K2NTSzVMUU9YQlFMUzgx
 M3lwODJTbzdvSnkxTFE3ODNtZWFMdwpHN0Z4ZHhEUGozTmdKTTQ4eEVCZkVlTS8zTWRwVjBlWWF
 Qd0NjbXlzS1d6aEFhczIvTXRqYzZ5MHJwTGJkRVcvClZNaGh3ekFpdEFVZEJnPT0KPVlXSmwKLS
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
v4 -> v5
 - driver code changes based on Andy's feedback - detailed list in the respective patch
 - re-add Krzysztof's review tag (sorry for dropping it)
 - fix typo in Kconfig SPI block
 - Link to v4: https://lore.kernel.org/r/20251207-honeywell_abp2_driver-v4-0-b52a4b96bbf7@subdimension.ro

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


