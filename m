Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 368A810E38D
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2019 22:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfLAVJy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Dec 2019 16:09:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:51522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726965AbfLAVJy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Dec 2019 16:09:54 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 928BC20865;
        Sun,  1 Dec 2019 21:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575234592;
        bh=KnH1X21TpcbK4yvu0f9o3XBV5xnJ8tgrWxBrMATOpqY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xkMKfWxmIFHT2jP3YWh5y9FyReZPVvHXMRN/F6W0K7K3ibQV8dDj4o5J96EY7KOiH
         wgZi8+QW3EwBzkmLtnOtMLQSi2ZfcAesaav0PBaPjbrGsn0seq2UkjRv+QYNEtxg8M
         dcRElyuuGVvawxSyN3ekfim/AE6/15uGEcAQZxYM=
Date:   Sun, 1 Dec 2019 21:09:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <lars@metafoo.de>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pmeerw@pmeerw.net>,
        <knaack.h@gmx.de>, <fabrice.gasnier@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: iio: adc: convert sd modulator to
 json-schema
Message-ID: <20191201210947.75b79f55@archlinux>
In-Reply-To: <20191127171642.6014-1-olivier.moysan@st.com>
References: <20191127171642.6014-1-olivier.moysan@st.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 27 Nov 2019 18:16:42 +0100
Olivier Moysan <olivier.moysan@st.com> wrote:

> Convert the sigma delta modulator bindings
> to DT schema format using json-schema.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Looks fine to me, but I'd like to give plenty of time for others to have
a chance to take a look.

If it looks like I've lost it in a week or two feel free to ping me.

Thanks,

Jonathan

> ---
>  .../iio/adc/sigma-delta-modulator.txt         | 13 -------
>  .../iio/adc/sigma-delta-modulator.yaml        | 35 +++++++++++++++++++
>  2 files changed, 35 insertions(+), 13 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> deleted file mode 100644
> index 59b92cd32552..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -Device-Tree bindings for sigma delta modulator
> -
> -Required properties:
> -- compatible: should be "ads1201", "sd-modulator". "sd-modulator" can be use
> -	as a generic SD modulator if modulator not specified in compatible list.
> -- #io-channel-cells = <0>: See the IIO bindings section "IIO consumers".
> -
> -Example node:
> -
> -	ads1202: adc {
> -		compatible = "sd-modulator";
> -		#io-channel-cells = <0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
> new file mode 100644
> index 000000000000..8967c6f06d9d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/sigma-delta-modulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Device-Tree bindings for sigma delta modulator
> +
> +maintainers:
> +  - Arnaud Pouliquen <arnaud.pouliquen@st.com>
> +
> +properties:
> +  compatible:
> +    description: |
> +      "sd-modulator" can be used as a generic SD modulator,
> +      if the modulator is not specified in the compatible list.
> +    enum:
> +      - sd-modulator
> +      - ads1201
> +
> +  '#io-channel-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - '#io-channel-cells'
> +
> +examples:
> +  - |
> +    ads1202: adc@0 {
> +      compatible = "sd-modulator";
> +      #io-channel-cells = <0>;
> +    };
> +
> +...

