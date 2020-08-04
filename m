Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1C923B5EA
	for <lists+linux-iio@lfdr.de>; Tue,  4 Aug 2020 09:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgHDHma (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Aug 2020 03:42:30 -0400
Received: from mailout11.rmx.de ([94.199.88.76]:37719 "EHLO mailout11.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbgHDHma (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 4 Aug 2020 03:42:30 -0400
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout11.rmx.de (Postfix) with ESMTPS id 4BLRYF45jsz3ybM;
        Tue,  4 Aug 2020 09:42:25 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4BLRY03tZlz2xNM;
        Tue,  4 Aug 2020 09:42:12 +0200 (CEST)
Received: from n95hx1g2.localnet (192.168.54.102) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 4 Aug
 2020 09:40:12 +0200
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
Subject: Re: [PATCH v5 2/2] iio: light: as73211: New driver
Date:   Tue, 4 Aug 2020 09:40:11 +0200
Message-ID: <2356337.HYKpEJ1Wej@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CAHp75Vev64E86OWm+eV=1o4ZDs0Xh_Y1z6V54GmpRwWmjD7=eA@mail.gmail.com>
References: <20200802163735.76617-1-ceggers@arri.de> <20200802163735.76617-3-ceggers@arri.de> <CAHp75Vev64E86OWm+eV=1o4ZDs0Xh_Y1z6V54GmpRwWmjD7=eA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.102]
X-RMX-ID: 20200804-094212-4BLRY03tZlz2xNM-0@kdin01
X-RMX-SOURCE: 217.111.95.66
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sunday, 2 August 2020, 20:02:35 CEST, Andy Shevchenko wrote:
> Thanks for an update, my comments below.

Thanks for the review. Please see below for my questions.

Best regards
Christian

> On Sun, Aug 2, 2020 at 7:40 PM Christian Eggers <ceggers@arri.de> wrote:
> > Datasheet:
> > https://ams.com/documents/20143/36005/AS73211_DS000556_3-01.pdf/a65474c0-
> > b302-c2fd-e30a-c98df87616df
> Do we need the UUID after the document file name?
I have send AMS an inquiry. Not sure whether I will get an answer. I will wait
a few days until sending v6.

> > +#define AS73211_OFFSET_TEMP (-66.9)
> > +#define AS73211_SCALE_TEMP  0.05
> 
> In the kernel we don't do float arithmetic. How these are being used?
Does this restriction also apply for compile time constants? I am quite 
sure that all calculations using these defines will be evaluated at compile
time. If found a number of other places where probably the same is done:

find . -name '*.c' | xargs grep "#define.*[0-9]\.[0-9]" | grep -v '"' | grep -v "\/\*.*[0-9]\.[0-9]"

> > +               *val2 = (AS73211_OFFSET_TEMP - (int)AS73211_OFFSET_TEMP) *
> > 1000000;
> > 
> > +                       *val2 = (AS73211_SCALE_TEMP -
> > (int)AS73211_SCALE_TEMP) * 1000000;
> Magic 1000000 multiplier.
I think that in the context of IIO_VAL_INT_PLUS_MICRO this isn't quite magic. Using
1000000 directly seems quite usual:

find drivers/iio/ -type f | xargs grep "val2 = .*1000000"

> I think here you got them always 0. And to fix that you need to
> redefine (with also units included in the name) above constants like
> #define ..._OFFSET_TEMP_mC 66500
> ... _SCALE_TEMP_?? 50
a scale factor has no unit

> 
> Consider to use definitions from
> https://elixir.bootlin.com/linux/latest/source/include/linux/units.h
There are only definition for milli celsius. For IIO_VAL_INT_PLUS_MICRO I would
require micro celsius.

If I have the freedom, I would keep it as it is. Else I would suggest the following:
#define AS73211_OFFSET_TEMP_INT (-66)
#define AS73211_OFFSET_TEMP_MICRO 900000
#define AS73211_SCALE_TEMP_INT 0
#define AS73211_SCALE_TEMP_MICRO 50000

> > +       }}
> > +
> > +       return -EINVAL;
> 
> Make it default case.
changed. Is there any benefit? My IDE's syntax checker now complains
"No return, in a function returning non-void". But gcc is happy with this.

> > +       ret = devm_iio_device_register(dev, indio_dev);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       return 0;
> 
>   return devm_iio_device_register();
changed. I prefer the original pattern as it would produce less changed lines
if something needs to inserted later.



