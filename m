Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BB0345E03
	for <lists+linux-iio@lfdr.de>; Tue, 23 Mar 2021 13:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhCWM1m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Mar 2021 08:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhCWM1K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Mar 2021 08:27:10 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC1FC061574
        for <linux-iio@vger.kernel.org>; Tue, 23 Mar 2021 05:27:10 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id u20so25309462lja.13
        for <linux-iio@vger.kernel.org>; Tue, 23 Mar 2021 05:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XngEVJM1BlZxxtxKJcCTSV7ycav5zHqwABJNpRvqI6Q=;
        b=Uy/27Eg7txLYmAnlljepIsKLGRhNLdLyNc+/sfTzSpEb0Y+7K03YdVG69+BPByLwWU
         47Wd5lcyXTEeL+VN/u4z31CwJKnYud8GltPWHjsKNiI6H4Krc/4EsLQ0Iia/dSkRrnJ2
         TxE8sXrWbJ18bH8KsPWfXNJywhYO2+ryYLfzVW4UfAtC/Q2OulU2J+T7Vi/mLeWTvmEU
         5jYb0N2j6gw+KaUCO2wSDHqRcp7NlJytltjbQ7/qBAporXCqHjmnoXLXkb+weoR9YlOU
         PXYm3iMmZFKR2lAItZNxj48/MQUI/Oe4vONf3jtylNxgNxPy5pZQVEBctO0PTTUhXTIn
         IF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XngEVJM1BlZxxtxKJcCTSV7ycav5zHqwABJNpRvqI6Q=;
        b=HIVT3X/0h4XxVKSN4rFz/S9KwZDsryh//hpGpVKafq4SjFqmqtls6/DiY94bcfhn+a
         r+fA5nhBbtgJiKXKTbF/OLjcYUPsEvZASD1qylMIX5xY9YK9oAes4aasti6Bz8/A71yw
         P6yvPIWGdLVrGGN8bCGx6kZUbiOy/VJXuMo3BavIU10Ee2XzQH/lt1o4BpCMQkMAJ+ff
         u7S0TuogakpjBpgOOno56MgkKQ3sWrnp7hi8KJ7SMA/wtcM9iSYXIriupc/oo4pU9IgS
         n6mFwWKUNhgB4YGA1mBT62MZFXH6pFh9yi2P2fHTQ6fFDBoAWtoYcw+NcLDY3Gn7n7SE
         wZLQ==
X-Gm-Message-State: AOAM533f4P4T3Fr+pdaSyI7OPlKTTcJMpvLLaqAXQ9AFlo8noARBMdT/
        FMO7Dr91yCn+nxAB8UIXbIty6w==
X-Google-Smtp-Source: ABdhPJxYS6GvNaVy1YMbppYLcgi4tu48i6Znc4+EII3HzDNv1642jQyanrfYmTGJYHzzhiKJsjITKw==
X-Received: by 2002:a05:651c:2005:: with SMTP id s5mr3084316ljo.491.1616502428925;
        Tue, 23 Mar 2021 05:27:08 -0700 (PDT)
Received: from localhost.localdomain (c-d7cb225c.014-348-6c756e10.bbcust.telenor.se. [92.34.203.215])
        by smtp.gmail.com with ESMTPSA id e18sm2311245ljl.92.2021.03.23.05.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 05:27:08 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] iio: Fix iio_read_channel_processed_scale()
Date:   Tue, 23 Mar 2021 13:27:05 +0100
Message-Id: <20210323122705.1326362-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The code was checking if (ret) from the processed
channel readout, not smart, we need to check if (ret < 0)
as this will likely be something like IIO_VAL_INT.

Fixes: dc98269f7c7d ("iio: Provide iio_read_channel_processed_scale() API")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Jonathan: this Fixes tag is the commit ID found in your
testing branch, feel free to just squash if you prefer
that.
---
 drivers/iio/inkern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index c61fc06f98b8..9c22697b7e83 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -702,7 +702,7 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
 	if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_PROCESSED)) {
 		ret = iio_channel_read(chan, val, NULL,
 				       IIO_CHAN_INFO_PROCESSED);
-		if (ret)
+		if (ret < 0)
 			goto err_unlock;
 		*val *= scale;
 	} else {
-- 
2.29.2

