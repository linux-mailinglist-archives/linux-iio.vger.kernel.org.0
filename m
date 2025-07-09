Return-Path: <linux-iio+bounces-21479-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7C1AFE90F
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 14:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192E23B9396
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 12:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDE92DA779;
	Wed,  9 Jul 2025 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="EHqmVv1z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259872D97BD;
	Wed,  9 Jul 2025 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752064533; cv=none; b=OotuKiTw6HWA0FQKyoGr50eEW5T/wHCekUIpks7WDSiXcKVS4i95gosul9HPDcifOAJp/aW+UZt+AZgLZML96kF8qMqViiaARNAEtkh7C7tDm/TcXU50uy4g2WAV/ORUQdNH4XZHlc6bgcH7y1jRF1BT9BKIf82npjM006qCsOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752064533; c=relaxed/simple;
	bh=BPy698GcrpPtoDCbVGGWNB9EVLtqnrd3EWTkrQRFADQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qxBgEc+nbDaLCImFASJuBlY/48Xrbm/nViYcM7WLEDOf3R3my1wKaKExvGB04pWyzE7OQG3EPfDYlciZMww/F5M/WuSIpiAnMSg/I7uE0KbJR7x2hs0dmlffGcx4rhc25cmDyRLVmYIQU3ISc27gZCf4ZSa5HXE4AKVgzbYvdkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=EHqmVv1z; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1752064524; x=1752323724;
	bh=dE7y/rO3sn7Fy0B0lT1j9SUVem01cPsz49Vvy/A3twI=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=EHqmVv1z/MzXmRI0oWyQmaCXiPqF52iS+QNyU8PBK032ppWAXaDibaulqYCYMkquA
	 o5yWq6X4LqQq8Pg95eIHUe370/xZCD4x9EmnRHT3YCh6rrX9swLQvEl1i3ErQwT72w
	 xHunN/jzkuLFSsIjiorfDUUC2CV70RVbt/oETb301Y1GUcaRXcf7BZeYra2b1koeu7
	 rHQKAGSetM1GmeQ+9qJvESojpab3faSE6H/bKhMe5xDcRlf+gzg/zxBOjeehWYXBV7
	 CgMty9v9Z4KTfXd9ddjWKclwbRKWGlLdwGl91Edefr4+LRDcQ9oif9uDgok7+e66LM
	 zNywarHbZ77rA==
X-Pm-Submission-Id: 4bccrW0nVXz1DDrT
From: Sean Nyekjaer <sean@geanix.com>
Date: Wed, 09 Jul 2025 14:35:11 +0200
Subject: [PATCH 3/6] iio: imu: inv_icm42600: Remove redundant error msg on
 regulator_disable()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-icm42pmreg-v1-3-3d0e793c99b2@geanix.com>
References: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
In-Reply-To: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2

The regulator framework already emits an error message when
regulator_disable() fails, making the local dev_err() redundant.
Remove the duplicate message to avoid cluttering the kernel log
with the same error twice.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 35f7c66d77790829a739d2c54ba77e53903a9297..55a29b1e2b11355598b0ede7af22857aed3ae134 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -700,12 +700,8 @@ static int inv_icm42600_enable_regulator_vddio(struct inv_icm42600_state *st)
 static void inv_icm42600_disable_vddio_reg(void *_data)
 {
 	struct inv_icm42600_state *st = _data;
-	const struct device *dev = regmap_get_device(st->map);
-	int ret;
 
-	ret = regulator_disable(st->vddio_supply);
-	if (ret)
-		dev_err(dev, "failed to disable vddio error %d\n", ret);
+	regulator_disable(st->vddio_supply);
 }
 
 static void inv_icm42600_disable_pm(void *_data)

-- 
2.50.0


