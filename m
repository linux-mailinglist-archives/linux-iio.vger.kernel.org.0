Return-Path: <linux-iio+bounces-15685-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DB6A38617
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0F4F175480
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BA52253E2;
	Mon, 17 Feb 2025 14:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ib40oP+h"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B5B223328
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801882; cv=none; b=oS+4mmtTFrealuYAjzL97ILY8CCzNQMtCTQvxW7t7Y6avMghhapMkP2VnETIjyNA58OCyR+rfJv65kX3UDR+bJ5hc3JOsui+JqE0DF63pNhx6mUrPIoTn8FAXJsgHVxasx3Z+/u4KqmOei77ZdKzWnyA3zKs3SiDK66Y+kko5Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801882; c=relaxed/simple;
	bh=Qsq488fVzfGtDIoOZcTgs0Xq1jPI+2vxNId8rdyvfkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=caIMpSkdtKddoO+s87HIHSxIw4DnJqFKKneE+yfVQx3bWY8fRJDgsXes4KSnnWag9HIJCq1EvsLnxZebXsOi6yNDr/WC/ySHP5c5QVQ0yEjOEySMIvYMRKuZ8VGj3UbO5bDslrPxfnnytxpierX75ucTuKIcIrUV5pctemw+gJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ib40oP+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0572DC4CED1;
	Mon, 17 Feb 2025 14:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801881;
	bh=Qsq488fVzfGtDIoOZcTgs0Xq1jPI+2vxNId8rdyvfkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ib40oP+hLtrnKxfnCkSJYV15P9UR8f02bzwvpojxdCXdJkYeN/ZMqapWQ6qWt2syt
	 V1Ebvx7q5JzoGlbz3sDQEKc6xi6owDfLkqDovgO4wx7pkOksL4h2VzLkvmLgVMYbSJ
	 MJ2Wew97r0YckE4RZR7kgROGerIYNvol8cC8fxsRbLA1y1DHpCC2rrudsuuTaRkCCU
	 EaT3hZ2giuAjy+Mf2iqmMzjjyYbmrlleQIGKc+SE2KOEh/4OKD/d5KVlL6DVnilC+q
	 4LQyfYljTPukEx4zCwhUIm96TGOVKTaxhhrsxDjsW+q91IEjyXoss5yOFkpU3KAb9G
	 0Ny4dbmBvjJZg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Phil Reid <preid@electromag.com.au>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Marek Vasut <marex@denx.de>,
	Frank Li <Frank.Li@nxp.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 13/29] iio: adc: ad7768-1: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 17 Feb 2025 14:16:13 +0000
Message-ID: <20250217141630.897334-14-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217141630.897334-1-jic23@kernel.org>
References: <20250217141630.897334-1-jic23@kernel.org>
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
 drivers/iio/adc/ad7768-1.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index c2ba357b82d8..ea829c51e80b 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -365,13 +365,12 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = ad7768_scan_direct(indio_dev);
 
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 		*val = ret;
-- 
2.48.1


