Return-Path: <linux-iio+bounces-16619-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 045EDA58607
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F66188BEC0
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985821DF742;
	Sun,  9 Mar 2025 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="II31LcZ9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5847A4A0C
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741540059; cv=none; b=XmJw1zrg7gDMDuWHXf6VIEF2IyJCSM0eQhGPW+e4OD/XT/dbZdLl4aLjo4ve92gVqE94OXguAMbH726V4hPDMmmOcgGBOAmFzwUm75s0NWtGe7bKzhwgApCJPOshbirOM14MjfqOmy+W1mZtQOc4kFGgJgqAxiVP139taya06Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741540059; c=relaxed/simple;
	bh=R3B6AMjl+xKkxZBZ4aqii1R3GEz91ejCpM08awiT9aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQncj0v4N+mx/QXpJp85JWk7x6d7pIUbplHzZR3Xb4cjoLJOr/g/xV8BIkW2Rgq3gJKLZSmgSzsPkVf6qHeW2QWje+J5wxkr40Vy+AO8b2tWPsDJz8pAErn1Ad/T2blfxfZ7aV8wjV/f9Jm/tMKDi+DFC3lUxPNjGcWdy+iLiHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=II31LcZ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6F9C4CEE3;
	Sun,  9 Mar 2025 17:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741540058;
	bh=R3B6AMjl+xKkxZBZ4aqii1R3GEz91ejCpM08awiT9aE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=II31LcZ9OYKidO2n8LaXLdSGePmUFt6s6qwI38yJh2vt5pIfM5c5PdimSVyd65FGG
	 MNQW6HgUNHseaSKOO/6Ez0dqKfqsNdHP00Whitc6ErVCDIoonvrFXgT5TJ6nj8fWOs
	 1OzpTXVH3o/cLC1IQqE4GFqnNNiy6WXSGqqLd3idP0pweA4+UJMQ7LCOYd6TXWhZtW
	 /KuHvyX9qstx5R156ROgXo8bya753sv75Oc8knjG9JfxrKW0Cs5BiZJ5bizGKNWUIO
	 XvwPxpSGH1CpDZEbVhVHThNaDI2Hdaokv6L+7cBI8sptHBhTHAEEUlL9pdsgQs2o0K
	 7EaNGYpxhdFrQ==
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
Subject: [PATCH 13/18] iio: light: si1145: Switch to sparse friendly iio_device_claim/release_direct()
Date: Sun,  9 Mar 2025 17:06:28 +0000
Message-ID: <20250309170633.1347476-14-jic23@kernel.org>
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
 drivers/iio/light/si1145.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index 66abda021696..4aa02afd853e 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -633,11 +633,10 @@ static int si1145_read_raw(struct iio_dev *indio_dev,
 		case IIO_VOLTAGE:
 		case IIO_TEMP:
 		case IIO_UVINDEX:
-			ret = iio_device_claim_direct_mode(indio_dev);
-			if (ret)
-				return ret;
+			if (!iio_device_claim_direct(indio_dev))
+				return -EBUSY;
 			ret = si1145_measure(indio_dev, chan);
-			iio_device_release_direct_mode(indio_dev);
+			iio_device_release_direct(indio_dev);
 
 			if (ret < 0)
 				return ret;
@@ -750,18 +749,17 @@ static int si1145_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = si1145_param_set(data, reg1, val);
 		if (ret < 0) {
-			iio_device_release_direct_mode(indio_dev);
+			iio_device_release_direct(indio_dev);
 			return ret;
 		}
 		/* Set recovery period to one's complement of gain */
 		ret = si1145_param_set(data, reg2, (~val & 0x07) << 4);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return ret;
 	case IIO_CHAN_INFO_RAW:
 		if (chan->type != IIO_CURRENT)
@@ -773,19 +771,18 @@ static int si1145_write_raw(struct iio_dev *indio_dev,
 		reg1 = SI1145_PS_LED_REG(chan->channel);
 		shift = SI1145_PS_LED_SHIFT(chan->channel);
 
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = i2c_smbus_read_byte_data(data->client, reg1);
 		if (ret < 0) {
-			iio_device_release_direct_mode(indio_dev);
+			iio_device_release_direct(indio_dev);
 			return ret;
 		}
 		ret = i2c_smbus_write_byte_data(data->client, reg1,
 			(ret & ~(0x0f << shift)) |
 			((val & 0x0f) << shift));
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return si1145_store_samp_freq(data, val);
-- 
2.48.1


