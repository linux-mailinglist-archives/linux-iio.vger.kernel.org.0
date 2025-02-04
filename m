Return-Path: <linux-iio+bounces-15019-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD566A27C76
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 21:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C093A3B94
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6A621A426;
	Tue,  4 Feb 2025 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imp9RwNV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1191219EAB
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 20:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699503; cv=none; b=GfrALmhlqNYb6nBf9PPL9MImqYW7t9M0mVeyKxb+vNLoGNYug9s8TArtYdLOdfioUHFeakhjd5i4StBGBa7DIVMAQe93fCD0eWnL0sR+v1qtOZtDzoywH5nGHoI9y2YjZEBcaVWt+MrLifi3FN7qK4SMUA5GOpNw8SMnLQnuw08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699503; c=relaxed/simple;
	bh=q5GYZSR15YdatvrqvGQgioN5BJYDjW+MBstI2u2suQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6im5Pl1fT1h50sS4Xk4Ye8CqjcCg9J/nYXl3BhRLTY6S/GqzyMbkYNG/puIA7ShPEsvREpf94rKBen1ffJdhYS/WT/Renc5QR3aqOll5qpKigqxMCIsGkPoLWx/V8pKSAM/+/MdiYxtEx3K/b1mWaql1nPmITNU5EmHpsubaMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imp9RwNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCD9C4CEDF;
	Tue,  4 Feb 2025 20:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699503;
	bh=q5GYZSR15YdatvrqvGQgioN5BJYDjW+MBstI2u2suQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=imp9RwNVrqnId2eOB8fQelsycRcUHFA+YFuTfD5sjy1LiPSkLcO040u9sfxvZ74Ny
	 fSQ632Oyk9hnV0jLFZjdJ1Rj6ihnBy6JMzwbTGQ8k8QS0nkE2tkZZTHfYkiuKbTy/Z
	 zwsaPim8IKYP/uNSUONuktgjZahwwSLFwHzKJxTO0J/GyULi58TpcLiJCfCyVWzFcG
	 Pn9YeNAOpil9uAty/63JH2mg9NqfR5zzCHcT1DXdj7Po8RJ+i+gQi6F8Pr26Mis69u
	 CUrJuevbxibqHXnGACgr1+r35jGH/tC+r5B0Nekz+gvSz3eoOjbGr4ivn8MKkiDGPo
	 cVok8+0EEEDWw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Mariel Tinaco <Mariel.Tinaco@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Guillaume Stols <gstols@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Antoni Pokusinski <apokusinski01@gmail.com>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 24/27] iio: dummy: Stop using iio_device_claim_direct_scoped()
Date: Tue,  4 Feb 2025 20:02:46 +0000
Message-ID: <20250204200250.636721-25-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204200250.636721-1-jic23@kernel.org>
References: <20250204200250.636721-1-jic23@kernel.org>
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
to check for unbalanced context. Introduce two new utility functions
to allow for direct returns with claim and release of direct mode
in the caller.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dummy/iio_simple_dummy.c | 119 ++++++++++++++++-----------
 1 file changed, 70 insertions(+), 49 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
index 09efacaf8f78..8575d4a08963 100644
--- a/drivers/iio/dummy/iio_simple_dummy.c
+++ b/drivers/iio/dummy/iio_simple_dummy.c
@@ -267,6 +267,65 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
 	},
 };
 
+static int __iio_dummy_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val)
+{
+	struct iio_dummy_state *st = iio_priv(indio_dev);
+
+	guard(mutex)(&st->lock);
+	switch (chan->type) {
+	case IIO_VOLTAGE:
+		if (chan->output) {
+			/* Set integer part to cached value */
+			*val = st->dac_val;
+			return IIO_VAL_INT;
+		} else if (chan->differential) {
+			if (chan->channel == 1)
+				*val = st->differential_adc_val[0];
+			else
+				*val = st->differential_adc_val[1];
+			return IIO_VAL_INT;
+		} else {
+			*val = st->single_ended_adc_val;
+			return IIO_VAL_INT;
+		}
+
+	case IIO_ACCEL:
+		*val = st->accel_val;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int __iio_dummy_read_processed(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan,
+				      int *val)
+{
+	struct iio_dummy_state *st = iio_priv(indio_dev);
+
+	guard(mutex)(&st->lock);
+	switch (chan->type) {
+	case IIO_STEPS:
+		*val = st->steps;
+		return IIO_VAL_INT;
+	case IIO_ACTIVITY:
+		switch (chan->channel2) {
+		case IIO_MOD_RUNNING:
+			*val = st->activity_running;
+			return IIO_VAL_INT;
+		case IIO_MOD_WALKING:
+			*val = st->activity_walking;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
 /**
  * iio_dummy_read_raw() - data read function.
  * @indio_dev:	the struct iio_dev associated with this device instance
@@ -283,59 +342,21 @@ static int iio_dummy_read_raw(struct iio_dev *indio_dev,
 			      long mask)
 {
 	struct iio_dummy_state *st = iio_priv(indio_dev);
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW: /* magic value - channel value read */
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			guard(mutex)(&st->lock);
-			switch (chan->type) {
-			case IIO_VOLTAGE:
-				if (chan->output) {
-					/* Set integer part to cached value */
-					*val = st->dac_val;
-					return IIO_VAL_INT;
-				} else if (chan->differential) {
-					if (chan->channel == 1)
-						*val = st->differential_adc_val[0];
-					else
-						*val = st->differential_adc_val[1];
-					return IIO_VAL_INT;
-				} else {
-					*val = st->single_ended_adc_val;
-					return IIO_VAL_INT;
-				}
-
-			case IIO_ACCEL:
-				*val = st->accel_val;
-				return IIO_VAL_INT;
-			default:
-				return -EINVAL;
-			}
-		}
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = __iio_dummy_read_raw(indio_dev, chan, val);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_PROCESSED:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			guard(mutex)(&st->lock);
-			switch (chan->type) {
-			case IIO_STEPS:
-				*val = st->steps;
-				return IIO_VAL_INT;
-			case IIO_ACTIVITY:
-				switch (chan->channel2) {
-				case IIO_MOD_RUNNING:
-					*val = st->activity_running;
-					return IIO_VAL_INT;
-				case IIO_MOD_WALKING:
-					*val = st->activity_walking;
-					return IIO_VAL_INT;
-				default:
-					return -EINVAL;
-				}
-			default:
-				return -EINVAL;
-			}
-		}
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = __iio_dummy_read_processed(indio_dev, chan, val);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_OFFSET:
 		/* only single ended adc -> 7 */
 		*val = 7;
-- 
2.48.1


