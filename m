Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA3FB18FBD9
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 18:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgCWRuP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 13:50:15 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37000 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgCWRuP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Mar 2020 13:50:15 -0400
Received: by mail-pj1-f68.google.com with SMTP id o12so164769pjs.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2020 10:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GvzX87ZAuDOtSf9ktETqmuX5+J+Lr+vZommjhI4YPnA=;
        b=uRmBCOIlK4vFDtlWZD0dXx5uBtaO4UoSj+N0FGlGCu7BVmLTtVQHjr2EBtuJYk0M3L
         7C8bCNhHFDSLLoSGy20igYAL1YOJBqyX+WTwUOFL2Iqe6VUs54Nk2Ys5GjG7UjRbdhkb
         wtnlxtL8VpMehg7oBKa9VX2pgPvqEROQVaCEI6k1lpTgnmKOkct4AaZJoZS/3qzbtSg3
         Vwm8Ne3gS0DmtGMzk5KXoWcICMsw4OozgwplOvnpN3GI6dkAtg+Xd4RBOy8MIzvwSo7a
         C7xQZs/rz+Qe7u8jBndLFGHti5sEZCODH8E44nmG+EJARk79vYkjUX+0QzbUG79ekVLe
         I/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GvzX87ZAuDOtSf9ktETqmuX5+J+Lr+vZommjhI4YPnA=;
        b=NnLvSyC72gdf0E6r6NwkyIvAtgO5uTxzcGmBvkHOg7G8/vvdXY8bvMyDlrSUgUhm+R
         3GSP9Cgml17ZVWItdpubHR9K8T2DAEdDl7wWuzL5fcK715ZqItw8Xh4vs1DwL+uJhfjU
         Hfu2/xKz0nH0P8zX+BpEuUl9DJh6lqM6zWANWim/sZpk8qVuCgRkSMAdoM7s2MLFqYEH
         a0ruXarFh8ZMhPI1HkQPTl8io4wCvqVL7s5J9LGwV39wWNKXgmN8p1zisbVg3XNnQS/n
         vs+jKu0fba5CBTk7IhzS8ZvcJ9B88ZZ9Mz5SYoTs3wbZBkX5O30Pou3MSxh0AnlQ4EDJ
         GQEw==
X-Gm-Message-State: ANhLgQ2n8dNnbaFHF3TsMp0pccXjDH+wG+uDq7Jex0YRkRl6/cWR132s
        u9dzzAKwJWfwXnvDn6Rw54A=
X-Google-Smtp-Source: ADFU+vvxQQRe5tqk8DMu4SHHw8G8YnalqzluHa2wv7K3vrxSaIA6LkLyEcQIWV1a+21Jm6V1jzBMKg==
X-Received: by 2002:a17:90a:fa08:: with SMTP id cm8mr548614pjb.144.1584985813421;
        Mon, 23 Mar 2020 10:50:13 -0700 (PDT)
Received: from deeUbuntu ([103.240.207.191])
        by smtp.gmail.com with ESMTPSA id i3sm7919350pgj.13.2020.03.23.10.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 10:50:12 -0700 (PDT)
Date:   Mon, 23 Mar 2020 23:20:05 +0530
From:   DEEPAK VARMA <mh12gx2825@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        kieran.bingham@ideasonboard.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] staging: iio: adc: ad7192: Correct macro names
 from SYNC to SINC
Message-ID: <20200323175003.GB22110@deeUbuntu>
References: <cover.1584904896.git.mh12gx2825@gmail.com>
 <a5aea6836da9aa2f950449225892ee18f10e217c.1584904896.git.mh12gx2825@gmail.com>
 <CAHp75VetdASuw60zcp+O=RWK+pmksuPtkGL3smrqYbdfgC98xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VetdASuw60zcp+O=RWK+pmksuPtkGL3smrqYbdfgC98xw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 23, 2020 at 01:40:08AM +0200, Andy Shevchenko wrote:
> On Sun, Mar 22, 2020 at 9:57 PM Deepak R Varma <mh12gx2825@gmail.com> wrote:
> >
> > Three macros include SYNC in their names which is a typo. Update those
> > names to SINC.
> 
> It is good to elaborate the source of the above statement (e.g.
> datasheet pages).
> 
> > Fixes: 77f6a23092c0 ("staging: iio: adc: ad7192: Add low_pass_3db_filter_frequency")
> 
> >
> 
> This blank line should go before Fixes tag. The rule is that tags are
> forming a block at the end of commit message.
> 
> > Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> > Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> The code below looks good to me.

Thank you for your feedback. I agree with your comments. I will update
and send this back as next version.

Deepak.

> 
> 
> >
> > ---
> >
> > Changes since v2:
> >         - None. Version increment to follow patch series versioning.
> >
> > Changes since v1:
> >         - None. Patch added in v2 version as suggested by Stefano.
> >
> >
> >  drivers/iio/adc/ad7192.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> > index 02981f3d1794..d9a220d4217f 100644
> > --- a/drivers/iio/adc/ad7192.c
> > +++ b/drivers/iio/adc/ad7192.c
> > @@ -144,9 +144,9 @@
> >  #define AD7192_EXT_FREQ_MHZ_MAX        5120000
> >  #define AD7192_INT_FREQ_MHZ    4915200
> >
> > -#define AD7192_NO_SYNC_FILTER  1
> > -#define AD7192_SYNC3_FILTER    3
> > -#define AD7192_SYNC4_FILTER    4
> > +#define AD7192_NO_SINC_FILTER  1
> > +#define AD7192_SINC3_FILTER    3
> > +#define AD7192_SINC4_FILTER    4
> >
> >  /* NOTE:
> >   * The AD7190/2/5 features a dual use data out ready DOUT/RDY output.
> > @@ -367,7 +367,7 @@ static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
> >                 st->conf |= AD7192_CONF_REFSEL;
> >
> >         st->conf &= ~AD7192_CONF_CHOP;
> > -       st->f_order = AD7192_NO_SYNC_FILTER;
> > +       st->f_order = AD7192_NO_SINC_FILTER;
> >
> >         buf_en = of_property_read_bool(np, "adi,buffer-enable");
> >         if (buf_en)
> > @@ -484,11 +484,11 @@ static void ad7192_get_available_filter_freq(struct ad7192_state *st,
> >
> >         /* Formulas for filter at page 25 of the datasheet */
> >         fadc = DIV_ROUND_CLOSEST(st->fclk,
> > -                                AD7192_SYNC4_FILTER * AD7192_MODE_RATE(st->mode));
> > +                                AD7192_SINC4_FILTER * AD7192_MODE_RATE(st->mode));
> >         freq[0] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
> >
> >         fadc = DIV_ROUND_CLOSEST(st->fclk,
> > -                                AD7192_SYNC3_FILTER * AD7192_MODE_RATE(st->mode));
> > +                                AD7192_SINC3_FILTER * AD7192_MODE_RATE(st->mode));
> >         freq[1] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
> >
> >         fadc = DIV_ROUND_CLOSEST(st->fclk, AD7192_MODE_RATE(st->mode));
> > @@ -576,25 +576,25 @@ static int ad7192_set_3db_filter_freq(struct ad7192_state *st,
> >
> >         switch (idx) {
> >         case 0:
> > -               st->f_order = AD7192_SYNC4_FILTER;
> > +               st->f_order = AD7192_SINC4_FILTER;
> >                 st->mode &= ~AD7192_MODE_SINC3;
> >
> >                 st->conf |= AD7192_CONF_CHOP;
> >                 break;
> >         case 1:
> > -               st->f_order = AD7192_SYNC3_FILTER;
> > +               st->f_order = AD7192_SINC3_FILTER;
> >                 st->mode |= AD7192_MODE_SINC3;
> >
> >                 st->conf |= AD7192_CONF_CHOP;
> >                 break;
> >         case 2:
> > -               st->f_order = AD7192_NO_SYNC_FILTER;
> > +               st->f_order = AD7192_NO_SINC_FILTER;
> >                 st->mode &= ~AD7192_MODE_SINC3;
> >
> >                 st->conf &= ~AD7192_CONF_CHOP;
> >                 break;
> >         case 3:
> > -               st->f_order = AD7192_NO_SYNC_FILTER;
> > +               st->f_order = AD7192_NO_SINC_FILTER;
> >                 st->mode |= AD7192_MODE_SINC3;
> >
> >                 st->conf &= ~AD7192_CONF_CHOP;
> > --
> > 2.17.1
> >
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
