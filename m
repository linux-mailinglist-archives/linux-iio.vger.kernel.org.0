Return-Path: <linux-iio+bounces-7152-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 718B0924310
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 18:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15581B23DB4
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4AF1BD039;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9zkoQwc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3C21BD008;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936159; cv=none; b=SR2BRenbNLhhQVuwqgXuc2/S1kYFI3wReBmMBrwAhWyxcNlZNYnycv0qzpnT7G8dk5tvAg0247CO4sasJjEKrR95bwHpHFGNiCGes2XwIVnhdLL9hRuKGesmKccBhdHBgfWExHmNw4+iLq1FZf8xtrFUBtqDeRxYZC2tcKzVK1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936159; c=relaxed/simple;
	bh=HiXT5JNAR/1VnVUe+f4ZpB2y/EtlWF8H9g7WziIDIOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tPB5usl2DwmDqh/mCTM7euPwl4Q+ReIlDJGQA4nIzzm3cj3XTwXkq8s4APIoNXPjlP1tB0a5ntRwpOq0XyaCSH+MaZxzb6OuiZCVwGsRgKgIKPwGL94SmkwrEmJ2/vH5hGsAUJCckoeIU6zfhsU93FQFeB/i3S0y7KjEJDIT9lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9zkoQwc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62CE6C4AF15;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719936159;
	bh=HiXT5JNAR/1VnVUe+f4ZpB2y/EtlWF8H9g7WziIDIOk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=g9zkoQwcrhJCIJbGkZ2UnJ2K6vM5cQ5NT1hwVFH1T4YYHPFWPhGrxMtZgOvxipKzv
	 B4ufyTGUezxkTuIpeBcVrkUZGo9FF1gtu9MZLH0V+wLhze+SI8uP8HyBkfEPanA5wb
	 qayOlb/pZ+qRxMK/WGRwSqgCgY7QRfpKF5seY+ozhwqndUjCQuVO/ewSbceCQLMS/O
	 bvAYkEuoXob1XiWpzWLKzXBBVidgSR7eOJVq9xqVx33/WuCkOsj2eDJ9raqT4iOOCb
	 l/O2CVbYXpwqgKlnA0XHL3+PafonA+nvnnHn8FQlJQ47/QJdzPQFfv/fDwTbUOj2BS
	 8WqN/hV0oyszg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B51DC3064D;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 02 Jul 2024 18:02:39 +0200
Subject: [PATCH 07/20] iio: accel: bmc150-accel-core: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-dev-iio-masklength-private-v1-7-98193bf536a6@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719936156; l=922;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=JeCIOP4qgOR1Vu/Iu0Qe9nBtR5DIWcMVPhJ4pTpIOtQ=;
 b=/2w5q3UWgYNzczpKhdhjLtwr+/NVWDbhJ9/6z6VmYIYt6PsaG52LAInaeclbeVx47gtB/KIA7
 Fg5QC9lLSHnDagmgywq6G+tpSSB5XobU6izlnRNijyC3zDtfltQ7gVV
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
 drivers/iio/accel/bmc150-accel-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index ae0cd48a3e293..03121d020470e 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1007,8 +1007,7 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
 		int j, bit;
 
 		j = 0;
-		for_each_set_bit(bit, indio_dev->active_scan_mask,
-				 indio_dev->masklength)
+		iio_for_each_active_channel(indio_dev, bit)
 			memcpy(&data->scan.channels[j++], &buffer[i * 3 + bit],
 			       sizeof(data->scan.channels[0]));
 

-- 
2.45.2



