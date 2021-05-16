Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1775E382045
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 20:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhEPSPV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 14:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhEPSPU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 May 2021 14:15:20 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3804FC061573;
        Sun, 16 May 2021 11:14:05 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id v4so3397771qtp.1;
        Sun, 16 May 2021 11:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:from:to:cc
         :subject:references:in-reply-to;
        bh=A10QVI63ZnZaEwuZVcvvWXL6QCvI3g5Ffr4RSYcvmsU=;
        b=QiKHl+MrpHxo+WCvelIu7kydY1Vn0quJnq7WdUD/5ntDFBAkGkP6E9YQXPS0hoSMVK
         z9VEsANA/awWcmVF8s5mvEZScXzD5MpCgdc1AUsKDBmOE/U6kiIcEvaYDRpyTdobiiTm
         NHQK4ntkyx94yoTbQIbG4lEW7N2/k6sZMgj+qXg9EQqfRtJ2nVDU0WWj3r1pw/iP2Qvl
         d4AF/hJ5bdTTT2qsvQYw8mFzCrpAuqn73OYKrk6HejiVcSaXQbVOqgT6qeDN/5EmmjEo
         nTT2IekEeCjrIx1EKPepPy8NklTFXctOyB2QNHyWBwEtUywIZXVoVyi/t951fSnOa7jx
         KsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:from:to:cc:subject:references:in-reply-to;
        bh=A10QVI63ZnZaEwuZVcvvWXL6QCvI3g5Ffr4RSYcvmsU=;
        b=BCLZRKSYMaprSeDv6GVflAcGllkQ8lPEoQ4hqiIDxl+CyVMm96EBusMVxqg/WO0kNq
         tnjYGm2hVr7sHK7Q+MP2mV+gEWJRIZwrPoOwNClHZb1CB97lDTrVEUPXz6uX31/PGjpr
         HuvRgkTMDwW62AkeiAB4Qh5iZTQh7pEZwswdKiqIDiT8HbofrIQCEVZRRAKpTuWhIpMl
         Ej0nNfRLZu28nlWsOAR1ZQD3R1I6I6R6x02i9TtD7Sxf8EiEURac7jwIXUxIw8GZSpMG
         AiSQPyWEw3R9PBDWP4f4fLPqBdCteEIzxpDFqrTXfuzXEIq2gngARU4SUFayCsEQvJmk
         d8MQ==
X-Gm-Message-State: AOAM532GFpKAR6OwtQs4JsPqZjowqMbAFsrHobeBtAsqrc6oANNFvJdh
        P+09fsB5+ZIYLak+r4Sl4N+nBK+dVae8hw==
X-Google-Smtp-Source: ABdhPJxjHtYy7hiP/faV1yjmuHhffGJkp7KWujxD9Vl19H0DGlRSAz5drA+71RG17tpKHeXNiEwWMQ==
X-Received: by 2002:a05:622a:350:: with SMTP id r16mr51130966qtw.27.1621188844299;
        Sun, 16 May 2021 11:14:04 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id s190sm8845581qkc.40.2021.05.16.11.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 May 2021 11:14:03 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 16 May 2021 14:14:02 -0400
Message-Id: <CBEVHCPHGJJD.2IDUUG1RPDF64@shaak>
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Jonathan Cameron" <jic23@kernel.org>,
        "Guenter Roeck" <linux@roeck-us.net>
Cc:     <jdelvare@suse.com>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, "Peter Rosin" <peda@axentia.se>
Subject: Re: [RFC PATCH v1 0/2] hwmon: (iio_hwmon) optionally force iio
 channel type
References: <20210516044315.116290-1-liambeguin@gmail.com>
 <20210516100631.7310a7bb@jic23-huawei> <CBEREZMZ2Z8U.13BH8G7RKPPL7@shaak>
 <e56146c5-2bff-3a6d-b54e-fd40993f82aa@roeck-us.net>
 <20210516172618.2d7ad168@jic23-huawei>
In-Reply-To: <20210516172618.2d7ad168@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun May 16, 2021 at 12:26 PM EDT, Jonathan Cameron wrote:
> On Sun, 16 May 2021 08:54:06 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
>
> > On 5/16/21 8:02 AM, Liam Beguin wrote:
> > > Hi Jonathan,
> > >=20
> > > On Sun May 16, 2021 at 5:06 AM EDT, Jonathan Cameron wrote: =20
> > >> On Sun, 16 May 2021 00:43:13 -0400
> > >> Liam Beguin <liambeguin@gmail.com> wrote:
> > >> =20
> > >>> Add a devicetree binding to optionally force a different IIO channe=
l
> > >>> type.
> > >>>
> > >>> This is useful in cases where ADC channels are connected to a circu=
it
> > >>> that represent another unit such as a temperature or a current.
> > >>>
> > >>> `channel-types` was chosen instead of `io-channel-types` as this is=
 not
> > >>> part of the iio consumer bindings.
> > >>>
> > >>> In the current form, this patch does what it's intended to do:
> > >>> change the unit displayed by `sensors`, but feels like the wrong wa=
y to
> > >>> address the problem.
> > >>>
> > >>> Would it be possible to force the type of different IIO channels fo=
r
> > >>> this kind of use case with a devicetree binding from the IIO subsys=
tem?
> > >>>
> > >>> It would be convenient to do it within the IIO subsystem to have th=
e
> > >>> right unit there too.
> > >>>
> > >>> Thanks for your time,
> > >>> Liam =20
> > >>
> > >> Hi Liam,
> > >>
> > >> +CC Peter for AFE part.
> > >>
> > >> It's an interesting approach, but I would suggest we think about thi=
s
> > >> a different way.
> > >>
> > >> Whenever a channel is being used to measure something 'different' fr=
om
> > >> what it actually measures (e.g. a voltage ADC measuring a current) t=
hat
> > >> reflects their being some analog component involved.
> > >> If you look at drivers/iio/afe/iio-rescale.c you can see the approac=
h
> > >> we currently use to handle this. =20
> > >=20
> > > Many thanks for pointing out the AFE code. That look like what I was
> > > hoping to accomplish, but in a much better way.
> > >  =20
> > >>
> > >> Effectively what you add to devicetree is a consumer of the ADC chan=
nel
> > >> which in turn provides services to other devices. For this current c=
ase
> > >> it would be either a current-sense-amplifier or a current-sense-shun=
t
> > >> depending on what the analog front end looks like. We have to descri=
be
> > >> the characteristics of that front end which isn't something that can
> > >> be done via a simple channel type.
> > >> =20
> > >=20
> > > Understood. My original intention was to use sensors.conf to do the
> > > conversions and take into accounts those parameters.
> > >  =20
> > >> That afe consumer device can then provide services to another consum=
er
> > >> (e.g. iio-hwmon) which work for your usecase.
> > >>
> > >> The main limitation of this approach currently is you end up with
> > >> one device per channel. That could be improved upon if you have a
> > >> usecase
> > >> where it matters.
> > >>
> > >> I don't think we currently have an equivalent for temperature sensin=
g
> > >> but it would be easy enough to do something similar. =20
> > >=20
> > > Wonderful, thanks again for pointing out the AFE!
> > >  =20
> >=20
> > Please don't reinvent the ntc_thermistor driver.

> Agreed, I'd forgotten it existed :( Had a feeling we'd solved that
> problem before
> but couldn't remember the name of the driver.
>
> The afe driver already deals with current / voltage scaling and
> conversion
> for common analog circuits. Potential dividers, current shunts etc, but
> they
> are all the linear cases IIRC.
>
> ntc_thermistor deals with the much more complex job of dealing with a
> thermistor.

I agree, no need to reinvent this.

Like Jonathan said, the ntc_thermistor driver seems to handle much more
complex cases. Where would be the best place to add support for PT100
and PT1000? iio-rescale?

Thanks,
Liam

>
> Thanks,
>
> Jonathan
>
> >=20
> > Thanks,
> > Guenter
> >=20
> > > Liam
> > >  =20
> > >>
> > >> Jonathan
> > >>
> > >> =20
> > >>>
> > >>> Liam Beguin (2):
> > >>>    hwmon: (iio_hwmon) optionally force iio channel type
> > >>>    dt-bindings: hwmon: add iio-hwmon bindings
> > >>>
> > >>>   .../devicetree/bindings/hwmon/iio-hwmon.yaml  | 41 ++++++++++++++=
+++++
> > >>>   drivers/hwmon/iio_hwmon.c                     |  2 +
> > >>>   2 files changed, 43 insertions(+)
> > >>>   create mode 100644 Documentation/devicetree/bindings/hwmon/iio-hw=
mon.yaml
> > >>>
> > >>>
> > >>> base-commit: 9f4ad9e425a1d3b6a34617b8ea226d56a119a717 =20
> > >  =20
> >=20

