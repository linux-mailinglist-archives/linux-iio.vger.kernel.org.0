Return-Path: <linux-iio+bounces-20908-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71C6AE4146
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 14:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317D33A334E
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 12:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2592324BC09;
	Mon, 23 Jun 2025 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqCn48LU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D239124887D;
	Mon, 23 Jun 2025 12:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750683360; cv=none; b=o0eOVckCwInC+qFHWsx5QzxNSRhwoe8fod12OeoHAfEwp2HrDZIq+5pbxAd5rpVXTRF6w3ZUJsRlAtgUwfVdEe9a3Pdd+frFopCX0rzMJf+TGg0Vj+TkAV6UVvE73ioQ5mZLpgr2v9mfE9YWIFfqux2ZRaN4JFLUmPBkT3XJ9kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750683360; c=relaxed/simple;
	bh=YuILsy/ohkvfKCdU2Ji92sX+6WIltRJpeKY8t27HCSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ieyh+MVAoZfDhsyzc0NraqVOG4qYLDKNEGDQpMyhnicQbQpd0jpT2iLZGa1cQ2xYMSX9SpePofkIEYEROMRGr7ykJdzeqL79xKib7tAhARhfKNe46vOsN0WzVz+sHG4MhaJor8rsqjyiPIqMwRBqGnERBeSTUCIcw/yu+aWfO68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqCn48LU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F51CC4CEF0;
	Mon, 23 Jun 2025 12:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750683360;
	bh=YuILsy/ohkvfKCdU2Ji92sX+6WIltRJpeKY8t27HCSw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SqCn48LU8XydkL/tHHPVsnA+EY30qKZU/V5FQZje4bzb8vpIUJj93F+3meZ7LMby+
	 YSD9yawW/b3tw/JFoQlEVvYd9ouy4jH5leXjneYoFg2sTvcVyG7ZFcU8RANyTYXbTR
	 cO3FViX0vGer+zq9T8E0gnvLuG3XdLUCS/fbyX1hFrTDO4wbJuTz1CWZyDfhIlB4b2
	 wfJ/Z8bTYHz5Nm5QVZxzr3U7O3oxL7Z9fJQ6x+1c6U3zElKMXaaiBGpcG8ynEWh/D7
	 PURXG9H91Yo/mqhjjBQ9cNtzczURKyq/sSARP4c5k4ADItdWQxZOy7E6C5p63KcVTu
	 /BTkxClBPD/VQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBCFC77B7F;
	Mon, 23 Jun 2025 12:56:00 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Mon, 23 Jun 2025 14:55:52 +0200
Subject: [PATCH v5 1/3] iio: imu: inv_icm42600: move structure DMA buffers
 at the end
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-losd-3-inv-icm42600-add-wom-support-v5-1-4b3b33e028fe@tdk.com>
References: <20250623-losd-3-inv-icm42600-add-wom-support-v5-0-4b3b33e028fe@tdk.com>
In-Reply-To: <20250623-losd-3-inv-icm42600-add-wom-support-v5-0-4b3b33e028fe@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750683359; l=1524;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=Sqk5EBW69Vb3qsTzZ8JKNX6MNPvlZeiK+pOwCYdRCz0=;
 b=yZ91Enn+j5euiJhL/kFfEZ/3Qeqk2J4+Olnz93SNdPg9C41wawcKrf802EsCcRbpCzlGeywD/
 2JNEJBVnaQbApO7CgYux8OdHV4MA7OM6sfUOYNITdEg1EUPujIfvaLq
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Move DMA buffers at the end of the structure to avoid overflow
bugs with unexpected effect.

struct inv_icm42600_fifo has a DMA buffer at the end.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 55ed1ddaa8cb5dd410d17db3866fa0f22f18e9d2..9b2cce172670c5513f18d5979a5ff563e9af4cb3 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -148,9 +148,9 @@ struct inv_icm42600_suspended {
  *  @suspended:		suspended sensors configuration.
  *  @indio_gyro:	gyroscope IIO device.
  *  @indio_accel:	accelerometer IIO device.
- *  @buffer:		data transfer buffer aligned for DMA.
- *  @fifo:		FIFO management structure.
  *  @timestamp:		interrupt timestamps.
+ *  @fifo:		FIFO management structure.
+ *  @buffer:		data transfer buffer aligned for DMA.
  */
 struct inv_icm42600_state {
 	struct mutex lock;
@@ -164,12 +164,12 @@ struct inv_icm42600_state {
 	struct inv_icm42600_suspended suspended;
 	struct iio_dev *indio_gyro;
 	struct iio_dev *indio_accel;
-	u8 buffer[2] __aligned(IIO_DMA_MINALIGN);
-	struct inv_icm42600_fifo fifo;
 	struct {
 		s64 gyro;
 		s64 accel;
 	} timestamp;
+	struct inv_icm42600_fifo fifo;
+	u8 buffer[2] __aligned(IIO_DMA_MINALIGN);
 };
 
 

-- 
2.49.0



