Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C38BECF19
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2019 15:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfKBORi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 Nov 2019 10:17:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbfKBORi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 Nov 2019 10:17:38 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 798BD21726;
        Sat,  2 Nov 2019 14:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572704256;
        bh=k14iEwM6RKdBcCO+Po3E+Sj5THJj0pyUJkmEsBnTEos=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ddwABK1o1SXh4zDgL50BBdXEtsduB+shgFyJb0J3JREF0/rhcOArgkKPwzU4xm1Tc
         NP15sjRFToL4JDBKNAbMBI6muPNaOEFlQEXS2ZJaXmZN+MMLkA4IHk2LXOFBenVMTe
         d1VWJbz1RGTVPJ9Ils658qCFJKzb6mNqokqdiFNo=
Date:   Sat, 2 Nov 2019 14:17:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        patrick.havelange@essensium.com,
        paresh.chaudhary@rockwellcollins.com, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de,
        Matthew Weber <matthew.weber@rockwellcollins.com>,
        Colin King <colin.king@canonical.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: max31856: add option for setting mains filter
 rejection frequency
Message-ID: <20191102141725.04437533@archlinux>
In-Reply-To: <CAN8YU5P4vUWOTSJWiL-cPDmQ3aJLe0Z-E3TK5Pmzg1kkxptY-w@mail.gmail.com>
References: <20190923121714.13672-1-andrea.merello@gmail.com>
        <20190923121714.13672-2-andrea.merello@gmail.com>
        <20191006085423.68bcecfd@archlinux>
        <CAN8YU5Ogcp8ERkxntTVQH3EoJF7h61VCONPXEaP-kvpx8EmS+g@mail.gmail.com>
        <20191017133210.00002799@huawei.com>
        <CAN8YU5Nxrv8q4LjCCrHH-qR6kj=PjNLBANgrTkYdX1b1OP+gkA@mail.gmail.com>
        <20191022103458.3a112511@archlinux>
        <CAN8YU5OxU+DTeNzczdKPsM42BGwCY9SVpzPGvfH=e-wqU4sgjQ@mail.gmail.com>
        <20191027092254.35a4c151@archlinux>
        <CAN8YU5P4vUWOTSJWiL-cPDmQ3aJLe0Z-E3TK5Pmzg1kkxptY-w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Oct 2019 08:32:48 +0100
Andrea Merello <andrea.merello@gmail.com> wrote:

> Il giorno dom 27 ott 2019 alle ore 10:23 Jonathan Cameron
> <jic23@kernel.org> ha scritto:
> >
> > On Wed, 23 Oct 2019 10:29:07 +0200
> > Andrea Merello <andrea.merello@gmail.com> wrote:
> >  
> > > Il giorno mar 22 ott 2019 alle ore 11:35 Jonathan Cameron
> > > <jic23@kernel.org> ha scritto:  
> > > >
> > > > On Fri, 18 Oct 2019 15:46:32 +0200
> > > > Andrea Merello <andrea.merello@gmail.com> wrote:
> > > >  
> > > > > Il giorno gio 17 ott 2019 alle ore 14:32 Jonathan Cameron
> > > > > <jonathan.cameron@huawei.com> ha scritto:  
> > > > > >
> > > > > > On Wed, 16 Oct 2019 15:14:20 +0200
> > > > > > Andrea Merello <andrea.merello@gmail.com> wrote:
> > > > > >  
> > > > > > > Il giorno dom 6 ott 2019 alle ore 09:54 Jonathan Cameron
> > > > > > > <jic23@kernel.org> ha scritto:  
> > > > > > > >
> > > > > > > > On Mon, 23 Sep 2019 14:17:12 +0200
> > > > > > > > Andrea Merello <andrea.merello@gmail.com> wrote:
> > > > > > > >  
> > > > > > > > > This sensor has an embedded notch filter for reducing interferences caused
> > > > > > > > > by the power mains. This filter can be tuned to reject either 50Hz or 60Hz
> > > > > > > > > (and harmonics).
> > > > > > > > >
> > > > > > > > > Currently the said setting is left alone (the sensor defaults to 60Hz).
> > > > > > > > > This patch introduces a IIO attribute that allows the user to set the said
> > > > > > > > > filter to the desired frequency.
> > > > > > > > >
> > > > > > > > > NOTE: this has been intentionally not tied to any DT property to allow
> > > > > > > > > the configuration of this setting from userspace, e.g. with a GUI or by
> > > > > > > > > reading a configuration file, or maybe reading a GPIO tied to a physical
> > > > > > > > > switch or accessing some device that can autodetect the line frequency.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Andrea Merello <andrea.merello@gmail.com>  
> > > > > > > > This one is not something that can be expect to be known from the setup
> > > > > > > > of the device as it will depend on local mains frequency.
> > > > > > > >
> > > > > > > > So fine, to have it as a userspace control, but the name is too generic.
> > > > > > > > We already have a number of filter attributes and we should try to
> > > > > > > > work out how to bring it inline with them.  
> > > > > > >
> > > > > > > Sure
> > > > > > >  
> > > > > > > > in_X_filter_low_pass_3db_frequency
> > > > > > > > in_X_filter_high_pass_3db_frequency
> > > > > > > >
> > > > > > > > So would,
> > > > > > > > in_X_filter_notch_center_frequency work?
> > > > > > > > ( I suppose we should use the American spelling ;)  
> > > > > > >
> > > > > > > Yes, it seems OK in this case. I will produce a V2 with this modification.
> > > > > > >  
> > > > > > > > This kind of ignores the harmonics aspect but at least documents the
> > > > > > > > main frequency being blocked.  
> > > > > > >
> > > > > > > I think this is perfectly fine: the user wants to set the notch filter
> > > > > > > center frequency to either 60Hz or 50Hz to match the line frequency,
> > > > > > > then she/he expects the filter to simply "work" somehow; IMO the
> > > > > > > harmonic thing does not needed to be explicit.
> > > > > > >  
> > > > > > > > There is a slight complexity that we have devices that have dual
> > > > > > > > notchfilters (50 and 60Hz) and ones where you can turn it off entirely.
> > > > > > > >
> > > > > > > > I suppose no value would count as off and we could perhaps use a list
> > > > > > > > for both on at the same time (though that's a bit horrible).  
> > > > > > >
> > > > > > > IMHO it seems reasonable. Maybe for all-off and both-on conditions we
> > > > > > > could also use magic strings like i.e. "all" and "off".  
> > > > > >
> > > > > > I go with 'maybe' on that one.  Need to think about whether that is just
> > > > > > a partial solution as we will probably find a device with 3 options that only
> > > > > > supports any 2 at one time.  That would still need a more complex interface.
> > > > > >
> > > > > > Will think on this.  
> > > > >
> > > > > I'll keep this patch on hold, waiting for your thoughts. Take the time
> > > > > you need :)
> > > > >
> > > > > BTW IMHO:
> > > > >
> > > > > If we want to address the most possible generic case, then we may
> > > > > standardize a set of possible attributes for filters (like "enable",
> > > > > "center_frequency", "width",  "Q" , etc). Of course most filters will
> > > > > not allow for setting most of those attributes.  
> > > >
> > > > Absolutely.  We currently have a few defined for low and high pass
> > > > filters, but if there are more complex features to define we should
> > > > do so.
> > > >  
> > > > >
> > > > > Then i.e.  in our case we could have one single filter that allows for
> > > > > setting the frequency to either 50hz or 60hz; in other cases we could
> > > > > have i.e. two filters (with 50hz and 60hz center freq respectively),
> > > > > and they would allow to set only the "enable" attribute; in case you
> > > > > can i.e. enable only two of three filters, when you try to enable the
> > > > > 3rd it just refuse that. In this scenario probably "center_frequency"
> > > > > could be just a regular value (not a list).  
> > > >
> > > > Agreed.  The question is whether to index filters.  So allow more
> > > > than one of a given type on a given channel. So far we have
> > > > only had the one and there isn't a nice way to support multiple
> > > > as we currently don't have any indexed parameters of a single channel.  
> > >
> > > Yes, being able to indexing filters was the underlying assumption..
> > >  
> > > > I haven't seen parts that actually do have this level of sophisticated
> > > > filtering built in, with the exception of mains filters like this one.  
> > >
> > > Yes, I didn't too indeed.
> > >  
> > > > I think we have to allow for the possibility so if you are happy to do
> > > > so please propose the ABI additions to support multiple filters of
> > > > a type. I would suggest keeping them per type though
> > > >
> > > > e.g.
> > > >
> > > > in_X_filter_low_passY_3db_frequency etc
> > > > with Y as the optional index.  
> > >
> > > Seems reasonable.
> > >
> > > Well the idea is the one you've just explained here, that is adding an
> > > optional index for filters (per type and per ch); I'm not getting what
> > > do you mean about proposing it..  
> > Like all new ABI, needs a formal documentation patch.  Sometimes
> > we get more review on those than on discussions deep in a thread like
> > this.  
> 
> OK, this is honestly a bit out of my scope, but - if this is OK for
> you - I may try to do that after getting to some end with those
> in-flight patches..

That is fine, but we will need docs for anything that is added
even if it's the version without an index.

Don't have to be detailed etc, just a couple of lines for
Documentation/ABI/testing/sysfs-bus-iio to define what it is and
what it's units are.

> 
> > >  
> > > > For now, lets just implement then using extended attributes rather
> > > > than trying to extend the core to generate these automatically.
> > > >
> > > > If this turns out not to be a corner case we can try to figure
> > > > out a sane way of generating the multiple indexed versions.  
> > >
> > > OK. Let's try not to over-complicate things until it's really needed -
> > > Also, maybe if we'll hit other weird devices that need something like
> > > this, then they could have some exotic features that we haven't in
> > > mind yet now; it might turn out that we need something even more
> > > different, so maybe it's better to wait for real "users" of the ABI
> > > before deciding how to change it..
> > >
> > > But indeed, getting back to the patch originally discussed in this
> > > thread: if you are OK whit this, then I'll go with a
> > > "in_temp_filter_notch_center_frequency" attribute.
> > >
> > > I may use a specific IIO_DEVIC_ATTR or add it to the core (without
> > > addressing the index thing), as you prefer.  
> >
> > Which ever makes most sense to you. Either is fine for a new
> > attribute, though here don't we need the indexed filters?  
> 
> This specific device has only the option to choose either 50Hz
> filtering or 60Hz filtering; no option to disable filtering or enable
> both frequency. So I would say that here we can expose just one filter
> for which the center frequency can be set to either 50Hz or 60Hz (like
> the original patch did - but with proper name this time). I would say
> that we don't need indexed filters here. Or have I missed something ?
> 
> (So I would start with a IIO_DEVICE_ATTR for now then).

That's fine.  I'd somehow gotten it into my head that the part
had two filters :)

> 
> > >
> > > BTW: Looking at other drivers, it seems that for other attributes
> > > (e.g. oversampling_ratio, discussed in 2/3) they tend to round
> > > required values to the closest allowed value, instead of returning an
> > > error. In this specific case, do you want to apply the same logic? For
> > > consistency reasons I would do that, but at the practical side,
> > > requiring a line filter frequency which is not either 50Hz or 60Hz
> > > seems really an error to me..  
> >
> > It can be a bit of a tricky decision but for something like this
> > where the precise value works, it should reject incorrect ones.  
> 
> OK
> 
> > Oversampling is an odd one.  It should probably always round up
> > as it's usually not a problem to average more results, it just
> > wastes power.  That only applies if the oversampling_ratio
> > is independent of other attributes such as sampling frequency.  
> 
> It actually affects also the sampling rate; the more samples you
> average, the slowest output rate you achieve. But actually there is no
> attribute for setting the sampling frequency.. it is internally
> adjusted by the chip depending by averaging and filter line frequency
> (don't know why).
> 
> (if we want also this attribute, then I can craft another patch for
> adding it; it may be usefult to report the actual sample rate, I'm not
> sure if it makes sense to let the user set it, because we can
> basically just switch the averaging to one of the few possible values
> to get the sample rate to change as a side effect - assuming that one
> doesn't want to change the line frequency filter).

OK.  There are no hard rules on which attributes are the 'dominant'
ones so it would be fine to either not expose it or to have it read
only.  It can certainly be useful for fast devices as it lets you
size the buffers, but for a temperature sensor like this one
sampling_frequency probably doesn't matter to anyone.

> 
> BTW What about to round the requested oversampling_ratio to the
> closest allowed value (instead of rounding up)?

If a user has requested a value for oversampling ratio, it will
be to achieve a particular improvement in noise rejection.

As such I'd assume round up was most appropriate, or error on any
value that isn't a precise value.
> 
> > Still, we have traditionally been relaxed on this as long
> > as writing the the 'correct' value always works as that's what
> > userspace ABI should be doing.
> >
> > Jonathan
> >  
Thanks,

Jonathan
