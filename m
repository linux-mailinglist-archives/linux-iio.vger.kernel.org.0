Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF921E00D7
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2019 11:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfJVJfF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Oct 2019 05:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:32830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730247AbfJVJfE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 Oct 2019 05:35:04 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 792BC20679;
        Tue, 22 Oct 2019 09:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571736903;
        bh=VZgqPtWa34Q/Fy1JG7lVK4c7SupOaSY+KLgU+PRBV0I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dFtLbZpYTWlXldjBRXJFnQ4KXsK7Qtz1gl/5zgauKtQ+pVqsb9gmViJ1cSnbaTc5o
         fdgPYqgJx4ZC8wqcJDA1DF6ml7Yx1HdsV/EpoByojRFz0lTqFvRVgMChRQExYpYEPc
         /b+KVafl7MRASCRnwJ7nEq90letW6MwHUFqCszyY=
Date:   Tue, 22 Oct 2019 10:34:58 +0100
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
Message-ID: <20191022103458.3a112511@archlinux>
In-Reply-To: <CAN8YU5Nxrv8q4LjCCrHH-qR6kj=PjNLBANgrTkYdX1b1OP+gkA@mail.gmail.com>
References: <20190923121714.13672-1-andrea.merello@gmail.com>
        <20190923121714.13672-2-andrea.merello@gmail.com>
        <20191006085423.68bcecfd@archlinux>
        <CAN8YU5Ogcp8ERkxntTVQH3EoJF7h61VCONPXEaP-kvpx8EmS+g@mail.gmail.com>
        <20191017133210.00002799@huawei.com>
        <CAN8YU5Nxrv8q4LjCCrHH-qR6kj=PjNLBANgrTkYdX1b1OP+gkA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Oct 2019 15:46:32 +0200
Andrea Merello <andrea.merello@gmail.com> wrote:

> Il giorno gio 17 ott 2019 alle ore 14:32 Jonathan Cameron
> <jonathan.cameron@huawei.com> ha scritto:
> >
> > On Wed, 16 Oct 2019 15:14:20 +0200
> > Andrea Merello <andrea.merello@gmail.com> wrote:
> >  
> > > Il giorno dom 6 ott 2019 alle ore 09:54 Jonathan Cameron
> > > <jic23@kernel.org> ha scritto:  
> > > >
> > > > On Mon, 23 Sep 2019 14:17:12 +0200
> > > > Andrea Merello <andrea.merello@gmail.com> wrote:
> > > >  
> > > > > This sensor has an embedded notch filter for reducing interferences caused
> > > > > by the power mains. This filter can be tuned to reject either 50Hz or 60Hz
> > > > > (and harmonics).
> > > > >
> > > > > Currently the said setting is left alone (the sensor defaults to 60Hz).
> > > > > This patch introduces a IIO attribute that allows the user to set the said
> > > > > filter to the desired frequency.
> > > > >
> > > > > NOTE: this has been intentionally not tied to any DT property to allow
> > > > > the configuration of this setting from userspace, e.g. with a GUI or by
> > > > > reading a configuration file, or maybe reading a GPIO tied to a physical
> > > > > switch or accessing some device that can autodetect the line frequency.
> > > > >
> > > > > Signed-off-by: Andrea Merello <andrea.merello@gmail.com>  
> > > > This one is not something that can be expect to be known from the setup
> > > > of the device as it will depend on local mains frequency.
> > > >
> > > > So fine, to have it as a userspace control, but the name is too generic.
> > > > We already have a number of filter attributes and we should try to
> > > > work out how to bring it inline with them.  
> > >
> > > Sure
> > >  
> > > > in_X_filter_low_pass_3db_frequency
> > > > in_X_filter_high_pass_3db_frequency
> > > >
> > > > So would,
> > > > in_X_filter_notch_center_frequency work?
> > > > ( I suppose we should use the American spelling ;)  
> > >
> > > Yes, it seems OK in this case. I will produce a V2 with this modification.
> > >  
> > > > This kind of ignores the harmonics aspect but at least documents the
> > > > main frequency being blocked.  
> > >
> > > I think this is perfectly fine: the user wants to set the notch filter
> > > center frequency to either 60Hz or 50Hz to match the line frequency,
> > > then she/he expects the filter to simply "work" somehow; IMO the
> > > harmonic thing does not needed to be explicit.
> > >  
> > > > There is a slight complexity that we have devices that have dual
> > > > notchfilters (50 and 60Hz) and ones where you can turn it off entirely.
> > > >
> > > > I suppose no value would count as off and we could perhaps use a list
> > > > for both on at the same time (though that's a bit horrible).  
> > >
> > > IMHO it seems reasonable. Maybe for all-off and both-on conditions we
> > > could also use magic strings like i.e. "all" and "off".  
> >
> > I go with 'maybe' on that one.  Need to think about whether that is just
> > a partial solution as we will probably find a device with 3 options that only
> > supports any 2 at one time.  That would still need a more complex interface.
> >
> > Will think on this.  
> 
> I'll keep this patch on hold, waiting for your thoughts. Take the time
> you need :)
> 
> BTW IMHO:
> 
> If we want to address the most possible generic case, then we may
> standardize a set of possible attributes for filters (like "enable",
> "center_frequency", "width",  "Q" , etc). Of course most filters will
> not allow for setting most of those attributes.

Absolutely.  We currently have a few defined for low and high pass
filters, but if there are more complex features to define we should
do so.

> 
> Then i.e.  in our case we could have one single filter that allows for
> setting the frequency to either 50hz or 60hz; in other cases we could
> have i.e. two filters (with 50hz and 60hz center freq respectively),
> and they would allow to set only the "enable" attribute; in case you
> can i.e. enable only two of three filters, when you try to enable the
> 3rd it just refuse that. In this scenario probably "center_frequency"
> could be just a regular value (not a list).

Agreed.  The question is whether to index filters.  So allow more
than one of a given type on a given channel. So far we have
only had the one and there isn't a nice way to support multiple
as we currently don't have any indexed parameters of a single channel.

I haven't seen parts that actually do have this level of sophisticated
filtering built in, with the exception of mains filters like this one.

I think we have to allow for the possibility so if you are happy to do
so please propose the ABI additions to support multiple filters of
a type. I would suggest keeping them per type though

e.g.

in_X_filter_low_passY_3db_frequency etc
with Y as the optional index.

For now, lets just implement then using extended attributes rather
than trying to extend the core to generate these automatically.

If this turns out not to be a corner case we can try to figure
out a sane way of generating the multiple indexed versions.


> 
> >
> >
> > Jonathan
> >  
> > >  
> > > > > ---
> > > > >  drivers/iio/temperature/max31856.c | 49 ++++++++++++++++++++++++++++++
> > > > >  1 file changed, 49 insertions(+)
> > > > >
> > > > > diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
> > > > > index 73ed550e3fc9..d12613f7ba3c 100644
> > > > > --- a/drivers/iio/temperature/max31856.c
> > > > > +++ b/drivers/iio/temperature/max31856.c
> > > > > @@ -23,6 +23,7 @@
> > > > >  #define MAX31856_CR0_1SHOT         BIT(6)
> > > > >  #define MAX31856_CR0_OCFAULT       BIT(4)
> > > > >  #define MAX31856_CR0_OCFAULT_MASK  GENMASK(5, 4)
> > > > > +#define MAX31856_CR0_FILTER_50HZ   BIT(0)
> > > > >  #define MAX31856_TC_TYPE_MASK      GENMASK(3, 0)
> > > > >  #define MAX31856_FAULT_OVUV        BIT(1)
> > > > >  #define MAX31856_FAULT_OPEN        BIT(0)
> > > > > @@ -63,6 +64,7 @@ static const struct iio_chan_spec max31856_channels[] = {
> > > > >  struct max31856_data {
> > > > >       struct spi_device *spi;
> > > > >       u32 thermocouple_type;
> > > > > +     bool filter_50hz;
> > > > >  };
> > > > >
> > > > >  static int max31856_read(struct max31856_data *data, u8 reg,
> > > > > @@ -123,6 +125,11 @@ static int max31856_init(struct max31856_data *data)
> > > > >       reg_cr0_val &= ~MAX31856_CR0_1SHOT;
> > > > >       reg_cr0_val |= MAX31856_CR0_AUTOCONVERT;
> > > > >
> > > > > +     if (data->filter_50hz)
> > > > > +             reg_cr0_val |= MAX31856_CR0_FILTER_50HZ;
> > > > > +     else
> > > > > +             reg_cr0_val &= ~MAX31856_CR0_FILTER_50HZ;
> > > > > +
> > > > >       return max31856_write(data, MAX31856_CR0_REG, reg_cr0_val);
> > > > >  }
> > > > >
> > > > > @@ -249,12 +256,53 @@ static ssize_t show_fault_oc(struct device *dev,
> > > > >       return show_fault(dev, MAX31856_FAULT_OPEN, buf);
> > > > >  }
> > > > >
> > > > > +static ssize_t show_filter(struct device *dev,
> > > > > +                        struct device_attribute *attr,
> > > > > +                        char *buf)
> > > > > +{
> > > > > +     struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > > > > +     struct max31856_data *data = iio_priv(indio_dev);
> > > > > +
> > > > > +     return sprintf(buf, "%d\n", data->filter_50hz ? 50 : 60);
> > > > > +}
> > > > > +
> > > > > +static ssize_t set_filter(struct device *dev,
> > > > > +                       struct device_attribute *attr,
> > > > > +                       const char *buf,
> > > > > +                       size_t len)
> > > > > +{
> > > > > +     struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > > > > +     struct max31856_data *data = iio_priv(indio_dev);
> > > > > +     unsigned int freq;
> > > > > +     int ret;
> > > > > +
> > > > > +     ret = kstrtouint(buf, 10, &freq);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +
> > > > > +     switch (freq) {
> > > > > +     case 50:
> > > > > +             data->filter_50hz = true;
> > > > > +             break;
> > > > > +     case 60:
> > > > > +             data->filter_50hz = false;
> > > > > +             break;
> > > > > +     default:
> > > > > +             return -EINVAL;
> > > > > +     }
> > > > > +
> > > > > +     max31856_init(data);
> > > > > +     return len;
> > > > > +}
> > > > > +
> > > > >  static IIO_DEVICE_ATTR(fault_ovuv, 0444, show_fault_ovuv, NULL, 0);
> > > > >  static IIO_DEVICE_ATTR(fault_oc, 0444, show_fault_oc, NULL, 0);
> > > > > +static IIO_DEVICE_ATTR(filter, 0644, show_filter, set_filter, 0);
> > > > >
> > > > >  static struct attribute *max31856_attributes[] = {
> > > > >       &iio_dev_attr_fault_ovuv.dev_attr.attr,
> > > > >       &iio_dev_attr_fault_oc.dev_attr.attr,
> > > > > +     &iio_dev_attr_filter.dev_attr.attr,
> > > > >       NULL,
> > > > >  };
> > > > >
> > > > > @@ -280,6 +328,7 @@ static int max31856_probe(struct spi_device *spi)
> > > > >
> > > > >       data = iio_priv(indio_dev);
> > > > >       data->spi = spi;
> > > > > +     data->filter_50hz = false;
> > > > >
> > > > >       spi_set_drvdata(spi, indio_dev);
> > > > >  
> > > >  
> >
> >  

