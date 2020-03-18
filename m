Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02E2618A2F1
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 20:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCRTKJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 15:10:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42252 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgCRTKJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 15:10:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id x2so14038339pfn.9
        for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2020 12:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VOBWLQGfw9hrqp4HF5VYzgZRzQyGWfm20OBERquZAJc=;
        b=U7zWEe3WEQ29YB5/radORzKH73O5kRYHPpMzba+xgFWKmGl7C/o7Q5Fe4iH0LzeEKy
         O+e3AQFmpsr7dwb94lu+zUyeZ6lURQuNd1CHRLuJpquzbz4UD3nfJa5SajkmawxS/f3l
         hMAtYbR+Cf5JDSkDiWbj0/Q4Y7raEaj0/cd4jXAcPyIhVlZ6arhRE99yOf/GuECybr2W
         FI3BV/goHCyztfawbmMzxh5qRQ/sJoHS5Uz0JcStd2O06lVL+U7RNXnpKgGYKSC90V8/
         wioTPZxFQptjiPLtlPW81Lfd3u36KV5A+gS+MsxHXbpKJGInXKrvZEkoxqsP0hKyVWmS
         AKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VOBWLQGfw9hrqp4HF5VYzgZRzQyGWfm20OBERquZAJc=;
        b=idZx9OGQ9usiAv5QHf+rNutbXwVn4fKWjcyhlTQmf2lgkArWTPkqLQOk+bg/rv1sEZ
         vagDsrRaQUWVLj6uJR2glEMVUStnG1PeToo8Zp9VMZct+I+LRiqpEXvIc9iyrmxkeOGC
         WXzpz1HLzDm0KaSxz0T2Ndm1JxU/qL6G7plXmhCYdiKy1Y28zmjb1LDuJxjqJQbjQQNl
         t8/eR1bKNQ7xUEKqSw5CClkGJEuuN1Z/z05NRLEqmjHArzZA6QfGg2xl/JXOWlzh0z47
         sqTnG2zcofdxauqLMth2og9pS5KL6/K6H/7wvXW/oh0BFOWfTS5iAneUL0eGSPhhA/Ib
         MMWA==
X-Gm-Message-State: ANhLgQ11SQxAq3A/KZaSAojqbyBNxyY6VjREqD2c53zsBKUUm+Xv2bEJ
        MST+b0t+ihene9UnDf9mc1o=
X-Google-Smtp-Source: ADFU+vszJHONjwMNvdqTloVIQYxvQsSPyehd2PU4fpdgWBSXg9rO7+It35XfJwpu0C56Eh3x6XgE2w==
X-Received: by 2002:a62:5c87:: with SMTP id q129mr5801804pfb.82.1584558607941;
        Wed, 18 Mar 2020 12:10:07 -0700 (PDT)
Received: from deeUbuntu ([103.241.226.97])
        by smtp.gmail.com with ESMTPSA id b70sm7678812pfb.6.2020.03.18.12.10.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 12:10:07 -0700 (PDT)
Date:   Thu, 19 Mar 2020 00:40:02 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, kieran.bingham@ideasonboard.com
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 3/3] staging: iio: adc: ad7192: Reformat lines crossing 80
 columns
Message-ID: <89282ed6f355553eb1e81ae9b5f991eae4cd96ba.1584557481.git.mh12gx2825@gmail.com>
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

Macro arguments are computed at the time of calling the macro. This
makes the lines cross 80 column width. Add variables to perform the
calculations before hand and use these variable in the macro calls instead.

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
 drivers/staging/iio/adc/ad7192.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index a5b6cc1fc375..2a9c68aa8260 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -480,14 +480,15 @@ static void ad7192_get_available_filter_freq(struct ad7192_state *st,
 						    int *freq)
 {
 	unsigned int fadc;
+	unsigned int sinc3_filter, sinc4_filter;
 
 	/* Formulas for filter at page 25 of the datasheet */
-	fadc = DIV_ROUND_CLOSEST(st->fclk,
-				 AD7192_SINC4_FILTER * AD7192_MODE_RATE(st->mode));
+	sinc4_filter = AD7192_SINC4_FILTER * AD7192_MODE_RATE(st->mode);
+	fadc = DIV_ROUND_CLOSEST(st->fclk, sinc4_filter);
 	freq[0] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
 
-	fadc = DIV_ROUND_CLOSEST(st->fclk,
-				 AD7192_SINC3_FILTER * AD7192_MODE_RATE(st->mode));
+	sinc3_filter = AD7192_SINC3_FILTER * AD7192_MODE_RATE(st->mode);
+	fadc = DIV_ROUND_CLOSEST(st->fclk, sinc3_filter);
 	freq[1] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
 
 	fadc = DIV_ROUND_CLOSEST(st->fclk, AD7192_MODE_RATE(st->mode));
-- 
2.17.1

