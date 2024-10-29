Return-Path: <linux-iio+bounces-11543-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2B09B4336
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 08:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3982283856
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 07:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F73202654;
	Tue, 29 Oct 2024 07:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpK6P1En"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9A9202643;
	Tue, 29 Oct 2024 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730187407; cv=none; b=I/BSejF9cymnrEO+orI7OE+1od5yvf2JbJH4rTVLZRC0uAyvFLHmmUPMZ1hNYR+qTCUHYvsLy5AEM/ZPJ760izGF72tCguSY9RgHwo0aThFor7IGVvz7fPWZFb8VmGthhyCoIDPaLE9Hyz2upfgrRRH6OT+gxi8iAQ2g/UUE08M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730187407; c=relaxed/simple;
	bh=kNTBoqky3ZSkNmN5ExCWZnozRHqT5V5FzCWXQyyTH50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwmdrjhlTCWceGgNnctc8iw0s9SQ0nh8xhP4oe09nr5W1H8+WNznAixZul4ttl5I2uGw1X86knQVGwx7m7uQ4m4aVfqhbe0cUH0iBsbN/XlnyHfZVRAPYt1EmwoBhwp+myiZCAfrZoHziF7oIJNqhiO3HIujk6KA08Kes2yF8gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpK6P1En; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF136C4CEE6;
	Tue, 29 Oct 2024 07:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730187406;
	bh=kNTBoqky3ZSkNmN5ExCWZnozRHqT5V5FzCWXQyyTH50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dpK6P1En9oRzOphi3kiEQdy2vUHVWRCtZsGmlWemjHoz6GVtEnBnez8z2p0wIyLrU
	 1a8f+R+9PWFJZMKAk5NclItCWB9/rQZYEMiVFapSTzQEXl9lqA4+1r4mJj46lX18uX
	 RSbL4pBepRygfr13STnnVWiXueHcddPMKLeWntNk3sbJq0xCvLgwl07EdGEiJPd84X
	 1KTWUhbrp8S245I+AWZvOMP2bEogQ5NoTGzo64vZho6U0DBy5f1tLPPhwwNaYbmTuY
	 U0tBWyomYgbPk71PKW31xg38Ow38r4TTM8RBNF9obkPg9tMWjadKld3Kdan4Tz8TKs
	 i3ptPy1eWW8XA==
Date: Tue, 29 Oct 2024 08:36:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Dumitru Ceclan <dumitru.ceclan@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: adc: adi,ad7124: Use symbolic
 name for interrupt flag
Message-ID: <slxpfomdbs5bdg34tyayjfq4uv5tm23lep4xezwstkkmdvzq62@jlfvbmwsla7j>
References: <20241028160748.489596-6-u.kleine-koenig@baylibre.com>
 <20241028160748.489596-7-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241028160748.489596-7-u.kleine-koenig@baylibre.com>

On Mon, Oct 28, 2024 at 05:07:50PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Using IRQ_TYPE_EDGE_FALLING instead of 2 makes the example easier to
> understand for a human (and adds only little more effort for a parser).
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> index 35ed04350e28..de49b571bd57 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> @@ -111,6 +111,7 @@ unevaluatedProperties: false
> =20
>  examples:
>    - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
>      spi {
>        #address-cells =3D <1>;
>        #size-cells =3D <0>;
> @@ -119,7 +120,7 @@ examples:
>          compatible =3D "adi,ad7124-4";
>          reg =3D <0>;
>          spi-max-frequency =3D <5000000>;
> -        interrupts =3D <25 2>;
> +        interrupts =3D <25 IRQ_TYPE_EDGE_FALLING>;

Sorry, but this is trivial. Do it for all the bindings in IIO or IIO/ADC
in one patch. Or just leave it because old code was correct.

Best regards,
Krzysztof


