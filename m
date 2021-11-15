Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7B644FD97
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 04:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbhKODq7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 22:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbhKODqs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Nov 2021 22:46:48 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD510C061208;
        Sun, 14 Nov 2021 19:43:49 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id q64so4623664qkd.5;
        Sun, 14 Nov 2021 19:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jw54IKpjaf2lkn1AccMjzP5THrJX1wdOQq5FTCzCg5c=;
        b=DjLRDmDVbl1ZyXfxqXLk1sdMNlIAw/tQVyXtqgCGXuAKMPNc4nEPFvThwMufa8lLo8
         qvw4v2b66A4cDzPnMM5L8jKgwt8JixhJGrd2K3pNktNZo4axDrN88DodndrSpeSsPpUa
         9YDH6Th83X0FdrwVZdQa/bRD1wxHPXZcXbuoBme1Mp73SfDoDWZCGw4fELV0GSLlPjVM
         +ypz+eb5fPoVEjZNh3I/TnmdAdu8NFfzSiqAK/nZIqdLs5ZlN/eUcq7sBndG3H0usBr+
         Rx5EDYhyIxZIZWayZocsEphIKMEU+cQbSDHIVg5F3C08K/KJj/lzN8zhEt1THYiNpr71
         S6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jw54IKpjaf2lkn1AccMjzP5THrJX1wdOQq5FTCzCg5c=;
        b=6b/cFSupnqZF+0A4NDrwbbLTztH3DIb/vyFgg+kNGDEl1+qe4h7fV4lbwHUUGGXaBk
         Q9MNjV/laMZs8P5L8lWdKlrRs44bGMjtxz3w8ZCf4/Xsl56++CrOfFOp3LaNVwfmP8tQ
         gs2RkU2Nf067PzQVc77bGx5yPISwNcExdXJWlkXzeuPcToWumfd6R4tf9B2fzMaM5xfK
         x5YN4xsAzK4jPbAOuOfDe0GSiSjpm6AzWGNK05Vg3vx8eQPOQ5bmLKTmjcksiZLGpBMj
         ir0w91qCoensHTNcPUUmPhE8B4x6cAomglFCE6cIku9E/dATy8MFpI1JAQHEjP+wOIPF
         Ttqw==
X-Gm-Message-State: AOAM533c+8PRlNceqLOwjAsCreAmz3AQu2nylwXWtT3k/0gIUstIa51k
        KjC/jOlOwyKJH+BsH3hyOH8=
X-Google-Smtp-Source: ABdhPJxL/aQ5f6EoQ5PThbTF+n8FB/+yxi8RKinApwa1x4nntEkDDH6FvPHU7hQOwMcq2q8zlFgHWQ==
X-Received: by 2002:a05:620a:3191:: with SMTP id bi17mr22879088qkb.266.1636947828961;
        Sun, 14 Nov 2021 19:43:48 -0800 (PST)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id h5sm206519qkn.62.2021.11.14.19.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 19:43:48 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v9 08/14] iio: afe: rescale: reduce risk of integer overflow
Date:   Sun, 14 Nov 2021 22:43:28 -0500
Message-Id: <20211115034334.1713050-9-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20211115034334.1713050-1-liambeguin@gmail.com>
References: <20211115034334.1713050-1-liambeguin@gmail.com>
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
index 394f8b16b29c..17036130d364 100644
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

