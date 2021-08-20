Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F693F346E
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 21:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbhHTTSe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 15:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbhHTTSd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 15:18:33 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41113C061575;
        Fri, 20 Aug 2021 12:17:55 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id jv8so6083103qvb.3;
        Fri, 20 Aug 2021 12:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yb6bnKhOc9+gxx5x6SczajCd0sry7xBboXJ9PwvGMsI=;
        b=sR8bZqMrBNE+TiH5qENySn5XAG7Uaam+WvV2837eME4b5k9UjUOE9Bi/etvlpn1dKW
         e5EonlIKrFYGv1DS/aeq8TXG4r+ISBswKLsnO+7TRM+Yi1hwuhBTtbjH3rvxZOIj6M8V
         wVC7ljRx4TzFr3v1DtqZ0GZXnDELCIy3iuShIzdpm/s8aKVd1fO8XCoLFEUejR4ZbU7Z
         sP3ecnFl94GXozoO7tb3KLl9mK2yHbIYrhqfntx8hCxfrP6Y6Wwow1ls6OcxL+7BVJzg
         +mbagkmtNVMbjrDtFoDwOwFpGfHvuGtBB4h/dKag4kNLHRsztHTFHNqzlToTOObbfOo3
         FtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yb6bnKhOc9+gxx5x6SczajCd0sry7xBboXJ9PwvGMsI=;
        b=YQAxF0o7FAhx/eyRcpI8sAyDJxsOVsp57Lyt4LZ1gmHmo6pJC6Crijt71vpvdounE5
         fd73VHUOR5UVUG6j/pFMtzabowtRYtZ+zQljtjPWzUC7fdBAmYQvV5yynEySlGDgjL5b
         KCJHBEkxrPtvnTGjuysHx1Z9wBxDs56Q6EvBvv04KyO71uba7p6qYkNjF+y4YR3Rk+jZ
         7t6eUvcaM8qH6YL6A8sawV2++Jbn8HfFE+HpU1dcPt2bbfy6KQMzLJCs+pulLmWTrTby
         oAe/CJJzo5WdSpP4Us9tj8wx+a9PESnccn02tA60YAkFs6OgptSRn6HwBb9u13S9SApl
         MwMQ==
X-Gm-Message-State: AOAM5338b4U4jV46DqqfwpWrV12uVp6onMDJcR7W2v5/gNTelOBnT5eC
        +qHydkZAM2pObmPc3z9dYeI=
X-Google-Smtp-Source: ABdhPJy5izsCHrKgZpcSGSbSDKOGOu4fv+ERS7q5UOqJtvBoUDkAcXpOa7VSXIlB9U0waFZBcVzo1A==
X-Received: by 2002:ad4:438e:: with SMTP id s14mr21716393qvr.26.1629487074532;
        Fri, 20 Aug 2021 12:17:54 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id o6sm3603869qkp.111.2021.08.20.12.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:17:53 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v8 02/14] iio: inkern: apply consumer scale when no channel scale is available
Date:   Fri, 20 Aug 2021 15:17:02 -0400
Message-Id: <20210820191714.69898-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20210820191714.69898-1-liambeguin@gmail.com>
References: <20210820191714.69898-1-liambeguin@gmail.com>
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
2.32.0.452.g940fe202adcb

