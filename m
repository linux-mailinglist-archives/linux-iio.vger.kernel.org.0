Return-Path: <linux-iio+bounces-15683-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0784A38612
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092FF163136
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467AA224B1F;
	Mon, 17 Feb 2025 14:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgFFrTy2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003E6224B17
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801871; cv=none; b=RiHjX7BRyoxdm60DdPmcNn1s4kUZi07pCNdemPNJuAHInGWIxypH4Ry28JgroMifd3tUo36WaFE6cjbn8P1Bs+Ptyms6jMNN/T+jHRj4oTbNlIPWy3q3mednxX7CFUoPDNb3WN3po71G1I7b0SNdza/crUEepn3NwZYiacNguqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801871; c=relaxed/simple;
	bh=lBCHWJxoUYFtYnqWzjIChKY2nsdvZpKkFsRNp5YxjnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=attwMKqVqndj9jfjqDchIKkDKXGbizoN1UNYv2+U+tF0bvqeMba7CyyTDQ8/0DhODUhNfesvvc12UuoJrRt77o7F/ijhZTSZom+7RxgN046d903+pBIbRgFGbtkqjr1uF17aIHkmk2agwh9J4ag4dmlfUl0dryDgoN2dVqj/PkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgFFrTy2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E683DC4CEE4;
	Mon, 17 Feb 2025 14:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801870;
	bh=lBCHWJxoUYFtYnqWzjIChKY2nsdvZpKkFsRNp5YxjnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LgFFrTy2ENz3t4PxDfHxGruN5gMr6YrwXyLElmU3AX8lglVEbnX9ioiMlyu58YttZ
	 TScnWjJecB51Fl4zAkU0KCthDn7dmrlJsXOU7al1bZ3mU6eebIAoXW776vWtT06mp4
	 ux9ME26fupzlNFGqtatnFLu5mmwI4k5TRjd/rWKfVeH3uoAvxZpkdDNRVetq05lR37
	 2reM7X/q5n5WXO6R19VVW8dJB5tbj9p+Up/ZVjHdDfVaekXnjBXE7MCV/i3p8Yi/Tw
	 +xj+5MgFh8iA82QnUv+lFEOn6fY/ZZ6h1UKQq/dCJOox5fTMhOpXcbwkPXSeQ8dm0c
	 WvNXbBdlXSjAA==
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
Subject: [PATCH 11/29] iio: adc: ad7192: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 17 Feb 2025 14:16:11 +0000
Message-ID: <20250217141630.897334-12-jic23@kernel.org>
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
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 785429900da8..f6150b905286 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -694,9 +694,8 @@ static ssize_t ad7192_set(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	switch ((u32)this_attr->address) {
 	case AD7192_REG_GPOCON:
@@ -719,7 +718,7 @@ static ssize_t ad7192_set(struct device *dev,
 		ret = -EINVAL;
 	}
 
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 
 	return ret ? ret : len;
 }
@@ -1017,13 +1016,12 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 {
 	int ret;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	ret = __ad7192_write_raw(indio_dev, chan, val, val2, mask);
 
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 
 	return ret;
 }
-- 
2.48.1


