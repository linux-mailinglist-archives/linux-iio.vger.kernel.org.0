Return-Path: <linux-iio+bounces-15699-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB21A385FD
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BA327A1DC3
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE4B22257C;
	Mon, 17 Feb 2025 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7kabR52"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD212222AE
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801957; cv=none; b=lBbZt542cq/WXd4euqTJSLPiz4L4ie7sGp+uuB56iE5R8JK6GNP4shBO1Kw5kUnP2f4u8irYQU0FCUO33/9CPu41vRQAVlkOgAMCI8YKZzQwoPEeeH/vDuQ9ilS9rkEoo5ZdMEZ8HLtqVCaCUs3cO2d/262DdCPvcW4g7MpHz5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801957; c=relaxed/simple;
	bh=gn/KStolaftcyqTZpMGSdcKL5sXvfMwH3wicMc1s1DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSPBpKn6fa9W2CJO6oksrDk2wwXaNHRXPomzO3hF+9JiHBIUUPJ5gvLB5Hxm2iuwux+tDzTc8nSeHtOr/x8mFRbIz8fFqxHRGO/3GwENsPBW3MperVT1SwDh2yuL+d410wZ8aQ4W0VV2fOG3kBkpLnXoNB1epxGUAS9zTTBfbu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7kabR52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FA6C4CED1;
	Mon, 17 Feb 2025 14:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801957;
	bh=gn/KStolaftcyqTZpMGSdcKL5sXvfMwH3wicMc1s1DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f7kabR527IBMi0EctvJ1yENpWjrQu5hpnAZAmu32Ktd3aES6pDVyyIM86+E1m6Rao
	 +Xi7xxtHp3bJVZOpwTlRsYTe5688IiVEtufBCpz0wrgw3PgkTG3aL9DYf39/DgKhid
	 Pr2oWwatd4arXS77AwSMyJQ2ceiw2y11RrxS1JsSFWhMhtc7Jj7Kt8bm373PmiNi2+
	 Yd1P8+UQCBK2YyKsiUGdWSDVDSejFcj6l2PLwe2zCHVjtHczdnnyfb/X3mYn2RtT5/
	 Uvl144sBDsLZsn944YNMgo+6Ztsb1Kaa171V3eXjfRPBi/+6Rz9a/uBU87UsfLm9Ze
	 4YltcXOuJWazw==
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
Subject: [PATCH 26/29] iio: adc: max11410: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 17 Feb 2025 14:16:26 +0000
Message-ID: <20250217141630.897334-27-jic23@kernel.org>
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
---
 drivers/iio/adc/max11410.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/max11410.c b/drivers/iio/adc/max11410.c
index 6e06c62715a8..437d9f24b5a1 100644
--- a/drivers/iio/adc/max11410.c
+++ b/drivers/iio/adc/max11410.c
@@ -471,9 +471,8 @@ static int max11410_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		mutex_lock(&state->lock);
 
@@ -481,7 +480,7 @@ static int max11410_read_raw(struct iio_dev *indio_dev,
 
 		mutex_unlock(&state->lock);
 
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 
 		if (ret)
 			return ret;
@@ -550,9 +549,8 @@ static int max11410_write_raw(struct iio_dev *indio_dev,
 		if (val != 0 || val2 == 0)
 			return -EINVAL;
 
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		/* Convert from INT_PLUS_MICRO to FRACTIONAL_LOG2 */
 		val2 = val2 * DIV_ROUND_CLOSEST(BIT(24), 1000000);
@@ -561,16 +559,15 @@ static int max11410_write_raw(struct iio_dev *indio_dev,
 
 		st->channels[chan->address].gain = clamp_val(gain, 0, 7);
 
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 
 		return 0;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = __max11410_write_samp_freq(st, val, val2);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 
 		return ret;
 	default:
-- 
2.48.1


