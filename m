Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C531213B2D1
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2020 20:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgANTU0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jan 2020 14:20:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:44612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgANTUZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Jan 2020 14:20:25 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09D9B24679;
        Tue, 14 Jan 2020 19:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579029624;
        bh=51mPKvKOvFBPcyebnpeFfrpdOAPyvnnFW5SZb3BDz5A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0AzsTqV+6NRVdOwYlop8UGvirDY6l6CFWTp76WjFI/3G25rUyinXv5ASQPgWsOVJB
         GomQpKA16rlD6ylSIvLNc5VHnSKssm/NbO/8Yw2Fo/Z0klQ0VVy4HF3/DXH09v5NM9
         gg5eboqH985MWFANNYfhEI/QvEHQa1j0DAYBFmCs=
Received: by mail-qt1-f179.google.com with SMTP id t3so13466245qtr.11;
        Tue, 14 Jan 2020 11:20:24 -0800 (PST)
X-Gm-Message-State: APjAAAXkfrlErTvvVstfO50qZEx6h/QYWNWp9B5OdmkKFSGrfC3j9/5b
        VfChq1K3HRDu91ucGLDbwITNQVX6iHQ5mtA3BA==
X-Google-Smtp-Source: APXvYqxtoC7YzVsJSq0poDkCvJI/CcjPKwVkad6yKqrUxD2hA8j7iTo4qnjLsj9KT03fSLGDVtvDkqcYswDEUHsVCD0=
X-Received: by 2002:ac8:6747:: with SMTP id n7mr128832qtp.224.1579029623073;
 Tue, 14 Jan 2020 11:20:23 -0800 (PST)
MIME-Version: 1.0
References: <1575649028-10909-1-git-send-email-fabrice.gasnier@st.com>
 <20191217234345.GA7738@bogus> <cadc76a7-7e9d-1f0a-21fd-2d7942dbe5c9@st.com>
In-Reply-To: <cadc76a7-7e9d-1f0a-21fd-2d7942dbe5c9@st.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 14 Jan 2020 13:20:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJdw=WzMhp1d9E3131AuyO7in7bgR5X4NM1n7Ox4X0YXw@mail.gmail.com>
Message-ID: <CAL_JsqJdw=WzMhp1d9E3131AuyO7in7bgR5X4NM1n7Ox4X0YXw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: iio: adc: stm32-adc: convert bindings to json-schema
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        olivier moysan <olivier.moysan@st.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 14, 2020 at 10:02 AM Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
>
> On 12/18/19 12:43 AM, Rob Herring wrote:
> > On Fri, Dec 06, 2019 at 05:17:08PM +0100, Fabrice Gasnier wrote:
> >> Convert the STM32 ADC binding to DT schema format using json-schema
> >>
> >> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> >> ---
> >> Note: this applies on top of IIO tree currently (iio-for-5.5c).
> >>
> >> Changes in V2:
> >> - Take almost all of Rob suggestions (removed reg generic description,
> >>   added minItems, maxItems, st,max-clk-rate-hz range, drop some pipes,
> >>   simplify clock-names, remove unneeded allOfs)
> >> - For now, keep all in one file despite there are lots of if/thens in the
> >>   bindings
> >> ---
> >>  .../devicetree/bindings/iio/adc/st,stm32-adc.txt   | 149 -------
> >>  .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  | 454 +++++++++++++++++++++
> >>  2 files changed, 454 insertions(+), 149 deletions(-)
> >>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> >>  create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> >
> >
>
>
> [snip]
>
> >> +
> >> +      st,adc-channels:
> >> +        description: |
> >> +          List of single-ended channels muxed for this ADC. It can have up to:
> >> +            - 16 channels, numbered from 0 to 15 (for in0..in15) on stm32f4
> >> +            - 20 channels, numbered from 0 to 19 (for in0..in19) on stm32h7 and
> >> +              stm32mp1.
> >> +        allOf:
> >> +          - $ref: /schemas/types.yaml#/definitions/uint32-array
> >> +
>
> [snip]
>
> >> +
> >> +    allOf:
> >> +      - if:
> >> +          properties:
> >> +            compatible:
> >> +              contains:
> >> +                const: st,stm32f4-adc
> >> +
> >> +        then:
> >> +          properties:
> >> +            reg:
> >> +              enum:
> >> +                - 0x0
> >> +                - 0x100
> >> +                - 0x200
> >> +
> >> +            interrupts:
> >> +              minimum: 0
> >> +              maximum: 2
> >> +
> >> +            assigned-resolution-bits:
> >> +              enum: [6, 8, 10, 12]
> >> +              default: 12
> >> +
> >> +            st,adc-channels:
> >> +              minItems: 1
> >> +              maxItems: 16
> >> +              minimum: 0
> >> +              maximum: 15
> >
> > You are mixing array and scalar constraints here. You need:
> >
> > minItems: 1
> > maxItems:16
> > items:
> >   minimum: 0
> >   maximum: 15
> >
> > Update dtschema. It will now catch this. There's a few others too.
>
> Hi Rob,
>
> Sorry for the late reply. I updated dtschema. Now it catches it.
>
> I've tried your suggestion, but when I test it, I don't get any error on
> maxItems.
>
> In the example: "st,adc-channels = <0>, <1>, ... more than 16 items;"
>
> Is it possible I face some other issue with dtschema ?

The problem is how "<0>, <1>" vs. "<0 1>" gets encoded. While those
are the same in the dtb, in yaml we have "[[0], [1]]" vs. "[[0, 1]]".
Making the brackets significant is helpful for some things like
phandle+args and 'reg' where we have a matrix of values, but for
arrays it just gets in the way. I think as I suggested is the right
form for the binding schema, and we need to either decide what's the
correct way for brackets or improve the tool to accept both ways.

Rob
