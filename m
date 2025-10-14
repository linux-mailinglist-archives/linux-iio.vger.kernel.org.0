Return-Path: <linux-iio+bounces-25048-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1983BDA93C
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 18:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03722188271C
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 16:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959D3302154;
	Tue, 14 Oct 2025 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5FftEwV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C00E2FF646
	for <linux-iio@vger.kernel.org>; Tue, 14 Oct 2025 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458271; cv=none; b=g/R6l63k0iCH4H0WKP1b7Fluc3ft/hmdYre3Nbpf4BBaOVAGo5PK1z2Ntn15qhA6smnyK3twjyUlVihIEXbmB0Qkk0lcBh+kXXjb5Uh+wn3COosCJpRehsRsI2cXPGWLy88RuOfXKWKn2xUQ6k23iZ4GC2HmrYQP981CsUMqoXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458271; c=relaxed/simple;
	bh=cgGGWkNLi5kUkZ5XtXPyN02ZnWo0wYfVpJDHqBiZlT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n/HcvLqY7Tzgjn9yk3s5S2yFz/l3picDOgqVirjckHKaC6yHM3W9LMnqrIgsLsLc5P8qv73VXedK8Zwsg6kSt4B/2hD9Cv6VjjdFjC1EvORwHei4sIbUK6jgKZqEe7BAxce7THPRMa9+ayqTEgyKUh8aOU/ewBCk19+FqvUcUYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5FftEwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C9A4C4CEE7;
	Tue, 14 Oct 2025 16:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760458270;
	bh=cgGGWkNLi5kUkZ5XtXPyN02ZnWo0wYfVpJDHqBiZlT4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=B5FftEwVihlU4FOukWcSUeMWEvaU/KF3+wpjpV8OucMJy9YBsE+7bFkP6+KfBlg1O
	 zUuTK/bDEyEHLfwaP5Tw6DpjMyU5AP+Tkg1l1vTnTayxkm7ucJ18LA3UWcs986kQWX
	 pirYG6iOb4w1D3+Vpp+yJwubSV0F0iDvLmOJKrG/9uez8xmRa0MdQm/OaZ5ZCEkovH
	 Z2RSeXiO/beHA0vjv5KhGGZ/hm1u4/lhVU89RCPZxn2jbBDQoB/EL2zIB+bFc1hnos
	 JWGMv0y7Avm3oPgXVkFv0rK/qsSPK41tr+NuakRC0TqeBl0FH4vVVoo0kHiucZLqu/
	 cspSsprKWVhuQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C74CCD193;
	Tue, 14 Oct 2025 16:11:10 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 14 Oct 2025 17:11:41 +0100
Subject: [PATCH] iio: dac: ad5446: Add AD5542 to the spi id table
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-dev-add-ad5542-v1-1-cfd197db03a0@analog.com>
X-B4-Tracking: v=1; b=H4sIADx27mgC/x2MQQqAIBQFrxJ/naCmYF0lWoj/VX9joRBBdPekx
 SxmMfNQRRFUmrqHCi6pcuQmpu8o7TFvUMLNyWrrjTZOMS4VmRveO6tCCuPgGEED1KKzYJX7H87
 L+356bfBzYAAAAA==
X-Change-ID: 20251014-dev-add-ad5542-8c8934de80ee
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760458303; l=1036;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=zjLKzS1W0/5HBFY1YTVVWSk3p4EDX/9So7On4WYstjk=;
 b=E1C/CYMOFW2iu4rNfmmBcdVfvqnYKSbiuMTO2Kfp7Hlp7me3gNPymAl0zp6cxMayDHQTASval
 sHV/BReLDxPCJurJxSXBtcTTDwHfdbMtuAJixwwySr3H1n+uIJUx9zt
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Michael Hennerich <michael.hennerich@analog.com>

This adds support for the AD5542 single channel Current Source and
Voltage Output DACs.

It is similar to the AD5542A model so just use the same id.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/ad5446.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index ad304b0fec08..6e4103f4afcb 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -422,6 +422,7 @@ static const struct spi_device_id ad5446_spi_ids[] = {
 	{"ad5512a", ID_AD5512A},
 	{"ad5541a", ID_AD5541A},
 	{"ad5542a", ID_AD5541A}, /* ad5541a and ad5542a are compatible */
+	{"ad5542", ID_AD5541A}, /* ad5541a and ad5542a are compatible */
 	{"ad5543", ID_AD5541A}, /* ad5541a and ad5543 are compatible */
 	{"ad5553", ID_AD5553},
 	{"ad5600", ID_AD5600},

---
base-commit: 4b17a60d1e1c2d9d2ccbd58642f6f4ac2fa364ba
change-id: 20251014-dev-add-ad5542-8c8934de80ee
--

Thanks!
- Nuno Sá



