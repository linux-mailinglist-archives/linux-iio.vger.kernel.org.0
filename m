Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F2C341D4C
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 13:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhCSMrf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 08:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhCSMrS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 08:47:18 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8065AC06174A
        for <linux-iio@vger.kernel.org>; Fri, 19 Mar 2021 05:47:14 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id o10so9791544lfb.9
        for <linux-iio@vger.kernel.org>; Fri, 19 Mar 2021 05:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZmMEaCbX313n2vdr0onRBI+hCAzWVSAtBv1IYayn5O0=;
        b=ZXHSLzmFgrXKprFLOqV5LsnsoSPxRhH9vufRZxa7XW5FHYHMbfjmgrs967OUcO7yYP
         TDQk2TIGDi3W970kXH+Oweza+UDSOipdMLz6/XwyV1w1JqBbQQyfrQu+R+0/Oh/0KC/U
         +JxKCBAIoJc8nHilYwxyCWvZbRifQLoj7G8yx97D3cLG35BwoNjw+GUiFgyaopdKdyAf
         a1G0FYq8CGZqOKODFY4oqmji6pOH537cD8Q6rJj5Bv/T3SEgoVkgkMAZtYpaYRtAeHJW
         xpno+4io9o1waqe48yTabZIvqDHP8qiwSznZmPUeGV/72pChyoVfjeGe/Lj13bQVeDd8
         RnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZmMEaCbX313n2vdr0onRBI+hCAzWVSAtBv1IYayn5O0=;
        b=k6gegqmYINXEmHUK7Tqbma/FXgOHvb9jyj0gk5BFkWMf2gdQAg76TYOuFivfl3ZrLH
         p+fmIige8Efv9lqqT5DRMgVd2myrEMJ+nVxkixiSvKlQ6PIPsiF9ncuBVlpVI4F2DJzv
         h5VBk4Phe8AxVQW4YDOMc+VepQk68iAhor3Xzca/TPDP+AwxDDGBKMaHPFlTAznxAG/A
         a1Yd1aKDjcfwK+Ora8w3QZqNPr+j3pFLjl5geQArv3N0xagBpDxUq+knhuq+iZEjqZc9
         0JUUKIhcCjCSesqSk/YtcCgmtthYmcNVj6KnkC489NFJseIZdrBBjEFYFjt4kVgHJsLh
         9nyA==
X-Gm-Message-State: AOAM533yehiN6FmvEFlHY2X2Cdi3/tMTTKvWtNew1Se1YNwEWKptrMl0
        2p+7AbTAkDQ2OPfHYtyZJQi14nmPMFwOyvxBKng=
X-Google-Smtp-Source: ABdhPJxLlHJqaIClccKH+H95PUHbsz8OjHoWazhXtyeJT4yG5fFyro1572GETlrM5mbLq3wzw6QXHg==
X-Received: by 2002:a19:44:: with SMTP id 65mr762466lfa.537.1616158032910;
        Fri, 19 Mar 2021 05:47:12 -0700 (PDT)
Received: from localhost.localdomain (c-d7cb225c.014-348-6c756e10.bbcust.telenor.se. [92.34.203.215])
        by smtp.gmail.com with ESMTPSA id w23sm752182lji.127.2021.03.19.05.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 05:47:12 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] iio: accel: bmc150: Accept any trigger
Date:   Fri, 19 Mar 2021 13:47:09 +0100
Message-Id: <20210319124709.484859-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The BMC150 driver checks to see that the trigger it is
using is one of its own.

Not nice for my system where the IRQ line from the BMA222
is not connected so there is *no* trigger I can use.

This seems just plain wrong to me. Certainly a userspace
process will want to use the trigger from one single sensor
even of it is reading say three different sensors for some
sensor fusion.

Delete this trigger check.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/bmc150-accel-core.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 7e425ebcd7ea..ae81b547dcfc 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -853,20 +853,6 @@ static int bmc150_accel_write_event_config(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static int bmc150_accel_validate_trigger(struct iio_dev *indio_dev,
-					 struct iio_trigger *trig)
-{
-	struct bmc150_accel_data *data = iio_priv(indio_dev);
-	int i;
-
-	for (i = 0; i < BMC150_ACCEL_TRIGGERS; i++) {
-		if (data->triggers[i].indio_trig == trig)
-			return 0;
-	}
-
-	return -EINVAL;
-}
-
 static ssize_t bmc150_accel_get_fifo_watermark(struct device *dev,
 					       struct device_attribute *attr,
 					       char *buf)
@@ -1217,7 +1203,6 @@ static const struct iio_info bmc150_accel_info_fifo = {
 	.write_event_value	= bmc150_accel_write_event,
 	.write_event_config	= bmc150_accel_write_event_config,
 	.read_event_config	= bmc150_accel_read_event_config,
-	.validate_trigger	= bmc150_accel_validate_trigger,
 	.hwfifo_set_watermark	= bmc150_accel_set_watermark,
 	.hwfifo_flush_to_buffer	= bmc150_accel_fifo_flush,
 };
-- 
2.29.2

