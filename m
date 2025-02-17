Return-Path: <linux-iio+bounces-15687-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8715BA3861C
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C80F164CAC
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258AF22370C;
	Mon, 17 Feb 2025 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqNqJgxm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84EF2206AA
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801892; cv=none; b=Nk8IArj6uy1PfwWAbVvp7fWQ+7MpJWfC8vEuBS8XrHt6k3iXvZhXvAu5h46dZXXpf2duQ9NnvD4lGHlL5svHNV75Db/jDWrrXHQC1ofN5hVPPHxSuQF6B8066GeGKtop6n6r8etEg0ferAvmwc2azrJRidOcKvAkN0oLJBkIUjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801892; c=relaxed/simple;
	bh=V/UozWdSXxTY+UKLtlabaLKmFIIJyiKmzYb3lz6yCes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYIPiy12E0BUuJvMdS07TlutSAcCs33VDkKfkw/BAIVjXcQ0rZKcORhP4oj+dqQnojDoPscHZaiCAr5t2UapPYXIb23Z2yrxM1pcvjE6pd2CxbUPJrSFYMspwu/DvBhQDgsxt3YEKC1kNjmO9R5U1PJL9uyhS4+AnCN0Y+/xlKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqNqJgxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E35BC4CED1;
	Mon, 17 Feb 2025 14:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801892;
	bh=V/UozWdSXxTY+UKLtlabaLKmFIIJyiKmzYb3lz6yCes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gqNqJgxmL/5fbBp6NG2ZXOLDBQnTq5Mi2hJvh34vdmdWp23xPFLK7TWbMuYtvCMHy
	 +aT8J5qXS1CGn3kN505ofKMvdzoFAqiHwyE43vLq+TthBVjR0DIH85kQTgbC4WrsD5
	 8N1mO1M0e8yvmv2HZMHGKXYXwxbgwa93/6lPz7oILZahJ3jRnbbODXpyXfHRdPA3j0
	 TO1MGpz8rdzflu8VQoBDCYG5qHjmTAIOIcM97uxofumkPFolqhye2e1nNcH9dCnQrg
	 b1a7jEaEJYY+4J+pIPnB0rSVr1PY0l/oGIdnikgmWKsjih+1jPwPe93xYAx94DPNDi
	 17ZfkzY1ychdg==
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
Subject: [PATCH 15/29] iio: adc: ad7791: Factor out core of ad7791_write_raw() to simplify error handling
Date: Mon, 17 Feb 2025 14:16:15 +0000
Message-ID: <20250217141630.897334-16-jic23@kernel.org>
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

Factor out everything under the direct mode claim allowing direct returns
in error paths.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7791.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index 76118fe22db8..e49d4843f304 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -310,15 +310,11 @@ static int ad7791_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-static int ad7791_write_raw(struct iio_dev *indio_dev,
+static int __ad7791_write_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int val, int val2, long mask)
 {
 	struct ad7791_state *st = iio_priv(indio_dev);
-	int ret, i;
-
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	int i;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -328,20 +324,30 @@ static int ad7791_write_raw(struct iio_dev *indio_dev,
 				break;
 		}
 
-		if (i == ARRAY_SIZE(ad7791_sample_freq_avail)) {
-			ret = -EINVAL;
-			break;
-		}
+		if (i == ARRAY_SIZE(ad7791_sample_freq_avail))
+			return -EINVAL;
 
 		st->filter &= ~AD7791_FILTER_RATE_MASK;
 		st->filter |= i;
 		ad_sd_write_reg(&st->sd, AD7791_REG_FILTER,
 				sizeof(st->filter),
 				st->filter);
-		break;
+		return 0;
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
+}
+
+static int ad7791_write_raw(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *chan, int val, int val2, long mask)
+{
+	int ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = __ad7791_write_raw(indio_dev, chan, val, val2, mask);
 
 	iio_device_release_direct_mode(indio_dev);
 	return ret;
-- 
2.48.1


