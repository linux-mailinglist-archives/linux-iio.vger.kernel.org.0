Return-Path: <linux-iio+bounces-16967-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228E6A64EE7
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 13:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F171720D9
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 12:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376612397B0;
	Mon, 17 Mar 2025 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2n+5v0l"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E286F22257F;
	Mon, 17 Mar 2025 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214754; cv=none; b=phDPhFupe+Bkgwv3WyDVr6xEqgcEM/LKVWLpqhwxCSLEiWR9I+GBp1BH5VJ9p3D3oPgk4soZKTIvtsw0oM88aeLyKTeH+Ot/Nr/SfNNIwTwDovwYLcEp/G+R0djgwTq+nVtXMn567AXLomsmjiVvSW9KXKowKd7wdpW360Lnv7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214754; c=relaxed/simple;
	bh=mpj0eN0ZSj2hePIuckNxCH5q4VA4XGLe8rJAIVpQJUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9UXpWEoE5Ytdc774Ipw3f8kz62sZOylA7TcbQrN+el3IqNaHwyQk5ILTXuu6C9qxktsRG0QaeyuVFK90L5oB7ejkR9jEYXGSns+mlTJ9JwNVafKrDrHdHs+Kogx7jdCIIYQOXLB6OgaEXTT9FvmAtgR9lYs38F15pqsDH+jjyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2n+5v0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0C5C4CEE3;
	Mon, 17 Mar 2025 12:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742214753;
	bh=mpj0eN0ZSj2hePIuckNxCH5q4VA4XGLe8rJAIVpQJUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V2n+5v0lo0ugDAJNnonNI/LS0hPWcwjIclVlv7fm9E4XxKWldEvumLnziEmTvRv9d
	 J9EkCdRKZTN9MVybBmgoz1GM5yjJ01qygdA6yBMda90KcZ8DsMANdwZnHWQGHCkxzh
	 F245TDS1QLGcU+YYT22mdHLujci/YRLF2TABKizDoDiJvPNgCkiBqkGfUpAJdBTg5U
	 FBN57FIENTQtT2YX4NP4KhKOiAXFFDl0D4qeMigoYAi1yb/VxbJX3UFGzEtfGZOYzz
	 rQubcIKRuf+JD2vb9A8FAgT6Q0sMqH1Fxc/coOouPei8HHP/1eZ9fosJi5L0BIK3O2
	 IpC/is1zg5wuQ==
Date: Mon, 17 Mar 2025 12:32:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: <marius.cristea@microchip.com>
Cc: <lars@metafoo.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <oskar.andero@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: adding support for
 PAC194X
Message-ID: <20250317123222.1d2a6efd@jic23-huawei>
In-Reply-To: <20250317090803.30003-2-marius.cristea@microchip.com>
References: <20250317090803.30003-1-marius.cristea@microchip.com>
	<20250317090803.30003-2-marius.cristea@microchip.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Mar 2025 11:08:02 +0200
<marius.cristea@microchip.com> wrote:

> From: Marius Cristea <marius.cristea@microchip.com>
> 
> This is the device tree schema for iio driver for Microchip PAC194X and
> PAC195X series of Power Monitors with Accumulator.

Wrapping of commit message is a little messy.  Either just have one paragraph
or add some bland lines to make the paragraph breaks look more intentional.

> The PAC194X family supports 9V Full-Scale Range and the PAC195X supports
> 32V Full-Scale Range.
> There are two versions of the PAC194X/5X: the PAC194X/5X-1 devices are
> for high-side current sensing and the PAC194X/5X-2 devices are for
> low-side current sensing or floating VBUS applications.
> The PAC194X/5X-1 is named shortly PAC194X/5X.
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---
>  .../bindings/iio/adc/microchip,pac1944.yaml   | 195 ++++++++++++++++++
>  1 file changed, 195 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml
> new file mode 100644
> index 000000000000..1997e889e3f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml

> +
> +      microchip,vbus-mode:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          In order to increase measurement resolution and keeping the same
> +          number the of bits the device has a configurable VBUS full range
> +          scale (FSR). The range should be set by hardware design and it should
> +          not be changed during runtime. The bipolar capability for VBUS enables
> +          accurate offset measurement and correction.
> +          The VBUS could be configured into the following full scale range
> +            <0>  -  VBUS has unipolar +32V to 0V FSR (default) for PAC195X
> +                    or +9V to 0V (default) for PAC194X
> +            <1>  -  VBUS has bipolar +32V to -32V FSR for PAC195X
> +                    or +9V to -9V for PAC194X. The actual range is limited to
> +                    about -200 mV due to the impact of the ESD structures.
> +            <2>  -  VBUS has bipolar +16V to -16V FSR for PAC195X
> +                    or +4.5V to -4.5V for PAC194X. The actual range is limited
> +                    to about -200 mV due to the impact of the ESD structures.
> +        maximum: 2

There are examples in tree of multirange devices where we specify the pair
of negative and positive limits.  That makes for easy to read DT by
avoiding the use of enums.

> +
> +      microchip,vsense-mode:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          In order to decrease the power dissipation on the shunt resistor and
> +          in the same time to increase measurement resolution by keeping the
> +          same number the of bits the device has a configurable VSENSE full
> +          range scale (FSR). The range should be set by hardware design and it
> +          should not be changed during runtime. 
> +          The VSENSE could be configured into the following full scale range
> +            <0>  -  VSENSE has unipolar +100 mV to 0V FSR (default)
> +            <1>  -  VSENSE has bipolar +100 mV to -100 mV FSR
> +            <2>  -  VSENSE has bipolar +50 mV to -50 mV FSR
> +        maximum: 2

Similar to above. Consider allowing <0, 100>, <-100, 100>. <-50, 50>
I'm curious why you've documented them as positive to negative above.
 
> +
> +      microchip,accumulation-mode:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          The Hardware Accumulator may be used to accumulate VPOWER, VSENSE or
> +          VBUS values for any channel. By setting the accumulator for a channel
> +          to accumulate the VPOWER values gives a measure of accumulated power
> +          into a time period, which is equivalent to energy. Setting the
> +          accumulator for a channel to accumulate VSENSE values gives a measure
> +          of accumulated current, which is equivalent to charge. This allows the
> +          accumulator to be used as a coulomb counter. For either VSENSE or
> +          VBUS, many samples may be accumulated on chip and the result collected
> +          by the host and divided by the accumulator counter count value to
> +          yield an average value with a very long integration time to reduce
> +          noise. This feature is also very useful for system calibration,
> +          allowing many averages to be accumulated for fast averaging/noise
> +          reduction.
> +          This functionality needs to be setup once and must not be changed
> +          during the runtime, just in case the user wants to measure the charge
> +          or the energy consumed from board power up till the user has control
> +          or during a reboot of the system.    
This one feels like it really isn't a one time thing.

For a few somewhat similarly behaving things (step counts on pedometers for example)
we have explicit channel enabled attributes.  Here you could just prevent
any other actions that would break the accumulation after the software has opted
in to enable a particular energy channel. If you need to fake a reset of similar
just check the counter and subtract it in software after a channel change.
      
> +          The Hardware Accumulator could be configured to accumulate
> +          VPOWER, VSENSE or VBUS
> +            <0>  -  Accumulator accumulates VPOWER (default)
> +            <1>  -  Accumulator accumulates VSENSE
> +            <2>  -  Accumulator accumulates VBUS
> +        maximum: 2
If we do keep it in here then have
default: 0 and don't specify it in the examples below.

Jonathan


