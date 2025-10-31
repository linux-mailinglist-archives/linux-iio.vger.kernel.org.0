Return-Path: <linux-iio+bounces-25756-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE67C255F8
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 14:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 19B1435150F
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 13:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DEC34B1AD;
	Fri, 31 Oct 2025 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+uRkNXx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701D734A3AC;
	Fri, 31 Oct 2025 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919054; cv=none; b=YW7Vg5XnSuqBpAcqMcrgxwBhd8RnJvRJDIi1cuzcbJyeDkDKXI3ErpjTSiyQQGUhHp7FKWI6gWZEiMcYm49bRKa5ImJCQqrL3ldyXsxCaIf/oSnF5Acqf8S8zjpTcffU1ywd9p8mpyeQ3zviEqt8xV8gO5fGVnPq8vIDmu/kd/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919054; c=relaxed/simple;
	bh=F2dQov/k8/XGikOnynsRGjTKyVzwWntonzbekUZ8F4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lnQjqfs5zWErUTpdMvintDJMvHpZhIq3x1TOfi/TgGPfEo9D1cXwcU3rcgpzV7VBrck9FZis9HMSCcVU5VnU1f+6/qSsfIGGGHQ2PHe9Z99VKYM6mk65wet6mE6aawxVatJRIb02jNjTs+XCF4mK9iORVNkcjPZk2cQqRoEDOUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+uRkNXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0482AC4CEE7;
	Fri, 31 Oct 2025 13:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761919052;
	bh=F2dQov/k8/XGikOnynsRGjTKyVzwWntonzbekUZ8F4M=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=e+uRkNXx6Q4gCVsqoDCnid4Qs6AQphBQdX7Ip1BSVnSqP95FAMQJb0LIh0DTBA/tq
	 UnurPcI4tjePldqN9aTbj0udPo0Jvb2WZAMS0ZZOie99wJbFePCgvjvZAVX3+UB4la
	 B4cdrrC/K/UmtbJ2J3BI9EqrgKPp3ubfh5uhRlwWDNcBg//uVxv9lgplPJCIjsKTu0
	 wnbqdRVUz9YemRSTBxZ67pmlb7/HBifTNEuuCnuGueHlfStJk9R9B8IJq1qrkdR3hO
	 dIbMCbpVg7nJKKytRsNTSHqMQoC1dsTEs0tua3kkQQ/Mr6lj6rjmW2qBY5bOyO8tXt
	 g16fQgD9mirdg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EEFCCF9FF;
	Fri, 31 Oct 2025 13:57:31 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Fri, 31 Oct 2025 13:57:06 +0000
Subject: [PATCH v2] iio: imu: inv_icm45600: Initializes
 inv_icm45600_buffer_postdisable sleep
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-icm45600_fix_buffer_sleep_init-v2-1-5cdc04e1bcba@tdk.com>
X-B4-Tracking: v=1; b=H4sIADHABGkC/42NWw7CIBBFt9LMtxhAwOqX+zANsXSwE+0jgI2mY
 e9iV+Dnubk5Z4WIgTDCuVoh4EKRprGA3FXg+tt4R0ZdYZBcasEPgpEblDacW09v2768x2DjE3G
 2NFJiNTfSG+RHXysokjlgOW6Ba1O4p5im8Nl6i/itf6sXwQQ7SYW+bYXRWF9S99i7aYAm5/wFw
 ETtacoAAAA=
X-Change-ID: 20251031-icm45600_fix_buffer_sleep_init-8062f6e07f84
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Remi Buisson <remi.buisson@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761919051; l=1575;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=Rx62rT5vGu7kFWtOCrCoEMC+ZXlR39elZof20ubLlDA=;
 b=kfjGhVBUaoE4027tfvZxjjDZqatcfqnxl2+OfuvbAz4md8gbYTd6AV3AOtULR8I2Q6O73oLj3
 bI93bDRmPAtCIrCRr1FreWPjr7Pj0TR9Oy9983/Xja55wM8eDT0fbpP
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
Smatch static checker warning:

	drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c:377 inv_icm45600_buffer_postdisable()
	error: uninitialized symbol 'sleep'.

Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
---
Changes in v2:
- Moving pacth description from cover-letter to single commit
- Link to v1: https://lore.kernel.org/r/20251031-icm45600_fix_buffer_sleep_init-v1-1-924efbb165e8@tdk.com
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



