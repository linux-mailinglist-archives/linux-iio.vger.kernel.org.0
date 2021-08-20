Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79583F347F
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 21:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237996AbhHTTSt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 15:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238661AbhHTTSp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 15:18:45 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BADAC0613A4;
        Fri, 20 Aug 2021 12:18:01 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id r21so8267295qtw.11;
        Fri, 20 Aug 2021 12:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y+d7i6VNQL7/AzXrJYxjwN+0uTqvj42FO5FoBzckvOQ=;
        b=j00J1cFAFoK82HRUM/wQ9AoggSBeZcRA4T08k3Lgh8Semk3jC/u8WC1MZ9Ebi6jlMv
         HNBL+wvqMvL3NzZlsCclw5PJ2NCSjbhzjSI948CIVT9cLciSmptZCxgrt3BLC2XS/Vfg
         uzYEquss1lX462b0s6UFW7Rq73+hjnLIwlxXoHwGt2zCj1S98vtDSFO7zp0JBZdzq5Ui
         1EmaU1b+Ky93AzUy2CUOZvpmOEx562sW/FMsp2WxAm8ex1eCIz91MQnMFLiXjSgaDUJX
         cWkRJEf+NG88USM1OYA1gdoyiHKxNcX93PQtwbOXdg7HtL6iIJnWQ0mJy8ERwvyrabp9
         VeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y+d7i6VNQL7/AzXrJYxjwN+0uTqvj42FO5FoBzckvOQ=;
        b=E6D3ws8AFwZ8F1m7REe7ZnzxeCTJkrN7DXoSPuJWd/VNI3I1dx/NhL6YTTKqwprARi
         xEqdTQGGMqz/0aTy0JQduflHi3nPcjmsTXHRrzDPa3ViRJ+yWKsyhMJrv+/V2IukkdW2
         pLf/R1LIeIfcbKRtuA/Fo7Rq3WHJn0KQCiVoN+8tQYojnjMINjrFl+FclAU3zBRb4gYX
         h/iIccErrv7O/Sz20z6d9H1qLo+zSdsx4zCHSUAvFhtVg6oxKV/TtQTv9R69HXrjnn2U
         Xz65NJpeiZVfPO106p5MSc9uvMOnFhpcLXSLKFmq2jroJ0luCT0Yxx3qkKSAGEdoYTGX
         hgXg==
X-Gm-Message-State: AOAM532bw4Ziz2rnZ5W7lBnGE4/db1vWaDXgaDRuPrwj+OMPsQs+Ms8l
        TOs6UUdszADHl1uWOaAVfHU=
X-Google-Smtp-Source: ABdhPJxaiOEUnfdcHhv/uvEPJUETGmctk4qghzh+OU5Tx5VYBhAPtYedxKkNdE5zgoTiHjHBmHXyuQ==
X-Received: by 2002:ac8:13c8:: with SMTP id i8mr19147787qtj.219.1629487080350;
        Fri, 20 Aug 2021 12:18:00 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id o6sm3603869qkp.111.2021.08.20.12.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:17:59 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v8 08/14] iio: afe: rescale: reduce risk of integer overflow
Date:   Fri, 20 Aug 2021 15:17:08 -0400
Message-Id: <20210820191714.69898-9-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20210820191714.69898-1-liambeguin@gmail.com>
References: <20210820191714.69898-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Reduce the risk of integer overflow by doing the scale calculation on
a 64-bit integer. Since the rescaling is only performed on *val, reuse
the IIO_VAL_FRACTIONAL_LOG2 case.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 809e966f7058..c408c4057c08 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -27,16 +27,13 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 	u32 neg;
 
 	switch (scale_type) {
-	case IIO_VAL_FRACTIONAL:
-		*val *= rescale->numerator;
-		*val2 *= rescale->denominator;
-		return scale_type;
 	case IIO_VAL_INT:
 		*val *= rescale->numerator;
 		if (rescale->denominator == 1)
 			return scale_type;
 		*val2 = rescale->denominator;
 		return IIO_VAL_FRACTIONAL;
+	case IIO_VAL_FRACTIONAL:
 	case IIO_VAL_FRACTIONAL_LOG2:
 		tmp = (s64)*val * 1000000000LL;
 		tmp = div_s64(tmp, rescale->denominator);
-- 
2.32.0.452.g940fe202adcb

