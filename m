Return-Path: <linux-iio+bounces-16620-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 730C8A58608
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4BDC16A1F6
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705751E3DD7;
	Sun,  9 Mar 2025 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmJtJGg1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318B04A0C
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741540063; cv=none; b=uxdICik4OkfUhEPJBTBb9Aph9kAmr7qQTQPWHLlT5q4HcUZV4OYAFzLK98iqNl7WYfBbMn4nzLM7vcyolDD+UbNkUlF3uYkokD1TMNLeKqkRnN2SBZ/JW8AWb7NV8BzNsZOx9/Xo9I59BJlvMANp5WbFcZFZGsK3I/Lkw45wcbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741540063; c=relaxed/simple;
	bh=q/WOeOTozqRxHaulDQUhhgJ0UWNfW1YcPOazerXbKjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9LmCxxssYCdFpLPAUyHHm7xtBUzbEgLmOfUkVnQX7HtW4D06HeYchPr74bENjP3jJ5r800daoF4Jh2cOtwqM/SGgSVITM9yXrxRENIFZhBDzqmy8kC9dp70dTApr+TM8zpBwUTaR808EWSRn2Jo2mEcJyaDcByDzvn5x+LM0j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmJtJGg1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C853C4CEE5;
	Sun,  9 Mar 2025 17:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741540063;
	bh=q/WOeOTozqRxHaulDQUhhgJ0UWNfW1YcPOazerXbKjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CmJtJGg1iPn/d3uk7kII1ZqwR98EreMDrNKWib7l8iuiMrQpzjDYiXkdLzr1jnDlc
	 ODguq1fyoFlmSaEDkX2FxpBdgDM7BgnDLzD1WqYyncg5xezO0k3IYHWr0JEiC74aqt
	 XG4zsFdjZWLl0EX8+F9KNCvBpybaLMLQ9/9SbxRWv3KT6PtMe6j+d5BCCUv1fICj+/
	 ml0RkJk7yqvYdVOXeZznISkKp16e35e6JXeWeOW1XH1cQoRKTTs9LHWx/tF2jm6VpF
	 1KqNyOh/ZIwM81A4JJ29nxnQR50WaTc+AnTJHDZkx+cQVQ0V9xr+zc7VacuUrOR3xr
	 tatrLtLXyDrXA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Astrid Rost <astrid.rost@axis.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 14/18] iio: light: st_uvis25: Switch to sparse friendly iio_device_claim/release_direct()
Date: Sun,  9 Mar 2025 17:06:29 +0000
Message-ID: <20250309170633.1347476-15-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309170633.1347476-1-jic23@kernel.org>
References: <20250309170633.1347476-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These new functions allow sparse to find failures to release
direct mode reducing chances of bugs over the claim_direct_mode()
functions that are deprecated.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/st_uvis25_core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
index 40a810000df0..124a8f9204a9 100644
--- a/drivers/iio/light/st_uvis25_core.c
+++ b/drivers/iio/light/st_uvis25_core.c
@@ -117,9 +117,8 @@ static int st_uvis25_read_raw(struct iio_dev *iio_dev,
 {
 	int ret;
 
-	ret = iio_device_claim_direct_mode(iio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(iio_dev))
+		return -EBUSY;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED: {
@@ -144,7 +143,7 @@ static int st_uvis25_read_raw(struct iio_dev *iio_dev,
 		break;
 	}
 
-	iio_device_release_direct_mode(iio_dev);
+	iio_device_release_direct(iio_dev);
 
 	return ret;
 }
-- 
2.48.1


