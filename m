Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19538DC670
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2019 15:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392519AbfJRNrt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Oct 2019 09:47:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33902 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388989AbfJRNrt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Oct 2019 09:47:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id y135so9403124wmc.1
        for <linux-iio@vger.kernel.org>; Fri, 18 Oct 2019 06:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=BOgznSRBfS03DyBh+2vseFPY7Pg0AXaWcZ5e9qUSIJU=;
        b=Z/5J177X00h+z36JlvJLzzpLEjlpk9zqEVILIFDsKc7pFonTmSIn/MVrZOAvlPWcVL
         hQJEH6W6Gh39xsNJ2ssaKKMslUATzSYOIYllRKhR/VAYGWr2Hgj4Y8k0U7YgHACDrggL
         M9p38gKX0Sng45nzPVQ6Gyu+NcbN+S0B5pbiTPun/OfXeu+4TnH+cE6MTV9l4qehYxiG
         /wSc1lvnDJ74cngy9U/298HNkU4ftZggTjMxhL0wbofxyBnxs76shT5BvHWJGChy0tis
         M/Y0Euv5uxiBHnqR8cuW/CcH01OgR2+GhY8JiEufAiTGzknD0N/gPYjvEizLqAOL7dZT
         7TVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=BOgznSRBfS03DyBh+2vseFPY7Pg0AXaWcZ5e9qUSIJU=;
        b=EQm3B0bnhOC9GGVqtGfxollgHUOCBE0MYU4Z/CoU5mteO3lkhoLNzl08iTMCTaoSd7
         Ymb735RjJc8M3AOqyINldMYXGhPCzTNz2Kh9BeR0+EFvlcRxH4LxfycaiinMrA39cfsf
         fc6nbmZkW5mwY+HAVIbDlnBUWLne/FfDoU0u0vZKLlsEHkdMqfFR7o5xmfZa5Jb25u1I
         gxPTlLYWsNgMxprfx/ViF5z2E7i+9BZZLCJlILSQR+1WizDLuESHVTMDN6RGwiY9ZxpO
         4UvBOcrsc3eAFyf4HfzXL9NHnmU23FzJIqcV1cD1rqesz8um4urOOpc7tFmh4KfWk3g1
         jDXw==
X-Gm-Message-State: APjAAAUwgGTjg12OnN5WjnpumRUvVfRQuog2CloPhsrzA3p6kQnw0kaF
        5LoDi0xm3PGjek6LzU6SngeUi4cPZYEV/6qilj4=
X-Google-Smtp-Source: APXvYqyt4vFYe56Rbhc33d8OwrNhtqfhlxp8UeMt26gANybqqlqwILVV0G3c/oGd42lOaKRizsiF5w7TlC2TSbE+JkA=
X-Received: by 2002:a05:600c:224c:: with SMTP id a12mr6590891wmm.19.1571406464588;
 Fri, 18 Oct 2019 06:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190923121714.13672-1-andrea.merello@gmail.com>
 <20190923121714.13672-3-andrea.merello@gmail.com> <20191006085545.2df79667@archlinux>
 <CAN8YU5NPpcwcj1ik+yzWuvRheBzLtj3A75b_5FZtqw2osfoahQ@mail.gmail.com> <20191017133414.000062ae@huawei.com>
In-Reply-To: <20191017133414.000062ae@huawei.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Fri, 18 Oct 2019 15:47:33 +0200
Message-ID: <CAN8YU5PhGaQzbO9KNWvAXC3zqxyMksZ+5zHOdKPFK4PEVT=i6A@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: max31856: add support for configuring the HW averaging
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        patrick.havelange@essensium.com,
        paresh.chaudhary@rockwellcollins.com, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de,
        Matthew Weber <matthew.weber@rockwellcollins.com>,
        Colin King <colin.king@canonical.com>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Il giorno gio 17 ott 2019 alle ore 14:34 Jonathan Cameron
<jonathan.cameron@huawei.com> ha scritto:
>
> On Wed, 16 Oct 2019 15:33:42 +0200
> Andrea Merello <andrea.merello@gmail.com> wrote:
>
> > Il giorno dom 6 ott 2019 alle ore 09:55 Jonathan Cameron
> > <jic23@kernel.org> ha scritto:
> > >
> > > On Mon, 23 Sep 2019 14:17:13 +0200
> > > Andrea Merello <andrea.merello@gmail.com> wrote:
> > >
> > > > This sensor can perform samples averaging in hardware, but currently the
> > > > driver leaves this setting alone (default is no averaging).
> > > >
> > > > This patch introduces a new IIO attribute that allows the user to set the
> > > > averaging as desired (the HW supports averaging of 2, 5, 8 or 16 samples)
> > > >
> > > > Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> > >
> > > Sounds like oversampling combined with a lower sampling frequency, so
> > > there is standard ABI for that.
> >
> > OK. Do you refer to "oversampling_ratio"?
> >
> > The datasheet says this applies to thermocouple measure, but by doing
> > some testing with real HW, it seems that this setting affects both
> > thermocouple and cold-junction measures, so I guess it shouldn't be in
> > the form "in_temp_raw_oversampling_ratio"; does this sound right to
> > you?
> Ah yes. oversampling_ratio it is.  I should read our Docs :)

OK. I will do a V2 with this.

> I think
> in_temp_oversampling_ratio will be generated if you use the info_mask_shared_by_type
> to do this.
>
> _raw is just another type of information about the channel, rather than
> part of the channel naming.
>
> Thanks,
>
> Jonathan
>
> >
> > > Jonathan
> > >
> > > > ---
> > > >  drivers/iio/temperature/max31856.c | 43 ++++++++++++++++++++++++++++++
> > > >  1 file changed, 43 insertions(+)
> > > >
> > > > diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
> > > > index d12613f7ba3c..8b2e0102fa5c 100644
> > > > --- a/drivers/iio/temperature/max31856.c
> > > > +++ b/drivers/iio/temperature/max31856.c
> > > > @@ -24,6 +24,8 @@
> > > >  #define MAX31856_CR0_OCFAULT       BIT(4)
> > > >  #define MAX31856_CR0_OCFAULT_MASK  GENMASK(5, 4)
> > > >  #define MAX31856_CR0_FILTER_50HZ   BIT(0)
> > > > +#define MAX31856_AVERAGING_MASK    GENMASK(6, 4)
> > > > +#define MAX31856_AVERAGING_SHIFT   4
> > > >  #define MAX31856_TC_TYPE_MASK      GENMASK(3, 0)
> > > >  #define MAX31856_FAULT_OVUV        BIT(1)
> > > >  #define MAX31856_FAULT_OPEN        BIT(0)
> > > > @@ -65,6 +67,7 @@ struct max31856_data {
> > > >       struct spi_device *spi;
> > > >       u32 thermocouple_type;
> > > >       bool filter_50hz;
> > > > +     int averaging;
> > > >  };
> > > >
> > > >  static int max31856_read(struct max31856_data *data, u8 reg,
> > > > @@ -109,6 +112,10 @@ static int max31856_init(struct max31856_data *data)
> > > >
> > > >       reg_cr1_val &= ~MAX31856_TC_TYPE_MASK;
> > > >       reg_cr1_val |= data->thermocouple_type;
> > > > +
> > > > +     reg_cr1_val &= ~MAX31856_AVERAGING_MASK;
> > > > +     reg_cr1_val |= data->averaging << MAX31856_AVERAGING_SHIFT;
> > > > +
> > > >       ret = max31856_write(data, MAX31856_CR1_REG, reg_cr1_val);
> > > >       if (ret)
> > > >               return ret;
> > > > @@ -295,14 +302,50 @@ static ssize_t set_filter(struct device *dev,
> > > >       return len;
> > > >  }
> > > >
> > > > +static ssize_t show_averaging(struct device *dev,
> > > > +                           struct device_attribute *attr,
> > > > +                           char *buf)
> > > > +{
> > > > +     struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > > > +     struct max31856_data *data = iio_priv(indio_dev);
> > > > +
> > > > +     return sprintf(buf, "%d\n", 1 << data->averaging);
> > > > +}
> > > > +
> > > > +static ssize_t set_averaging(struct device *dev,
> > > > +                          struct device_attribute *attr,
> > > > +                          const char *buf,
> > > > +                          size_t len)
> > > > +{
> > > > +     struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > > > +     struct max31856_data *data = iio_priv(indio_dev);
> > > > +     unsigned int nsamples;
> > > > +     int shift;
> > > > +     int ret;
> > > > +
> > > > +     ret = kstrtouint(buf, 10, &nsamples);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     shift = fls(nsamples) - 1;
> > > > +     if (nsamples > 16 || BIT(shift) != nsamples)
> > > > +             return -EINVAL;
> > > > +
> > > > +     data->averaging = shift;
> > > > +     max31856_init(data);
> > > > +     return len;
> > > > +}
> > > > +
> > > >  static IIO_DEVICE_ATTR(fault_ovuv, 0444, show_fault_ovuv, NULL, 0);
> > > >  static IIO_DEVICE_ATTR(fault_oc, 0444, show_fault_oc, NULL, 0);
> > > >  static IIO_DEVICE_ATTR(filter, 0644, show_filter, set_filter, 0);
> > > > +static IIO_DEVICE_ATTR(averaging, 0644, show_averaging, set_averaging, 0);
> > > >
> > > >  static struct attribute *max31856_attributes[] = {
> > > >       &iio_dev_attr_fault_ovuv.dev_attr.attr,
> > > >       &iio_dev_attr_fault_oc.dev_attr.attr,
> > > >       &iio_dev_attr_filter.dev_attr.attr,
> > > > +     &iio_dev_attr_averaging.dev_attr.attr,
> > > >       NULL,
> > > >  };
> > > >
> > >
>
>
