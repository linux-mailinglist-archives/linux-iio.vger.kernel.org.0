Return-Path: <linux-iio+bounces-17444-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 679A8A76585
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C00133AA0FF
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD88E1E501C;
	Mon, 31 Mar 2025 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGTgi5hv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896671D618E
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423303; cv=none; b=SkAI/Henf+GUR8diwNwkTD+kx4/9IwSqpCX7aYzqkZUSfU7Cj4KJuB+amYVIl/71h317xqEv9kbIINktFDUaJX0+wDJCAJtx/xFmZQDCP9v+MHZmnZdyyR2n8JNCjZMdQ7vboZN0HYQS9TXstZQl26bNzKRM1YyD6MLW5Pkb2Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423303; c=relaxed/simple;
	bh=pLMwio6p4cgakr7w7elqwXNuJ5aTmzh6oRZZ5EckWeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URXQyGOwWrlNuW6h2OvNiM5S7Lj1o2fWs3AisvUkgYq7Bzh/vUZJ3LS6B9e8J3sZAAY8PaT3ZHTuPmjlbnHzdSEm9ixh9q7sT+/Vr1qaqw/Ew/RY4gtC1zMFET1hVM/m0uwN2UZA13DwZarqUu3cpfuhmt7mNYq4s1xyBttXjcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGTgi5hv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D10BC4CEE5;
	Mon, 31 Mar 2025 12:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423303;
	bh=pLMwio6p4cgakr7w7elqwXNuJ5aTmzh6oRZZ5EckWeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jGTgi5hvyp4VomJ81/yxIeQbrbBeBs7x595vNMIT4MyGlXzUtzeNiLJ3W7WEVZyHA
	 c/hXuXDNZYDjIDFo3JkCzSF/ltG9unHrrQ1yNBfUYP9xyWisJu3MsOpPuzQSwp7xX2
	 SkZb7K3WgFlionnnzSKfCvO9vAqyOY2f1ibTxEyBN6hpbJQzk1ISE0+x/HdWxwueVM
	 kJJzSgj9WQVZ+6uq/EnFpsp3d5zOLscQFQV76ESAsxrbYgROtr8LZM4qqQp76tUTH+
	 /dugkbCJhR71+oR9GX5NuhigKwCMRX42EBNU1AH2M4Dv1plFrxS6lgQiVwugZJ7lR6
	 JAhYSMN89BlAA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Roan van Dijk <roan@protonic.nl>,
	Jyoti Bhayana <jbhayana@google.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	Eugene Zaikonnikov <ez@norphonic.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Shen Jianping <Jianping.Shen@de.bosch.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 14/37] iio: humidity: hts211: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 31 Mar 2025 13:12:54 +0100
Message-ID: <20250331121317.1694135-15-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331121317.1694135-1-jic23@kernel.org>
References: <20250331121317.1694135-1-jic23@kernel.org>
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
 drivers/iio/humidity/hts221_core.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index ca4746f2ecba..bfeb0a60d3af 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -464,13 +464,12 @@ static int hts221_read_raw(struct iio_dev *iio_dev,
 {
 	int ret;
 
-	ret = iio_device_claim_direct_mode(iio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(iio_dev))
+		return -EBUSY;
 
 	ret = __hts221_read_raw(iio_dev, ch, val, val2, mask);
 
-	iio_device_release_direct_mode(iio_dev);
+	iio_device_release_direct(iio_dev);
 
 	return ret;
 }
@@ -504,13 +503,12 @@ static int hts221_write_raw(struct iio_dev *iio_dev,
 {
 	int ret;
 
-	ret = iio_device_claim_direct_mode(iio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(iio_dev))
+		return -EBUSY;
 
 	ret = __hts221_write_raw(iio_dev, chan, val, mask);
 
-	iio_device_release_direct_mode(iio_dev);
+	iio_device_release_direct(iio_dev);
 
 	return ret;
 }
-- 
2.48.1


