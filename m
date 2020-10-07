Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE878285624
	for <lists+linux-iio@lfdr.de>; Wed,  7 Oct 2020 03:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgJGBRm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Oct 2020 21:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbgJGBRm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Oct 2020 21:17:42 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B73C0613D7
        for <linux-iio@vger.kernel.org>; Tue,  6 Oct 2020 18:17:41 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 144so380804pfb.4
        for <linux-iio@vger.kernel.org>; Tue, 06 Oct 2020 18:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6s2rUyIhHoR4qKNTzxmszZi7AfKkr8P4gJKIqWc5ulE=;
        b=eGZDJQUMleSYIV0HKTKITDCfW5XpRAzbMYj9Ok/kvM1c6JEJxgLkw0zm5YUjGeHZDM
         l5XccqQ0OXV/iwISTm2V6M6g1Fk1/jjAPBZey0b8O6Nlc+YC6oNptaJoHtZ7Qse03hqm
         CMq+vkacQ2JRd6hE65LnDWSpnMs1c0SZS8lEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6s2rUyIhHoR4qKNTzxmszZi7AfKkr8P4gJKIqWc5ulE=;
        b=Jw7ZOq5UszwoEgd3OUQuAwaOcqEDp2gl2pMgrnwD0BORfIt/3yI8GqVkyBMkTf7h+h
         lBoCASkTGWOFYeGy8cqHfSW3PEGH8dAD2Ly/wkwoRrNSA1ksM15r5yFxK+/zOLqugdrO
         Oiy2qglHJU/Gi1nUfXNYLpsNllWW5pCgTxuXQ2ZeyGT5E3Cp6hlNR7D+PqUgJVqn+VZA
         Ysi3aotQ8h5zvX6Np1sVOT27h05qH/a+48SWKBZtEgsjrfuCam1oM+1KDHIKmnCkS8eh
         zqWW4cg96hphqAC84IkGl/aFQCivxi9cE+6TKk+a1SeI/B1QDevyR04T3JZ51pNKQElW
         6ySA==
X-Gm-Message-State: AOAM532rFxI2tG7nTgAqHF+kd3dXJvnrkPsao33pYYFfEivnWR96NIcf
        l/rEMdrcJxD10MTsXNysEQtyfg==
X-Google-Smtp-Source: ABdhPJyD0hcqeYSUzaEuncbK1UaOIRChc1U2PEqWaYKhOeFKbSymCgxSlotTuEe8SSPhriwuUMTPKw==
X-Received: by 2002:a63:2406:: with SMTP id k6mr823418pgk.366.1602033461399;
        Tue, 06 Oct 2020 18:17:41 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id z190sm482654pfc.89.2020.10.06.18.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 18:17:40 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH v3 3/6] iio: sx9310: Support setting hysteresis values
Date:   Tue,  6 Oct 2020 18:17:32 -0700
Message-Id: <20201007011735.1346994-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
In-Reply-To: <20201007011735.1346994-1-swboyd@chromium.org>
References: <20201007011735.1346994-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for setting the hysteresis as a shifted value of a channel's
proximity threshold. Each channel can have a different threshold, but
the hysteresis applies to all channels as a right shift factor.
Therefore, duplicate the hysteresis value across all channels and make
it depend on the channel's proximity threshold. This is sort of odd but
seems to work in practice as most of the time only one channel is used.

Cc: Daniel Campello <campello@chromium.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Evan Green <evgreen@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/iio/proximity/sx9310.c | 62 +++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 35e927dc4f66..9eb10e8263e7 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -75,6 +75,7 @@
 #define   SX9310_REG_PROX_CTRL8_9_BODYTHRESH_900	0x03
 #define   SX9310_REG_PROX_CTRL8_9_BODYTHRESH_1500	0x05
 #define SX9310_REG_PROX_CTRL10				0x1a
+#define   SX9310_REG_PROX_CTRL10_HYST_MASK		GENMASK(5, 4)
 #define   SX9310_REG_PROX_CTRL10_HYST_6PCT		(0x01 << 4)
 #define   SX9310_REG_PROX_CTRL10_FAR_DEBOUNCE_2		0x01
 #define SX9310_REG_PROX_CTRL11				0x1b
@@ -149,7 +150,9 @@ static const struct iio_event_spec sx9310_events[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_EITHER,
-		.mask_separate = BIT(IIO_EV_INFO_ENABLE) | BIT(IIO_EV_INFO_VALUE),
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				 BIT(IIO_EV_INFO_HYSTERESIS) |
+				 BIT(IIO_EV_INFO_VALUE),
 	},
 };
 
@@ -574,6 +577,30 @@ static int sx9310_read_thresh(struct sx9310_data *data,
 	return IIO_VAL_INT;
 }
 
+static int sx9310_read_hysteresis(struct sx9310_data *data,
+				  const struct iio_chan_spec *chan, int *val)
+{
+	unsigned int regval, pthresh;
+	int ret;
+
+	ret = sx9310_read_thresh(data, chan, &pthresh);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL10, &regval);
+	if (ret)
+		return ret;
+
+	regval = FIELD_GET(SX9310_REG_PROX_CTRL10_HYST_MASK, regval);
+	if (!regval)
+		regval = 5;
+
+	/* regval is at most 5 */
+	*val = pthresh >> (5 - regval);
+
+	return IIO_VAL_INT;
+}
+
 static int sx9310_read_event_val(struct iio_dev *indio_dev,
 				 const struct iio_chan_spec *chan,
 				 enum iio_event_type type,
@@ -588,6 +615,8 @@ static int sx9310_read_event_val(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
 		return sx9310_read_thresh(data, chan, val);
+	case IIO_EV_INFO_HYSTERESIS:
+		return sx9310_read_hysteresis(data, chan, val);
 	default:
 		return -EINVAL;
 	}
@@ -623,6 +652,35 @@ static int sx9310_write_thresh(struct sx9310_data *data,
 	return ret;
 }
 
+static int sx9310_write_hysteresis(struct sx9310_data *data,
+				   const struct iio_chan_spec *chan, int _val)
+{
+	unsigned int hyst, val = _val;
+	int ret, pthresh;
+
+	ret = sx9310_read_thresh(data, chan, &pthresh);
+	if (ret < 0)
+		return ret;
+
+	if (val == 0)
+		hyst = 0;
+	else if (val == pthresh >> 2)
+		hyst = 3;
+	else if (val == pthresh >> 3)
+		hyst = 2;
+	else if (val == pthresh >> 4)
+		hyst = 1;
+	else
+		return -EINVAL;
+
+	hyst = FIELD_PREP(SX9310_REG_PROX_CTRL10_HYST_MASK, hyst);
+	mutex_lock(&data->mutex);
+	ret = regmap_update_bits(data->regmap, SX9310_REG_PROX_CTRL10,
+				 SX9310_REG_PROX_CTRL10_HYST_MASK, hyst);
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
 
 static int sx9310_write_event_val(struct iio_dev *indio_dev,
 				  const struct iio_chan_spec *chan,
@@ -638,6 +696,8 @@ static int sx9310_write_event_val(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
 		return sx9310_write_thresh(data, chan, val);
+	case IIO_EV_INFO_HYSTERESIS:
+		return sx9310_write_hysteresis(data, chan, val);
 	default:
 		return -EINVAL;
 	}
-- 
Sent by a computer, using git, on the internet

