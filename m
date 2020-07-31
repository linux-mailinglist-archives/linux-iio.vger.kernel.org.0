Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC619233F7C
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jul 2020 08:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbgGaGzp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jul 2020 02:55:45 -0400
Received: from mailout08.rmx.de ([94.199.90.85]:41351 "EHLO mailout08.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731224AbgGaGzp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 31 Jul 2020 02:55:45 -0400
Received: from kdin02.retarus.com (kdin02.dmz1.retloc [172.19.17.49])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout08.rmx.de (Postfix) with ESMTPS id 4BHyj80mYTzMt5g;
        Fri, 31 Jul 2020 08:55:40 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin02.retarus.com (Postfix) with ESMTPS id 4BHyhl34Xtz2TTJr;
        Fri, 31 Jul 2020 08:55:19 +0200 (CEST)
Received: from n95hx1g2.localnet (192.168.54.61) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 31 Jul
 2020 08:54:56 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: light: as73211: New driver
Date:   Fri, 31 Jul 2020 08:54:54 +0200
Message-ID: <6453117.yIeBT9JUrU@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CAHp75VeXqFgqiGUkS71B1xCD-60iQFS4EKJwVFX-L_dTUFMc6A@mail.gmail.com>
References: <20200730104946.39148-1-ceggers@arri.de> <20200730104946.39148-3-ceggers@arri.de> <CAHp75VeXqFgqiGUkS71B1xCD-60iQFS4EKJwVFX-L_dTUFMc6A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.61]
X-RMX-ID: 20200731-085521-4BHyhl34Xtz2TTJr-0@kdin02
X-RMX-SOURCE: 217.111.95.66
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Good morning Andy,

thank you again for the comprehensive feedback! Below I removed
everything but possible open points. I'll send v4 soon.

Best regards
Christian

On Thursday, 30 July 2020, 13:31:31 CEST, Andy Shevchenko wrote:
> On Thu, Jul 30, 2020 at 1:52 PM Christian Eggers <ceggers@arri.de> wrote:
> > +/**
> > + * struct as73211_data - Instance data for one AS73211
> > + * @client: I2C client.
> > + * @osr:    Cached Operational State Register.
> > + * @creg1:  Cached Configuration Register 1.
> > + * @creg2:  Cached Configuration Register 2.
> > + * @creg3:  Cached Configuration Register 3.
> > + * @buffer: Buffer for triggered measurements.
> > + * @mutex:  Keeps cached registers in synch with the device.
> > + * @completion: Completion to wait for interrupt.
> > + */
> > +struct as73211_data {
> > +       struct i2c_client *client;
> > +       u8 osr;
> > +       u8 creg1;
> > +       u8 creg2;
> > +       u8 creg3;
> > +       struct mutex mutex;
> > +       struct completion completion;
> > +};
> 
> Actually Jonathan is correct -- the above has kernel doc issues.
That's correct (the description for @buffer has to be removed). I didn't figure
out how to automatically check for this. When building with V=1 C=1, I only get
the message "as73211.c:76: info: Scanning doc for struct as73211_data".

> > +static unsigned int as73211_integration_time_us(struct as73211_data
> > *data)
> > +{
> > +       /* Integration time has 15 steps, the step size depends on the
> > clock. */ +       unsigned int mul = BIT(3 - (data->creg3 & GENMASK(1,
> > 0)));
> Shouldn't be rather
> 
> #define FOO  GENMASK(1, 0)
> mul = BIT(FOO - (creg & FOO));
> 
> with a descriptive name of FOO?
> 
> Or if both 3:s have different meaning, two definitions?
In my opinion, both 3:s have different meaning. The first is from an arbitrary
choosen mathematic transformation (like the 125). I've added appropriate
documentation for this.

> > +static unsigned int as73211_gain(struct as73211_data *data)
> > +{
> > 
> > +       return BIT(0xb - FIELD_GET(AS73211_CREG1_GAIN_MASK, data->creg1));
> 
> Magic!
Similarly it's difficult to find an eligible alias for the 0xb as the
whole expression is constructed from viewing tables on the data sheet. I added
some comment.

> > +       if (data->client->irq) {
> > +               dev_dbg(dev, "Waiting for completion...\n");
> > +               ret = wait_for_completion_timeout(&data->completion,
> > 
> > +                                       2 + usecs_to_jiffies(time_us));
> 
> Magic!
It turned out the the "2" can be removed, as the timeout is already rounded up.

> > +               usleep_range(time_us, time_us + 100000);
> If time_us appears to be, let's say, 100. The above margin is way too high.
range changed to (time_us, 2 * time_us).

> > +               if (osr_status & AS73211_OSR_SS) {
> > +                       dev_warn(dev, "%s() Measurement has not
> > stopped\n", __func__); +                       return -ETIME;
> > +               }
> > +               if (osr_status & AS73211_OSR_STATUS_NOTREADY) {
> > +                       dev_warn(dev, "%s() Data is not ready\n",
> > __func__); +                       return -ENODATA;
> > +               }
> > +               if (!(osr_status & AS73211_OSR_STATUS_NDATA)) {
> > +                       dev_warn(dev, "%s() New new data available\n",
> > __func__); +                       return -ENODATA;
> > +               }
> > +               if (osr_status & AS73211_OSR_STATUS_LDATA) {
> > +                       dev_warn(dev, "%s() Result buffer overrun\n",
> > __func__); +                       return -ENOBUFS;
> > +               }
> > +               if (osr_status & AS73211_OSR_STATUS_ADCOF) {
> > +                       dev_warn(dev, "%s() ADC overflow\n", __func__);
> > +                       return -EOVERFLOW;
> > +               }
> > +               if (osr_status & AS73211_OSR_STATUS_MRESOF) {
> > +                       dev_warn(dev, "%s() Measurement result
> > overflow\n", __func__); +                       return -EOVERFLOW;
> > +               }
> > +               if (osr_status & AS73211_OSR_STATUS_OUTCONVOF) {
> > +                       dev_warn(dev, "%s() Timer overflow\n", __func__);
> > +                       return -EOVERFLOW;
> > +               }
> > +               dev_warn(dev, "%s() Unexpected status value\n", __func__);
> > +               return -EIO;
> > +       }
> 
> All above dev_warn() are wrong. Should be dev_err(). Otherwise all
> return -ERRNO are wrong.
I have changed everything to "dev_err".

> > +               *val = BIT(data->creg3 & GENMASK(1, 0)) * 1024 * 1000;
> 
> 1000 is magic and 1024 either.
Changed to 1024000 and added a comment.

> 1000 is frequency multiplier? If it's not defined do it like
>   #define HZ_PER_KHZ
>   #define KHZ_PER_MHZ
> or what is that?
> 
> ...
> 
> > +               *val = time_us / 1000000;
> > +               *val2 = time_us % 1000000;
> 
> Ditto.
> 
> NSEC_PER_SEC or what?
> 
> ...
> 
> > +               int reg_bits, freq_kHz = val / 1000;  /* 1024, 2048, ...
> > */
> 
> HZ_PER_KHZ?
> 
> ...
> 
> > +               if (val < 0 || (freq_kHz * 1000) != val || val2)
> 
> Ditto.
I switched to existing defined where possible. But I wouldn't like to introduce
this for every possible physical unit. Please check again in v4.

> > +               return i2c_smbus_write_byte_data(data->client,
> > AS73211_REG_CREG3, data->creg3);
> Can it suddenly return positive number?
The i2c_smbus_write_xxx() return 0 on success, but i2c_smbus_read_xxx return
the value read from the register...

> > +       struct iio_dev *indio_dev = pf->indio_dev;
> 
> Ditto. Do you use indio_dev below (except one case)? I haven't noticed.
indio_dev is used multiple times

> > +       }
> > +       /* Optimization for reading only color channels */
> > +       else {
> 
> Should be one line. Had you run checkpatch?
checkpatch didn't complain here (probably due to the comment). Changed anyway.

> > +static ssize_t as73211_show_samp_freq_available(struct device *dev
> > __always_unused, +                                                struct
> > device_attribute *attr __always_unused, +                                
> >                char *buf)
> > +{
> > +}
> > +
> > +static ssize_t as73211_show_int_time_available(struct device *dev,
> > +                                               struct device_attribute
> > *attr __always_unused, +                                              
> > char *buf)
> > +{
> > +}
> > +
> > +static ssize_t as73211_show_hardwaregain_available(struct device *dev
> > __always_unused, +                                                  
> > struct device_attribute *attr __always_unused, +                         
> >                          char *buf)
> > +{
> > +}
> 
> I guess above is an overkill. See example here
> 
> commit 6085102c494b8afc62bc093f8f32d6248f6d33e5
> Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date:   Mon Mar 23 12:41:26 2020 +0200
> 
>    iio: pressure: bmp280: Convert to use ->read_avail()
> 
> ...
> 
Converted to read_avail(). Please also review read_raw() for
IIO_CHAN_INFO_OFFSET and IIO_CHAN_INFO_SCALE.

> > +       ret = i2c_smbus_read_byte_data(data->client, AS73211_REG_OSR);
> > +       if (ret < 0)
> > +               return ret;
> 
> Yeah, be consistent. Either all such call should be checked against
> negative error code, or drop ' < 0' everywhere it applies.
I decided to check for < 0 everywhere.

> > +       if (client->irq) {
> > +               ret = request_threaded_irq(client->irq,
> > +                               NULL,
> > +                               as73211_ready_handler,
> > +                               IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> 
> Should not be IRQ trigger type here. (Do you have broken firmware table?)
Of course you are right! This is already in the device tree:

interrupts = <19 IRQ_TYPE_EDGE_RISING>;




