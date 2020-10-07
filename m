Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEAF285623
	for <lists+linux-iio@lfdr.de>; Wed,  7 Oct 2020 03:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgJGBRm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Oct 2020 21:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgJGBRm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Oct 2020 21:17:42 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931C7C0613D4
        for <linux-iio@vger.kernel.org>; Tue,  6 Oct 2020 18:17:40 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 34so314898pgo.13
        for <linux-iio@vger.kernel.org>; Tue, 06 Oct 2020 18:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wwcKo51Wb1Z8EGzntv8DWG85B5SZsF7AJ7GbGFyxohQ=;
        b=Jyb3RvSAMZGM7KSDjSeqpe4m8AAoVyAvRkrSXmCC7gzSrTUIPymZDjTzh4QFM+K6aw
         JIcSgkao5+8OuKHZBfTCbZpCmBA8qIR9Hp0/hI7XhsS6w9KdNwnUIkeKnvWMKioOtx1I
         6tJp1qJj28VVg7wtXBWzwLhadspF58dsZeuYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wwcKo51Wb1Z8EGzntv8DWG85B5SZsF7AJ7GbGFyxohQ=;
        b=P0MiJvWVQeEN6TkBfiMt2SVsjXbeD7cC2NR2Fl+q4b70ZRE+EpaMlX1JMonqnZDkbL
         Ed/gNw8UaNNblgUxdZwKxD9UdqXGZsorNzSW+uHwN3llLdwRskEZZ0mtLSWTgNHJsWPb
         qW0AnjrvwKAmYR0Lh0X9KlevuqSgmjVL4wX8nWHjR0nuGbMGjKeb+e06OC+IL6s/J1Dz
         LH74JUuYrDfgk5C60HpfJn/ozKnwgfPO3ABDXphEpUcITd1BCO+e93UX2+8mVfkVnUcD
         +xRd+IfIhGtfyjgn1bLNdoZcaZwpZP2sk10GAqbJWQ94HXH/5+ExStXmQWPAGLdF9+BN
         YyTw==
X-Gm-Message-State: AOAM533H3dC8MBvEfKwwxXAP7qZqygqCbkwCC+UvpJ+z4QtJf3m2FZOY
        eOGszQm4MvBYAtFkj2oEAm30fg==
X-Google-Smtp-Source: ABdhPJz9psZfDbPlXxoosYLG7JwYe/vPGGUY191I0C4oWFpK03/Eccr1qI/p+bvmUFLN8iVqKLeTzg==
X-Received: by 2002:a63:f807:: with SMTP id n7mr810721pgh.311.1602033460124;
        Tue, 06 Oct 2020 18:17:40 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id z190sm482654pfc.89.2020.10.06.18.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 18:17:39 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH v3 2/6] iio: sx9310: Support setting proximity thresholds
Date:   Tue,  6 Oct 2020 18:17:31 -0700
Message-Id: <20201007011735.1346994-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
In-Reply-To: <20201007011735.1346994-1-swboyd@chromium.org>
References: <20201007011735.1346994-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support to set the proximity thresholds for each channel.

Cc: Daniel Campello <campello@chromium.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Evan Green <evgreen@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/iio/proximity/sx9310.c | 114 +++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 030397a85845..35e927dc4f66 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -68,6 +68,7 @@
 #define   SX9310_REG_PROX_CTRL7_AVGNEGFILT_2		(0x01 << 3)
 #define   SX9310_REG_PROX_CTRL7_AVGPOSFILT_512		0x05
 #define SX9310_REG_PROX_CTRL8				0x18
+#define   SX9310_REG_PROX_CTRL8_9_PTHRESH_MASK		GENMASK(7, 3)
 #define SX9310_REG_PROX_CTRL9				0x19
 #define   SX9310_REG_PROX_CTRL8_9_PTHRESH_28		(0x08 << 3)
 #define   SX9310_REG_PROX_CTRL8_9_PTHRESH_96		(0x11 << 3)
@@ -531,6 +532,117 @@ static int sx9310_read_avail(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static const unsigned int sx9310_pthresh_codes[] = {
+	2, 4, 6, 8, 12, 16, 20, 24, 28, 32, 40, 48, 56, 64, 72, 80, 88, 96, 112,
+	128, 144, 160, 192, 224, 256, 320, 384, 512, 640, 768, 1024, 1536
+};
+
+static int sx9310_get_thresh_reg(unsigned int channel)
+{
+	switch (channel) {
+	case 0:
+	case 3:
+		return SX9310_REG_PROX_CTRL8;
+	case 1:
+	case 2:
+		return SX9310_REG_PROX_CTRL9;
+	}
+
+	return -EINVAL;
+}
+
+static int sx9310_read_thresh(struct sx9310_data *data,
+			      const struct iio_chan_spec *chan, int *val)
+{
+	unsigned int reg;
+	unsigned int regval;
+	int ret;
+
+	reg = ret = sx9310_get_thresh_reg(chan->channel);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read(data->regmap, reg, &regval);
+	if (ret)
+		return ret;
+
+	regval = FIELD_GET(SX9310_REG_PROX_CTRL8_9_PTHRESH_MASK, regval);
+	if (regval > ARRAY_SIZE(sx9310_pthresh_codes))
+		return -EINVAL;
+
+	*val = sx9310_pthresh_codes[regval];
+	return IIO_VAL_INT;
+}
+
+static int sx9310_read_event_val(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan,
+				 enum iio_event_type type,
+				 enum iio_event_direction dir,
+				 enum iio_event_info info, int *val, int *val2)
+{
+	struct sx9310_data *data = iio_priv(indio_dev);
+
+	if (chan->type != IIO_PROXIMITY)
+		return -EINVAL;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		return sx9310_read_thresh(data, chan, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int sx9310_write_thresh(struct sx9310_data *data,
+			       const struct iio_chan_spec *chan, int val)
+{
+	unsigned int reg;
+	unsigned int regval;
+	int ret, i;
+
+	reg = ret = sx9310_get_thresh_reg(chan->channel);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(sx9310_pthresh_codes); i++) {
+		if (sx9310_pthresh_codes[i] == val) {
+			regval = i;
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(sx9310_pthresh_codes))
+		return -EINVAL;
+
+	regval = FIELD_PREP(SX9310_REG_PROX_CTRL8_9_PTHRESH_MASK, regval);
+	mutex_lock(&data->mutex);
+	ret = regmap_update_bits(data->regmap, reg,
+				 SX9310_REG_PROX_CTRL8_9_PTHRESH_MASK, regval);
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+
+static int sx9310_write_event_val(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan,
+				  enum iio_event_type type,
+				  enum iio_event_direction dir,
+				  enum iio_event_info info, int val, int val2)
+{
+	struct sx9310_data *data = iio_priv(indio_dev);
+
+	if (chan->type != IIO_PROXIMITY)
+		return -EINVAL;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		return sx9310_write_thresh(data, chan, val);
+	default:
+		return -EINVAL;
+	}
+}
+
 static int sx9310_set_samp_freq(struct sx9310_data *data, int val, int val2)
 {
 	int i, ret;
@@ -744,6 +856,8 @@ static const struct iio_info sx9310_info = {
 	.attrs = &sx9310_attribute_group,
 	.read_raw = sx9310_read_raw,
 	.read_avail = sx9310_read_avail,
+	.read_event_value = sx9310_read_event_val,
+	.write_event_value = sx9310_write_event_val,
 	.write_raw = sx9310_write_raw,
 	.read_event_config = sx9310_read_event_config,
 	.write_event_config = sx9310_write_event_config,
-- 
Sent by a computer, using git, on the internet

