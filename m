Return-Path: <linux-iio+bounces-15688-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80743A3863F
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F88D3B9DA3
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DA9221DBB;
	Mon, 17 Feb 2025 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suX8eyQF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B084F212FA2
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801898; cv=none; b=CAz+0JwFW0T+Ojex7ZdzZxSJP6746jhGN3BP/r4EeIySukhIHq2qUXsyvInn3q76hUqRqgFgabVuhHSWT7VZMxQ3umcZJ3mYW8YUSKs9Ocus8+mSeLeyO6E1WzeIeqFuhHBcACCWm/EWrNTxQgv30xG6qktbvZ9qOpwGj1dsn0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801898; c=relaxed/simple;
	bh=1yEomtg6oBxzCHG66zqOM326+VwxXT61IFBovqibR4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drhO+zod/CrmhdsQ9nNqLnT10STyIEbASs3ojWTdSJJZzVxmcLFp2KmBi1KzGIMRVe3LaHEQMEBIM2KFxZV59CPJlUS33p7NMCWGANROPBDPmjn6SJs3iQT5CsaxQ4DAlC9outP4GGCal6WGwxpQyhBm7DXR4e7Z2VWjnJTYPP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suX8eyQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D592C4CED1;
	Mon, 17 Feb 2025 14:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801898;
	bh=1yEomtg6oBxzCHG66zqOM326+VwxXT61IFBovqibR4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=suX8eyQFtoA1+Yfbl/xm/yJ2W4H55OZ6GKd2RHu77w83q+R3cTaYRFjVt2TkeXqOU
	 S1ZUhnLaVzeGj6AuQA/nZtjVD6gyzYDgD5+kad9v77Gc5R83Xv4IlnUf5enJ9ctzbu
	 q5zCamlwCRFcsY9+gvfE6ukNMvzt+WKqMib53jBU8p/eA8vQNs15fZvXNyQnCJ1sFQ
	 LfYg3JpyJYQCbEecurzNFNjNrd77I+DfmYgfbVjk2gCBikf1cz2rFR4WQzxv/6brhb
	 lDjS617CcDBRBv1KrqYONofTls6BFVEGGWvSqg2iV8hFf9dwyvd9oM5w/77hxgiev5
	 Mwpr9wKTczQEQ==
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
Subject: [PATCH 16/29] iio: adc: ad7791: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 17 Feb 2025 14:16:16 +0000
Message-ID: <20250217141630.897334-17-jic23@kernel.org>
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
functions that are deprecated

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7791.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index e49d4843f304..597c2686ffa4 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -343,13 +343,12 @@ static int ad7791_write_raw(struct iio_dev *indio_dev,
 {
 	int ret;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	ret = __ad7791_write_raw(indio_dev, chan, val, val2, mask);
 
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 	return ret;
 }
 
-- 
2.48.1


