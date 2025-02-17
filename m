Return-Path: <linux-iio+bounces-15679-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ACBA385E8
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0C41893262
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14386221DA4;
	Mon, 17 Feb 2025 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fapjf+89"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7022212FA2
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801847; cv=none; b=pmQ0apMAU1YsevKhpg4jLpcMoogVlbpqv+algUMdw5fn71LXe/q2h3CjByxuXl3T9jJqO15MvlsHamnPdE4/msDGw604qASKuL6+mfVM6bFpRXblmi2MTmuOH4KHilupBWlMGkLrA6bpml9T3sMME4QK38IJ0GaeIasGEPA0LFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801847; c=relaxed/simple;
	bh=csnHw+U3DnGvCZ2RSAdo8qUvmmZTpoEggvKkm5Do0JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTWaMUBmmbQxVh0LyPlzlRXhOaWwGncy24RrPpP0/4J4B9agOR2NTBipDwLS88o7YQM4wysJ+Ya4NllW6sxf4SFlbKKieFSrOayyu6PBobV39iVi7k/NtuE4n0StjKCvwLQvw1gFzINtn5U/ehW32XcoFT78eDZjXeTFEjbB3gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fapjf+89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC4EC4CEE4;
	Mon, 17 Feb 2025 14:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801847;
	bh=csnHw+U3DnGvCZ2RSAdo8qUvmmZTpoEggvKkm5Do0JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fapjf+89meeGOydvAuyx4F+73VphUbV7qJ9ZC+cBxdTLM+55+sv714ngA1bat48yn
	 Eto4wtzijQSuWjVOVVkl9gWyjCTvpDnzQIrIQAkBd6VhxOlmUywGt3Hx3XjtKbOe8B
	 Tp7NWg2lhdNiKU7QCTtqPpJdErgGiJxYOyjL5nIYEv4DAIqBlHu3oBWOWULBbEMy+j
	 uyXa3pXzkx9PLBOb6Z+p+oxvZJaJCT859MH2N7BgfrbdI4QLeev2gUX8fmlFeAYBvJ
	 ZFeZLEgFfrAm8hXhUdEVe4l9KXSiyTSicuB1udEQflYX4ZTzQxbKXCeAXsZrLUSVTr
	 nFxzJXwGnRJVQ==
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
Subject: [PATCH 07/29] iio: adc: stm32-dfsdm: Factor out core of reading INFO_RAW
Date: Mon, 17 Feb 2025 14:16:07 +0000
Message-ID: <20250217141630.897334-8-jic23@kernel.org>
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

This allows the claim on direct mode to be release in one place
rather than a lot of error paths, simplifying code.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 59 +++++++++++++++++++------------
 1 file changed, 36 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index fe11b0d8eab3..1cf2594d6872 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1306,6 +1306,38 @@ static int stm32_dfsdm_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int __stm32_dfsdm_read_info_raw(struct iio_dev *indio_dev,
+				       struct iio_chan_spec const *chan,
+				       int *val)
+{
+	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
+	int ret = 0;
+
+	if (adc->hwc)
+		ret = iio_hw_consumer_enable(adc->hwc);
+	if (adc->backend)
+		ret = iio_backend_enable(adc->backend[chan->scan_index]);
+	if (ret < 0) {
+		dev_err(&indio_dev->dev,
+			"%s: IIO enable failed (channel %d)\n",
+			__func__, chan->channel);
+		return ret;
+	}
+	ret = stm32_dfsdm_single_conv(indio_dev, chan, val);
+	if (adc->hwc)
+		iio_hw_consumer_disable(adc->hwc);
+	if (adc->backend)
+		iio_backend_disable(adc->backend[chan->scan_index]);
+	if (ret < 0) {
+		dev_err(&indio_dev->dev,
+			"%s: Conversion failed (channel %d)\n",
+			__func__, chan->channel);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan, int *val,
 				int *val2, long mask)
@@ -1326,30 +1358,11 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
 			return ret;
-		if (adc->hwc)
-			ret = iio_hw_consumer_enable(adc->hwc);
-		if (adc->backend)
-			ret = iio_backend_enable(adc->backend[idx]);
-		if (ret < 0) {
-			dev_err(&indio_dev->dev,
-				"%s: IIO enable failed (channel %d)\n",
-				__func__, chan->channel);
-			iio_device_release_direct_mode(indio_dev);
-			return ret;
-		}
-		ret = stm32_dfsdm_single_conv(indio_dev, chan, val);
-		if (adc->hwc)
-			iio_hw_consumer_disable(adc->hwc);
-		if (adc->backend)
-			iio_backend_disable(adc->backend[idx]);
-		if (ret < 0) {
-			dev_err(&indio_dev->dev,
-				"%s: Conversion failed (channel %d)\n",
-				__func__, chan->channel);
-			iio_device_release_direct_mode(indio_dev);
-			return ret;
-		}
+
+		ret = __stm32_dfsdm_read_info_raw(indio_dev, chan, val);
 		iio_device_release_direct_mode(indio_dev);
+		if (ret)
+			return ret;
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-- 
2.48.1


