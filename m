Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F79382834
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 11:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbhEQJYV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 05:24:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33601 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235544AbhEQJYU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 May 2021 05:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621243384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Jo0PG+9A7IMnQJQIDbkVjlphN+bvQx89POlPZYb6Jc=;
        b=YezAW7iFProsOcosmWmSda+qZWygHgAuLvQuupCa7MWeIXTU1jTv1dQTncGnpr69GRDuYG
        psf2gmky/CkJOIKdwGJ6RLsDvUDV320NaHCiXi5XsedH8HsSKQxi8YoLuTzU8F4yzAhn77
        pBmSasxbwHsadhodBzXk3lzuE7ccbC8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-ZPiGqt7oPAi6ZdSX90cEEQ-1; Mon, 17 May 2021 05:23:02 -0400
X-MC-Unique: ZPiGqt7oPAi6ZdSX90cEEQ-1
Received: by mail-ed1-f71.google.com with SMTP id q18-20020a50cc920000b029038cf491864cso3550959edi.14
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 02:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Jo0PG+9A7IMnQJQIDbkVjlphN+bvQx89POlPZYb6Jc=;
        b=hnvD5beNVKiuG6ydOCAr/2dKb9tDQkFPX6cWktRfaBBI31fGP+OC7pbtohafPR+9ck
         tsiedyQKt9idLLxjb1AmPy4LSVZTpSQrMFnXDKNBxd9S+4eVcKszKk5YlkvEzji25qKw
         qtEVFdIMTiuFFuct/8IFJLmCWfZzS17yB/IIGQxNVN4JRqJ6LqRM/ttX9Sc3UVp9jWZg
         1eDpaH4HZGN5R6TQr/yKaNZQb4NEDrHUmVWUoUuABp56NwhWkhIhRkZJLdZwtHqF91SF
         KX68hdHt9cdKAJ2NaRgRh/rQcJaxld+OKlgpdvKzbrtUbLfA3zaKoUYlDRbdF/YVmYDf
         mMUw==
X-Gm-Message-State: AOAM532SBChPMEJkhSlIIXxjspbCI9Ks0LjxADfsw6t9Cg3VIcPJDg8t
        q/8lqhjfkJjKSQIeotAXXwUToNxqLY3OsnVXfgFrO4SITGJvkId4NlM2lla2wgAliBWUUc8mXpE
        9CA6xG8LN1OFy5ymJ2s20
X-Received: by 2002:a17:907:264d:: with SMTP id ar13mr9512107ejc.279.1621243381820;
        Mon, 17 May 2021 02:23:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0sR3wIml+uxupA2G/ZI2clN6nNS7AqKTON8c4D3fpCCcfSs4uzrZwQDMIECbZZ+QEtSXEZA==
X-Received: by 2002:a17:907:264d:: with SMTP id ar13mr9512091ejc.279.1621243381679;
        Mon, 17 May 2021 02:23:01 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id p7sm2469627edw.43.2021.05.17.02.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 02:23:01 -0700 (PDT)
Subject: Re: [PATCH] iio: accel: st_sensors: Support generic mounting matrix
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Daniel Drake <drake@endlessm.com>
References: <20210515000058.204601-1-linus.walleij@linaro.org>
 <CAHp75Ve-dNqKprs-qsEDbKtZAh74Tdvbggwj5p6W9Akt1=01FQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fc19cd14-6909-c88b-3fa1-84128b86221a@redhat.com>
Date:   Mon, 17 May 2021 11:23:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve-dNqKprs-qsEDbKtZAh74Tdvbggwj5p6W9Akt1=01FQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 5/17/21 9:46 AM, Andy Shevchenko wrote:
> On Sat, May 15, 2021 at 6:17 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> The ST accelerators support a special type of quirky
>> mounting matrix found in ACPI systems, but not a generic
>> mounting matrix such as from the device tree.
>>
>> Augment the ACPI hack to be a bit more generic and
>> accept a mounting matrix from device properties.
>>
>> This makes it possible to fix orientation on the Ux500
>> HREF device.
> 
> I think this entire thread may be interesting to Hans, hence Cc him.

Thanks I'm fine with the suggested change, but I've some
review marks below (inline).

> 
> 
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: Denis Ciocca <denis.ciocca@st.com>
>> Cc: Daniel Drake <drake@endlessm.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>>  drivers/iio/accel/st_accel_core.c | 51 ++++++++++++++++++++-----------
>>  1 file changed, 34 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
>> index 43c50167d220..cfbcf740e3cb 100644
>> --- a/drivers/iio/accel/st_accel_core.c
>> +++ b/drivers/iio/accel/st_accel_core.c
>> @@ -1069,26 +1069,25 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
>>  #define ST_ACCEL_TRIGGER_OPS NULL
>>  #endif
>>
>> -#ifdef CONFIG_ACPI
>>  static const struct iio_mount_matrix *
>> -get_mount_matrix(const struct iio_dev *indio_dev,
>> -                const struct iio_chan_spec *chan)
>> +st_accel_get_mount_matrix(const struct iio_dev *indio_dev,
>> +                         const struct iio_chan_spec *chan)
>>  {
>>         struct st_sensor_data *adata = iio_priv(indio_dev);
>>
>>         return adata->mount_matrix;
>>  }
>>
>> -static const struct iio_chan_spec_ext_info mount_matrix_ext_info[] = {
>> -       IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, get_mount_matrix),
>> +static const struct iio_chan_spec_ext_info st_accel_mount_matrix_ext_info[] = {
>> +       IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, st_accel_get_mount_matrix),
>>         { },
>>  };
>>
>> +#ifdef CONFIG_ACPI
>>  /* Read ST-specific _ONT orientation data from ACPI and generate an
>>   * appropriate mount matrix.
>>   */
>> -static int apply_acpi_orientation(struct iio_dev *indio_dev,
>> -                                 struct iio_chan_spec *channels)
>> +static int apply_acpi_orientation(struct iio_dev *indio_dev)
>>  {
>>         struct st_sensor_data *adata = iio_priv(indio_dev);
>>         struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
>> @@ -1207,22 +1206,20 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev,
>>                 }
>>         }
>>
>> -       /* Expose the mount matrix via ext_info */
>> -       for (i = 0; i < indio_dev->num_channels; i++)
>> -               channels[i].ext_info = mount_matrix_ext_info;
>> -
>>         ret = 0;
>>         dev_info(&indio_dev->dev, "computed mount matrix from ACPI\n");
>>
>>  out:
>>         kfree(buffer.pointer);
>> +       dev_warn(&indio_dev->dev,
>> +                "failed to apply ACPI orientation data: %d\n", ret);
>> +

This path is also taken on a successful return, so the dev_warn needs
to be guarded by a "if (ret)" condition.

>>         return ret;
>>  }
>>  #else /* !CONFIG_ACPI */
>> -static int apply_acpi_orientation(struct iio_dev *indio_dev,
>> -                                 struct iio_chan_spec *channels)
>> +static int apply_acpi_orientation(struct iio_dev *indio_dev)
>>  {
>> -       return 0;
>> +       return -EINVAL;
>>  }
>>  #endif
>>
>> @@ -1251,6 +1248,7 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
>>         struct iio_chan_spec *channels;
>>         size_t channels_size;
>>         int err;
>> +       int i;
>>
>>         indio_dev->modes = INDIO_DIRECT_MODE;
>>         indio_dev->info = &accel_info;
>> @@ -1275,9 +1273,28 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
>>                 goto st_accel_power_off;
>>         }
>>
>> -       if (apply_acpi_orientation(indio_dev, channels))
>> -               dev_warn(&indio_dev->dev,
>> -                        "failed to apply ACPI orientation data: %d\n", err);
>> +       /* First try ACPI orientation then try the generic function */
>> +       err = apply_acpi_orientation(indio_dev);
>> +       if (err) {
>> +               adata->mount_matrix = devm_kmalloc(&indio_dev->dev,
>> +                                                  sizeof(*adata->mount_matrix),
>> +                                                  GFP_KERNEL);
>> +               if (!adata->mount_matrix) {
>> +                       err = -ENOMEM;
>> +                       goto st_accel_power_off;
>> +               }

So now we to this devm_kmalloc both in apply_acpi_orientation() if it succeeds
as well as here if apply_acpi_orientation() fails. It would be better to just
stop kmallocing it all together in both places and just embed the struct in adata,
iow make adata->mount_matrix be the actual iio_mount_matrix struct, rather then
a pointer to it.

This will allow removing the 2 devm_kmalloc calls + their error handling.

Regards,

Hans



>> +
>> +               err = iio_read_mount_matrix(adata->dev, "mount-matrix",
>> +                                           adata->mount_matrix);
>> +               if (err)
>> +                       goto st_accel_power_off;
>> +       }
>> +       /*
>> +        * We have at least an identity matrix, so expose the mount
>> +        * matrix via ext_info
>> +        */
>> +       for (i = 0; i < indio_dev->num_channels; i++)
>> +               channels[i].ext_info = st_accel_mount_matrix_ext_info;
>>
>>         indio_dev->channels = channels;
>>         adata->current_fullscale = &adata->sensor_settings->fs.fs_avl[0];
>> --
>> 2.31.1
>>
> 
> 

