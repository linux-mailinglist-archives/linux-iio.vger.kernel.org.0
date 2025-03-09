Return-Path: <linux-iio+bounces-16624-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EFFA5860C
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32A6188BEC0
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4701E51FC;
	Sun,  9 Mar 2025 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zrp89IlQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1CD4A0C
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 17:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741540079; cv=none; b=mQqHwIR+ZNEVyN7MJj3xDcHTzL1bCHyns6pVujJ0qoXv6srNl+aglIl6CmrsZM9UgxJHTfLDEGFa/FWfdQaPLd/sHqLIVl4avpj+QDPoSqXm599rSNm5JILBWdDZ7UFt16GA9SQxKopzFtYthWGqIH86XZas/4hmeC1BPHMwMoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741540079; c=relaxed/simple;
	bh=kwCMKNrJoH+FMxxiYYgEY1VAsVZFgXiOohf3BlSMboI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXS2gqDM39MmHEyt/Wm6Ya3BzbBjh045KDo+LZvZJbX12bNdFD3Qerp5QrEpfFSkQQzOPP2IGSR2fS8NVNsIOxbwrz8VN8xCuGhzjYuk5RDarteJ/pMcs3aoXFNuneKZaGJ3uy2HSEQP+1jkzIvMAR5iCXHGWh3X7V1NblnMGag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zrp89IlQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E261C4CEE3;
	Sun,  9 Mar 2025 17:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741540078;
	bh=kwCMKNrJoH+FMxxiYYgEY1VAsVZFgXiOohf3BlSMboI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zrp89IlQNFWklIIxZDdrpnqdqLX7CyZd+Zy6+zIgICbIvsS0f16jEKgdR2PXyY/NW
	 jYHOOdF3Zv4zZM5ylHqy1c7y6o5zi6yOiVMDr5QOxWVn7quAaatA5xWOqtp2jooWO0
	 4QuxI+F+hxdoRS/0pqml9rRi5LjHsHVYopSoc0PIZN/9NKORXWU7kyni3FvuJXae6H
	 A4jUprSwjibd36R3w9oeyiyFiPwyAalgtXx4VtVIN/H6nZocyPSon/uj0GDzEzCaQv
	 p7nEOQF4ZAvvj/HyRpfzUMwPvuQFXpRNAlXDaVSfQpx6VuH+qAcD06yyUwSd/ApcOG
	 E1WEckzQhx4xQ==
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
Subject: [PATCH 18/18] iio: light: vcnl4035: Switch to sparse friendly iio_device_claim/release_direct()
Date: Sun,  9 Mar 2025 17:06:33 +0000
Message-ID: <20250309170633.1347476-19-jic23@kernel.org>
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

This case triggered a false positive from sparse, resolved by
factoring out the code that includes the claim and release of
direct mode.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/vcnl4035.c | 42 ++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 67c94be02018..b2bede9d3daa 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -156,6 +156,31 @@ static int vcnl4035_set_pm_runtime_state(struct vcnl4035_data *data, bool on)
 	return ret;
 }
 
+static int vcnl4035_read_info_raw(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan, int *val)
+{
+	struct vcnl4035_data *data = iio_priv(indio_dev);
+	int ret;
+	int raw_data;
+	unsigned int reg;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	if (chan->channel)
+		reg = VCNL4035_ALS_DATA;
+	else
+		reg = VCNL4035_WHITE_DATA;
+	ret = regmap_read(data->regmap, reg, &raw_data);
+	iio_device_release_direct(indio_dev);
+	if (ret)
+		return ret;
+
+	*val = raw_data;
+
+	return IIO_VAL_INT;
+}
+
 /*
  *	Device IT	INT Time (ms)	Scale (lux/step)
  *	000		50		0.064
@@ -175,28 +200,13 @@ static int vcnl4035_read_raw(struct iio_dev *indio_dev,
 {
 	struct vcnl4035_data *data = iio_priv(indio_dev);
 	int ret;
-	int raw_data;
-	unsigned int reg;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		ret = vcnl4035_set_pm_runtime_state(data, true);
 		if  (ret < 0)
 			return ret;
-
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (!ret) {
-			if (chan->channel)
-				reg = VCNL4035_ALS_DATA;
-			else
-				reg = VCNL4035_WHITE_DATA;
-			ret = regmap_read(data->regmap, reg, &raw_data);
-			iio_device_release_direct_mode(indio_dev);
-			if (!ret) {
-				*val = raw_data;
-				ret = IIO_VAL_INT;
-			}
-		}
+		ret = vcnl4035_read_info_raw(indio_dev, chan, val);
 		vcnl4035_set_pm_runtime_state(data, false);
 		return ret;
 	case IIO_CHAN_INFO_INT_TIME:
-- 
2.48.1


