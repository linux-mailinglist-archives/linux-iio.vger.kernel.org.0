Return-Path: <linux-iio+bounces-7628-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D54C931A53
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2024 20:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 233F32830F1
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2024 18:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B28718B1A;
	Mon, 15 Jul 2024 18:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="JRBn5QkJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851A031758
	for <linux-iio@vger.kernel.org>; Mon, 15 Jul 2024 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721068313; cv=none; b=ZK/HJi916nnQQ4+b/IqFYFhaDXsGT69+Z+dusR3Ndw5MUAWuSN0fI3xFmlPWgSo28i1j3jRSB+1Uva3T9PIEuVdsB0o49p8icdMO0PZADTX1voPc3HPWPnPw2NUn8YmTyp353IJE3M1Jex/HgbdRhAX/jl5k/hH+fwA+52yZqhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721068313; c=relaxed/simple;
	bh=WvUVA4dYsnO3pT80qX0evFD4yD2/e3NkR36i8zd8KAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxsXIAoYnbzHhQ2gG21ByvrHsX+ogoip2yf0Df07hXag66L8rYpi+ir1wpZoMdOp5JVl34MDV/mR4UrEFVvbU2zokNl7gH0h8w0+AK06Err13eanD9Bt15+OI7QooK3KSnHHmkyULJ922waYF0DDVTKeSd8u1emlAf4UBG5+/uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=JRBn5QkJ; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id C15438887A;
	Mon, 15 Jul 2024 20:31:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721068309;
	bh=GhPcUF0/Otf5pFSjLPvzpLNUdQ8qiLuLLnBqV4+RCaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JRBn5QkJUbZEZg14A3T/MfvCCP0pX99SgmO6oDKoGA4wsdvPcJL9QoPVs+lwwFRl5
	 QaBNLd0SmUfQr91Y7so1msXysLSAGrbt4Fnfv7zDGzEJ68feT++NPIKuO5wTWATXnp
	 7y1zIEnZPdGNMvz4/EujV6sn1hCHVtRvB3j/q2G9w1/N9XhhPqvfeQxN0XIdIGP39S
	 5iXyttMsmgu347H7+aSiuzmzNrc1Eh6KBpG00xXfRzCZEk6Wdw1JNbsr93Q+jj19OE
	 TVg6toOxFWbDxzdf1v0K5Kr8PFv3TL39Q+vym5NBxkStKDVeu9neTZ1H4QIDWzmE0u
	 Yxb1y4qIUYGHg==
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/5] iio: light: noa1305: Make integration time configurable
Date: Mon, 15 Jul 2024 20:28:59 +0200
Message-ID: <20240715183120.143417-5-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240715183120.143417-1-marex@denx.de>
References: <20240715183120.143417-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Add another attribute which is the integration time. Report available
integration time settings, support read of integration time currently
configured in hardware, and support configuration of integration time
into hardware.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/light/noa1305.c | 61 +++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/iio/light/noa1305.c b/drivers/iio/light/noa1305.c
index e778714a942a0..da83425fd9100 100644
--- a/drivers/iio/light/noa1305.c
+++ b/drivers/iio/light/noa1305.c
@@ -55,6 +55,17 @@ static int noa1305_scale_available[] = {
 	1000000, 625 * 77,	/* 6.25 ms */
 };
 
+static int noa1305_int_time_available[] = {
+	0, 800000,		/* 800 ms */
+	0, 400000,		/* 400 ms */
+	0, 200000,		/* 200 ms */
+	0, 100000,		/* 100 ms */
+	0, 50000,		/* 50 ms */
+	0, 25000,		/* 25 ms */
+	0, 12500,		/* 12.5 ms */
+	0, 6250,		/* 6.25 ms */
+};
+
 struct noa1305_priv {
 	struct i2c_client *client;
 	struct regmap *regmap;
@@ -97,12 +108,30 @@ static int noa1305_scale(struct noa1305_priv *priv, int *val, int *val2)
 	return IIO_VAL_FRACTIONAL;
 }
 
+static int noa1305_int_time(struct noa1305_priv *priv, int *val, int *val2)
+{
+	int data;
+	int ret;
+
+	ret = regmap_read(priv->regmap, NOA1305_REG_INTEGRATION_TIME, &data);
+	if (ret < 0)
+		return ret;
+
+	data &= NOA1305_INTEGR_TIME_MASK;
+	*val = noa1305_int_time_available[2 * data + 0];
+	*val2 = noa1305_int_time_available[2 * data + 1];
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
 static const struct iio_chan_spec noa1305_channels[] = {
 	{
 		.type = IIO_LIGHT,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
 	}
 };
 
@@ -120,6 +149,11 @@ static int noa1305_read_avail(struct iio_dev *indio_dev,
 		*length = ARRAY_SIZE(noa1305_scale_available);
 		*type = IIO_VAL_FRACTIONAL;
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_INT_TIME:
+		*vals = noa1305_int_time_available;
+		*length = ARRAY_SIZE(noa1305_int_time_available);
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
 	}
@@ -139,14 +173,41 @@ static int noa1305_read_raw(struct iio_dev *indio_dev,
 		return noa1305_measure(priv, val);
 	case IIO_CHAN_INFO_SCALE:
 		return noa1305_scale(priv, val, val2);
+	case IIO_CHAN_INFO_INT_TIME:
+		return noa1305_int_time(priv, val, val2);
 	default:
 		return -EINVAL;
 	}
 }
 
+static int noa1305_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct noa1305_priv *priv = iio_priv(indio_dev);
+	int i;
+
+	if (chan->type != IIO_LIGHT)
+		return -EINVAL;
+
+	if (mask != IIO_CHAN_INFO_INT_TIME)
+		return -EINVAL;
+
+	if (val)	/* >= 1s integration time not supported */
+		return -EINVAL;
+
+	/* Look up integration time register settings and write it if found. */
+	for (i = 0; i < ARRAY_SIZE(noa1305_int_time_available); i++)
+		if (noa1305_int_time_available[2 * i + 1] == val2)
+			return regmap_write(priv->regmap, NOA1305_REG_INTEGRATION_TIME, i);
+
+	return -EINVAL;
+}
+
 static const struct iio_info noa1305_info = {
 	.read_avail = noa1305_read_avail,
 	.read_raw = noa1305_read_raw,
+	.write_raw = noa1305_write_raw,
 };
 
 static bool noa1305_writable_reg(struct device *dev, unsigned int reg)
-- 
2.43.0


