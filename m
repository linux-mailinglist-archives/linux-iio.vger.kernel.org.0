Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C67723126
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2019 12:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfETKSF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 May 2019 06:18:05 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44787 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfETKSF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 May 2019 06:18:05 -0400
Received: by mail-ot1-f66.google.com with SMTP id g18so12433610otj.11
        for <linux-iio@vger.kernel.org>; Mon, 20 May 2019 03:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gXwsAJO0tts828Qbued5BPG7sund0+mXZJvWOgHS3vY=;
        b=iQAITR2y2ALK+DXNVCDoxbPn/16kG/IHjlbxCktgfcJNl3XRt2ANdnqTcmOPzmiyRx
         yXCEUxVVY1AxgcNc47ZyWl6Vs9NKKXUG6JKcv0d3259jZNud3yZGuBlerBbVQIwZbyO3
         XJqOUSu3CXfkkIssP/9Eb8rgAXX0AijpE1E2ywHdyHRLXRFFrg+qhI36pxTMhrYFbDlO
         +DrnMKW4jpr8b1GkxgDAiR00f6M8CA9ayBO46IfzmSHV+YqO5wd1XCbX2Ku0xS17pYac
         g0ryZOuCKK/P/Nt5Bx0/vq+BZDUei0kkAk8KDBahsze3Qw+mTnySlp7cr8Ndf3JCd6SW
         2SMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gXwsAJO0tts828Qbued5BPG7sund0+mXZJvWOgHS3vY=;
        b=h5ibBwxCPnd9/Fjx8kTSiIHcGs+JBuoKTS5+76+Xtlg9aQ6NWqeO2l4J2N1saIemXv
         A4jIF8tiW/50Lsw+X/FXWtlKe7PrMhVDMrA5ZA7DMFNzmTdg8oznC9MVQsJvjr5XqEDJ
         AWvwWWA+xdJLjWfGO2oAr9UI3hxC1ZDel8sbpEBDhAhaRBV9EnGNQVAW2FZyAdTeIBwY
         a19ExIt+pEOtge+Cr3WZUvm8BVWMMWBXc5sOqjvoSoWQB9YSf5TbnjZ11bpREI4jKDJB
         lbUGm72DBesMoRl5X5l1mAncaV3CPD3PWC5qarSEbahPcwcpLELqcD5tOhh2YUweyDfO
         GYCQ==
X-Gm-Message-State: APjAAAUHgfCpT7MoRG4yvLczrWQavBN4/fQwsWpV4Y2eM1KWPgEahVDp
        JUxIY6r/Etxv1199Doy/TejdofmGgYRawzQNlMs=
X-Google-Smtp-Source: APXvYqx7pLD341rUTybvnarwr59FGhzs0WWXDMkINehHblzHMzqOx8qCzoVTCfM8JUX/BB/ldjQ4+ERk7eqLLRsEDDs=
X-Received: by 2002:a05:6830:1386:: with SMTP id d6mr14534603otq.149.1558347484552;
 Mon, 20 May 2019 03:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190518221558.21799-1-tallysmartins@gmail.com>
 <20190518221558.21799-2-tallysmartins@gmail.com> <20190519121747.0e7b5824@archlinux>
In-Reply-To: <20190519121747.0e7b5824@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 20 May 2019 13:17:53 +0300
Message-ID: <CA+U=DsqCpBrOoZR0HcQVO6B3TVtsF=rC3DHcLLh8isj7i=dpwg@mail.gmail.com>
Subject: Re: [PATCH 2/2] staging: iio: ad2s1210: Add devicetree yaml doc
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Tallys Martins <tallysmartins@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.or>, kernel-usp@googlegroups.com,
        Souza Guilherme <gdsdsilva@inf.ufpel.edu.br>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 19, 2019 at 8:18 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 18 May 2019 19:15:58 -0300
> Tallys Martins <tallysmartins@gmail.com> wrote:
>

CC-ing my work-email
There are some issues with it and mailing lists; I'll hopefully sort
them out in the next weeks.

> > The driver currently has no devicetree documentation. This commit adds =
a
> > devicetree folder and documentation for it. Documentation must be moved
> > as well when the driver gets out of staging.
> >
> > Signed-off-by: Tallys Martins <tallysmartins@gmail.com>
> > Signed-off-by: Souza Guilherme <gdsdsilva@inf.ufpel.edu.br>
> > Co-developed-by: Souza Guilherme <gdsdsilva@inf.ufpel.edu.br>
>
> Hi,
>
> There is no need for a direct relationship between a binding and a driver
> at all. As such, we normally don't take binding documents in staging.
>
> Just put it directly in it's final destination.  The driver can catch
> up with it later!
>
> I'm still not that comfortable with yaml (haven't gotten around
> to doing any conversions myself yet) so I'll be looking for additional
> review on these from others.

Personal note: I also don't like YAML, but that may be me feeling old.
I'm not that old to prefer XML, but old enough to prefer JSON.
I am still trying to accommodate my taste/feeling for the format, even
though I've been using it sporadically for ~5 years now in various
other elements.
Travis-CI may be the biggest user of it.
Looks like Ruby users were the biggest pushers/initiators of YAML, and
Python people seem to have jumped in shortly after.

Oh well: =C2=AF\_(=E3=83=84)_/=C2=AF

>
> A few comments inline.
>
> > ---
> >  .../Documentation/devicetree/ad2s1210.yaml    | 41 +++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >  create mode 100644 drivers/staging/iio/Documentation/devicetree/ad2s12=
10.yaml

Maybe also remove the old txt binding if adding this new one.
No need to keep them both.

> >
> > diff --git a/drivers/staging/iio/Documentation/devicetree/ad2s1210.yaml=
 b/drivers/staging/iio/Documentation/devicetree/ad2s1210.yaml
> > new file mode 100644
> > index 000000000000..733aa07b4626
> > --- /dev/null
> > +++ b/drivers/staging/iio/Documentation/devicetree/ad2s1210.yaml
> > @@ -0,0 +1,41 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/iio/ad2s1210.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: |
> > +  Analog Devices Inc. AD2S1210 10-Bit to 16-Bit R/D Converters
> > +
> > +maintainers:
> > +  - Graff Yang <graff.yang@gmail.com>
> I would check that one with the Analog devices team.

I guess, add (here):
Michael Hennerich <michael.hennerich@analog.com>

>
> > +
> > +description: |
> > +  Analog Devices AD2S1210 Resolver to Digital SPI driver
> > +
> > +  https://www.analog.com/en/products/ad2s1210.html
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad2s1210

These 2 are required here, since this chip operates in SPI mode 3.

spi-cpha:  true

spi-cpol: true

Also, from the driver, some GPIOs should also be documented:

static const struct ad2s1210_gpio gpios[] =3D {
        [AD2S1210_SAMPLE] =3D { .name =3D "adi,sample", .flags =3D GPIOD_OU=
T_LOW },
        [AD2S1210_A0] =3D { .name =3D "adi,a0", .flags =3D GPIOD_OUT_LOW },
        [AD2S1210_A1] =3D { .name =3D "adi,a1", .flags =3D GPIOD_OUT_LOW },
        [AD2S1210_RES0] =3D { .name =3D "adi,res0", .flags =3D GPIOD_OUT_LO=
W },
        [AD2S1210_RES1] =3D { .name =3D "adi,res1", .flags =3D GPIOD_OUT_LO=
W },
};

So,

adi,sample-gpios:
adi,a0-gpios:
adi,a1-gpios:
adi,res0-gpios:
adi,res10-gpios:

These also look like they are required.

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clock-frequency:
> > +    minimum: 2000
> > +    maximum: 20000
> > +    default: 8192
> This doesn't look like a modern clock binding.
> If we are going to end up changing this, then we should probably delay
> having a binding doc until after that change is made.
>
> We often only do binding docs for drivers in staging just before moving
> them out so as to avoid this sort of issue.

These clock properties are not needed here.

>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +examples:
> > +  - |
> > +  resolver@0 {
> > +    compatible =3D "adi,ad2s1210";
> > +    reg =3D <0>;
> An example is probably more useful if it includes all the optional proper=
ties
> as well.

This should also be included in an spi block:
So:

spi0 {
       resolver@0 {
            compatible =3D "adi,ad2s1210";
            reg =3D <0>;
            spi-cpha;
            spi-cpol;
            // and then the adi,***-gpios I think here
       };
};

I don't think much more-else is needed for this driver.

> > +  };
> > +...
>
> Thanks,
>
> Jonathan
>
