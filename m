Return-Path: <linux-iio+bounces-19801-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33511AC0CD9
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 15:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C8377B36DF
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 13:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EA828D832;
	Thu, 22 May 2025 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mO3n5S/+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497A328CF6A
	for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747920618; cv=none; b=uYPjKMMTLX7zrBRz8M6I5CRjzGiEmx3OWLA77KuVdLlaglyxiGhXukOJB/3JUXxwKE5t+Lvn37+3WuQGMezst4b2EagJsa3wLwGiSpr9AB3525DivySTD6AgBVCazD9ebdREKGyk+o2Mk0yytasla7kFop78ipd/eMRPw2isAi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747920618; c=relaxed/simple;
	bh=uzcxmVJ06dfQ2tREYWZUQmzhuz1HLysXNqnIbo0pevY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gq0IPtz+KlnMnNCLRXKp0JfLl1cVLULNGJGuPcyqqfIgjOjsm1y281mdj/FtBQhVmJTPBf8DQlHVv+hvpFd/jtQkDjZeZ+L3gslgTlhPyUZ8ifpg+SgZ7fkwoIo9l46a1qfMbT0PJ7Yg1It/DoMWszTjj+luxS5pYyWYNNdtF5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mO3n5S/+; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a37a243388so2974752f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 06:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747920614; x=1748525414; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lT1TbXWqbLY6oC/7pDfmnvkR13CB+3JHqRPljDvsco4=;
        b=mO3n5S/+Iw4bDGbrDCFbV+e/m1IzMeKWC320XgQCY94KEvff3Lf6Z1wxUv8aErrNxL
         BDdSE7Thf6eytYmW8JyyomM9miJ2sz4qes66Mi0uj2VHAPju1+7Z+Y8eNZeV6nBpRrai
         oDA99nRw3xfgHvOjeVAj60R6VwMTGodjE90+9h4gbDpE7m0flIx4Li3sCRP0dUJQNFTv
         vmC9c+0H6kHCE9Ue7EhWjIQXAgm2sO0/LsJgT37k/SJBaz7EO3j4DlYgaUuopDlU5EGp
         hVQnbUlgkkugGzvpbiQUxVtDvkwA1EwmAX8p3uIz92aCZ4vOy1/orQA7P6zFd+FPl8xi
         xdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747920614; x=1748525414;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lT1TbXWqbLY6oC/7pDfmnvkR13CB+3JHqRPljDvsco4=;
        b=QrwHwWO+pgEGEdNE3NsbV7qSnj2ysmEC2uEG1Yu28HarSg7c/5mOzjHtW6PAO/m5KR
         hTVoM25pRzWrybnk9lkL5ywYYalYbuGMlgE+hpi7kInoLA0u8MX9dqpHlsvfI9d/ut/n
         eKCXpmo7gp0woF/eaSEfgwlHvCd0pvo6RLiRn3LIkJyc68dV51ajigzse/lWzBZ+xKjF
         OgI5Uj5WtZ89rWnc1S5H3y0wJ2X8M3gaKsapE1PoNqnUwjdyOv1RqnUQ8J8HQqwTWiXV
         TfXjZ57SxtOGZcQ2nhdDrLyUUgkC+fXGtYNg4latV0hJwL1bTbZyVsYUwdYvkHl1sHP2
         Ek0Q==
X-Gm-Message-State: AOJu0YyCf5XQZS+SAwEc+v+hx7pzRw6MmeVJXWrDyMMw5EpkXrjXI6xB
	fpF1GEDYY/CPWghWkUrgFKE/5KDDkqmp2LcMov2ejvCXgz2Sj1KShpYsXOSpdmfxGjE=
X-Gm-Gg: ASbGncsqCca9siPRGs4BYfnOonFxz1GGk41E8dKORMmbPhDOiEUuTVXjEHSAANwK3ea
	CqI06mW1nnEZVSmT7n4zjcDCpK+F8RwOfKyCynOwgFPpGxZRcrCJ6k4YrYsJmOUCzbSNjCLTslM
	w7K49czxNZHKsk8Hb24CRJbGRkQ1HSK5pHiV+xvsMyGOahsThxnPxNeoTSppTd+0wzeOcbLo4b4
	NkQyU2XOH+631SCcKpA0Q6Wbe9ZSssqhA5wpRvqYJziWVycog6yYGTczLytCZ6U5zewUXsqyXqY
	c627TgB9vZlTgjkZHE8xpsc+lmwv3EOx8tdOi87xc6m5MIwgtIgaGvjtUO/z9yHwVS9B6T6mCkb
	tp4EVBB1MUR6ZdHBWMCTat4M4txOqyOg=
X-Google-Smtp-Source: AGHT+IHF+eVyJCrCz5tU9KpKqSdb8Eipd/fwiZwG9eYHrDNqidXh8VyAPfDGcs0PivpsP5TYxl6OqQ==
X-Received: by 2002:a05:6000:2282:b0:3a3:7bbc:d958 with SMTP id ffacd0b85a97d-3a37bbcdc3bmr9963373f8f.1.1747920614411;
        Thu, 22 May 2025 06:30:14 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f1ef0b20sm109837585e9.14.2025.05.22.06.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 06:30:13 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 22 May 2025 15:27:07 +0200
Subject: [PATCH v6 6/6] iio: adc: ad7606: add gain calibration support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250522-wip-bl-ad7606-calibration-v6-6-487b90433da0@baylibre.com>
References: <20250522-wip-bl-ad7606-calibration-v6-0-487b90433da0@baylibre.com>
In-Reply-To: <20250522-wip-bl-ad7606-calibration-v6-0-487b90433da0@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5640;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=FrnFIjXjnkaraAHZa2fhT+4HMZyAF9OoYi/BTOJJXJg=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsjQV8v78li42GqufW23yOvw1coBLr+UY7ac2syQvermz
 /NRZ5lmdpSyMIhxMciKKbLUJUaYhN4OlVJewDgbZg4rE8gQBi5OAZjIljeMDO9WyH9/IRf6rDfy
 ufT3DzN+6Cnf71TqEH5fPPHVCw+V2suMDL9EXj8+68E9ffN/qfztqdYXrTal3Um2ncbafma+7EV
 xXk4A
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add gain calibration support, using resistor values set on devicetree,
values to be set accordingly with ADC external RFilter, as explained in
the ad7606c-16 datasheet, rev0, page 37.

Usage example in the fdt yaml documentation.

Tested-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/iio/adc/ad7606.h |  3 +++
 2 files changed, 58 insertions(+)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index f832fd0daf50a69a892636018bda2e43f73d1570..00c498afd942724c9241a8c59080f61a3075bca1 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -33,6 +33,10 @@
 
 #include "ad7606.h"
 
+#define AD7606_CALIB_GAIN_MIN	0
+#define AD7606_CALIB_GAIN_STEP	1024
+#define AD7606_CALIB_GAIN_MAX	(63 * AD7606_CALIB_GAIN_STEP)
+
 /*
  * Scales are computed as 5000/32768 and 10000/32768 respectively,
  * so that when applied to the raw values they provide mV values.
@@ -125,6 +129,7 @@ static int ad7609_chan_scale_setup(struct iio_dev *indio_dev,
 				   struct iio_chan_spec *chan);
 static int ad7616_sw_mode_setup(struct iio_dev *indio_dev);
 static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev);
+static int ad7606_chan_calib_gain_setup(struct iio_dev *indio_dev);
 
 const struct ad7606_chip_info ad7605_4_info = {
 	.max_samplerate = 300 * KILO,
@@ -180,6 +185,7 @@ const struct ad7606_chip_info ad7606b_info = {
 	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
 	.sw_setup_cb = ad7606b_sw_mode_setup,
 	.offload_storagebits = 32,
+	.calib_gain_setup_cb = ad7606_chan_calib_gain_setup,
 	.calib_offset_avail = ad7606_calib_offset_avail,
 	.calib_phase_avail = ad7606b_calib_phase_avail,
 };
@@ -195,6 +201,7 @@ const struct ad7606_chip_info ad7606c_16_info = {
 	.scale_setup_cb = ad7606c_16bit_chan_scale_setup,
 	.sw_setup_cb = ad7606b_sw_mode_setup,
 	.offload_storagebits = 32,
+	.calib_gain_setup_cb = ad7606_chan_calib_gain_setup,
 	.calib_offset_avail = ad7606_calib_offset_avail,
 	.calib_phase_avail = ad7606c_calib_phase_avail,
 };
@@ -246,6 +253,7 @@ const struct ad7606_chip_info ad7606c_18_info = {
 	.scale_setup_cb = ad7606c_18bit_chan_scale_setup,
 	.sw_setup_cb = ad7606b_sw_mode_setup,
 	.offload_storagebits = 32,
+	.calib_gain_setup_cb = ad7606_chan_calib_gain_setup,
 	.calib_offset_avail = ad7606c_18bit_calib_offset_avail,
 	.calib_phase_avail = ad7606c_calib_phase_avail,
 };
@@ -355,6 +363,46 @@ static int ad7606_get_chan_config(struct iio_dev *indio_dev, int ch,
 	return 0;
 }
 
+static int ad7606_chan_calib_gain_setup(struct iio_dev *indio_dev)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	unsigned int num_channels = st->chip_info->num_adc_channels;
+	struct device *dev = st->dev;
+	int ret;
+
+	/*
+	 * This function is called once, and parses all the channel nodes,
+	 * so continuing on next channel node on errors, informing of them.
+	 */
+	device_for_each_child_node_scoped(dev, child) {
+		u32 reg, r_gain;
+
+		ret = fwnode_property_read_u32(child, "reg", &reg);
+		if (ret)
+			return ret;
+
+		/* Chan reg is a 1-based index. */
+		if (reg < 1 || reg > num_channels)
+			return ret;
+
+		ret = fwnode_property_read_u32(child, "adi,rfilter-ohms",
+					       &r_gain);
+		if (ret)
+			/* Keep the default register value. */
+			continue;
+
+		if (r_gain > AD7606_CALIB_GAIN_MAX)
+			return -EINVAL;
+
+		ret = st->bops->reg_write(st, AD7606_CALIB_GAIN(reg - 1),
+			DIV_ROUND_CLOSEST(r_gain, AD7606_CALIB_GAIN_STEP));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
 					  struct iio_chan_spec *chan)
 {
@@ -1446,6 +1494,13 @@ static int ad7606_probe_channels(struct iio_dev *indio_dev)
 	if (slow_bus)
 		channels[i] = (struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(i);
 
+	/* Setting up gain calibration for all channels. */
+	if (st->sw_mode_en && st->chip_info->calib_offset_avail) {
+		ret = st->chip_info->calib_gain_setup_cb(indio_dev);
+		if (ret)
+			return ret;
+	}
+
 	indio_dev->channels = channels;
 
 	return 0;
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index f613583a7fa4095115b0b28e3f8e51cd32b93524..6313eea2bd0ccf97222a50dc26d8ec65042d0db7 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -50,6 +50,7 @@ struct ad7606_state;
 typedef int (*ad7606_scale_setup_cb_t)(struct iio_dev *indio_dev,
 				       struct iio_chan_spec *chan);
 typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
+typedef int (*ad7606_calib_gain_setup_cb_t)(struct iio_dev *indio_dev);
 
 /**
  * struct ad7606_chip_info - chip specific information
@@ -66,6 +67,7 @@ typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
  * @init_delay_ms:	required delay in milliseconds for initialization
  *			after a restart
  * @offload_storagebits: storage bits used by the offload hw implementation
+ * @calib_gain_setup_cb: callback to setup of gain calibration
  * @calib_offset_avail: pointer to offset calibration range/limits array
  * @calib_phase_avail:  pointer to phase calibration range/limits array
  */
@@ -81,6 +83,7 @@ struct ad7606_chip_info {
 	bool				os_req_reset;
 	unsigned long			init_delay_ms;
 	u8				offload_storagebits;
+	ad7606_calib_gain_setup_cb_t	calib_gain_setup_cb;
 	const int			*calib_offset_avail;
 	const int			(*calib_phase_avail)[2];
 };

-- 
2.49.0


