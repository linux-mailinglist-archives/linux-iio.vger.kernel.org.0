Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD911ECC8D
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jun 2020 11:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgFCJ0V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jun 2020 05:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgFCJ0U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jun 2020 05:26:20 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B609AC05BD43;
        Wed,  3 Jun 2020 02:26:20 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m1so1399047pgk.1;
        Wed, 03 Jun 2020 02:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZPr+aQAATVUkvplzbC3lCmk20hrbatLRa0Nqdzu8JGg=;
        b=CRUMWWfNqtHTw24ZIWxApphaL2vDf74zguV2SHALour4ZAEdb2+x+71ulAmZzzHno4
         45TO4kMT1dYBXjkKPPjTvF8t2Xg0SpXM9r39e2YW0ae24zRIRIVo9MOKIM0RXnU7mBPz
         SLb0GAxH9DfIQi1+tw0GSOHbm5iw1jSVgFU9ztC5RKvMJ0PBaOcbGWDbH6a4xusFB3wZ
         9DIeCAIS+fmWOSGmYNcqFnZi4lTTUvy7LmLHElkjfUCBrumSwxgEeT3IHVWNAnmhLYks
         BAqX3R5wsMWWQZz9zqSkyDPK0hKTOhaRi84rbfqstbJ7rIzp7esvDrbyYI0IDnGgY35+
         owlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZPr+aQAATVUkvplzbC3lCmk20hrbatLRa0Nqdzu8JGg=;
        b=pMaHSQAGPFShvYe1wo0cJmjDC81rean6SANFzr34IXeWAh2+OMmCaZbkojRBlTmnDA
         ViS4gwEaWbA4SZ8obiOUy0cmJeVkx2xfG6l/HO0OgBD9VdZoHMYUOWlWOkXX6IQ1YJuV
         nZdP6b36L5vglvclw28lTDk5GX8jruQYj9DIa9t0S7xipWRtwWANKtpvmM4NSQr8LYNC
         t4SgwMhZ+o0B2P7B65g6lONjDJ7jWK6nFm8rbKR9i6bs0saYqpWzNXY69qK46eZwIXzp
         HfQ37SGHSXZX5gOEumpbjgNxYx5QDGupw9wEY0fNDzCAVsT2+APfSxrQCfSOIUjclMIa
         0XOw==
X-Gm-Message-State: AOAM5329eJ3g11k2ZF0/IUE8b8fioM9jvCIreFf12jnLz4AZhMYD9RQF
        dbWY1kV5DF4FT6vXY9XOwBA=
X-Google-Smtp-Source: ABdhPJxsDx9t2mNzXR4FOD0cCfNVH5B5nRh0OHbOq+wv91eZasB/PFvbFsgwn4jAQpFqpWuQwaLYtA==
X-Received: by 2002:a17:90a:734b:: with SMTP id j11mr4521220pjs.114.1591176380348;
        Wed, 03 Jun 2020 02:26:20 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id u19sm1514224pfk.98.2020.06.03.02.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 02:26:19 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Paul Cercueil <paul.cercueil@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v3] iio: amplifiers: ad8366: Change devm_gpiod_get() to optional and add the missed check
Date:   Wed,  3 Jun 2020 17:26:10 +0800
Message-Id: <20200603092610.1424489-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since if there is no GPIO, nothing happens, replace devm_gpiod_get()
with devm_gpiod_get_optional().
Also add IS_ERR() to fix the missing-check bug.

Fixes: cee211f4e5a0 ("iio: amplifiers: ad8366: Add support for the ADA4961 DGA")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v3:
  - Change devm_gpiod_get() to optional.
  - Modify description.

 drivers/iio/amplifiers/ad8366.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 62167b87caea..8819e8997f76 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -262,8 +262,12 @@ static int ad8366_probe(struct spi_device *spi)
 	case ID_ADA4961:
 	case ID_ADL5240:
 	case ID_HMC1119:
-		st->reset_gpio = devm_gpiod_get(&spi->dev, "reset",
+		st->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
 			GPIOD_OUT_HIGH);
+		if (IS_ERR(st->reset_gpio)) {
+			ret = PTR_ERR(st->reset_gpio);
+			goto error_disable_reg;
+		}
 		indio_dev->channels = ada4961_channels;
 		indio_dev->num_channels = ARRAY_SIZE(ada4961_channels);
 		break;
-- 
2.26.2

