Return-Path: <linux-iio+bounces-16609-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFF3A585FD
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41563ABD4C
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A651DF73C;
	Sun,  9 Mar 2025 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+nmlZCX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDFA2AE95
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741540018; cv=none; b=iWkyWMKCkCD9EhZFGEb415vAJQW/ZPtKcUO1NS8fQSFfEf88fw9rA37aXuTVFYiLBISOUvyeEMhAyfkPSf8BkpCeyDF3c+SFQTtpZOyGrgrGQHsO9Xn1ZdzjKv6u5QHbfhpy6Uo4Gfk7E1u39yhC5jKZl9ToNIfLPchOhTPxLCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741540018; c=relaxed/simple;
	bh=sjo8I+TItiGsiEftwmu24qPk9lUz7fQiNJdOgPfhtyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mptAePONyddYLmgpZ6HI1DHBuqFb9AxV/YTVCFTuQO9oRySwQp6xoWcHAweLqGvuOAuTOwzrwR/F4TLStlEsnHH14Ercwo3Ic6iOeIgf65wK0RJZQfc4RA4h8+nRaQNpMqKdC9kyqJlNNAniqXAh17C0xWF5w92dSrvrBpoYWSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+nmlZCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD96C4CEE5;
	Sun,  9 Mar 2025 17:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741540018;
	bh=sjo8I+TItiGsiEftwmu24qPk9lUz7fQiNJdOgPfhtyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g+nmlZCXWLxe2TmGDhXEwsmb7NHOUouej5C0fvqJTVez9SquOMWfjJ1oOqi+APb5i
	 fWIxkTCiQ5rQChiAQG2rgteNHWDabDMI2snlvltEu03tPYwz+6ZQ10JwOaBjaqZkYW
	 MsuHZ5ID+yAZ4GmWATck12p/ACrtthSab1xK+UBXJMyM7k0Xc1B58QROeQ0CY/JQ0M
	 OTDsWe+eRWsks7tLyijgZfgBxkOB4LcPyDS9iiy/C7CRuzGLVS4ryqA4za0YJGFMrw
	 dBYzJ0oUCHXgPvI/ni0kOnCB+KviyFO/oj1EfgXlrVRDUefSKBaXPMhhcHinvpJ2Do
	 ITUbdCoDC4BPg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Astrid Rost <astrid.rost@axis.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 03/18] iio: light: isl29125: Switch to sparse friendly iio_device_claim/release_direct()
Date: Sun,  9 Mar 2025 17:06:18 +0000
Message-ID: <20250309170633.1347476-4-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309170633.1347476-1-jic23@kernel.org>
References: <20250309170633.1347476-1-jic23@kernel.org>
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
 drivers/iio/light/isl29125.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
index 326dc39e7929..6bc23b164cc5 100644
--- a/drivers/iio/light/isl29125.c
+++ b/drivers/iio/light/isl29125.c
@@ -131,11 +131,10 @@ static int isl29125_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		ret = isl29125_read_data(data, chan->scan_index);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 		*val = ret;
-- 
2.48.1


