Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5843394EBE
	for <lists+linux-iio@lfdr.de>; Sun, 30 May 2021 02:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhE3BBG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 May 2021 21:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhE3BBG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 May 2021 21:01:06 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA6FC06174A;
        Sat, 29 May 2021 17:59:29 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id j189so8019851qkf.2;
        Sat, 29 May 2021 17:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M+5j+Z5LbA7a2FIvAeMZE8bSlMINPxKMfuNuPFa97JU=;
        b=fOybSCm/yYyrc8H3+/eQ7rt01iHz7k6s3hHW0sOq0QwceASTYe+oX3ljZ9YK/R18iR
         7bb9ZB9/vhXRyvKg6eFL1p161fE9wChOVY/23GPNkakUHWRX+e8n/u+7yDPXA49DELAX
         3L61NMvGDyt3+YGM0bnt2j0idBs12Me0tbHlSXctSSkIA+DIyZq3uO9jJqzNfgedDdNN
         /OlIme4eVzN+yAPTcjILtMF6TPGEj0XD6wIoONNYuJYbeXy6ITjuGxd+UAhLx0af5WK3
         GggSl6LBB1BTX7RanEq2r7LGo18S11MUIdfAa2G6R9pNehDFB5VK6K3II5r4yV/XZ+fG
         wcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M+5j+Z5LbA7a2FIvAeMZE8bSlMINPxKMfuNuPFa97JU=;
        b=DyPjo8YiHAVTUPTHO2qVRxe1cnZA9sNcr3yvatkyT399TFYqKxMlS8zOduE38naKEt
         Is2tgloq3JSGNrrtowTpK6YtBfOJzYibgamCLD79IujJ92V82x+ncRv6q7yRXJZJ2xY8
         Xd3q3XMBzA1W302JybZRtMYSwAU9t2aInru34kLnnwWyaY+Z3ObL9hElt17MUsjFrw+g
         nXnK+mQNFt/9v1cksq3deBsZm8Jx0CTYMVFoIL4qUNyNf9NJZBnxZP+KBT1PFtDeWIRi
         9ITRrZNi4QrrDErPXO7Kct9VBy4pqSZjWqNxqTb1njh9q09u/ovrQwrO2GN3qLCvm5cz
         wfHw==
X-Gm-Message-State: AOAM533NWi+MPdUkCPwY4zHsa0uGwVPSSVVkWOAq1vcPOhqdI+//cgRD
        UQoVetIUiiYavlBQC/s9xOE=
X-Google-Smtp-Source: ABdhPJwsWQi6t8e9B+89hQGrErNBIH8mw8IDv9SLAbroW2HTVVaV3V+A6P2Mvr/ZA9eSh/2e8aPSyw==
X-Received: by 2002:a05:620a:12f2:: with SMTP id f18mr10696137qkl.122.1622336368566;
        Sat, 29 May 2021 17:59:28 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id z1sm6382601qki.47.2021.05.29.17.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 17:59:28 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v1 1/9] iio: inkern: always apply scale requested by consumer
Date:   Sat, 29 May 2021 20:59:09 -0400
Message-Id: <20210530005917.20953-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210530005917.20953-1-liambeguin@gmail.com>
References: <20210530005917.20953-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

When a consumer calls iio_read_channel_processed() and no scaling is
available on the channel, it's assumed that the scale is one and the raw
value is returned as expected.

On the other hand, if the consumer calls iio_convert_raw_to_processed()
the scaling factor requested by the consumer is not applied.
This for example causes the consumer to process mV when expecting uV.

Make sure to always apply the scaling factor requested by the consumer.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/inkern.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index db77a2d4a56b..4b6a8e11116a 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -601,11 +601,7 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 	scale_type = iio_channel_read(chan, &scale_val, &scale_val2,
 					IIO_CHAN_INFO_SCALE);
 	if (scale_type < 0) {
-		/*
-		 * Just pass raw values as processed if no scaling is
-		 * available.
-		 */
-		*processed = raw;
+		*processed = raw * scale;
 		return 0;
 	}
 
-- 
2.30.1.489.g328c10930387

