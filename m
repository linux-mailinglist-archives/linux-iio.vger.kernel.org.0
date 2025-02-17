Return-Path: <linux-iio+bounces-15697-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A32A3860D
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B76771882D48
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D456221E086;
	Mon, 17 Feb 2025 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCldqZfL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9487D21D587
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801945; cv=none; b=L/Tohdl1gXvSDocMWeENs15luPDv3vxbDwnFRfMib+E8NfBhPCG2kyzAnpd9ru6XWr3VHlznfIfk2JcWrFBhwAq0SC299t7W+s3l25v+XR3XUvrPGz6hItDNC3C0RwoO9sCE+9lwrFRoQucUbOwss+pXU0jE0oLz6mKO1HeG6zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801945; c=relaxed/simple;
	bh=fCC9iFGMkki6NT+sXldWGFWrSpLe479HPYnhAfdQy48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLoxTsdDQqbQ0uMHxNVqw7uHtpsfaGLR6XQSluWTGnUlvf3eiRCPUAp+iv6T2RFmsDArMHJXQC+IpabuxLAJvvX/iU5P3dXFGg9C6u6kNLKnGtqHTan6L+6Hlm9zHvsXk/pRbyX1R1vnK+aZwza/3ggfh2JQ9h53LLzx2XiubVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCldqZfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652CEC4CED1;
	Mon, 17 Feb 2025 14:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801945;
	bh=fCC9iFGMkki6NT+sXldWGFWrSpLe479HPYnhAfdQy48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cCldqZfLlhrn5cO3FChriqQemtp9/BEu5WaDqN2i6UQzvhq3CsiuSZaanhenYF2wa
	 3yp6v8NddarxWtd2hI0eCYDBJG9cVYJZ33FMluKd1tC1nuoRDhcsnVZJSntSC2rMF6
	 IPWANBBzKTEE258Q8fhOl7LbVu4xqssoyiJk5ZYA5XBlvfPVTqoFG61c/6/YpIZ4Ll
	 KHgZ4NpOBm9pFod7prWe+i/0xGVxQVPEDjM3Ddn0Tn+k4W9r6F0tXhFPaeyse/RInc
	 1nv+D+Br9G+LNHiCj2qOvk7AYT92iaWaHrjvfXeVTjk3Z9MagOz2fMOh3Cr5Xz29W1
	 O0ayqp1mVuVxw==
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
Subject: [PATCH 24/29] iio: adc: max1027: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 17 Feb 2025 14:16:24 +0000
Message-ID: <20250217141630.897334-25-jic23@kernel.org>
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
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index e6a47abc862f..7e736e77d8bb 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -378,12 +378,11 @@ static int max1027_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = max1027_read_single_value(indio_dev, chan, val);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
-- 
2.48.1


