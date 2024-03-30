Return-Path: <linux-iio+bounces-3954-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2B6892CB6
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 20:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E126DB221CC
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 19:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EB540846;
	Sat, 30 Mar 2024 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5dZrqqO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9D5200D9
	for <linux-iio@vger.kernel.org>; Sat, 30 Mar 2024 19:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711825756; cv=none; b=BO547/XrSWdN3ns1ZAQsQfM3GBNWj34NfMM23eJYJwWSV+JCZQvsZWJzKUdnnJ1OEYJ7QgYf4vC7t4s7wO1Zwxqpqs32EW71c3Loh6f0LDemVzoHafBCR9BfcF2ct5m8wdX7xwjkGMImKiXnik9c3w7Tsy6mVTHwZXRAO0go1XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711825756; c=relaxed/simple;
	bh=9VhaaU0wBIDEiUet4doMfR7XyJ63UDMd34J1DY1qlDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uX/zeljF334Yx3MW0gAYka5ytCiUrZ5Sj3u2g9KuifQNijn4czCWlEZTSCsNnTmPd9jGg0IGCINrYS0d5L0lqBI7ILl+lRuUzrW014sVrMdCtxOhlgADUwlWKcYyLZyMLOFAMrAtblVQ2IJo0qGn61HAYt0adn5GYGOCdzKEBv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5dZrqqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A0DC433C7;
	Sat, 30 Mar 2024 19:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711825756;
	bh=9VhaaU0wBIDEiUet4doMfR7XyJ63UDMd34J1DY1qlDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K5dZrqqOH2aHEJa5T2rinI5eVQPK6Z8E8T+KuSRA1SUMG2xZ2I9dAxKdDr1x4vlLt
	 9Qdo5mp2XjlP2cnA50HzIKCH99wTC5iZUFQVuMbcTyhKV/DuKTsq36CFuVI1Y3NB91
	 JpeemrF4JrVCHxI+erKqH7eDYTQjtWWIAaNBg8IJG0AShfkVFtjJ8Fy10pvvv0rOXK
	 CfoVAYMn8wT4LXUFIqsuIeL9bcpDC8ZD+zk2ZLoWNY99eBcTArrh+YnltC1iWMSZuW
	 QRa8Pl4ftpi6yVY34Ne3MKSAmsMBe7jKvr14hcm372e7odPaARpDGHlylK9+F5iU3O
	 TCVyRVvLY9SMg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Marius Cristea <marius.cristea@microchip.com>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4/8] iio: adc: ad4130: Use device_for_each_child_node_scoped() to simplify error paths.
Date: Sat, 30 Mar 2024 19:08:45 +0000
Message-ID: <20240330190849.1321065-5-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330190849.1321065-1-jic23@kernel.org>
References: <20240330190849.1321065-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This loop definition removes the need for manual releasing of the fwnode_handle
in early exit paths (here an error path) allow simplfication of the code
and reducing the chance of future modificiations not releasing
fwnode_handle correctly.

Cc: Cosmin Tanislav <demonsingur@gmail.com>
Cc: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad4130.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index febb64e67955..aaf1fb0ac447 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -1600,17 +1600,14 @@ static int ad4130_parse_fw_children(struct iio_dev *indio_dev)
 {
 	struct ad4130_state *st = iio_priv(indio_dev);
 	struct device *dev = &st->spi->dev;
-	struct fwnode_handle *child;
 	int ret;
 
 	indio_dev->channels = st->chans;
 
-	device_for_each_child_node(dev, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		ret = ad4130_parse_fw_channel(indio_dev, child);
-		if (ret) {
-			fwnode_handle_put(child);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return 0;
-- 
2.44.0


