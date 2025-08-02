Return-Path: <linux-iio+bounces-22210-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9B4B18F77
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 18:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 376097AB560
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 16:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC93248F5C;
	Sat,  2 Aug 2025 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3ZQlifm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F328246794
	for <linux-iio@vger.kernel.org>; Sat,  2 Aug 2025 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754153172; cv=none; b=hi4f92eJgBOSITZXQyo1RLO8esZIHitxGM1kH4mhxlpLydu2MCY8HtLlz4vRFpcm3LiGPl/4s+XTjA05sTK9ORtO3DkV99OjD+R7JWIG/NMJkHLpA33c8Od6d6SFIIm+UyNEioiuBjqG9xhdGDil8Q+yIpPjobLRFrxcBdZZBao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754153172; c=relaxed/simple;
	bh=7e1f5GgsGo+rFH4GNGGXBzTAVgysQxZMUXsExrZsOa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8BAUryD2pY3D48UPeS5TPSfarjBjOdb/ezDa7wa0F5+ksFGmtyBETctagv4kC8n+w+UO708f1E8HOQ2gdVWChyX+WAgZg9of+G7/ORZ8C3ATml1tLYUInm5R3M25DbUeKR2P7CfePWLnA+GqKq4ZG0qaugyH+wCVWlMsqa/HTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3ZQlifm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99310C4CEEF;
	Sat,  2 Aug 2025 16:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754153172;
	bh=7e1f5GgsGo+rFH4GNGGXBzTAVgysQxZMUXsExrZsOa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G3ZQlifmfpUz30/ga1TxZeTDW4bsA2/dNmsB535/pacE7EbOxy652CqeVw2RH4ejf
	 ykh02Tguh7TLhbmOPPQe3kXCRjd42Res2sbCd3yV2UaLgQ8Tgv8fkcrI9IKwejGlq/
	 HFedtECFzCM7w8+l4Ku6qTA/kuldY8wJWANytH093blIR48+1IbAF+8rkmHXqmWOhn
	 woU7yhcNupl/Li1yknUlZbxJ0YrY22Yp2d/N3ZMkUPEE5/wKobl2E4EvRuxkOdntdA
	 y2xCpL60u+KdEcXUcR4RciVTlLXq+iVZc8mLOr/yFtbiTQwCALc/FYTO2XSP4medHb
	 LFGJuEX2ivTCw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Abhash Jha <abhashkumarjha123@gmail.com>,
	Astrid Rost <astrid.rost@axis.com>,
	=?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Christian Eggers <ChristianEggersceggers@arri.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 12/16] iio: light: tcs3414: Use iio_push_to_buffers_with_ts() to allow source size runtime check
Date: Sat,  2 Aug 2025 17:44:32 +0100
Message-ID: <20250802164436.515988-13-jic23@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250802164436.515988-1-jic23@kernel.org>
References: <20250802164436.515988-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Also move the structure used as the source to the stack as it is only 16
bytes and not the target of an DMA or similar.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/tcs3414.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
index 39268f855c77..5be461e6dbdb 100644
--- a/drivers/iio/light/tcs3414.c
+++ b/drivers/iio/light/tcs3414.c
@@ -53,11 +53,6 @@ struct tcs3414_data {
 	u8 control;
 	u8 gain;
 	u8 timing;
-	/* Ensure timestamp is naturally aligned */
-	struct {
-		u16 chans[4];
-		aligned_s64 timestamp;
-	} scan;
 };
 
 #define TCS3414_CHANNEL(_color, _si, _addr) { \
@@ -204,6 +199,12 @@ static irqreturn_t tcs3414_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct tcs3414_data *data = iio_priv(indio_dev);
 	int i, j = 0;
+	/* Ensure timestamp is naturally aligned */
+	struct {
+		u16 chans[4];
+		aligned_s64 timestamp;
+	} scan = { };
+
 
 	iio_for_each_active_channel(indio_dev, i) {
 		int ret = i2c_smbus_read_word_data(data->client,
@@ -211,10 +212,10 @@ static irqreturn_t tcs3414_trigger_handler(int irq, void *p)
 		if (ret < 0)
 			goto done;
 
-		data->scan.chans[j++] = ret;
+		scan.chans[j++] = ret;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
 		iio_get_time_ns(indio_dev));
 
 done:
-- 
2.50.1


