Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56919234451
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jul 2020 12:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732487AbgGaKxM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jul 2020 06:53:12 -0400
Received: from mailout07.rmx.de ([94.199.90.95]:55415 "EHLO mailout07.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729141AbgGaKxM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 31 Jul 2020 06:53:12 -0400
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout07.rmx.de (Postfix) with ESMTPS id 4BJ3z72b6fzBwbd;
        Fri, 31 Jul 2020 12:53:07 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4BJ3yk4dddz2xFV;
        Fri, 31 Jul 2020 12:52:46 +0200 (CEST)
Received: from n95hx1g2.localnet (192.168.54.39) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 31 Jul
 2020 12:52:23 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] iio: light: as73211: New driver
Date:   Fri, 31 Jul 2020 12:52:22 +0200
Message-ID: <2706267.JtmGt7LAV2@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CAHp75VdDCnQLh0Qts8hsgLBy5TqibOKAYSeFxuV69XLroRBOEg@mail.gmail.com>
References: <20200731070114.40471-1-ceggers@arri.de> <20200731070114.40471-3-ceggers@arri.de> <CAHp75VdDCnQLh0Qts8hsgLBy5TqibOKAYSeFxuV69XLroRBOEg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.39]
X-RMX-ID: 20200731-125248-4BJ3yk4dddz2xFV-0@kdin01
X-RMX-SOURCE: 217.111.95.66
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

thanks for further review. If nobody else sends comments, I'll
publish the next version tonight. Maybe we could clarify the questions
below in time.

Best regards
Christian


> W=1 (not V=1) runs kernel doc validation script.
without V=1, I get nothing. Neither excess nor missing members
are reported on my system.


On Friday, 31 July 2020, 09:34:02 CEST, Andy Shevchenko wrote:
> On Fri, Jul 31, 2020 at 10:03 AM Christian Eggers <ceggers@arri.de> wrote:
> > +static const int as73211_samp_freq_avail[] = { 1024000, 2048000, 4096000,
> > 8192000 };
> This looks related to the below mentioned 1.024MHz.
> 
> Perhaps add a definition above and comment here?
> 
> #define AS73211_BASE_FREQ_1024KHZ   1024000
added similar define in v5. The array looks like the following now

static const int as73211_samp_freq_avail[] = {
	AS73211_SAMPLE_FREQ_BASE,
	AS73211_SAMPLE_FREQ_BASE * 2,
	AS73211_SAMPLE_FREQ_BASE * 4,
	AS73211_SAMPLE_FREQ_BASE * 8
};


> > +/* integration time in units of 1024 clock cycles */
> 
> Unify this with below one. Or the other way around, i.o.w. join one of
> them into the other.
> 
> > +static unsigned int as73211_integration_time_1024cyc(struct as73211_data
> > *data) +{
> > +       /* integration time in CREG1 is in powers of 2 (x 1024 cycles) */
> > +       return BIT(FIELD_GET(AS73211_CREG1_TIME_MASK, data->creg1));
> > +}
I'm not sure, whether this is possible. as73211_integration_time_1024cyc()
returns the current setting from hardware. as73211_integration_time_us()
calculates the resulting time. But as73211_integration_time_us() is also
called in as73211_integration_time_calc_avail() inside the loop.

> > +       unsigned int time_us = as73211_integration_time_us(data,
> > +                                                          as73211_integration_time_1024cyc(data));
> One line?
checkpatch complains... ignore?


> > +               int reg_bits, freq_kHz = val / 1000 /* HZ_PER_KHZ */;  /*
> > 1024, 2048, ... */ +
> > +               /* val must be 1024 * 2^x */
> > +               if (val < 0 || (freq_kHz * 1000 /* HZ_PER_KHZ */) != val
> > ||
> > +                               !is_power_of_2(freq_kHz) || val2)
> > +                       return -EINVAL;
> 
> Please, define HZ_PER_KHZ locally. It will really help when we move
> these definitions to a global level.
ok

> 
> ...
> 
> > +               /* gain can be calculated from CREG1 as 2^(13 -
> > CREG1_GAIN) */ +               reg_bits = 13 - ilog2(val);
> 
> 13 is the second time in the code. Deserves a descriptive definition.
I'm unsure how to solve this. Possible values for gain:

CREG1[7:4]  | gain
-----------------------------
0           | 2048x
1           | 1024x
2           |  512x
...         |  ...
13          |    1x

#define AS73211_CREG1_GAIN_1_NON_SHIFTED 13  // this define is CREG1 related, but not shifted to the right position

static unsigned int as73211_gain(struct as73211_data *data)
{
	/* gain can be calculated from CREG1 as 2^(13 - CREG1_GAIN) */
	return BIT(AS73211_CREG1_GAIN_1_NON_SHIFTED - FIELD_GET(AS73211_CREG1_GAIN_MASK, data->creg1));
}

---- or ----

#define AS73211_CREG1_GAIN_1 FIELD_PREP(AS73211_CREG1_GAIN_MASK, 13)

static unsigned int as73211_gain(struct as73211_data *data)
{
	/* gain can be calculated from CREG1 as 2^(13 - CREG1_GAIN) */
	return BIT(FIELD_GET(AS73211_CREG1_GAIN_MASK, AS73211_CREG1_GAIN_1) - FIELD_GET(AS73211_CREG1_GAIN_MASK, data->creg1));
}


> > +       indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > +       if (indio_dev == NULL)
> 
> if (!indio_dev)
> 
> > +               return -ENOMEM;
> 
> ...
> 
> > +       indio_dev->dev.parent = dev;
> 
> Doesn't IIO core do this for you?
devm_iio_device_alloc() doesn't pass 'dev' to iio_device_alloc().
I already looked around, but I didn't find. And after debugging
v5.4, devm_iio_device_alloc() definitely doesn't do it.

> > +       ret = devm_iio_device_register(dev, indio_dev);
> > +       if (ret < 0)
> > +               goto powerdown;
> > +
> > +       return 0;
> > 
> > +powerdown:
> > +       as73211_power(indio_dev, false);
> > +       return ret;
> 
> devm_*() is tricky. Here you broke ordering heavily. So, consider to
> add this under devm_add_action_or_reset().
Sorry, my mistake! I already felt that something may be wrong here...



