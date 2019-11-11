Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D46D6F8325
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2019 23:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKKW7c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Nov 2019 17:59:32 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:45977 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfKKW7c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Nov 2019 17:59:32 -0500
Received: by mail-il1-f195.google.com with SMTP id o18so13642042ils.12
        for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2019 14:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lUzGTYBIu4Pm0wf2HZ38uUB4Om1K0yz39d+GEmxoteg=;
        b=WP+YNBn+nfzXphzXewrDoh+gNLNKoqg/ajPjCyLVYmzXhTePylch+hZzmWVFNP48c3
         sIRRvfxNtdFMd41ND/qEwQvl8DwkRFHknhfYLxSN+a03Hm19Oi9uqwtgVBkz8+uXcY9W
         WQxeOkYySsUxH7mJ63/7KVXlEH3bMl5RHEWRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lUzGTYBIu4Pm0wf2HZ38uUB4Om1K0yz39d+GEmxoteg=;
        b=YwDHfsHSxHgvOpQkCi8JHW6klPTGNh4aH6dXq5sY+1mqdH27jpPXqvH/m54GeoXYeV
         Tuu3853GMteZH6MvcKwDg+T3DiEDiHrtB+JpfQmIn5c/WYVTjPelhR9t8mGSrX2R2Ao4
         lbTdAb+3FksA7g53OD5WW9xdxzK6faA7jtFl3VGPvythq47f9eXeSJ6hsDdR8qBZsz1A
         nUQ0S3oXD+F/8tdUWOF9ieHN7CmB6AeekYybE+lrikTSgsNWbaDUcYMCMk+LiXE/V0cV
         Pt4TVWR727Mi+Vj2IrOyVJxa2H/CNXFaPztGMUl4/nBE+yXsSk1xnRY44WzL+fLgnOXq
         gJ3Q==
X-Gm-Message-State: APjAAAUPU7CHK2jkGwHd6cAfknGb/mFau2/FpSRD5vXau6qQqANhvb54
        Lm+1Jw6mwru2xxYk0mWjyg1FRgfwM6XRAOtRYptfGHanS9sqfh6l
X-Google-Smtp-Source: APXvYqx5+ooJihCtL0ST2Rbi1Tc4s/aqxUTQxJvlalslmripBVAgCwueH5SzJfA2MOIeIKS/JqmUeW49tEZfgltxT9g=
X-Received: by 2002:a92:2450:: with SMTP id k77mr32329757ilk.120.1573513170686;
 Mon, 11 Nov 2019 14:59:30 -0800 (PST)
MIME-Version: 1.0
References: <20190923121714.13672-1-andrea.merello@gmail.com>
 <20191111153517.13862-1-andrea.merello@gmail.com> <20191111153517.13862-2-andrea.merello@gmail.com>
In-Reply-To: <20191111153517.13862-2-andrea.merello@gmail.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Tue, 12 Nov 2019 07:59:19 +0900
Message-ID: <CAJCx=gnvX0pQnBMpL0JkGYuonAxAwazK=qXx=9UB4eO4EQWVNA@mail.gmail.com>
Subject: Re: [v2 1/9] iio: max31856: add option for setting mains filter
 rejection frequency
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Colin Ian King <colin.king@canonical.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Daniel Gomez <dagmcr@gmail.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Nov 12, 2019 at 12:35 AM Andrea Merello
<andrea.merello@gmail.com> wrote:
>
> This sensor has an embedded notch filter for reducing interferences caused
> by the power mains. This filter can be tuned to reject either 50Hz or 60Hz
> (and harmonics).
>
> Currently the said setting is left alone (the sensor defaults to 60Hz).
> This patch introduces a IIO attribute that allows the user to set the said
> filter to the desired frequency.
>
> NOTE: this has been intentionally not tied to any DT property to allow
> the configuration of this setting from userspace, e.g. with a GUI or by
> reading a configuration file, or maybe reading a GPIO tied to a physical
> switch or accessing some device that can autodetect the line frequency.
>

Looks good to me. Although this ideal could be a device tree property
as well, but not a big deal.

Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>

> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Colin Ian King <colin.king@canonical.com>
> Cc: Patrick Havelange <patrick.havelange@essensium.com>
> Cc: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> Cc: Matt Weber <matthew.weber@rockwellcollins.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> Cc: Chuhong Yuan <hslester96@gmail.com>
> Cc: Daniel Gomez <dagmcr@gmail.com>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> ---
>  drivers/iio/temperature/max31856.c | 50 ++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
> index 73ed550e3fc9..d97ba9ee1598 100644
> --- a/drivers/iio/temperature/max31856.c
> +++ b/drivers/iio/temperature/max31856.c
> @@ -23,6 +23,7 @@
>  #define MAX31856_CR0_1SHOT         BIT(6)
>  #define MAX31856_CR0_OCFAULT       BIT(4)
>  #define MAX31856_CR0_OCFAULT_MASK  GENMASK(5, 4)
> +#define MAX31856_CR0_FILTER_50HZ   BIT(0)
>  #define MAX31856_TC_TYPE_MASK      GENMASK(3, 0)
>  #define MAX31856_FAULT_OVUV        BIT(1)
>  #define MAX31856_FAULT_OPEN        BIT(0)
> @@ -63,6 +64,7 @@ static const struct iio_chan_spec max31856_channels[] = {
>  struct max31856_data {
>         struct spi_device *spi;
>         u32 thermocouple_type;
> +       bool filter_50hz;
>  };
>
>  static int max31856_read(struct max31856_data *data, u8 reg,
> @@ -123,6 +125,11 @@ static int max31856_init(struct max31856_data *data)
>         reg_cr0_val &= ~MAX31856_CR0_1SHOT;
>         reg_cr0_val |= MAX31856_CR0_AUTOCONVERT;
>
> +       if (data->filter_50hz)
> +               reg_cr0_val |= MAX31856_CR0_FILTER_50HZ;
> +       else
> +               reg_cr0_val &= ~MAX31856_CR0_FILTER_50HZ;
> +
>         return max31856_write(data, MAX31856_CR0_REG, reg_cr0_val);
>  }
>
> @@ -249,12 +256,54 @@ static ssize_t show_fault_oc(struct device *dev,
>         return show_fault(dev, MAX31856_FAULT_OPEN, buf);
>  }
>
> +static ssize_t show_filter(struct device *dev,
> +                          struct device_attribute *attr,
> +                          char *buf)
> +{
> +       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +       struct max31856_data *data = iio_priv(indio_dev);
> +
> +       return sprintf(buf, "%d\n", data->filter_50hz ? 50 : 60);
> +}
> +
> +static ssize_t set_filter(struct device *dev,
> +                         struct device_attribute *attr,
> +                         const char *buf,
> +                         size_t len)
> +{
> +       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +       struct max31856_data *data = iio_priv(indio_dev);
> +       unsigned int freq;
> +       int ret;
> +
> +       ret = kstrtouint(buf, 10, &freq);
> +       if (ret)
> +               return ret;
> +
> +       switch (freq) {
> +       case 50:
> +               data->filter_50hz = true;
> +               break;
> +       case 60:
> +               data->filter_50hz = false;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       max31856_init(data);
> +       return len;
> +}
> +
>  static IIO_DEVICE_ATTR(fault_ovuv, 0444, show_fault_ovuv, NULL, 0);
>  static IIO_DEVICE_ATTR(fault_oc, 0444, show_fault_oc, NULL, 0);
> +static IIO_DEVICE_ATTR(in_temp_filter_notch_center_frequency, 0644,
> +                      show_filter, set_filter, 0);
>
>  static struct attribute *max31856_attributes[] = {
>         &iio_dev_attr_fault_ovuv.dev_attr.attr,
>         &iio_dev_attr_fault_oc.dev_attr.attr,
> +       &iio_dev_attr_in_temp_filter_notch_center_frequency.dev_attr.attr,
>         NULL,
>  };
>
> @@ -280,6 +329,7 @@ static int max31856_probe(struct spi_device *spi)
>
>         data = iio_priv(indio_dev);
>         data->spi = spi;
> +       data->filter_50hz = false;
>
>         spi_set_drvdata(spi, indio_dev);
>
> --
> 2.17.1
>
