Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8040938D6DF
	for <lists+linux-iio@lfdr.de>; Sat, 22 May 2021 20:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhEVSPc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 May 2021 14:15:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231156AbhEVSPc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 May 2021 14:15:32 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FCB161139;
        Sat, 22 May 2021 18:14:04 +0000 (UTC)
Date:   Sat, 22 May 2021 19:15:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Denis Ciocca <denis.ciocca@st.com>,
        Daniel Drake <drake@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 1/5 v3] iio: st_sensors: Create extended attr macro
Message-ID: <20210522191527.228f795a@jic23-huawei>
In-Reply-To: <323cc45a-6db2-8732-d3b0-784b1250d7f7@redhat.com>
References: <20210518230722.522446-1-linus.walleij@linaro.org>
        <323cc45a-6db2-8732-d3b0-784b1250d7f7@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 19 May 2021 15:17:36 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 5/19/21 1:07 AM, Linus Walleij wrote:
> > Extend ST_SENSORS_LSM_CHANNELS() to a version that will accept extended
> > attributes named ST_SENSORS_LSM_CHANNELS_EXT() and wrap the former as a
> > specialized version of the former.
> > 
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Denis Ciocca <denis.ciocca@st.com>
> > Cc: Daniel Drake <drake@endlessm.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>  
> 
> Thanks.
> 
> The entire series looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

@Linus, for IIO stuff, please put a cover letter on series as it makes it
easier for people to reply with things like this and still let me use b4
without manual tweaking.

Anyhow, manually tweaked series applied to the togreg branch of iio.git and
pushed out as testing for the autobuilders to poke at it and see what they
find.

Thanks,

Jonathan


> 
> for the series.
> 
> Regards,
> 
> Hans
> 
> 
> > ---
> > ChangeLog v2->v3:
> > - Rebase and resend.
> > ChangeLog v1->v2:
> > - New helper patch from Stephan.
> > ---
> >  include/linux/iio/common/st_sensors.h | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> > index 0b9aeb479f48..8e0d76b42db9 100644
> > --- a/include/linux/iio/common/st_sensors.h
> > +++ b/include/linux/iio/common/st_sensors.h
> > @@ -48,8 +48,8 @@
> >  #define ST_SENSORS_MAX_NAME			17
> >  #define ST_SENSORS_MAX_4WAI			8
> >  
> > -#define ST_SENSORS_LSM_CHANNELS(device_type, mask, index, mod, \
> > -					ch2, s, endian, rbits, sbits, addr) \
> > +#define ST_SENSORS_LSM_CHANNELS_EXT(device_type, mask, index, mod, \
> > +				    ch2, s, endian, rbits, sbits, addr, ext) \
> >  { \
> >  	.type = device_type, \
> >  	.modified = mod, \
> > @@ -65,8 +65,14 @@
> >  		.storagebits = sbits, \
> >  		.endianness = endian, \
> >  	}, \
> > +	.ext_info = ext, \
> >  }
> >  
> > +#define ST_SENSORS_LSM_CHANNELS(device_type, mask, index, mod, \
> > +				ch2, s, endian, rbits, sbits, addr)	\
> > +	ST_SENSORS_LSM_CHANNELS_EXT(device_type, mask, index, mod,	\
> > +				    ch2, s, endian, rbits, sbits, addr, NULL)
> > +
> >  #define ST_SENSORS_DEV_ATTR_SAMP_FREQ_AVAIL() \
> >  		IIO_DEV_ATTR_SAMP_FREQ_AVAIL( \
> >  			st_sensors_sysfs_sampling_frequency_avail)
> >   
> 

