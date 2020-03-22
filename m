Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B389518EC0D
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 20:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgCVT4W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 15:56:22 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33636 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCVT4W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 15:56:22 -0400
Received: by mail-pj1-f65.google.com with SMTP id jz1so9645pjb.0
        for <linux-iio@vger.kernel.org>; Sun, 22 Mar 2020 12:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4mmFgFlr44x8W7HUsD9TTAhCqpazgNzz0n6SLIavbyQ=;
        b=rlqFC51DqHLLPbWDm5lUR186fTdfDKfp98yV+fhZiO8B7zcFQ9lX/5HAkCOAJKaDmu
         Y0UJn7AI+slSqQgj1D0rPxjKCLyYSwt4LQ3T3GpjZR+R5LAzfUwGLU0Q36K0x7einr8+
         bGK6nsxULLT/JFplvFNcZGbuQn8LEiEMfoiti/fRCj1tIfRPKdHvGqQwykCW4bboyA1X
         mtj0FrZtluMsTmuVfE+H9gu6AoqhtksIt6xaGA81ctsYRqyKkgo7HIJ21L6ifm+Nfdyg
         D7Gm/Ppzvn3sWAjfLgmuAPw3R6ABUVP6pE27JMaL4ZgEXSEDazHqdYvLe1elQ4bwxyyZ
         F5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4mmFgFlr44x8W7HUsD9TTAhCqpazgNzz0n6SLIavbyQ=;
        b=XUgIzpo231WVFT/vQ5OBeDFp9yf6FE2LaoZQcPlsQwo3O9PJEAq8apMOaUU0qHSa78
         hOycRW5dazxOLBDjD6+ijWkC7SOas6WKScUo1YGlK5vRptrNtdPyjo0cTlhiW/9YV8eE
         2nt5C0TvhjIOTnPUFIoOaurx2CHDB4/a8xW6ybO+Un2zNAZCUwmMwUXb5k2/nWYIGRyy
         fcesl3gJniE1rl17HjUWf4c95+7ss6ZQVRaljFOFjHK+6FTq4hjhMICN4AIUXzC9H3ai
         YwObYDDNHledmUFrXDCIUdFZcdr4eTiXZ51JiVyTUXmdjPZ3x3dB1bd7p/7LFQzF4ciK
         /nog==
X-Gm-Message-State: ANhLgQ0tZ7XVHpfsI/GodeJYpWKtBc37CoMpGkvMR0fc5ugOqCDcHsH3
        BRCbxu3gqp3w9ptI7BNGeiQ=
X-Google-Smtp-Source: ADFU+vuAo6idE+tzVND+3tC0cdmHVEXhs0EmX29w6eJrYQEeX8vTlANGquGVeJ/54SUag7XPGmwl7w==
X-Received: by 2002:a17:902:7008:: with SMTP id y8mr18599189plk.279.1584906980582;
        Sun, 22 Mar 2020 12:56:20 -0700 (PDT)
Received: from deeUbuntu ([103.240.207.191])
        by smtp.gmail.com with ESMTPSA id i2sm11197333pfr.151.2020.03.22.12.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Mar 2020 12:56:20 -0700 (PDT)
Date:   Mon, 23 Mar 2020 01:26:14 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, kieran.bingham@ideasonboard.com
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v3 3/4] staging: iio: adc: ad7192: get_filter_freq code
 optimization
Message-ID: <dad3cdb5de76234cc460300c31aea6af671f81ad.1584904896.git.mh12gx2825@gmail.com>
References: <cover.1584904896.git.mh12gx2825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1584904896.git.mh12gx2825@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Current implementation of the function ad7192_get_available_filter_freq
repeats calculation of output data rate a few times. We can simplify
these steps by refactoring out the calculation of fADC. This would also
addresses the checkpatch warning of line exceeding 80 character.

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---

Changes since v2:
	1. Improved function implementation. No need to use a ew
	   variable. Changes suggested by Stefano.

Changes since v1:
	1. Corrected variable names to follow datasheet terminology.


 drivers/iio/adc/ad7192.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index d9a220d4217f..5dafcf8754dd 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -482,18 +482,13 @@ static void ad7192_get_available_filter_freq(struct ad7192_state *st,
 {
 	unsigned int fadc;
 
-	/* Formulas for filter at page 25 of the datasheet */
-	fadc = DIV_ROUND_CLOSEST(st->fclk,
-				 AD7192_SINC4_FILTER * AD7192_MODE_RATE(st->mode));
-	freq[0] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
+	fadc = DIV_ROUND_CLOSEST(st->fclk, AD7192_MODE_RATE(st->mode) * 1024);
 
-	fadc = DIV_ROUND_CLOSEST(st->fclk,
-				 AD7192_SINC3_FILTER * AD7192_MODE_RATE(st->mode));
-	freq[1] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
-
-	fadc = DIV_ROUND_CLOSEST(st->fclk, AD7192_MODE_RATE(st->mode));
-	freq[2] = DIV_ROUND_CLOSEST(fadc * 230, 1024);
-	freq[3] = DIV_ROUND_CLOSEST(fadc * 272, 1024);
+	/* Formulas for filter at page 25 of the datasheet */
+	freq[0] = DIV_ROUND_CLOSEST(fadc * 240, AD7192_SINC4_FILTER);
+	freq[1] = DIV_ROUND_CLOSEST(fadc * 240, AD7192_SINC3_FILTER);
+	freq[2] = fadc * 230;
+	freq[3] = fadc * 272;
 }
 
 static ssize_t ad7192_show_filter_avail(struct device *dev,
-- 
2.17.1

