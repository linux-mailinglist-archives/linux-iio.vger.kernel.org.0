Return-Path: <linux-iio+bounces-26009-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB11FC3F1B4
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 10:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661A3188DF52
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 09:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CE731813F;
	Fri,  7 Nov 2025 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUvtwmJe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A8B31771E;
	Fri,  7 Nov 2025 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762506842; cv=none; b=WvMhUMOwNZ0Ap1+wACktIF9mIfyHvEsQirt6XSLkUAI7+9Kj2WKwGQjIhCMbwsuRRftKosg42XfJ4snMbgaUcW8x5oMoDo9MWx0ZxTNijlpv8Rj/4lA3c7Zc0kIjLst9qDtG7/e2Cwdz5UDXikWHLVDJf+sCMQNRBGV8cL0BdzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762506842; c=relaxed/simple;
	bh=sk262LJaEte1LxYrOZlRv+oGbDTDbh+k0NKy4pPUswA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I3ETNPN6s3Ev3hYkbQ0T7QxWAhcfDbwnG5fYRv292MeIw9nOfqAys9WSsSo0yo+ffZzCJcmiOXkl4cSHpeJasqjcOdm9GOlmh98wqncI+d1O74rRdKGddbC11dkvJdWVpZd+covTG20nW8qzKrHlX6DtpNBmplGcsPDqQjezYRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUvtwmJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 096A3C19423;
	Fri,  7 Nov 2025 09:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762506841;
	bh=sk262LJaEte1LxYrOZlRv+oGbDTDbh+k0NKy4pPUswA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=iUvtwmJejdOZgFPeNehQY+c3cyWnFkGAWMBhKF7C09z7ZYvwXtPUgJR3BZQnxRFJS
	 qLk8/7o4RisD80I2MTaYJUmxpZJBeYDWynRHAHkMaXjpinGV/DKOjeG+vmZN4zn2eG
	 StX87CiBnkbPasOrMNdV8XPtVOJiyO+S+6No6LBn9vIbmiIOsmNW94vWzOSHTpibHc
	 2zXLdIrLAvuM/37+Z8FpFvQMCuAMPjkyzB1TqdpaDmvqEkOLUiWrKdYPmSOxX4qAyr
	 r1gnD5tp4ra7mtvPxiudyQUiJmsqAxP6YL0Bcn8vlxfPQcrQgHWaK2xzTKvhStA4me
	 6O6cTs3fYkDZw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02C0CCFA05;
	Fri,  7 Nov 2025 09:14:00 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Fri, 07 Nov 2025 09:13:58 +0000
Subject: [PATCH v4] iio: imu: inv_icm45600: Initializes
 inv_icm45600_buffer_postdisable sleep
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-icm45600_fix_buffer_sleep_init-v4-1-5648fbfb57ad@tdk.com>
X-B4-Tracking: v=1; b=H4sIAFW4DWkC/5XNQQ7CIBCF4asY1mIYoFhdeQ9jGqCDTrStgdpoT
 O8u7ca4Upf/ZPK9J0sYCRPbLp4s4kCJujaHXi6YP9n2iJzq3EwKWYBQwMk3ujBCVIHulbuFgLF
 KF8RrRS31vBRGBoNiHUrNMnKNmB/ngf0h94lS38XHvDfAdP2ZHoAD30iNwTkwBZa7vj6vfNewC
 R7kf5jMWOFrLzSC885+YuqNgTBfMZUxtMoGU1qFBt7YOI4vu8A4cWQBAAA=
X-Change-ID: 20251031-icm45600_fix_buffer_sleep_init-8062f6e07f84
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Remi Buisson <remi.buisson@tdk.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762506840; l=1865;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=KHYZL4PBkFcdTzaWag6cVizPSRawbM+rQCJdwDIqyec=;
 b=LJrkBuBn+oJJ4i6+c9a1Glm0edUU8D+kxrkVzMQbuHuC6IkPGp5tssgL2dXIty231dS0qARbJ
 Z6v8TApjoFpDqyt4gKR2tKvzRy9Ggs1UlGsYuN5dYrIvtKHizzqTyO4
X-Developer-Key: i=remi.buisson@tdk.com; a=ed25519;
 pk=yDVMi4C7RpXN4dififo42A7fDDt3THYzoZoNq9lUZuo=
X-Endpoint-Received: by B4 Relay for remi.buisson@tdk.com/20250411 with
 auth_id=372
X-Original-From: Remi Buisson <remi.buisson@tdk.com>
Reply-To: remi.buisson@tdk.com

From: Remi Buisson <remi.buisson@tdk.com>

The sleep variable in inv_icm45600_buffer_postdisable could be used without
being assigned in case of error. It must be initialized to 0 by default.

Fixes: 06674a72cf7a ("iio: imu: inv_icm45600: add buffer support in iio devices")
Closes: https://lore.kernel.org/linux-iio/aPi6Xw-ZoUkW76zR@stanley.mountain/
Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
---
Changes in v4:
- Add space in closse tag in commit message
- Remove extra blank line in commit message
- Link to v3: https://lore.kernel.org/r/20251106-icm45600_fix_buffer_sleep_init-v3-1-ea3af68a3e61@tdk.com

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



