Return-Path: <linux-iio+bounces-7160-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DDE924318
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 18:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06CE628B67E
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8381BD505;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijd0h4VG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79791BD035;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936160; cv=none; b=E9SK7HBaoU71ngX9SY30yTYMdcVS83QmM30D7a+kHCRlPl7Ivn6iJclx4DA+4qht/tZRGqhH/ue66z/8GwKhoF6ivutSHKplt6DNB2sdPWj/poIXZ7OPO1C6HiHF6kVjfSWp0vgrtNqAvGB5/fONn64Y9+/mfmAzcUXoWpWTei0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936160; c=relaxed/simple;
	bh=rd4bK4dYxKBbRt1v/HZMzCwZJy2bdmq2nBBb4Aozq18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sxiBlwPqotZJ5A939f5sQeM0wLodYn0tsgC59cWhtV3n+Erg7npHrVhB7dx7Xe+NKAMN9CxM1P9WA1ggQWF1ID/VNDFMjS/ffLaxt3om4c1D4hGTqrYJUzq79xA7GOjhhgqbzq0GhNcBOSFEATlwpm+O2i/W2Za1y4CmsL78aZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijd0h4VG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB7F6C4AF52;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719936159;
	bh=rd4bK4dYxKBbRt1v/HZMzCwZJy2bdmq2nBBb4Aozq18=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ijd0h4VGLKb6DgMe5DsdLxpkH3LbYrWs2NMHmaMDaNc6tVzkfMo9kUEP2wJrGsGc0
	 Od7mnwaGsqanwApfirV7x/qjlneE7P8aP8x1Fm9ophsegSrP7eYvJeoEmLudFDhu46
	 5R38H33cLnWvK208CK2BHc4GkhONUHJX4aQbCMLiLThgjBSM5TJYJre3tyY7jsOzgo
	 S1obIwoNgFve0lCmS687q8eUNCie0rtx1xkEJJyRc+1vkcSDb6gnoJQItwX3u3YQ/A
	 EnGb3s543oao/IsJDJYO5n3x1OEVycMYz6kD3CqdQtazs+Ngbr9+BihmUOH1XShqe4
	 vbc3YABjmuVpg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4516C30658;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 02 Jul 2024 18:02:45 +0200
Subject: [PATCH 13/20] iio: accel: stk8ba50: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-dev-iio-masklength-private-v1-13-98193bf536a6@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719936157; l=866;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=TFHhQ83QqdJS9zWdzKNj08+dSBp1rdr6hB/g9TIyego=;
 b=vHiGPKXd69rf0HoQ0INFT45P7M/hmXLo0wVQ4CVhuTDIKz0/OPtTpUelGoQ5YexRkZHIpbO2c
 3ZzhIyVx1UQBU3qUZQf0pojqjpQ5CeCmKRq2Aah3AUVM5WwC0Yayj7w
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Use iio_for_each_active_channel() to iterate over active channels
accessing '.masklength' so it can be annotated as __private when there are
no more direct users of it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/accel/stk8ba50.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index 6d3c7f444d21d..a32a77324e92d 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -330,8 +330,7 @@ static irqreturn_t stk8ba50_trigger_handler(int irq, void *p)
 			goto err;
 		}
 	} else {
-		for_each_set_bit(bit, indio_dev->active_scan_mask,
-				 indio_dev->masklength) {
+		iio_for_each_active_channel(indio_dev, bit) {
 			ret = stk8ba50_read_accel(data,
 						  stk8ba50_channel_table[bit]);
 			if (ret < 0)

-- 
2.45.2



