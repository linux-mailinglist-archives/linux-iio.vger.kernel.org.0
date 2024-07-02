Return-Path: <linux-iio+bounces-7153-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D507924311
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 18:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D712E1F22672
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BCE1BD4E7;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HifFKV1f"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDBD1BD00F;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936159; cv=none; b=hXB4pBouOVtoyUnnv69CErXkHASoJuvC9yvqS9pLY/PoxPDX321fOD9jMfP3E69vQ7fsLN78BeVywIl+1gGFAVx/7l44JltL4B6juga59NZbJyIgqwf7JdHema52CjCsHcAHk9IonQNYHJrEjAiCcs/I6NhRgYZ9uF8f3ec6Ak0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936159; c=relaxed/simple;
	bh=RaueGeC+jGBMTdCacPR+kb1XmqOFJE7ZrTneACLbmpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lExbuTXCLB7Nv0ZWM1Y/3MLDPOzKgU2k/MgcSQ03VGg/IxYM5bt4Szp+465VvdwYMU2XeCJ8ZeSEx4Tn+Clt3Wm0frtZpOpGlDGVQsNze/EXwDPhj/valVWjYxnXSaUsIcXbG3/VUC99HMpTbHr0b847wnh/KFvlDlxFUpN1IRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HifFKV1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 370B5C4AF10;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719936159;
	bh=RaueGeC+jGBMTdCacPR+kb1XmqOFJE7ZrTneACLbmpE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HifFKV1f7zIRt7LFHBSCXcJcLG+fe6E6yersqY97MhQZ6J+yYfDjvnkDyhIoSnsvX
	 huT0ZuavwxfIjRt/sN0PZnTsV0L9Ln80VyMiz3Amw4lq6VUufCYFVqy+Mxcah9OLYd
	 IhNpEF86n6MQhcnzPPeLgk3fPYKsfdSA+9HxrLgTtPgNfX9JgIHD/BAR1IMUGbz7kJ
	 SHmEqbxZ6pDVp1R+kAJeC8FY8HOHr0qo4rVAe5TOdf9zshDh34k6aHIvrnQPzcUlij
	 500wsqGBIcxhS/4IdvlwIl08Jb6WGclESK6hdbtSMIhyx4hBsR+E6/1C4AEIL8Qp4/
	 YkBkTHm/Wc2rg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6EDC3064D;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 02 Jul 2024 18:02:36 +0200
Subject: [PATCH 04/20] iio: accel: adxl367: make use of
 iio_get_masklength()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-dev-iio-masklength-private-v1-4-98193bf536a6@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719936156; l=721;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=f4PVshteDVZAwqATinUZmA3UwIta66xyxWFMtEAfYQg=;
 b=1jd1tko8JTt6ombBnrwWcAZplN7C74Nu1r8Ua45+V5Zh5KiUAiJVG3T2zgTbf3ehU5XCQW62l
 Tn8hVu93D49Apu1X0TW0t5tEspUjaokc84rDXaGMUk7V4hl1ov/rbc4
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
 drivers/iio/accel/adxl367.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 5cf4828a5eb5..1c046e96aef9 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -1220,7 +1220,7 @@ static int adxl367_update_scan_mode(struct iio_dev *indio_dev,
 		return ret;
 
 	st->fifo_set_size = bitmap_weight(active_scan_mask,
-					  indio_dev->masklength);
+					  iio_get_masklength(indio_dev));
 
 	return 0;
 }

-- 
2.45.2



