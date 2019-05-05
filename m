Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABC613F67
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2019 14:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfEEMWm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 May 2019 08:22:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfEEMWm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 May 2019 08:22:42 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 476D6206DF;
        Sun,  5 May 2019 12:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557058960;
        bh=rna6GYm8TPz72RZf9OEHq2A6XC1YXYW//MSiZ3dlc4I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eJZpE4qSZ5dledYiFjY26cIddBb6Hel0G+5tVF6aJmQclhrCQbhqj7Ay6HsyT6MPp
         uu2ftaO+Ge0/caX5JvSM4kas1bgc2Ppmq1ut3lPqfp8FmZihV3e4omftPQiLEtZhx7
         ZmgQeMhEMWOoIQZtnWDtjCtEktRh6QsEGgKqT9Ds=
Date:   Sun, 5 May 2019 13:22:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Adam Michaelis <adam.michaelis@rockwellcollins.com>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        michael.hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        charles-antoine.couret@essensium.com, devicetree@vger.kernel.org,
        brandon.maier@rockwellcollins.com,
        clayton.shotwell@rockwellcollins.com
Subject: Re: [PATCH 2/6] dt-bindings: iio: ad7949: Add adi,reference-select
Message-ID: <20190505132234.313b78e9@archlinux>
In-Reply-To: <1556745423-11368-2-git-send-email-adam.michaelis@rockwellcollins.com>
References: <1556745423-11368-1-git-send-email-adam.michaelis@rockwellcollins.com>
        <1556745423-11368-2-git-send-email-adam.michaelis@rockwellcollins.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  1 May 2019 16:16:59 -0500
Adam Michaelis <adam.michaelis@rockwellcollins.com> wrote:

> Adding optional parameter to AD7949 to specify the source for the
> reference voltage signal. Default value is maintaned with option '6' to
> match previous version of driver.
> 
> Signed-off-by: Adam Michaelis <adam.michaelis@rockwellcollins.com>
> ---
>  .../devicetree/bindings/iio/adc/ad7949.txt         | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ad7949.txt b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
> index c7f5057356b1..14ee9a2cb2a5 100644
> --- a/Documentation/devicetree/bindings/iio/adc/ad7949.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
> @@ -6,11 +6,29 @@ Required properties:
>  	* "adi,ad7682"
>  	* "adi,ad7689"
>   - reg: spi chip select number for the device
> - - vref-supply: The regulator supply for ADC reference voltage
>  
> -Example:
> +Optional properties:
> + - adi,reference-select: Select the reference voltage source to use
> + when converting the input voltages. Valid values are:
So my immediate thought here is we are mapping one binding to several
different things. Some of which are definitely better described in other
ways.

So let us break it down:

Internal vs external.
- External should require a regulator.  If the regulator is there, normal
assumption would be you want to use it.

Which internal reference?  Hmm. This would be incompatible with the external
regulator and I'd expect the presence of such a regulator to override this.
That does need a new binding.
adi,internal-reference-milivolts = 2500 or 4096.   Much nicer to have
real numbers for someone wondering how it is configured than an enum.

Temperature sensor enabled: Why is this a devicetree question rather than
a runtime decision?

Buffer enabled: This needs a custom binding
adi,external-reference-buffer-enable or something like that?

Makes for a more consistent binding where some elements can be common
across similar devices.  It would be good to see if similar bindings
already exist.  Potentially tings like the reference-buffer enable
may be worth making standard ADC properties rather than device
specific.

Thanks,

Jonathan

	
> +   0: Internal 2.5V reference; temperature sensor enabled
> +   1: Internal 4.096V reference; temperature sensor enabled
> +   2: External reference, temperature sensor enabled, no buffer
> +   3: External reference, temperature sensor enabled, buffer enabled
> +   6: External reference, temperature sensor disabled, no buffer
> +   7: External reference, temperature sensor disabled, buffer enabled
> + - vref-supply: The regulator supply for ADC reference voltage. Required
> + if external reference selected by 'adi,reference-select'.
> +
> +Examples:
>  adc@0 {
>  	compatible = "adi,ad7949";
>  	reg = <0>;
> +	adi,reference-select = <2>;
>  	vref-supply = <&vdd_supply>;
>  };
> +
> +adc@0 {
> +	compatible = "adi,ad7949";
> +	reg = <0>;
> +	adi,reference-select = <0>;
> +};

