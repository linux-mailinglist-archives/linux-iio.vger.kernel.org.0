Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C022239DF2E
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jun 2021 16:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhFGOui (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Jun 2021 10:50:38 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:40781 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhFGOug (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Jun 2021 10:50:36 -0400
Received: by mail-qk1-f180.google.com with SMTP id u30so16864043qke.7;
        Mon, 07 Jun 2021 07:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OKwbA7CkZ/dV0H/nAmt5zTOn4ixRO23QkLcRozVJn9c=;
        b=uB8iMLzLtQnPC4uy6Oy+bBk/7uuGVoR/+yjBxcJLo51kqUK5EtLNNUkfb1zTnPSQ3S
         JaqbeGS5MY2w/6SiaXbYFMJI4NsV79YtWiu/Ix9Btwc+mvMpgTvIBj28md+H/xfJeyOy
         sT/8CNCcHctHGK5RY04/DSd/YIw1n+MBaHfW7/zZF4xmFVhXRuz3/OfXAxzV9CHF1jjQ
         an/9gery/oxlwOW1J25EaXgcf7HyvEtO+GsL2uXeOLHOKibabzlPeIi/xzN3Uk563Ayb
         DPDezHcalYB4oI4ThK7fWjCkrnznOI96zyjOfdqELjNCK8NLNSpdws6Wpr9bhu8Odkzn
         2OsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OKwbA7CkZ/dV0H/nAmt5zTOn4ixRO23QkLcRozVJn9c=;
        b=OmhGZEVEFxicbpZDGa7nlrawK28CNeKFjYI5kI6Cv30CIeT3zIEmecE81rPAs5TzkJ
         s/UqetURTSj7zJ5Iw3II456RZkwEjrSXyC+fwAI0EfFS32aZelehVEYO+gxu3A+7h/Yl
         EyY69vy4AFQjYMYEJrx7ujl+0X3Q+htJSo4q4i5wv/+0Me/uqnmn1SanzKZBcNUeKMtv
         ACuGnKeCCXz7v7OPZpYZipkBr79NiTqlmChHpSMXNLdRCYWOwMQ9LnmIpDZPzcm/Uhv8
         EpvXoyXT9sIb4rk5715sa3H5yTME64lKJ5BolVLergf0G1az9n+qe3OiarpHW3yIOgX4
         /N5w==
X-Gm-Message-State: AOAM530vVYnsZN+RibhVR5geApxrvhhKDIEYRCY1DhfVvTQSIRNpQyVU
        WemBF/eOlJ+4sHLehsF96/I=
X-Google-Smtp-Source: ABdhPJyiAT3fTtx138sRldeyD+npBsaC2xzgmtE0T0miVZU0YmivlFA2jKtw4kCBUGLX6r/13vxohA==
X-Received: by 2002:a05:620a:f03:: with SMTP id v3mr17338663qkl.96.1623077250208;
        Mon, 07 Jun 2021 07:47:30 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id s7sm4157855qkp.35.2021.06.07.07.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 07:47:29 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v2 2/8] iio: inkern: apply consumer scale when no channel scale is available
Date:   Mon,  7 Jun 2021 10:47:12 -0400
Message-Id: <20210607144718.1724413-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210607144718.1724413-1-liambeguin@gmail.com>
References: <20210607144718.1724413-1-liambeguin@gmail.com>
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

