Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF96A234918
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jul 2020 18:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbgGaQVW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jul 2020 12:21:22 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2552 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727997AbgGaQVW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 31 Jul 2020 12:21:22 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 04B5D8FFCBA9E1A5A831;
        Fri, 31 Jul 2020 17:21:20 +0100 (IST)
Received: from localhost (10.52.124.83) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 31 Jul
 2020 17:21:19 +0100
Date:   Fri, 31 Jul 2020 17:19:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Christian Eggers <ceggers@arri.de>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] iio: light: as73211: New driver
Message-ID: <20200731171955.00000942@Huawei.com>
In-Reply-To: <CAHp75VdSNXWCVVgX+8BCC5iWjO14KMUCNrYvZyFfez-fFerQsA@mail.gmail.com>
References: <20200731070114.40471-1-ceggers@arri.de>
        <20200731070114.40471-3-ceggers@arri.de>
        <CAHp75VdDCnQLh0Qts8hsgLBy5TqibOKAYSeFxuV69XLroRBOEg@mail.gmail.com>
        <2706267.JtmGt7LAV2@n95hx1g2>
        <CAHp75VdSNXWCVVgX+8BCC5iWjO14KMUCNrYvZyFfez-fFerQsA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.124.83]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 31 Jul 2020 18:41:47 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Jul 31, 2020 at 1:52 PM Christian Eggers <ceggers@arri.de> wrote:
> 
> > > W=1 (not V=1) runs kernel doc validation script.  
> > without V=1, I get nothing. Neither excess nor missing members
> > are reported on my system.  
> 
> It's strange.
> 
> ...
> 
> > > Perhaps add a definition above and comment here?
> > >
> > > #define AS73211_BASE_FREQ_1024KHZ   1024000  
> > added similar define in v5. The array looks like the following now
> >
> > static const int as73211_samp_freq_avail[] = {  
> 
> >         AS73211_SAMPLE_FREQ_BASE,  
> 
> ' * 1'
> 
> >         AS73211_SAMPLE_FREQ_BASE * 2,
> >         AS73211_SAMPLE_FREQ_BASE * 4,
> >         AS73211_SAMPLE_FREQ_BASE * 8
> > };  
> 
> ...
> 
> > > > +/* integration time in units of 1024 clock cycles */  
> > >
> > > Unify this with below one. Or the other way around, i.o.w. join one of
> > > them into the other.
> > >  
> > > > +static unsigned int as73211_integration_time_1024cyc(struct as73211_data
> > > > *data) +{
> > > > +       /* integration time in CREG1 is in powers of 2 (x 1024 cycles) */
> > > > +       return BIT(FIELD_GET(AS73211_CREG1_TIME_MASK, data->creg1));
> > > > +}  
> > I'm not sure, whether this is possible. as73211_integration_time_1024cyc()
> > returns the current setting from hardware. as73211_integration_time_us()
> > calculates the resulting time. But as73211_integration_time_us() is also
> > called in as73211_integration_time_calc_avail() inside the loop.  
> 
> What I meant is solely comments to be joined, not the code.
> 
> ...
> 
       unsigned int time_us = as73211_integration_time_us(data, as73211_integration_time_1024cyc(data));  
> > > One line?  
> 
> > checkpatch complains... ignore?  
> 
> Hmm... is it over 100? Or you are using some old tools to work with
> the kernel...

It's over a 100... (about 103 by the handy scale at the top of my email client :)

> 
> ...
> 
> > > > +               /* gain can be calculated from CREG1 as 2^(13 -
> > > > CREG1_GAIN) */ +               reg_bits = 13 - ilog2(val);  
> > >
> > > 13 is the second time in the code. Deserves a descriptive definition.  
> 
> > I'm unsure how to solve this. Possible values for gain:
> >
> > CREG1[7:4]  | gain
> > -----------------------------
> > 0           | 2048x
> > 1           | 1024x
> > 2           |  512x
> > ...         |  ...
> > 13          |    1x
> >
> > #define AS73211_CREG1_GAIN_1_NON_SHIFTED 13  // this define is CREG1 related, but not shifted to the right position
> >
> > static unsigned int as73211_gain(struct as73211_data *data)
> > {
> >         /* gain can be calculated from CREG1 as 2^(13 - CREG1_GAIN) */
> >         return BIT(AS73211_CREG1_GAIN_1_NON_SHIFTED - FIELD_GET(AS73211_CREG1_GAIN_MASK, data->creg1));
> > }  
> 
> This way (w/o _NON_SHIFTED suffix) if both 13:s in the code are of the
> same meaning.
> 
> ...
> 
> > > > +       indio_dev->dev.parent = dev;  
> > >
> > > Doesn't IIO core do this for you?  
> > devm_iio_device_alloc() doesn't pass 'dev' to iio_device_alloc().
> > I already looked around, but I didn't find. And after debugging
> > v5.4, devm_iio_device_alloc() definitely doesn't do it.  
> 
> Why are you talking about v5.4? We are in v5.8 cycle contributing to v5.9.

This will be 5.10 now.  5.9 cycle for new stuff via IIO effectively closed
last week. 

> 
> Recently IIO gained some features among which I think the one that
> assigns parent devices.
> 
yup. This should be in linux-next now for the coming merge window (which probably opens on Sunday).

Note that we have lots of time to tidy up loose ends for this one as it will only sit
in my tree for next few weeks if I do pick it up.

Jonathan


