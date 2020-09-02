Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB9225B454
	for <lists+linux-iio@lfdr.de>; Wed,  2 Sep 2020 21:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgIBTSg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Sep 2020 15:18:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgIBTSe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 2 Sep 2020 15:18:34 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9E1320E65;
        Wed,  2 Sep 2020 19:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599074314;
        bh=bj4ZIsKT/Jh/DzKW3wY2SgrI7QXyJCc+8lJsbBsAuy4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gu6D2IzeCZ2HtwN4X2eeNuyWUuztpIcFBW/A8RboxT7WdBHw2KVjcYeOFrIAZo0MH
         Xnpcgx2YO8M7mrxbOTFe5pRwLfIpPuHYegoZIava8l4i59MwMbyrtNtWcj5NhGj/v5
         XucaAJ5Ck+t9uIHRyOgBMUZ/TQEVh56loyTsG4GU=
Received: by mail-ej1-f44.google.com with SMTP id i26so217591ejb.12;
        Wed, 02 Sep 2020 12:18:33 -0700 (PDT)
X-Gm-Message-State: AOAM532rRpU+2Swp2DO60+5SiQgCn4WH4nvYZybMn/kcUtdZf5Bb+T5Q
        WWWN0x5SwZgJez3x6NT0x4YMhtyEOygs2XPkOGY=
X-Google-Smtp-Source: ABdhPJybyWYa5Mw6aDof5IdFGPJRJbQu/QpPibfDxauEMG/A/ccQ/Mhm86RvJbFQrFM1yJDbUl3wBa8m3mIM7e6eZ1k=
X-Received: by 2002:a17:906:3b4b:: with SMTP id h11mr1491517ejf.381.1599074312251;
 Wed, 02 Sep 2020 12:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200902145957.13861-1-krzk@kernel.org> <CAHp75Vd3sT6Vuovsy8YQg+pdqQd3s4vU8PQNNQvUruKZOiRSAw@mail.gmail.com>
 <c481fb32b071c02fe21fe669c0e67117b16386dd.camel@perches.com>
In-Reply-To: <c481fb32b071c02fe21fe669c0e67117b16386dd.camel@perches.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 2 Sep 2020 21:18:19 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfRp6e9barifViCA4mp2EFmR71Ld2Y3EA++-rhW49JnAA@mail.gmail.com>
Message-ID: <CAJKOXPfRp6e9barifViCA4mp2EFmR71Ld2Y3EA++-rhW49JnAA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] MAINTAINERS: Consolidate Analog Devices IIO
 entries and remove Beniamin Bia
To:     Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2 Sep 2020 at 20:54, Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2020-09-02 at 21:11 +0300, Andy Shevchenko wrote:
> > On Wed, Sep 2, 2020 at 6:04 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > Emails to Beniamin Bia bounce with no such address so remove him from
> > > maintainers.  After this removal, many entries for Analog Devices Inc
> > > IIO drivers look exactly the same so consolidate them.
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > But nit-pick below.
> []
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> []
> > > @@ -1152,8 +1101,12 @@ W:       http://wiki.analog.com/
> > >  W:     http://ez.analog.com/community/linux-device-drivers
> > >  F:     Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
> > >  F:     Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
> > > +F:     Documentation/devicetree/bindings/iio/adc/adi*
> > > +F:     Documentation/devicetree/bindings/iio/amplifiers/adi*
> >
> > I would rather see one line like
> > F:     Documentation/devicetree/bindings/iio/*/adi,*

Good point.

>
> Maybe the ones outside of iio too?
>
> $ find Documentation/ -wholename "*/adi,*"
> Documentation/devicetree/bindings/net/adi,adin.yaml
> Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt
> Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
> Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
> Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
> Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
> Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> Documentation/devicetree/bindings/display/bridge/adi,adv7511.txt
> Documentation/devicetree/bindings/spi/adi,axi-spi-engine.txt
> Documentation/devicetree/bindings/sound/adi,adau7002.txt
> Documentation/devicetree/bindings/sound/adi,adau1977.txt
> Documentation/devicetree/bindings/sound/adi,adau7118.yaml
> Documentation/devicetree/bindings/sound/adi,axi-i2s.txt
> Documentation/devicetree/bindings/sound/adi,adau17x1.txt
> Documentation/devicetree/bindings/sound/adi,ssm2305.txt
> Documentation/devicetree/bindings/sound/adi,adau1701.txt
> Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt
> Documentation/devicetree/bindings/sound/adi,ssm2602.txt
> Documentation/devicetree/bindings/mux/adi,adgs1408.txt
> Documentation/devicetree/bindings/mux/adi,adg792a.txt
> Documentation/devicetree/bindings/dma/adi,axi-dmac.txt
> Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
> Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
> Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
> Documentation/devicetree/bindings/hwmon/adi,ltc2947.yaml

These might be different entries, different subsystems. Even if
devices in hwmon could be similar to iio, but sound is something else.

Best regards,
Krzysztof
