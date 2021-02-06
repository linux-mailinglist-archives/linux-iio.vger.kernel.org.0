Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62441311D8D
	for <lists+linux-iio@lfdr.de>; Sat,  6 Feb 2021 15:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhBFOEE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Feb 2021 09:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhBFOEE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Feb 2021 09:04:04 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BD1C06174A
        for <linux-iio@vger.kernel.org>; Sat,  6 Feb 2021 06:03:23 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u14so11127111wri.3
        for <linux-iio@vger.kernel.org>; Sat, 06 Feb 2021 06:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=IMI74dMxKTqNSDvJ1QkplB9n4AB3qfo8BAhey/TO1mA=;
        b=GDevMRkeCaZKMTZcAjhEQ4tkPpWxPL9YaSePXUdo4zLQwmCK+lUVgh7Ugn0oa9aCV0
         o0eteK+ul99Ua25nAonIqp0oU9dUXH85pRFNe4HlSs5kOb1KE00LvH2Y4p7XMN2q/kG+
         1N9FM+Qf9m2OEOb74ONEKkDu2Mc8wQtJaCAhL9xy/lOAhUtYFoHJyDkDhb2D3IXriwHL
         qG/nRLbBhMe0Q06srMO2huSUI46rkK5T2eqNOwflGyRT3nQqkPpeUPIyKOqHQb2uZa0F
         sdP2HldXLmCvX7m4TxqQZtzNK0b/J4MC5gYa4AxlttDK3fob6/MorhG8dQQzbK0maJ5z
         aEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=IMI74dMxKTqNSDvJ1QkplB9n4AB3qfo8BAhey/TO1mA=;
        b=uUEeB5rgzWZYe6mud9Ecp375h5OwaVVcPLlUHxJ6BOUE1Eb/hyPhzHS5NuFwe2++9E
         Kx2K6Ja1k3NQK47edWSUvWDbnrIQ7jN7a6gYZ1UA2saHp8VpSJh8w4n4FCFUjqGGaa5p
         pPUyX0scEmt/WPzzyf325Tl6R1KR+9UiuSZf5UHNlgkUykL6h5mX7ciUUGJKkjZXRf3T
         st3bUtJzjjDnTlqJtlOa1US/ve9UMjWFhbOcbar5aJIYIZ+no2b/sFWKNb5v3hZJydAh
         3RC/+HSCDIPSF5VA6w7TgrZZrsLB6MHiNT1eCUu5uT+Tdjq0mTTEhEuZThkpPOaHEjxL
         TqJg==
X-Gm-Message-State: AOAM530dZNKnKbkHR6zchIZgyxgIpf0wgjKVbi40YlytiH+W4H1FnOk6
        QmcQMfF4BTUWRT7PXft6ADI=
X-Google-Smtp-Source: ABdhPJy4IJb74NM+JNGjWMVgQ6OTLuPlh9N22M9mZkxKnKYFPogsLKutLASEFeFumazW+N+zTbitzA==
X-Received: by 2002:adf:902a:: with SMTP id h39mr10362769wrh.147.1612620202127;
        Sat, 06 Feb 2021 06:03:22 -0800 (PST)
Received: from ubuntu (62-46-102-85.adsl.highway.telekom.at. [62.46.102.85])
        by smtp.gmail.com with ESMTPSA id e12sm17063620wrs.67.2021.02.06.06.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 06:03:21 -0800 (PST)
Date:   Sat, 6 Feb 2021 15:03:20 +0100
From:   Wilfried Wessner <wilfried.wessner@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] iio: ad7949: fix wrong ADC result due to incorrect bit mask
Message-ID: <20210206140320.GA601846@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Wilfried Wessner <wilfried.wessner@gmail.com>

Fixes a wrong bit mask used for the ADC's result, which was caused by an
improper usage of the GENMASK() macro. The bits higher than ADC's 
resolution are undefined and if not masked out correctly, a wrong result 
can be given. The GENMASK() macro indexing is zero based, so the mask has 
to go from [resolution -1 , 0].

---
 drivers/iio/adc/ad7949.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 5d597e5050f6..1b4b3203e428 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -91,7 +91,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 	int ret;
 	int i;
 	int bits_per_word = ad7949_adc->resolution;
-	int mask = GENMASK(ad7949_adc->resolution, 0);
+	int mask = GENMASK(ad7949_adc->resolution - 1, 0);
 	struct spi_message msg;
 	struct spi_transfer tx[] = {
 		{
-- 
2.25.1

