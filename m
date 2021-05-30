Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F89F394EC5
	for <lists+linux-iio@lfdr.de>; Sun, 30 May 2021 02:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhE3BBJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 May 2021 21:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhE3BBI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 May 2021 21:01:08 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B347C061574;
        Sat, 29 May 2021 17:59:30 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id v8so8014246qkv.1;
        Sat, 29 May 2021 17:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mbqEA5IK/uO8G7pI1RDGv5fK4ScxDTUkLTrFNzcvRf4=;
        b=vO0YqN5I/XDF0yCaJ9zOSj3wK6PHcctkjn2+AwQLlhkkQj+BtESgICLUqoBIJNCanF
         Fr1LhKK/NXCQDfLc4PEh++qnUff3SFxbyOPnzEWQ6gbYO++5TsQnwW7GPAjO+0subBGw
         XeWQMFmQas6tvmc7f1vhr3oqQ3iI9a3xpQIYs60qsm/ZVE6nLWxDYCBIgXZfHJmejlhR
         mzT2Qk07vF2qXUDhBLbzJYjXqZ/nLtA0PxWnOhFU4qyrvGJJzAdFsWwhtKccsk9TB+Yh
         b4zVJlRENFkQ4uLrmOvAlohtFkDJF2uJhK1DGPFCrx7mHI/SNfdO+cIavZ9VLgjoU+Ov
         dejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mbqEA5IK/uO8G7pI1RDGv5fK4ScxDTUkLTrFNzcvRf4=;
        b=Fw/neIvHOZku8kgemnGNKZ2LmTQVpNZr2oXpwrNeHbjHnTx3lUj4Ymd9aMwMHLICyb
         yuI4N+xfeVhy0pUKDcCFmOVVMqybMAqN7zfL2wIGZ/1yBPNfnzOESlvokP9gyf3MiEEH
         UIOJ5MiZyyPHuGUhaUk6u5SZnNkm2g0xVoO7d4H8KqYXTfQJyYdooY81Vc23dxUQIv2Z
         lRM7RGnl1GSdORmbfr4ueRkfG4Vrl7fk66IxpWW8Bi92lom8v6XydK2nHBgfM5nRedwv
         29ZKqnbGnDa4ZWS4VCEVko2aMv8wN1hS+4Q5lNmbgfpGdPQXr+dfG5R9Fpaxgr7V2GN5
         oCeQ==
X-Gm-Message-State: AOAM5326uvZ3+DWCEHEh0TgOvjEVOq96+775KpcqvoCp0TnYCBX6v0hz
        Wyd3Gdak5MM/RmtNeFs7Y4ARdUdwwf6HAQ==
X-Google-Smtp-Source: ABdhPJwb32aYZj8i8XGtpuUevM4VFR8cwgxYisXE3ldklNXOqT5IFAQ4bNn5zQt2Wix1OPhjZyGUBQ==
X-Received: by 2002:a05:620a:2ec:: with SMTP id a12mr10152780qko.92.1622336369680;
        Sat, 29 May 2021 17:59:29 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id z1sm6382601qki.47.2021.05.29.17.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 17:59:29 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v1 2/9] iio: inkern: error out on unsupported offset type
Date:   Sat, 29 May 2021 20:59:10 -0400
Message-Id: <20210530005917.20953-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210530005917.20953-1-liambeguin@gmail.com>
References: <20210530005917.20953-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

iio_convert_raw_to_processed_unlocked() assumes the offset is an
integer. Make that clear to the consumer by returning an error when an
unsupported offset type is detected.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/inkern.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 4b6a8e11116a..dede4536d499 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -595,8 +595,12 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 	int ret;
 
 	ret = iio_channel_read(chan, &offset, NULL, IIO_CHAN_INFO_OFFSET);
-	if (ret >= 0)
+	if (ret == IIO_VAL_INT) {
 		raw64 += offset;
+	} else if (ret >= 0) {
+		dev_err(&chan->indio_dev->dev, "unsupported offset type");
+		return -EINVAL;
+	}
 
 	scale_type = iio_channel_read(chan, &scale_val, &scale_val2,
 					IIO_CHAN_INFO_SCALE);
-- 
2.30.1.489.g328c10930387

