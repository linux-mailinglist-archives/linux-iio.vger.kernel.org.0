Return-Path: <linux-iio+bounces-15216-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E704FA2DFD7
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 19:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449E518844C2
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 18:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BF21E1A28;
	Sun,  9 Feb 2025 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejoSWlTm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E851E0E13
	for <linux-iio@vger.kernel.org>; Sun,  9 Feb 2025 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124573; cv=none; b=GAdggfrAC7XHyFCA4Na3wo2JuLxyVWHTWvYuMjdthDq7QDy8DaEJ58V47aNFOCI3u/xVre4PLw/lpgaFHkRsAhvnAKKqlyHaKS9g3uSopHvurN44eNsJeB4PL62++l+djrNtkSisaYSF0ESF56piVtaCSAts3AF71/HUU/wELIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124573; c=relaxed/simple;
	bh=HbzHUSWGqEwHmxnERyrztbXeNCSzu/58kFPxC6FdP3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qootLo/TYfVZkycMPyvAIYs5c8ZBkug6Jp70qh6CPVvGQl5BTx/00gqWG7kf8xr/qe/GOfM+jocOh3OyWDsQ+WKUxas7LXP2ZXSz7orrSUd1i70dc2arunzH49BVORH5IoyUlE8ECt5wq8wqyYPesBl+uH3/aQBThsHse63Wvg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejoSWlTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AFFC4CEDD;
	Sun,  9 Feb 2025 18:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739124573;
	bh=HbzHUSWGqEwHmxnERyrztbXeNCSzu/58kFPxC6FdP3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ejoSWlTmb16BpEbWlC96Nl6LbL4n+p57IRL2r0GspjXKsy5bJ22XT8JhmSsaGIJsZ
	 UVElIhKNMXR8Hex2Kj1Cs3AdtLV6NHzYre4+YqVdk38+MOAkbd/nrySKxrHzvK76iM
	 H3HdbARkyQF0LLYMQD1CAx+3zVlGGfoASfiyvwEOGbAkgjeAsqgxRCzVpN1xKZdqZc
	 /UQkW8dn3Zn/4iGbfouS8WTAjVQMdqP0MoXvWFdq1BdA913ay0kZMngT96Ag1Jlj6H
	 ZGCPbh0mZCXaftqEoC7YZ0UkS/GnOSJSdissoqBfMfp6DbeiQw9rIYxeLZrqHIlO09
	 phTntwqSg4l1A==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Mariel Tinaco <Mariel.Tinaco@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Guillaume Stols <gstols@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Antoni Pokusinski <apokusinski01@gmail.com>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 23/27] iio: dac: ad8460: Stop using iio_device_claim_direct_scoped()
Date: Sun,  9 Feb 2025 18:06:20 +0000
Message-ID: <20250209180624.701140-24-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209180624.701140-1-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This complex cleanup.h use case of conditional guards has proved
to be more trouble that it is worth in terms of false positive compiler
warnings and hard to read code.

Move directly to the new claim/release_direct() that allow sparse
to check for unbalanced context.

Cc: Mariel Tinaco <Mariel.Tinaco@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/ad8460.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad8460.c b/drivers/iio/dac/ad8460.c
index 535ee3105af6..6e45686902dd 100644
--- a/drivers/iio/dac/ad8460.c
+++ b/drivers/iio/dac/ad8460.c
@@ -264,9 +264,12 @@ static ssize_t ad8460_write_toggle_en(struct iio_dev *indio_dev, uintptr_t priva
 	if (ret)
 		return ret;
 
-	iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
-		return ad8460_enable_apg_mode(state, toggle_en);
-	unreachable();
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = ad8460_enable_apg_mode(state, toggle_en);
+	iio_device_release_direct(indio_dev);
+	return ret;
 }
 
 static ssize_t ad8460_read_powerdown(struct iio_dev *indio_dev, uintptr_t private,
@@ -421,14 +424,17 @@ static int ad8460_write_raw(struct iio_dev *indio_dev,
 			    long mask)
 {
 	struct ad8460_state *state = iio_priv(indio_dev);
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
-			iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
-				return ad8460_set_sample(state, val);
-			unreachable();
+			if (!iio_device_claim_direct(indio_dev))
+				return -EBUSY;
+			ret = ad8460_set_sample(state, val);
+			iio_device_release_direct(indio_dev);
+			return ret;
 		case IIO_CURRENT:
 			return regmap_write(state->regmap, AD8460_CTRL_REG(0x04),
 					    FIELD_PREP(AD8460_QUIESCENT_CURRENT_MSK, val));
-- 
2.48.1


