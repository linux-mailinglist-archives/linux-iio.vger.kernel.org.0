Return-Path: <linux-iio+bounces-17431-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C707A76575
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78CCC1889810
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16831E3772;
	Mon, 31 Mar 2025 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNfH/iPI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DDB339A1
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423221; cv=none; b=tJV5oeon9fR1SjvlP4CKPdAF0Vzetw1QRmcI+ZOBoINYEL2vfPY+K6bm4k/pvt2GcKxA1fy3QxFadgV4A0tbOCfd0dD5bzsTylGLDRxz7khuYJH2quq+uglBthrxLa4eX4Xtf0DD3Ww079SZVUk/LbkoA1n4KrzoaaLQUYUlf6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423221; c=relaxed/simple;
	bh=FAKwMydjlxwNgnbyXQ4JWVNy4HlxKhM9Afm/NQ6kDo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMG0SL2QoFiIOWGvXLOhQYWBXovWOdT/jL3Oo5fEyigHi/E/RxuOcXdPp/WhHgcVJ3AU/Fjb+cV+fF2liGSWN05GlpETrqAzFI5karg5nq5SrCe8o9dNsa12MrejZ4YjkyPeXkaG4H+l0Z3C5D75/qcyhlAZfgJd9OQBo/HKgJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNfH/iPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D6DC4CEE5;
	Mon, 31 Mar 2025 12:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423221;
	bh=FAKwMydjlxwNgnbyXQ4JWVNy4HlxKhM9Afm/NQ6kDo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aNfH/iPIw8uAqXGO2FmaRYKz3H/OO2huqosRe9wXUIUkXFKtBZw/hoAJt9LL3jsKc
	 kGdWygh93DR58hKSzIX401mmozJyXuz96eeWSjX0bnJLrIGIQc8PUDiigyWDNTxYiD
	 mvBuA5VoHTfjI7BnYDL/v+hhb6N+A90gYh1qoXJlequmlgPVZG7cwYCHEt0E6KgtBg
	 Fb148KemdVHfEcRiqg1rdt30CAH2A/0Y6muh6g7rDB313Lk/PehGljSKdN5c/Rki6P
	 1c+sUUsVSejlgFVMeDP/gWs+FAiRe4neFvJm4I1+05rnCOQ5vVFPEc+JbPvkgSWnV5
	 BCjYL8cRIhuCw==
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
Subject: [PATCH 01/37] iio: addac: ad74115: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 31 Mar 2025 13:12:41 +0100
Message-ID: <20250331121317.1694135-2-jic23@kernel.org>
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
Cc: Cosmin Tanislav <demonsingur@gmail.com>
---
 drivers/iio/addac/ad74115.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
index a7e480f2472d..edccdc9cf34b 100644
--- a/drivers/iio/addac/ad74115.c
+++ b/drivers/iio/addac/ad74115.c
@@ -866,15 +866,14 @@ static int ad74115_get_adc_code(struct iio_dev *indio_dev,
 	struct ad74115_state *st = iio_priv(indio_dev);
 	int ret;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	mutex_lock(&st->lock);
 	ret = _ad74115_get_adc_code(st, channel, val);
 	mutex_unlock(&st->lock);
 
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 
 	return ret;
 }
-- 
2.48.1


