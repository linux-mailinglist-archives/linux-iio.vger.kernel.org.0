Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D5726455A
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 13:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgIJLdo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 07:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730255AbgIJLYn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Sep 2020 07:24:43 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEB4C061756;
        Thu, 10 Sep 2020 04:23:28 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 5so4083897pgl.4;
        Thu, 10 Sep 2020 04:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T1jU/BIULwBFdkoPS5XoMOevUkSDj3Vui3wyMh4knhM=;
        b=kOioGQ5evJcV7vpyJ2QT+b8KV74xlfj4V9gz+Gi9EJKijWhwcOR2jiYEUVAY3td3LW
         Y08bH84CTpx8e1jVbrmjV040DNvqg3GLneTw00f6P/lqlxejHGjOK+XxxAmKjlnNDMUH
         1CL7nWgoCi8F9/LMTe4G7vr7hXTULJuAKlEwrpISSp9qOTNqMRqGI9sibilZLgXT+U+x
         2S9vALT5XO91HHsPu7PAVi5LsQ35l8W0H5GMW5/W5UKQpM5mlE55S8I4sHH4fIZRCb4C
         elah9RPrcRcUVGWbTbX8KVhKd0AbE/DLcWiRSNsdVPZ47jX+2LBSaOScguSScmKG/Vhc
         cwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T1jU/BIULwBFdkoPS5XoMOevUkSDj3Vui3wyMh4knhM=;
        b=gVxhj0EYehb9J6fqyMhcyjfcM81GEFbREy+Dq1hW3kurKWHHzgvljrUSyYu+oNF4hK
         Od583C2k3iiGlBmRDWKzdDXdFFk4/pXYlxvKpEN3/52LncE9NjXzJjfcieyhp6/DTg+9
         qHm4Aovw92QtNHsmsX2DS9ygyV/b/P+SvxCh3EodYn06i8IsGUpaXDBnijnDMCaYah0y
         S72R6qEDBTHaLx8G/NQboOHwyTN056RFZGxWqQ/+NxNMQV52BuSbqc7Wz71YoX5JJpmk
         0fbx/2MZWCGatSG7EPql7Hb4v4/MhQrUgcDcnYQ+fv6frlqUGEctk9RHxUVEd3ZbA7Q3
         gDOQ==
X-Gm-Message-State: AOAM533ScDMQMj108uJ9jfPb5mLA5ar0Kbrk2pN7qd3m14vTlfol+Eh8
        hMraFpNhWs5Ij/6vA1pURe62rVWXE4NwKwYRixQ=
X-Google-Smtp-Source: ABdhPJyCj6CWd0QanAzErE/ynm5jwINoiczRiB4v/uRCuGY6oPJwHWMmLybWkZiYlUewNxugqJLfl5R3W8ptoe7SDh4=
X-Received: by 2002:a63:ec4c:: with SMTP id r12mr4011616pgj.74.1599737008099;
 Thu, 10 Sep 2020 04:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200829064726.26268-1-krzk@kernel.org> <20200829064726.26268-8-krzk@kernel.org>
 <20200909193600.41970d8c@archlinux> <CAJKOXPeo8SXWaRmiFG6z+t9jcnaSMRpvRPm2X22Rf6rtEeKVew@mail.gmail.com>
 <a37c69f2-1f16-2680-2716-0c1b77748d55@axentia.se> <CAHp75Vc4-zkkWtOz8w7pA0Vu1yMAVodhPSLQ1NJH4K+j9XD52g@mail.gmail.com>
 <CAJKOXPdNAw8scFKCGaC_hp4jMyLD_mFLKr=+fGKSm6nCkcRF9g@mail.gmail.com>
In-Reply-To: <CAJKOXPdNAw8scFKCGaC_hp4jMyLD_mFLKr=+fGKSm6nCkcRF9g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Sep 2020 14:23:10 +0300
Message-ID: <CAHp75Vc4VdfNeaLH_7MOGLsJLnbyYB+DnSpsyoDx2GDFV2N5Dg@mail.gmail.com>
Subject: Re: [PATCH v3 08/18] iio: adc: stm32: Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 10, 2020 at 9:59 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, 10 Sep 2020 at 08:52, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Thursday, September 10, 2020, Peter Rosin <peda@axentia.se> wrote:
> >> On 2020-09-09 21:57, Krzysztof Kozlowski wrote:
> >> > On Wed, 9 Sep 2020 at 20:36, Jonathan Cameron <jic23@kernel.org> wrote:
> >> >> On Sat, 29 Aug 2020 08:47:16 +0200
> >> >> Krzysztof Kozlowski <krzk@kernel.org> wrote:

...

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

Yes, and that's what happened here. You missed optimization which led
to an error.

And this is a good showcase to see how dev_err_probe() may be misused
because of overlooking subtle details.
Perhaps we can do

static inline __must_check dev_err_probe_ret(...)
{
  return dev_err_probe(...);
}

(or other way around, introduce dev_err_probe_noret(), yes, name sucks)

-- 
With Best Regards,
Andy Shevchenko
