Return-Path: <linux-iio+bounces-17436-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD727A7657B
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0EB18834CC
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B85E1E3774;
	Mon, 31 Mar 2025 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+ZX9cs5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B61A1E32CD
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423253; cv=none; b=kCuu/hV/mKNJD3X54rya3OAw57YskgxSy66ZIdZaYlB7teg0kSvtmL7ox0GyCEJN6NZRaYrS2fK2KGrntIZCuMYCNDJtO01mE/SYe1Jg6kPn0uj4v/vrkxtrcLYMRxNC5ZFS/EWyDg5n28ZIqd0JtQnenptUrGA0X2KylW3izOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423253; c=relaxed/simple;
	bh=Pg3aMTMJ2LBBAhyRSbi3XbBfL7zwCX4hyNaXNC0F57Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+PkaXYoIEKWY25hCxyJ6fCQH6PKZtARzHX0xLDd6g2LZsO+t4wdEqW0+GHlYuV4fn7fFfSp20HXs9Cgd73mJCyZ20qgtYEr0et1tw+1JVUESLMW1HjuRtiVkz9QaaOo6tmRHQjGZweRQ7lIuwnDLVM6mV1n08/pQ45HF5OZ7/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+ZX9cs5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C78C4CEE3;
	Mon, 31 Mar 2025 12:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423252;
	bh=Pg3aMTMJ2LBBAhyRSbi3XbBfL7zwCX4hyNaXNC0F57Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N+ZX9cs5ZsHRvQtmzv2L3opQ8nudKzeLTL026Sye6gZQKXsVI9aLL6fEx2R6+aHJB
	 bVYKmd29nc9mS5eD0cF9WzxSE/zExPT9qdGnCDPz8z6QxqduBzKCAuDbRZboAoDPgr
	 S3OR05ZqVWah6YtIqUFcktRxjT+I2AHSwXkXwUsNrofK7Fd9V3IcYYYtA678/Ir8OR
	 JbY7wNIpMZERdALNeGu82ol0wiCVBtCAevSAZRgGkTvmz/giESHQ0sSTJC1gzVRrQ3
	 Sn0BMxPWxFIRHY0X4J3gRFwY69zs94aGn/n8mE0YKLlWwfRiLgj13vnDiP0hqmT/Me
	 bN6oAxhq/yQ6A==
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
Subject: [PATCH 06/37] iio: common: scmi: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 31 Mar 2025 13:12:46 +0100
Message-ID: <20250331121317.1694135-7-jic23@kernel.org>
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
Cc: Jyoti Bhayana <jbhayana@google.com>
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index ed15dcbf4cf6..1a62dd902f05 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -351,12 +351,11 @@ static int scmi_iio_read_raw(struct iio_dev *iio_dev,
 		ret = scmi_iio_get_odr_val(iio_dev, val, val2);
 		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(iio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(iio_dev))
+			return -EBUSY;
 
 		ret = scmi_iio_read_channel_data(iio_dev, ch, val, val2);
-		iio_device_release_direct_mode(iio_dev);
+		iio_device_release_direct(iio_dev);
 		return ret;
 	default:
 		return -EINVAL;
-- 
2.48.1


