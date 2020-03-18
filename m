Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F58518A2F0
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 20:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgCRTJV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 15:09:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41598 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgCRTJV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 15:09:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id z65so14392173pfz.8
        for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2020 12:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YEEpLr5+9ztTpGaOz8N7g2LyZGmujAzWy12eX7YdNmo=;
        b=MjZCBBShUsR9RJeODy1dBujUBHxI4csLM446yIy8x9e4ZdtloWT0ZD+zMV0E1Ziqil
         IKjFYI5C7ehZdDdSPOCvpudCDOjmnBE3NKaTHUlLNzgq5N0XH6d9TdKgwcY8b6dDeOun
         zk83A8MDbUYPuwAHHweGgxTWEJwleQ+nLFizJLp1X42B+1jMXIQo0GO8kLm5qj8Jk01r
         8WY0NCyzvWIbRfA6VEEHNQ/JE58QAeOnWbPDOCNRuzjrQprkuo2W863dbJbYVqHhrfIy
         O6LBoUWYxcUqEUGpM3ahwk+HwnTdovD8YsVWA0HeO9/U2dls/+Er00gEAN86rutP9XAQ
         u1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YEEpLr5+9ztTpGaOz8N7g2LyZGmujAzWy12eX7YdNmo=;
        b=Z1YqTcajn/aZNH7M5TuLxhbv/ro18P1ODZPFQ/S+sFwgFgQJ8BDQsWTJM6X5eLpQ+e
         tp+YQWS1SzHHBOmr6oeiRvKAAURQgyM20RprOjKtwRAul0Aun+ItjIkk99TbVhZB5ljp
         qkRiqQyLMax2uqTIgRV2co+TIuiGwjPXN6vC9UAId291zfx0vE+nooVe/y+NDABK8nKm
         lhjLRDftEWbyaGFsqT7ROf6eHzdUHrTjTE7H56EXNSpmGtnRGAidz2l/KrXNvAzOAoSL
         4QLPyPqD4d48qpZ3i2DUorE62Yaadvp40j/0CKWTJT5Qps5bHUHl4AWE6ZZ9vrJEzytp
         e0yA==
X-Gm-Message-State: ANhLgQ28uBh/Pc0metq7Wkf6oGxXza8QL5Yvq0zha+Nd/T70+7g2Puzd
        AkUNgCFHooX4L2iAmZ+AiOI=
X-Google-Smtp-Source: ADFU+vuZAAHf/3CfLamAZA6JXtbjgfhIbWCvMZ2pr72QGuS2GmPqG/JNTaVFTbcqUBCzpxY3T1s4Xg==
X-Received: by 2002:a63:c550:: with SMTP id g16mr6330836pgd.9.1584558559252;
        Wed, 18 Mar 2020 12:09:19 -0700 (PDT)
Received: from deeUbuntu ([103.241.226.97])
        by smtp.gmail.com with ESMTPSA id m2sm6338077pge.81.2020.03.18.12.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 12:09:18 -0700 (PDT)
Date:   Thu, 19 Mar 2020 00:39:13 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, kieran.bingham@ideasonboard.com
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 2/3] staging: iio: adc: ad7192: Correct macro names from SYNC
 to SINC
Message-ID: <4eaa90f120a24fd5f08338d0643ee8f215f169b1.1584557481.git.mh12gx2825@gmail.com>
References: <cover.1584557481.git.mh12gx2825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1584557481.git.mh12gx2825@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Three macros include SYNC in their names which is a typo. Update those
names to SINC. Change suggested by Lars-Peter Clausen.

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
 drivers/staging/iio/adc/ad7192.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 51b1cd3ad1de..a5b6cc1fc375 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -143,9 +143,9 @@
 #define AD7192_EXT_FREQ_MHZ_MAX	5120000
 #define AD7192_INT_FREQ_MHZ	4915200
 
-#define AD7192_NO_SYNC_FILTER	1
-#define AD7192_SYNC3_FILTER	3
-#define AD7192_SYNC4_FILTER	4
+#define AD7192_NO_SINC_FILTER	1
+#define AD7192_SINC3_FILTER	3
+#define AD7192_SINC4_FILTER	4
 
 /* NOTE:
  * The AD7190/2/5 features a dual use data out ready DOUT/RDY output.
@@ -366,7 +366,7 @@ static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
 		st->conf |= AD7192_CONF_REFSEL;
 
 	st->conf &= ~AD7192_CONF_CHOP;
-	st->f_order = AD7192_NO_SYNC_FILTER;
+	st->f_order = AD7192_NO_SINC_FILTER;
 
 	buf_en = of_property_read_bool(np, "adi,buffer-enable");
 	if (buf_en)
@@ -483,11 +483,11 @@ static void ad7192_get_available_filter_freq(struct ad7192_state *st,
 
 	/* Formulas for filter at page 25 of the datasheet */
 	fadc = DIV_ROUND_CLOSEST(st->fclk,
-				 AD7192_SYNC4_FILTER * AD7192_MODE_RATE(st->mode));
+				 AD7192_SINC4_FILTER * AD7192_MODE_RATE(st->mode));
 	freq[0] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
 
 	fadc = DIV_ROUND_CLOSEST(st->fclk,
-				 AD7192_SYNC3_FILTER * AD7192_MODE_RATE(st->mode));
+				 AD7192_SINC3_FILTER * AD7192_MODE_RATE(st->mode));
 	freq[1] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
 
 	fadc = DIV_ROUND_CLOSEST(st->fclk, AD7192_MODE_RATE(st->mode));
@@ -575,25 +575,25 @@ static int ad7192_set_3db_filter_freq(struct ad7192_state *st,
 
 	switch (idx) {
 	case 0:
-		st->f_order = AD7192_SYNC4_FILTER;
+		st->f_order = AD7192_SINC4_FILTER;
 		st->mode &= ~AD7192_MODE_SINC3;
 
 		st->conf |= AD7192_CONF_CHOP;
 		break;
 	case 1:
-		st->f_order = AD7192_SYNC3_FILTER;
+		st->f_order = AD7192_SINC3_FILTER;
 		st->mode |= AD7192_MODE_SINC3;
 
 		st->conf |= AD7192_CONF_CHOP;
 		break;
 	case 2:
-		st->f_order = AD7192_NO_SYNC_FILTER;
+		st->f_order = AD7192_NO_SINC_FILTER;
 		st->mode &= ~AD7192_MODE_SINC3;
 
 		st->conf &= ~AD7192_CONF_CHOP;
 		break;
 	case 3:
-		st->f_order = AD7192_NO_SYNC_FILTER;
+		st->f_order = AD7192_NO_SINC_FILTER;
 		st->mode |= AD7192_MODE_SINC3;
 
 		st->conf &= ~AD7192_CONF_CHOP;
-- 
2.17.1

