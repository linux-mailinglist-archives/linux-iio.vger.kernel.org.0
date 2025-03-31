Return-Path: <linux-iio+bounces-17461-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD039A7659B
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31AB13AA0E8
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D85A1E51F1;
	Mon, 31 Mar 2025 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6d+RtQj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36491E51E0
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423411; cv=none; b=jso1j214d4lE5eTpEYXLP7fJmsTo2itpY+edtYIV4eNp9mRL4PzHxtt+1DYjJN0Wtk3yQabdV9BmM41Ut+jFjzia6kHt2xdV8b3wnDmaSqkR7FFzI6ehJo4lX1h7/0mnYoK3gaS1slOg6mPBQuKDSP2EDIRk93nWSnh15ev7PGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423411; c=relaxed/simple;
	bh=t5zsMLD9acAVhrclDPi3bIflel+5AtGA4BotMrkH6oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1oLabBgocJtUE0Dv7iEUpknxYjTLuAcBZSfQOxaDYNtCPg4HztNEgMTFoB1PgyHV8J9kQPCQX2f03qycxjc59N4G5fz55caTvlHxJ4NG8KRKTrKZB/Se+cUM5DeEXXSi0/j9hImyQrjftUlwy/gqHQAH59/ccRAUJT9FhHWjNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6d+RtQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9107C4CEEA;
	Mon, 31 Mar 2025 12:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423410;
	bh=t5zsMLD9acAVhrclDPi3bIflel+5AtGA4BotMrkH6oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N6d+RtQjd24PCi0T5mrrSQz9uGECGIlOkSyqE2ekv8OZmvHNJzK+CfYh0wVZS07ka
	 xSr7b15OIMa766P+TkqEtNUHniciudWgKB3jpGk8kvD/+hyycopaV8xhGgtm9Omi+o
	 wu6SNoobLFd8EUfI4PZVaA2TbRpep3OqWJptQHBoNgT5Ad1HOM0nZyS02VZ71oHWgK
	 W9cSMIXyEhFQ6MZ5So8YHKAnjJzelusBXiw4fATs6/Zq3mIuj+Eq3U3ZzXHWYae3xO
	 S9+YC85Zg9fzZk/KnODTWRhrUJ/SiPYUAYiRpAxCNLayTQg22S1Wm2NbTppH/vZ4wI
	 uUlT6rowx28hA==
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
Subject: [PATCH 31/37] iio: proximity: hx9023s: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 31 Mar 2025 13:13:11 +0100
Message-ID: <20250331121317.1694135-32-jic23@kernel.org>
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
Cc: Yasin Lee <yasin.lee.x@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 5aa8e5a22f32..5be5f4986347 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -701,12 +701,11 @@ static int hx9023s_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = hx9023s_get_proximity(data, chan, val);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return hx9023s_get_samp_freq(data, val, val2);
-- 
2.48.1


