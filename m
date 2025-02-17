Return-Path: <linux-iio+bounces-15676-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AABA38620
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584B13B8D8F
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E694122068E;
	Mon, 17 Feb 2025 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdTpzXsH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912BA21D5BD
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801830; cv=none; b=WrHvCo9FLJfzoU8fxd9BTyJ1KpRRFN4iwCzpftF8O5IsOsmyEVTyj2HU6qSap/XKcAk98tA9EtCs4uQkD1Vcsblna+quF0LlRRPO9ktiiDgDHIV4SJBKbMRD4gOqESTCcJpSm8PV20SttJuFYr+Q0+NoW4J0+SjU5MWG3zl8JDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801830; c=relaxed/simple;
	bh=atNVxPelO0EvIhapjy+GuilNReWE4gyI3jWjGSwFQSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRMMe62PeksFBvJQUYGreEEBbSHCt/VycBOjuq8sXLqkJ+5PsFIfwVbpPwSz5NebVUDLBfW8KTldKnEYpyiDOZFAQjMQC/bApi0rAgUfjY4C4+Uqdo2VPr1TdFzVDur6R4Wez+olze3f7GF2D1qnNp92uhAZU7cZen9AxZruzoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdTpzXsH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1D5C4CEE7;
	Mon, 17 Feb 2025 14:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801830;
	bh=atNVxPelO0EvIhapjy+GuilNReWE4gyI3jWjGSwFQSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UdTpzXsHTSPm/K/Q+2sAWqhN1MhNH10sWFam0OAnprq+dym+6B/bN5wbMv/jKFn6U
	 JdRXe8BkJyDm9yKRqVMTjvR22HANmICkvphD7rGMfRifAtt4VS2S0S0KxR8Qs6q2AU
	 fgpStg2KnpqNNN7ZHXMTjN1lRgcUmdTmMlxddaxoyDNiO4jP9Waw3IUzrHaKh4N1D5
	 ZYFdixEaxsmWCldlcLqLBaa3ADbLC5DSgVLIGOGahgt7CHj4Hbcq9W4WPAhK89nEX2
	 enV0KPdU1KdCBEOr2Ehpo7t31lw+Q8D312aLFp+2JaLmJH2jjRF5EvhOYGz7FupPdo
	 uePxOiYyuggZw==
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
Subject: [PATCH 04/29] iio: adc: ti-ads1100: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 17 Feb 2025 14:16:04 +0000
Message-ID: <20250217141630.897334-5-jic23@kernel.org>
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
Cc: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/iio/adc/ti-ads1100.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
index 0519f8afb033..b0790e300b18 100644
--- a/drivers/iio/adc/ti-ads1100.c
+++ b/drivers/iio/adc/ti-ads1100.c
@@ -223,12 +223,11 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
 	guard(mutex)(&data->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = ads1100_get_adc_result(data, chan->address, val);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 
-- 
2.48.1


