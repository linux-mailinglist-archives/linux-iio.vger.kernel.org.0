Return-Path: <linux-iio+bounces-10647-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B618499F848
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 22:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2711C22594
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 20:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C631F9EAE;
	Tue, 15 Oct 2024 20:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7tOqAVL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875A71F80DD;
	Tue, 15 Oct 2024 20:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729025359; cv=none; b=qi0NOWqUw9kRcLmxJhJZG0dGxNi70OWRBa9lS/ZSv67rlSl+8sDtGr/q7fyDxzvHhP7yHbgoJarV64TYSBChqe0AAnDV0lLyR1UiUznBY6F6ntjh5eC6gnn9uGVZiyyfkCkXxFDkLdsvxRA7uudto8lbkYjf1LdKLgpSi97/3IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729025359; c=relaxed/simple;
	bh=xj9OvkqMZG5aEAzJvAvOcFXLPpB+0MR2/hG/UCYHGrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWxcb55bZsXAMzzSy6MWALPKQZoiBFcshiRl170XN7eo7MS2iXk4j/ivJM0xRJyEnqn5Zu00nJRzVg1IV55xqwKXLhXKiKmGdDMW//NfuV+w6338fWdqsQkGUzoa/bUggcL/zU/5dMFLsb05Q/Xqf0aqliUpQuBYA+uLWTOHfd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7tOqAVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC159C4CEC6;
	Tue, 15 Oct 2024 20:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729025358;
	bh=xj9OvkqMZG5aEAzJvAvOcFXLPpB+0MR2/hG/UCYHGrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7tOqAVL+1eVN6nsQGdrxdvVvgqwd4KXa2ZT9V4i4+UNiPZw34TgaDLhLEQ3jDqiC
	 uciXApJG1ZVpMoJwmhSP1dR9AGy5FsN9s5VsT99EHfkKMkAl5Cl/iarfOSaXqSXZ9b
	 fUgjKjguPzhKSSTf57YXq9WkxxcCeX+3wPyx3cXdo6Hcs0o1WvkONgZCioyKTTHCGi
	 Wc8aevrg1Ucuh839/5WoXMSBoS+38y0ub7B0JQp1T3ZgWXTsPdnjKkOn/Vw1K63wd6
	 D2is14exr1a5fBoIusU0hi1Xtc5duo3MpiUlAfCIBK/+oK8y8savmlplLb2nxWU17q
	 2RwEKmruGSiFw==
Date: Tue, 15 Oct 2024 15:49:16 -0500
From: Rob Herring <robh@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 1/4] dt-bindings: iio: adc: ad7380: add adaq4370-4
 and adaq4380-4 compatible parts
Message-ID: <20241015204916.GA1926571-robh@kernel.org>
References: <20241015-ad7380-add-adaq4380-4-support-v1-0-d2e1a95fb248@baylibre.com>
 <20241015-ad7380-add-adaq4380-4-support-v1-1-d2e1a95fb248@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241015-ad7380-add-adaq4380-4-support-v1-1-d2e1a95fb248@baylibre.com>

On Tue, Oct 15, 2024 at 11:09:06AM +0200, Julien Stephan wrote:
> adaq4370-4 (2MSPS) and adaq4380-4 (4MSPS) are quad-channel precision data
> acquisition signal chain μModule solutions compatible with the ad738x
> family, with the following differences:
> 
> - configurable gain in front of each 4 adc
> - internal reference is 3V derived from refin-supply (5V)
> - additional supplies
> 
> To configure the gain a new patternProperties is added to describe each
> channel. It is restricted to adaq devices.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 117 +++++++++++++++++++++
>  1 file changed, 117 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> index 74d82721637c..3007d8e39684 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> @@ -25,6 +25,8 @@ description: |
>    * https://www.analog.com/en/products/ad7386-4.html
>    * https://www.analog.com/en/products/ad7387-4.html
>    * https://www.analog.com/en/products/ad7388-4.html
> +  * https://www.analog.com/en/products/adaq4370-4.html
> +  * https://www.analog.com/en/products/adaq4380-4.html
>  
>  
>  $ref: /schemas/spi/spi-peripheral-props.yaml#
> @@ -46,6 +48,8 @@ properties:
>        - adi,ad7386-4
>        - adi,ad7387-4
>        - adi,ad7388-4
> +      - adi,adaq4370-4
> +      - adi,adaq4380-4
>  
>    reg:
>      maxItems: 1
> @@ -59,6 +63,9 @@ properties:
>    vlogic-supply: true
>    refio-supply: true
>    refin-supply: true
> +  vs-p-supply: true
> +  vs-n-supply: true
> +  ldo-supply: true
>  
>    aina-supply:
>      description:
> @@ -86,12 +93,43 @@ properties:
>        specify the ALERT interrupt.
>      maxItems: 1
>  
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
>  required:
>    - compatible
>    - reg
>    - vcc-supply
>    - vlogic-supply
>  
> +patternProperties:
> +  "^channel@([0-3])$":
> +    $ref: adc.yaml
> +    type: object
> +
> +    properties:
> +      reg:
> +        description:
> +          The channel number. From 0 to 3 corresponding to channels A,B,C,D
> +        items:
> +          minimum: 0
> +          maximum: 3

This allows mutiple entries. Is that intended? If so, define the range 
(minItems/maxItems). If not, drop 'items'.

> +
> +      adi,gain-milli:
> +        description:
> +          The hardware gain applied to the ADC input (in milli units).
> +          If not present, default to 1000 (no actual gain applied).
> +        $ref: /schemas/types.yaml#/definitions/uint32

Elsewhere the same property is a uint16. Don't define different types 
for the same property name.


> +        default: 1000

Constraints? minimum/maximum/enum?

