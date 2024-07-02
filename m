Return-Path: <linux-iio+bounces-7157-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF696924316
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 18:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A2D5B24018
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFD51BD4F4;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTa+Vub0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6791BD024;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936159; cv=none; b=EtdmPRjXYfnQOC2pa8DbmQEoUgOTSxWrCwmomgSVDRuscLrNwGuuEuWe5ySMrcM4alm5vAIdt049YccXe+OlqhUFEesY7JKPymMOecA7BEujOyMPXzWA4jRGxp6xcbZD7/sB6E17OVFujutXbL5wpe42HoDtkqHostENMhJrgiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936159; c=relaxed/simple;
	bh=ZCwedfbQM7Bvz4eB/mWdYfk3xL/2GllIWFfaCMXiRTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qfU8PxXvozKyLDDbN3uv7D2bP+YtKX8yjyPSw7XjdETYFML6hEQ24IWdFeU4qgxOqGnHgpAqtTNOJR1DWHG0BOvX9f5Vcw4J0J18LIZJXcrK+4rMNX1rh4YRBWuwb48fKNs4EZdnhHS1RJU01q7k5fcvb9YgIN9OnGs2e3EREAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTa+Vub0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70445C4AF17;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719936159;
	bh=ZCwedfbQM7Bvz4eB/mWdYfk3xL/2GllIWFfaCMXiRTc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GTa+Vub03zR2Z0JlaAuGVCX8zdkoTQI1fTWcZdCMahH6ij6zkAILRy+47B8/Gb0Ei
	 +b/W+lNoDN3QapbENksnfctH0DMKvBteZhop3lqhhVsI5aEvPSN8KW4KLPxPXoP5Ne
	 /n4N/0Nrf5BiFx0/uet82tEJuef2tAfKSJevMbz2CtLzxXJYAgr7sfQYxdOTb95MgJ
	 lgGX6a3+66yQXpDP8Su8JmajILcpIvgjGpfemIq4gZxiEY0Qhmiah1yz6/ZR3bxE7Q
	 gP72YhD18aXHpI6BKFg1WdziZDsEG8kQuulAg2p59k0HU0ot/M0t6r5g1lPwuu+TEP
	 v8+zYd9wJflMg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A412C30658;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 02 Jul 2024 18:02:40 +0200
Subject: [PATCH 08/20] iio: accel: cros_ec_accel_legacy: make use of
 iio_get_masklength()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-dev-iio-masklength-private-v1-8-98193bf536a6@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719936156; l=856;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Yooi1Y6tJJguy67GjA7GqDAjdHAGHhdREsMY2f86Dxo=;
 b=RBZcE+cYo3blVA2VGyLaJwUXflDQ6pPjo9mW6HflNYlGIxZLsMd2KyTAefDtDCYuqFOtd5yT7
 dRU0tYawuD3DUTmtGjIR9BLFCxRsRdf/aghHELirnJcWyKom2CvKcEO
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Ue iio_get_masklength() to access '.masklength' so it can be annotated
as __private when there are no more direct users of it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/accel/cros_ec_accel_legacy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
index 0f403342b1fc..f7e4dc02b34d 100644
--- a/drivers/iio/accel/cros_ec_accel_legacy.c
+++ b/drivers/iio/accel/cros_ec_accel_legacy.c
@@ -62,7 +62,7 @@ static int cros_ec_accel_legacy_read_cmd(struct iio_dev *indio_dev,
 		return ret;
 	}
 
-	for_each_set_bit(i, &scan_mask, indio_dev->masklength) {
+	for_each_set_bit(i, &scan_mask, iio_get_masklength(indio_dev)) {
 		*data = st->resp->dump.sensor[sensor_num].data[i] *
 			st->sign[i];
 		data++;

-- 
2.45.2



