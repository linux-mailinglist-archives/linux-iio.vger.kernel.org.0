Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417A23C35AB
	for <lists+linux-iio@lfdr.de>; Sat, 10 Jul 2021 19:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhGJRAU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Jul 2021 13:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229551AbhGJRAS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Jul 2021 13:00:18 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63FE561208;
        Sat, 10 Jul 2021 16:57:30 +0000 (UTC)
Date:   Sat, 10 Jul 2021 18:00:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v2 4/4] dt-bindings: iio: adc: ad7949: add
 adi,reference-source
Message-ID: <20210710180001.051f7367@jic23-huawei>
In-Reply-To: <20210709155856.1732245-5-liambeguin@gmail.com>
References: <20210709155856.1732245-1-liambeguin@gmail.com>
        <20210709155856.1732245-5-liambeguin@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  9 Jul 2021 11:58:56 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> From: Liam Beguin <lvb@xiphos.com>
> 
> Add bindings documentation for the adi,reference-source property.
> This property is required to properly configure the ADC sample request
> based on which reference source should be used for the calculation.

Should this be per channel? That will effect some of what I say below...

> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  .../bindings/iio/adc/adi,ad7949.yaml          | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
> index 9b56bd4d5510..eae3121cad01 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
> @@ -35,6 +35,27 @@ properties:
>    "#io-channel-cells":
>      const: 1
>  
> +  adi,reference-select:

This is one field in the register, but it's not one thing, so lets break it up
in DT.  We should do this both to make for more readable dts files and to
enforce the requirements on regulators...

> +    description: |
> +      Select the reference voltage source to use when converting samples.
> +      Acceptable values are:
> +      - 0: Internal reference and temperature sensor enabled.
> +           Vref=2.5V, buffered output
> +      - 1: Internal reference and temperature sensor enabled.
> +           Vref=4.096V, buffered output
> +      - 2: Use external reference, temperature sensor enabled.
> +           Internal buffer disabled
> +      - 3: Use external reference, internal buffer and temperature sensor
> +           enabled.
> +      - 6: Use external reference, internal buffer and temperature sensor
> +           disabled.
> +      - 7: Use external reference, internal buffer enabled.
> +           Internal reference and temperature sensor disabled.

So question 1 is whether to use an external or internal reference.
Normally we'd make the coarse decision of whether to use an external reference
by whether there is a regulator provided.  That won't work so well if we make
this per channel.

Question 2, assuming internal reference, what voltage?  Those should take
an actual voltage (probably in mV and match against an enum of the two possible values).
Binding should check to make sure this isn't specified as well as saying we
are using an external refernce.

Question 3, assuming external reference, is temperature sensor enabled?
- actually dumb question, but why would anyone not want this enabled?  Maybe turn it
off in runtime pm, but in general if you've fitted a chip with a temperature sensor
you at least sometimes want to measure temperature!  So my gut feeling is don't
allow this to be controlled (effectively drop cases 6 and 7 above as being
unlikely to be of interest to anyone)

Question 4, Is the internal buffer enabled when using and external reference.
This one is interesting.   We could just expose it in general, but I wonder
if we can do something that reflects how it is used.  From the various figures in
the datasheet this seems to be coupled to whether the external reference is on
pin REF_IN or pin REF.  If that's the case can we have two optional regs only
one of which should be supplied?  However, this gets more fiddly because
the default right now is vref-supply actually being connected to the vrefin connection.
That's annoying as it stops us using the obvious naming...
Hence I think we can have
vref-supply (actually connected to vrefin) and vref-unbuffered-supply



> +
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3, 6, 7]
> +    default: 7
> +
>  required:
>    - compatible
>    - reg

