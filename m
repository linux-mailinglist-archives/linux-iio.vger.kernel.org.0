Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B991B885B
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 19:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgDYR7G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 13:59:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgDYR7G (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 13:59:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71F94206B9;
        Sat, 25 Apr 2020 17:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587837545;
        bh=8ojAkugMKNr0HOcKJukOabtkpBS19lmg0Bp7/OoK854=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ijK40JRcybkPPANgc/j+K/mvBiXqVdVpC4A0IVbFoGLIR35detu+lb6LLUqffIkQk
         qEb+VRZE8XI0kwbMVPe84pYWJkgzLRYGmM30lzkzGVkWExUBOLovRtHzwpPJOwb+hh
         26YWCjngmupCdjRS8nkwBFl3h5xpTr8kdOhhaOUo=
Date:   Sat, 25 Apr 2020 18:59:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/6] iio: chemical: scd30: add core driver
Message-ID: <20200425185901.1611eca5@archlinux>
In-Reply-To: <CAHp75Vdajf7Ci3ytxP7Qs9=fFaxvVBQoL5uh+HUDwxHS5r9MUg@mail.gmail.com>
References: <20200422141135.86419-1-tomasz.duszynski@octakon.com>
        <20200422141135.86419-2-tomasz.duszynski@octakon.com>
        <CAHp75VcbaGYj76qkDJnTnuG5SM215qVmFo7FLR6YzHA37PgF_g@mail.gmail.com>
        <20200424190413.GA2731@arch>
        <CAHp75Vdajf7Ci3ytxP7Qs9=fFaxvVBQoL5uh+HUDwxHS5r9MUg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 25 Apr 2020 14:43:35 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Apr 24, 2020 at 10:05 PM Tomasz Duszynski
> <tomasz.duszynski@octakon.com> wrote:
> > On Wed, Apr 22, 2020 at 10:49:44PM +0300, Andy Shevchenko wrote:  
> > > On Wed, Apr 22, 2020 at 5:22 PM Tomasz Duszynski
> > > <tomasz.duszynski@octakon.com> wrote:  
> 
> ...
> 
> > > > Add Sensirion SCD30 carbon dioxide core driver.  
> > >
> > > And DocLink tar of Datasheet: with a link?  
> >
> > I never do this. These files change their location way too often to be
> > worthwhile putting here. Nobody has that much time to fallow all this
> > and keep respective files up to date.
> >
> > But that doesn't mean I can't drop a link here.
> > https://developer.sensirion.com/fileadmin/user_upload/customers/sensirion/Dokumente/9.5_CO2/Sensirion_CO2_Sensors_SCD30_Interface_Description.pdf  
> 
> Yes, just make it a tag
> 
> DocLink: ....
> 
> ...
> 
> > > > +int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
> > > > +               int (*command)(struct scd30_state *state, enum scd30_cmd cmd,
> > > > +                              u16 arg, char *rsp, int size));  
> > >
> > > My gosh.
> > > Please, supply proper structure member in priv or alike.  
> >
> > Not sure it's worth the fuss. Wrapping all into structure means either
> > copying respective members or more dereferences later on.  
> 
> At least you may introduce a typedef, because above really hurts my eyes.
> 
> ...
> 
> > > > +enum {
> > > > +       CONC,
> > > > +       TEMP,
> > > > +       HR,
> > > > +};  
> > >
> > > Way too generic names for anonymous enum.  
> >
> > I'd argue that they are pretty well understood abbreviations in iio generally
> > and here specifically. But adding some prefix won't harm.  
> 
> Yes, prefix is what I was talking about.
> 
> ...
> 
> > > > +static int scd30_wait_meas_poll(struct scd30_state *state)
> > > > +{
> > > > +       int tries = 5;
> > > > +
> > > > +       while (tries--) {
> > > > +               int ret;
> > > > +               u16 val;
> > > > +
> > > > +               ret = scd30_command(state, CMD_MEAS_READY, 0, (char *)&val,
> > > > +                                   sizeof(val));
> > > > +               if (ret)
> > > > +                       return -EIO;
> > > > +
> > > > +               /* new measurement available */
> > > > +               if (val)
> > > > +                       break;
> > > > +
> > > > +               msleep_interruptible(state->meas_interval * 250);
> > > > +       }
> > > > +
> > > > +       if (tries == -1)
> > > > +               return -ETIMEDOUT;  
> > >
> > > unsigned int tries = ...;
> > >
> > > do {
> > >  ...
> > > } while (--tries);
> > > if (!tries)
> > >   return ...;
> > >
> > > looks better and I guess less code in asm.
> > >  
> >
> > You mean that one extra branch in case of while?  
> 
> There are few things:
> a) do {} while notation immediately tells that at least one cycle of
> body will be done (unconditionally);
> b) it makes a loop variable unsigned and no need to check for specific
> negative numbers;
> c) it quite likely will generate slightly better assembly code.
> 
> >  But it comes to code
> > itself it looks more compact. And I am okay with that.
> >  
> > > > +       return 0;
> > > > +}  
> 
> ...
> 
> > > > +       if (kstrtou16(buf, 0, &val))
> > > > +               return -EINVAL;  
> > >
> > > Shadowed error code. Don't do like this.  
> >
> > Integer parsing either returns EINVAL or ERANGE. Passing the latter to
> > the user is not worth the trouble, especially because majority of writable attrs
> > have a fellow _available attr.  
> 
> It's simple a bad coding practice. Please, change.
> 
> > > > +       if (kstrtou16(buf, 0, &val))
> > > > +               return -EINVAL;  
> > >
> > > Ditto.
> > >  
> > > > +       if (kstrtou16(buf, 0, &val))
> > > > +               return -EINVAL;  
> > >
> > > Ditto.  
> 
> ...
> 
> > > > +       if (kstrtou16(buf, 0, &val))
> > > > +               return -EINVAL;  
> > >
> > > No shadowed error code, please. Check entire code.  
> 
> Same here.
> 
> ...
> 
> > > > +static IIO_DEVICE_ATTR_RW(pressure_comp, 0);
> > > > +static IIO_DEVICE_ATTR_RO(pressure_comp_available, 0);
> > > > +static IIO_DEVICE_ATTR_RW(meas_interval, 0);
> > > > +static IIO_DEVICE_ATTR_RO(meas_interval_available, 0);
> > > > +static IIO_DEVICE_ATTR_RW(asc, 0);
> > > > +static IIO_DEVICE_ATTR_RW(frc, 0);
> > > > +static IIO_DEVICE_ATTR_RO(frc_available, 0);
> > > > +static IIO_DEVICE_ATTR_RW(temp_offset, 0);
> > > > +static IIO_CONST_ATTR(temp_offset_available, "[0 1 65535]");
> > > > +static IIO_DEVICE_ATTR_WO(reset, 0);  
> > >
> > > Do you need all of them? Doesn't  IIO core provides a tons of helpers for these?
> > > Btw, where is ABI documentation? It's a show stopper.  
> >
> > They are sensor specific and none falls into a category of iio generic
> > attrs. Maybe, except the measurement interval which could be represented as
> > a SAMP_FREQ.  
> 
> IIO ABI becomes already a big pile of nodes and I hope we will become
> stricter about adding new ones.
Yes.  Starting point is they need to be documented or they can't be
properly reviewed.

Documentation/ABI/testing/sysfs-bus-iio-*

> 
> > But given that measurement interval spans from 2s to 1800s
> > it becomes a little bit awkward to have it in Hz.  
> 
> > As for ABI that's in
> > a separate patch.  
> 
> It's not good from bisectability point of view. If by some reason this
> patch or documentation patch gets reverted, the other one will be
> dangling.
> Please, unify them.
> 

