Return-Path: <linux-iio+bounces-22586-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6216BB210F4
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 18:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62CF17B88DE
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 16:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1129B296BC1;
	Mon, 11 Aug 2025 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moC1WH2g"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66FE296BB5
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927710; cv=none; b=Yw3eCfu4+WCYJFDeeSnnHyjIdrY4IDMlFDeCenHPG0Nrhj3e3bwIr8G2ajn2A4hLOBZhKoAhxifYiEegp2jL2EJ9RNBIUUmLwhx9ctmPtybkuil8BAjtdQxFZnTmosC2tf3fCZmIRXon56t2cgEEXH3lyjkjiArjAp1bKEr6Qho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927710; c=relaxed/simple;
	bh=I8Wwydq4G2+1UIssFwQlnSiZ7/G1SL0KuwbCbXd6gUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3pIAb9VV+7WUF+qw2jFzLnZale0O8kHn/I619N9Ia1iR8VLYb3CSI7/WJJMCxpO4fHg7cpD7FPX2CRxutI7fv0KA5BNPcLLoGfr+a2BL3QDgHNTAZMWm0nYTYtOPVzYhEB8wmVYpzIuY2AmS8CvUWgMEZdvWls0uHevk9UzPBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moC1WH2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4826C4CEF5;
	Mon, 11 Aug 2025 15:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754927710;
	bh=I8Wwydq4G2+1UIssFwQlnSiZ7/G1SL0KuwbCbXd6gUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=moC1WH2gCgzzjfQWIShVDuTk5PQ6MwLK34GwCyO0ISVpdUPeZJJHnV5PrjmbLFwD0
	 wsOnnqkfVT5K7Xk10qgXCUSfFu2II2qCxBE74vE5AKpyTAvf38KLl59ICtZeU9e4Qx
	 9KRYEMQw0lUrsRHrXsgGGc2dmzkL9clElyiy/Vq44lo7CeQeJUtvUFXA218K9hBOXT
	 AFvKLI2WMRTeN8PxPMNr543SqFUQNMDTAHrKA0yK5/dyPKx/BJJvq40Ks7jF/Dy3HD
	 W55jHODV836eBoD/tsXrEWLN9K80czFwe1nUy/ccHFsYBMyeNgrFSov18RBc2qPDgd
	 5HLrYCssJB+mA==
From: Hans de Goede <hansg@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Liam Beguin <liambeguin@gmail.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH v4 4/6] iio: Improve iio_read_channel_processed_scale() precision
Date: Mon, 11 Aug 2025 17:54:51 +0200
Message-ID: <20250811155453.31525-5-hansg@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811155453.31525-1-hansg@kernel.org>
References: <20250811155453.31525-1-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before this change iio_read_channel_processed_scale() always assumes that
channels which advertise IIO_CHAN_INFO_PROCESSED capability return
IIO_VAL_INT on success.

Ignoring any fractional values from drivers which return
IIO_VAL_INT_PLUS_MICRO / IIO_VAL_INT_PLUS_NANO. These fractional values
might become non fractional after scaling so these should be taken into
account for better precision.

Use the new iio_multiply_value() helper to do proper scaling taking
the fractionional values into account.

Signed-off-by: Hans de Goede <hansg@kernel.org>
---
Changes in v4:
- Use the new iio_multiply_value() helper
---
 drivers/iio/inkern.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index af1da729d18e..2a1ecef2b820 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -722,20 +722,19 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
 				     unsigned int scale)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
-	int ret;
+	int ret, val2;
 
 	guard(mutex)(&iio_dev_opaque->info_exist_lock);
 	if (!chan->indio_dev->info)
 		return -ENODEV;
 
 	if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_PROCESSED)) {
-		ret = iio_channel_read(chan, val, NULL,
+		ret = iio_channel_read(chan, val, &val2,
 				       IIO_CHAN_INFO_PROCESSED);
 		if (ret < 0)
 			return ret;
-		*val *= scale;
 
-		return ret;
+		return iio_multiply_value(val, scale, ret, *val, val2);
 	} else {
 		ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
 		if (ret < 0)
-- 
2.49.0


