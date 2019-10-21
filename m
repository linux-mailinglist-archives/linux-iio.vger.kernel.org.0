Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF99DF125
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 17:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfJUPUW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 11:20:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbfJUPUW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Oct 2019 11:20:22 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71EEB2084B;
        Mon, 21 Oct 2019 15:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571671221;
        bh=nbD/xN9E0NOEQev6bZPtgeSvlXjsM38xYXZf9XPf6K0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FDIwjTr6OuzGTDBVQIbiCn2fzZIXQx/WdcGXMNT/q13a2X9hV4fyKL9thpvYiHXQX
         BlcsKH485Fdzi03ZiY5Zxiqi79YFlMUaEPs+bvJGxKuzTJgHcShrWzhwSgjyBqYfae
         aKhxv7O2jj/7xTsSbUZ12lNOozaJTH/MJ5Z4sggs=
Date:   Mon, 21 Oct 2019 16:20:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 2/2] iio: (bma400) add driver for the BMA400
Message-ID: <20191021162016.531e6a2e@archlinux>
In-Reply-To: <20191019024351.GB8593@nessie>
References: <20191018031848.18538-1-dan@dlrobertson.com>
        <20191018031848.18538-3-dan@dlrobertson.com>
        <CAHp75VfMW0fvmO9jGTnQumJ9Sm-SgNL0ohjSR4qRQY365aeMBw@mail.gmail.com>
        <20191019024351.GB8593@nessie>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 19 Oct 2019 02:43:51 +0000
Dan Robertson <dan@dlrobertson.com> wrote:

> On Fri, Oct 18, 2019 at 10:23:38AM +0300, Andy Shevchenko wrote:
> > On Fri, Oct 18, 2019 at 6:44 AM Dan Robertson <dan@dlrobertson.com> wrote:  
> > > + * bma400.h - Register constants and other forward declarations
> > > + *            needed by the bma400 sources.  
> >
> > Including file name in the file is not the best practice. Imagine if
> > by some reason we will need to rename it (to support more sensors, for
> > example, and reflect it by replacing 00 -> 0x).
> > So, please, remove here and everywhere else.  
> 
> That makes sense.
> 
> > > +#define BMA400_TWO_BITS_MASK    0x03
> > > +#define BMA400_LP_OSR_MASK      0x60
> > > +#define BMA400_NP_OSR_MASK      0x30
> > > +#define BMA400_ACC_ODR_MASK     0x0f
> > > +#define BMA400_ACC_SCALE_MASK   0xc0  
> > 
> > GENMASK()
> > (Don't forget to include bits.h for it)  
> 
> Thanks.
> 
> > > +static const int bma400_scale_table[] = {
> > > +       0, 38344,
> > > +       0, 76590,
> > > +       0, 153277,  
> >   
> > > +       0, 306457  
> > 
> > Better to leave comma here. It doesn't matter for this device, but
> > make of use the better practices.  
> > > +};  
> > 
> > Also, I'm wondering why values are not exactly multiply by 2. Is in DS
> > of the chip any explanation for this?  
> 
> It would be a multiply by 2. I tried to follow the bma180 driver here, but I'm
> starting to think that may be the wrong approach.

I'll guess that, like so many accelerometers this one has documentation
in terms of 'g'.  Which is bonkers at g isn't a constant... g_0 is but no
datasheet ever seems to note that distinction.  Oh well. So these
are rounded to nearest value in m/s^2...  To be honest, the sensor
noise levels are usual such that this level of precision really
doesn't matter. 

> 
> > > +static const int bma400_osr_table[] = { 0, 1, 3 };  
> >   
> > > +/* See the ACC_CONFIG1 section of the datasheet */
> > > +static const int bma400_sample_freqs[] = {
> > > +       12,  500000,
> > > +       25,  0,
> > > +       50,  0,
> > > +       100, 0,
> > > +       200, 0,
> > > +       400, 0,
> > > +       800, 0,
> > > +};  
> > 
> > This can be replaced by a formula(s).  
> 
> Yeah I think I can implement the get, set, and read functions for sample_freq
> with a formula, but the scale and sample frequency tables are needed by the
> implementation of read_avail. A implementation of read_avail with a range and
> a step would be ideal, but I couldn't find any documentation on implementing
> read_avail where the step value of the range is a multiple. Please correct
> me if I've missed something.

Indeed. We've only defined it as being fixed intervals.
I'm not keen to expand the options for the userspace interface any
further.  

You could compute the values at startup and store it in your state structure
I think (or compute them on demand, but you'd need to have the space somewhere
non volatile).

> 
> Note that this applies to the scale table as well.
> 
> > > +struct bma400_sample_freq {
> > > +       int hz;
> > > +       int uhz;
> > > +};  
> > 
> > I'm wondering why above table is not using this struct.  
> 
> Originally it did, but I changed this in the second version when I added support
> for iio_info read_avail to try to be a little closer to other implementations of
> iio_read avail.
> 
> > > +const struct regmap_config bma400_regmap_config = {
> > > +       .reg_bits = 8,
> > > +       .val_bits = 8,
> > > +       .max_register = BMA400_CMD_REG,
> > > +       .cache_type = REGCACHE_RBTREE,
> > > +       .writeable_reg = bma400_is_writable_reg,
> > > +       .volatile_reg = bma400_is_volatile_reg,
> > > +};  
> >   
> > > +EXPORT_SYMBOL(bma400_regmap_config);  
> > 
> > Why? And why it's not _GPL?  
> 
> This is used by the bma400_i2c module.

Which is licensed as GPL v2, so I don't follow why this isn't
_GPL either.

> 
> > > +       int ret;
> > > +       int host_temp;
> > > +       unsigned int raw_temp;  
> > 
> > Better reversed xmas tree order.  
> 
> Sounds good.
> 
> >   
> > > +               if (idx + 1 >= ARRAY_SIZE(bma400_sample_freqs)) {  
> > 
> > Why do you need this churn with +1 and = ?  
> 
> Since we've "flattened" the array of sample frequency we need to ensure that the
> Hz (bma400_sample_freqs[idx]) and uHz (bma400_sample_freqs[idx + 1]) are both
> valid. This will be negated in the next version as I'll switch to a formula.
> Instead I'll ensure the returned ODR value is not above 0x0b.
> 
> > > +                       dev_err(data->dev, "sample freq index is too high");
> > > +                       ret = -EINVAL;
> > > +                       goto error;
> > > +               }  
> > 
> >   
> > > +       for (i = 0; i + 1 < ARRAY_SIZE(bma400_sample_freqs); i += 2) {  
> > 
> > Using defined struct will guarantee you to have always 2x members in
> > the array. So, drop this arithmetic churn.  
> 
> I should be able to figure out how to use a formula here, but I see where you're
> coming from and I agree.
> 
> > > +       if (ret < 0) {
> > > +               dev_err(data->dev, "Failed to read chip id register: %x!", ret);  
> > 
> > %x for returned error code is too hackerish.  
> 
> Makes sense. I'll change this in the update.
> 
> > > +               return ret;  
> >   
> > > +       } else if (val != BMA400_ID_REG_VAL) {  
> > 
> > Redundant 'else'  
> 
> > > +               dev_err(data->dev, "CHIP ID MISMATCH: %x!", ret);  
> > 
> > Hacker detected!  
> 
> :)
> 
> > > +               return -ENODEV;
> > > +       }  
> >   
> > > +               /*
> > > +                * TODO: The datasheet waits 1500us here in the example, but
> > > +                * lists 2/ODR as the wakeup time.
> > > +                */
> > > +               usleep_range(1500, 20000);  
> > 
> > These range values are too sparse. Usually the second one is less than
> > first one * 2.
> > Fix it now.  
> 
> Good to know. I'll fix this in the update.
> 
> > > +EXPORT_SYMBOL(bma400_probe);  
> > 
> > Why is not GPL?  
> 
> Ah, saw in the docs "GPL" means GPL-2.0.

So guess you are fine with making these all GPL exports then :)

> 
> >   
> > > +EXPORT_SYMBOL(bma400_remove);  
> > 
> > Ditto.  
> 
> This symbol is used in bma400_i2c.
> 
> > 
> > P.S. I probably missed some places with the same mistake as commented
> > above. Please address all places in the code where my comments are
> > applicable.  
> 
> Noted. Thanks for the feedback!
> 
> Cheers,
> 
>  - Dan
Thanks,

Jonathan.
