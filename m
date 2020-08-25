Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920652518CD
	for <lists+linux-iio@lfdr.de>; Tue, 25 Aug 2020 14:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgHYMqI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Aug 2020 08:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHYMqG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Aug 2020 08:46:06 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E0FC061574;
        Tue, 25 Aug 2020 05:46:06 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h12so6751137pgm.7;
        Tue, 25 Aug 2020 05:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=py5+igg5KiFdh7KxKzplCQAotknCjgGJlLRzcQCkBK4=;
        b=SivCnJfYQBFAN78enEIGNE+PC9UJxWadffE9Nx+lppZiU7rsGEDsd0H73J6B9L7A/8
         rluWfnvx2BTuOxanMQ/SC3VpePAwh2MhHZzIE04P9A+ZTxbLn9f89lgDX/lt/JHgRA9+
         LVgy1GjHb6XZIkm+b1pli/hClkSCixw/tvha7YRpzqt/ERTGvKVAg0tMCeL6VlxgJHBQ
         xQdgdkxWQyXW28YhUEnEipcDU6wabQWU3vPkwbfeetKtbvbA8GZQ9i0kPNulsd3MgMBf
         DTX2ZZdSasNJhgb3RqvK7eSK5ygO2K83vGPwi28hl0RHxfPZKFrGpEqWRQcVHNMrRx7I
         6alw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=py5+igg5KiFdh7KxKzplCQAotknCjgGJlLRzcQCkBK4=;
        b=hJ7nWolwaaWGNc/mwvdFTnRi4MhWyqItuLj9dxjsxCWR7jjEs3JtZ0Z+GA7G0WQgsG
         hns7bSlMYKKJJyHFAMcNdmE8vcfT1AjjjTBI3zb0I0/JxS8HkWgppNtdofyTCq2iHdyq
         0ccDjrSPrQdLKkHcop8EpP7RmYKffd2ssd5I4TdwD9MfgQ3P6aAVJoidudpKkEUq2wbw
         uwHu579EpPmHvGuik8bnZaKcXidcYv1iv67WVh7wDyy1z5RkTxL43e81ndZPXhC8nklx
         evDXBNeDQBvjwqcXlfUxsORgvuad2fOOIic1PmgUnL5Y8XyrbQm0Fp6cUxSQ6lwliIOZ
         gyeg==
X-Gm-Message-State: AOAM5336LGlVaC0YcJyhuxw/UmG1G6zowGlAmHHxCz+EaETUKxxWtdp3
        CUw8oyh2n+/fU+1QRtMjVIA=
X-Google-Smtp-Source: ABdhPJwENMvsDKcpajfQFR2oGmxz1FNWuRnRwLSgBXBs8ugW7t9Zgx79LDG9scrYCAkTeBmBkwmKaw==
X-Received: by 2002:a62:7b8b:: with SMTP id w133mr7929458pfc.286.1598359565866;
        Tue, 25 Aug 2020 05:46:05 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:619:dc6c:a526:a3b6:4686:f6fb])
        by smtp.gmail.com with ESMTPSA id s4sm15293952pfh.128.2020.08.25.05.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 05:46:05 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     dragos.bogdan@analog.com, darius.berghe@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: [PATCH 1/1] iio: gyro: adxrs290: Insert missing mutex initialization call
Date:   Tue, 25 Aug 2020 18:15:52 +0530
Message-Id: <20200825124552.11155-1-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Insert a missing mutex_init() call during the probe that initializes
the driver's local lock to unlocked state.

Fixes: 2c8920fff145 ("iio: gyro: Add driver support for ADXRS290")
Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---
 drivers/iio/gyro/adxrs290.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index 38bab4e3eee9..ff989536d2fb 100644
--- a/drivers/iio/gyro/adxrs290.c
+++ b/drivers/iio/gyro/adxrs290.c
@@ -385,6 +385,8 @@ static int adxrs290_probe(struct spi_device *spi)
 	indio_dev->num_channels = ARRAY_SIZE(adxrs290_channels);
 	indio_dev->info = &adxrs290_info;
 
+	mutex_init(&st->lock);
+
 	val = spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_ADI_ID));
 	if (val != ADXRS290_ADI_ID) {
 		dev_err(&spi->dev, "Wrong ADI ID 0x%02x\n", val);
-- 
2.20.1

