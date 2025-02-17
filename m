Return-Path: <linux-iio+bounces-15692-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B65BA38628
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A87D176862
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2394224888;
	Mon, 17 Feb 2025 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5ZWdySt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F702236EE
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801916; cv=none; b=EobezNOqREMrC+E9Z0mZsUdkwD1L+Bjvd5UqW+cLoMNMmQqoUSSuWn1ZgJSW6ehsM0JCEgvMk7s1wk3TVK6lDAmF5wbBWtDuweGnawPTKXdAVfqV6i9oeJJdNZAlXkLHwy5xQBaV8l/W3+CTacIetgWfMDihVxIOuyNL8HCviDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801916; c=relaxed/simple;
	bh=PXkGrB7pjweVW+JqhE+z9Vkn8g6SlqX94PRziIFvEjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWs2S3+UWmqbPbe4/nG884yAZ5rFaTCfGbMGAG07TgbJh288lcrpd+l4aCDylM6DyqjdPhUVIyU+YWNmNfLU/Apk2nIo7lnZwHZ6n/174YUBRLGWllZYxOzekPaV7euLQii6hFXnukF4zBdHpeknl3MUXOiitPCHKvlc8oqplCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5ZWdySt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6A7C4CED1;
	Mon, 17 Feb 2025 14:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801916;
	bh=PXkGrB7pjweVW+JqhE+z9Vkn8g6SlqX94PRziIFvEjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u5ZWdyStmhKOtEN9bckyqtomzj7l7AEDDHF3jbVb4FQC1VXXlL3I6y6idJ/M5mK9r
	 BcqLAZqqCiamYD4rbV96Q3ir+54fV/QPrkdttohYf7iHDLvwnfkdM+dLnRbXpldyDA
	 wxpMB2YSLH1ftwYY2hZzaGmc3S2Ou3iBeNgPFzIJPUyMDrPJ/rsykZpT2NYIJZ1PId
	 IApK/s6xAF4f5lTFWL3H89iRe5J1RLTdzVjSd8PIxKIPgNfV0pzeVOSQit6IhwZgN1
	 g1qNzX5feI286+MNz1NIgBLfEUs2zA3+wt7N15tL/6QIioqK6uXw6NKJSU4Ns4ZAwF
	 T1HUU5H7ASunQ==
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
Subject: [PATCH 19/29] iio: adc: ad799x: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 17 Feb 2025 14:16:19 +0000
Message-ID: <20250217141630.897334-20-jic23@kernel.org>
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
Kept this one out of the 'simple' category as it is worth considering
factoring out the code when the claim on direct mode is held. I think
it isn't quite complex enough to make that useful but if others disagree
I can do so.
---
 drivers/iio/adc/ad799x.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index aa44b4e2542b..993f4651b73a 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -291,13 +291,12 @@ static int ad799x_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		mutex_lock(&st->lock);
 		ret = ad799x_scan_direct(st, chan->scan_index);
 		mutex_unlock(&st->lock);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 
 		if (ret < 0)
 			return ret;
@@ -411,9 +410,8 @@ static int ad799x_write_event_config(struct iio_dev *indio_dev,
 	struct ad799x_state *st = iio_priv(indio_dev);
 	int ret;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	mutex_lock(&st->lock);
 
@@ -429,7 +427,7 @@ static int ad799x_write_event_config(struct iio_dev *indio_dev,
 
 	ret = ad799x_write_config(st, st->config);
 	mutex_unlock(&st->lock);
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 	return ret;
 }
 
-- 
2.48.1


