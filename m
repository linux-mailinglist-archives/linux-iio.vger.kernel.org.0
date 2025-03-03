Return-Path: <linux-iio+bounces-16275-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18DAA4BF54
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 12:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561263AF14A
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 11:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B5B20E000;
	Mon,  3 Mar 2025 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Kvg5Dv8q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F1F20D50E
	for <linux-iio@vger.kernel.org>; Mon,  3 Mar 2025 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002472; cv=none; b=fKciHqpeOtLefmyFpNG1BjPZbBWhcp9xDsVsa9JrkkZS+qQGpxyN4sbjrRTNjbadZCL5vSRxV3Jbs4CNtjcoAkRx19puY541D6aLkPH42JDtqGGOlBmTQlHHHIczne+KpH8VhJEAA+/OXcf0PXZNzjV/UmD7ygOKYf4JyDdJ44U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002472; c=relaxed/simple;
	bh=f5oXDYngVLmmeCgw3m2NxlkPSjJDX6EDhYcIJAY4bHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hB5yZrwQv6Y/UTxz7wl2OSjMKJ9YewQTtXq1AA30MqmZx3KIS6ZzF4bGqS1dmQ/ijqKy5+cJPlkJ3xN2uFtszMRhlTt4ch7lsA5HIUHW3yuIBqGL7PSYDsCa2YUVc6Vf8IyQqG6lakiGtLKdxQ+aq+P6nr9Nl3yU3GPofYqjxuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Kvg5Dv8q; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43aac0390e8so27135425e9.2
        for <linux-iio@vger.kernel.org>; Mon, 03 Mar 2025 03:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741002469; x=1741607269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oStMvILYc+VcE0Bos6wZo8DhR0OCDR8DIF2cp2zAmw=;
        b=Kvg5Dv8q27F+9fY4+9dvP9nw5dxD/T/cY1xeQpvnMGjlAq+1RCNalf+3aP1HYkxQEh
         WXD2FrvxELzuGwye3gSljMkPK6xi8cfTLdWfNmWKDS2azpxpKRd7833kDc8cOyUe3u2z
         zKEgL2KYqdHrqKAC5raBrIWNmAhQR2SV/Eiectu0Wjvf2xjwUViwPWMsptHGWPa2Md+V
         ui+XdMwAwgC1WxVVNhijfF4Y909WTBbXXGsuFRLvtz6zVTrCmAm6SccUa+5h9y4IlNRa
         MLz6lmX+HqIhAKgcgLs3v/DtSl3tKlMUpF3vjidw51ki3E105Li8HwNM9ptw9dsz5RkB
         BtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002469; x=1741607269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oStMvILYc+VcE0Bos6wZo8DhR0OCDR8DIF2cp2zAmw=;
        b=RlCq70lTvBF0T0sKSLef/smbtEPiAq8Ct3mebMKq4FmoZLZ/gL/GRDm9yUhrkPLrmv
         yMgbtHPhb4160KDU6Lk8QvgqG1pa8LkGyEuL201oGY2DYlavptb95kNV/XDqRIs9TXXp
         iixf3ww68N8RzHz4y187nkn6kQGxT9FC7vKKSYCpzTPvSSHHunKcDtoVGO+hGb3sfqbn
         kpGRS9musQ9werzav9Wm2VHLZUee8AvNNDQZs1kzqStB5pDW3isBocyKPvCzE1fJAcEO
         7BTVB5XRGwes18yb6tbA48qo58nD0VsxUEJAi2a/goCbf58BP82dPwosMtC0MosJkJgf
         7NFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSOMUwVW76VcmHnE8brJpMe8TPF3NAHz747iKnpImVAdMfQsHUX9UC7i/KCM5Ugu1KxMnQaEbzAXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcHbC3mmRNwsAPPjJq37OTM4+C1C/ZGFiloUto5jymEbSeLl4t
	CfNXlax0GspjzIYOeQdtDUA5UrlMEXnK7Fz3lTu+mE4fEbnVKMEHm7ui6ctNKHM=
X-Gm-Gg: ASbGncurqPI5EVbZfaoexKysIREiOjZcVtiW9xDnuV1FP4ThQp3toXYeNs+Z4UIXMNN
	4FQykEajHAS4q7aPGP7BOZR3nF5YDjeXADuDvYNOx7a2jLmYGJZK53pOBUJifY6QZsUny94DwNt
	vQzTjt5E2818bFLpK43Jck2PuNVvCAV3RQgR9TZBzCyg/VSj+hxSOwSlK+PSeq8YUuehny5qLf0
	20VfQ0lqgg5zPyjMNY9h4pLmd66FPnAjbOcldy8DYlqFyMwySsr4QbdL7+PUBwvZ+oYW97TdoUD
	ccyNDKZQzLwzFSkhiZPvL3HMynAvwHhQcJ10gpSQxvsXn2pHPQJDxkchFaMprgiBX8+Xw9MGgG5
	aAwofrnJmICr/3Qd4fNq3Q+ZDnw==
X-Google-Smtp-Source: AGHT+IELfVBNUZ3T62EMT1S63oZc8YXWbdY+myyuSZ9x2ZPWALyNI6M68yP4U9enUx3QzHfaeTngGA==
X-Received: by 2002:a05:600c:5119:b0:439:a25b:e7d3 with SMTP id 5b1f17b1804b1-43ba67047c9mr107630935e9.14.1741002469168;
        Mon, 03 Mar 2025 03:47:49 -0800 (PST)
Received: from localhost (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73702bd0sm158648515e9.10.2025.03.03.03.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:47:48 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Guillaume Ranquet <granquet@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Michael Walle <michael@walle.cc>,
	Nuno Sa <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/8] iio: adc: ad4130: Adapt internal names to match official filter_type ABI
Date: Mon,  3 Mar 2025 12:47:03 +0100
Message-ID: <20250303114659.1672695-15-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303114659.1672695-10-u.kleine-koenig@baylibre.com>
References: <20250303114659.1672695-10-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=10026; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=f5oXDYngVLmmeCgw3m2NxlkPSjJDX6EDhYcIJAY4bHI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnxZbJmgat15ejTK0QQKh7YezB6CM5zXG9qgXEo EJXgAtDlCmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ8WWyQAKCRCPgPtYfRL+ TmOEB/40PrifRoyMnbRW15f0Kc5i2Lyj3lHgreXcSplrKQrQ2yQT8ugWqShJzKm3GrX8Ivmxuay /ROUnJccQp+uZrdP6UXQS4IttUfsMk/wET65liNBPSoQr//Mw0l5Do5jUJ2js0C+MssELsulZMO GmX7KoRlwPum8U2U232iA4nUBn7Ed5XHe140HYOsR2+xvZjC80dc+JGdceUW64U0MgXV34DLLWC K3fjzvFG+dyIBLiLUJOnJ2v5B9lchBTUyoZIER10Eufnf9Z7De+rIT0h+kzY2Z1gry51NVnsr+r 4q/SeYDF5v4+nubYhxlYB8zc3sjL5Gd4Wk4G/iDhUh0jOTDx
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Recently the interface to to select a filter was officially blessed to
use "filter_type". Adapt the naming of several functions accordingly to
make the new standard more present and so make the driver a better
template for other drivers. Apart from the comment update this is just
s/filter_mode/filter_type/.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad4130.c | 84 ++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index 4ab1943c4697..3dbf1d89b671 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -203,7 +203,7 @@ enum ad4130_mode {
 	AD4130_MODE_IDLE = 0b0100,
 };
 
-enum ad4130_filter_mode {
+enum ad4130_filter_type {
 	AD4130_FILTER_SINC4,
 	AD4130_FILTER_SINC4_SINC1,
 	AD4130_FILTER_SINC3,
@@ -234,7 +234,7 @@ struct ad4130_setup_info {
 	unsigned int			pga;
 	unsigned int			fs;
 	u32				ref_sel;
-	enum ad4130_filter_mode		filter_mode;
+	enum ad4130_filter_type		filter_type;
 	bool				ref_bufp;
 	bool				ref_bufm;
 };
@@ -255,7 +255,7 @@ struct ad4130_chan_info {
 };
 
 struct ad4130_filter_config {
-	enum ad4130_filter_mode		filter_mode;
+	enum ad4130_filter_type		filter_type;
 	unsigned int			odr_div;
 	unsigned int			fs_max;
 	enum iio_available_type		samp_freq_avail_type;
@@ -341,9 +341,9 @@ static const unsigned int ad4130_burnout_current_na_tbl[AD4130_BURNOUT_MAX] = {
 	[AD4130_BURNOUT_4000NA] = 4000,
 };
 
-#define AD4130_VARIABLE_ODR_CONFIG(_filter_mode, _odr_div, _fs_max)	\
+#define AD4130_VARIABLE_ODR_CONFIG(_filter_type, _odr_div, _fs_max)	\
 {									\
-		.filter_mode = (_filter_mode),				\
+		.filter_type = (_filter_type),				\
 		.odr_div = (_odr_div),					\
 		.fs_max = (_fs_max),					\
 		.samp_freq_avail_type = IIO_AVAIL_RANGE,		\
@@ -354,9 +354,9 @@ static const unsigned int ad4130_burnout_current_na_tbl[AD4130_BURNOUT_MAX] = {
 		},							\
 }
 
-#define AD4130_FIXED_ODR_CONFIG(_filter_mode, _odr_div)			\
+#define AD4130_FIXED_ODR_CONFIG(_filter_type, _odr_div)			\
 {									\
-		.filter_mode = (_filter_mode),				\
+		.filter_type = (_filter_type),				\
 		.odr_div = (_odr_div),					\
 		.fs_max = AD4130_FILTER_SELECT_MIN,			\
 		.samp_freq_avail_type = IIO_AVAIL_LIST,			\
@@ -378,7 +378,7 @@ static const struct ad4130_filter_config ad4130_filter_configs[] = {
 	AD4130_FIXED_ODR_CONFIG(AD4130_FILTER_SINC3_PF4,      148),
 };
 
-static const char * const ad4130_filter_modes_str[] = {
+static const char * const ad4130_filter_types_str[] = {
 	[AD4130_FILTER_SINC4] = "sinc4",
 	[AD4130_FILTER_SINC4_SINC1] = "sinc4+sinc1",
 	[AD4130_FILTER_SINC3] = "sinc3",
@@ -610,7 +610,7 @@ static bool ad4130_setup_info_eq(struct ad4130_setup_info *a,
 				     unsigned int pga;
 				     unsigned int fs;
 				     u32 ref_sel;
-				     enum ad4130_filter_mode filter_mode;
+				     enum ad4130_filter_type filter_type;
 				     bool ref_bufp;
 				     bool ref_bufm;
 			     }));
@@ -621,7 +621,7 @@ static bool ad4130_setup_info_eq(struct ad4130_setup_info *a,
 	    a->pga != b->pga ||
 	    a->fs != b->fs ||
 	    a->ref_sel != b->ref_sel ||
-	    a->filter_mode != b->filter_mode ||
+	    a->filter_type != b->filter_type ||
 	    a->ref_bufp != b->ref_bufp ||
 	    a->ref_bufm != b->ref_bufm)
 		return false;
@@ -728,7 +728,7 @@ static int ad4130_write_slot_setup(struct ad4130_state *st,
 	if (ret)
 		return ret;
 
-	val = FIELD_PREP(AD4130_FILTER_MODE_MASK, setup_info->filter_mode) |
+	val = FIELD_PREP(AD4130_FILTER_MODE_MASK, setup_info->filter_type) |
 	      FIELD_PREP(AD4130_FILTER_SELECT_MASK, setup_info->fs);
 
 	ret = regmap_write(st->regmap, AD4130_FILTER_X_REG(slot), val);
@@ -872,11 +872,11 @@ static int ad4130_set_channel_enable(struct ad4130_state *st,
  * (used in ad4130_fs_to_freq)
  */
 
-static void ad4130_freq_to_fs(enum ad4130_filter_mode filter_mode,
+static void ad4130_freq_to_fs(enum ad4130_filter_type filter_type,
 			      int val, int val2, unsigned int *fs)
 {
 	const struct ad4130_filter_config *filter_config =
-		&ad4130_filter_configs[filter_mode];
+		&ad4130_filter_configs[filter_type];
 	u64 dividend, divisor;
 	int temp;
 
@@ -895,11 +895,11 @@ static void ad4130_freq_to_fs(enum ad4130_filter_mode filter_mode,
 	*fs = temp;
 }
 
-static void ad4130_fs_to_freq(enum ad4130_filter_mode filter_mode,
+static void ad4130_fs_to_freq(enum ad4130_filter_type filter_type,
 			      unsigned int fs, int *val, int *val2)
 {
 	const struct ad4130_filter_config *filter_config =
-		&ad4130_filter_configs[filter_mode];
+		&ad4130_filter_configs[filter_type];
 	unsigned int dividend, divisor;
 	u64 temp;
 
@@ -911,7 +911,7 @@ static void ad4130_fs_to_freq(enum ad4130_filter_mode filter_mode,
 	*val = div_u64_rem(temp, NANO, val2);
 }
 
-static int ad4130_set_filter_mode(struct iio_dev *indio_dev,
+static int ad4130_set_filter_type(struct iio_dev *indio_dev,
 				  const struct iio_chan_spec *chan,
 				  unsigned int val)
 {
@@ -919,17 +919,17 @@ static int ad4130_set_filter_mode(struct iio_dev *indio_dev,
 	unsigned int channel = chan->scan_index;
 	struct ad4130_chan_info *chan_info = &st->chans_info[channel];
 	struct ad4130_setup_info *setup_info = &chan_info->setup;
-	enum ad4130_filter_mode old_filter_mode;
+	enum ad4130_filter_type old_filter_type;
 	int freq_val, freq_val2;
 	unsigned int old_fs;
 	int ret = 0;
 
 	guard(mutex)(&st->lock);
-	if (setup_info->filter_mode == val)
+	if (setup_info->filter_type == val)
 		return 0;
 
 	old_fs = setup_info->fs;
-	old_filter_mode = setup_info->filter_mode;
+	old_filter_type = setup_info->filter_type;
 
 	/*
 	 * When switching between filter modes, try to match the ODR as
@@ -937,55 +937,55 @@ static int ad4130_set_filter_mode(struct iio_dev *indio_dev,
 	 * using the old filter mode, then convert it back into FS using
 	 * the new filter mode.
 	 */
-	ad4130_fs_to_freq(setup_info->filter_mode, setup_info->fs,
+	ad4130_fs_to_freq(setup_info->filter_type, setup_info->fs,
 			  &freq_val, &freq_val2);
 
 	ad4130_freq_to_fs(val, freq_val, freq_val2, &setup_info->fs);
 
-	setup_info->filter_mode = val;
+	setup_info->filter_type = val;
 
 	ret = ad4130_write_channel_setup(st, channel, false);
 	if (ret) {
 		setup_info->fs = old_fs;
-		setup_info->filter_mode = old_filter_mode;
+		setup_info->filter_type = old_filter_type;
 		return ret;
 	}
 
 	return 0;
 }
 
-static int ad4130_get_filter_mode(struct iio_dev *indio_dev,
+static int ad4130_get_filter_type(struct iio_dev *indio_dev,
 				  const struct iio_chan_spec *chan)
 {
 	struct ad4130_state *st = iio_priv(indio_dev);
 	unsigned int channel = chan->scan_index;
 	struct ad4130_setup_info *setup_info = &st->chans_info[channel].setup;
-	enum ad4130_filter_mode filter_mode;
+	enum ad4130_filter_type filter_type;
 
 	guard(mutex)(&st->lock);
-	filter_mode = setup_info->filter_mode;
+	filter_type = setup_info->filter_type;
 
-	return filter_mode;
+	return filter_type;
 }
 
-static const struct iio_enum ad4130_filter_mode_enum = {
-	.items = ad4130_filter_modes_str,
-	.num_items = ARRAY_SIZE(ad4130_filter_modes_str),
-	.set = ad4130_set_filter_mode,
-	.get = ad4130_get_filter_mode,
+static const struct iio_enum ad4130_filter_type_enum = {
+	.items = ad4130_filter_types_str,
+	.num_items = ARRAY_SIZE(ad4130_filter_types_str),
+	.set = ad4130_set_filter_type,
+	.get = ad4130_get_filter_type,
 };
 
-static const struct iio_chan_spec_ext_info ad4130_filter_mode_ext_info[] = {
+static const struct iio_chan_spec_ext_info ad4130_ext_info[] = {
 	/*
-	 * Intentional duplication of attributes to keep backwards compatibility
-	 * while standardizing over the main IIO ABI for digital filtering.
+	 * `filter_type` is the standardized IIO ABI for digital filtering.
+	 * `filter_mode` is just kept for backwards compatibility.
 	 */
-	IIO_ENUM("filter_mode", IIO_SEPARATE, &ad4130_filter_mode_enum),
+	IIO_ENUM("filter_mode", IIO_SEPARATE, &ad4130_filter_type_enum),
 	IIO_ENUM_AVAILABLE("filter_mode", IIO_SHARED_BY_TYPE,
-			   &ad4130_filter_mode_enum),
-	IIO_ENUM("filter_type", IIO_SEPARATE, &ad4130_filter_mode_enum),
+			   &ad4130_filter_type_enum),
+	IIO_ENUM("filter_type", IIO_SEPARATE, &ad4130_filter_type_enum),
 	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_TYPE,
-			   &ad4130_filter_mode_enum),
+			   &ad4130_filter_type_enum),
 	{ }
 };
 
@@ -999,7 +999,7 @@ static const struct iio_chan_spec ad4130_channel_template = {
 			      BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE) |
 					BIT(IIO_CHAN_INFO_SAMP_FREQ),
-	.ext_info = ad4130_filter_mode_ext_info,
+	.ext_info = ad4130_ext_info,
 	.scan_type = {
 		.sign = 'u',
 		.endianness = IIO_BE,
@@ -1049,7 +1049,7 @@ static int ad4130_set_channel_freq(struct ad4130_state *st,
 	guard(mutex)(&st->lock);
 	old_fs = setup_info->fs;
 
-	ad4130_freq_to_fs(setup_info->filter_mode, val, val2, &fs);
+	ad4130_freq_to_fs(setup_info->filter_type, val, val2, &fs);
 
 	if (fs == setup_info->fs)
 		return 0;
@@ -1141,7 +1141,7 @@ static int ad4130_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ: {
 		guard(mutex)(&st->lock);
-		ad4130_fs_to_freq(setup_info->filter_mode, setup_info->fs,
+		ad4130_fs_to_freq(setup_info->filter_type, setup_info->fs,
 				  val, val2);
 
 		return IIO_VAL_INT_PLUS_NANO;
@@ -1171,7 +1171,7 @@ static int ad4130_read_avail(struct iio_dev *indio_dev,
 		return IIO_AVAIL_LIST;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		scoped_guard(mutex, &st->lock) {
-			filter_config = &ad4130_filter_configs[setup_info->filter_mode];
+			filter_config = &ad4130_filter_configs[setup_info->filter_type];
 		}
 
 		*vals = (int *)filter_config->samp_freq_avail;
-- 
2.47.1


