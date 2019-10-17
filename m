Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 341E7DAC69
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2019 14:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502451AbfJQMgL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Oct 2019 08:36:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4240 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2502412AbfJQMgJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Oct 2019 08:36:09 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 15C4B7370270985C51A3;
        Thu, 17 Oct 2019 20:35:55 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Thu, 17 Oct 2019
 20:35:53 +0800
Date:   Thu, 17 Oct 2019 13:35:43 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Andrea Merello <andrea.merello@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        <patrick.havelange@essensium.com>,
        <paresh.chaudhary@rockwellcollins.com>, <pmeerw@pmeerw.net>,
        <lars@metafoo.de>, <knaack.h@gmx.de>,
        Matthew Weber <matthew.weber@rockwellcollins.com>,
        Colin King <colin.king@canonical.com>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: max31856: add support for runtime-configuring
 the thermocouple type
Message-ID: <20191017133543.00005418@huawei.com>
In-Reply-To: <CAN8YU5PxgjwoLyxqMTuQJDGfo7MYAb0A54pFcFV5_cPeJ=H7Ng@mail.gmail.com>
References: <20190923121714.13672-1-andrea.merello@gmail.com>
        <20190923121714.13672-4-andrea.merello@gmail.com>
        <20191006085825.1efc1d7a@archlinux>
        <CAN8YU5PxgjwoLyxqMTuQJDGfo7MYAb0A54pFcFV5_cPeJ=H7Ng@mail.gmail.com>
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

On Wed, 16 Oct 2019 15:43:18 +0200
Andrea Merello <andrea.merello@gmail.com> wrote:

> Il giorno dom 6 ott 2019 alle ore 09:58 Jonathan Cameron
> <jic23@kernel.org> ha scritto:
> >
> > On Mon, 23 Sep 2019 14:17:14 +0200
> > Andrea Merello <andrea.merello@gmail.com> wrote:
> >  
> > > The sensor support various thermocouple types (e.g. J, K, N, ...). The
> > > driver allows to configure this parameter using a DT property.
> > >
> > > This is useful when i.e. the thermocouple is physically tied to the sensor
> > > and it is usually not removed, or when it is at least known in advace  
> >
> > advance  
> 
> OK
> 
> > > which sensor will be connected to the circuit.
> > >
> > > However, if the user can randomly connect any kind of thermocouples (i.e.
> > > the device exposes a connector, and the user is free to connect its own
> > > sensors), it would be more appropriate to provide a mechanism to
> > > dynamically switch from one thermocouple type to another. This can be i.e.
> > > handled in userspace by a GUI, a configuration file or a program that
> > > detects the thermocouple type by reading a GPIO, or a eeprom on the probe,
> > > or whatever.
> > >
> > > This patch adds a IIO attribute that can be used to override, at run-time,
> > > the DT-provided setting (which serves as default).
> > >
> > > Signed-off-by: Andrea Merello <andrea.merello@gmail.com>  
> > For now this is device specific ABI so you need to have an entry in
> > Documentation/ABI/testing/sysfs-bus-iio-max31856  
> 
> OK
> 
> > Or we could consider this generic enough to put it in a file
> > covering other thermocouple to digital sensors.  
> 
> Yes, theoretically thermocouple-type is a generic thing that isn't
> bound to this specific driver/chip. Currently the others IIO
> thermocouple drivers don't need this because they supports chips that
> handle just a specific thermocouple type, but if you want to make this
> API generic for the future then I can go this way.. It seems
> reasonable to me indeed.
> 

Lets do it then ;)  We might want to add a read only attrs to the
other drivers to make them self describing.

Thanks,

Jonathan

> > Thanks,
> >
> > Jonathan
> >  
> > > ---
> > >  drivers/iio/temperature/max31856.c | 44 ++++++++++++++++++++++++++++++
> > >  1 file changed, 44 insertions(+)
> > >
> > > diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
> > > index 8b2e0102fa5c..588e791c79a3 100644
> > > --- a/drivers/iio/temperature/max31856.c
> > > +++ b/drivers/iio/temperature/max31856.c
> > > @@ -6,6 +6,7 @@
> > >   * Copyright (C) 2018-2019 Rockwell Collins
> > >   */
> > >
> > > +#include <linux/ctype.h>
> > >  #include <linux/module.h>
> > >  #include <linux/init.h>
> > >  #include <linux/err.h>
> > > @@ -70,6 +71,10 @@ struct max31856_data {
> > >       int averaging;
> > >  };
> > >
> > > +const char max31856_tc_types[] = {
> > > +     'B', 'E', 'J', 'K', 'N', 'R', 'S', 'T'
> > > +};
> > > +
> > >  static int max31856_read(struct max31856_data *data, u8 reg,
> > >                        u8 val[], unsigned int read_size)
> > >  {
> > > @@ -336,16 +341,55 @@ static ssize_t set_averaging(struct device *dev,
> > >       return len;
> > >  }
> > >
> > > +static ssize_t show_tc_type(struct device *dev,
> > > +                         struct device_attribute *attr,
> > > +                         char *buf)
> > > +{
> > > +     struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > > +     struct max31856_data *data = iio_priv(indio_dev);
> > > +
> > > +     return sprintf(buf, "%c\n", max31856_tc_types[data->thermocouple_type]);
> > > +}
> > > +
> > > +static ssize_t set_tc_type(struct device *dev,
> > > +                        struct device_attribute *attr,
> > > +                        const char *buf,
> > > +                        size_t len)
> > > +{
> > > +     struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > > +     struct max31856_data *data = iio_priv(indio_dev);
> > > +     char tmp;
> > > +     int tc_type = -1;
> > > +     int i;
> > > +
> > > +     if (sscanf(buf, "%c\n", &tmp) != 1)
> > > +             return -EINVAL;
> > > +
> > > +     for (i = 0; i < ARRAY_SIZE(max31856_tc_types); i++) {
> > > +             if (max31856_tc_types[i] == toupper(tmp)) {
> > > +                     tc_type = i;
> > > +                     break;
> > > +             }
> > > +     }
> > > +     if (tc_type < 0)
> > > +             return -EINVAL;
> > > +     data->thermocouple_type = tc_type;
> > > +     max31856_init(data);
> > > +     return len;
> > > +}
> > > +
> > >  static IIO_DEVICE_ATTR(fault_ovuv, 0444, show_fault_ovuv, NULL, 0);
> > >  static IIO_DEVICE_ATTR(fault_oc, 0444, show_fault_oc, NULL, 0);
> > >  static IIO_DEVICE_ATTR(filter, 0644, show_filter, set_filter, 0);
> > >  static IIO_DEVICE_ATTR(averaging, 0644, show_averaging, set_averaging, 0);
> > > +static IIO_DEVICE_ATTR(thermocouple_type, 0644, show_tc_type, set_tc_type, 0);
> > >
> > >  static struct attribute *max31856_attributes[] = {
> > >       &iio_dev_attr_fault_ovuv.dev_attr.attr,
> > >       &iio_dev_attr_fault_oc.dev_attr.attr,
> > >       &iio_dev_attr_filter.dev_attr.attr,
> > >       &iio_dev_attr_averaging.dev_attr.attr,
> > > +     &iio_dev_attr_thermocouple_type.dev_attr.attr,
> > >       NULL,
> > >  };
> > >  
> >  


