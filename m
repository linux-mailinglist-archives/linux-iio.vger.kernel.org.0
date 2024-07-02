Return-Path: <linux-iio+bounces-7151-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D4092430F
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 18:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54521B23B62
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9601BD031;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGuOy2AE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879471BC096;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936159; cv=none; b=iNDEhfvaU12oXTpAJ0femiedqmX5whXh0bNCHyXFGZvYRRLssdgdiJ9Jua5lhrqRlRrke9mmOWi0hpIdYq0HpwvfAIVMtEAlyq7ScL5efPoW9VckcYJ8xvNnAcUvwKN5GbZuS2H/cwjGARSthv2e9EqyPyo9w/7tNWxuPXKPc3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936159; c=relaxed/simple;
	bh=ihOzVGJqm0d6Bf+2v8BGqtXAu3mpTzxXVeZwgRlF1Mc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AUvSwG0IL2c/ayg+v+c3r1G4buYnqdU+s7oRNNwO70DI/45s5ZFiwx2+QmZchZ6f34WSeg3skRKN0+ErAA3bP9DTwAh6Ap38EjwkRsQfbU8B/qa7tXwn4UPswejko3dwRcKK7hptl0agDcVkGjElvVdFAsPWQnTZjOZ3qa0pkkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGuOy2AE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2429FC4AF07;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719936159;
	bh=ihOzVGJqm0d6Bf+2v8BGqtXAu3mpTzxXVeZwgRlF1Mc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cGuOy2AE08q77TRgAM5guB04jdSAG1x2AN/lrBk+xF9n/RVcKtjtzIB0fM6BJosrF
	 ZA06zsWpE/FlxZX3Jc9kCnENk5/PUhMnUfK4TOQG+V0jpU2Ko+pnuCEk4jmyzSdu9d
	 EdHjYTN+XEr+4ZLST1iclSyyJJWwfErlVxdIQfSgATSg7U+id/xPQZhtMOdXwMJFBU
	 4pxBd49SNw73EzjWAknnoq1+93obLJ3DHlD8gPJ17cCj+sTlp/jYvTl5I3iGber6vP
	 cJHOeYRO5OdJkZV4EV4I5E182HJP0D3MDm7url8LH8hfD3qbL7asrsOr26mpNShkup
	 JHebQSwf+uLNg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C5FC3065D;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 02 Jul 2024 18:02:34 +0200
Subject: [PATCH 02/20] iio: core: make use of iio_get_masklength()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-dev-iio-masklength-private-v1-2-98193bf536a6@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719936156; l=787;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=q8IX5Pt5A6KGno27QoxN2X3k3j64RKvI5e+ShjWeyFk=;
 b=ssQKkLuKZ5MrR4JWpkmj+KsOh1I/ZpdqwlW13UWmcM9OVrQdUyCjMgixEpP0nWba20kAbq0P8
 vrxtwleODJGByn7di9rpyaB1q/aljuXsXM+tXlAhZJwcxpFg222xGmX
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
 drivers/iio/industrialio-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 2f185b3869495..e392a10aaf320 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1907,7 +1907,7 @@ static void iio_sanity_check_avail_scan_masks(struct iio_dev *indio_dev)
 	int i;
 
 	av_masks = indio_dev->available_scan_masks;
-	masklength = indio_dev->masklength;
+	masklength = iio_get_masklength(indio_dev);
 	longs_per_mask = BITS_TO_LONGS(masklength);
 
 	/*

-- 
2.45.2



