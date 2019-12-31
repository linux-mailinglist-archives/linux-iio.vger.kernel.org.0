Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 984E212D72D
	for <lists+linux-iio@lfdr.de>; Tue, 31 Dec 2019 09:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfLaI6G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Dec 2019 03:58:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42088 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfLaI6G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Dec 2019 03:58:06 -0500
Received: by mail-pf1-f195.google.com with SMTP id 4so19493400pfz.9;
        Tue, 31 Dec 2019 00:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ZTbILHgjavD8pUQVlTkHTCm6k/5J8XxDjruksnhX6fc=;
        b=CP/jy2f+cM56C7UbqfRK/2wtYOg5IEjJGY5dBfcHwlI7jeNpyydAESg1XlnW7/v0oV
         RczuUStwOmSgrY6zS7cw2JpJQkJXq1ltUq11eBruB3YXon2ItzsYJr4nECYmOEir7hgj
         3ZWfvgtBh+Txkv9J4VxoSULYETV53CtOSN2tmf/OcbgrUsNEYps8NdXM7ibSDZ9B9AGv
         /a7dBY+7NhYvXlKCEMOirQ8tYJblQ1vNalomPUyD4PGE1oXTMPdmoWP+gwH1wJkjjDx/
         zgv+enR8Wy5LnChCA0gW62IyzEUj5uVTLCilKabR7232SIF4AGc7bJjHcsvvOf5rsSV7
         TTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ZTbILHgjavD8pUQVlTkHTCm6k/5J8XxDjruksnhX6fc=;
        b=PAO7Jr4baaRpIraPf2OHTESSqLUpCFT3edzou662YXNpcnDbX+8KRds7wAHvGdBiqQ
         zcLDpXPF76eX9J37D2TIXlzKrw3t9ut7laIX63TFPnuflw3JhQmMFpUcfFexEQ7mX9GS
         nh1IvQDrqFBQxynmtQ94YpZasiRiFBUyt2MmLFdOw8w0l5ZLPdpNDWZ/xTTlsDYWE25P
         yFYNQY7RogPmBud9rUnHEyfqGDZSaW0cwBmgYWxlo5vTbk7U5cIds+hog2A/V1eLGw4H
         hOQXUHoZUy33C8OtA8eW3iETsVSLIdUQdZSmMokD4YkeHtFRdYgqEPjvIR6C/LWadhPv
         1cSg==
X-Gm-Message-State: APjAAAWu5Kjpxlbm8PsEoVGQWEVjRJK1JdKWVCZEmWCTLzBuS7EVQvCd
        lMRo1Xh2AUflCeYdw7Thg/Ah87ua
X-Google-Smtp-Source: APXvYqxTXDW+ncszbLBICFTsb1alLkn5gAdkMafqnX8QwRaT5rVvmlkEpP7p5HbGcgkJq/L8y4zUow==
X-Received: by 2002:a63:6e0e:: with SMTP id j14mr75608458pgc.361.1577782684680;
        Tue, 31 Dec 2019 00:58:04 -0800 (PST)
Received: from [0.0.0.0] ([103.103.128.212])
        by smtp.gmail.com with ESMTPSA id n26sm53678434pgd.46.2019.12.31.00.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Dec 2019 00:58:03 -0800 (PST)
Subject: Re: [PATCH v2 1/2] iio: chemical: add support for Dynament Premier
 series single gas sensor
To:     Matt Ranostay <matt.ranostay@konsulko.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Tomasz Duszynski <tduszyns@gmail.com>, mike.looijmans@topic.nl,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <3a17c9e1-f916-0cde-3296-70066dccb2b3@gmail.com>
 <FA803BE2-2715-4F63-8F5B-3A57F700AB1B@konsulko.com>
 <20191223160712.1e1cfcde@archlinux>
 <CAJCx=gk6s=VN9V_BDAr-SXPz1ZU0N6j4KUZbUnZ=gdKqOddupA@mail.gmail.com>
From:   YuDong Zhang <mtwget@gmail.com>
Message-ID: <22a26e68-9d0c-60d3-47da-5124402f5f41@gmail.com>
Date:   Tue, 31 Dec 2019 16:57:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAJCx=gk6s=VN9V_BDAr-SXPz1ZU0N6j4KUZbUnZ=gdKqOddupA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


在 2019/12/31 13:50, Matt Ranostay 写道:
> On Tue, Dec 24, 2019 at 12:07 AM Jonathan Cameron <jic23@kernel.org> wrote:
>> On Tue, 17 Dec 2019 21:17:43 -0800
>> Matt Ranostay <matt.ranostay@konsulko.com> wrote:
>>
>>>> On Dec 17, 2019, at 17:52, ruantu <mtwget@gmail.com> wrote:
>>>>
>>>> ﻿On Tue, Dec 17, 2019 at 2:24 AM YuDong Zhang <mtwget@gmail.com> wrote:
>>>>>> Add support for Dynament Premier series single gas sensor.
>>>>>>
>>>>> Just looking the Dynament site and I assume this is for the OEM-1
>>>>> Development kit? If so you probably should
>>>>> note that in the documentation because the sensors themselves are
>>>>> likely to be used in other end products (and not
>>>>> always the dev kit)
>>>>>
>>>>> Also bit of silly question this is an UART device so why not do
>>>>> processing in userspace? :)
>>>>>
>>>>> - Matt
>>>> This is a driver implemented according to the <Dynamization Sensor
>>>> Communications protocol>. I think the protocol is standard. This is
>>>> the idea that emerged after the iio subsystem used serial_bus.
>>> Well egg on my face since only got recently back on this mailing
>>> list.... looks good over all but the floating point to fixed point
>>> stuff maybe has some comments. Also I am on holiday till the New Year
>>> but please CC on future changes!
>> The question about whether to allow serial bus drivers in IIO wasn't
>> entirely obvious so reasonable to raise it.  There is a long tradition
>> of doing serial bus drivers only in userspace.  However, there is
>> nothing fundamentally different about them from spi or i2c drivers.
>>
>> Sometimes we have the addition of interrupts or gpio signals (not
>> true for this one though!).
>>
>> Basically it's nicer to have all sensors use a common interface.
>> We could do that the next level up in a userspace library but I'm not
>> sure there is stronger reason to do that in this case than for simple i2c
>> / spi devices.
>>
>> So I saw no reason to block serdev devices in IIO.  Not many there
>> yet though!
> Ah this could come in handy for the EZO line of Atlas Scientific
> sensors which communicate over UART (well also i2c but it the same
> command structure as the UART).
>
> - Matt
I need to reconsider this patch because Dynament's multiple gas sensors 
use the same protocol.
>> Thanks,
>>
>> Jonathan
>>
>>
>>>>>> Signed-off-by: YuDong Zhang <mtwget@gmail.com>
>>>>>> ---
>>>>>>   MAINTAINERS                    |   5 +
>>>>>>   drivers/iio/chemical/Kconfig   |  10 +
>>>>>>   drivers/iio/chemical/Makefile  |   1 +
>>>>>>   drivers/iio/chemical/premier.c | 366 +++++++++++++++++++++++++++++++++
>>>>>>   4 files changed, 382 insertions(+)
>>>>>>   create mode 100644 drivers/iio/chemical/premier.c
>>>>>>
>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>>> index a049abccaa26..ae228ac7adc9 100644
>>>>>> --- a/MAINTAINERS
>>>>>> +++ b/MAINTAINERS
>>>>>> @@ -5792,6 +5792,11 @@ S:       Maintained
>>>>>>   F:     drivers/media/usb/dvb-usb-v2/dvb_usb*
>>>>>>   F:     drivers/media/usb/dvb-usb-v2/usb_urb.c
>>>>>>
>>>>>> +DYNAMENT PREMIER SERIES SINGLE GAS SENSOR DRIVER
>>>>>> +M:     YuDong Zhang <mtwget@gmail.com>
>>>>>> +S:     Maintained
>>>>>> +F:     drivers/iio/chemical/premier.c
>>>>>> +
>>>>>>   DYNAMIC DEBUG
>>>>>>   M:     Jason Baron <jbaron@akamai.com>
>>>>>>   S:     Maintained
>>>>>> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
>>>>>> index fa4586037bb8..93c0c108245b 100644
>>>>>> --- a/drivers/iio/chemical/Kconfig
>>>>>> +++ b/drivers/iio/chemical/Kconfig
>>>>>> @@ -62,6 +62,16 @@ config IAQCORE
>>>>>>            iAQ-Core Continuous/Pulsed VOC (Volatile Organic Compounds)
>>>>>>            sensors
>>>>>>
>>>>>> +config PREMIER
>>>>>> +       tristate "Dynament Premier series sensor"
>>>>>> +       depends on SERIAL_DEV_BUS
>>>>>> +       help
>>>>>> +         Say Y here to build support for the Dynament Premier
>>>>>> +         series sensor.
>>>>>> +
>>>>>> +         To compile this driver as a module, choose M here: the module will
>>>>>> +         be called premier.
>>>>>> +
>>>>>>   config PMS7003
>>>>>>          tristate "Plantower PMS7003 particulate matter sensor"
>>>>>>          depends on SERIAL_DEV_BUS
>>>>>> diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
>>>>>> index f97270bc4034..c8e779d7cf4a 100644
>>>>>> --- a/drivers/iio/chemical/Makefile
>>>>>> +++ b/drivers/iio/chemical/Makefile
>>>>>> @@ -10,6 +10,7 @@ obj-$(CONFIG_BME680_I2C) += bme680_i2c.o
>>>>>>   obj-$(CONFIG_BME680_SPI) += bme680_spi.o
>>>>>>   obj-$(CONFIG_CCS811)           += ccs811.o
>>>>>>   obj-$(CONFIG_IAQCORE)          += ams-iaq-core.o
>>>>>> +obj-$(CONFIG_PREMIER)          += premier.o
>>>>>>   obj-$(CONFIG_PMS7003) += pms7003.o
>>>>>>   obj-$(CONFIG_SENSIRION_SGP30)  += sgp30.o
>>>>>>   obj-$(CONFIG_SPS30) += sps30.o
>>>>>> diff --git a/drivers/iio/chemical/premier.c b/drivers/iio/chemical/premier.c
>>>>>> new file mode 100644
>>>>>> index 000000000000..a226dd9d78cb
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/iio/chemical/premier.c
>>>>>> @@ -0,0 +1,366 @@
>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>> +/*
>>>>>> + * Dynament Premier series single gas sensor driver
>>>>>> + *
>>>>>> + * Copyright (c) YuDong Zhang <mtwget@gmail.com>
>>>>>> + */
>>>>>> +
>>>>>> +#include <asm/unaligned.h>
>>>>>> +#include <linux/completion.h>
>>>>>> +#include <linux/device.h>
>>>>>> +#include <linux/errno.h>
>>>>>> +#include <linux/iio/iio.h>
>>>>>> +#include <linux/jiffies.h>
>>>>>> +#include <linux/kernel.h>
>>>>>> +#include <linux/mod_devicetable.h>
>>>>>> +#include <linux/module.h>
>>>>>> +#include <linux/mutex.h>
>>>>>> +#include <linux/of.h>
>>>>>> +#include <linux/regulator/consumer.h>
>>>>>> +#include <linux/serdev.h>
>>>>>> +
>>>>>> +#define PREMIER_DRIVER_NAME "dynament-premier"
>>>>>> +
>>>>>> +#define PREMIER_DLE (0x10)
>>>>>> +#define PREMIER_CMD_RD (0x13)
>>>>>> +#define PREMIER_CMD_NAK (0x19)
>>>>>> +#define PREMIER_CMD_DAT (0x1a)
>>>>>> +#define PREMIER_EOF (0x1f)
>>>>>> +
>>>>>> +#define PREMIER_TIMEOUT msecs_to_jiffies(6000)
>>>>>> +
>>>>>> +/*
>>>>>> + * commands have following format:
>>>>>> + *
>>>>>> + * +-----+-----+---------+-----+-----+-----------+-----------+
>>>>>> + * | DLE | CMD | PAYLOAD | DLE | EOF | CKSUM MSB | CKSUM LSB |
>>>>>> + * +-----+-----+---------+-----+-----+-----------+-----------+
>>>>>> + */
>>>>>> +static const u8 premier_cmd_read_live_data_simple[] = { 0x10, 0x13, 0x06, 0x10,
>>>>>> +                                                       0x1F, 0x00, 0x58 };
>>>>>> +
>>>>>> +struct premier_frame {
>>>>>> +       u8 state;
>>>>>> +       u8 is_dat;
>>>>>> +       u8 is_nak;
>>>>>> +       u8 data_len;
>>>>>> +       u8 vi, si, gi, gj;
>>>>>> +       u8 gas[4];
>>>>>> +       u8 byte_stuffing;
>>>>>> +       u8 checksum_received[2];
>>>>>> +       u16 checksum_calculated;
>>>>>> +};
>>>>>> +
>>>>>> +struct premier_data {
>>>>>> +       struct serdev_device *serdev;
>>>>>> +       struct premier_frame frame;
>>>>>> +       struct completion frame_ready;
>>>>>> +       struct mutex lock; /* must be held whenever state gets touched */
>>>>>> +       struct regulator *vcc;
>>>>>> +};
>>>>>> +
>>>>>> +static int premier_do_cmd_read_live_data(struct premier_data *state)
>>>>>> +{
>>>>>> +       int ret;
>>>>>> +
>>>>>> +       ret = serdev_device_write(state->serdev,
>>>>>> +                                 premier_cmd_read_live_data_simple,
>>>>>> +                                 sizeof(premier_cmd_read_live_data_simple),
>>>>>> +                                 PREMIER_TIMEOUT);
>>>>>> +       if (ret < sizeof(premier_cmd_read_live_data_simple))
>>>>>> +               return ret < 0 ? ret : -EIO;
>>>>>> +
>>>>>> +       ret = wait_for_completion_interruptible_timeout(&state->frame_ready,
>>>>>> +                                                       PREMIER_TIMEOUT);
>>>>>> +
>>>>>> +       if (!ret)
>>>>>> +               ret = -ETIMEDOUT;
>>>>>> +
>>>>>> +       return ret < 0 ? ret : 0;
>>>>>> +}
>>>>>> +
>>>>>> +static s32 premier_float_to_int_clamped(const u8 *fp)
>>>>>> +{
>>>>>> +       int val = get_unaligned_le32(fp);
>>>>>> +       int mantissa = val & GENMASK(22, 0);
>>>>>> +       /* this is fine since passed float is always non-negative */
>>>>>> +       int exp = val >> 23;
>>>>>> +       int fraction, shift;
>>>>>> +
>>>>>> +       /* special case 0 */
>>>>>> +       if (!exp && !mantissa)
>>>>>> +               return 0;
>>>>>> +
>>>>>> +       exp -= 127;
>>>>>> +       if (exp < 0) {
>>>>>> +               /* return values ranging from 1 to 99 */
>>>>>> +               return ((((1 << 23) + mantissa) * 100) >> 23) >> (-exp);
>>>>>> +       }
>>>>>> +
>>>>>> +       /* return values ranging from 100 to int_max */
>>>>>> +       shift = 23 - exp;
>>>>>> +       val = (1 << exp) + (mantissa >> shift);
>>>>>> +
>>>>>> +       fraction = mantissa & GENMASK(shift - 1, 0);
>>>>>> +
>>>>>> +       return val * 100 + ((fraction * 100) >> shift);
>>>>>> +}
>>>>>> +
>>>>>> +static int premier_read_raw(struct iio_dev *indio_dev,
>>>>>> +                           struct iio_chan_spec const *chan, int *val,
>>>>>> +                           int *val2, long mask)
>>>>>> +{
>>>>>> +       struct premier_data *state = iio_priv(indio_dev);
>>>>>> +       struct premier_frame *frame = &state->frame;
>>>>>> +       int ret;
>>>>>> +       s32 val_tmp;
>>>>>> +
>>>>>> +       switch (mask) {
>>>>>> +       case IIO_CHAN_INFO_PROCESSED:
>>>>>> +
>>>>>> +               mutex_lock(&state->lock);
>>>>>> +               ret = premier_do_cmd_read_live_data(state);
>>>>>> +               if (ret) {
>>>>>> +                       mutex_unlock(&state->lock);
>>>>>> +                       return ret;
>>>>>> +               }
>>>>>> +               val_tmp = premier_float_to_int_clamped(frame->gas);
>>>>>> +               mutex_unlock(&state->lock);
>>>>>> +
>>>>>> +               *val = val_tmp / 100;
>>>>>> +               *val2 = (val_tmp % 100) * 10000;
>>>>>> +               return IIO_VAL_INT_PLUS_MICRO;
>>>>>> +       default:
>>>>>> +               return -EINVAL;
>>>>>> +       }
>>>>>> +
>>>>>> +       return -EINVAL;
>>>>>> +}
>>>>>> +
>>>>>> +static const struct iio_info premier_info = {
>>>>>> +       .read_raw = premier_read_raw,
>>>>>> +};
>>>>>> +
>>>>>> +static const struct iio_chan_spec premier_channels[] = {
>>>>>> +       {
>>>>>> +               .type = IIO_MASSCONCENTRATION,
>>>>>> +               .channel = 1,
>>>>>> +               .channel2 = IIO_MOD_CO2,
>>>>>> +               .scan_index = -1,
>>>>>> +               .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>>>>>> +               .modified = 1,
>>>>>> +       },
>>>>>> +       IIO_CHAN_SOFT_TIMESTAMP(0),
>>>>>> +};
>>>>>> +
>>>>>> +static int premier_receive_buf(struct serdev_device *serdev,
>>>>>> +                              const unsigned char *buf, size_t size)
>>>>>> +{
>>>>>> +       struct iio_dev *indio_dev = serdev_device_get_drvdata(serdev);
>>>>>> +       struct premier_data *state = iio_priv(indio_dev);
>>>>>> +       struct premier_frame *frame = &state->frame;
>>>>>> +       int i;
>>>>>> +
>>>>>> +       for (i = 0; i < size; i++) {
>>>>>> +               if (frame->state > 0 && frame->state <= 7)
>>>>>> +                       frame->checksum_calculated += buf[i];
>>>>>> +
>>>>>> +               switch (frame->state) {
>>>>>> +               case 0:
>>>>>> +                       if (buf[i] == PREMIER_DLE) {
>>>>>> +                               frame->is_dat = 0;
>>>>>> +                               frame->is_nak = 0;
>>>>>> +                               frame->checksum_calculated = buf[i];
>>>>>> +                               /* We don't initialize checksum_calculated in
>>>>>> +                                * the last state in case we didn't go
>>>>>> +                                * there because of noise
>>>>>> +                                */
>>>>>> +                               frame->state++;
>>>>>> +                       }
>>>>>> +                       break;
>>>>>> +               case 1:
>>>>>> +                       /*
>>>>>> +                        * If noise corrupts a byte in the FSM sequence,
>>>>>> +                        * we loop between state 0 and 1,
>>>>>> +                        * until we have a valid sequence of DLE&DAT or DLE&NAK
>>>>>> +                        */
>>>>>> +                       if (buf[i] == PREMIER_CMD_DAT) {
>>>>>> +                               frame->is_dat = 1;
>>>>>> +                               frame->state++;
>>>>>> +                       } else if (buf[i] == PREMIER_CMD_NAK) {
>>>>>> +                               frame->is_nak = 1;
>>>>>> +                               frame->state++;
>>>>>> +                       } else
>>>>>> +                               frame->state = 0;
>>>>>> +                       break;
>>>>>> +               case 2:
>>>>>> +                       if (frame->is_nak)
>>>>>> +                               frame->state = 0;
>>>>>> +                       else if (frame->is_dat) {
>>>>>> +                               frame->data_len = buf[i] - 4;
>>>>>> +                               /* remove version and status bytes from count */
>>>>>> +                               if (frame->data_len < 4)
>>>>>> +                                       frame->state = 0;
>>>>>> +                               /* we check for the upper limit in state 5 */
>>>>>> +                               else
>>>>>> +                                       frame->state++;
>>>>>> +                       } else
>>>>>> +                               frame->state = 0;
>>>>>> +                       break;
>>>>>> +               case 3:
>>>>>> +                       /* Just do nothing for 2 rounds to bypass
>>>>>> +                        * the 2 version bytes
>>>>>> +                        */
>>>>>> +                       if (frame->vi < 2 - 1)
>>>>>> +                               frame->vi++;
>>>>>> +                       else {
>>>>>> +                               frame->vi = 0;
>>>>>> +                               frame->state++;
>>>>>> +                       }
>>>>>> +                       break;
>>>>>> +               case 4:
>>>>>> +                       if (frame->si < 2 - 1)
>>>>>> +                               frame->si++;
>>>>>> +                       else {
>>>>>> +                               frame->si = 0;
>>>>>> +                               frame->state++;
>>>>>> +                       }
>>>>>> +                       break;
>>>>>> +               case 5:
>>>>>> +                       if (frame->gi < frame->data_len - 1) {
>>>>>> +                               if (buf[i] != PREMIER_DLE ||
>>>>>> +                                   frame->byte_stuffing) {
>>>>>> +                                       frame->gas[frame->gj] = buf[i];
>>>>>> +                                       frame->byte_stuffing = 0;
>>>>>> +                                       frame->gj++;
>>>>>> +                                       if (frame->gj >= 4)
>>>>>> +                                               frame->state = 0;
>>>>>> +                                       /* Don't violate array limits
>>>>>> +                                        * if data_len corrupt
>>>>>> +                                        */
>>>>>> +                               } else
>>>>>> +                                       frame->byte_stuffing = 1;
>>>>>> +                               frame->gi++;
>>>>>> +                       } else {
>>>>>> +                               frame->gas[frame->gj] = buf[i];
>>>>>> +                               frame->byte_stuffing = 0;
>>>>>> +                               frame->gi = 0;
>>>>>> +                               frame->gj = 0;
>>>>>> +                               frame->state++;
>>>>>> +                       }
>>>>>> +                       break;
>>>>>> +               case 6:
>>>>>> +                       if (buf[i] == PREMIER_DLE)
>>>>>> +                               frame->state++;
>>>>>> +                       else
>>>>>> +                               frame->state = 0;
>>>>>> +                       break;
>>>>>> +               case 7:
>>>>>> +                       if (buf[i] == PREMIER_EOF)
>>>>>> +                               frame->state++;
>>>>>> +                       else
>>>>>> +                               frame->state = 0;
>>>>>> +                       break;
>>>>>> +               case 8:
>>>>>> +                       frame->checksum_received[1] = buf[i];
>>>>>> +
>>>>>> +                       frame->state++;
>>>>>> +                       break;
>>>>>> +               case 9:
>>>>>> +                       frame->checksum_received[0] = buf[i];
>>>>>> +
>>>>>> +                       if (frame->checksum_calculated ==
>>>>>> +                           get_unaligned_le16(frame->checksum_received))
>>>>>> +                               complete(&state->frame_ready);
>>>>>> +
>>>>>> +                       frame->state = 0;
>>>>>> +                       break;
>>>>>> +               }
>>>>>> +       }
>>>>>> +
>>>>>> +       return size;
>>>>>> +}
>>>>>> +
>>>>>> +static const struct serdev_device_ops premier_serdev_ops = {
>>>>>> +       .receive_buf = premier_receive_buf,
>>>>>> +       .write_wakeup = serdev_device_write_wakeup,
>>>>>> +};
>>>>>> +
>>>>>> +static int premier_probe(struct serdev_device *serdev)
>>>>>> +{
>>>>>> +       struct premier_data *state;
>>>>>> +       struct iio_dev *indio_dev;
>>>>>> +       int ret;
>>>>>> +
>>>>>> +       indio_dev = devm_iio_device_alloc(&serdev->dev, sizeof(*state));
>>>>>> +       if (!indio_dev)
>>>>>> +               return -ENOMEM;
>>>>>> +
>>>>>> +       state = iio_priv(indio_dev);
>>>>>> +       serdev_device_set_drvdata(serdev, indio_dev);
>>>>>> +       state->serdev = serdev;
>>>>>> +       indio_dev->dev.parent = &serdev->dev;
>>>>>> +       indio_dev->info = &premier_info;
>>>>>> +       indio_dev->name = PREMIER_DRIVER_NAME;
>>>>>> +       indio_dev->channels = premier_channels;
>>>>>> +       indio_dev->num_channels = ARRAY_SIZE(premier_channels);
>>>>>> +       indio_dev->modes = INDIO_DIRECT_MODE;
>>>>>> +
>>>>>> +       mutex_init(&state->lock);
>>>>>> +       init_completion(&state->frame_ready);
>>>>>> +
>>>>>> +       state->vcc = devm_regulator_get(&serdev->dev, "vcc");
>>>>>> +       if (IS_ERR(state->vcc)) {
>>>>>> +               ret = PTR_ERR(state->vcc);
>>>>>> +               return ret;
>>>>>> +       }
>>>>>> +
>>>>>> +       serdev_device_set_client_ops(serdev, &premier_serdev_ops);
>>>>>> +       ret = devm_serdev_device_open(&serdev->dev, serdev);
>>>>>> +       if (ret)
>>>>>> +               return ret;
>>>>>> +
>>>>>> +       serdev_device_set_baudrate(serdev, 9600);
>>>>>> +       serdev_device_set_flow_control(serdev, false);
>>>>>> +
>>>>>> +       ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
>>>>>> +       if (ret)
>>>>>> +               return ret;
>>>>>> +
>>>>>> +       if (state->vcc) {
>>>>>> +               ret = regulator_enable(state->vcc);
>>>>>> +               if (ret)
>>>>>> +                       return ret;
>>>>>> +       }
>>>>>> +
>>>>>> +       return devm_iio_device_register(&serdev->dev, indio_dev);
>>>>>> +}
>>>>>> +
>>>>>> +static void premier_remove(struct serdev_device *serdev)
>>>>>> +{
>>>>>> +       struct iio_dev *indio_dev = serdev_device_get_drvdata(serdev);
>>>>>> +       struct premier_data *state = iio_priv(indio_dev);
>>>>>> +
>>>>>> +       if (state->vcc)
>>>>>> +               regulator_disable(state->vcc);
>>>>>> +}
>>>>>> +
>>>>>> +static const struct of_device_id premier_of_match[] = {
>>>>>> +       { .compatible = "dynament,premier" },
>>>>>> +       {}
>>>>>> +};
>>>>>> +MODULE_DEVICE_TABLE(of, premier_of_match);
>>>>>> +
>>>>>> +static struct serdev_device_driver premier_driver = {
>>>>>> +       .driver = {
>>>>>> +               .name = PREMIER_DRIVER_NAME,
>>>>>> +               .of_match_table = premier_of_match,
>>>>>> +       },
>>>>>> +       .probe = premier_probe,
>>>>>> +       .remove = premier_remove,
>>>>>> +};
>>>>>> +module_serdev_device_driver(premier_driver);
>>>>>> +
>>>>>> +MODULE_AUTHOR("YuDong Zhang <mtwget@gmail.com>");
>>>>>> +MODULE_DESCRIPTION("Dynament Premier series single gas sensor driver");
>>>>>> +MODULE_LICENSE("GPL v2");
>>>>>> --
>>>>>> 2.24.1
>>>>>>
