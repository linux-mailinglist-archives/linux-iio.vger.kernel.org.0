Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3683C9630
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 05:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbhGODPd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 23:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbhGODPc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 23:15:32 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44183C061760;
        Wed, 14 Jul 2021 20:12:39 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 23so3871139qke.0;
        Wed, 14 Jul 2021 20:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OKwbA7CkZ/dV0H/nAmt5zTOn4ixRO23QkLcRozVJn9c=;
        b=h5DRdorl/Cv+oBCaUXejlaBxd8o0gxonA1RPHhSv+DJ4AKfOKupLmfbs6sYjhtUUT3
         61jvAcuMFZb4vv+n8Hf8E+hmc6GgmPkg7MpzYVYwfNb8zUIXsCTNS7GZdUmMF+nLViLu
         OLotoUm+H/N5hMyiNJfEZtpukayfpqCWqU9CO6gbWK8vERYzIq3vDoaHNRdjAoCGnX8A
         HvIMwphtM0ku6CqgdhDesgMw+VoTYISpdGgbOZZXC6W/fkZQBa9sR2DL+ZuXcGx3TDnd
         zVClW7wKEg0b2QvVqNO5routjGZamDaRPol60JwRRosXsp01NMbsfTAf+yOndTsWcqzD
         InXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OKwbA7CkZ/dV0H/nAmt5zTOn4ixRO23QkLcRozVJn9c=;
        b=XGL+0FyiIzju5mlVLmbfwaxHkEA/KCbhMMv6lGM0yi1cshpKcVKgR0tQFw/ZuSwDil
         D0pKkRCiTk5+EFuImrANqzdDUQaW6oOcvuiwTnkHCD73b/I6ymqFiKa2FSXOmileX/OV
         h7GleKy3sg20LGM7sNNAC8jgd3tOMhjVQO8o6TaVoIReZQYpY9UUM2OvipDpJ5wwKJX/
         yCfKhwNoeAurcsg1wmJrcJLspDHzbbAEhTojoG11GHL1ik3FcJiGNgW23JSwDS0UHyQK
         v9yGnybO3HL0JzHoy6l89xFX+Rov4tGomYEYKszV36/urKJDFMu3BhI3UK1yF2G5XyuE
         TvNA==
X-Gm-Message-State: AOAM533DYTKe1hY6R+rvCc9zLCuxi275xmeUZG1k3R3NnmivueXx0xfX
        Xkipzo4KDa+NOxf1+7bhWQc=
X-Google-Smtp-Source: ABdhPJybJtHNP8AsTErA+fNnk3JfPtodx7D32j58h2ivpHuFUOJIZ1jYFVRvoa/3Nqku4ZC7aaaZ1A==
X-Received: by 2002:a37:43c9:: with SMTP id q192mr1472077qka.470.1626318758486;
        Wed, 14 Jul 2021 20:12:38 -0700 (PDT)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id t125sm1932847qkf.41.2021.07.14.20.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 20:12:38 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v5 02/10] iio: inkern: apply consumer scale when no channel scale is available
Date:   Wed, 14 Jul 2021 23:12:07 -0400
Message-Id: <20210715031215.1534938-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210715031215.1534938-1-liambeguin@gmail.com>
References: <20210715031215.1534938-1-liambeguin@gmail.com>
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

