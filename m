Return-Path: <linux-iio+bounces-19282-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FF1AAF77A
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 12:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4253A8BA5
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 10:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1777220F4D;
	Thu,  8 May 2025 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LP8kkEhB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893981F7904
	for <linux-iio@vger.kernel.org>; Thu,  8 May 2025 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746698850; cv=none; b=kQT7mVO053mZIeHpsz07XySaX3Z/wtxFkvH0A6jRrslk2eN0ribQ/Mbw9dP9JiTE3EJ0gzo1aUpJk7n9M6Q3UGogUrGvl9eVTx2we5vLu2zgyWQXKTeByVAJk2FeUwXzR8NCHOGu9QgQAfClNchdhEZKzCqAeTzsMl+L1UIOyrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746698850; c=relaxed/simple;
	bh=9bBOS/0ntbmChBTvXIdn7mA34DT+PnX0QF+rbGzxdGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oxR6xpuVFbRMNreddF6VGFG0YUmyHVJgpHtwEuD26CQLF1o+Z/HLrLvNFlYV41zBx8A5/D3sgBv/osuB4zY5uSpQjVG2xGXUg1HaJg+TkS15q7yx8xIPX2uau8T+e31agRX1r14nEUBT0FQKw02U0ep4D+UY4i2yajXDWB4DxYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LP8kkEhB; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cfe574976so5305405e9.1
        for <linux-iio@vger.kernel.org>; Thu, 08 May 2025 03:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746698847; x=1747303647; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QUpwY7ya7B0Chhz+iwJiZbHzkFF5gSMkeXJnzI0Aa8k=;
        b=LP8kkEhBI3Fitn6OihyYOKRacdXIga4LHm++KpEOaaqaszMT8I3ZsQqtQyC2PyoVUm
         qxJGVS271ZeHSRzTjeYs8Lb57w0LQMa7muocVfqGxcVUYvGdv7epzifXNi0uVvk9CMdC
         gVOm1HooopmZLARhxNM0EK43Xzs1Z3ULaMfWXrqEXVaTHNufMUi29eJsNmQoCbfCWwSV
         qWU72hntLjhS+pi6OQ3Rb+yH7rkxmbAXpgCkccc5C1ESM3VV8iV48n6g0Hq7TwidLj0u
         +hRW0ORnclH5x7zquaTa8+N6cn5Y8PWcpKijjg24MAzh88hbEIgEqF3t5WVMB8grrXNp
         7Djg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746698847; x=1747303647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUpwY7ya7B0Chhz+iwJiZbHzkFF5gSMkeXJnzI0Aa8k=;
        b=U/p0tO2n108hDtHLQomrIoW/pmjduWTG6AVKhu7CqlgXhzn+ONe6Vkvwtn3eroOECI
         x/nM3ftypJKvnJ4BvoFlUNckYGS9sjhJ+fb7lyw9CfbcnOJc9o+nfWJGm9id7gDQXeG3
         RNsg/oB5kwLTMdBu2/ZWad5JbXH6YXyXMah6jKZ8ihXNI2/oijif50TqGsWmtNhlFW8I
         91RNC/zmiZCFyWvG4I1IWWDZaIQY105UV3CbLGahobA3dsYW5Z9SaUefVcKLBL9b2uK1
         xnA8X3DP9vTBVb54GttF8dNG7YoTdcZoponMXvPt4BtTX9tRssgTww3xkoe9CQP2Uc6X
         Kp+A==
X-Gm-Message-State: AOJu0YwsoZDYJVhSgsJFUhufEfC/VlhAJ6F8/NgM8Mtx3RhYC1Iy7ron
	KiROnare+xcH0+WEUhobQlU8/9YCTlgI7zI994fNkwoggbADyubXD+Ofds9SCnk=
X-Gm-Gg: ASbGncunBz6Gt1sDePAHRSMHJJ0bwYd6bjV7g30+AAJhuOM6w9MPp4Nt+32BrxVIPkW
	GFEWEpXzRDcCJLhP3SL3XrTPbiVM1vBTLwwzztlmN4XcFDbP9d4uj6BSKonLIdtJ8ai9zAN3UlE
	j6d+keKFtnS8GhDr/go9qehhfa63z4gDrDo/GfOxRQB/Kx4Nj9g2qPnVWAUmQXX2J4LMCH7lW/Y
	Eg7KiA9dnUlO7Vlcbtp5xqFc5m4W2mljNkHUc75xY2i6aEDh6AU61KdfTdd6bs96a9GbZBbdcUd
	xb0ZQedSHWDitTUMovdnIZbcgN2pU8QUZgTWesQSVvuO67NVmud2eNDytyX4hdRmPV6MYSVbp2i
	XpKLPnqEutyzg
X-Google-Smtp-Source: AGHT+IE6mlfTLQz1/O9/8Ciru6ltbfXTCNp7lTWaNLU0qD5Hj+4gVaEyX+R8g5QKvwT0zr7eHzyCiQ==
X-Received: by 2002:a05:600c:4f52:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-441d44dd407mr45484575e9.23.1746698846815;
        Thu, 08 May 2025 03:07:26 -0700 (PDT)
Received: from [192.168.0.2] (host-87-8-31-78.retail.telecomitalia.it. [87.8.31.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd363940sm31699665e9.25.2025.05.08.03.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 03:07:26 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 08 May 2025 12:06:07 +0200
Subject: [PATCH v4 3/5] iio: adc: ad7606: add offset and phase calibration
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250508-wip-bl-ad7606-calibration-v4-3-91a3f2837e6b@baylibre.com>
References: <20250508-wip-bl-ad7606-calibration-v4-0-91a3f2837e6b@baylibre.com>
In-Reply-To: <20250508-wip-bl-ad7606-calibration-v4-0-91a3f2837e6b@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9430;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=3PXmVxCz6657mCdpDOhkR+/JCD3hi9i1/g3nOKo+7HM=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsiQaeKX37GolbfU+7XPJc1aj5xdRnfW3GC5lvnSpCTCe
 of1RsfyjlIWBjEuBlkxRZa6xAiT0NuhUsoLGGfDzGFlAhnCwMUpABPZfoDhf/AzDeWkqPVl6k0L
 Aj7vujDzQ5DRVZ8MgYVKZzlUHPanbWT4KyPVe11kzYYr+hOtLxw+zsP3MuhpfWzzbXve5VazX/3
 ZwA4A
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add support for offset and phase calibration, only for
devices that support software mode, that are:

ad7606b
ad7606c-16
ad7606c-18

Tested-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 160 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/iio/adc/ad7606.h |   9 +++
 2 files changed, 169 insertions(+)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 2aa59481c52c07537110e7fc1fd1aedbab6b098d..a986eb1284106da4980ac36cb0b5990e4e3bd948 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -95,6 +95,22 @@ static const unsigned int ad7616_oversampling_avail[8] = {
 	1, 2, 4, 8, 16, 32, 64, 128,
 };
 
+static const int ad7606_calib_offset_avail[3] = {
+	-128, 1, 127,
+};
+
+static const int ad7606c_18bit_calib_offset_avail[3] = {
+	-512, 4, 508,
+};
+
+static const int ad7606b_calib_phase_avail[][2] = {
+	{ 0, 0 }, { 0, 1250 }, { 0, 318750 },
+};
+
+static const int ad7606c_calib_phase_avail[][2] = {
+	{ 0, 0 }, { 0, 1000 }, { 0, 255000 },
+};
+
 static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
 					  struct iio_chan_spec *chan);
 static int ad7606c_16bit_chan_scale_setup(struct iio_dev *indio_dev,
@@ -164,6 +180,8 @@ const struct ad7606_chip_info ad7606b_info = {
 	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
 	.sw_setup_cb = ad7606b_sw_mode_setup,
 	.offload_storagebits = 32,
+	.calib_offset_avail = ad7606_calib_offset_avail,
+	.calib_phase_avail = ad7606b_calib_phase_avail,
 };
 EXPORT_SYMBOL_NS_GPL(ad7606b_info, "IIO_AD7606");
 
@@ -177,6 +195,8 @@ const struct ad7606_chip_info ad7606c_16_info = {
 	.scale_setup_cb = ad7606c_16bit_chan_scale_setup,
 	.sw_setup_cb = ad7606b_sw_mode_setup,
 	.offload_storagebits = 32,
+	.calib_offset_avail = ad7606_calib_offset_avail,
+	.calib_phase_avail = ad7606c_calib_phase_avail,
 };
 EXPORT_SYMBOL_NS_GPL(ad7606c_16_info, "IIO_AD7606");
 
@@ -226,6 +246,8 @@ const struct ad7606_chip_info ad7606c_18_info = {
 	.scale_setup_cb = ad7606c_18bit_chan_scale_setup,
 	.sw_setup_cb = ad7606b_sw_mode_setup,
 	.offload_storagebits = 32,
+	.calib_offset_avail = ad7606c_18bit_calib_offset_avail,
+	.calib_phase_avail = ad7606c_calib_phase_avail,
 };
 EXPORT_SYMBOL_NS_GPL(ad7606c_18_info, "IIO_AD7606");
 
@@ -683,6 +705,40 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
 	return ret;
 }
 
+static int ad7606_get_calib_offset(struct ad7606_state *st, int ch, int *val)
+{
+	int ret;
+
+	ret = st->bops->reg_read(st, AD7606_CALIB_OFFSET(ch));
+	if (ret < 0)
+		return ret;
+
+	*val = st->chip_info->calib_offset_avail[0] + ret *
+		st->chip_info->calib_offset_avail[1];
+
+	return 0;
+}
+
+static int ad7606_get_calib_phase(struct ad7606_state *st, int ch, int *val,
+				  int *val2)
+{
+	int ret;
+
+	ret = st->bops->reg_read(st, AD7606_CALIB_PHASE(ch));
+	if (ret < 0)
+		return ret;
+
+	*val = 0;
+
+	/*
+	 * ad7606b: phase delay from 0 to 318.75 μs in steps of 1.25 μs.
+	 * ad7606c-16/18: phase delay from 0 µs to 255 µs in steps of 1 µs.
+	 */
+	*val2 = ret * st->chip_info->calib_phase_avail[1][1];
+
+	return 0;
+}
+
 static int ad7606_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val,
@@ -717,6 +773,22 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 		pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
 		*val = DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, cnvst_pwm_state.period);
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = ad7606_get_calib_offset(st, chan->scan_index, val);
+		iio_device_release_direct(indio_dev);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CONVDELAY:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = ad7606_get_calib_phase(st, chan->scan_index, val, val2);
+		iio_device_release_direct(indio_dev);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT_PLUS_NANO;
 	}
 	return -EINVAL;
 }
@@ -767,6 +839,64 @@ static int ad7606_write_os_hw(struct iio_dev *indio_dev, int val)
 	return 0;
 }
 
+static int ad7606_set_calib_offset(struct ad7606_state *st, int ch, int val)
+{
+	int start_val, step_val, stop_val;
+
+	start_val = st->chip_info->calib_offset_avail[0];
+	step_val = st->chip_info->calib_offset_avail[1];
+	stop_val = st->chip_info->calib_offset_avail[2];
+
+	if (val < start_val || val > stop_val)
+		return -EINVAL;
+
+	val -= start_val;
+	val /= step_val;
+
+	return st->bops->reg_write(st, AD7606_CALIB_OFFSET(ch), val);
+}
+
+static int ad7606_set_calib_phase(struct ad7606_state *st, int ch, int val,
+				  int val2)
+{
+	int wreg, start_ns, step_ns, stop_ns;
+
+	if (val != 0)
+		return -EINVAL;
+
+	start_ns = st->chip_info->calib_phase_avail[0][1];
+	step_ns = st->chip_info->calib_phase_avail[1][1];
+	stop_ns = st->chip_info->calib_phase_avail[2][1];
+
+	/*
+	 * ad7606b: phase delay from 0 to 318.75 μs in steps of 1.25 μs.
+	 * ad7606c-16/18: phase delay from 0 µs to 255 µs in steps of 1 µs.
+	 */
+	if (val2 < start_ns || val2 > stop_ns)
+		return -EINVAL;
+
+	wreg = val2 / step_ns;
+
+	return st->bops->reg_write(st, AD7606_CALIB_PHASE(ch), wreg);
+}
+
+static int ad7606_write_raw_get_fmt(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan, long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CONVDELAY:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int ad7606_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val,
@@ -820,6 +950,18 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 		if (val < 0 && val2 != 0)
 			return -EINVAL;
 		return ad7606_set_sampling_freq(st, val);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = ad7606_set_calib_offset(st, chan->scan_index, val);
+		iio_device_release_direct(indio_dev);
+		return ret;
+	case IIO_CHAN_INFO_CONVDELAY:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = ad7606_set_calib_phase(st, chan->scan_index, val, val2);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	default:
 		return -EINVAL;
 	}
@@ -998,6 +1140,14 @@ static int ad7606_read_avail(struct iio_dev *indio_dev,
 		*type = IIO_VAL_INT_PLUS_MICRO;
 
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*vals = st->chip_info->calib_offset_avail;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_RANGE;
+	case IIO_CHAN_INFO_CONVDELAY:
+		*vals = (const int *)st->chip_info->calib_phase_avail;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		return IIO_AVAIL_RANGE;
 	}
 	return -EINVAL;
 }
@@ -1060,6 +1210,7 @@ static const struct iio_info ad7606_info_sw_mode = {
 	.read_raw = &ad7606_read_raw,
 	.write_raw = &ad7606_write_raw,
 	.read_avail = &ad7606_read_avail,
+	.write_raw_get_fmt = ad7606_write_raw_get_fmt,
 	.debugfs_reg_access = &ad7606_reg_access,
 	.validate_trigger = &ad7606_validate_trigger,
 	.update_scan_mode = &ad7606_update_scan_mode,
@@ -1252,6 +1403,15 @@ static int ad7606_probe_channels(struct iio_dev *indio_dev)
 			chan->info_mask_separate_available |=
 				BIT(IIO_CHAN_INFO_SCALE);
 
+			if (st->chip_info->calib_offset_avail) {
+				chan->info_mask_separate |=
+					BIT(IIO_CHAN_INFO_CALIBBIAS) |
+					BIT(IIO_CHAN_INFO_CONVDELAY);
+				chan->info_mask_separate_available |=
+					BIT(IIO_CHAN_INFO_CALIBBIAS) |
+					BIT(IIO_CHAN_INFO_CONVDELAY);
+			}
+
 			/*
 			 * All chips with software mode support oversampling,
 			 * so we skip the oversampling_available check. And the
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 441e62c521bcbea69b4f70bb2d55f65334d22276..f613583a7fa4095115b0b28e3f8e51cd32b93524 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -40,6 +40,11 @@
 #define AD7606_RANGE_CH_ADDR(ch)	(0x03 + ((ch) >> 1))
 #define AD7606_OS_MODE			0x08
 
+#define AD7606_CALIB_GAIN(ch)		(0x09 + (ch))
+#define AD7606_CALIB_GAIN_MASK		GENMASK(5, 0)
+#define AD7606_CALIB_OFFSET(ch)		(0x11 + (ch))
+#define AD7606_CALIB_PHASE(ch)		(0x19 + (ch))
+
 struct ad7606_state;
 
 typedef int (*ad7606_scale_setup_cb_t)(struct iio_dev *indio_dev,
@@ -61,6 +66,8 @@ typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
  * @init_delay_ms:	required delay in milliseconds for initialization
  *			after a restart
  * @offload_storagebits: storage bits used by the offload hw implementation
+ * @calib_offset_avail: pointer to offset calibration range/limits array
+ * @calib_phase_avail:  pointer to phase calibration range/limits array
  */
 struct ad7606_chip_info {
 	unsigned int			max_samplerate;
@@ -74,6 +81,8 @@ struct ad7606_chip_info {
 	bool				os_req_reset;
 	unsigned long			init_delay_ms;
 	u8				offload_storagebits;
+	const int			*calib_offset_avail;
+	const int			(*calib_phase_avail)[2];
 };
 
 /**

-- 
2.49.0


