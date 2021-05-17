Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A52386DC0
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 01:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbhEQXkG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 19:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbhEQXkG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 May 2021 19:40:06 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DD8C061573
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 16:38:49 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z13so11298857lft.1
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 16:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P/Y6XbDTCvgW3VbQmCGY1JGa9deJDrj59RfruZ1XQjk=;
        b=sru8k50MpkalCjWFw9AGoQQoYas/rugjXPU7ig1vluTw52zTAgov5ttFQ2I4a5Uah+
         bd/rH1jYhRReDa/XCLNf3rbrnCHDtw1lBFd/3QV7UyQmYb/tbxbyw8XqzTeSTPe0RIKK
         XRaYtFHHo/IF/cVWy8/InWUygEUk7GzG1pwPpryEO4lJmaVa28EcAOmiXH9in01dLBxF
         9JnVlOPFGOn5uA3wascNCzKzWIy2QBNznvTqwV8vEb5zGfNT3pqDuVUqh7XhLcoup8W+
         glKiruubgiUItpoaWFHeWFGA33E6Dq8+gwSAQ1jUytUQ46Mg0UyixYHR/FlH8EESGw9l
         trcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P/Y6XbDTCvgW3VbQmCGY1JGa9deJDrj59RfruZ1XQjk=;
        b=ue4/AYZPoz5/rj7up9nIbvEQPZtuFGo2/kMTtoxxMXntP4zn6bAZlZmtFmrnjYTkyh
         6BCFaxk4qMSb27fOS06fwlAEPiZvo3zBPu+aOiT/9GRSW3cjOCW6ND6pHWVLbBKKrHRU
         anzpkabNS+EWaLdUB6v0awT8I9WSSyuhQo7KipoQe2DfVrrbLtCkgAz7jlb/5jFel4dx
         pcqMogUUeEgOfYsRAzFFl/Jgw7Ma1/NxfRKedGdMlXsIhQ1zcRY8M4JDh0dQg/ZPH1Fv
         EXndXXb2fgjLduJ/vA3oxVrAi6AzslDuy6RBd2y8zgrDmnkFS9MVaTKWjWMzr75qWeMh
         Sv2A==
X-Gm-Message-State: AOAM531BAs1dHk1aAxjxNtPAhXISoKrnGoBcZOHt+AULK6fQ+sgIJiKq
        h51nTfOHg5PccQ1LpJiXthapVlGfP6tEjw==
X-Google-Smtp-Source: ABdhPJx2TQ0rxZ4OYrlhhDwJFbW3Ai+caOO8By59k9Stc0lSiqRaj0DdddRhEj6vO3YiY75UU/KPAA==
X-Received: by 2002:a05:6512:6c5:: with SMTP id u5mr1456477lff.260.1621294727904;
        Mon, 17 May 2021 16:38:47 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id r10sm168425lfe.110.2021.05.17.16.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 16:38:47 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Daniel Drake <drake@endlessm.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 3/5 v2] iio: accel: st_sensors: Stop copying channels
Date:   Tue, 18 May 2021 01:33:20 +0200
Message-Id: <20210517233322.383043-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517233322.383043-1-linus.walleij@linaro.org>
References: <20210517233322.383043-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The channels were copied only so that the .ext_info member should become
assignable. We now have compile-time static assignment so drop this code.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Denis Ciocca <denis.ciocca@st.com>
Cc: Daniel Drake <drake@endlessm.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Improvement found by Stephan.
---
 drivers/iio/accel/st_accel_core.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 8044b8ae7ead..fa06a3ef84e7 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1247,8 +1247,6 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *adata = iio_priv(indio_dev);
 	struct st_sensors_platform_data *pdata = dev_get_platdata(adata->dev);
-	struct iio_chan_spec *channels;
-	size_t channels_size;
 	int err;
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -1263,17 +1261,9 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 		goto st_accel_power_off;
 
 	adata->num_data_channels = ST_ACCEL_NUMBER_DATA_CHANNELS;
+	indio_dev->channels = adata->sensor_settings->ch;
 	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
 
-	channels_size = indio_dev->num_channels * sizeof(struct iio_chan_spec);
-	channels = devm_kmemdup(&indio_dev->dev,
-				adata->sensor_settings->ch,
-				channels_size, GFP_KERNEL);
-	if (!channels) {
-		err = -ENOMEM;
-		goto st_accel_power_off;
-	}
-
 	/* First try ACPI orientation then try the generic function */
 	err = apply_acpi_orientation(indio_dev);
 	if (err) {
@@ -1283,7 +1273,6 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 			goto st_accel_power_off;
 	}
 
-	indio_dev->channels = channels;
 	adata->current_fullscale = &adata->sensor_settings->fs.fs_avl[0];
 	adata->odr = adata->sensor_settings->odr.odr_avl[0].hz;
 
-- 
2.31.1

