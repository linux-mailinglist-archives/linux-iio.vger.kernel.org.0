Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC0322D094
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jul 2020 23:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgGXVdi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jul 2020 17:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgGXVdh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2020 17:33:37 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C57C0619E4
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 14:33:37 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q17so5283456pls.9
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 14:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7r5P7yY97nIyh5VEzHl8IWXtXY0874kQ28pbPaAX6qA=;
        b=STyOXqoW5ATgPELLwQQ+htug+4PwoBB7dhN8Zr+us4YTpwo6KWpaLdQ9vA7dvEmTn0
         OoDH/1U/qklppbzvfH52Cfcws+RcgFNHewY9GvymoxFT8cogRC8mj1SpAmA/RBfam/an
         DEZlRBCGTseP5LiJfhi5DcDMVLOW/5iFsrkMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7r5P7yY97nIyh5VEzHl8IWXtXY0874kQ28pbPaAX6qA=;
        b=dqj5l0EzzXoCdqRnYPl6OfG4GxVPqEf/GCJA0m1qw0cHP8Y96Tred3UxaNFXCEs2Q0
         6jMt/RvwiHzR3g+yZ2M1A8Bsz01KkuPvQsZzydEGlHj+B76BMaMCmrdhN18KO2wEcyfO
         JaFkfXZASuWkU4Hx4IMb08So4Eo+Qpu8TPeUxznpnjxarSvpsGb0eOAMfBydvUMsSj99
         gCiQUweXWXbDp6/JBjpBNIfth/tA2KivaiNYWA3+bv3EluODBj4m0tlp04PN/CMki/Sq
         NlrKo4ZUKHCO5z7nAlqTtVCGu3IYj7iQ5jPvyffW957uYgemlK8xp8j9zXhEyT2XK7Lk
         4lwA==
X-Gm-Message-State: AOAM532ZHFDno2a/j1XZlTQwqgZ69VqnFjKGeJ8/qbbQ1tD0IxRxphOl
        Zy1uhR5sr9uP8qSadE6BH+7wQrEAGxI=
X-Google-Smtp-Source: ABdhPJypUULXnzt+wfn35DBVEVvoWc6T57rYbQ4sYcNEUCnquL9y0upEE6DaTrBVpCMFf8Iw+DUYBQ==
X-Received: by 2002:a17:90b:30d7:: with SMTP id hi23mr7703975pjb.69.1595626416540;
        Fri, 24 Jul 2020 14:33:36 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id z6sm7312919pfn.173.2020.07.24.14.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 14:33:36 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 5/5] iio: sx9310: Enable vdd and svdd regulators at probe
Date:   Fri, 24 Jul 2020 14:33:29 -0700
Message-Id: <20200724213329.899216-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200724213329.899216-1-swboyd@chromium.org>
References: <20200724213329.899216-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enable the main power supply (vdd) and digital IO power supply (svdd)
during probe so that the i2c communication and device works properly on
boards that aggressively power gate these supplies.

Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Daniel Campello <campello@chromium.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/iio/proximity/sx9310.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 1e1f6bba50f6..ad6ed100c7a6 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
 #include <linux/iio/buffer.h>
@@ -899,12 +900,21 @@ static int sx9310_set_indio_dev_name(struct device *dev,
 	return 0;
 }
 
+static void sx9310_regulator_disable(void *supplies)
+{
+	regulator_bulk_disable(2, supplies);
+}
+
 static int sx9310_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	int ret;
 	struct iio_dev *indio_dev;
 	struct sx9310_data *data;
+	struct regulator_bulk_data supplies[] = {
+		{ .supply = "vdd" },
+		{ .supply = "svdd" },
+	};
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (indio_dev == NULL)
@@ -919,6 +929,23 @@ static int sx9310_probe(struct i2c_client *client,
 	if (IS_ERR(data->regmap))
 		return PTR_ERR(data->regmap);
 
+	ret = devm_regulator_bulk_get(&client->dev, ARRAY_SIZE(supplies), supplies);
+	if (ret)
+		return ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(supplies), supplies);
+	if (ret)
+		return ret;
+	/* Must wait for Tpor time after initial power up */
+	usleep_range(1000, 1100);
+
+	/* Update sx9310_regulator_disable() size if this bug is hit */
+	BUILD_BUG_ON(ARRAY_SIZE(supplies) != 2);
+	ret = devm_add_action_or_reset(&client->dev, sx9310_regulator_disable,
+				       supplies);
+	if (ret)
+		return ret;
+
 	ret = regmap_read(data->regmap, SX9310_REG_WHOAMI, &data->whoami);
 	if (ret < 0) {
 		dev_err(&client->dev, "error in reading WHOAMI register: %d\n",
-- 
Sent by a computer, using git, on the internet

