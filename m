Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056FB263F7C
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 10:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbgIJIPo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 04:15:44 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2802 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726961AbgIJINp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 04:13:45 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id CCFBE850CD2915818418;
        Thu, 10 Sep 2020 09:13:43 +0100 (IST)
Received: from localhost (10.52.121.43) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 10 Sep
 2020 09:13:43 +0100
Date:   Thu, 10 Sep 2020 09:12:08 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        "Michael Hennerich" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>, Peter Rosin <peda@axentia.se>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3 08/18] iio: adc: stm32: Simplify with dev_err_probe()
Message-ID: <20200910091208.000055fa@Huawei.com>
In-Reply-To: <CAJKOXPdNAw8scFKCGaC_hp4jMyLD_mFLKr=+fGKSm6nCkcRF9g@mail.gmail.com>
References: <20200829064726.26268-1-krzk@kernel.org>
        <20200829064726.26268-8-krzk@kernel.org>
        <20200909193600.41970d8c@archlinux>
        <CAJKOXPeo8SXWaRmiFG6z+t9jcnaSMRpvRPm2X22Rf6rtEeKVew@mail.gmail.com>
        <a37c69f2-1f16-2680-2716-0c1b77748d55@axentia.se>
        <CAHp75Vc4-zkkWtOz8w7pA0Vu1yMAVodhPSLQ1NJH4K+j9XD52g@mail.gmail.com>
        <CAJKOXPdNAw8scFKCGaC_hp4jMyLD_mFLKr=+fGKSm6nCkcRF9g@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.43]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 10 Sep 2020 08:58:57 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Thu, 10 Sep 2020 at 08:52, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >
> >
> >
> > On Thursday, September 10, 2020, Peter Rosin <peda@axentia.se> wrote:  
> >>
> >> Hi!
> >>
> >> On 2020-09-09 21:57, Krzysztof Kozlowski wrote:  
> >> > On Wed, 9 Sep 2020 at 20:36, Jonathan Cameron <jic23@kernel.org> wrote:  
> >> >>
> >> >> On Sat, 29 Aug 2020 08:47:16 +0200
> >> >> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >> >>  
> >> >>> Common pattern of handling deferred probe can be simplified with
> >> >>> dev_err_probe().  Less code and also it prints the error value.
> >> >>>
> >> >>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >> >>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >> >>>  
> >> >> I don't have the thread to hand, but this tripped a warning next
> >> >> and the patch was dropped as a result. See below.  

oops. That is what I get for reading an email very quickly then looking
at the code a few hours later.  Still a problem here we need to fix
unless I'm missing something.

> >> >
> >> > Thanks for letting me know. If you mean the warning caused by:
> >> > https://lore.kernel.org/lkml/20200909073716.GA560912@kroah.com/
> >> > then the driver-core patch was dropped, not the iio one:
> >> > https://lore.kernel.org/linux-next/20200909074130.GB561485@kroah.com/T/#t
> >> >
> >> > So we are good here :)  
> >>
> >> No, we are definitely not good. See below. That means "See below", and
> >> not "Please take a guess at what is being talking about".  
> >
> >
> >  
> >>  
> >> >>> @@ -596,12 +594,9 @@ static int stm32_adc_core_switches_probe(struct device *dev,
> >> >>>               priv->booster = devm_regulator_get_optional(dev, "booster");
> >> >>>               if (IS_ERR(priv->booster)) {
> >> >>>                       ret = PTR_ERR(priv->booster);
> >> >>> -                     if (ret != -ENODEV) {
> >> >>> -                             if (ret != -EPROBE_DEFER)
> >> >>> -                                     dev_err(dev, "can't get booster %d\n",
> >> >>> -                                             ret);
> >> >>> -                             return ret;
> >> >>> -                     }
> >> >>> +                     if (ret != -ENODEV)
> >> >>> +                             dev_err_probe(dev, ret, "can't get booster\n");  
> >> >>
> >> >> This tripped a warning and got the patch dropped because we no longer
> >> >> return on error.  
> >>
> >> As Jonathan already said, we no longer return in this hunk. I.e., you have
> >> clobbered the error path.  
> >
> >
> > Exactly my point why I proposed _must_check in the first place.  
> 
> That was not exactly that point as you did not mention possible errors
> but only "miss the opportunity to optimize". Optimization is different
> things than a mistake.

In this particular case we have introduced a bug. If the regulator returns
an error other than -ENODEV we will carry on when really should error out.
This includes deferred probe route in which it won't print a message but also won't
actually defer.

Jonathan


> 
> Best regards,
> Krzysztof
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


