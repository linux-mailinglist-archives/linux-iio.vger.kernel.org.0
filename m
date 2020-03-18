Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 173A51894E1
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 05:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgCRE1H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 00:27:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39007 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgCRE1G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 00:27:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id m1so2405931pll.6
        for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2020 21:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Oh2KAIRX8aKqtv+Ffl3IQBandoMpCHIL5wtrJabvgmM=;
        b=K2W3jt/9sV1zNczLnBqkHjRlfTbAxvCZ0ntC5O1osBzt1/yEyftVAlJMVTrflTk8rl
         J7oNswiTsMp5J0O2+YuM9h80c1CBnvv15U2rlv0O/urZzgZoPRC4h9pRp7X55UyoY5vm
         PcAgbfonKlJZdZH/oQThZD18nFA57Er0HiDTwUXocKk0y8WCtCOvfcY+F9KWPm1h0RNm
         jxbHVHgFpr36b6b9rZolhOa4O+qVGYhN+/x3bS1ioAoQjcQs9oGO+JuU6+uBUKIi+RAF
         EfI/mVnnbMAApXOqtJrDZS+3rKCze76/aJBQM8/UA7jDMGB82USz8uJQIoJd+RDH0bBn
         Vktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Oh2KAIRX8aKqtv+Ffl3IQBandoMpCHIL5wtrJabvgmM=;
        b=eB3pUZTIvPUNKF6TRMaXBN9rxbXaGtDmzhfI3ikYqDRisy1LvMdn91qJQ4OHYJpmTw
         wmfuWk3gwW60YYUqWv18icj9DYPDzOl6fNB/X7ZQaQLTAPk9s/6sAlXFqUWr+IES0RaA
         xtoB3FGYC0vnnscczeAv8ZLzalvtS93FEQ9oYg4+MCavV/SXrw+MqbvkuY07L7Q9Y9bF
         iSDVzLNI0eHX8cccckFlfLDMPuSK9FNCVc6uW/3PXP/TjIPUIHH9UybHLHGBFqlVavFf
         +egiPttVzydA89GSiKIrZ5mfuFPBdJ7WtWZ140d+YIW0kPCurX5ZTzNJ2dbRRz1WXc+t
         cQEw==
X-Gm-Message-State: ANhLgQ1VzmuHMr+Z7wQJ5h2Mgo7c4fvbaOGC8Hpse0OCb8UasDUy1EuE
        EvaKW6ZtDa+SeAh5pMG/DU5UU6NJ
X-Google-Smtp-Source: ADFU+vvPCB3WdVWhY0EEXtpKq72hgH+7U5Lu9vtvOxiWeGFKseaemlePEXKN3IM0W8Ay5L2GlLL+Qg==
X-Received: by 2002:a17:90a:a795:: with SMTP id f21mr2644541pjq.29.1584505625804;
        Tue, 17 Mar 2020 21:27:05 -0700 (PDT)
Received: from deeUbuntu ([103.241.226.97])
        by smtp.gmail.com with ESMTPSA id c8sm4844023pfj.108.2020.03.17.21.27.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Mar 2020 21:27:05 -0700 (PDT)
Date:   Wed, 18 Mar 2020 09:56:59 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, kieran.bingham@ideasonboard.com
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 1/2] staging: iio: adc: ad7192: Reformat lines crossing 80
 columns
Message-ID: <50419988d636c90511a07da256c91aa3b3e33bff.1584505215.git.mh12gx2825@gmail.com>
References: <cover.1584505215.git.mh12gx2825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1584505215.git.mh12gx2825@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Macro arguments are computed at the time of macro invocation. This makes
the lines cross 80 column width. Add variables to perform the
calculations before hand and use these new variable in the macro calls
instead.

Also re-indent enum members to address checkpatch warning / check messages.

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
 drivers/staging/iio/adc/ad7192.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index bf3e2a9cc07f..0265f6607d75 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -156,8 +156,8 @@
  */
 
 enum {
-   AD7192_SYSCALIB_ZERO_SCALE,
-   AD7192_SYSCALIB_FULL_SCALE,
+	AD7192_SYSCALIB_ZERO_SCALE,
+	AD7192_SYSCALIB_FULL_SCALE,
 };
 
 struct ad7192_state {
@@ -477,17 +477,18 @@ static ssize_t ad7192_set(struct device *dev,
 }
 
 static void ad7192_get_available_filter_freq(struct ad7192_state *st,
-						    int *freq)
+					     int *freq)
 {
 	unsigned int fadc;
+	unsigned int sync3_filter, sync4_filter;
 
 	/* Formulas for filter at page 25 of the datasheet */
-	fadc = DIV_ROUND_CLOSEST(st->fclk,
-				 AD7192_SYNC4_FILTER * AD7192_MODE_RATE(st->mode));
+	sync4_filter = AD7192_SYNC4_FILTER * AD7192_MODE_RATE(st->mode);
+	fadc = DIV_ROUND_CLOSEST(st->fclk, sync4_filter);
 	freq[0] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
 
-	fadc = DIV_ROUND_CLOSEST(st->fclk,
-				 AD7192_SYNC3_FILTER * AD7192_MODE_RATE(st->mode));
+	sync3_filter = AD7192_SYNC3_FILTER * AD7192_MODE_RATE(st->mode);
+	fadc = DIV_ROUND_CLOSEST(st->fclk, sync3_filter);
 	freq[1] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
 
 	fadc = DIV_ROUND_CLOSEST(st->fclk, AD7192_MODE_RATE(st->mode));
-- 
2.17.1

