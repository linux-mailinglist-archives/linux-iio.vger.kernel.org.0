Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD54ADAC53
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2019 14:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390848AbfJQMee (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Oct 2019 08:34:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47088 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727291AbfJQMed (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Oct 2019 08:34:33 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 06D84C192E045DB6BCE0;
        Thu, 17 Oct 2019 20:34:30 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Thu, 17 Oct 2019
 20:34:25 +0800
Date:   Thu, 17 Oct 2019 13:34:14 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Andrea Merello <andrea.merello@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        <patrick.havelange@essensium.com>,
        <paresh.chaudhary@rockwellcollins.com>, <pmeerw@pmeerw.net>,
        <lars@metafoo.de>, <knaack.h@gmx.de>,
        Matthew Weber <matthew.weber@rockwellcollins.com>,
        Colin King <colin.king@canonical.com>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: max31856: add support for configuring the HW
 averaging
Message-ID: <20191017133414.000062ae@huawei.com>
In-Reply-To: <CAN8YU5NPpcwcj1ik+yzWuvRheBzLtj3A75b_5FZtqw2osfoahQ@mail.gmail.com>
References: <20190923121714.13672-1-andrea.merello@gmail.com>
        <20190923121714.13672-3-andrea.merello@gmail.com>
        <20191006085545.2df79667@archlinux>
        <CAN8YU5NPpcwcj1ik+yzWuvRheBzLtj3A75b_5FZtqw2osfoahQ@mail.gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Oct 2019 15:33:42 +0200
Andrea Merello <andrea.merello@gmail.com> wrote:

> Il giorno dom 6 ott 2019 alle ore 09:55 Jonathan Cameron
> <jic23@kernel.org> ha scritto:
> >
> > On Mon, 23 Sep 2019 14:17:13 +0200
> > Andrea Merello <andrea.merello@gmail.com> wrote:
> >  
> > > This sensor can perform samples averaging in hardware, but currently the
> > > driver leaves this setting alone (default is no averaging).
> > >
> > > This patch introduces a new IIO attribute that allows the user to set the
> > > averaging as desired (the HW supports averaging of 2, 5, 8 or 16 samples)
> > >
> > > Signed-off-by: Andrea Merello <andrea.merello@gmail.com>  
> >
> > Sounds like oversampling combined with a lower sampling frequency, so
> > there is standard ABI for that.  
> 
> OK. Do you refer to "oversampling_ratio"?
> 
> The datasheet says this applies to thermocouple measure, but by doing
> some testing with real HW, it seems that this setting affects both
> thermocouple and cold-junction measures, so I guess it shouldn't be in
> the form "in_temp_raw_oversampling_ratio"; does this sound right to
> you?
Ah yes. oversampling_ratio it is.  I should read our Docs :)

I think
in_temp_oversampling_ratio will be generated if you use the info_mask_shared_by_type
to do this.

_raw is just another type of information about the channel, rather than
part of the channel naming.

Thanks,

Jonathan

> 
> > Jonathan
> >  
> > > ---
> > >  drivers/iio/temperature/max31856.c | 43 ++++++++++++++++++++++++++++++
> > >  1 file changed, 43 insertions(+)
> > >
> > > diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
> > > index d12613f7ba3c..8b2e0102fa5c 100644
> > > --- a/drivers/iio/temperature/max31856.c
> > > +++ b/drivers/iio/temperature/max31856.c
> > > @@ -24,6 +24,8 @@
> > >  #define MAX31856_CR0_OCFAULT       BIT(4)
> > >  #define MAX31856_CR0_OCFAULT_MASK  GENMASK(5, 4)
> > >  #define MAX31856_CR0_FILTER_50HZ   BIT(0)
> > > +#define MAX31856_AVERAGING_MASK    GENMASK(6, 4)
> > > +#define MAX31856_AVERAGING_SHIFT   4
> > >  #define MAX31856_TC_TYPE_MASK      GENMASK(3, 0)
> > >  #define MAX31856_FAULT_OVUV        BIT(1)
> > >  #define MAX31856_FAULT_OPEN        BIT(0)
> > > @@ -65,6 +67,7 @@ struct max31856_data {
> > >       struct spi_device *spi;
> > >       u32 thermocouple_type;
> > >       bool filter_50hz;
> > > +     int averaging;
> > >  };
> > >
> > >  static int max31856_read(struct max31856_data *data, u8 reg,
> > > @@ -109,6 +112,10 @@ static int max31856_init(struct max31856_data *data)
> > >
> > >       reg_cr1_val &= ~MAX31856_TC_TYPE_MASK;
> > >       reg_cr1_val |= data->thermocouple_type;
> > > +
> > > +     reg_cr1_val &= ~MAX31856_AVERAGING_MASK;
> > > +     reg_cr1_val |= data->averaging << MAX31856_AVERAGING_SHIFT;
> > > +
> > >       ret = max31856_write(data, MAX31856_CR1_REG, reg_cr1_val);
> > >       if (ret)
> > >               return ret;
> > > @@ -295,14 +302,50 @@ static ssize_t set_filter(struct device *dev,
> > >       return len;
> > >  }
> > >
> > > +static ssize_t show_averaging(struct device *dev,
> > > +                           struct device_attribute *attr,
> > > +                           char *buf)
> > > +{
> > > +     struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > > +     struct max31856_data *data = iio_priv(indio_dev);
> > > +
> > > +     return sprintf(buf, "%d\n", 1 << data->averaging);
> > > +}
> > > +
> > > +static ssize_t set_averaging(struct device *dev,
> > > +                          struct device_attribute *attr,
> > > +                          const char *buf,
> > > +                          size_t len)
> > > +{
> > > +     struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > > +     struct max31856_data *data = iio_priv(indio_dev);
> > > +     unsigned int nsamples;
> > > +     int shift;
> > > +     int ret;
> > > +
> > > +     ret = kstrtouint(buf, 10, &nsamples);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     shift = fls(nsamples) - 1;
> > > +     if (nsamples > 16 || BIT(shift) != nsamples)
> > > +             return -EINVAL;
> > > +
> > > +     data->averaging = shift;
> > > +     max31856_init(data);
> > > +     return len;
> > > +}
> > > +
> > >  static IIO_DEVICE_ATTR(fault_ovuv, 0444, show_fault_ovuv, NULL, 0);
> > >  static IIO_DEVICE_ATTR(fault_oc, 0444, show_fault_oc, NULL, 0);
> > >  static IIO_DEVICE_ATTR(filter, 0644, show_filter, set_filter, 0);
> > > +static IIO_DEVICE_ATTR(averaging, 0644, show_averaging, set_averaging, 0);
> > >
> > >  static struct attribute *max31856_attributes[] = {
> > >       &iio_dev_attr_fault_ovuv.dev_attr.attr,
> > >       &iio_dev_attr_fault_oc.dev_attr.attr,
> > >       &iio_dev_attr_filter.dev_attr.attr,
> > > +     &iio_dev_attr_averaging.dev_attr.attr,
> > >       NULL,
> > >  };
> > >  
> >  


