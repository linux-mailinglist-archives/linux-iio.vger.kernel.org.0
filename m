Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D462F832A
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2019 00:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKKXB5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Nov 2019 18:01:57 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45371 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfKKXB5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Nov 2019 18:01:57 -0500
Received: by mail-io1-f67.google.com with SMTP id v17so15402041iol.12
        for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2019 15:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nspRpV10UCEGrIwtn0mo4Jtvp+YeyokFU/ucBqZPW80=;
        b=E/5fJ328Drmr2MgrdxPfi445jJIYZub5NjJsuPrZKCTVMs5x1YghmlbVu6ZwzShIg/
         VDJOAMaO/XlGsmNbzx2lA6s24x+Ama208E8rdM5jwRLm5pIa2SJjhcVLRwDUoXsYJxb+
         fRiDAMYoh8SAm2KvMmKKLG6uFZ9Ie2HaHO+ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nspRpV10UCEGrIwtn0mo4Jtvp+YeyokFU/ucBqZPW80=;
        b=ay2NYi2rpzLCkfnCMKGb8Umg98i/4JADvEafH5IxSBTZOPHYMyi/DhYdIB+XqnKW9D
         a5DDALrB3eXqWlYpP+nDn6aZqLh4FuPzK3di18ijQmDwXWN38MQzYdLYBN1XM5cNbPNq
         NISVc9GtmbnMzDn8cFKw98BkacLiyGlF9fI8gRScmJMjM9O82j+Adl0cH2BX4H2yeHkM
         5FQeRyqKQlfcvem7KAi4lKnVoTdPAJSpJdAtku/A/iDGiAFMKfGnVd+v/+idlMikLhlt
         RpjwdTmsey8Feh+3PzP52CvbYWstFkUxO0vRL62mDbTql4knw6x4IstOK8Rb9j44x+3e
         Ic0w==
X-Gm-Message-State: APjAAAXabfTj69+hs0K/Tsvr+dZFuECguPgC8klQ8VBM05H7SZXWi1P9
        oi5Y1Xz/9cM2aLvZYMKw1sQiOan9jtBw4r4REOokwA==
X-Google-Smtp-Source: APXvYqx7grrVA0AQdVS+0G43SLLViHFMiQx7cHVSbKitbAK1ZcekO4UorNUpKGL8K1gQwz3i+MTfRmzVMYdMyZTGsTM=
X-Received: by 2002:a6b:dd16:: with SMTP id f22mr26406949ioc.272.1573513315046;
 Mon, 11 Nov 2019 15:01:55 -0800 (PST)
MIME-Version: 1.0
References: <20190923121714.13672-1-andrea.merello@gmail.com>
 <20191111153517.13862-1-andrea.merello@gmail.com> <20191111153517.13862-4-andrea.merello@gmail.com>
In-Reply-To: <20191111153517.13862-4-andrea.merello@gmail.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Tue, 12 Nov 2019 08:01:44 +0900
Message-ID: <CAJCx=gkkBuiTQS9ecRC9YxrK561qr+ywYQDTt1mrYreSbCrfsQ@mail.gmail.com>
Subject: Re: [v2 3/9] iio: max31856: add support for configuring the HW averaging
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
> This sensor can perform samples averaging in hardware, but currently the
> driver leaves this setting alone (default is no averaging).
>
> This patch binds this HW setting to the "oversampling_ratio" IIO attribute
> and allows the user to set the averaging as desired (the HW supports
> averaging of 2, 5, 8 or 16 samples; in-between values are rounded up).
>
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
>  drivers/iio/temperature/max31856.c | 46 +++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
> index d97ba9ee1598..9f0f4f65dccd 100644
> --- a/drivers/iio/temperature/max31856.c
> +++ b/drivers/iio/temperature/max31856.c
> @@ -12,6 +12,7 @@
>  #include <linux/spi/spi.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/util_macros.h>
>  #include <dt-bindings/iio/temperature/thermocouple.h>
>  /*
>   * The MSB of the register value determines whether the following byte will
> @@ -24,6 +25,8 @@
>  #define MAX31856_CR0_OCFAULT       BIT(4)
>  #define MAX31856_CR0_OCFAULT_MASK  GENMASK(5, 4)
>  #define MAX31856_CR0_FILTER_50HZ   BIT(0)
> +#define MAX31856_AVERAGING_MASK    GENMASK(6, 4)
> +#define MAX31856_AVERAGING_SHIFT   4
>  #define MAX31856_TC_TYPE_MASK      GENMASK(3, 0)
>  #define MAX31856_FAULT_OVUV        BIT(1)
>  #define MAX31856_FAULT_OPEN        BIT(0)
> @@ -50,7 +53,10 @@ static const struct iio_chan_spec max31856_channels[] = {
>         {       /* Thermocouple Temperature */
>                 .type = IIO_TEMP,
>                 .info_mask_separate =
> -                       BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +                       BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE) |
> +                       BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE),

Adding IIO_CHAN_INFO_THERMOCOUPLE_TYPE shouldn't happen in this
patchset, since it isn't related
to the oversampling.

- Matt

> +               .info_mask_shared_by_type =
> +                       BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO)
>         },
>         {       /* Cold Junction Temperature */
>                 .type = IIO_TEMP,
> @@ -58,6 +64,8 @@ static const struct iio_chan_spec max31856_channels[] = {
>                 .modified = 1,
>                 .info_mask_separate =
>                         BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +               .info_mask_shared_by_type =
> +                       BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO)
>         },
>  };
>
> @@ -65,6 +73,7 @@ struct max31856_data {
>         struct spi_device *spi;
>         u32 thermocouple_type;
>         bool filter_50hz;
> +       int averaging;
>  };
>
>  static int max31856_read(struct max31856_data *data, u8 reg,
> @@ -109,6 +118,10 @@ static int max31856_init(struct max31856_data *data)
>
>         reg_cr1_val &= ~MAX31856_TC_TYPE_MASK;
>         reg_cr1_val |= data->thermocouple_type;
> +
> +       reg_cr1_val &= ~MAX31856_AVERAGING_MASK;
> +       reg_cr1_val |= data->averaging << MAX31856_AVERAGING_SHIFT;
> +
>         ret = max31856_write(data, MAX31856_CR1_REG, reg_cr1_val);
>         if (ret)
>                 return ret;
> @@ -217,6 +230,9 @@ static int max31856_read_raw(struct iio_dev *indio_dev,
>                         return IIO_VAL_INT_PLUS_MICRO;
>                 }
>                 break;
> +       case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +               *val = 1 << data->averaging;
> +               return IIO_VAL_INT;
>         default:
>                 ret = -EINVAL;
>                 break;
> @@ -225,6 +241,33 @@ static int max31856_read_raw(struct iio_dev *indio_dev,
>         return ret;
>  }
>
> +static int max31856_write_raw(struct iio_dev *indio_dev,
> +                             struct iio_chan_spec const *chan,
> +                             int val, int val2, long mask)
> +{
> +       struct max31856_data *data = iio_priv(indio_dev);
> +       int msb;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +               if (val > 16 || val < 1)
> +                       return -EINVAL;
> +               msb = fls(val) - 1;
> +               /* Round up to next 2pow if needed */
> +               if (BIT(msb) < val)
> +                       msb++;
> +
> +               data->averaging = msb;
> +               max31856_init(data);
> +               break;
> +
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  static ssize_t show_fault(struct device *dev, u8 faultbit, char *buf)
>  {
>         struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -313,6 +356,7 @@ static const struct attribute_group max31856_group = {
>
>  static const struct iio_info max31856_info = {
>         .read_raw = max31856_read_raw,
> +       .write_raw = max31856_write_raw,
>         .attrs = &max31856_group,
>  };
>
> --
> 2.17.1
>
