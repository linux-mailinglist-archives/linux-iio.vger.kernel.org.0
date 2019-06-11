Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 651C2417C5
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2019 00:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407775AbfFKWAo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Jun 2019 18:00:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407758AbfFKWAo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 Jun 2019 18:00:44 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBE2820866;
        Tue, 11 Jun 2019 22:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560290443;
        bh=6wt58freXYakzLC3l+w1fNDxCWBRmdHXoj+rBGdpgUo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WwSPphCrIfjN8xr2FGpl9TwUkiKTORJSYOiN1Ar7DBUCd/sN5obikBSc9h7F+f+IN
         8uFvcPjF9URXIAWJMWCwfWR5rEMwzmhg2y4HxlHOh36q4n6ofjtkgTgKgGR42+ZL2S
         m6Q1P9S6eUi8b0/v43UamaEJZKg0cKD8RKupnZx8=
Received: by mail-qk1-f177.google.com with SMTP id l128so8712184qke.2;
        Tue, 11 Jun 2019 15:00:42 -0700 (PDT)
X-Gm-Message-State: APjAAAW3BW87NuwCBb4m5fBoRR1W1opKlgIoheHwUqhB4kJIL5y1Vdqc
        Xcd1ghuy7EW/bgWV8TaW7Q6FOqfLMrR+hFxVaA==
X-Google-Smtp-Source: APXvYqxAosGlT5kLbEYc7A8eFkXTwEsqIRmfJhcEbutAwwqMxG2UXqT+bffMX7rQ3up6XhxfhUajYaqFMZeSV3XzK9k=
X-Received: by 2002:a05:620a:5b1:: with SMTP id q17mr60654324qkq.174.1560290442211;
 Tue, 11 Jun 2019 15:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <1559653697-2760-1-git-send-email-stefan.popa@analog.com> <20190611215932.GA24974@bogus>
In-Reply-To: <20190611215932.GA24974@bogus>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 11 Jun 2019 16:00:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLXXo7wMef-j8Gj+mim_yJ2w5R3tyqPMNtS8iX5ffrJjg@mail.gmail.com>
Message-ID: <CAL_JsqLXXo7wMef-j8Gj+mim_yJ2w5R3tyqPMNtS8iX5ffrJjg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] dt-bindings: iio: frequency: Add docs for ADF4371 PLL
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 11, 2019 at 3:59 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jun 04, 2019 at 04:08:17PM +0300, Stefan Popa wrote:
> > Document support for Analog Devices ADF4371 SPI Wideband Synthesizer.
> >
> > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> > ---
> > Changes in v2:
> >       - Nothing changed.
> > Changes in v3:
> >       - Nothing changed.
> > Changes in v4:
> >       - Nothing changed.
> > Changes in v5:
> >       - Nothing changed.
>
> Please add acks/reviewed-bys when posting new versions.
>
> But something else I noticed:
>
> >
> >  .../devicetree/bindings/iio/frequency/adf4371.yaml | 54 ++++++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> > new file mode 100644
> > index 0000000..d7adf074
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> > @@ -0,0 +1,54 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/frequency/adf4371.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices ADF4371 Wideband Synthesizer
> > +
> > +maintainers:
> > +  - Popa Stefan <stefan.popa@analog.com>
> > +
> > +description: |
> > +  Analog Devices ADF4371 SPI Wideband Synthesizer
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/adf4371.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,adf4371
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    description:
> > +      Definition of the external clock (see clock/clock-bindings.txt)
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    description:
> > +      Must be "clkin"
>
> This can be a schema:
>
> clock-names:
>   items:
>     - clkin

And with that, you can keep my R-by.

Rob
