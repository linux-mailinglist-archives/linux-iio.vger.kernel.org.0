Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8AF3ED41C
	for <lists+linux-iio@lfdr.de>; Mon, 16 Aug 2021 14:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbhHPMlA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Aug 2021 08:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbhHPMkG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Aug 2021 08:40:06 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E653C061796;
        Mon, 16 Aug 2021 05:39:32 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id n11so14005384qkk.1;
        Mon, 16 Aug 2021 05:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=5AngW8YnH2bBvvJ2iUVtLSJUllib7jnVTIimPTcWaRY=;
        b=KcBKXBC4VncaPthNtFvRbNGsY2mjuh8fT49RoRjs4sZlA0N35uGAXEguwPjyYgm+VL
         LOk5qQyDY3k+GL9SvbS4/ZC5fyuwQTxwCiFOzu/Dgd/oqb+n4iRTy8LjJ3W2ux+dN4np
         9xvSvDCBroDw1DSagCytU/W28HaJa+FbY8jbzif8ey+sNGOmV8PV/LOOFPP/IgjAWuiz
         TEGY1OolnpW3N9KQscv5+yh+KxXKKOaExcnX9Xs09zxFuRc23Z4DDn19Fd/fzmanGHe3
         Ajdv2nG2I9uAgiEFLsVuPqN52cxbsg3QsCVTkL3D98y5W3prFKYhGSj+GfOBQ0Ipll8s
         7P+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=5AngW8YnH2bBvvJ2iUVtLSJUllib7jnVTIimPTcWaRY=;
        b=a8wukj5ImwNRsFBJXrdLXyih6zrgZoKyvNO+DhJOUQOV+xp4HnhpHvzZNZwCcTN1qi
         8YvuqBpX9lF6Jb2jb5YYRPh6TFDwnOg58dF0iBN6V8Ofr4YgyyCEzTzasq16IcKXIfMO
         nu9BTB3yCdhSJwuCSgMej3hfIBz22YHzO01B4r2ZcvxhVRFrZr1P97Re6EbfnUOvRJfm
         RQE9tjcox7YxuMEsHGka17zKnrHQTJ0HALzTOsWM68nalN95fTPn15uLAIgUj4XGPSn2
         RlXAt6Sep9JhJh7dl7NIW/wG8fXcQaoQw1F24SKTQO8Chqs0R2EZXP8jsWfK5jqmuiud
         4nqA==
X-Gm-Message-State: AOAM531LpwEQ0ikn5MEqEQduL5INgEQ9QlVy1PstvqxcWalLyWx1D/Z+
        1GMTDP/NlQXVXk9lAKgANI8=
X-Google-Smtp-Source: ABdhPJxG9zATTGdIZbGWnZXkrXcXYG+ALQRYRS5Q7pNocY8rLsBZ2LDWIYAbFg5NrkFUSjxGwDnrbQ==
X-Received: by 2002:a05:620a:f91:: with SMTP id b17mr15627824qkn.107.1629117571707;
        Mon, 16 Aug 2021 05:39:31 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id l14sm4754286qtj.26.2021.08.16.05.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 05:39:31 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 16 Aug 2021 08:39:30 -0400
Message-Id: <CDKXZBW1JDOD.1ZXIT12Y3WK5B@shaak>
Cc:     "Lars-Peter Clausen" <lars@metafoo.de>,
        "Michael Hennerich" <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        "Charles-Antoine Couret" <charles-antoine.couret@essensium.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <Nuno.Sa@analog.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "linux-iio" <linux-iio@vger.kernel.org>,
        "devicetree" <devicetree@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>
Subject: Re: [PATCH v6 3/5] iio: adc: ad7949: add vref selection support
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Andy Shevchenko" <andy.shevchenko@gmail.com>
References: <20210815213309.2847711-1-liambeguin@gmail.com>
 <20210815213309.2847711-4-liambeguin@gmail.com>
 <CAHp75Vd-AfmwMyYyy5ygwmvGfwZLh9VwvBEzSwW3fc99jxFpnQ@mail.gmail.com>
In-Reply-To: <CAHp75Vd-AfmwMyYyy5ygwmvGfwZLh9VwvBEzSwW3fc99jxFpnQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon Aug 16, 2021 at 4:04 AM EDT, Andy Shevchenko wrote:
> On Mon, Aug 16, 2021 at 12:35 AM Liam Beguin <liambeguin@gmail.com>
> wrote:
> >
> > From: Liam Beguin <lvb@xiphos.com>
> >
> > Add support for selecting the voltage reference from the devicetree.
> >
> > This change is required to get valid readings with all three
> > vref hardware configurations supported by the ADC.
> >
> > For instance if the ADC isn't provided with an external reference,
> > the sample request must specify an internal voltage reference to get a
> > valid reading.
>
> ...
>
> > +       /* Setup internal voltage reference */
> > +       tmp =3D 4096000;
> > +       ret =3D device_property_read_u32(dev, "adi,internal-ref-microvo=
lt", &tmp);
>
> > +       if (ret < 0 && ret !=3D -EINVAL) {

Hi Andy,

>
> What does this check (second part) is supposed to mean?
> The first part will make it mandatory, is it the goal?
>

device_property_read_u32() will return -EINVAL if the property isn't
found in the devicetree.

This checks for errors when the property is defined while keeping it
optional.

Liam

> > +               dev_err(dev, "invalid value for adi,internal-ref-microv=
olt\n");
> > +               return ret;
> > +       }
>
> --
> With Best Regards,
> Andy Shevchenko

