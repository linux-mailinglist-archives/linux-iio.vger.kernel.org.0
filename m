Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C53D25C144
	for <lists+linux-iio@lfdr.de>; Thu,  3 Sep 2020 14:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgICMrD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Sep 2020 08:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgICMqp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Sep 2020 08:46:45 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0C3C061244;
        Thu,  3 Sep 2020 05:46:44 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w16so2856921qkj.7;
        Thu, 03 Sep 2020 05:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aOsGAmtNUymTnEOKjFJ9YOCYVJQ+nk6RK0ByF1/hxrw=;
        b=krqrBQm+2/yYu5kyGdAOA1sv2XukiWqj4o8PKSTaQfo0+K/jDn3nVz4F5y3UfEI0DY
         q0yimp7W157dpH995SoDURJZ8fHtEfb2E27EE9yk2u7SYaFbl5Tpuq2/WwPr0zDfOZhJ
         G3xnj9gwjXsGUTG9QEtpg8tTWbgmB7G7EVddtZUfvBGMzYI+QKWmEXWPM1q25Yykd8zX
         rQHgY59rb5K6/hSdq7VPUEIW/UiHK5NKPH0Szgh4jGrO9lUR7MT2WRaO/z+Hb7kJmAD8
         6IjCs6TJRxRMkNegsLP3Bh59bKumaEqViTfwsXNi3ht0+QkqgAuoLxuBLNX26gFDWXwe
         ZO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOsGAmtNUymTnEOKjFJ9YOCYVJQ+nk6RK0ByF1/hxrw=;
        b=U0nm3zyJIWLlKSCqtZDDKVsbSz2Bwgmh+gYNgQFPfi5vuk91EkTDkND1iXgYfxWHpr
         ElnE2ZomFCXH7LWqjY/6QvpapWE0aNA9DmKDZ2oB5bq4n+fxhgR4vdmv6+xSvfFpLO65
         16gDCZIpsOBHhHE7duV68K6dKpiI9IymhPhZT7qbKakEMnSYdyT8M/+x6UHGOmu6m4zK
         qd6QwgoKWuJVO5MRxM26zAeR4ha4HclzxE1xKoy5Q6yVEdAa1p/IEtjreqk/m3bDgh+s
         5QHYBOIcxjLpz6Ik3qglOStMXss5EGxIJadWBm24zmGAEEZfwih5jGpRwZadZwaqR19z
         Xdkw==
X-Gm-Message-State: AOAM531ujdYWd2ybMl3Sm4KM0lX+BWq1PvwQm7diNTKVKxY41cwqi2sH
        PZSOB8KJ2oVvBJQGFkV0StwZH9V9EAbdfWHM5aM=
X-Google-Smtp-Source: ABdhPJzZCUsqBp3N43hpKtkXbnmEa46NQdYO/iQ5BaKeP4TOv6PZNJmklQ1XC8Uv1VA4b218XASaT1yoxEg0c0jMN5U=
X-Received: by 2002:a05:620a:559:: with SMTP id o25mr2921887qko.262.1599137200221;
 Thu, 03 Sep 2020 05:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200825124711.11455-1-nish.malpani25@gmail.com>
 <20200825124711.11455-3-nish.malpani25@gmail.com> <20200829174845.7fae971d@archlinux>
In-Reply-To: <20200829174845.7fae971d@archlinux>
From:   Nishant Malpani <nish.malpani25@gmail.com>
Date:   Thu, 3 Sep 2020 18:16:28 +0530
Message-ID: <CAEtfd9Z51qm29zECBzQrRGoiL5SuVJ6_=ZMA98gSCxEY6-CH1g@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: iio: gyro: adxrs290: Add required
 interrupts property
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        Darius <darius.berghe@analog.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

On Sat, Aug 29, 2020 at 10:18 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 25 Aug 2020 18:17:10 +0530
> Nishant Malpani <nish.malpani25@gmail.com> wrote:
>
> > Append 'interrupts' as a required property and provide a suitable example
> > for using a GPIO interrupt line.
> >
> > Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
> Hi Nishant,
>
> I don't understand why the interrupt is 'required'.  Also note you should
> never be adding required properties to an existing binding.  It's possible
> someone already used the binding as it stands and shipped a board with
> it burnt in a firmware. (bit unlikely but you never know!)
>
> Jonathan
>

You're right; I hadn't thought of it that way. Will remove the
'interrupts' property from the 'required' ist in v2.

> > ---
> >  .../devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml   | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
> > index 61adb2c2454b..cae593dd1ba7 100644
> > --- a/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
> > +++ b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
> > @@ -28,17 +28,23 @@ properties:
> >
> >    spi-cpha: true
> >
> > +  interrupts:
> > +    maxItems: 1
> > +
> >  required:
> >    - compatible
> >    - reg
> >    - spi-max-frequency
> >    - spi-cpol
> >    - spi-cpha
> > +  - interrupts
>
> Why?  Device works fine without one being supplied.
> It's not uncommon on embedded boards to not wire up interrupts
> due to a lack of pins and just rely on polling.
>

I was under the impression that the triggered-buffer way of capturing
data would more reasonable to the consumers of a gyroscope. But what
you point out makes total sense. Thanks for pointing out. Will fix it
in v2.

With regards,
Nishant Malpani

> >
> >  additionalProperties: false
> >
> >  examples:
> >    - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> >      spi {
> >          #address-cells = <1>;
> >          #size-cells = <0>;
> > @@ -48,6 +54,8 @@ examples:
> >                     spi-max-frequency = <5000000>;
> >                     spi-cpol;
> >                     spi-cpha;
> > +                   interrupt-parent = <&gpio>;
> > +                   interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> >          };
> >      };
> >  ...
>
