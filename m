Return-Path: <linux-iio+bounces-7163-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B4692431D
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 18:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AB24B23041
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CA21BD510;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uW8b/Ltn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016D61BD4E5;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936160; cv=none; b=jXWUQ8byFEyKHPJhRKK9NTaS4Gb7au+csgtVPC825r7jZDd5NFQ3/y0n8hB/TnOvsEO+PGW1BkeHdMkQc6xxYz27fzc+Mny2WHxyoRMItBef3C5IEYM3eLUBZGnJ3w1rr6HOmACMQ/C01ytRoEznab8nTZN71QTNiC3IwpzTolE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936160; c=relaxed/simple;
	bh=71yuAUOKQP1vw736p1/RjH6fm1/8Q3DuQ5CHUBxzKZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JPO5eJZ7+cavzpPm7HMqA+K82VkT1tExniMFsHvfmSIIhG0w2XAt8SaOJrslWfuRkEqrj6OyBdkcFmvRmZdFQnEPe75YHdM4GJ37sRfxw8DuWEcoXVPCeijKFDGkjKC2mHE1Z2sgjj4BwPOw86foqeVFIVDvb/AfgO3rGwj3L9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uW8b/Ltn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9145C4AF12;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719936159;
	bh=71yuAUOKQP1vw736p1/RjH6fm1/8Q3DuQ5CHUBxzKZM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uW8b/Ltn68boEo6cbtU/0evdtMrP+Lfhbqn1Jn7SXi6rhL9ls7GcKgvHvw3QvFYNE
	 jG3j6iBRiB6ZXav9XPw60Bn97M2BHD5XpHRssmwy/Afx+Gg2NIAFa5Xw6wENcvA6SV
	 COCXWYKNPzCwRPSrcB5EMOVyG20pie+Fi85m0lm4ChyXZ168NYWhXAsKP9b4AtvYOE
	 y81jaxNCJpikWR9ZDgFkSpdfVJsd2PzCor8JVFp7orHvjzsTH+pTHg75BwlLMc2uVJ
	 Bx0rDhVf/2RvBu6b5q2BywM7JpwabuCC1NXcx662sg7V33t36/+z5rQdPxWZ8GPHMZ
	 FvYmMJXLr813w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDECBC3064D;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 02 Jul 2024 18:02:47 +0200
Subject: [PATCH 15/20] iio: adc: ad7298: make use of iio_get_masklength()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-dev-iio-masklength-private-v1-15-98193bf536a6@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719936157; l=801;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ZK5+aMXYaMNYV9d90opMtFfRkoEJrZPm17fO7HBXKCg=;
 b=bBdOYmZMjoXy8dHw5U5DCzkC1MW642k0qxtGkPbdxSpudzdrcC1SyHkq1BXJDjzSOQsc2EYqH
 PKMs/R0+RzqB2zgmUTR43u8A7wBZFCtENhKKATYeu6u68vHJTWB0Imh
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
 drivers/iio/adc/ad7298.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index c0430f71f592..0128436367db 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -109,7 +109,8 @@ static int ad7298_update_scan_mode(struct iio_dev *indio_dev,
 	int scan_count;
 
 	/* Now compute overall size */
-	scan_count = bitmap_weight(active_scan_mask, indio_dev->masklength);
+	scan_count = bitmap_weight(active_scan_mask,
+				   iio_get_masklength(indio_dev));
 
 	command = AD7298_WRITE | st->ext_ref;
 

-- 
2.45.2



