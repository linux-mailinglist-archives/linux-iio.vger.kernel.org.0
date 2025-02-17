Return-Path: <linux-iio+bounces-15678-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615DBA3862B
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC043B113B
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452CC22371A;
	Mon, 17 Feb 2025 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mu3HIO9v"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0545C22370D
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801842; cv=none; b=tGVN9KzzU3Z/QPhdjV6/Pdn180cZblB1s7TQ4iWWmAPds3WvCBekt5pebZ/6e4OdAA85A+BZrt2JyvM7ylgtbqjYhWkX05r2ZiD2Xz+fXDAaWLM6JLXMvwJcMJfRUqm45R29RYBayt5yG8vEHbe/Dz18Mbj0DFCS7H1N8UJbZ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801842; c=relaxed/simple;
	bh=vaI3p86yqkWTV92lC9NLqHcE1PrPVtBumyyz8er07i8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sop1PZfGrc2ClMZNZJR+NhmyrV7wuDvszV0qJpUmuWPIpoAdDFoOl4t+ZlW8JpknjxI7mJDxO6j3ShdRC+Pmr6gAhvRD7x50oWN+Q+iEt7PYeWQYJVIKf29Ew8eUj+mQiBLrOMdPZQCc6Qtw4tTK/rROY8eXAG8ZBPq8yfw2H1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mu3HIO9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73212C4CED1;
	Mon, 17 Feb 2025 14:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801841;
	bh=vaI3p86yqkWTV92lC9NLqHcE1PrPVtBumyyz8er07i8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mu3HIO9v3Mlm856J+QxvolFtGQtEbLkOGCce6kxsUtkelcC9i86zJO1kxpAyQ/AJw
	 fVQC/dmK2aYEl4/4cfrdv7rOm9s3hz2+nlkTVYK6GTYMTo9dl81r5e20mvniJ2W79a
	 eb3ZSyxPNE3HldAFlwMiKjsyBZwKDrewlKOlfUsxmDdPI2rChEf32B1//FI+cWWPL4
	 a9ujSq1/sbe1MjI0Pypdqb+aucDkynOf6V9etmaKJYv+CsN/AtTtnZvd0Qi1qHWu96
	 b3QKWBD2OlfZQVSaNNUg48LG6z2MmYAIJ/5PUmfDCXt8s57JfLNMgFZSI9F+CvN/r4
	 0O6CSK6WvSZuw==
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
Subject: [PATCH 06/29] iio: adc: ti-ads1015: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 17 Feb 2025 14:16:06 +0000
Message-ID: <20250217141630.897334-7-jic23@kernel.org>
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
Cc: Marek Vasut <marex@denx.de>
---
 drivers/iio/adc/ti-ads1015.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index a91ec18ddbec..729977b611ec 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -569,11 +569,10 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
 	guard(mutex)(&data->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		ret = __ads1015_read_info_raw(data, chan, val);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret)
 			return ret;
 
@@ -786,16 +785,15 @@ static int ads1015_write_event_config(struct iio_dev *indio_dev,
 	guard(mutex)(&data->lock);
 
 	/* Prevent from enabling both buffer and event at a time */
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	if (state)
 		ret = ads1015_enable_event_config(data, chan, comp_mode);
 	else
 		ret = ads1015_disable_event_config(data, chan, comp_mode);
 
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 	return ret;
 }
 
-- 
2.48.1


