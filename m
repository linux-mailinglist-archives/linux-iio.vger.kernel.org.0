Return-Path: <linux-iio+bounces-27689-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD080D1CF7C
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 08:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E85FA300F5B3
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 07:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CF637A49B;
	Wed, 14 Jan 2026 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="ajlDFMyE"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D3D37BE78;
	Wed, 14 Jan 2026 07:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768377329; cv=none; b=vEScZVNUL77QA/oLKZAtBxTsJFFn5uLOnRVF2g25qV+AlHAGeR6MNc78tnueR5yIECHPKPX1LhiM5P6Y56P6CnscLiAsyoxNA9nBQ1Bojksq3ZtHT29y59fkpjA08LVPGcBxjTEJPHuZgtc2z/d3CJamAogRQurxaqYBMIVinSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768377329; c=relaxed/simple;
	bh=GnKrYcsopNdMlVTP+QvAio2TiaHlo7ghgsNZ+LqLeLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FdqNvimOrpCMchU71vL67wfEkhCouUbmBI5DrtzUCMPeBCJC8ukqyULhnbqVFqBxzQggbZwVvOYcvfPfSARSa5P0z0r1cXVrhqEjUrTB+odOUvM3xoatNIwTN1LU7qKTgNZd3hqt1GhBvIxB8Fx15Yn+gfMP1YrIpkmTn/5GiE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=ajlDFMyE; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id 0375316020B;
	Wed, 14 Jan 2026 09:51:59 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768377120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Q7u2EhI4eBfmAlWLst1u3yxl/bYP3Vvu9LhuWN9AKk=;
	b=ajlDFMyEqSypJTRGVCvH7YrRGfmEHJdlAjNhlWtpB9IDebVlaJes9B5lTEZSazWWhCOXwI
	x4024Hk3UNGbCSmE6fY2V0UaNkDxD59xnNQ+UD19wNfNJvIP+X23pQCtzKMf2f0eX02GXS
	59gsTYwMRbVANgSY5rmHOv8u9Xjj/PbMuNdKdZRY7O6aYlNrZ/fksT7YjTj2vSoR8tW5/8
	3p4WwXIU+RJK8YkA43MXXqBb/L4kGdVmczaniPuOB/lkk21re79r/5BE+kSRNQFbhO2Giy
	4oZ4acQm+s+2AsVPiCKe/ztMXva7am+86dKRRg9lzJ9XjNmABp0k8ZeT5fIu4A==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 09:51:38 +0200
Subject: [PATCH v6 2/2] iio: pressure: abp2030pa: remove error message
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-honeywell_abp2_driver-v6-2-231c3a8c222b@subdimension.ro>
References: <20260114-honeywell_abp2_driver-v6-0-231c3a8c222b@subdimension.ro>
In-Reply-To: <20260114-honeywell_abp2_driver-v6-0-231c3a8c222b@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=882;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=GnKrYcsopNdMlVTP+QvAio2TiaHlo7ghgsNZ+LqLeLA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xuU3gzdjFxckRRY2dhSVlId2gxeWVVMmJjCkYwSDV1aWFTR2oxV1cvMmxH
 T2h3OG9rQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFowc2R
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWTJEbA
 pELzBSc0dZdmdQbklmUWRhUTJXaUFrd2NQQW0xTnFHbzNkckswUHV0R0lXQmJEZi9tY2pkaW1XZ
 GlJbnIzQzU1CnZDb3Qzdkg5by9UbWo2RGpRU1pIdFAwMU51SW9nUUl0NEsxbDIza05zc1ZxL2Iv
 OWFFNGxvU25BYTgrSVJyVTQKOHdwVTBBK0NpOU1iMmpReUFFbHZHUHlYVFpVaC9IYUw4aVZIUWg
 zelJuaDZSaVB1SXVZd1lGZHJ3QjNnTlVEZAoyUGZiNW1BWURDYVF1czBXTkNXY2VWN0JwV2lxM1
 E2a2EyMnZIaGZvZ3dQR0pObzB6V1NFM28xS0VkMDU3MCt1ClNtREdCdWNXS0dyOFBzcWhXN25lN
 TlMQTVVSkFENmNWaXdzbUFEUUROcWU1QTUyZjl1VE9GYlNqYXFpVkVEb3MKSXdzUm1BQTJENU85
 d2gweFczMlNrSHNWblgxcjRXYmFacmwyUDlKQ2RYODFLUTV3a08ybksyTm1nYi9BM0RNdQp5TmQ
 4ZlZ5L0JTTFFzZXZQbmR2U2lVZ3pxNVhPbWx5Mml4a0YrOWFORDllNis5NGlQclRuK2F5L0R1eX
 QwWVJTCklrUmh4TCt1cVdKd0RBMElXYWdtSEt1bWVScEg0a2ZyRWRqV3JGVEpWR3B1Qm9lZFB0Q
 nU2cm5LbVZkTUlmWVUKMTQ4M2FLR3FwNFpHbXpMNGk3aG5YcTBjN2labjFhYzVUQUtMOWFzNEhD
 Z01XS1lBUkg0NnMyZnFFemhBVHZMWQpHc3d4bkpDNHZ1TlJnZU84SFp5UmxUZWlMc0NlZTFOYVR
 5Tzl2cUJyU1RmU3IrTUt0djJPdTllMUtKRXlzeXJsCjNnY3ZDMUpRbDFjaGQ4MFR5WEJNVHhsSj
 FyekM1WXowWElISGZaZlR2dFl1dFZ3T0tDND0KPU9lOXYKLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
 S0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Do not print redundant error message if devm_request_irq() fails.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/pressure/abp2030pa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/abp2030pa.c b/drivers/iio/pressure/abp2030pa.c
index be11e28208ec..4ca056a73cef 100644
--- a/drivers/iio/pressure/abp2030pa.c
+++ b/drivers/iio/pressure/abp2030pa.c
@@ -523,7 +523,7 @@ int abp2_common_probe(struct device *dev, const struct abp2_ops *ops, int irq)
 		ret = devm_request_irq(dev, irq, abp2_eoc_handler, IRQF_ONESHOT,
 				       dev_name(dev), data);
 		if (ret)
-			return dev_err_probe(dev, ret, "request irq %d failed\n", data->irq);
+			return ret;
 	}
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,

-- 
2.52.0


