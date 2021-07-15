Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF533C962E
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 05:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhGODPc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 23:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbhGODPb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 23:15:31 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56624C06175F;
        Wed, 14 Jul 2021 20:12:38 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 201so3809957qkj.13;
        Wed, 14 Jul 2021 20:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aLIjEv3Y3XGxT5C/sRBa0wIugXh2Hwubx4IA7LHkqcs=;
        b=SXLG1AME+jZDiQqShuO4lpIRMS9uk2FqeRX8KwMynZa6qHxraMumJPtoE+KOcoEP27
         NRfaF7avW9GRpi8uoPHBWsBXJSWkVnbzh38md12tnZkYiFFZ0iL39lb4BJMmqds7ZGXi
         ZMK9MKhO9oLyO4TCmN2+gqGPfzG/8OGOUhm/6RFPwtUpvdANj1ybGpU63OttTGhWq1B4
         bHBXcTL3u9YoHJxYCV+21PEq8pYW4vEhCeFpCT2GYFp86f5s4MhCK5iuXBlTkPyhsGq3
         zliP96Y36O0OL+3YOfSkt3eCoWvnwo+++ctA9DHqbMrWkBRSByCFdYqmfDyB1OFzm3+h
         eZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aLIjEv3Y3XGxT5C/sRBa0wIugXh2Hwubx4IA7LHkqcs=;
        b=hFZXwBxRWmsXJQkXmnuvusTVp6sSdQOoInID5hteDy5LfCLJ4cTEdTbquD5IntXiUk
         PRFpPEBD5duzRYtHfGB0ULQjAAsG5r01YhJTE0fQ6wLyzSXh+jtskDS1tfWNFHIHaKKd
         Xj42vGh6RUmJRAsIQrrXzJlG+vOTlEZYgCkwdrASeyYhGmDgJ4fpSPLBCzkXvWI4DQfR
         5HyFtcJqsJOge2j0mnxhkHk23wUcyEJGzCMAFO4MyPXs117MABnC82CeNgchP4QVCD5e
         wVvu7Agh8FMETMRaP4PtKCc86OJLuc+gZK9MXFk/zm+Nx/c1KyLbtQOmKN3EMGgLohwx
         ZXqw==
X-Gm-Message-State: AOAM530TU6BN4qoIrLKhJSnPSGw1TUv0LOGtSUeR0zr2FqekH3BiOvk9
        9LCtL/ore6fnKpsZ783tzTE=
X-Google-Smtp-Source: ABdhPJw4L1G9mU41qAAtvtnmbgrKFIwht/EEvVq66G/8c7BnBFneE+CvHdRnYhVkpVQRk03F0KcXqw==
X-Received: by 2002:a37:b983:: with SMTP id j125mr1435238qkf.482.1626318757409;
        Wed, 14 Jul 2021 20:12:37 -0700 (PDT)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id t125sm1932847qkf.41.2021.07.14.20.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 20:12:37 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v5 01/10] iio: inkern: apply consumer scale on IIO_VAL_INT cases
Date:   Wed, 14 Jul 2021 23:12:06 -0400
Message-Id: <20210715031215.1534938-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210715031215.1534938-1-liambeguin@gmail.com>
References: <20210715031215.1534938-1-liambeguin@gmail.com>
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

