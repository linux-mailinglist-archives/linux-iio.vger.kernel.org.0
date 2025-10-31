Return-Path: <linux-iio+bounces-25732-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B5BC24A8A
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 11:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C113AE2B5
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 10:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4BD342CBA;
	Fri, 31 Oct 2025 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gzsv3UXb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B785277026;
	Fri, 31 Oct 2025 10:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761908292; cv=none; b=h3sH00DT4x9RKQtu7OcuSYlWpbSoOhqfKlC5J6jCizjQSwFCxqVnTj9cD5AiepBOGmbY6qaI6JOzj+ceMY0hznAtZ4CisSVEjGjcqkn8UKA3giBcU/id2dGLm0tfsNAvjQQ7ptrEgB0tuOwR33MNoEjJ81WZbaOJiJNxfxorJGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761908292; c=relaxed/simple;
	bh=5do5Ubxatm6jhrmYPuudJ1w3ROQptVL1YObQ7qj6QOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Jvzumbz3dtpQBCIMlvFX1+J/GBNqkyN7LWXXARNvOXnOUAslylB+OYhEPLTAQia3eDCRTz4s/jdAe39jfZDnRqdQ3dRswg6y+qmfvXDYmDn7MGegPzb9owJSHpfXvMVQcfFV1OpmKwPARXhLzKniujWDKfNr1ZwdPo55PwdmJZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gzsv3UXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC717C4CEF8;
	Fri, 31 Oct 2025 10:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761908286;
	bh=5do5Ubxatm6jhrmYPuudJ1w3ROQptVL1YObQ7qj6QOY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Gzsv3UXbHy7RyruyvtZcbyq8FVXlB7mFLG1WRH79syQ/wPyO0D/RKrqRAn15mDmQS
	 BNRh1XzZl5ejcxq/Ws7eNMKxpsU1fxrcowWrcsVTL1PsOmDgdTIWzkyMgNEiQSULxz
	 yEA4+teRszW+P26gQJrzxdCtRA2I1GC8jWxxRzDcj4qZDkGUAq4jA2jd5nFCZiqlp8
	 ge7t2J8c8nT1m9/xxu58Z19LtN4HBFEwwnXHEMAMblS1xWV2tFEL4YuEBYJlsPEVHk
	 UDZgf/nPir9fq/YlGWq4jJ7zr8E8FMuubhBu4Uv4b42P9v2gndHRTgCe9JlQvHL0eS
	 0DtowObYF8Pyw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5B2CCF9FA;
	Fri, 31 Oct 2025 10:58:06 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Fri, 31 Oct 2025 10:58:02 +0000
Subject: [PATCH] iio: imu: inv_icm45600: Initializes
 inv_icm45600_buffer_postdisable sleep
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-icm45600_fix_buffer_sleep_init-v1-1-924efbb165e8@tdk.com>
X-B4-Tracking: v=1; b=H4sIADmWBGkC/x2NUQqDMBAFryL73cAmaiq9SilB7dt2oU0lqSKId
 zf4OTDMbJSRFJlu1UYJi2b9xQL2UtH47uMLRp+FybFrLdfW6PhtWs8cRNcwzCJIIX+AKWjUv+n
 YO/Hgq3QNlciUUMRzcH/s+wHd5zjpcAAAAA==
X-Change-ID: 20251031-icm45600_fix_buffer_sleep_init-8062f6e07f84
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Remi Buisson <remi.buisson@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761908285; l=1222;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=VpdMvsXgKn/COc93uRlwlfHH10F/tvvmLU5wsUZM+qk=;
 b=88NM6IdkF46e5D0ne2znApGOCl5VOkNTq5eKGAlANfUloG09rdBKjBok1Q/3dI34AXfq+nl2o
 SuVaGkLinm2BoJReF8U0Pu5E0VLPHGBQbhxDkzb/zzK+jvBIHl6m1FJ
X-Developer-Key: i=remi.buisson@tdk.com; a=ed25519;
 pk=yDVMi4C7RpXN4dififo42A7fDDt3THYzoZoNq9lUZuo=
X-Endpoint-Received: by B4 Relay for remi.buisson@tdk.com/20250411 with
 auth_id=372
X-Original-From: Remi Buisson <remi.buisson@tdk.com>
Reply-To: remi.buisson@tdk.com

From: Remi Buisson <remi.buisson@tdk.com>

Fixes: 06674a72cf7a ("iio: imu: inv_icm45600: add buffer support in iio devices")
---
The sleep variable in inv_icm45600_buffer_postdisable could be used without being
assigned in case f error. It must be initialized to 0 by default.

Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
---
 drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
index 2efcc177f9d60a6a2509e448c0ddaf4b9e1fd755..bb8382feddc0fd882a6be2ce5e4fe77ab68f13fd 100644
--- a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
@@ -357,7 +357,7 @@ static int inv_icm45600_buffer_postdisable(struct iio_dev *indio_dev)
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int sensor;
 	unsigned int *watermark;
-	unsigned int sleep;
+	unsigned int sleep = 0;
 	int ret;
 
 	if (indio_dev == st->indio_gyro) {

---
base-commit: 70437bbd7529e9860fb7f0c92a89e0e6abaa994e
change-id: 20251031-icm45600_fix_buffer_sleep_init-8062f6e07f84

Best regards,
-- 
Remi Buisson <remi.buisson@tdk.com>



