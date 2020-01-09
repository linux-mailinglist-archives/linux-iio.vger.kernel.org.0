Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D528013538A
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2020 08:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgAIHLE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jan 2020 02:11:04 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:51887 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgAIHLE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jan 2020 02:11:04 -0500
Received: from localhost ([31.212.60.142]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MfZDK-1jMIjo396O-00fwpo; Thu, 09 Jan 2020 08:10:48 +0100
Date:   Thu, 9 Jan 2020 08:10:47 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     Rob Herring <robh@kernel.org>
Cc:     jic23@kernel.org, mark.rutland@arm.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, rpi-receiver@htl-steyr.ac.at,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: devantech-srf04.yaml: add pm feature
Message-ID: <20200109071047.GA3043@arbad>
References: <20200102172749.v7ufupd32ytf7jda@arbad>
 <20200108165813.GA4472@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108165813.GA4472@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:n4ntl9gVhdsv+OwVdqknKL8TANkqMYHfUGVQTP0bv2p2PAA85Nl
 7iPPMgwkQ8uapwU5YKMJMWeuMFow089H1U2dy4bbZYVKrD6YVVQiPQ8NE8akssYB0Wc4G6m
 /0Zoa31ALt+49KlkgDgDQfwXa2+/WIYOe05+EXL+BA4BM2wS8WwVO0PJBu5TplSPHE3ANbi
 OLP57Mv1jWP1FysrPyq2g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lCCLisCEUrs=:9ZKaN92OPR8/Y54hM9jcRH
 s6joxY0YtizkvP4rarCGq9I2q7vo2TBU1xkW7B9VT7FrjNiqcVTt9jFc+N08reBHNT1yTYKHT
 /k6QzzufTMrto4INolpHzGtBjexDN2WbDN9wL4HnR1tJ/3RNwDWcwDXSF2Rn6muEkbKL/B1wk
 oAYU4CgLMOfZro3YT5WL1EbRUnzTlihW2mInt7tuLuxua1eAUP92xR5oLRnaSUOSAAVJoNDpi
 WJOZUTg6WSwZsZQPCCMuUxb/19bIRt7JGV9a4ewAU4ZTKvVVf6n0n2DqgtFR7ZegSmwNuDqPv
 wvLI9hqCR7Qk+txMSIXRrOWYUHgiGnJ3wiMYC8hLD5HqOKHlGWT7FaACmlH92R5Ky6Z4jUwbG
 Z8+UKbSVQacz0XO9vxN7NmA49UfA+/E2u2ixrwYqtkVj8iZgrU/lkLNtTUn4iN5OADSK0qEWT
 BlVWwtvUkPM4m16HViwclJY6PYX/KwFvmXJ5g0XGsi1MANJAZ/GfYlByofgzS8SHFN/JUEIA4
 iOesEasQXMMXlzkr8Mnkl3obWZmo+hRD2FNtO8Zpae3OqcCK51TNWTqF5FA0tT7LNsvXu6Ofb
 1EFQiXIbcZGn9vZPVyVqTIVtsksxFuErXxwvy8ENxnGiRtkNaSSDny6J8mxQq4c/s3g11F+Y5
 9wqnoI21A0a0xDzYE2KJfX+37lJzrnlSQr0c4mE95VnUVZO5Bzk2U+U9c78vJkBjtvdhVuais
 U/eZRhZLcUz0qO2NhZ9RE4wxgHYz/hIIGi10ANNQaLQu2XjJP9+oM/ThtHRhRr/GQRo32AzuK
 EceoU0RQuz3jLy7pbbjUqkY/sVpl79f7KS6KSOWcAvKCp8GeC2QBqV/EJ0GGGJFSta9K57o3+
 Bs3moFz3Ibf0QuU8z9Tw==
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Rob,

see below.

Rob Herring <robh@kernel.org> schrieb am Mi, 08. Jan 10:58:
> On Thu, Jan 02, 2020 at 06:27:51PM +0100, Andreas Klinger wrote:
> > Add GPIO line and startup time for usage of power management
> > 
> > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> > ---
> >  .../bindings/iio/proximity/devantech-srf04.yaml          | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
> > index 4e80ea7c1475..b3fcb3b79485 100644
> > --- a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
> > +++ b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
> > @@ -51,6 +51,22 @@ properties:
> >        the time between two interrupts is measured in the driver.
> >      maxItems: 1
> >  
> > +  power-gpios:
> > +    description:
> > +      Definition of the GPIO for power management of connected peripheral
> > +      (output).
> > +      This GPIO can be used by the external hardware for power management.
> > +      When the device gets suspended it's switched off and when it resumes
> > +      it's switched on again. After some period of inactivity the driver
> > +      get suspended automatically (autosuspend feature).
> > +    maxItems: 1
> > +
> > +  startup-time-ms:
> 
> Why isn't this implied by the compatible string? 

Under the same trade name "SRF-04" there are many different sensors on the
market which are clones of the original one from Devantech. They are equipped
with different hardware components and they have a slightly different behavior,
such as the startup time. 

> 
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> You can drop this for standard units. 
> 
> 0-2^32 is valid?

I can add boundaries here.

> 
> > +    description:
> > +      This is the startup time the device needs after a resume to be up and
> > +      running.
> > +
> >  required:
> >    - compatible
> >    - trig-gpios
> > -- 
> > 2.11.0

Andreas
