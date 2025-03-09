Return-Path: <linux-iio+bounces-16618-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16311A58606
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3A8188C372
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6141DE3C7;
	Sun,  9 Mar 2025 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wi7wGlzG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCD81E1DF3
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741540054; cv=none; b=CHXFU5vAYWAi1SlMoJXote+FKTHull0nTv1TEuDmw2/pOb+wh1/uli109JK9FAY9SIFDBLMlRt2Ig9GVItScMUcsjDdGtQWOhWVVyqgMydMum/g+68R/rxTEmnAdwTycfzxsADTpakIPrUAyj4vVvF0nmYGmA0XejhimpHnhrM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741540054; c=relaxed/simple;
	bh=ykkmCnO2Bvce590xfznrM2tNQdHgae6iWO5sl4XBdqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEGJMutMb1g4Q0esDbYvdpfArbIi1K23+sPz1TGdcZNGRBCbvJgsqHCi+Ios0VWSD9v1VlOCQPYuvBZgGTu8mgRNJbH/gi0KnBC2bmyWG83sfYjoGIvnxg2oYm4Uxfmn3JeY5on+G6CHglPHJJIkPrqDMd6go6DYnLzga36pxwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wi7wGlzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44EFC4CEE3;
	Sun,  9 Mar 2025 17:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741540053;
	bh=ykkmCnO2Bvce590xfznrM2tNQdHgae6iWO5sl4XBdqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wi7wGlzGOlCT8GYJ6FlfzlA9yQst4a5a4XUfjzhw4eGu0o2Q+/1EeBZrUTOJYbLoh
	 pClqc+frp4uzhjfC9NqDqSxMFYpydDOJEPc8ZA8pvm9jA/OJcCpNc+7lFJOPyJJp/O
	 af1zABC1UamdtL2amnLW+XJxqD7WkBC6TtK/Fr+H7IktS7vElWVOKIYhqq58Zh9FIf
	 HGAFhX/lyDVmqeci0w/fiqBt2XV/H/5KsVTr9HMJeq4d7pzb6bf90TiMvBzopUCqY3
	 Bx9vBmaoH+mOD1JkxVOdP8ZoYxYGiUwMtCx27cYYIQSTmsBs1upHtIHnvnLhZBzlYS
	 jpfGDEZWktgSQ==
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
Subject: [PATCH 12/18] iio: light: rpr0521: Switch to sparse friendly iio_device_claim/release_direct()
Date: Sun,  9 Mar 2025 17:06:27 +0000
Message-ID: <20250309170633.1347476-13-jic23@kernel.org>
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
 drivers/iio/light/rpr0521.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 65c60a1d2f0b..92e7552f3e39 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -743,19 +743,17 @@ static int rpr0521_read_raw(struct iio_dev *indio_dev,
 {
 	struct rpr0521_data *data = iio_priv(indio_dev);
 	int ret;
-	int busy;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		if (chan->type != IIO_INTENSITY && chan->type != IIO_PROXIMITY)
 			return -EINVAL;
 
-		busy = iio_device_claim_direct_mode(indio_dev);
-		if (busy)
+		if (!iio_device_claim_direct(indio_dev))
 			return -EBUSY;
 
 		ret = rpr0521_read_info_raw(data, chan, val);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 
-- 
2.48.1


