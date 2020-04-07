Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6640E1A0A51
	for <lists+linux-iio@lfdr.de>; Tue,  7 Apr 2020 11:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgDGJmE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Apr 2020 05:42:04 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:42003 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725883AbgDGJmE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Apr 2020 05:42:04 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8F18B580432;
        Tue,  7 Apr 2020 05:42:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 07 Apr 2020 05:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=CCbcFFDvgPRSxCF+8kZaaLO/1MA
        76diBRU97kO0B2Q8=; b=T5/TfczrwzeOgw6HFlUxIdyoSA/V0HhD7PYXgy/9TQ4
        ikbfway1Ve6eAIDB1YpuKG8qj8p0bt3ImtiS5pVw3wXumJRHeiWAuFM+0UCB+KNf
        jNkB4xLghBQLbrYfXDxqscKi7+Zd5C0e8otfoRQsR9J83FuaTZ51porehp1vuEIx
        27FTOX4iAFXHwRRQKZFXxlJhg/FVD0RcXh9vmzfub5Yc/D2TLRdWM92xAgXJWFre
        g5AooSA85ZbUkd3R0yR/wB16lhCJCscJRIUxoos4gqOUk7PFRjpf7A0VAr3/6Jij
        Vo/9sYx3ICBSkKgA4qG+jSXhS/rz7mt4yoyei538yIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=CCbcFF
        DvgPRSxCF+8kZaaLO/1MA76diBRU97kO0B2Q8=; b=D8wY+GD4/i+PHJodUNJO57
        8imtIXeZcubk9ZyX7MWTkFSIlwKtdy9pezqcnMwb9f+Q/UWIgV8aqvjJ+kkzEv7V
        /dvqFuDOa3o5Gd1IoLrBvFUBc87+XSIyZAvpthaTuigqpH/wjPLycMqzY1/PmmPZ
        mnFMDp4yUSc8Ork+6KdpZr8Cj0kOc+b61fFDKWEbAjltSwPU9J4kder4tAu5bO7Q
        kuIXCEu23UEVOftL2fYnnHEvuPwT2z33SUQuJEjfJ3oZrfGQ6zJpnjUAwNJXDp4o
        AjKMMZjRqmnZ9oskDmQlGTyg5fRmjTa9AIqswuJJ4rQ6pPofwl+X4EQqzAeeZOoQ
        ==
X-ME-Sender: <xms:6UqMXrEESRaMA6LPL3tIrAKxumyafD9oInxTfyn0UYeMhbuq_F3qpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucffohhmrghinh
    epuggvvhhitggvthhrvggvrdhorhhgnecukfhppeeltddrkeelrdeikedrjeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvse
    gtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:6UqMXjxTEDcTx1vL3tqsGbobBFxRNsbgWN30Nr0OrYnkWl2y1Vrdww>
    <xmx:6UqMXgps9meExFNY9FK8qVIHjUIRuKsKRFhApBpQRbNRfR8LRDGObA>
    <xmx:6UqMXtjiYQnYDtdnDJwlxdZOiIOoWsN6Bt76h6ENnjnYbJhLZR--ug>
    <xmx:6kqMXmjh6iiSCY83qIMll5ueTt-0nO1qmd6Z7Q-wNzHVP6hBGf0vIg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 19790328005A;
        Tue,  7 Apr 2020 05:42:01 -0400 (EDT)
Date:   Tue, 7 Apr 2020 11:41:59 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] Input: rotary-encoder-counter: add DT bindings
Message-ID: <20200407094159.xtbhtsxorvs2g22c@gilmour.lan>
References: <20200406155806.1295169-1-kamel.bouhara@bootlin.com>
 <20200406155806.1295169-3-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="japkdjzpcbcq3brx"
Content-Disposition: inline
In-Reply-To: <20200406155806.1295169-3-kamel.bouhara@bootlin.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--japkdjzpcbcq3brx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kamel,

The prefix for device tree bindings is usually dt-bindings:
$framework: $title

So a title like "dt-bindings: input: Add a counter-based rotary
encoder binding" would be better.

On Mon, Apr 06, 2020 at 05:58:05PM +0200, Kamel Bouhara wrote:
> Add dt binding for the counter variant of the rotary encoder driver.
>
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> ---
>  .../input/rotary-encoder-counter.yaml         | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/rotary-encoder-counter.yaml
>
> diff --git a/Documentation/devicetree/bindings/input/rotary-encoder-counter.yaml b/Documentation/devicetree/bindings/input/rotary-encoder-counter.yaml
> new file mode 100644
> index 000000000000..a59f7c1faf0c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/rotary-encoder-counter.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: GPL-2.0

Bindings are usually used by other OS's, so you should consider
putting it under a more permissive license, usually that would be GPL2
and the BSD-2-Clause

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/rotary-encoder-counter.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rotary Encoder Counter
> +
> +maintainers:
> +  - Kamel Bouhara <kamel.bouhara@bootlin.com>
> +
> +description:
> +  Registers a Rotary encoder connected through a counter device.

You shouldn't really describe the action here, but more what the
binding is about. The registration will not depend on the presence of
the node following that binding, but rather on whether or not the OS
that uses it has support for it.

> +properties:
> +  compatible:
> +    const: rotary-encoder-counter
> +
> +  counter:
> +    description: Phandle for the counter device providing rotary position.

This should have a type

> +  linux-axis:
> +    description: The input subsystem axis to map to this rotary encoder.
> +    type: boolean
> +
> +  qdec-mode:
> +    description: |
> +      Quadrature decoder function to set in the counter device.
> +      3: x1-PHA
> +      4: x1-PHB
> +      5: x2-PHA
> +      6: x2-PHB
> +      7: x4-PHA and PHB

That range (even though it's a bit odd) should be expressed through an
enum so that you can check that the values are actually within that
range.

> +  steps:
> +    description: Number of steps in a full turnaround of the encoder.

Muli-line strings should have either quotes around them, or a | or >
like you did for the description. | will keep the \n, > will make that
a single string.

This should also have a type

> +      Only relevant for absolute axis.

This should be expressed through a if / then clause, or a dependencies one

>                                         Defaults to 24 which is a typical
> +      value for such devices.

This should be expressed through a default property.

> +  relative-axis:
> +    description: Register a relative axis rather than an absolute one.
> +    type: boolean
> +
> +  rollover:
> +    description: Automatic rollover when the rotary value becomes greater
> +      than the specified steps or smaller than 0. For absolute axis only.
> +    type: boolean

Same story than steps for the dependency. Also, what is is the
behaviour when this property isn't set?

> +  poll-interval:
> +    description: Poll interval at which the position is read from the counter
> +      device (default 500ms).

It should have a type too, and a default property

> +
> +required:
> +  - compatible
> +  - counter
> +  - qdec-mode
> +
> +examples:
> +  - |
> +    rotary@0 {
> +        compatible = "rotary-encoder-counter";

A unit-address (the part after @) only makes sense for a node if
there's a matching reg property in the node. This will trigger a DTC
warning, so you should remove the @0

Maxime

--japkdjzpcbcq3brx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXoxK5wAKCRDj7w1vZxhR
xV5PAP9oleLNJ1AEhCCnvJCT4zm5frzWFncYL0ZW4bzrBCNAgQD/VfmXTyrdhPL8
UoL54zIDj9ggENLCwxMqk6jdw/++/wM=
=QF+N
-----END PGP SIGNATURE-----

--japkdjzpcbcq3brx--
