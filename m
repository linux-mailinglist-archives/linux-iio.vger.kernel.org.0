Return-Path: <linux-iio+bounces-13921-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D84A01AEB
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 18:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3743A2EB2
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 17:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAC718C02E;
	Sun,  5 Jan 2025 17:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fok9foc6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10598F6C
	for <linux-iio@vger.kernel.org>; Sun,  5 Jan 2025 17:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736098040; cv=none; b=DzkjPLimbAcFFnKO3U1Q6eop6RnpqplUlTRBQYCKssjnzkYK6zdSIgvm3Uk263tO4OEKBs6qP4iWSkqlmFc9fxqokiFnx97C1IRRMhqV+SrtXEEFDDUDF8uF2525SyTsvfA2NiUzghdpqGWVxK/JipjPvg8+pQ2Sp50SxFz1bvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736098040; c=relaxed/simple;
	bh=KPf/jLRA7SCW4wUrCoTMSteypPI4EMEVIWlbRfbsFZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=co7diX46szLANa5ZHd4/BvClVqcik2DcqUODa/U97XnMavroj/sS+VHuXmou8RRYRu63nvFE3UUYPbesT34l3QM0clIzbDjd5O7BsCoyh+Gzq5RNq+Ifbmb+Z2rt4YytusK8KM4227rI3eTIHE9PfZ0YCNdSGfu2rAHW/lUFa9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fok9foc6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C0FC4CEDD;
	Sun,  5 Jan 2025 17:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736098040;
	bh=KPf/jLRA7SCW4wUrCoTMSteypPI4EMEVIWlbRfbsFZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fok9foc6e/jFv9hK1fwoJ1S/5eFNlkgodZR4EwYMtHPsoMARZ8eEt5gCQoxhdxEk1
	 duurhtVoLVuDQwPJH4B+mEWu5ocTaYjoYFhDHDwffb1PXJrwkks+PMLRvkMuzzXwms
	 UqjYXEoM2NYBMnssLkF6waG/XHdS2UOUoAXkv2NAeHwf83DA+EBiQJ+dT37PVHPmAL
	 aEc8VWumJDPH3mz70T6g4iVKXlk/BdrmDBgtO/adBaEsVBWcoEp+vHcQLx7i+QyJCK
	 bmfY4SxbiOXVDhLk6UFl6pLQPjnfIPdN6RhCzBqinPhWXlkJAHt6PXT1VeLmuWHGL7
	 6YKYQvy6hzEkA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?=E2=80=9CLuc=20Van=20Oostenryck=E2=80=9D?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 22/27] iio: chemical: ens160: Stop using iio_device_claim_direct_scoped()
Date: Sun,  5 Jan 2025 17:26:07 +0000
Message-ID: <20250105172613.1204781-23-jic23@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250105172613.1204781-1-jic23@kernel.org>
References: <20250105172613.1204781-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This complex cleanup.h use case of conditional guards has proved
to be more trouble that it is worth in terms of false positive compiler
warnings and hard to read code.

Move directly to the new claim/release_direct() that allow sparse
to check for unbalanced context.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/chemical/ens160_core.c | 32 ++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/chemical/ens160_core.c b/drivers/iio/chemical/ens160_core.c
index 48d5ad2075b6..152f81ff57e3 100644
--- a/drivers/iio/chemical/ens160_core.c
+++ b/drivers/iio/chemical/ens160_core.c
@@ -100,25 +100,35 @@ static const struct iio_chan_spec ens160_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
+static int __ens160_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val)
+{
+	struct ens160_data *data = iio_priv(indio_dev);
+	int ret;
+
+	guard(mutex)(&data->mutex);
+	ret = regmap_bulk_read(data->regmap, chan->address,
+			       &data->buf, sizeof(data->buf));
+	if (ret)
+		return ret;
+	*val = le16_to_cpu(data->buf);
+	return IIO_VAL_INT;
+}
+
 static int ens160_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long mask)
 {
-	struct ens160_data *data = iio_priv(indio_dev);
 	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			guard(mutex)(&data->mutex);
-			ret = regmap_bulk_read(data->regmap, chan->address,
-					       &data->buf, sizeof(data->buf));
-			if (ret)
-				return ret;
-			*val = le16_to_cpu(data->buf);
-			return IIO_VAL_INT;
-		}
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = __ens160_read_raw(indio_dev, chan, val);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->channel2) {
 		case IIO_MOD_CO2:
-- 
2.47.1


