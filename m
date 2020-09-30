Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9243C27E321
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 09:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgI3H5w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 03:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgI3H5f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 03:57:35 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B42C0613D3
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2020 00:57:34 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id l126so627298pfd.5
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2020 00:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gw1RFzK+yqUfrbLUb2+nTAxxqoc8k7XTSgedNtFofyE=;
        b=fHoXBFJzW9q1lKzLZ8paOVu1Kp7m4wRQ6AfsR1yl3WZJgS+22rJrctdrcivzvQDUOg
         n5McLJgP2Qd/7LnQZlRmu7tpRXyuyB8et3tsVmRoKenMDmOx+yXJDQ3LgxPZi3ATwet3
         B422ar3HwfHshIWuY8SehOyWkd78+51GnyvqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gw1RFzK+yqUfrbLUb2+nTAxxqoc8k7XTSgedNtFofyE=;
        b=qvQpKeZfCOciNZUvm4Pu+3vb0peojP2zQEEwuS8Op4hpLpt3/8xPJpe30Jm/SZUr2h
         T4BHXym/fGv24ahKlFGnfdIkLxBIGxwBbNMGAh1zCRrg1nrEk0pIHYDWrmymKRR1HyRp
         T9ePsmS872gnzJpzrYff8sN1zVV931hSiZ5nst0sGWs7+Xl3ExSxttQuJJz5daI7qUqd
         x/7vonh7XhBFD/XAbK6l8emuIz0O4yJN8bm77ZL2r+RIvW81HEaX9nz51Krer4c6xOqR
         eT3Pv94BOS5XyfgyORWXDdb9B3mSzMuL5FK71BF1Ach78DBcZiq0tllhnUjhyN7J48uQ
         8kXw==
X-Gm-Message-State: AOAM532e//6jLORQO923D6VBYyGEdi+J36GraiGrkIXN4Z6wemMd+Gjd
        /6zEo7Ca2FoHFx5QrULC+k3cOw==
X-Google-Smtp-Source: ABdhPJw1GlABTjohd8iR+8sFFzcQQOx9J4YlvXW46Cw3p7uoZOHsaGriT8XOILLMhjghBLYAOx08HA==
X-Received: by 2002:a05:6a00:2db:b029:142:2501:34ed with SMTP id b27-20020a056a0002dbb0290142250134edmr1204975pft.70.1601452654504;
        Wed, 30 Sep 2020 00:57:34 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id l21sm1272131pjq.54.2020.09.30.00.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 00:57:34 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH v2 4/6] iio: sx9310: Support setting debounce values
Date:   Wed, 30 Sep 2020 00:57:26 -0700
Message-Id: <20200930075728.2410327-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
In-Reply-To: <20200930075728.2410327-1-swboyd@chromium.org>
References: <20200930075728.2410327-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The rising and falling directions can be debounced in the hardware as
"close" and "far" debounce settings. Add support for these as rising and
falling debounce settings.

Cc: Daniel Campello <campello@chromium.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Evan Green <evgreen@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/iio/proximity/sx9310.c | 100 +++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 9eb10e8263e7..3f909177eca9 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -77,6 +77,8 @@
 #define SX9310_REG_PROX_CTRL10				0x1a
 #define   SX9310_REG_PROX_CTRL10_HYST_MASK		GENMASK(5, 4)
 #define   SX9310_REG_PROX_CTRL10_HYST_6PCT		(0x01 << 4)
+#define   SX9310_REG_PROX_CTRL10_CLOSE_DEBOUNCE_MASK	GENMASK(3, 2)
+#define   SX9310_REG_PROX_CTRL10_FAR_DEBOUNCE_MASK	GENMASK(1, 0)
 #define   SX9310_REG_PROX_CTRL10_FAR_DEBOUNCE_2		0x01
 #define SX9310_REG_PROX_CTRL11				0x1b
 #define SX9310_REG_PROX_CTRL12				0x1c
@@ -147,6 +149,16 @@ struct sx9310_data {
 };
 
 static const struct iio_event_spec sx9310_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
+	},
 	{
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_EITHER,
@@ -601,6 +613,42 @@ static int sx9310_read_hysteresis(struct sx9310_data *data,
 	return IIO_VAL_INT;
 }
 
+static int sx9310_read_far_debounce(struct sx9310_data *data, int *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL10, &regval);
+	if (ret)
+		return ret;
+
+	regval = FIELD_GET(SX9310_REG_PROX_CTRL10_FAR_DEBOUNCE_MASK, regval);
+	if (regval)
+		*val = 1 << regval;
+	else
+		*val = 0;
+
+	return IIO_VAL_INT;
+}
+
+static int sx9310_read_close_debounce(struct sx9310_data *data, int *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL10, &regval);
+	if (ret)
+		return ret;
+
+	regval = FIELD_GET(SX9310_REG_PROX_CTRL10_CLOSE_DEBOUNCE_MASK, regval);
+	if (regval)
+		*val = 1 << regval;
+	else
+		*val = 0;
+
+	return IIO_VAL_INT;
+}
+
 static int sx9310_read_event_val(struct iio_dev *indio_dev,
 				 const struct iio_chan_spec *chan,
 				 enum iio_event_type type,
@@ -615,6 +663,15 @@ static int sx9310_read_event_val(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
 		return sx9310_read_thresh(data, chan, val);
+	case IIO_EV_INFO_PERIOD:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return sx9310_read_far_debounce(data, val);
+		case IIO_EV_DIR_FALLING:
+			return sx9310_read_close_debounce(data, val);
+		default:
+			return -EINVAL;
+		}
 	case IIO_EV_INFO_HYSTERESIS:
 		return sx9310_read_hysteresis(data, chan, val);
 	default:
@@ -682,6 +739,40 @@ static int sx9310_write_hysteresis(struct sx9310_data *data,
 	return ret;
 }
 
+static int sx9310_write_far_debounce(struct sx9310_data *data, int val)
+{
+	int ret;
+	unsigned int regval;
+
+	val = ilog2(val);
+	regval = FIELD_PREP(SX9310_REG_PROX_CTRL10_FAR_DEBOUNCE_MASK, val);
+
+	mutex_lock(&data->mutex);
+	ret = regmap_update_bits(data->regmap, SX9310_REG_PROX_CTRL10,
+				 SX9310_REG_PROX_CTRL10_FAR_DEBOUNCE_MASK,
+				 regval);
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int sx9310_write_close_debounce(struct sx9310_data *data, int val)
+{
+	int ret;
+	unsigned int regval;
+
+	val = ilog2(val);
+	regval = FIELD_PREP(SX9310_REG_PROX_CTRL10_CLOSE_DEBOUNCE_MASK, val);
+
+	mutex_lock(&data->mutex);
+	ret = regmap_update_bits(data->regmap, SX9310_REG_PROX_CTRL10,
+				 SX9310_REG_PROX_CTRL10_CLOSE_DEBOUNCE_MASK,
+				 regval);
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
 static int sx9310_write_event_val(struct iio_dev *indio_dev,
 				  const struct iio_chan_spec *chan,
 				  enum iio_event_type type,
@@ -696,6 +787,15 @@ static int sx9310_write_event_val(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
 		return sx9310_write_thresh(data, chan, val);
+	case IIO_EV_INFO_PERIOD:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return sx9310_write_far_debounce(data, val);
+		case IIO_EV_DIR_FALLING:
+			return sx9310_write_close_debounce(data, val);
+		default:
+			return -EINVAL;
+		}
 	case IIO_EV_INFO_HYSTERESIS:
 		return sx9310_write_hysteresis(data, chan, val);
 	default:
-- 
Sent by a computer, using git, on the internet

