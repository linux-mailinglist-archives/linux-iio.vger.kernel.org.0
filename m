Return-Path: <linux-iio+bounces-15017-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D208A27C6C
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 21:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE703A3A94
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A172063F9;
	Tue,  4 Feb 2025 20:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDTO68TT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5227C2063FD
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 20:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699497; cv=none; b=C9HWNQZg75bhgytAEttOX7+7EDQjTem1LzO4yONOA2TM4XUnD6WQ9RCCoWXW1G1T5R1I66EePztboeotetlJlxW76ZibYTbHUIMKGrfNp05bIAO7MaJPUXOYoM/LpKLY+TyjsJSsgw2IptLsZSNm/oVRYJeIlLGvNQKZhXVMWr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699497; c=relaxed/simple;
	bh=IqM7rr8s7Lgno6Y5qG0cYwimP4qr7aOPjOp483MBSbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNrez/BYERctFGHEOnUSj5QuxhtgyEIgB/pnC+7IR25PNqW4u+av7nr6jap4xgEAXZNJMBouSkz2fjpxsmkojdUHrmBzMUlncbxfp1eEUP8zRSNp2HJyucnyhQyrhZJ17+/nuIZDRrokAtAuJG+YfdJhAFjf6EY66u7xd1NUrW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDTO68TT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611DCC4CEE3;
	Tue,  4 Feb 2025 20:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699497;
	bh=IqM7rr8s7Lgno6Y5qG0cYwimP4qr7aOPjOp483MBSbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WDTO68TTVeSwAUYIat9Gx+j+E4zU7B+JF2cyvPUhImo65OC7BTTdk9sIDuLW36pUd
	 VtR1oBDmEzhlWQVZW51QmH23dqRAYxV92+aWDGIb77TluzIIy4pj+BwGM0b9D4OuTu
	 QUhor2VBFtoXTi/JH2IXpiCMec+wCRwzT0ktlDQpCoUweWuc7Xz1mj8R9NgxZKydxN
	 7begCqIJgilbyS4dfBq6hVKGMRhUZbrGkysm1wrIKEG607WdaNJC1djlO/31qb69bk
	 8wlqSq3gaPIacM+8Yq/x7SzS09ebGBzkfuF1IZjRbqG7PCm5+d29SF0oMB3I6GZJET
	 9oKPzDQDHDO/Q==
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
Subject: [PATCH 23/27] iio: dac: ad8460: Stop using iio_device_claim_direct_scoped()
Date: Tue,  4 Feb 2025 20:02:45 +0000
Message-ID: <20250204200250.636721-24-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204200250.636721-1-jic23@kernel.org>
References: <20250204200250.636721-1-jic23@kernel.org>
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

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mariel Tinaco <Mariel.Tinaco@analog.com>
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


