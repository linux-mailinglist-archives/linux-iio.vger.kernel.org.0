Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFA3388351
	for <lists+linux-iio@lfdr.de>; Wed, 19 May 2021 01:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhERXtz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 May 2021 19:49:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42355 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231217AbhERXtz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 May 2021 19:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621381716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Zzi+SAr9vviQUX89uEL8pD9LR8GE/KJTXWFjz6jM+5c=;
        b=ViRoNJ6rVhza35okRPYK1Soryqaf0KEGid3IqtzYUXI6GqyHgCJc0cgPKx4+JtQcJlmvdo
        jeLwodsHlCB/95Jn2YY/9zlTCQlM7xqbXyODDKyoLZzW+6qujFRRJx6q3Jz3zWtFnB822y
        RUjWExAk9+0xFDK3picBgVfTwKEq+Bw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-hnosqZSeNZSrQgzZw3vZmg-1; Tue, 18 May 2021 19:48:34 -0400
X-MC-Unique: hnosqZSeNZSrQgzZw3vZmg-1
Received: by mail-qv1-f71.google.com with SMTP id t1-20020a0ca6810000b029019e892416e6so8750589qva.9
        for <linux-iio@vger.kernel.org>; Tue, 18 May 2021 16:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zzi+SAr9vviQUX89uEL8pD9LR8GE/KJTXWFjz6jM+5c=;
        b=VkGRxpiYhyHs+ulYnT9TK1qezO27vp2WNU8R+u6UJGYEoXNVJmqQH+ekXor3xNqWMv
         Eoq1G3X2atV06MREmFLvuAka3ssvMKoJEvyMLmUlpQVTH0Xn0LBL+W242kJrT7g4SyjC
         EUivpMAO0pslihj2LHVz6nkPApUc9k92AnO1SBSVBr3u5Voxy/MpXAaE6z7kfWd5rcNS
         /2ikkI14xfoMrRdTzJV/jNXfKlf0giV7pzBl7UYQFCuuOVmAuwNUSTcX/GQXdYc6i/Hr
         afmlhWWT0sLt1JyymBolrl6Qb9sr/A7MVJCOdtH9ub/uU87enFGeBPdlfeUe6Lf5966f
         5hyA==
X-Gm-Message-State: AOAM533Pm/+K3JPjGGD+jnriwXDpKwPAichNJx9zYAHajKnWqc5Z/78t
        1l2t4OvzB22nxeftQZlsLfIYvfun6rnMih0m8732tBf2Ii4DseJZyTR4gKdgGByfXmO7FADosuV
        FOyBFnsjXOzGNg9lq1OKC
X-Received: by 2002:ad4:4583:: with SMTP id x3mr8991415qvu.39.1621381714377;
        Tue, 18 May 2021 16:48:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2NcN9F2HiatICeWVHirqXYxASTW6qrsfJmiTulm5rmcA9pWAPfCU5tS8h6surb/woeiTalA==
X-Received: by 2002:ad4:4583:: with SMTP id x3mr8991403qvu.39.1621381714225;
        Tue, 18 May 2021 16:48:34 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u186sm14205527qkd.30.2021.05.18.16.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 16:48:33 -0700 (PDT)
From:   trix@redhat.com
To:     jic23@kernel.org, lars@metafoo.de, sean@geanix.com,
        andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] iio: accel: fxls8962af: conditionally compile fxls8962af_i2c_raw_read_errata3()
Date:   Tue, 18 May 2021 16:48:28 -0700
Message-Id: <20210518234828.1930387-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The build is failing with this link error
ld: fxls8962af-core.o: in function `fxls8962af_fifo_transfer':
fxls8962af-core.c: undefined reference to `i2c_verify_client'

This is needed for the i2c variant, not the spi variant. So
conditionally compile based on CONFIG_FXLS8962AF_I2C.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iio/accel/fxls8962af-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 9fe5a18a605cc..b6d833e2058c8 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -624,6 +624,7 @@ static const struct iio_buffer_setup_ops fxls8962af_buffer_ops = {
 	.postdisable = fxls8962af_buffer_postdisable,
 };
 
+#if IS_ENABLED(CONFIG_FXLS8962AF_I2C)
 static int fxls8962af_i2c_raw_read_errata3(struct fxls8962af_data *data,
 					   u16 *buffer, int samples,
 					   int sample_length)
@@ -639,6 +640,7 @@ static int fxls8962af_i2c_raw_read_errata3(struct fxls8962af_data *data,
 
 	return ret;
 }
+#endif
 
 static int fxls8962af_fifo_transfer(struct fxls8962af_data *data,
 				    u16 *buffer, int samples)
@@ -648,6 +650,7 @@ static int fxls8962af_fifo_transfer(struct fxls8962af_data *data,
 	int total_length = samples * sample_length;
 	int ret;
 
+#if IS_ENABLED(CONFIG_FXLS8962AF_I2C)
 	if (i2c_verify_client(dev))
 		/*
 		 * Due to errata bug:
@@ -657,6 +660,7 @@ static int fxls8962af_fifo_transfer(struct fxls8962af_data *data,
 		ret = fxls8962af_i2c_raw_read_errata3(data, buffer, samples,
 						      sample_length);
 	else
+#endif
 		ret = regmap_raw_read(data->regmap, FXLS8962AF_BUF_X_LSB, buffer,
 				      total_length);
 
-- 
2.26.3

