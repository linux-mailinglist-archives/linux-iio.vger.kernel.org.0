Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B0C23112D
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 20:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732106AbgG1SAt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 14:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgG1SAt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 14:00:49 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0C7C061794;
        Tue, 28 Jul 2020 11:00:49 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e8so12372566pgc.5;
        Tue, 28 Jul 2020 11:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WBMNQPtnD6I/Bgjj59itOH+RfUB46B6TUxAPGjL81xo=;
        b=IHA2HtpYwZRdI9rWn3foDft2ZgajkzMQh+/TUcg4uXGGjVeTs1IXQB8j+rvbAIL5mW
         fRBO+bKx1oFVa3U4eBAkeOFkbr7mK/a78Oas6s8dhCUdM0hamZV6ooB7MLBP/V1+m+a1
         FnJ1bKBrnan16aQqcmYbo9J7nieuSoi7VEjpvDiw8J442F8hBbxbtfsLl8jNnUza7Iou
         E0XAa4QFW9ybNkMhbNxhM5ocY4PiBiDgQtxLwLm4kM7HBhenkAVLdN5R5IxIHYxAwm86
         fsa30wcjMXUP0Ltm/eYmASegEijf4xupLVl/TA/b8rGoBGBP8E0tK2M/TJaD5NdDEzW+
         Sf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WBMNQPtnD6I/Bgjj59itOH+RfUB46B6TUxAPGjL81xo=;
        b=Ff5s0YOdg9m29zKjphl/hBHdhEk/GWTJo8T7JFWNQQRHJpnbIpw1zKtKA7V7CNTEVs
         YxLBhFbavZDCfEDyDQbKqJYEGMCAtg6di3j51O6eix3qn2ip5PMOpy6s215fEA2wrbME
         2kWh4AF4f2T+Nsd8p+IkDee8ylLln1iRi5j7Mevw6c9Gqy9PQ08U00Ln6Ny2xYBC4Cfd
         snqt69xw58y5X69U8VisQ6YARIh9ECP/8CxqlQKNssxgsbt10T4yxXIVPRLH36xnXnRd
         m4aBBV4eaYxGhyhXcYDlw+vQVmEFOTstVspC2mgowGdiQDhNgsPCD68zY1y+L9YYiWqm
         vbAw==
X-Gm-Message-State: AOAM532XczNWb6Hkl3ibPkexhIpWGKXZtCNnmLhktBXUL11h6gDxqx/f
        eyPlryk7U3I8zuNbfFLJTlmF3sBsRwLV7UT+nys=
X-Google-Smtp-Source: ABdhPJyiAtuFbtqD5eCvDcXIbqXe9z2InMqBoNc+jv75qq/uJxDlEGSRbLKi3QDdUpZXY/lFGKdEfejpknc6e/Iy8JU=
X-Received: by 2002:a63:ce41:: with SMTP id r1mr26129721pgi.203.1595959248698;
 Tue, 28 Jul 2020 11:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200728062831.1143-1-ceggers@arri.de> <20200728062831.1143-3-ceggers@arri.de>
In-Reply-To: <20200728062831.1143-3-ceggers@arri.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jul 2020 21:00:31 +0300
Message-ID: <CAHp75Vcz1kv_xhaRZMdK21KrkAbeBLE3evJNsjA2yMa=V0Yb0g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: light: as73211: New driver
To:     Christian Eggers <ceggers@arri.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 28, 2020 at 9:32 AM Christian Eggers <ceggers@arri.de> wrote:
>
> Support for AMS AS73211 JENCOLOR(R) Digital XYZ Sensor.
>
> This driver has no built-in trigger. In order for making triggered
> measurements, an external (software) trigger driver like
> iio-trig-hrtimer or iio-trig-sysfs is required.
>
> The sensor supports single and continuous measurement modes. The latter
> is not used by design as this would require tight timing synchronization
> between hardware and driver without much benefit.

...

> +/*

> + * as73211.c - Support for AMS AS73211 JENCOLOR(R) Digital XYZ Sensor

No need to have a filename in the very file.

> + *
> + * Author: Christian Eggers <ceggers@arri.de>
> + *
> + * Copyright (c) 2020 ARRI Lighting
> + *
> + * Color light sensor with 16-bit channels for red, green, blue, clear);
> + * 7-bit I2C slave address 0x74 .. 0x77.
> + *

> + * Datasheet: https://ams.com/documents/20143/36005/AS73211_DS000556_3-01.pdf/a65474c0-b302-c2fd-e30a-c98df87616df

Can you also put it in the same form in the tag block of the commit message?

> + *
> + */

...

> +#define AS73211_OSR_DOS_MASK      (0x7 << AS73211_OSR_DOS_SHIFT)

GENMASK()

...

> +#define AS73211_AGEN_DEVID_MASK   (0xf << AS73211_AGEN_DEVID_SHIFT)

Ditto for all _MASK definitions.

...

> +
> +

One blank line is enough.

> +/**
> + * struct as73211_data - Instance data for one AS73211
> + * @client: I2C client.
> + * @osr:    Cached Operational State Register.
> + * @creg1:  Cached Configuration Register 1.
> + * @creg2:  Cached Configuration Register 2.
> + * @creg3:  Cached Configuration Register 3.
> + * @buffer: Buffer for triggered measurements.

> + * @mutex:  Device mutex. N.B: We do not use iio_dev::mlock because we need to
> + *          change device properties while in buffered mode.

I'm wondering if we have an established way to refer to fields in
other structures in kernel doc.

> + * @completion: Completion to wait for interrupt.
> + */

...

> +static unsigned int as73211_integration_time_cycles(struct as73211_data *data)
> +{
> +       return 1 << (data->creg1 & AS73211_CREG1_TIME_MASK);

BIT() ?

> +}

...

> +/* return current integration time (in us) */

Useless comment

> +static unsigned int as73211_integration_time_us(struct as73211_data *data)
> +{
> +       /* Integration time has 15 steps, the step size depends on the clock. */
> +       unsigned int mul = 1 << (3 - (data->creg3 & 0b11));  /* 8 = 1.024 MHz, 4 = 2.048 MHz ...*/

BIT() ?

0b11?! 0x3 would work, but shouldn't be defined via GENMASK()  or alike?

> +       unsigned int time_cycles = as73211_integration_time_cycles(data);
> +       unsigned int time_us = time_cycles * 125 * mul;
> +
> +       return time_us;

return  as73211_...(...) * 125 * mul;

> +}

...

> +/* return gain (1, 2, 4, 8, ...) */

Ditto. (Applies for all such)

> +static unsigned int as73211_gain(struct as73211_data *data)
> +{
> +       return 1 << (0b1011 - (data->creg1 >> AS73211_CREG1_GAIN_SHIFT));
> +}

Similar comments. Also applies to the rest.

> +/* must be called with as73211_data::mutex held. */
> +static int as73211_req_data(struct as73211_data *data)
> +{
> +       unsigned int time_us = as73211_integration_time_us(data), ret;

Please, split to separate lines.
Esp. wrong type for ret.

> +       union i2c_smbus_data smbus_data;
> +       s32 osr_status;
> +
> +       if (data->client->irq)

> +               init_completion(&data->completion);

I believe it should be reinit_completion().

> +       /* During measurement, there should be no traffic on the i2c bus */

> +       i2c_lock_bus(data->client->adapter, I2C_LOCK_SEGMENT);

Hmm.. Really?

> +       data->osr &= ~AS73211_OSR_DOS_MASK;
> +       data->osr |= AS73211_OSR_DOS_MEASURE | AS73211_OSR_SS;
> +
> +       smbus_data.byte = data->osr;
> +       ret = __i2c_smbus_xfer(data->client->adapter, data->client->addr,
> +                       data->client->flags, I2C_SMBUS_WRITE,
> +                       AS73211_REG_OSR, I2C_SMBUS_BYTE_DATA, &smbus_data);
> +       if (ret) {
> +               i2c_unlock_bus(data->client->adapter, I2C_LOCK_SEGMENT);
> +               return ret;
> +       }
> +
> +       /* Reset AS73211_OSR_SS (is self clearing) in order to avoid unintentional
> +        * triggering of further measurements later.
> +        */

Comment style.

> +       data->osr &= ~AS73211_OSR_SS;
> +
> +       /* Add some extra margin for the timeout. sensor timing is not as precise
> +        * as our one ...
> +        */
> +       time_us += time_us / 8;
> +       if (data->client->irq) {
> +               dev_dbg(&data->client->dev, "%s(): Waiting for completion...\n", __func__);
> +               ret = wait_for_completion_timeout(&data->completion,
> +                                       2 + usecs_to_jiffies(time_us));
> +               if (!ret) {

> +                       dev_err(&data->client->dev,

struct device = &data->client->dev;
will save you some LOCs here and there.

> +                               "timeout waiting for READY IRQ\n");
> +                       i2c_unlock_bus(data->client->adapter, I2C_LOCK_SEGMENT);
> +                       return -ETIMEDOUT;
> +               }
> +       } else {
> +               /* Wait integration time */
> +               dev_dbg(&data->client->dev, "%s(): Sleeping %d us\n", __func__, time_us);

Please, drop __func__ from dev_dbg() calls. It duplicates Dynamic
Debug functionality. And TBH these are quite useless if you know how
to use ftrace, perf, etc.

> +               usleep_range(time_us, time_us + 100000);
> +       }
> +
> +       i2c_unlock_bus(data->client->adapter, I2C_LOCK_SEGMENT);
> +
> +       osr_status = i2c_smbus_read_word_data(data->client, AS73211_OUT_OSR_STATUS);
> +       if (osr_status < 0) {
> +               ret = osr_status;
> +               return ret;
> +       }
> +
> +       dev_dbg(&data->client->dev, "%s: osr_status = 0x%04x\n", __func__, osr_status);
> +       if (osr_status != (AS73211_OSR_DOS_MEASURE | AS73211_OSR_STATUS_NDATA)) {
> +               if (osr_status & AS73211_OSR_SS) {
> +                       dev_warn(&data->client->dev, "%s() Measurement has not stopped\n",
> +                                       __func__);
> +                       return -ETIME;
> +               }
> +               if (osr_status & AS73211_OSR_STATUS_NOTREADY) {
> +                       dev_warn(&data->client->dev, "%s() Data is not ready\n", __func__);
> +                       return -ENODATA;
> +               }
> +               if (!(osr_status & AS73211_OSR_STATUS_NDATA)) {
> +                       dev_warn(&data->client->dev, "%s() New new data available\n", __func__);
> +                       return -ENODATA;
> +               }
> +               if (osr_status & AS73211_OSR_STATUS_LDATA) {
> +                       dev_warn(&data->client->dev, "%s() Result buffer overrun\n", __func__);
> +                       return -ENOBUFS;
> +               }
> +               if (osr_status & AS73211_OSR_STATUS_ADCOF) {
> +                       dev_warn(&data->client->dev, "%s() ADC overflow\n", __func__);
> +                       return -EOVERFLOW;
> +               }
> +               if (osr_status & AS73211_OSR_STATUS_MRESOF) {
> +                       dev_warn(&data->client->dev, "%s() Measurement result overflow\n",
> +                                       __func__);
> +                       return -EOVERFLOW;
> +               }
> +               if (osr_status & AS73211_OSR_STATUS_OUTCONVOF) {
> +                       dev_warn(&data->client->dev, "%s() Timer overflow\n", __func__);
> +                       return -EOVERFLOW;
> +               }
> +               dev_warn(&data->client->dev, "%s() Unexpected status value\n", __func__);
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}

...

> +               *val = (1 << (data->creg3 & 0b11)) * 1024 * 1000;

BIT()? GENMASK() ? 1000 I believe defined already.

...

> +       }
> +       }  // switch (mask)

Strange indentation and useless comment.

I guess better to have something like

switch () {
  ...
case X: {
  ...
}}

...

> +       if (*indio_dev->active_scan_mask == 0xf) {

Magic!

...

> +                       /* saturate all channels (useful for overflows) */
> +                       iio_buffer[1] = 0xffff;
> +                       iio_buffer[2] = 0xffff;
> +                       iio_buffer[3] = 0xffff;

Magic!

...

> +       else if (*indio_dev->active_scan_mask == 0xe) {

Ditto.

...

> +static ssize_t as73211_show_samp_freq_available(
> +               struct device *dev __always_unused,
> +               struct device_attribute *attr __always_unused,
> +               char *buf)
> +{
> +       size_t len = 0;
> +       int i;
> +
> +       for (i = 0; i < 4; i++) {
> +               len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> +                       (1 << (i + 10)) * 1000);
> +       }
> +
> +       /* replace trailing space by newline */
> +       buf[len - 1] = '\n';
> +
> +       return len;
> +}

Repetition of IIO core functionality?

Ditto question for the other similar functions.

...

> +                       struct i2c_device_id const *id __always_unused)

And why it's not a ->probe_new()?

...

> +       if (indio_dev == NULL)

if (!indio_dev)

> +               return -ENOMEM;

...

> +       if ((ret >> AS73211_AGEN_DEVID_SHIFT) == 0b0010)
> +               dev_info(&client->dev, "AS73211 found\n");
> +       else
> +               return -ENODEV;

Other way around (usual pattern)

err = ...
if (err) {
  ...
}

But that message is simple spam and noise in the log.

...

> +#ifdef CONFIG_PM_SLEEP

__maybe_unused

> +static int as73211_suspend(struct device *dev)
> +{

> +}
> +
> +static int as73211_resume(struct device *dev)
> +{

> +}
> +#endif

...


> +#ifdef CONFIG_OF

Dtop it.

> +static const struct of_device_id as73211_of_match[] = {

> +       {
> +               .compatible = "ams,as73211",
> +       },

Can be one line.

> +       {},

No comma here

> +};
> +MODULE_DEVICE_TABLE(of, as73211_of_match);
> +#else
> +#define as73211_of_match NULL
> +#endif

...

> +static struct i2c_driver as73211_driver = {
> +       .driver = {
> +               .name           = AS73211_DRV_NAME,

> +               .of_match_table = of_match_ptr(as73211_of_match),

Drop of_match_ptr().

> +               .pm             = &as73211_pm_ops,
> +       },
> +       .probe          = as73211_probe,
> +       .remove         = as73211_remove,
> +       .id_table       = as73211_id,
> +};
> +module_i2c_driver(as73211_driver);

-- 
With Best Regards,
Andy Shevchenko
