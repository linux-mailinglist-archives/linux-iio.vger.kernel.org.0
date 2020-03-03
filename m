Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C701B177BFB
	for <lists+linux-iio@lfdr.de>; Tue,  3 Mar 2020 17:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgCCQef (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Mar 2020 11:34:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729382AbgCCQef (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Mar 2020 11:34:35 -0500
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A89E214D8;
        Tue,  3 Mar 2020 16:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583253274;
        bh=040NxJov27zi2kpuEFE/fkgPEuBn6cFOe57ed0NlmXw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0OkZ88X7x23SXQDFnEHTH7GYDZfGoMfVmrHt+OIFTKRzij5MSL40RB88NY1VOd6lj
         s+xGB1l+P9dENTDQS2MJ42gwFRwS/d8AkVRep5dVOgXHMLXA3ZBKJ1aQGd/XFErQHn
         c0sDitgPhUsEBwgaeh/+BASrNzQADeqqiFzHHAVo=
Received: by mail-qv1-f48.google.com with SMTP id ea1so1943921qvb.7;
        Tue, 03 Mar 2020 08:34:34 -0800 (PST)
X-Gm-Message-State: ANhLgQ1isXFEuRJW4wZiu6U7s5s0vFt5hh1gxiVnJZxjKR9695acW0n2
        pBTAkcvwcAh5HJAKfEvlPggXiUe0DW3vHAGCFA==
X-Google-Smtp-Source: ADFU+vuUWwCQpXqxzwroYvAR0PB55wCGn+p0NXTooSsdWNMkPzFMrO6gdKsWNueviXZ4c8D6stIkxMpo4uQsvUjbAsk=
X-Received: by 2002:ad4:4593:: with SMTP id x19mr1088256qvu.79.1583253273312;
 Tue, 03 Mar 2020 08:34:33 -0800 (PST)
MIME-Version: 1.0
References: <20200225124152.270914-1-nuno.sa@analog.com> <20200225124152.270914-6-nuno.sa@analog.com>
 <20200302222254.GA27619@bogus> <1054e87af61518d73dfcb0995e7aab7484e81630.camel@analog.com>
 <5661b3f80a7fd041989b30d2f9ca76bfa762499d.camel@analog.com>
In-Reply-To: <5661b3f80a7fd041989b30d2f9ca76bfa762499d.camel@analog.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 3 Mar 2020 10:34:19 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJU_C6OU+x1LxSX=rBjLtiaOcmdwR+_8LyKd094XMJ08A@mail.gmail.com>
Message-ID: <CAL_JsqJU_C6OU+x1LxSX=rBjLtiaOcmdwR+_8LyKd094XMJ08A@mail.gmail.com>
Subject: Re: [PATCH 5/5] dt-bindings: iio: Add adis16475 documentation
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 3, 2020 at 3:59 AM Sa, Nuno <Nuno.Sa@analog.com> wrote:
>
> On Tue, 2020-03-03 at 09:43 +0000, Sa, Nuno wrote:
> > [External]
> >
> > On Mon, 2020-03-02 at 16:22 -0600, Rob Herring wrote:
> > > On Tue, Feb 25, 2020 at 01:41:52PM +0100, Nuno S=C3=A1 wrote:
> > > > Document the ADIS16475 device devicetree bindings.
> > > >
> > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > ---
> > > >  .../bindings/iio/imu/adi,adis16475.yaml       | 130
> > > > ++++++++++++++++++
> > > >  MAINTAINERS                                   |   1 +
> > > >  2 files changed, 131 insertions(+)
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> > > > b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> > > > new file mode 100644
> > > > index 000000000000..c0f2146e000c
> > > > --- /dev/null
> > > > +++
> > > > b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> > > > @@ -0,0 +1,130 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/iio/imu/adi,adis16475.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Analog Devices ADIS16475 and similar IMUs
> > > > +
> > > > +maintainers:
> > > > +  - Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > +
> > > > +description: |
> > > > +  Analog Devices ADIS16475 and similar IMUs
> > > > +
> > > > https://www.analog.com/media/en/technical-documentation/data-sheets=
/ADIS16475.pdf
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - adi,adis16475-1
> > > > +      - adi,adis16475-2
> > > > +      - adi,adis16475-3
> > > > +      - adi,adis16477-1
> > > > +      - adi,adis16477-2
> > > > +      - adi,adis16477-3
> > > > +      - adi,adis16470
> > > > +      - adi,adis16465-1
> > > > +      - adi,adis16465-2
> > > > +      - adi,adis16465-3
> > > > +      - adi,adis16467-1
> > > > +      - adi,adis16467-2
> > > > +      - adi,adis16467-3
> > > > +      - adi,adis16500
> > > > +      - adi,adis16505-1
> > > > +      - adi,adis16505-2
> > > > +      - adi,adis16505-3
> > > > +      - adi,adis16507-1
> > > > +      - adi,adis16507-2
> > > > +      - adi,adis16507-3
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  spi-cpha: true
> > > > +
> > > > +  spi-cpol: true
> > > > +
> > > > +  spi-max-frequency:
> > > > +    maximum: 2000000
> > > > +
> > > > +  interrupts:
> > > > +    maxItems: 1
> > > > +
> > > > +  clocks:
> > > > +    maxItems: 1
> > > > +
> > > > +  clock-names:
> > > > +    oneOf:
> > > > +      - const: sync
> > > > +      - const: direct-sync
> > > > +      - const: pulse-sync
> > > > +      - const: scaled-sync
> > >
> > > According to the datasheet I looked at, the input is called 'sync'.
> > > It
> > > looks like you are mixing operating mode and clock connection.
> >
> > The sync pin is where the external clock should be connected (when
> > available). I'm kinda of using the clock-name property as a way of
> > selecting the mode the user wants to use as done in other devices (
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
> > ). In the end, what we should have in the sync pin is an external
> > clock
> > with the exception of the `sync` mode. I guess this one could be
> > called
> > output-sync and, in this case, the sync pin is actually an output pin
> > pulsing when the internal processor collects data.
> >
> > I'm ok in changing it if there's a better way of doing it... Do you
> > have any suggestion?
> >
> > -Nuno S=C3=A1
>
> So, you mean having the clock-name only as "sync" (or maybe even
> removing it?) and having a dedicated property like clock-mode?

Yes. Though it needs a vendor prefix: adi,clock-mode. Or perhaps adi,sync-m=
ode?

Rob
