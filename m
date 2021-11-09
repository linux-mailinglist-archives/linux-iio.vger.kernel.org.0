Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318FC44AD05
	for <lists+linux-iio@lfdr.de>; Tue,  9 Nov 2021 12:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbhKIL7m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Nov 2021 06:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbhKIL7l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Nov 2021 06:59:41 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE812C061764;
        Tue,  9 Nov 2021 03:56:55 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id az37so37950146uab.13;
        Tue, 09 Nov 2021 03:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=zF7zWyPkws0daJATKw16m2eAaCLss4SIeuJrKPXaNkY=;
        b=HyW7zwK4N6jkoBGlaPvCVIwme4vRFBHGR/NdupJ5A1ykIjug0vp9DqiVgx6uk2RJJa
         9RGRs1VcRt+vLo4zMV8LZjH36ItgiuN7Y+bXyV/ywm3NFSM8XsUxrhZGy2VFR88Zw+AZ
         CFAxy8uFJ45mJ0BBmC04tTW7ijlNKvrn4Dwb/xlMMV8FiKN3dXAAuBHONbGslzjgEYw0
         oGYlJlSI4DucKU4qnE982t6Y7FHG51npsOneoqWc9skKM37ojcA2EpgLMKahq9k/okY8
         1L6TlbrkXfhS3PPltZj5NGOdea0JELjhlD0/SRIXNbKurbK+MxRb9MpkFOXANnIPa/7d
         Hgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=zF7zWyPkws0daJATKw16m2eAaCLss4SIeuJrKPXaNkY=;
        b=Nu3Sz7Rhx14HPoDEO+MsCRoeWQiHOZFsXIDKffUZIJxtLGwp/UIO1a3+ihzC+OqUtv
         d4yf7L97yIDLSOt+Sa89+u9QrqiDFcBTemHj5ISrCU+yyKdqJaGddUXm7hBO9cSZ+Hkd
         S4w9rq5KN4JiSNA3fa/av2ewMHjKJLDubaybXH2sC9giv1G7R4wH7uBmJgRWlNM0ciHj
         x/RjPUVrclnD/MMMllAH/CHr3Ize8NKItqxZIdM4yazMQ1ltp4NvBMMftE6iml2wHPwv
         ULgadmpG80MIY+r0uepPBA+dArd8QuIBEdZcEN7QNZPOd9zf6uK/P9YAA1Ss0imwRful
         1cMg==
X-Gm-Message-State: AOAM530g91wI235lBFMTpihipoyxvwrazOINDd9vDYC6qngUodjh9vs6
        sEL8OCBXm6lAiw32Nf/tHi4/vgXWeuEM7oJhV0U=
X-Google-Smtp-Source: ABdhPJwQIeOmEoIm6aGu1+L2phcrmG1y1ZtokXziAOa3rvkrcyrTXxkhTDDxVVLB6sEq1GMNbP4bbP+tQF+ckCFE/xU=
X-Received: by 2002:a05:6102:3166:: with SMTP id l6mr30092957vsm.51.1636459015051;
 Tue, 09 Nov 2021 03:56:55 -0800 (PST)
MIME-Version: 1.0
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20211028101840.24632-1-andrea.merello@gmail.com> <20211028101840.24632-11-andrea.merello@gmail.com>
 <85ef90ad-0d3a-6cb7-529f-667562b2ad71@infradead.org>
In-Reply-To: <85ef90ad-0d3a-6cb7-529f-667562b2ad71@infradead.org>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Tue, 9 Nov 2021 12:56:43 +0100
Message-ID: <CAN8YU5NiKz2JiNr-47OC4==N8L67HDshuH45BifnHBae+GUU-g@mail.gmail.com>
Subject: Re: [v2 10/10] iio: imu: add BNO055 I2C driver
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Il giorno ven 29 ott 2021 alle ore 00:04 Randy Dunlap
<rdunlap@infradead.org> ha scritto:
>
> On 10/28/21 3:18 AM, Andrea Merello wrote:
> > This path adds an I2C driver for communicating to a BNO055 IMU via I2C bus
> > and it enables the BNO055 core driver to work in this scenario.
> >
> > Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> > ---
> >   drivers/iio/imu/bno055/Kconfig      |  6 ++++
> >   drivers/iio/imu/bno055/Makefile     |  1 +
> >   drivers/iio/imu/bno055/bno055_i2c.c | 54 +++++++++++++++++++++++++++++
> >   3 files changed, 61 insertions(+)
> >   create mode 100644 drivers/iio/imu/bno055/bno055_i2c.c
> >
> > diff --git a/drivers/iio/imu/bno055/Kconfig b/drivers/iio/imu/bno055/Kconfig
> > index 941e43f0368d..87200787d548 100644
> > --- a/drivers/iio/imu/bno055/Kconfig
> > +++ b/drivers/iio/imu/bno055/Kconfig
> > @@ -7,3 +7,9 @@ config BOSH_BNO055_SERIAL
> >       tristate "Bosh BNO055 attached via serial bus"
> >       depends on SERIAL_DEV_BUS
> >       select BOSH_BNO055_IIO
> > +
> > +config BOSH_BNO055_I2C
> > +     tristate "Bosh BNO055 attached via I2C bus"
> > +     depends on I2C
> > +     select REGMAP_I2C
> > +     select BOSH_BNO055_IIO
>
> Hi,
>
> The config entries that have user prompt strings should also
> have help text.  scripts/checkpatch.pl should have told you
> about that...

I'll add it, thanks. But FYI checkpatch doesn't complain about that here.

> --
> ~Randy
