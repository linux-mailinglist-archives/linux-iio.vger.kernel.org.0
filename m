Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B7A3B8B79
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jul 2021 03:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238252AbhGABDT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Jun 2021 21:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbhGABDS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Jun 2021 21:03:18 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19268C061756;
        Wed, 30 Jun 2021 18:00:48 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id dj3so2127771qvb.11;
        Wed, 30 Jun 2021 18:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aLIjEv3Y3XGxT5C/sRBa0wIugXh2Hwubx4IA7LHkqcs=;
        b=abeBQ7HDze70AzrZWLTyi/x0HPTwfGhKphNcgOT8r7VAkeLghAo2c5uxwnmmWMLZAY
         AGd2TI8mW6gja4AjQeqnzq5pDS8fVVUvHXfLvGtTB1MvlNpSKrfLyWdB2FLAbcVQNJ5f
         ZWyJhcRBaqOWrU6DxLVPOc58Tud1NCer9EjcWTzwnxFGZPrVi4GJhNZSIsYJ2ZQwtVdd
         3RDXjKz7oD0nd2iMjWrjuhpxdm7Jhtcab2a40eSzUF1DtqRVVoL1yEI3Xilb4VxfLZ7f
         uAXvN5RNVJxQ4T3XxQRrjwc6AKY02TmQQ0eojkVwEr0hpmoUgRk9H4q5kIHkvE6/FzRD
         XyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aLIjEv3Y3XGxT5C/sRBa0wIugXh2Hwubx4IA7LHkqcs=;
        b=eumO9YpWvc0qGdP2Vv20ukSKPbYb1zViaecDIEnZItwqdTvDIOB/kVhfkg+nfzgYrF
         jbisWcr8b+KE3ls7CRMKLqMTCK8ASgQPl63mEn6QeuM5UtCKMBgdNZM2MUqXNaeSHULZ
         5bJaiyv/Lh+ga6wdjwfc4Iq+RLpjlclkt0ew/tfzuxbXy2S5tEzAQHZyPCFHEsu6+2wm
         ugWxGnWSQHXhIM1uvYuo0DhvSbLW7e9od2DWkAaZkcllbYxQFP1v//f2knD/1yhNxXuN
         5gwROEKdgDdLVSc2Tw++4pQYe5SETtFtv9kQQ1w6Z/gjnRceithbtLBKij9SC7Zj2Q2s
         KBQw==
X-Gm-Message-State: AOAM533yLVVKqrCK2C7l3SL/ZwlGGoiItW6dpC8qnphDnHpvopGa787D
        +zje0kdg5Qq1LYzJeieSerk=
X-Google-Smtp-Source: ABdhPJwSNrLpc8fuZVizpnNA/xDQxi4rl4wrIH4nvKcCWOhUShh+Y868e9ZGVwNzR8Rad3/CQtQ7yw==
X-Received: by 2002:a0c:9e49:: with SMTP id z9mr39578031qve.52.1625101247172;
        Wed, 30 Jun 2021 18:00:47 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id l127sm14087782qkc.64.2021.06.30.18.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 18:00:46 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v3 01/10] iio: inkern: apply consumer scale on IIO_VAL_INT cases
Date:   Wed, 30 Jun 2021 21:00:25 -0400
Message-Id: <20210701010034.303088-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210701010034.303088-1-liambeguin@gmail.com>
References: <20210701010034.303088-1-liambeguin@gmail.com>
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

