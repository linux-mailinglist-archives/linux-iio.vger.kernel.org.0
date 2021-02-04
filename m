Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7723330F6F1
	for <lists+linux-iio@lfdr.de>; Thu,  4 Feb 2021 17:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbhBDP4H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Feb 2021 10:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237501AbhBDPzP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Feb 2021 10:55:15 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B48C061786
        for <linux-iio@vger.kernel.org>; Thu,  4 Feb 2021 07:54:32 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id sa23so6235977ejb.0
        for <linux-iio@vger.kernel.org>; Thu, 04 Feb 2021 07:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=++R/1fsILOGF4vJb7pQXNieXWAnye6tFnRAXCu0Ng6A=;
        b=Jn8ds1c0pb3BkuQhBIMgh7F1nlwWKPxXNlyQAiNxYvdiYbXdhVmv31oH5z9L/kZaU3
         McTILJgGnpopg6T/Dn8Ie0W9AFw8YEDkfJTxQ6VVUcoN8aGID66pL2SxRTlraqqscGms
         E27Weo/XVHSyjSf9U0J7BxASWE/J4S/aqMKbKZZPVYwzLpQa1ZRi+kPfNgXKmtuQRxkg
         jm49FzCUW5zBpPyQyf8ieNrJfvevvfI6ap179uWg8YkmnAQcMSknnVDcuz6+9PAqD4fh
         eGaG1mKsSLE9nTYUnPWHXm0iJwspU4zyHq/KO3z4jyEprA4mPEtdg3/eqQ+9xIqCXzb2
         G0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=++R/1fsILOGF4vJb7pQXNieXWAnye6tFnRAXCu0Ng6A=;
        b=f0iUzr/5/S5klgCN2jA3HpTu2HkB7kFFJJb/xLmhzxKIF73YvgfYIKiBpV7VglQpjF
         DqRVBUh67rXSGnuGatYm7wVa/aZX2398xZ6BgqYwuJXATs8fr+TiRl4DYJ2CjZjZzDml
         9DhILGbqUHNaJbHKfvmo0W+q/aeWrqXVJ+eW09OcQN5zZ+dVL1vaBl57fUHlbHsUk+Nu
         ooN36DydgXLem8pkDW2Firxv42IpqMplfK1b8tdcO+upaISDaDVmT5o3YcEGlx94Sbsx
         mg8ZunW0pugmCKWIyzuTVOKlBd6Gnf7FP3lbJPzUCztx08unv+swWg61Nkq4wtINlBtN
         7bOw==
X-Gm-Message-State: AOAM531ofei8Y+B4lroNB+5kRwCARDdl5/YSStpntPaJ6YiIZCXC6jxL
        0QX5TWZp5WfJTG5mBNRhk1o=
X-Google-Smtp-Source: ABdhPJzj+cNdWUvMhcMfMi7LnJSed7gKFoW+OgX71W7+hRyWsoPL7J+vmIThYRHm3jQdrRF8PiQkxQ==
X-Received: by 2002:a17:906:1712:: with SMTP id c18mr8665506eje.417.1612454071532;
        Thu, 04 Feb 2021 07:54:31 -0800 (PST)
Received: from ubuntu (62-46-102-85.adsl.highway.telekom.at. [62.46.102.85])
        by smtp.gmail.com with ESMTPSA id f20sm2640781edd.47.2021.02.04.07.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 07:54:31 -0800 (PST)
Date:   Thu, 4 Feb 2021 16:54:30 +0100
From:   Wilfried Wessner <wilfried.wessner@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH] Correct bit mask for ADC result according to ADC's
 resolution.
Message-ID: <20210204155430.GA557111@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Wilfried Wessner <wilfried.wessner@gmail.com>
---
 drivers/iio/adc/ad7949.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 5d597e5050f6..a5b4858cb6dc 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -91,7 +91,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 	int ret;
 	int i;
 	int bits_per_word = ad7949_adc->resolution;
-	int mask = GENMASK(ad7949_adc->resolution, 0);
+	int mask = GENMASK((ad7949_adc->resolution-1), 0);
 	struct spi_message msg;
 	struct spi_transfer tx[] = {
 		{
-- 
2.25.1

