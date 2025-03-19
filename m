Return-Path: <linux-iio+bounces-17080-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44BCA68678
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 09:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B7B3AA97F
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 08:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E175250BF5;
	Wed, 19 Mar 2025 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCzRiOcf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388BB1DC9BA;
	Wed, 19 Mar 2025 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372126; cv=none; b=hxPaLPnpBlEYYsPwHsFtbUSvf/rGMG5STOIMiQg7Krvy4B79viYeInslY53akWEcH722lNR6SuMMJBd6BIggrs7czJvxm80A/Enxuc6RTePh9Tqk/n9ibG57uaVl4I+xKGC9UfztAiF7deEpiSIdAgjsgvBxSAbcIHfEFlx7AlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372126; c=relaxed/simple;
	bh=4OM7Y0XKHU7jFTd3joafKOXUjyOC5LlTTPCa5DtvEaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cso9exMTfNiiIR+ISbVv2r6LUiut6rNaFXQcHJb0xNCvyXX1O735ZeT5+J+9gQc/5R2bmzGdFqYUHmvYksQdbntoAsjlk5R82iaWIzCEhOPbzwfbyVqcglSbQso8TOI3M0H3n+PE7gn/XUNhsFL4d3o7uXIYh2CWx+70YreIypM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCzRiOcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085C6C4CEEE;
	Wed, 19 Mar 2025 08:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742372125;
	bh=4OM7Y0XKHU7jFTd3joafKOXUjyOC5LlTTPCa5DtvEaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RCzRiOcfx3w72TqMf46iCB/9wYcDLCfAu8+kJoXHHYCKd2J9EorZf/pPptWChV2Tf
	 giSX8QwCEGlmHaRG8dHngW+wbtSxN8pa7OTTxcdDrp/JxNwiT8snec03Rn9WyK71Be
	 YhuOjjoYnCeyiy4qiKba2MqSbLZY89CXHA/B19CP2SPbfE6lFpvJt2FEkRcOx0mHwd
	 9sXUe3MdHiatm2bIunqF7QXgLW+RjPSbmBLh4VNKFRKCi/75wi4zJuuo/fo30mNsNJ
	 g3wO73w57/Z2o4zzp2jZQSYxrPSiOyqoTY+nDefk12Ohpu599GdBkmoh+3bMTqLrkH
	 Pp4zhFJftmYfQ==
Date: Wed, 19 Mar 2025 09:15:21 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: iio: dac: Add adi,ad3530r.yaml
Message-ID: <20250319-opalescent-just-boa-fecdc0@krzk-bin>
References: <20250319-togreg-v1-0-d8244a502f2c@analog.com>
 <20250319-togreg-v1-3-d8244a502f2c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250319-togreg-v1-3-d8244a502f2c@analog.com>

On Wed, Mar 19, 2025 at 11:47:57AM +0800, Kim Seer Paller wrote:
> The AD3530R/AD3530 is an 8-Channel, 16-Bit Voltage Output DAC, while the

"Document the AD3530R/AD3530, an 8-Channel, 16-bit...."

> AD3531R/AD3531 is a 4-Channel, 16-Bit Voltage Output DAC. These devices
> include software-programmable gain controls that provide full-scale
> output spans of 2.5V or 5V for reference voltages of 2.5V. They operate
> from a single supply voltage range of 2.7V to 5.5V and are guaranteed to
> be monotonic by design. Additionally, these devices features a 2.5V,
> 5ppm/=C2=B0C internal reference, which is disabled by default.
>=20
> This adds the documentation for ad3530r.

And that sentence us really not needed. See submitting patches.

>=20
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad3530r.yaml   | 89 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 90 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml b=
/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..6b50dce38383c8eb0d2107bf4=
e44cd320776f481
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad3530r.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD3530R and Similar DACs
> +
> +maintainers:
> +  - Kim Seer Paller <kimseer.paller@analog.com>
> +
> +description: |
> +  The AD3530R/AD3530 are low power, 8-channel, 16-bit, buffered voltage =
output,
> +  DACs that include a 2.5V internal reference (disabled by default), and=
 a gain
> +  bit field, resulting in a full-scale output span of 2.5V (gain =3D 1) =
or 5V
> +  (gain =3D 2) for a reference voltage of 2.5V.
> +  Datasheet can be found here:
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/26=
64fa.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad3530r
> +      - adi,ad3531r
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 50000000
> +
> +  vdd-supply:
> +    description: Power Supply Input.
> +
> +  iovdd-supply:
> +    description: Digital Power Supply Input.
> +
> +  ref-supply:
> +    description:
> +      Reference Input/Output. The voltage at the REF pin sets the full-s=
cale
> +      range of all channels. If not provided the internal reference is u=
sed and
> +      also provided on the VREF pin.
> +
> +  reset-gpios:
> +    description:
> +      Active low signal that is falling edge sensitive. When it is deass=
erted,
> +      the digital core initialization is performed and all DAC registers=
 except
> +      the Interface Configuration A register are reset to their default =
values.
> +    maxItems: 1
> +
> +  ldac-gpios:
> +    description:
> +      LDAC pin to be used as a hardware trigger to update the DAC channe=
ls. If
> +      not present, the DAC channels are updated by Software LDAC.
> +    maxItems: 1
> +
> +  adi,double-output-range:
> +    description:
> +      Configure the output range for all channels. If the property is pr=
esent,
> +      the output will range from 0V to 2Vref. If the property is not
> +      present, the output will range from 0V to Vref.

You already have adi,range-double. It's not us who should find it, but
you. You have just ADI bindings to look at. We have all bindings.

Best regards,
Krzysztof


