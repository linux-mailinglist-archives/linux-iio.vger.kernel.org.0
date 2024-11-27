Return-Path: <linux-iio+bounces-12723-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA569DA36C
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 09:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBB61666E3
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 08:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CA8156236;
	Wed, 27 Nov 2024 08:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlAUM7Lm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F404E12C499;
	Wed, 27 Nov 2024 08:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732694427; cv=none; b=jyrvoQruPyUQRJKrnNH+hvc5OWz4allhhmll96GglnIJ+iZf1kVRR/M6+YIIGjL8Mlw2IzlQZBWQGuY1AvsCRYPqCAtizFSezrW9KXqiY1TUFdLGGUUdqHDlVli/t9ui3hNpsTZTEdRtIF+L7ZPZ9KteyA634jw5W4IJiBC1aRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732694427; c=relaxed/simple;
	bh=GgFaD5G7nqFywtoKREjsYWNcLoJk08J62pho+WSpmF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aan6TenTzsR8OWwI9oZzyNpfOjECVEV6zsocLlSp9/glLPzREBSt4XsQTZyTM728834uGh8tNekLolHk2Vz1TpSH5JsrwLlDH63rN8phxTqJfTrjOmcTezPXSEiiTRE07ZIhP8YMkKXnbiQzSdwe3I1uEgZmlukP9uvtPyMSGvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlAUM7Lm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EC6C4CECC;
	Wed, 27 Nov 2024 08:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732694426;
	bh=GgFaD5G7nqFywtoKREjsYWNcLoJk08J62pho+WSpmF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KlAUM7Lm5DlNOg07lUAolBchsP3+72z39PWUOaa/A32011A8vAyg5TpfJZYRLPwfX
	 ZwWEoftS985KFdJOZnf5OpZyVqCXB7JBb/Vp+UttePmCnuzMZl4ldRXK+5iTFvPNAc
	 AznH0W8ekw2K/aXPmnlcKxjurM92EgWlJhmjWpTgJOaG+Tn70hCkoQSJjzV/rcsnkP
	 SBQhsrWQKmusTooerr28t3CvCiH6oXDozuGX9ajBi95NJq+1Ji+3Sk2T680z2ep7WJ
	 8P2Jwg7gHnBFhq4Gnf6M+4xog4kwwb1/MprvBXyMdeGyWT/+NbxK6WVukg6hzwr9SU
	 bdr65ULZi8sFg==
Date: Wed, 27 Nov 2024 09:00:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v4 1/4] dt-bindings: iio: adc: adi,ad4000: Add PulSAR
Message-ID: <yhah2mrild37ntk77u75oysjzf3mpegvqeg5es2vzq6tencwco@lytu235eymoa>
References: <cover.1732660478.git.marcelo.schmitt@analog.com>
 <227873de1e9aa249504639da2241915541d089d5.1732660478.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <227873de1e9aa249504639da2241915541d089d5.1732660478.git.marcelo.schmitt@analog.com>

On Tue, Nov 26, 2024 at 08:15:05PM -0300, Marcelo Schmitt wrote:
> Extend the AD4000 series device tree documentation to also describe
> PulSAR devices.
> 
> The single-channel series of PulSAR devices is similar to the AD4000 series
> except PulSAR devices sample at slower rates and don't have a
> configuration register. Because PulSAR devices don't have a configuration
> register, they don't support all features of AD4000 devices and thus fewer
> interfaces are provided to user space. Also, while AD4000 may have their
> SDI pin connected to SPI host MOSI line, PulSAR SDI pin is never connected
> to MOSI.
> 
> Some devices within the PulSAR series are just faster versions of others.
> >From fastest to slowest, AD7980, AD7988-5, AD7686, AD7685, and AD7988-1 are
> all 16-bit pseudo-differential pin-for-pin compatible ADCs. Devices that
> only vary on the sample rate are documented with a common fallback
> compatible.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v3 -> v4
> - Sorted compatible strings in alphabetical order.
> - Left only fallback compatibles in allOf check list for adi,sdi-pin property.
> - Improved patch description with explanation about how the AD4000 and PulSAR
>   devices are different.
> 
> Well, I didn't manage to get a dtbs_check message for all the cases I was
> expecting to cover, yet. I trust the test done by maintainers while I don't
> figure out what's wrong with my setup.
> 
> FWIW, here's what I tried:
> 
> Cloned dt-binding tree from git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
> Fetched and checked out dt/next branch.
> Applied AD4000/PulSAR patches.
> - <62dd96ac9cd> ("iio: adc: ad4000: fix reading unsigned data")
> - <8ebfd0925521> ("iio: adc: ad4000: Check for error code from devm_mutex_init() call")
> - the patches from this patch series
> 
> Cloned dtc from git://git.kernel.org/pub/scm/utils/dtc/dtc.git into a directory
> at the same level of linux kernel source dir.
> 
> Cloned dt-schema from https://github.com/devicetree-org/dt-schema.git into a
> directory at the same level of linux kernel source dir.
> Within dt-schema, 
> mkdir venv
> python3 -m venv venv/
> source venv/bin/activate
> python3 -m ensurepip --default-pip
> python3 -m pip install --upgrade pip setuptools wheel
> pip install yamllint
> pip install dtschema --upgrade
> pip install -e .
> 
> export ARCH=arm; export CROSS_COMPILE=arm-linux-gnueabi-
> Ran `./scripts/dtc/update-dtc-source.sh` from the top level of Linux source tree.
> make defconfig
> Added zynq-coraz7s-ad7685.dts to arch/arm/boot/dts/xilinx/.
> Added zynq-coraz7s-ad7685.dtb to arch/arm/boot/dts/xilinx/Makefile.
> make -j4 dtbs_check # but it didn't print anything about adi,sdi-pin value.
> Changed the compatible from "adi,ad7685" to "adi,ad7687" and dtbs_check prints
> arch/arm/boot/dts/xilinx/zynq-coraz7s-ad7685.dtb: adc@0: adi,sdi-pin:0: 'sdi' is not one of ['high', 'low', 'cs']
> 

Your process is weird. None of these are needed, especially dtc, except
pip install yamllint and dtschema. Installing dtc suggests you are
working on some old kernel and that's a mistake on its own. Plaese work
on latest mainline / maintainer / next tree.


> -zynq-coraz7s-ad7685.dts file {
> // SPDX-License-Identifier: GPL-2.0
> 
> /dts-v1/;
> #include "zynq-7000.dtsi"
> 
> / {
> 	adc_vref: regulator-vref {
> 		compatible = "regulator-fixed";
> 		regulator-name = "EVAL 5V Vref";
> 		regulator-min-microvolt = <5000000>;
> 		regulator-max-microvolt = <5000000>;
> 		regulator-always-on;
> 	};
> 
> 	adc_vdd: regulator-vdd {
> 		compatible = "regulator-fixed";
> 		regulator-name = "Eval VDD supply";
> 		regulator-min-microvolt = <5000000>;
> 		regulator-max-microvolt = <5000000>;
> 		regulator-always-on;
> 	};
> 
> 	adc_vio: regulator-vio {
> 		compatible = "regulator-fixed";
> 		regulator-name = "Eval VIO supply";
> 		regulator-min-microvolt = <3300000>;
> 		regulator-max-microvolt = <3300000>;
> 		regulator-always-on;
> 	};
> };
> 
> &spi0 {
> 	adc@0 {
> 		compatible = "adi,ad7685";
> 		reg = <0>;
> 		spi-max-frequency = <40000000>;
> 		vdd-supply = <&adc_vdd>;
> 		vio-supply = <&adc_vio>;
> 		ref-supply = <&adc_vref>;
> 		adi,sdi-pin = "sdi";
> 	};
> };
> -} zynq-coraz7s-ad7685.dts file
> 
>  .../bindings/iio/adc/adi,ad4000.yaml          | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> index e413a9d8d2a2..3c1171c7f0e1 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> @@ -19,6 +19,20 @@ description: |
>      https://www.analog.com/media/en/technical-documentation/data-sheets/ad4020-4021-4022.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4001.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4003.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7685.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7686.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7687.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7688.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7690.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7691.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7693.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7942.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7946.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7980.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7982.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7983.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7984.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7988-1_7988-5.pdf
>  
>  $ref: /schemas/spi/spi-peripheral-props.yaml#
>  
> @@ -63,6 +77,32 @@ properties:
>  
>        - const: adi,adaq4003
>  
> +      - items:
> +          - enum:
> +              - adi,ad7685
> +              - adi,ad7686
> +              - adi,ad7980
> +              - adi,ad7988-1
> +              - adi,ad7988-5
> +          - const: adi,ad7983
> +
> +      - items:
> +          - enum:
> +              - adi,ad7688
> +              - adi,ad7693
> +          - const: adi,ad7687

I don't see where you allow adi,ad7687 alone. Same problem with other
cases.

> +
> +      - items:
> +          - enum:
> +              - adi,ad7690
> +              - adi,ad7982
> +              - adi,ad7984
> +          - const: adi,ad7691

Best regards,
Krzysztof


