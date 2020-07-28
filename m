Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB61D230D41
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 17:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbgG1PNg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 11:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730691AbgG1PN2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 11:13:28 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B954C061794
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 08:13:28 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k23so21064406iom.10
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 08:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7g2DMS0FPIZ0c5BtsKEx2bDwtPiWXmFL4GsCilJV19I=;
        b=d8eleb4MBB+74R1FQdN2sLvMwPOupEBPNEhXpr/In2/on2ERcbEHLNR3MN4sMtCY05
         fIlogS5Gf6IXBuMpceoXrgCKjfhKhFV7MtwSoPBvWnfmg0WeuppStmahExFke5V6klPt
         aTVh5lRzw6ZPFueGvBUn33rKXHIZZVLLNqaZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7g2DMS0FPIZ0c5BtsKEx2bDwtPiWXmFL4GsCilJV19I=;
        b=gjX2wQAvcm4RTEpFEBUmZHMlcJ1y23Ww5G2ZREdEpqNUTiE4MRjAmusHJr+F8iF33e
         9aRVH+VdOORxmVUAYrBZyzUsR7GzjOV/SdMwq/F8WYVWLm/kNy3TK2iyBsiWxmOs16V3
         0CdJiKgt9T1kyVgwMirNTuIZAsotkRHqfpFO07Ebe/Vf7RXKHe1oOnIAIPLT1iJ5c1Q1
         0XedfvQO9JZf4E9PJIfvAghIjmFIPL/mTG6FVhXbdyCRyp2Rc9XoQ/08JYl0HhFTcXbi
         J8QULFJVYFWYRw6wiLDg1xEIekGSpKVuxxB+afZ5EzxRVgbv/1KBGF+pttOVeYrlQG4D
         zSbg==
X-Gm-Message-State: AOAM530J1lnL47mPny3TBo/1fCsPA7H7PLAMpXROsqpXvQdO0pwf2Q1T
        Z6jTC/cTazhD3wWOkVLPdbTDew==
X-Google-Smtp-Source: ABdhPJw0FjZUaCtk3mItpKIJPN0aj5p9Lbxv8Jyx9ib1W0TOGX11VsA9cYlczInqsYM2F9YsK6/rEA==
X-Received: by 2002:a02:ec4:: with SMTP id 187mr31580705jae.11.1595949207095;
        Tue, 28 Jul 2020 08:13:27 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id q70sm6399781ili.49.2020.07.28.08.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 08:13:26 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH 15/15] iio: sx9310: Enable vdd and svdd regulators at probe
Date:   Tue, 28 Jul 2020 09:12:58 -0600
Message-Id: <20200728091057.15.Iaf4d717d1908ef22c88922b556e1eb803ae019c6@changeid>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200728151258.1222876-1-campello@chromium.org>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

Enable the main power supply (vdd) and digital IO power supply (svdd)
during probe so that the i2c communication and device works properly on
boards that aggressively power gate these supplies.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Daniel Campello <campello@chromium.org>
---

 drivers/iio/proximity/sx9310.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 202018b726e32f..24a2360b6314ef 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
 #include <linux/iio/buffer.h>
@@ -118,6 +119,7 @@ struct sx9310_data {
 	struct i2c_client *client;
 	struct iio_trigger *trig;
 	struct regmap *regmap;
+	struct regulator_bulk_data supplies[2];
 	/*
 	 * Last reading of the proximity status for each channel.
 	 * We only send an event to user space when this changes.
@@ -873,6 +875,13 @@ static int sx9310_set_indio_dev_name(struct device *dev,
 	return 0;
 }
 
+static void sx9310_regulator_disable(void *_data)
+{
+	struct sx9310_data *data = _data;
+
+	regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
+}
+
 static int sx9310_probe(struct i2c_client *client)
 {
 	int ret;
@@ -886,6 +895,8 @@ static int sx9310_probe(struct i2c_client *client)
 
 	data = iio_priv(indio_dev);
 	data->client = client;
+	data->supplies[0].supply = "vdd";
+	data->supplies[1].supply = "svdd";
 	mutex_init(&data->mutex);
 	init_completion(&data->completion);
 
@@ -893,6 +904,21 @@ static int sx9310_probe(struct i2c_client *client)
 	if (IS_ERR(data->regmap))
 		return PTR_ERR(data->regmap);
 
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->supplies),
+				      data->supplies);
+	if (ret)
+		return ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(data->supplies), data->supplies);
+	if (ret)
+		return ret;
+	/* Must wait for Tpor time after initial power up */
+	usleep_range(1000, 1100);
+
+	ret = devm_add_action_or_reset(dev, sx9310_regulator_disable, data);
+	if (ret)
+		return ret;
+
 	ret = regmap_read(data->regmap, SX9310_REG_WHOAMI, &data->whoami);
 	if (ret) {
 		dev_err(dev, "error in reading WHOAMI register: %d\n", ret);
-- 
2.28.0.rc0.142.g3c755180ce-goog

