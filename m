Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3532F3D0715
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 05:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhGUC01 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Jul 2021 22:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbhGUC0Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jul 2021 22:26:24 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6B7C061762;
        Tue, 20 Jul 2021 20:07:01 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id o31so306795qvo.1;
        Tue, 20 Jul 2021 20:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aLIjEv3Y3XGxT5C/sRBa0wIugXh2Hwubx4IA7LHkqcs=;
        b=LQE4Y14dktjeNg5+WJ5Yv8IXF2bJwzDDhOIJtWOvBucLM0aeie/s+V5AxnrmAS0nsd
         S+x/I2YCVMSMQhR6/FEhNZAuP1lkxZbLuW4OEjoLDZAKWmR6i9Rg9C/gjQTcBeRvha5J
         yCV+l2EBsZMiKa6h2dL/zoXcDDRtHE1GSoWNtjAAC/HSovnjtRlNNEmqh73PIeNkDRJ3
         3IVOQp4TexIsOIfp3xvnC1P6NeF3MsLyMB0ZytxqhV3wws+7jqewbpPV/lAM1/9N8Gwq
         liP0U//BZZOYHbzgn2AvVNv3aQ9F80fbdF53D/7onL0KEfe0CRzmA8j0QykM6R6rIzUl
         pQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aLIjEv3Y3XGxT5C/sRBa0wIugXh2Hwubx4IA7LHkqcs=;
        b=lBc54INnC1ACarARTTpTk6xZ+QBYGEUQ0kzZZjLsIr+U2YowlS9Ol9CEY3aQaoXbb7
         /yam4pABvTFICLW2AqfRvMS64uW10vRakk4cpFtiom2kmMGvgbCy6/NogSZQIhmiozhW
         Bs+jfQOWjJkoQMp74kPd3UMlXLBb/mIJkMOezCudu+NxPoyOWhDEmq5SrmEAEgIaqBNp
         ODN3MIPi/1CPLlfcRsDBWvQIkUj0mF4ZS0AC6AUNs0jtTX//6y3SHZqiOUibGfrrIIGx
         sgmMoZtXxTdN2DjRpwpybOE7H3DSejGsUtLPvzR1mFQYsm4Y2M9Eg0gsqEUBaxJ0JF7s
         kBpA==
X-Gm-Message-State: AOAM532IMsBqSBQWfLB7JosFw0xzQZ6V5XkcjCkno9Cu6FcfHGWGkn8x
        soh3FFT+lqzVrSZLcRkF9GI=
X-Google-Smtp-Source: ABdhPJwOZm6u8WfQCUC4PgRTb6IT2YUmJJE3CvbfIeizAjG+rFD8Bb+d0k9CelvrYXwwdBf1WxilJQ==
X-Received: by 2002:a05:6214:1941:: with SMTP id q1mr33142166qvk.35.1626836820699;
        Tue, 20 Jul 2021 20:07:00 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id g76sm10561024qke.127.2021.07.20.20.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 20:07:00 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v6 01/13] iio: inkern: apply consumer scale on IIO_VAL_INT cases
Date:   Tue, 20 Jul 2021 23:06:01 -0400
Message-Id: <20210721030613.3105327-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210721030613.3105327-1-liambeguin@gmail.com>
References: <20210721030613.3105327-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

When a consumer calls iio_read_channel_processed() and the channel has
an integer scale, the scale channel scale is applied and the processed
value is returned as expected.

On the other hand, if the consumer calls iio_convert_raw_to_processed()
the scaling factor requested by the consumer is not applied.

This for example causes the consumer to process mV when expecting uV.
Make sure to always apply the scaling factor requested by the consumer.

Fixes: 48e44ce0f881 ("iio:inkern: Add function to read the processed value")
Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/inkern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 391a3380a1d1..b752fe5818e7 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -599,7 +599,7 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 
 	switch (scale_type) {
 	case IIO_VAL_INT:
-		*processed = raw64 * scale_val;
+		*processed = raw64 * scale_val * scale;
 		break;
 	case IIO_VAL_INT_PLUS_MICRO:
 		if (scale_val2 < 0)
-- 
2.30.1.489.g328c10930387

