Return-Path: <linux-iio+bounces-27743-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E318CD1DDE2
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 11:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44066309D40F
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5203438A2BE;
	Wed, 14 Jan 2026 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="f2bWInOI"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B59538A9A1;
	Wed, 14 Jan 2026 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385271; cv=none; b=a/+axvV5AYc/ZO4qq3Luu7QgumHN0nzJXl9Lp7Yg/X3yD9ulH68cS7Kvwn3asOzOwXp2QtBK6WPV6Ixf9Mt8jCYcxHRHc23u0XaSdGn6mXbpD16lc5/QEy+m8b8Te8dIFhzoIVLgR4BynXQk28BTdkBuSlEenaedPibrUKt3jDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385271; c=relaxed/simple;
	bh=YP3hy6HdIt2/OfY3rzsKz/l8UwcCOPQAAlhXNihbKTA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XbBdNJAPVKmG5RMDpyyHXLcyxkZKigXMtNcrTxzGumLnLdxAwD86+Ymjn+Tv1HwRm6CiH1aTWom2/tCt1VICTCNaRVmp+Of1YPgnNbUy+m1Riis2UDUiwnCiiPvrzP/c454UID9BaBE+8pd9jGHy44p+eAhe4FTpEPSfllL6oUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=f2bWInOI; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id E27F5160209;
	Wed, 14 Jan 2026 12:07:44 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768385265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Gm/SOfNg4xNo5ZZ9+bVcxxDhlzUyAzLWnyjD9hE5oVE=;
	b=f2bWInOI8F3cG1fv+qGi8n3bfk41w7M2o1UP5TPd8SmQMPUucFJodrUS3hipjdSQsXAuCA
	wsMiGR81hVL1Mt+a4fnsXbMIdjPHy0vEZ+JSjn1NqbRZc0qkcZco4cOA9+pbZT0vHvs3JM
	g6St43G16W5NENQ2iseayhB9BRHfsZd5mSeF9iCgWcgEhyePnT0owLm8DY8bWGWjImIXSs
	Xf12RA5hvhSOcjHZoRoh4obpnP54cHBEbokudOMjPVHecuJnUvawI3Xr3AyDy4aUvFsdBX
	lgny4kZSzvaWGDn/dnFLwwYM9UvkYCnxxu06XjyH7E+5Js0ANliVy0twW4mgkQ==
From: Petre Rodan <petre.rodan@subdimension.ro>
Subject: [PATCH v2 00/13] iio: pressure: mprls0025pa: driver code cleanup
Date: Wed, 14 Jan 2026 12:05:34 +0200
Message-Id: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG5qZ2kC/13OTQqDMBCG4avIrJuSiU39WfUeRUrUsQ5olKSGF
 vHujUI3Xb4fzMOs4MkxeSiTFRwF9jzZGOqUQNMb+yTBbWxQUmlUqMU4u8E/moGMXWYhsaW8yLC
 +pAXEm9lRx+/Du1exe/avyX0OPuC+/qT8TwoopKjTq8FMdmh0c/NL3fJIdn/p7Caotm37Atqe9
 MawAAAA
X-Change-ID: 20251215-mprls_cleanup-01de8971b439
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2688;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=YP3hy6HdIt2/OfY3rzsKz/l8UwcCOPQAAlhXNihbKTA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgprQTBEQUFvQmRDc25wMk02U1dNQnl5WmlBR
 2xuYXRMSVhKRmdkZy9VQzhwaWsvT2hQZm9Zb1p1TFh5WmpsekFrCkwrb1RPVmZXb29rQ1R3UUFB
 UW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGpCUUpwWjJyU0d4U0EKQUFBQUFBUUF
 EbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWXdKZUQvMFRRV2E5dmpwLw
 pmK1JiNXpLeGhaUkR6K3Q2eXgvWi90QnArMnVWZVZvYk4xdFE0MHowUi91OTY2eGtZTGNxZlEyQ
 kFMM2dmYUNKClhkdmpSdWZReHNhblJnZzFhM255OThHVEZ3SW5kVUhYRmU3SG9RMHpHdHJRLzF3
 UGRVNWNxV0ZJMWl4cGZkUmMKd0pBZy9uQWFOYmkrNVlOalNOSTVtRk1Fc2lWV0d3T0tuZUR4Q1B
 mVXREL0tKWDF4UTVtNXZRUXd3WWoveHFSSwpicyt0SU8xOHFrSStkc0ZkdzlkYS9XOUZ6VkhlS3
 NoYUNYYjRkOXNtcHUyNUF6eFI5a0syakFnbFIrM2xBSVBVCjFVMzNBaFdWaTFZNHNmSXQ4QzJvV
 EJkWHVjeUlSRXFKUE1zRTFBMEY3WnJ2RjNNR2loa25kb2doTTIzWXNROEQKSWtBTlVnbTVyc3lm
 dGJJN2F2bm51SkNmakQrUnY5blovVkxoMHVmQUJFdWRYLytnNUpnYjJ2dWt0SzJRRkZZdwozSWR
 lSnFNcTBrZUdWZGZpSjFLNzBxTU1iOGQ1S1F1STF4OHBOR2haNGxicjZmWDAzZUNIUE53RlBYK0
 VuQnk5CklpcXBHT1ZvckdHMSt1YmtDc1FtMTR4NkplNFdBTE9QbHl1YnJiRy9VR0ZwQ1ZKZ05sR
 0FQcVlTZEF4anByaU0KYUtxWkVzVUpPUVNZQWlnbTd4ckFjZUtHNmMxalZpOXNGQ0YvZWduTjRp
 ZFlOMjdDeStFUXh5aWRLUnJubExCNwp0S1lIa0QrYVNEVzJNNndwSGlaZmJITWtpWU1VWW9sUDh
 Qcm9rdHV1eVZyZ0diT0RXbmw3RW43QjlsOEgvZnMrCk44NkVkMFdGdmkrdmlIdFY0UEhCdmMwZW
 15WHNrT1hyNVE9PQo9d0l1cgotLS0tLUVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

This series contains a collection of patches to the MPR sensor based
on feedback I received for other drivers.

major changes:
 - trigger flag fix (define edge direction only in the device tree)
 - fix SPI timing violation
 - fix scan_type struct
 - fix pressure calculation
    (does not affect users that define a sensor via the pressure-triplet)
 - stricter check for the status byte + better error return levels
 - drop the use of devm_kzalloc()
 - stick to the datasheet parameters while performing the measurement
    sequence

minor changes:
 - includes added and removed
 - rename generic 'buffer' variable to 'rx_buf'

I still included the memset patch for the reasons described in the v1 thread.
if you strongly consider that patch inadequate then please skip it.

Tested on two sensors - MPRLS0015PA0000SA and MPRLS0001BA00001A

Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf?download=false
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
Changes in v2:
- reordered patches based on Marcelo's input
- implemented code changes based on Marcelo and Jonathan's reviews
- Link to v1: https://lore.kernel.org/r/20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro

---
Petre Rodan (13):
      iio: pressure: mprls0025pa: fix spi_transfer struct initialisation
      iio: pressure: mprls0025pa: fix SPI CS delay violation
      iio: pressure: mprls0025pa: fix interrupt flag
      iio: pressure: mprls0025pa: fix scan_type struct
      iio: pressure: mprls0025pa: fix pressure calculation
      iio: pressure: mprls0025pa: cleanup includes
      iio: pressure: mprls0025pa: remove redundant declarations
      iio: pressure: mprls0025pa: rename buffer variable
      iio: pressure: mprls0025pa: introduce tx buffer
      iio: pressure: mprls0025pa: move memset to core
      iio: pressure: mprls0025pa: stricter checks for the status byte
      iio: pressure: mprls0025pa: change measurement sequence
      iio: pressure: mprls0025pa: add copyright line

 drivers/iio/pressure/mprls0025pa.c     | 112 +++++++++++++++------------------
 drivers/iio/pressure/mprls0025pa.h     |  15 ++---
 drivers/iio/pressure/mprls0025pa_i2c.c |  13 +---
 drivers/iio/pressure/mprls0025pa_spi.c |  41 +++++-------
 4 files changed, 73 insertions(+), 108 deletions(-)
---
base-commit: f9e05791642810a0cf6237d39fafd6fec5e0b4bb
change-id: 20251215-mprls_cleanup-01de8971b439

Best regards,
-- 
Petre Rodan <petre.rodan@subdimension.ro>


