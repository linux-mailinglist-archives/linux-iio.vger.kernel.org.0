Return-Path: <linux-iio+bounces-20191-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31866ACC958
	for <lists+linux-iio@lfdr.de>; Tue,  3 Jun 2025 16:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F993A8540
	for <lists+linux-iio@lfdr.de>; Tue,  3 Jun 2025 14:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549D723ED5E;
	Tue,  3 Jun 2025 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VjgvsLM0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D39E23D282
	for <linux-iio@vger.kernel.org>; Tue,  3 Jun 2025 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748961486; cv=none; b=BdcCoCNYeTYg0EYjAqUMbCMkdZQyxSuoHU13OulkzAGNJ+M/WsP7ZWhVDDbRs/LvyvjGr8n8UKFZIT9tzQk1pjM/lKIZa11kjpE3e9JQjgREpF/K05DMqhH3iiwUfUlZ6YclapIxMqVNSBXMFvPAeJVbf+C3PCjGv4jiPvLK4X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748961486; c=relaxed/simple;
	bh=d59aZ2Zz5gladbRX/062joKsiewywDpcFAgmU/rq5BU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OA99bs2d9gCBWRK52iYFvyAmOydvveFyRbpwb6uIbxhGEfCj74hlTmaOvrZgOisR+ZcV1PUTpkReDQTSXJYWYVGBZPaZUF2ydmj/GeHe0wL6zsmmEWofyHnU2ZhrcbBrL8mxTzEfICedtkkCvBjrmtkOs9Kh++f7Zrp3aGlYFLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VjgvsLM0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-442f4a3a4d6so32821835e9.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Jun 2025 07:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748961481; x=1749566281; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rb7HEQxdoEWONt7GCA176CzXBF9oAj76OvhYL/YxEYU=;
        b=VjgvsLM0f/cltw7FJY7dQFnWAtt01Cc9AnQgZnh0nweb+TnYw7g8jnoJxsMa0R60hK
         ROgk1vCZlmRqHYqgFM8bDhnFKQrwpU8THbmkcS3GY5bfvaKr0Q67u2rQnKBQcfVYYitY
         Kbe9b+rGPpfVDbgzY2eBj8YWAsZYpE6u6B5JOPVPRsOqCKVRUtoMAP7Z5RM0PNQSqbSu
         IQQsImkYiw3/SycMcJVEwERXxblvdfmO2poaUs8OwDJQWiLr9Gs/ClT4qJ//SCA2dJlX
         PEL0zDXfyeIkfRMvGYi56m/HiBxRmeZHmFUs8PW6Ceh4riYvcodAXFzZVnCKczbUPsyq
         7i3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748961481; x=1749566281;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rb7HEQxdoEWONt7GCA176CzXBF9oAj76OvhYL/YxEYU=;
        b=wCA5uDahNZh845CJp9fWKKqdzm/4zazRtayuTIIabZOeHAb9FbeJ3qDz2IhFGWtZj4
         SF4whYRsDPCrsWBHRvHHjjUCzqJoqAYOhdPOMwglyhHB9q6RUfz7xU3WCZFf7PHOKO4n
         Sxqk0jcmAhhcA8vdvp319wZD3biC3Zf1R1iy4QN2tUJmNCD2HsA2Moh2rfykZ44m8SJU
         pow/hIXOwIi/LgDBnrj1ZAHvhNXMsEPz6ImHvPIlcVf7Zg2DKQUXR5zc3ct53WRyYorY
         Id8BuHMalE3cYz43VWLwHXGZCrENYiWQitMMg6bcKZy/zxeYlmn/0SZLSoxAKF3nu9Qz
         9pDw==
X-Gm-Message-State: AOJu0YxVKTywb3pUJB3eSxNrFCBH477MUYmP95GRTe8NZ1+pS4capZq0
	JuEItwSr3YiPNlqZwY5Ql1QMBAkj+PASS6ZsYcrA0AfcbwpXB2wHEDvrnUEtTVkjplU=
X-Gm-Gg: ASbGncsKsMsbLQZVMrcW1LizbZqeTfGr6fx+S1DRZaosb3Dg8RouNHTI0wlMusQqzBH
	HVw6tcF13YJvAEeo4Iw5Y4R7UkGG5Feo4cNyM0Tl3cFrIK9raZQ2Hy1zQcIoucQ8nz7S+RsHP5h
	mObIY5PBdpXCilF+V+wWNeDgvsiVzcVIziUAc6EYMhXz70YSQPWphh7w/+MSIk64Emz3JzSRmHD
	2ceHbNvKd7V1koCNy7ckbikOyqd73+PwK0H7B985AsMNNI41bS53Lb5Q1mMGEg98K8hFKaT9VGZ
	bXwkAfhq+gPPnllOA6cO+rYCQS9ywV2K/EcXsQKS9GpMphlCfJM5YwGa8IVu/5XuY4BSOW6JczF
	DlEdkjWd5V2mlBSVaPI8sD7x7F/BhHX5elis=
X-Google-Smtp-Source: AGHT+IEcFKBgnrwGrJCtYNmhm5AxroVCNiLynN1qVxpW2BYvTLX8a0ohJYt5PjQ/TbVL0tA7rabvCA==
X-Received: by 2002:a05:600c:1d9f:b0:442:d9fb:d9a5 with SMTP id 5b1f17b1804b1-451e65ac356mr28831215e9.9.1748961481336;
        Tue, 03 Jun 2025 07:38:01 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.pool80116.interbusiness.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f1afebsm164430945e9.0.2025.06.03.07.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 07:38:00 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 03 Jun 2025 16:36:28 +0200
Subject: [PATCH v8 6/6] iio: adc: ad7606: add gain calibration support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250603-wip-bl-ad7606-calibration-v8-6-2371e7108f32@baylibre.com>
References: <20250603-wip-bl-ad7606-calibration-v8-0-2371e7108f32@baylibre.com>
In-Reply-To: <20250603-wip-bl-ad7606-calibration-v8-0-2371e7108f32@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6897;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=bvs8fIeq1nHwOu3c93up6s7Yw04NDFLuL8OghW12l8w=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsiw56i4/1h3Qrmg663V6t9KHtYLzn4Quv7X5r0xVWGHy
 nNdmb/kd5SyMIhxMciKKbLUJUaYhN4OlVJewDgbZg4rE8gQBi5OAZiIuzIjw9NLgfkZkt/5Hnl2
 h4pGnoth5y5YManN8H+Mzd30ZUXBJxkZDt/4UTBP11ikzHY5s6WuZWdGb6tDwZ/PJ3Ys/bwyeDI
 TKwA=
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
 drivers/iio/adc/ad7606.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/iio/adc/ad7606.h |  6 +++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index e0a666cc0e14255754e74daa9e1e88bc4ad1665c..22dcb52ced57d4305db6401605c064fc438d5be4 100644
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
@@ -355,6 +363,36 @@ static int ad7606_get_chan_config(struct iio_dev *indio_dev, int ch,
 	return 0;
 }
 
+static int ad7606_chan_calib_gain_setup(struct iio_dev *indio_dev)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	unsigned int num_channels = st->chip_info->num_adc_channels;
+	struct device *dev = st->dev;
+	int ret;
+
+	device_for_each_child_node_scoped(dev, child) {
+		u32 reg, r_gain;
+
+		ret = fwnode_property_read_u32(child, "reg", &reg);
+		if (ret)
+			return ret;
+
+		/* Chan reg is a 1-based index. */
+		if (reg < 1 || reg > num_channels)
+			return -EINVAL;
+
+		r_gain = 0;
+		ret = fwnode_property_read_u32(child, "adi,rfilter-ohms",
+					       &r_gain);
+		if (r_gain > AD7606_CALIB_GAIN_MAX)
+			return -EINVAL;
+
+		st->r_gain[reg - 1] = r_gain;
+	}
+
+	return 0;
+}
+
 static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
 					  struct iio_chan_spec *chan)
 {
@@ -1352,6 +1390,21 @@ static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev)
 	return st->bops->sw_mode_config(indio_dev);
 }
 
+static int ad7606_set_gain_calib(struct ad7606_state *st)
+{
+	int i, ret;
+
+	for (i = 0; i < st->chip_info->num_adc_channels; i++) {
+		ret = st->bops->reg_write(st, AD7606_CALIB_GAIN(i),
+					  DIV_ROUND_CLOSEST(st->r_gain[i],
+					  AD7606_CALIB_GAIN_STEP));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int ad7606_probe_channels(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
@@ -1444,6 +1497,13 @@ static int ad7606_probe_channels(struct iio_dev *indio_dev)
 	if (slow_bus)
 		channels[i] = (struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(i);
 
+	/* Getting gain calibration values for all channels. */
+	if (st->sw_mode_en && st->chip_info->calib_gain_setup_cb) {
+		ret = st->chip_info->calib_gain_setup_cb(indio_dev);
+		if (ret)
+			return ret;
+	}
+
 	indio_dev->channels = channels;
 
 	return 0;
@@ -1620,6 +1680,12 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		st->chip_info->sw_setup_cb(indio_dev);
 	}
 
+	if (st->sw_mode_en && st->chip_info->calib_gain_setup_cb) {
+		ret = ad7606_set_gain_calib(st);
+		if (ret)
+			return ret;
+	}
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(ad7606_probe, "IIO_AD7606");
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index f613583a7fa4095115b0b28e3f8e51cd32b93524..a5b0d318e2f4d73d3708288536e807957c5de68c 100644
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
@@ -131,6 +134,7 @@ struct ad7606_chan_scale {
  * @data:		buffer for reading data from the device
  * @offload_en:		SPI offload enabled
  * @bus_data:		bus-specific variables
+ * @r_gain:		array to store gain calibration resistor value in ohm
  * @d16:		be16 buffer for reading data from the device
  */
 struct ad7606_state {
@@ -161,6 +165,8 @@ struct ad7606_state {
 	bool				offload_en;
 	void				*bus_data;
 
+	int				r_gain[AD760X_MAX_CHANNELS];
+
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.

-- 
2.49.0


