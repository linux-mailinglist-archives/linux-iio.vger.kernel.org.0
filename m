Return-Path: <linux-iio+bounces-17459-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0478CA76599
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42952188985B
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8911E501C;
	Mon, 31 Mar 2025 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4VrFSte"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03B813B59B
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423397; cv=none; b=UUgcOPX/J+3hYOgJSKxXCWTnuI91opR1sQGVvWraCS1Pr0o9duP5q+KTcLfvxDSSc/J03+7jv+1QaSnf5pf1qVJkOOLXXB0+L34vcl6KsHVPbf4d+PZVujiMmvbprcV1lf90jrribF0s7mHdTCh2iojbfmPVsBdBN6hfpKbsRyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423397; c=relaxed/simple;
	bh=bkUBroduMD1qkWRgXaqshRbm7zTAmRWl8fpL8iy7krc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sapshwv8BKTrop8F3FrS44CQwHIkvHYKhf3TxhSmDXGDU6dIRk8BDngdbI6EocEOyqp5394jqa0jAkQhZT50xZsPxypZXRvTEsrbYlHq7qWWGFG7ao18Y3UMAkzjv/Md4Wlk9Q22/Uf9/bRRHswBN0oOTG0AfcUZheFc8K8NziE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4VrFSte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22D7C4CEEB;
	Mon, 31 Mar 2025 12:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423397;
	bh=bkUBroduMD1qkWRgXaqshRbm7zTAmRWl8fpL8iy7krc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G4VrFStesG4yZpJ0EP3T8TvA3/GAWfwf1ro1tZfqA7EOK6++lbOMtEICrsUGaCwMa
	 bCga0mnQMwnLiUiFBr3pO4gru/gkODowb0us9NvqXZ1SZjupBgFfZFh7brGGDZNjuN
	 L1HHrDo717bHq+vpAHGSlp094V+4635abvt2qt1rhBGctMLMiKhoXme31QOl1aoIUB
	 HVOIHPE2o9aStiLhJa+U8Wx25cwM03Q9niEqc82xdcPTuYXvUaybEr6Z+rX8Z1ThHp
	 hkSw1OOUc2+QX8uRXd8zxlaZ4C2j4vL+tbSay5fMlnzA5aiY3wq1vXWJcos1SnlMIX
	 rly+R6yZrSI+A==
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
Subject: [PATCH 29/37] iio: pressure: rohm-bm1390: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 31 Mar 2025 13:13:09 +0100
Message-ID: <20250331121317.1694135-30-jic23@kernel.org>
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
Cc: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/pressure/rohm-bm1390.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
index 9c1197f0e742..c48231739f48 100644
--- a/drivers/iio/pressure/rohm-bm1390.c
+++ b/drivers/iio/pressure/rohm-bm1390.c
@@ -319,12 +319,11 @@ static int bm1390_read_raw(struct iio_dev *idev,
 
 		return -EINVAL;
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(idev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(idev))
+			return -EBUSY;
 
 		ret = bm1390_read_data(data, chan, val, val2);
-		iio_device_release_direct_mode(idev);
+		iio_device_release_direct(idev);
 		if (ret)
 			return ret;
 
-- 
2.48.1


