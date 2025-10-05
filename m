Return-Path: <linux-iio+bounces-24750-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB8BBB96D9
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 15:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27CD189747B
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 13:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43788291C3F;
	Sun,  5 Oct 2025 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="Kk0cSCzu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CBE28AB16;
	Sun,  5 Oct 2025 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759669996; cv=none; b=bLMiKgR0EEjH7FVvoPXBI/B1hDdvbZW5t50vKyy2MZ9Bjh7GRh8lezbzQOCBn/XwCKk+nc/BYMzrgMP4joAK5fhinuPKJVQ0Sh60UYrv+UV9sH1f5+tidp/PPO8wJt4Z0d9PgS73mbV5Zb09TW9YPluuzYqVOj6/fRuYXpX9Zhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759669996; c=relaxed/simple;
	bh=d1J2MNB/TSp8FJmqC3xqo6geozDAbsIUbv2aGaGqnDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nRvx0OiouEP07gq3pzQVJsC9dFEL9K+wCErN84is/dsokVtqFRcR66wTiC/acbxhcqpQtXSi40lthbF8RxhQ3amT9PWcFYPoBkFp+ixbMDxSH5QmWufR4dR6PinTxIRj2ktXZ5VqKNV/o3EKSYZnHVJRmj+IUtGzCtkNukWt9ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=Kk0cSCzu; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id DB0AF173BFA;
	Sun, 05 Oct 2025 16:13:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1759669987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vfj7hLAQv6FGVYQz9sUHDZRVmbR0mVyLAK+ZlMSvlxA=;
	b=Kk0cSCzumsjr94CMFaWFIRjOQK0W+xLsew6U3d76apbLEDJjGdcSLUHJWdID28n+/QT33M
	DW+ess2uAYVdOs3MpmuDMWST6q/wlxdgC6IgDZMkGz5qBLwhkijXTIc5dxkHfapDGLSX1Y
	CwBnoOK9CUcbJ4Hhi+WFYxZLCr1dUHh4GrQIQhyM7BQeeHp2W1QmQaqPBZEGBO76twwbVi
	1FbVrUe9/iiSRub76sV6tjrICWdz+7oJylJPhuxuBl4UHTwsdDKqFF3sN1cpHMmchRFI9O
	P06bXVJVfLYHtt3juyxFCAwr9T0Lkcz5GI/AEfc+HcruL1BakbJalMJ5a7OqzQ==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sun, 05 Oct 2025 16:12:27 +0300
Subject: [PATCH v4 18/19] iio: accel: bma220: add debugfs reg access
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251005-b4-bma220_improvements-v4-18-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
In-Reply-To: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1189;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=d1J2MNB/TSp8FJmqC3xqo6geozDAbsIUbv2aGaGqnDE=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2ppYnRldVdVRUdOK3l4RnByWXFiUzVPMmVXCis0MWJzZ0FqT2FMM01MeXZN
 SmdvTElrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKbzRtN1h
 BQW9KRUhRcko2ZGpPa2xqRUg4UUFLSW1OeXN1bGxNamt4eFZ2Nm9VcWNOelAwb2JnWjZkN2E3Vw
 ovRmhFdnRBQk4zNXdWZm5welFIVEJwWjQ1NXozNzBiOE1McDBHRlovZDAxZTRVRUpLb1dXcEkyQ
 nBTeHIyTDJECldaRDNqTElaWHNDQTVBN1hBSjhCeVVjamgxTnVFRUlnQVdNbGF1QklnMndBV01j
 V3I0VTBxbVRKSXF3YTduTlYKSGNkZWphbWtheE41NVUzNUU2QVdhZUhrOHZnK0hCUFlTWWxLYjV
 GMmZJNTQ4Y2RhcUZ5UlJ6RXBJQmFnYTQ2awpTRU93NTNYV215cjBqL1E5L0NrQnN5WHhYTm9GRz
 ZGaGJZaDI1TXlSZ0piTzJqT0dhekVScHh1RzJnL1RHakllCk5qYkpZcEJnQnM1azl4T1BVbjNBS
 mNWbGRTSlVQRkdudk1WVFhDZGVBRFlWL0lvVUQ5ckhwdjRrZU9kTEtULysKS2FJTEVjc3hvQ2Vr
 MjhXQTBLZkFGeHFSMzIvdFlvWEYzQWxkU081Uk5JMWY3RHZ3eVErZ1NFT2gydHd2SlNPVApkYnh
 KYVY0bVJIR2FaQmNQbXFza1NwYWl0WkpuaFRPRUdqUGdhTy9iRzR6NnlFL052dWVaK3MwaTQ3NW
 xJdTJUCkQ1RFloK3VEcDdEOW9RaGEyZTRhK3ZEeFFIak0zcDhtVlErc1FWM2RsNElNMDlQeGRwT
 GhTNUVLRVNUWGdOZU8KUEtoZWtyakhOYVg3NTNiVnFEdS9HQUhCOTlQMXprNC9aUjZhbUdpdjFh
 Z2dmejNUeFYwYjZmUENwRFNFSWladAo4akpFcDF1R2N2aHc3dTBWeTFXVGJGQ2VUc0UzWnB5d25
 IVVRTem9BTzRHOXJ5NHhOTkRRN002UHArT0pMa05sCk9jZUQ2emhicXNzaGNBPT0KPXdxRlMKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Allow read/write access to sensor registers for use in unit-tests.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1->v4 no change
---
 drivers/iio/accel/bma220_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 7109759e28397d2660f17707124a8803a254cb14..0d6c301b1c47a04cfca5bae157f8ce6144f0b854 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -375,10 +375,21 @@ static int bma220_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static int bma220_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			     unsigned int writeval, unsigned int *readval)
+{
+	struct bma220_data *data = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(data->regmap, reg, readval);
+	return regmap_write(data->regmap, reg, writeval);
+}
+
 static const struct iio_info bma220_info = {
 	.read_raw		= bma220_read_raw,
 	.write_raw		= bma220_write_raw,
 	.read_avail		= bma220_read_avail,
+	.debugfs_reg_access	= &bma220_reg_access,
 };
 
 static int bma220_reset(struct bma220_data *data, bool up)

-- 
2.49.1


