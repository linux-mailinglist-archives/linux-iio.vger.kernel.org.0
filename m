Return-Path: <linux-iio+bounces-27174-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA910CCB926
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 12:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7E2730AEC9D
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 11:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CAB3164CE;
	Thu, 18 Dec 2025 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="Ij7qxGTJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C187A314A7F;
	Thu, 18 Dec 2025 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766056470; cv=none; b=E6I7g/7meNyz0WxfVEv4NxUJqXwVF+vLGAo/lAqoL+uj82d0Sh+rC6Yq5sjwryotCKho5jbDqyXaHoLGj9SVTelgGGKZ0wOEqCoyt3WdrqK5s1I/UlROOQBVdBW3EA8aDiN43sWUZgzCmk6ie1K4i4wRq9gy0J+XdPgm2Rg4944=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766056470; c=relaxed/simple;
	bh=UNzA4AwPEQZln4mAkqHOZ/191JAbuKK4FhPmsX8tVaQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JnYEfkNpTTDWx1E+ipbRm7vPiciTrM6IhRVHO5+1sBbJLR6WuEWDR9Sv4PR0Ovncyjulb8s6W04rN7whJIWEMpEgCIsm1sQEE6+3pXsnV6XXk/LJi64sBwuKsY7laVr2v9p1YGqME/I3ifYLDJr4JNRuQWcesAdAQIP6XnqVM44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=Ij7qxGTJ; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3804:ac00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 6E3B6160209;
	Thu, 18 Dec 2025 13:06:15 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1766055975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+vnGoUyKgUTPYM9Tj6dtxUtc3dBvKA5bs5MI/yUSMEo=;
	b=Ij7qxGTJrT4Gp1JUIjNafuaKa8x6rVRSMQwy6y/+tKzfxTNMDphVmquQ/kCluaKhIGsLve
	25lBT8YRw+LpegF11t1j7x2txFPLPHaa7mv1i1pvCC+eX2himl7wyCBxBmQqo51m8jkbfC
	PYvd72kzIBHvs1JBwPjKbb99gmqAgPm8egHIPtNFUjl70uLtNQ/G7BTNXSZxEhGzoIU+Xw
	iLdzZU5F2CgV/D+Et5qtCxNfuu1lrFUI77OfaTX5hk/9bl5TYZr4KPpb1vS8LLnV/F9i/a
	nbFrW9DZPZztbOdq8LRrfOVMZzCTBpGVRIWqdyh/BeUwFEX4AkMiHhg+6hZ3fw==
From: Petre Rodan <petre.rodan@subdimension.ro>
Subject: [PATCH 00/14] iio: pressure: mprls0025pa: driver code cleanup
Date: Thu, 18 Dec 2025 13:05:42 +0200
Message-Id: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAbgQ2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDI0NT3dyCopzi+OSc1MS80gJdA8OUVAtLc8MkE2NLJaCegqLUtMwKsHn
 RsbW1AK+08qFfAAAA
X-Change-ID: 20251215-mprls_cleanup-01de8971b439
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2523;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=UNzA4AwPEQZln4mAkqHOZ/191JAbuKK4FhPmsX8tVaQ=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xENEF1RDZ3S1hNb2Npb3BqOXZiRXpaeVJCCjN0aW9lNldtV2JEc0UyRWND
 K3BRS0lrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFErQUx
 BQW9KRUhRcko2ZGpPa2xqdGZnUC9pVzdFRVZ6RVVJaFYyQzcvcUFmd0xvT25WUXZ4UWErU0JLUA
 oxdDBOTC8vT1lrc0FxcEdwdHFkQVR6UDl4OFRHMy9ZUzVXT0dGcnAzL2d0M0p0dlRzNmtoSjBve
 nVoenRiVnlxClplektGYVphbjRDRTNoN0hUVFEydy9BL2VkSVNuKzBvSmtZZVZObUFJaW01dDM1
 a1poc2ZkN092UFJVMVpibVIKRGs1bnBjRFo0OTUxaEhnOHloclNYYTc0VmNCODBiWFkySnI5KzY
 vTm9NUFV6YjJBSEZwU2hLdXNENEdXR0FmbgpSTndwUmhtaWdhWlYzY3k2WXZRb3ZxbXBpNjV6b3
 FxL3RNbWtWZnRiNDVKU2NtVnp1MFdzcS81MGVvL3JEM3EzCloybGgzRjlVR2lpWHg1QVQrbVJ5L
 0pYaExjc21INE1yV2FpbkV6TnNrWjR5TFl1YUdrQTBZODIxLzhkbGwySHUKb0FNTlVCeUp4dGwx
 TU9YaXJ5YWxkZVJtS1crSDZXZXZqbGYwTEhmUncwUkhuaW9mVkxuS0xZdEhXV2dma3ZTYQpLSGQ
 3alNxVXVDdkxRTUt4ait2ZTF1LzBoSURBZ3Y2STRWRE1XbUJ3ZUlIM25sVDNjK3U4bWpsTzFOTE
 pvdHhzClhyVENxaVgvZThkQytRNFc1OWk4SVgwb3pXVU4xUUdWOERjRHplaGNZVWRIRkpUVVQ4M
 C85TWpxQU12UWp3aC8KU3pqbXB5N3QwcVRSTWxLWFR5ajcxQmlKbGhYMEg4NTBzeWg0enp5SDcr
 OFlib2dPaDBjdjl6RkNMcGlxdWp3QQpVa1JEYUNMT3lKNHhzV1p0NTd3WnpjK1A5S0p2QVNyT3V
 VSDQ2MnRUZE82L0ZNWFlqSnkyMXpCTDhQc0psdWZZCndXc3UxbFh1L3Bvdnl3PT0KPXd3Q3QKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

This series contains a collection of patches to the MPR sensor based
on feedback I received for other drivers.

major changes:
 - drop the use of devm_kzalloc()
 - trigger flag fix (define edge direction only in the device tree)
 - mitigate SPI timing violation by changing the measurement sequence
    (only affects users that do not use the EOC interrupt)
 - fix scan_type struct
 - pressure calculation fix for custom chips (does not affect users that define a sensor via the pressure-triplet)
 - stricter check for the status byte + better error return levels

minor changes:
 - includes added and removed
 - rename generic 'buffer' variable to 'rx_buf'
 - remove redundant locking

Tested on two sensors - MPRLS0015PA0000SA and MPRLS0001BA00001A

Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf?download=false
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
Petre Rodan (14):
      iio: pressure: mprls0025pa: Kconfig allow bus selection
      iio: pressure: mprls0025pa: remove redundant mutex
      iio: pressure: mprls0025pa: rename buffer variable
      iio: pressure: mprls0025pa: introduce tx buffer
      iio: pressure: mprls0025pa: zero out spi_transfer struct
      iio: pressure: mprls0025pa: memset rx_buf before reading new data
      iio: pressure: mprls0025pa: make ops->write function consistent
      iio: pressure: mprls0025pa: stricter checks for the status byte
      iio: pressure: mprls0025pa: mitigate SPI CS delay violation
      iio: pressure: mprls0025pa: cleanup pressure calculation
      iio: pressure: mprls0025pa: fix scan_type struct
      iio: pressure: mprls0025pa: fix interrupt flag
      iio: pressure: mprls0025pa: cleanup includes and forward declarations
      iio: pressure: mprls0025pa: add copyright line

 drivers/iio/pressure/Kconfig           |  34 +++++----
 drivers/iio/pressure/mprls0025pa.c     | 121 +++++++++++++++------------------
 drivers/iio/pressure/mprls0025pa.h     |  22 ++----
 drivers/iio/pressure/mprls0025pa_i2c.c |  20 +++---
 drivers/iio/pressure/mprls0025pa_spi.c |  28 ++------
 5 files changed, 90 insertions(+), 135 deletions(-)
---
base-commit: f9e05791642810a0cf6237d39fafd6fec5e0b4bb
change-id: 20251215-mprls_cleanup-01de8971b439

Best regards,
-- 
Petre Rodan <petre.rodan@subdimension.ro>


