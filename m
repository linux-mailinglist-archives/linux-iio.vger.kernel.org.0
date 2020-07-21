Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBEB2289FC
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 22:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgGUUfR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 16:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728606AbgGUUfR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2020 16:35:17 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D63C061794;
        Tue, 21 Jul 2020 13:35:17 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l63so12456206pge.12;
        Tue, 21 Jul 2020 13:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H2rlhi44PP/yGILmVfXDfaXGTcLk3tY2rxvlC2hr1ng=;
        b=c7ci4Ua/7LOBYP/R/an9KQ0sHvxaJAXFrSsrT3yazooggq8gZDlgmLkGzoRwpYAxNj
         C6F8TRui+arKmOUHwDPBrEFSrPapzUJObU/fwrDIv41D9Pm2Qc1FhugBx5k2Iz2L9bMM
         QFBLvFUmJpfZttdCPAajbf+ZsU0k3e82CuNyAW52I9Zg8tcQcEArWRq2t0vI8JL1M9zp
         eJG2HdwWAj1xd7WtOZwRcNnJlLQdCC+Hq8rFwBH14hiluT//5Gdl9KKH9/jFiOchshET
         7ZImaWDYp+ktu3oM0dtrvCCG2fhoNkeFlVNYAYc3hO0467i0F86qMf/eHCg3XFCjAlwC
         zuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H2rlhi44PP/yGILmVfXDfaXGTcLk3tY2rxvlC2hr1ng=;
        b=p3x4vPHeb72h1YR1w4ULL7TpM1ZtfU+5e+9nyvK6+t/lvtw302ttXylkQOFQJvwWjo
         dbw7ccQhwd7As3ElUY1/MzJFDpPAtegOVk0Dt/OAkcBLqOLlGDUAFejzRa1QrkyKmPha
         dFJldkNzA0Z05GXWe9MOCQuMnfe0pR2LJlZK1MFiKintYiaViVu8aoVXipinO6C8gJjW
         0nod2qff8IxKaGItX/xQ81JJTtcUjFuQnmKqRAfMh7VKGYxQCezrhkgO7x4f4Nyf4FtU
         7qXQ/ccoLcANr3jck53bJj3JSZdq2tuPgX8lVRVoHKA5CtFay6/qmyngP9p7eHFiQOWh
         w8gA==
X-Gm-Message-State: AOAM531RsFYf1yHckgLxg0UBn5PyVZaFkx95kb3O4ETF6kCQPc1qHTtW
        WYn5WIbumbzZx/0s24Wf/EzqXrNK
X-Google-Smtp-Source: ABdhPJyhqOcYNtd5vksn2vWZzTK+6YDHifO80UBVUzQovhdMF5nT3BelgrNB8ZAXNiqdNDc3PIVqww==
X-Received: by 2002:a63:ab4f:: with SMTP id k15mr24489873pgp.247.1595363716278;
        Tue, 21 Jul 2020 13:35:16 -0700 (PDT)
Received: from ?IPv6:2409:4072:593:314e:d028:8959:a8a3:a7bc? ([2409:4072:593:314e:d028:8959:a8a3:a7bc])
        by smtp.gmail.com with ESMTPSA id w64sm19528075pgd.67.2020.07.21.13.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 13:35:15 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] iio: gyro: Add driver support for ADXRS290
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        darius.berghe@analog.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
References: <20200721181926.27046-1-nish.malpani25@gmail.com>
 <CAHp75Vdr+Uo2uw3mzYP+LMRgp-eyi+YjG=O+wGVqyYx-+MRCaw@mail.gmail.com>
From:   Nishant Malpani <nish.malpani25@gmail.com>
Message-ID: <7ba8469a-dd8c-1686-6d26-e2a4cbfedce9@gmail.com>
Date:   Wed, 22 Jul 2020 02:05:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vdr+Uo2uw3mzYP+LMRgp-eyi+YjG=O+wGVqyYx-+MRCaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Andy,

Thanks for the review. Comments inline...

On 22/07/20 1:16 am, Andy Shevchenko wrote:
> On Tue, Jul 21, 2020 at 9:20 PM Nishant Malpani
> <nish.malpani25@gmail.com> wrote:
>>
>> ADXRS290 is a high performance MEMS pitch and roll (dual-axis in-plane)
>> angular rate sensor (gyroscope) designed for use in stabilization
>> applications. It also features an internal temperature sensor and
>> programmable high-pass and low-pass filters.
>>
>> Add support for ADXRS290 in direct-access mode for now.
> 
>> Datasheet:
>> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXRS290.pdf
> 
> Drop that 'Link:' part and followed blank line, so get something like
> 
> Datasheet: https://...
> Signed-off-by: ...
> 
Okay. Will fix in v3.

>> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
> 
> ...
> 
>> +config ADXRS290
>> +       tristate "Analog Devices ADXRS290 Dual-Axis MEMS Gyroscope SPI driver"
>> +       depends on SPI
>> +       help
>> +         Say yes here to build support for Analog Devices ADXRS290 programmable
>> +         digital output gyroscope.
>> +
>> +         This driver can also be built as a module. If so, the module will be
>> +         called adxrs290.
> 
> 
>> +enum adxrs290_mode {
>> +       STANDBY,
>> +       MEASUREMENT,
>> +};
> 
>> +struct adxrs290_state {
>> +       struct spi_device       *spi;
>> +       /* Serialize reads and their subsequent processing */
>> +       struct mutex            lock;
>> +       enum adxrs290_mode      mode;
>> +       unsigned int            lpf_3db_freq_idx;
>> +       unsigned int            hpf_3db_freq_idx;
>> +};
> 
> ...
> 
>> +/*
>> + * Available cut-off frequencies of the low pass filter in Hz.
>> + * The integer part and fractional part are represented separately.
>> + */
> 
>> +static const int adxrs290_lpf_3db_freq_tbl[][2] = {
> 
> What about adxrs290_lpf_3db_freq_hz_table ?
> 
Sure, makes it very precise. Will address in v3.

>> +};
>> +
>> +/*
>> + * Available cut-off frequencies of the high pass filter in Hz.
>> + * The integer part and fractional part are represented separately.
>> + */
>> +static const int adxrs290_hpf_3db_freq_tbl[][2] = {
> 
> Ditto.
> 
Yes.

>> +};
> 
> ...
> 
>> +static int adxrs290_get_rate_data(struct iio_dev *indio_dev, const u8 cmd,
>> +                                 unsigned int *val)
>> +{
>> +       struct adxrs290_state *st = iio_priv(indio_dev);
> 
>> +       int ret = 0;
> 
> Purpose of this?
>
'ret' will not be initialized if a successful spi_w8r16() takes place 
i.e if it doesn't go into the 'if' block. (Doesn't make sense to have it 
now since the below block of code is erroneous, but will need this in v3).

>> +       u16 temp;
>> +
>> +       mutex_lock(&st->lock);
>> +       temp = spi_w8r16(st->spi, cmd);
> 
>> +       if (temp < 0) {
> 
> How can this ever happen?
> 
Oops, you're right. Even though spi_w8r16() returns a negative error 
code on failure, 'temp' is declared unsigned. Thanks for pointing out. 
Will fix in v3.

>> +               ret = temp;
>> +               goto err_unlock;
>> +       }
>> +
>> +       *val = temp;
>> +
>> +err_unlock:
>> +       mutex_unlock(&st->lock);
>> +       return ret;
>> +}
> 
> Ditto for the rest of the similar cases.
>
Sure.

> ...
> 
>> +       case IIO_CHAN_INFO_SCALE:
>> +               switch (chan->type) {
>> +               case IIO_ANGL_VEL:
>> +                       *val = 0;
> 
> 
>> +                       *val2 = 87266;
> 
> Magic!
> 
Haha, will add comments in v3!

>> +                       return IIO_VAL_INT_PLUS_NANO;
>> +               case IIO_TEMP:
> 
>> +                       *val = 100;
> 
> Magic!
> 
Will add comments in v3.

>> +                       return IIO_VAL_INT;
>> +               default:
>> +                       return -EINVAL;
>> +               }
> 
> ...
> 
>> +               *vals = (const int *)adxrs290_lpf_3db_freq_tbl;
> 
> Why casting?
> 
adxrs290_lpf_3db_freq_tbl is of type (int *)[2], right? Without the 
casting, an incompatible-pointer-type error is thrown.

> ...
> 
>> +               *vals = (const int *)adxrs290_hpf_3db_freq_tbl;
> 
> Ditto.
> 
See above comment.

> ...
> 
> 
>> +       struct iio_dev *indio_dev;
>> +       struct adxrs290_state *st;
> 
>> +       int ret;
>> +       u8 val, val2;
> 
> Swap them to have in reversed spruce tree order.
> 
Okay, will do so in v3.

> ...
> 
>> +       indio_dev->dev.parent = &spi->dev;
> 
> Do you need this?
Oh, right (I'm aware of Alexandru's recent patch on this). Will address 
in v3.

> 
>> +       /* max transition time to measurement mode */
>> +       msleep_interruptible(ADXRS290_MAX_TRANSITION_TIME_MS);
> 
> I'm not sure what the point of interruptible variant here?
> 
I referred Documentation/timers/timers-howto.rst for this.
My reasoning was shaped to use the interruptible variant because the 
transition settles in a time *less than* 100ms and since 100ms is quite 
a huge time to sleep, it should be interrupted in case a signal arrives.

> ...
> 
>> +static const struct of_device_id adxrs290_of_match[] = {
>> +       { .compatible = "adi,adxrs290" },
> 
>> +       { },
> 
> No comma here!
> 
Okay. Will remove in v3.

With regards,
Nishant Malpani

>> +};
> 
