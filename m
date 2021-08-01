Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2103DCD51
	for <lists+linux-iio@lfdr.de>; Sun,  1 Aug 2021 21:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhHATkX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Aug 2021 15:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhHATkW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Aug 2021 15:40:22 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6160CC0613D5;
        Sun,  1 Aug 2021 12:40:13 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id f22so14745158qke.10;
        Sun, 01 Aug 2021 12:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OKwbA7CkZ/dV0H/nAmt5zTOn4ixRO23QkLcRozVJn9c=;
        b=T/kLWJHDY0jlV2/QSYqw8Gnjdp52QUgg3dkG85+ktLA4udP18yHXZybVUi5bGh6fmI
         ldB2NZyLo4NHENkwPrjk72jxSRRHecdEIzjFraS7a5mxNhKBUR3oDLL8RzeE+Mg1oBvb
         Bx4XIt3AcQP6jKuGBdP7b3eaZ5OQ6adPHOMVP0+RaA1E2zhTGSle7c1GnPrfdtGVc5uM
         U4i2ND0A68JYTPy/PZG1GoThJ6p6UbJ8FSHLfpENONNno/uBhL5DEoc0dIKhJd16Hru5
         2kfAs5QrsxT1grKDh+4wJFCEweUFtkjHwhO9aAuICJw0bEkcGwSyMYPS3jmbF+HCkXZR
         kW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OKwbA7CkZ/dV0H/nAmt5zTOn4ixRO23QkLcRozVJn9c=;
        b=gE363wJnVzOhvme2Ngcjsl0o8xosvHHTabj0qv6Oca/eAYcC3/sa19UK7pzDKQPthd
         aW2NsnZe8znSecsikIsL5ZCVdVV7hmIZavAPwjzc8BaayuvOZ+xuP9IFlcJplMxE5OYn
         utp3vHGUGYog11+MI/dq6sT2OGVZ7XsSM4nBV8fvi+gUTvli20V3Fi5s+lMTxUHg4riP
         tzywyhPLRwPi7VcQ32QQBfDbmk3gcIQkFq6gGbEevw6D2C1DIRuJ56y/h0ZW7rmtH2mG
         l9jTXLA+wa96q27OSfm2aSdPux3Vtskiq53L68j5YqmjIfMjmzUFH7QwM2fJFd5ReRnD
         aWNw==
X-Gm-Message-State: AOAM533l2Pm/hXhxgpZNUoT5GJCm5rduYWOY824pXpRePFnacWW2cOh2
        l1p5O/yE+AkUDTYEbOwjvu8=
X-Google-Smtp-Source: ABdhPJxgcecg3IPXVMwIZfDGLFQYkke32fidqSRIig816CldvD095OsSVj8q7xyfZSPzAIOiVlsL8w==
X-Received: by 2002:a05:620a:1001:: with SMTP id z1mr12329350qkj.204.1627846812598;
        Sun, 01 Aug 2021 12:40:12 -0700 (PDT)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id f10sm3621606qto.31.2021.08.01.12.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:40:12 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v7 02/13] iio: inkern: apply consumer scale when no channel scale is available
Date:   Sun,  1 Aug 2021 15:39:49 -0400
Message-Id: <20210801194000.3646303-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210801194000.3646303-1-liambeguin@gmail.com>
References: <20210801194000.3646303-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

When a consumer calls iio_read_channel_processed() and no channel scale
is available, it's assumed that the scale is one and the raw value is
returned as expected.

On the other hand, if the consumer calls iio_convert_raw_to_processed()
the scaling factor requested by the consumer is not applied.

This for example causes the consumer to process mV when expecting uV.
Make sure to always apply the scaling factor requested by the consumer.

Fixes: adc8ec5ff183 ("iio: inkern: pass through raw values if no scaling")
Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/inkern.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index b752fe5818e7..b69027690ed5 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -590,10 +590,10 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 					IIO_CHAN_INFO_SCALE);
 	if (scale_type < 0) {
 		/*
-		 * Just pass raw values as processed if no scaling is
-		 * available.
+		 * If no channel scaling is available apply consumer scale to
+		 * raw value and return.
 		 */
-		*processed = raw;
+		*processed = raw * scale;
 		return 0;
 	}
 
-- 
2.30.1.489.g328c10930387

