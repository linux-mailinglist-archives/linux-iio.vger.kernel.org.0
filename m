Return-Path: <linux-iio+bounces-25972-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091AAC3C18D
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 16:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273B542584F
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 15:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373E8299931;
	Thu,  6 Nov 2025 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjqP4PWE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ECE2957C2;
	Thu,  6 Nov 2025 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443078; cv=none; b=tCuVQ5JW0p5YYqV4KlB8m3RhZGWWCX8f0q5wGFMMzCXgdE0aXdY8hx/6qIxXth+9OUPYZNKbkrDwhN21WaenrU1agiz7BB9+xXC/DSMrO2JzJeitK4yuUJBARCzZWdIYZtxPjA3CG5QIO3xW/dWATw4ohrBHGANcKoSpLvNKGnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443078; c=relaxed/simple;
	bh=YNrEBMo35Bq9a0Ubhu/XS6aeK5Om7SRwirX8uKP/5Uk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GxrOB9VDrqylu0Kve72kOCpPYTPJqEHpCS3sjJsa/1kGWr4wNQOr3k4ndhKL446Zd5EvZ2maT6XAtY5ld7uUCn/biotx74eA5X5XLVZAoCI8ssLRZEqi2Q0f1vd7fnQcoFFS2iB/17y6jKYNuEEh3xH1FDukPfX9WYbXYnmhI2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjqP4PWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5EE78C4CEF7;
	Thu,  6 Nov 2025 15:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762443076;
	bh=YNrEBMo35Bq9a0Ubhu/XS6aeK5Om7SRwirX8uKP/5Uk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=hjqP4PWEu8GLjLHqkvC073J1gjpAJolDkRTIJgulkZqNvgdAPtmOj9VgeTAKVBgKu
	 U8YJS7oB2DDXYI4gF93xkShfBAkGIs3M2IpDj4RkWYkUeb7yQwaZtOKGrYryYyB9by
	 WpkEyrpkWYClXfH8Sv2brWRKjxY7tGqvwF1P9MYqHtkR0LW77u6wMaSIrNKEJWmveQ
	 3jJwAXE/7EcnVRroHoLhFXzlv2tNRyWE1S/tm91MFEaAwQZvUicrN9tyIJkmMseixD
	 hf/30ZTTeRoX8cnNPi8oOYo3jt17bFAgDVLjd3/Xh1+bU29WdXxZkStScd5UvYFx2K
	 Q5QTgQGHgcG+w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E5FCCF9F8;
	Thu,  6 Nov 2025 15:31:16 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Thu, 06 Nov 2025 15:31:07 +0000
Subject: [PATCH v3] iio: imu: inv_icm45600: Initializes
 inv_icm45600_buffer_postdisable sleep
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-icm45600_fix_buffer_sleep_init-v3-1-ea3af68a3e61@tdk.com>
X-B4-Tracking: v=1; b=H4sIADq/DGkC/5XNTQ7CIBCG4as0rMUABayuvIcxpNDBTrQ/gUo0T
 e8u7catLt/J5PlmEiEgRHIqZhIgYcShz1HuCuLaur8BxSY3EUwozkpO0XVSacaMx5exT+8hmPg
 AGA32ONGKaeE1sIOvJMnIGCA/bgOXa+4W4zSE97aX+Hr9mU6ccnoUEry1XCuozlNz37uhIyucx
 H+YyJhyjWMSuHW2/mLLsnwAYfqKBRcBAAA=
X-Change-ID: 20251031-icm45600_fix_buffer_sleep_init-8062f6e07f84
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Remi Buisson <remi.buisson@tdk.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762443075; l=1651;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=rjnLQ6ftgwL85LuwafkGpdVGU467jrrcGeZbXQXb9hI=;
 b=ES1XiY4cP7x/ZryQs38bwESSenkew1n22WNYFTdrjBMW0FOOO2LXuvCE4l2wHWM5Xqc6Bckjf
 YAcXmJFirzMCjns+lWL8C6Up8ONWfc2enfoYDcB/6pAMlvYioCwydD/
X-Developer-Key: i=remi.buisson@tdk.com; a=ed25519;
 pk=yDVMi4C7RpXN4dififo42A7fDDt3THYzoZoNq9lUZuo=
X-Endpoint-Received: by B4 Relay for remi.buisson@tdk.com/20250411 with
 auth_id=372
X-Original-From: Remi Buisson <remi.buisson@tdk.com>
Reply-To: remi.buisson@tdk.com

From: Remi Buisson <remi.buisson@tdk.com>

The sleep variable in inv_icm45600_buffer_postdisable could be used without
being assigned in case of error. It must be initialized to 0 by default.

Closes:https://lore.kernel.org/linux-iio/aPi6Xw-ZoUkW76zR@stanley.mountain/

Fixes: 06674a72cf7a ("iio: imu: inv_icm45600: add buffer support in iio devices")
Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
---
Changes in v3:
- Fix commit message: fix and closes moved to SoB
- Fix assignement of sleep variable after declaration.
- Link to v2: https://lore.kernel.org/r/20251031-icm45600_fix_buffer_sleep_init-v2-1-5cdc04e1bcba@tdk.com

Changes in v2:
- Moving pacth description from cover-letter to single commit
- Link to v1: https://lore.kernel.org/r/20251031-icm45600_fix_buffer_sleep_init-v1-1-924efbb165e8@tdk.com
---
 drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
index 2efcc177f9d60a6a2509e448c0ddaf4b9e1fd755..2b9ea317385ceb680f013c4c1b2a6a74fbe5d7e7 100644
--- a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
@@ -370,6 +370,7 @@ static int inv_icm45600_buffer_postdisable(struct iio_dev *indio_dev)
 		return -EINVAL;
 	}
 
+	sleep = 0;
 	scoped_guard(mutex, &st->lock)
 		ret = _inv_icm45600_buffer_postdisable(st, sensor, watermark, &sleep);
 

---
base-commit: 70437bbd7529e9860fb7f0c92a89e0e6abaa994e
change-id: 20251031-icm45600_fix_buffer_sleep_init-8062f6e07f84

Best regards,
-- 
Remi Buisson <remi.buisson@tdk.com>



