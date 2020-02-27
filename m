Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF2A172848
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2020 20:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgB0TDW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Feb 2020 14:03:22 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34158 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbgB0TDW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Feb 2020 14:03:22 -0500
Received: by mail-pg1-f193.google.com with SMTP id t3so179626pgn.1
        for <linux-iio@vger.kernel.org>; Thu, 27 Feb 2020 11:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qy/YBtdMo7sPQ4js3OQpNzOgMoEq2kdNiffok1y5gUY=;
        b=FbMHWNFFEe6JlANg/qJ69uVrV379D+xQQ94ZYyxmGFYnf6OLXWr6gWHZ5cZIAdcwNk
         0ZqG3SxfcQ4M7lJbiImVhYgzyypkO1UirJhU9dqa2mW429Wu1TnGCM1Jjikd9Zm303ho
         fnFNP60vuoY8U09j5izsRrUUWaoJX87qSSU7QfiwR6GcKmeNoe3L74y1w1mPxYCqhBES
         AE5+zyPFjO6I4AwYqKwxjlVy64ADPa8TqKy60SkbaWZera/Cv3inW5TKzm2By3gXE79r
         l+Sw1LOkVW1pguLsbu12oK+SUGuaXi8zSgQ4MaHRr3GL1bXvtqTfqYtvdr//r/ddb58A
         WOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qy/YBtdMo7sPQ4js3OQpNzOgMoEq2kdNiffok1y5gUY=;
        b=JDwWFVrzgCGe4CkCCyRvSB6SRoyywWHPiEvFrCiAf4WoH7heLtrX7Yc4+ShlGWve71
         4Zj1uy/Rije9RfJJLDuh+2th8ujvxNfhVm7tyWspcUn3Nvsq9HHh+o0Mdzm5G8xX9C8z
         RfTZh3WFU0/mtsEfQadNSmg5TzsnQSenC2nAJBQYRwUO2UpnR0n0w4qGv/VUCEzjNtol
         mSjXxS23CxbhDAfOE1xsOPYE9r5wv2ZEpQd8U9VDwveRY0TqwvIB7r4ROyc9A+JCS8sp
         1YQqg9L/ZVXP5DeXOlZQBIJY9cjA1yN2g2UrSbJdOwEvgoO2hCCOlemBQjYJxsSOxKZu
         wyNg==
X-Gm-Message-State: APjAAAVayEZ/K4WLaykvcik+YndAa/DIyetZOa0Us0WWl91dtR2tvUvQ
        c9Q28DA4OODeVgCLKKfGFfg=
X-Google-Smtp-Source: APXvYqymmCPR5DB2VxmAUygXw2UEKVMDH0JILOkjYnGAeaWZ0+DPNGXYo+0Dd1YZrNQp9POlxQzj7g==
X-Received: by 2002:a65:4c82:: with SMTP id m2mr729072pgt.432.1582830200715;
        Thu, 27 Feb 2020 11:03:20 -0800 (PST)
Received: from SARKAR ([49.207.57.206])
        by smtp.gmail.com with ESMTPSA id p3sm8230475pfg.184.2020.02.27.11.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 11:03:20 -0800 (PST)
Message-ID: <5e581278.1c69fb81.611d5.515b@mx.google.com>
X-Google-Original-Message-ID: <20200227190315.GB8432@rohitsarkar5398@gmail.com>
Date:   Fri, 28 Feb 2020 00:33:15 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH] iio: adc: max1363: replace mlock with own lock
References: <5e56bdc3.1c69fb81.c3b20.9153@mx.google.com>
 <b52bf5db819308d1a7456dc37882fa35508a06bf.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b52bf5db819308d1a7456dc37882fa35508a06bf.camel@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Feb 27, 2020 at 07:00:31AM +0000, Ardelean, Alexandru wrote:
> On Thu, 2020-02-27 at 00:19 +0530, Rohit Sarkar wrote:
> > [External]
> > 
> > This change replaces indio_dev's mlock with the drivers own lock. In
> > each case the lock is needed to protect the driver's own state.
> > 
> > Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
> > ---
> >  drivers/iio/adc/max1363.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> > index 5c2cc61b666e..b9557f957f3c 100644
> > --- a/drivers/iio/adc/max1363.c
> > +++ b/drivers/iio/adc/max1363.c
> > @@ -169,6 +169,7 @@ struct max1363_state {
> >  	const struct max1363_mode	*current_mode;
> >  	u32				requestedmask;
> >  	struct regulator		*reg;
> > +	struct mutex lock;
> 
> The 'lock' field should be aligned with *reg & requestedmask.
Ah yes, dont know how I missed that.

> Also, it's a good idea to do a 'mutex_init(&st->lock)' in max1363_probe().
> Somewhere after 'st = iio_priv(indio_dev);'

Will do
> Rest looks good
> 

Thanks,
Rohit
