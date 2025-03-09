Return-Path: <linux-iio+bounces-16599-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1426FA585EC
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17331883203
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 16:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA041DF731;
	Sun,  9 Mar 2025 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+7mG3MX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D1A748F
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741539526; cv=none; b=NFsEkxRi1sVjECnki9Tf6fAcjBPru3u2eTsw8PTrEy7BpNqL4TW73e10pRcj33S+R7ONBR3LJBdS+19hRKVdTY9SRDddgwTt7l56XNSFjkHKHpIhft3hn0qIMing9l4I/X74jfuevKB3BSV38zMUAsCHfs1Oqcl9bQ84cskH7uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741539526; c=relaxed/simple;
	bh=l3WF6slEFDi3bYBwHNVkyg4aE7Hpurgm02kHmpzlF/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhNMjTSghy06EDXNMMazq921NKi5x9J+n1a3lTebkkKiGsU3+pZ6Khc6qe6RNHOuv/LVrJELigN+ghyIWsc356xnT+udOJQci2ACDPR8PqYGC43T8VLYxlrHcjOu/Y2xOqfGUTHk1oZ6h8RcCGAiz4QJhOXqYEgIkbI9/KxUW4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+7mG3MX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50941C4CEE3;
	Sun,  9 Mar 2025 16:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741539525;
	bh=l3WF6slEFDi3bYBwHNVkyg4aE7Hpurgm02kHmpzlF/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j+7mG3MXCNeKKt5wQADg9Z44UdyAJqeqRjNK+DwuL4ODIBZtfCqmXEiNAxe73Yk/3
	 33P1gDeP3rx81NV3s3/V37lj1cD7hSaonDGO8v3eAUR3gjOkd9+P7lMj4ZewuV3B1M
	 fCxDFD+yD8L82PfA/oZsI8YkkQudjR3/Rc1/ylFtufAU0BJ+PzSU/nqhr5FqCseOfe
	 7oe8CNQIpGQjz0tSgRv7szGPC0MIhszRoJlyTYX4pEx9laj4oDLKVXsoDhLYNNB5Ut
	 1uG2esfFg0Wx2VjUWhTa8Q0qvZ2zoyv7R6Bmc29nbyNux06w3caqI3o97slAntxPfK
	 pDYX452S8FyTw==
From: Jonathan Cameron <jic23@kernel.org>
To: Frank Li <Frank.Li@nxp.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>
Cc: Marek Vasut <marex@denx.de>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 2/8] iio: adc: vf610: Switch to sparse friendly iio_device_claim/release_direct()
Date: Sun,  9 Mar 2025 16:58:13 +0000
Message-ID: <20250309165819.1346684-3-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309165819.1346684-1-jic23@kernel.org>
References: <20250309165819.1346684-1-jic23@kernel.org>
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


