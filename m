Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA22C25EDFD
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 15:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgIFNmv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 09:42:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgIFNmt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 09:42:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EF9620760;
        Sun,  6 Sep 2020 13:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599399768;
        bh=Iyf7pp+ihe6OsQtlb6IPzaKkpm409CiX6YhvVqtMDS8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r2gx16pULCwLgLw2iaXe6sYS1l/0+JbG3/G1IEEyjQM9A+s1vQAMiBRbgB2tiphiM
         F3pMcq0TiN4gowTtpZkI1FwC7D9npIh/w+xiQEjfejaB029/rpvNFWrEqB42Yk3nu/
         y7w5W/E0pfVXjekbr/ssUpULP6cgx5fSIVM0oIDQ=
Date:   Sun, 6 Sep 2020 14:42:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Crt Mori <cmo@melexis.com>, linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] iio: temperature: mlx90632: Interface to change
 object ambient temperature
Message-ID: <20200906144244.1049989c@archlinux>
In-Reply-To: <CAHp75VeiR1qQkBhA0XQ2_6aVAFHfQTWGcr+NeRhFNoCEiMK9kg@mail.gmail.com>
References: <20200904120726.199640-1-cmo@melexis.com>
        <CAHp75VeiR1qQkBhA0XQ2_6aVAFHfQTWGcr+NeRhFNoCEiMK9kg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 4 Sep 2020 15:19:27 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Sep 4, 2020 at 3:08 PM Crt Mori <cmo@melexis.com> wrote:
> >
> > Since object temperature might be different than the sensor temperature
> > the infrared sensors should provide an interface to inject ambient
> > temperature. This was in past done via write to ambient temperature
> > interface (in_temp_ambient_raw), but I think most people did not know
> > about it. This solution introduces a new iio type of the CALIBAMBIENT
> > which is hopefully more descriptive and more explicit about the purpose
> > and capabilities of the sensors.  
> 
> I'm fine, but one really picky comment below. I don't think a new
> version is needed till Jonathan will ask for it.
> 
> > Signed-off-by: Crt Mori <cmo@melexis.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Starting point for a new ABI is docs, so please add to
Documentation/ABI/testing/sysfs-bus-iio*

This is a somewhat odd corner case of saying don't use the local
measurement but one from 'over there' that we are supplying.

I'd love to come up with a more generic term for that, but if
we did I guess we'd back in the position that we are now, with a
non-obvious interface for this particular usecase.

So unless anyone else comments, please do a v3 with docs and
I'll pick it up.

Thanks,

Jonathan

> > ---
> >  drivers/iio/industrialio-core.c    | 1 +
> >  drivers/iio/temperature/mlx90632.c | 8 +++++++-
> >  include/linux/iio/types.h          | 1 +
> >  3 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 606d5e61c575..941011502f4d 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -165,6 +165,7 @@ static const char * const iio_chan_info_postfix[] = {
> >         [IIO_CHAN_INFO_CALIBEMISSIVITY] = "calibemissivity",
> >         [IIO_CHAN_INFO_OVERSAMPLING_RATIO] = "oversampling_ratio",
> >         [IIO_CHAN_INFO_THERMOCOUPLE_TYPE] = "thermocouple_type",
> > +       [IIO_CHAN_INFO_CALIBAMBIENT] = "calibambient",
> >  };
> >
> >  #if defined(CONFIG_DEBUG_FS)
> > diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> > index 94bca2b2866a..8e60d401b703 100644
> > --- a/drivers/iio/temperature/mlx90632.c
> > +++ b/drivers/iio/temperature/mlx90632.c
> > @@ -761,6 +761,9 @@ static int mlx90632_read_raw(struct iio_dev *indio_dev,
> >                         *val2 = data->emissivity * 1000;
> >                 }
> >                 return IIO_VAL_INT_PLUS_MICRO;  
> 
> Blank line is missed here.
> 
> > +       case IIO_CHAN_INFO_CALIBAMBIENT:
> > +               *val = data->object_ambient_temperature;
> > +               return IIO_VAL_INT;
> >
> >         default:
> >                 return -EINVAL;
> > @@ -781,6 +784,9 @@ static int mlx90632_write_raw(struct iio_dev *indio_dev,
> >                         return -EINVAL;
> >                 data->emissivity = val * 1000 + val2 / 1000;
> >                 return 0;
> > +       case IIO_CHAN_INFO_CALIBAMBIENT:
> > +               data->object_ambient_temperature = val;
> > +               return 0;
> >         default:
> >                 return -EINVAL;
> >         }
> > @@ -798,7 +804,7 @@ static const struct iio_chan_spec mlx90632_channels[] = {
> >                 .modified = 1,
> >                 .channel2 = IIO_MOD_TEMP_OBJECT,
> >                 .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> > -                       BIT(IIO_CHAN_INFO_CALIBEMISSIVITY),
> > +                       BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) | BIT(IIO_CHAN_INFO_CALIBAMBIENT),
> >         },
> >  };
> >
> > diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> > index e6fd3645963c..1e3ed6f55bca 100644
> > --- a/include/linux/iio/types.h
> > +++ b/include/linux/iio/types.h
> > @@ -59,6 +59,7 @@ enum iio_chan_info_enum {
> >         IIO_CHAN_INFO_CALIBEMISSIVITY,
> >         IIO_CHAN_INFO_OVERSAMPLING_RATIO,
> >         IIO_CHAN_INFO_THERMOCOUPLE_TYPE,
> > +       IIO_CHAN_INFO_CALIBAMBIENT,
> >  };
> >
> >  #endif /* _IIO_TYPES_H_ */
> > --
> > 2.25.1
> >  
> 
> 

