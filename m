Return-Path: <linux-iio+bounces-17453-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1409EA76590
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663633AA092
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5AB1E47A5;
	Mon, 31 Mar 2025 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPRQIWbc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE4613B59B
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423359; cv=none; b=fiWLipaP7YIe6mgFv+tn7oNYXY4OK0ujv06ZSdA8KGhlqlqlDzgRKUBtZrtp2JBmPlIuCZIAz5hvwAmU4IQeERWsStPl6+dzRyxMY5TWRNOkLjW52WsW+pRidcoc2xL8HPWFqnfErVwI+tAQXYMJV2X8MUeB/QiIM7FCjXZvAAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423359; c=relaxed/simple;
	bh=QbPjGNiEH56YpA27SkR3HxIXYFc7fD2SJi0T8/AzEy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnWXd+XaOTGDZtDGgPKxKIxWhcG8YII7lbwsF64oI5acmgd1mcZiDQGOa33w+RGp0oooV9QBao3fcFpDu20GWH1e8UxhJoiK/0GE2uSnmcKgnCRjhWl1RUWGFe7sHf4QviVMdnfe+2cEw95T0PdIAxAAXjtJ9P+WTIHyyk0vs3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPRQIWbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1C9C4CEE5;
	Mon, 31 Mar 2025 12:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423359;
	bh=QbPjGNiEH56YpA27SkR3HxIXYFc7fD2SJi0T8/AzEy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pPRQIWbc9xraM8Ij5wFma0LAuCT2xhYhB64RTTV9pBjPPpODseSGudYTkOy+t12KM
	 HSa7CveJUeiwoYWH0K7GLnfSnMFun+mz3c+hGiPrD5iwSGfdAETD5SLYohty2YoEx+
	 MWpEim4UIXKhy5VvYz0kyYEHVTwNnw53KtR75lrOa+cyN2g4yiG2IK427oXHBLArda
	 ri5sKQcGE1raJY95kw3ihrqj2n29jB4EJbxjt6xLYbmCS8Ue53IKlZdAfP8mbyIJ4X
	 WYeNWjn07nC2NtS34+su5qwmPIe71oPlkpx7jsw1/MJfYThpRiTK85uWcKbR07euI5
	 Hr/sbdeKc8OKg==
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
Subject: [PATCH 23/37] iio: magnetometer: rm3100: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 31 Mar 2025 13:13:03 +0100
Message-ID: <20250331121317.1694135-24-jic23@kernel.org>
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
 drivers/iio/magnetometer/rm3100-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index c99694a77a14..e5162ee64e01 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -399,12 +399,11 @@ static int rm3100_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret < 0)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = rm3100_read_mag(data, chan->scan_index, val);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 
 		return ret;
 	case IIO_CHAN_INFO_SCALE:
-- 
2.48.1


