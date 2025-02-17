Return-Path: <linux-iio+bounces-15674-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4D9A38615
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA613B8358
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09B521D59D;
	Mon, 17 Feb 2025 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g29tAkmF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BC821D584
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801818; cv=none; b=ZjHlCkDfm8FMEAUyLrUaD4iWphRQuUuYU+iEvERf92LFYvbI8ek9gZhdifoK6T4ibFLdgY0S/m6Rm6bth129mPReZAMQxWsCU0SF7cAj5m61NTR1Y/mt4LpleS1oC+ksvbsz/7SyhhIWyQqaPupSWJoYXjM2AjgqEdfOTRuUuYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801818; c=relaxed/simple;
	bh=l3WF6slEFDi3bYBwHNVkyg4aE7Hpurgm02kHmpzlF/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNJDASewFDuJVILOON78pQeZH+4cr1GdwU6V61gYRbFR/JakYEYNCuGO/Z+YMKvk3eeWCkNaPMX3PSQ+vu0xA3IBDIewdM/Pz5pXAKr0AFH27E04FMcOJXxHNvzY4yLMso2nIfGaZbiLa38mnzXf3Z6ePuq/sWXCQmgLcF5D5r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g29tAkmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E29C4CED1;
	Mon, 17 Feb 2025 14:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801818;
	bh=l3WF6slEFDi3bYBwHNVkyg4aE7Hpurgm02kHmpzlF/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g29tAkmFoWqTNXjocuL1Dyj+0z/d2s8VQiBRJHEnmX3pb+dtmGAVCjoal3OlqFyyw
	 +Vz1Tq7chGY7lz/GYi2NudpRNJlKasfYNvxQs3YIu76RnVhnHvTY/9FbXuMRts8Gc3
	 tf7scvEOVU2PsM10W2WuXxaVaxRnm0q8O29kOD1Ax19vPehvWus1s7IeXKLaLPQX/n
	 8Gba6vbmeE32+Ut/elAiW7qgrpZRfz5o/Ghg0CJOI9EiHuyKwSgPKtGxmhjAHyC1aP
	 uUA19q0TVLyNnRNNkjOIj2aIP+9dIKXWxQ1WZwNQAHKYXzCM3N4FCYSKvsCCOoW1eZ
	 aIn4Qp0YJ4img==
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
Subject: [PATCH 02/29] iio: adc: vf610: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 17 Feb 2025 14:16:02 +0000
Message-ID: <20250217141630.897334-3-jic23@kernel.org>
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
Cc: Frank Li <Frank.Li@nxp.com>
---
 drivers/iio/adc/vf610_adc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 57a22e31cfc7..f506ca4150b1 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -681,11 +681,10 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 	case IIO_CHAN_INFO_PROCESSED:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		ret = vf610_read_sample(info, chan, val);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 
-- 
2.48.1


