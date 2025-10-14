Return-Path: <linux-iio+bounces-25055-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E65BDAAE3
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 18:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CD2A3A5099
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 16:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB5930214D;
	Tue, 14 Oct 2025 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="lgNo2Csk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9F32FFFBB;
	Tue, 14 Oct 2025 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460205; cv=none; b=E6vNuml1MEOTF++e/0TtzwcTe1g1cXvBBnnbMYSPRC7IlEBJtGXw5QQTLYx3QFIDJNZqEqiXoEyqBRZXZreK2EW98NYY62vS/3uMszrLs5x68sHoOAipEUwqMhv0GMGRk3AAodvLF+bcTPD/i8PTti1Qa4V7SLL0WfXNzchcSr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460205; c=relaxed/simple;
	bh=YiNA3iLqyjLXZyLYtbRC5oAJpH8YvN3SAN5PdYePsww=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r2I0x4hHz5s1AF7JksNenInr6H4c5/0cuxJ+jAfUWcBfCN5Ck+tGek0ywv4LRb2Ms5UExzTMfdW/Xv8ErpqpRroAaOed29YmzDf2QmKwfhO1kvW3e9nG0hcWjNyP/hDVg35KfWrLJwLYCmx6Nt+563Lc5XhjIZ4WxFUOzYCzfxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=lgNo2Csk; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 6AA1E173BE9;
	Tue, 14 Oct 2025 19:43:14 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1760460194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ia4vZaPdP2AHku6PewVwHrlvnQ2g+B4aimjKQ++MKkI=;
	b=lgNo2Csk+eqheTb3nQYu1nTxr563LTgvx/FC3SC73hBXZfLJJ2Na9o3RdO2fOwAh4iNquW
	coJhRnolDKdoMqfp0AZ4ywjpaNMUnv3C2J4wI63moTcqPfovVx8goImlQHdUVnJ89gNaAp
	tOszV/KSQfatpPwMyfgAZ75YBgKZ1viul7uB3R2NNOwt7EETk5YyDPPkPNGKAUNA6IKBG3
	qRDKZgjbHCRmuzyRzibWT5x2qk8HDeZGvFhuMWtzfw9neZD/YdBedBLffnsdAVNj+ylG4I
	vWpXkQl8DHAQMnzhvD4m11biUiwaq4DToQLGyzYH7Dc88CMD08ScaGSLJlSyiA==
From: Petre Rodan <petre.rodan@subdimension.ro>
Subject: [PATCH 0/6] iio: accel: bma220: add events
Date: Tue, 14 Oct 2025 19:42:56 +0300
Message-Id: <20251014-bma220_events-v1-0-153424d7ea08@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJF97mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0MT3aTcRCMjg/jUstS8kmJds2Rjs8TkJJNE82RDJaCegqLUtMwKsHn
 RsbW1AIBqIC9fAAAA
X-Change-ID: 20251014-bma220_events-6c36acb4a7c1
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=YiNA3iLqyjLXZyLYtbRC5oAJpH8YvN3SAN5PdYePsww=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2p1ZlpYYTVzV2I4aWNoTEhMQmduM1QyaEx5CnFqZkJ0VFdIZEJvczZHUDlC
 VTliWG9rQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKbzduMlZ
 BQW9KRUhRcko2ZGpPa2xqRmkwUC8xdDRVVnJ4cGsyOGl2cW9oZ2dCS1pVdjIyZSt3eFlrZHYvUA
 ptZTdvNVEydk9lRVByakxZdHU1T1U3VGFBSS90ZnVTQzY1UGR1RFdtT0luTll3bUJTNTFZQklKd
 lpGQnBIdTBzClF1VzhSankvdDNxR1VBL0tDZGQ0L0FZdTNFSTA2ZHVNSkhWVUQvYmlPUEtSOTRT
 QnJabXd2azJLS1ZoOWJLK2kKYmM1aC85NmY5cXZkSmVIWURBMHJWdDI5MkJQRXlvUFJQSUZqMkd
 lTFgrQ21tSTYyMHB4NVhnaG14TG5ZSDRCUwpsem5VVE51TDZjM1JXc0k3b3NCaks3TXZndHNraD
 lMZGcydjBObDFwbXNES05SdUk1WFpmN0tvVy82T2ZRelJxCjZMa3RWVHhsN1M4RHRFazZJR2lBY
 1U1eDdxOE5sdUtPK092ZCtYcm8yV0NOUTc4d3JxRzBBOXZEMlczb1JMM3MKUjFvdGZkdmVXcEh0
 VUJnSWF4TlJqd2t5RkNUQnBpS2dFYzh2U1VaYSs1Szc0anhqOU41Z044SkxJMDlCOUl3Ugp1ZTN
 NQWRZYTB0SGZLMUlMMzdpU3lmYkxuOG9RdmlSTEllNjlScVhEQklOQUV2MS9aOHNlNXhCZXA3NG
 k4bUtmClVrMjBNOCtpdHlGTjlTTEFjV2xOeDFtNFU2M0ZGY2puSS9Xb0tpYTFQQjJyZWprWWN1L
 3phR0JQd25KSHd1Q0cKR044SmhlMWNDa0FtcnMzSjdaOGp2aEtLSnpEM2RMTlAwc0NyV0crc1Y2
 bjdsY2Zzam9wSjN2NnNjcmhEbUd3SAo5Qk4wNXFNd21kMHc4eXp1U0YveUlWcmhEQ1hDTVpPejF
 OWGpLVTFXVHBwVW43aU1YdzRldUF6RGh6WVc4NWcxCitFaDJaSWhJelVJd0p3PT0KPUlKVXcKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Series of patches that add tap/double-tap, high-g, low-g and slope
event detection to the bma220 driver.

The first two patches also do a bit of cleanup after the previous series.

The latch functionality is skipped for now since I'm unsure at this time
on how to implement a new API for it within iio.

To be applied to the iio testing branch.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
Petre Rodan (6):
      iio: accel: bma220: white space cleanup
      iio: accel: bma220: remove useless include
      iio: accel: bma220: add tap detection
      iio: accel: bma220: add low-g event detection
      iio: accel: bma220: add high-g event detection
      iio: accel: bma220: add any-motion detection

 drivers/iio/accel/bma220_core.c | 647 +++++++++++++++++++++++++++++++++++++++-
 drivers/iio/accel/bma220_i2c.c  |   1 -
 drivers/iio/accel/bma220_spi.c  |   4 +-
 3 files changed, 647 insertions(+), 5 deletions(-)
---
base-commit: 4b17a60d1e1c2d9d2ccbd58642f6f4ac2fa364ba
change-id: 20251014-bma220_events-6c36acb4a7c1

Best regards,
-- 
Petre Rodan <petre.rodan@subdimension.ro>


