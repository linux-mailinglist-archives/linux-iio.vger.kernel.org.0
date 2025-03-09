Return-Path: <linux-iio+bounces-16603-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42550A585F1
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6BB1697C7
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 16:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4971E3DD7;
	Sun,  9 Mar 2025 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUS9OboM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6791E0E00
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741539542; cv=none; b=OZ5vrq2aoCwR2Qds14s2lS7kH8fZie2iRJlb+FHFCACwxGrT/uLN80YcdzYEtsCMDDhPjoVczvRW9AGEE3sKqNk0hsZJ+2LLKCVzVEcxzodXiihsppY+/sCNZdOdzr7kpdizG7Dr4sEB8Hv/NEYNNYiv3l3FzDIb2s9irV0zOOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741539542; c=relaxed/simple;
	bh=vaI3p86yqkWTV92lC9NLqHcE1PrPVtBumyyz8er07i8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWIKuLVpE/A7qCCPWZ38yqmqPUkkKaFWnDYYkIST9A2UGX5NFqL89KNJJPKjkZxJbQNwVCd8SVX+ytDFRyZzCS06xjw613HKGdAKJJNdxksqb4aqewNp6foGZpdaqxo3PHZd7TXGh6gKqZoUsSpM7QYxKkOckZgqxv9AVH1gk1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUS9OboM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D34C4CEE3;
	Sun,  9 Mar 2025 16:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741539542;
	bh=vaI3p86yqkWTV92lC9NLqHcE1PrPVtBumyyz8er07i8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AUS9OboM965gxJfMnz2o6tbUumdqet5qNOF6hT6in/0Ok3Gzx7lubh6rZPj4XhReW
	 tGc8GevXdHiOg6F7kRoheAWA5UjavPbXPHjPz2XeW22WMO0UjuNssCGD75UPhYBDWe
	 04aG66s/n8W8DHg7q99Jnzh/MqTBw0YQSvBJSkcEWbNx/24Afjf8HnK2kN2+DFf16n
	 vqcKqj/VIHTSOR/k1AuTlQ7+dsCmcWTs+hw+gjjdMHBhDuuvsnIRGnprEVsURzjoSK
	 /PRTUPAodrDfedqv6aJTOG9iAK1MHgX8BOkV5hyF2hMhNofNIjBjGLwSGQwol357Xz
	 xDSe9pfhxbpDA==
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
Subject: [PATCH v2 6/8] iio: adc: ti-ads1015: Switch to sparse friendly iio_device_claim/release_direct()
Date: Sun,  9 Mar 2025 16:58:17 +0000
Message-ID: <20250309165819.1346684-7-jic23@kernel.org>
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


