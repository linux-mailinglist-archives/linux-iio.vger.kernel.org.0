Return-Path: <linux-iio+bounces-7161-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBF2924319
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 18:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1FED1C21D05
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1B81BD50C;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhUiOTLU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E727C1BD03C;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936160; cv=none; b=miyyGxrzIpAnCVkntP/M87ccY+wKPCQt1Wj/mehq97Mc3fUVs+0jQVTcRLrpbB0yx4MCyd/jUVnIbkEWAaPNiY5hu7Y2ryMcVEAp/uyEF0PHOu0QNwQudV+SmuoRm1OtmVyVxNTAAd0Kccf2qhpqAaiJUfTqwBwyvDxe8J1aqNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936160; c=relaxed/simple;
	bh=5Sqf3gwvJub0vRMW4cTH/hkIJm7o6yILPfaLsjTjjWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CqX8p2PbQpFO54LzraGcBULJ8y/VencUCUoFFn94aIv8SoVLFSpOpjgUTfpNWN+p6LkOrgRnCxkoGa/cfoZ4w8zbIKEvmb6o1lVp5zsale1wts0tJJ8mNrXlZOoYzrrXswxS9tEE6DusbnkzdjOwgCVtuYKVacGaCcgXdfpLQzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhUiOTLU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAB6AC4AF55;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719936159;
	bh=5Sqf3gwvJub0vRMW4cTH/hkIJm7o6yILPfaLsjTjjWM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KhUiOTLUnQZcDD+FUIM+JKIGCq2LQ0g8oiC9q5+/cC0EkFoms0MuznBS9mF6wqt/R
	 e+mvXEpIbxbJuGGAVReEOu/RsIeICHwUIc2BDL0lXUCnzlc+aWLU2kX/29bncr2yhl
	 2dxvT3WaqIUui4R1TpecknVqAmY96yNph3mgTJRDlFO5YUwwq4RNMV1mmYGCFUsLPA
	 K7t00u6NyC1jrZYo25s3qRAILBXX9TnIlfr4jUdBkoqBfT7beVrNZslbO5FelwDSfr
	 cJntrdS+jRxYmTzroiBP7Yi1n7NHcopX/5csagDuBVbdeUamEBY30308/iwgcmaDgE
	 qvtWahIGo+oLA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF609C3065C;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 02 Jul 2024 18:02:46 +0200
Subject: [PATCH 14/20] iio: adc: ad7266: make use of iio_get_masklength()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-dev-iio-masklength-private-v1-14-98193bf536a6@analog.com>
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com>
In-Reply-To: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com>
To: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719936157; l=824;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=+iJJW6/7I7TrYM1u+38IFCTTovEcPX4B9OrELlHsb2g=;
 b=7l7oJaQgLVUbsFsJZpuh/oP4+s8aNKMFAN7qbsnmyXqXb2eNN2i7UbGgtUnd4IeCXab9ouPGq
 SZ74x2ZsSvYCRuuQk6YpSeKtcNQz81jnLAy4vhEy2qwwXAOue7kJG3/
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Use iio_get_masklength() to access '.masklength' so it can be annotated
as __private when there are no more direct users of it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad7266.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 874d2dc34f928..accb78d4c3086 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -123,7 +123,8 @@ static int ad7266_update_scan_mode(struct iio_dev *indio_dev,
 	const unsigned long *scan_mask)
 {
 	struct ad7266_state *st = iio_priv(indio_dev);
-	unsigned int nr = find_first_bit(scan_mask, indio_dev->masklength);
+	unsigned int nr = find_first_bit(scan_mask,
+					 iio_get_masklength(indio_dev));
 
 	ad7266_select_input(st, nr);
 

-- 
2.45.2



