Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114FE2568C4
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 17:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgH2Pmp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 11:42:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728196AbgH2Pla (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 11:41:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B615206B5;
        Sat, 29 Aug 2020 15:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598715689;
        bh=k3qOKfMDelF5OX8qgtgOSW2vvEfhfxIHlvt4PAmmJRI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m+sW1f+u7G+keDDQIsLFj7/mwDpCWOQMmESkmWU9Lh1rk3LYMJ1NaVQgRWsKlhjFF
         lhI6ZrVD33Irj57BhLI5xj1NH2WsyW43PFhaN7VHeR+Of3nrOvjdmlU4n/V0YJcca4
         A2XMh+TwJ2QidA6Segilp9/dzw50+qWO6NGTo8y0=
Date:   Sat, 29 Aug 2020 16:41:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Christian Eggers <ceggers@arri.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: light: as73211: Fix AS73211_CREG1_GAIN_1
Message-ID: <20200829164125.540f5667@archlinux>
In-Reply-To: <CAHp75VfBMXPyH80d0hrUqohC4wvgBNSSNp4N86JcfiWSfWHs+w@mail.gmail.com>
References: <20200826095247.16368-1-ceggers@arri.de>
        <CAHp75VfBMXPyH80d0hrUqohC4wvgBNSSNp4N86JcfiWSfWHs+w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 26 Aug 2020 19:11:37 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Aug 26, 2020 at 12:55 PM Christian Eggers <ceggers@arri.de> wrote:
> >
> > Wrong value was introduced during review process.  
> 
> Ooops, long reviews have their outcomes...
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks.  Add I hadn't pushed this out yet in a non rebasing branch
I have folded it into the original patch.

thanks,

Jonathan

> 
> > Signed-off-by: Christian Eggers <ceggers@arri.de>
> > ---
> > Patch against jic23/iio.git, branch testing
> >
> >  drivers/iio/light/as73211.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
> > index 3383aaacbf52..e76747b99b92 100644
> > --- a/drivers/iio/light/as73211.c
> > +++ b/drivers/iio/light/as73211.c
> > @@ -56,7 +56,7 @@
> >  #define AS73211_AGEN_MUT(x)       FIELD_PREP(AS73211_AGEN_MUT_MASK, (x))
> >
> >  #define AS73211_CREG1_GAIN_MASK   GENMASK(7, 4)
> > -#define AS73211_CREG1_GAIN_1      13
> > +#define AS73211_CREG1_GAIN_1      11
> >  #define AS73211_CREG1_TIME_MASK   GENMASK(3, 0)
> >
> >  #define AS73211_CREG3_CCLK_MASK   GENMASK(1, 0)
> > @@ -217,7 +217,7 @@ static void as73211_integration_time_calc_avail(struct as73211_data *data)
> >
> >  static unsigned int as73211_gain(struct as73211_data *data)
> >  {
> > -       /* gain can be calculated from CREG1 as 2^(13 - CREG1_GAIN) */
> > +       /* gain can be calculated from CREG1 as 2^(11 - CREG1_GAIN) */
> >         return BIT(AS73211_CREG1_GAIN_1 - FIELD_GET(AS73211_CREG1_GAIN_MASK, data->creg1));
> >  }
> >
> > @@ -473,7 +473,7 @@ static int _as73211_write_raw(struct iio_dev *indio_dev,
> >                 if (val < 0 || !is_power_of_2(val) || val2)
> >                         return -EINVAL;
> >
> > -               /* gain can be calculated from CREG1 as 2^(13 - CREG1_GAIN) */
> > +               /* gain can be calculated from CREG1 as 2^(11 - CREG1_GAIN) */
> >                 reg_bits = AS73211_CREG1_GAIN_1 - ilog2(val);
> >                 if (!FIELD_FIT(AS73211_CREG1_GAIN_MASK, reg_bits))
> >                         return -EINVAL;
> > --
> > Christian Eggers
> > Embedded software developer
> >
> > Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
> > Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRA 57918
> > Persoenlich haftender Gesellschafter: Arnold & Richter Cine Technik GmbH
> > Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRB 54477
> > Geschaeftsfuehrer: Dr. Michael Neuhaeuser; Stephan Schenk; Walter Trauninger; Markus Zeiler
> >  
> 
> 

