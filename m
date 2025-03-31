Return-Path: <linux-iio+bounces-17441-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31109A76582
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F943AA075
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D631E32CD;
	Mon, 31 Mar 2025 12:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPgFjLl7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C181E377F
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423284; cv=none; b=ULHXKD3BvRehXVXuO/93WnQpmBQbgqfZwyu68U6DV7gakRyBv2yJ2xC9Q2wcUy2PwAF1mUShvYwtKU7SufRUSTdJlVcKSgeV2grwxSUfVwDp57QzzgEMPR5lPZiVzb7UXPY71yxVk/LtAOAQVTfJnyF0Bm9aTbhE5/Nre/s5uUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423284; c=relaxed/simple;
	bh=4oPsywMeiF36Vp5tgpV6wJJcJj8jP1JxM+zu/c34YXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTPSCQbXQKmfpv5ikGd5bKRW3cNUFcdoc1rAiJ5EZKc+xPTMchi2zi61mmD9cSrdtyoF/8Ki75Ywm1TPxbD4YL8o5FtMmP7ikO5zKEl26nAIxNRsANKRZif/YUt11UciuMgexDFQd84DMIb5AH9QxkevoO0rjmBZ9Eg948vnk+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPgFjLl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DFFC4CEE3;
	Mon, 31 Mar 2025 12:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423284;
	bh=4oPsywMeiF36Vp5tgpV6wJJcJj8jP1JxM+zu/c34YXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KPgFjLl7Rh1QbaZhYbfDzH/brpaTHmzduebpbrj74ZOyC1LDk6Pj/a9kRhyPeY/cT
	 MjXMDTjQFxhSYgLHz/6BrAcwsoVXXA/NUpvSsAdPiitOLMxQ7voBmcgcS8TuaBUTko
	 OS7vbg8xOpcM9R+KEg2Zn47mYE5dQPNEoKMehbECdI0xkfEHhcTnKz85RK2yyktLiu
	 YExRZ9p9rvEJ0PskMZxqHLn05LOyRbS1VzTUz5CSOEDXZOyaWcturTYotMqyHy6YPd
	 l6NUAWGwoOaA5+JmcnTSlTgoAJfp03cznvqNeSTtwRSSVbcCjhTU0epaVf5O9r4ttZ
	 6C6fzn1KOd9lQ==
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
Subject: [PATCH 11/37] iio: humidity: hdc100x: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 31 Mar 2025 13:12:51 +0100
Message-ID: <20250331121317.1694135-12-jic23@kernel.org>
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
 drivers/iio/humidity/hdc100x.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index fb8584423ad8..c2b36e682e06 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -212,12 +212,11 @@ static int hdc100x_read_raw(struct iio_dev *indio_dev,
 			*val = hdc100x_get_heater_status(data);
 			return IIO_VAL_INT;
 		}
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = hdc100x_get_measurement(data, chan);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 		*val = ret;
-- 
2.48.1


