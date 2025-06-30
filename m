Return-Path: <linux-iio+bounces-21168-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E23AEE7BD
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 21:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B681BC28D2
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 19:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051A02E6D1D;
	Mon, 30 Jun 2025 19:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSujRayk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDC02620F5;
	Mon, 30 Jun 2025 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751312853; cv=none; b=XEAY4fK8nHMXj1Haylt4QR0H5+eUPqNazwD8Lzrhis2FO+sVmCIYYapfe6On5K8IqjYwFhecgo7SGEsqdWZwdjibUN34mu63h1vkIQfrkZX+2/cct9hUYXMa8HGH1mudC68BRV/gDK5T3u3oDi8RI3NGoh+raSLvzvaWWCROpdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751312853; c=relaxed/simple;
	bh=Znef0FMzuDH6VGHqU8maPmZye7LfwYApNRJslGk1vcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MXmyra6mGKSwJD61IDRz6nsw5n+07Qh8sdVyd9p61lxscTeH9vXebr6jc8j7hnquWDe9xFmsNsRIX3M1pvZBP1q0rAyGKy50XscyljHIdnTx7fMY+StHRkMHKPN6otFCF9lRCOYegs8pMHRhb6XF7vUHg8qOw6ywKeFv9I5BToI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSujRayk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C285C4CEEB;
	Mon, 30 Jun 2025 19:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751312853;
	bh=Znef0FMzuDH6VGHqU8maPmZye7LfwYApNRJslGk1vcM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TSujRayk4lt7UUpvvOEjYUQI3EK9DWcG9uqxJ0vaoZxddZB9WWV71+ZN3MEP/P4IA
	 ggnxiKUCORvGRTanM3RFCaCLotrQrDENvaiD5f8D+So03vmqHWX+TYyoKF5Sa5icg1
	 Q4CcTokKy/bX4kS+zLwR9poChEeTOOnQLT/esWQl1f1woXJy6YWX4mjBS8fZ3TX24K
	 NJ+ManuS8Z67sITQi3Lt4VRA2sNAT9xpeyHkxl3yodycFWIPheJIsg7J2a/g6kvWvf
	 5StV21kL7d8eqwRcZXoaOAVM8NWVgTr19D86VKYk5UmK6NMnJSSUZDA8zbuhqsIKij
	 RAKbah0DiCpuw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCD0C83038;
	Mon, 30 Jun 2025 19:47:33 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Mon, 30 Jun 2025 21:47:29 +0200
Subject: [PATCH v6 1/3] iio: imu: inv_icm42600: reorganize DMA aligned
 buffers in structure
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-losd-3-inv-icm42600-add-wom-support-v6-1-5bb0c84800d9@tdk.com>
References: <20250630-losd-3-inv-icm42600-add-wom-support-v6-0-5bb0c84800d9@tdk.com>
In-Reply-To: <20250630-losd-3-inv-icm42600-add-wom-support-v6-0-5bb0c84800d9@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751312852; l=1893;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=YQ1EdN6AgLVf9Q86CW1l/yLV7rzxsO/ydve8d4dakbQ=;
 b=56aCg+7+DMkAB3t6pw1xCUu+WtUK0aDWIDNsbbmmTy2OrQLK/PU54E4jnNtEz2v1CnMigTrR7
 fikFw1YiY8YAZrNj18CiL94fOGhqdCr1UqjOvxDtN4qOaPfMnQgGKvY
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Move all DMA aligned buffers together at the end of the structure.

1. Timestamp anynomous structure is not used with DMA so it doesn't
belong after __aligned(IIO_DMA_MINALIGN).
2. struct inv_icm42600_fifo contains it's own __aligned(IIO_DMA_MINALIGN)
within it at the end so it should not be after __aligned(IIO_DMA_MINALIGN)
in the outer struct either.
3. Normally 1 would have been considered a bug, but because of the extra
alignment from 2, it actually was OK, but we shouldn't be relying on such
quirks.

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



