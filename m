Return-Path: <linux-iio+bounces-6424-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0460B90BBA5
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 22:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025B41C22BFD
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 20:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502F918F2F5;
	Mon, 17 Jun 2024 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5V9a9K5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070A3E542;
	Mon, 17 Jun 2024 20:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654585; cv=none; b=isMdLij3RC0flk2c6rrjP9Z/7Gs2OXbz8vw0ouVj+Hs7269eT/heRi8Xcy75JzZ8iRGO9wOi/Cbun7O2PqedJS/ENT7hQQ8fFNBjKV2AWQAUEohi63egtVGfwazegI2wna3vj5f64oizfk8lgjQDE29GWTdr1MAYwnrJff3raIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654585; c=relaxed/simple;
	bh=C+5qpcinwg9TQTMO8Y5KHbFdJoCAd4QTmSUU4KKt8l0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HnEnRVr/+6+1IHOPSBFEbDC5Gg8Liz/emZOkAO21oMsC0K6N68SoPnx+WaCVbUU5nj6Qwh4ttgdr6uGSGdjUUY+qybRJhC1JhvYSB+fSiOTW9ytdI4tFXMcus3GgnHMeCCqXtRhYDfkXNMr/hFvkssJJrAmnCzNaywqrOSgAuV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5V9a9K5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761FDC2BD10;
	Mon, 17 Jun 2024 20:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718654584;
	bh=C+5qpcinwg9TQTMO8Y5KHbFdJoCAd4QTmSUU4KKt8l0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S5V9a9K5DlZrebgzXB3/ufUjZw2++9r1da8nmDODk6/N5BejdvH8bIoWzeZ9hkWL+
	 7eWfqOyVQKOuNYJy31yJKC649e+6+wIjJtPKKS9JAxTEvyR6aobLh0dw6PJzK997+Z
	 6DfsAomXV5Rf94J/M2DTeSlaJWqYoYpSQGVBlhdQ5Roo5yHR7MOh40v7eGmvyvkECA
	 d1zkZDvgVFBRUWGbfFKwqKGRFj9xFH8c9Js7i42a6P8m+osjH9/G4BdDeWx3FanffA
	 gW9lNynWPUPyFb9T3dcLzbjBTlhlTRjysZgxeytc0/ZFJVa5x2QxtUIEG33P9khZW0
	 LlL80zX9FIzvQ==
Date: Mon, 17 Jun 2024 21:02:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, linux-iio@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, =?UTF-8?B?Sm/Do28=?= Paulo
 =?UTF-8?B?R29uw6dhbHZlcw==?= <joao.goncalves@toradex.com>, =?UTF-8?B?Sm8=?=
 =?UTF-8?B?w6Nv?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <jpaulo.silvagoncalves@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, Conor
 Dooley <conor.dooley@microchip.com>, linux-kernel@vger.kernel.org,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: add ti,ads1119
Message-ID: <20240617210255.560f6188@jic23-huawei>
In-Reply-To: <171865260138.3045376.15728867066959921704.robh@kernel.org>
References: <20240617183215.4080-1-francesco@dolcini.it>
	<20240617183215.4080-2-francesco@dolcini.it>
	<171865260138.3045376.15728867066959921704.robh@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Jun 2024 13:30:01 -0600
"Rob Herring (Arm)" <robh@kernel.org> wrote:

> On Mon, 17 Jun 2024 20:32:14 +0200, Francesco Dolcini wrote:
> > From: Jo=C3=A3o Paulo Gon=C3=A7alves <joao.goncalves@toradex.com>
> >=20
> > Add devicetree bindings for Texas Instruments ADS1119 16-bit ADC
> > with I2C interface.
> >=20
> > Datasheet: https://www.ti.com/lit/gpn/ads1119
> > Signed-off-by: Jo=C3=A3o Paulo Gon=C3=A7alves <joao.goncalves@toradex.c=
om>
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > v3:
> >  - add avdd and dvdd supplies
> >  - add Reviewed-by: Conor Dooley <conor.dooley@microchip.com
> >=20
> > v2:
> >  - add diff-channels and single-channel
> >  - add XOR check to make diff/single channel property required
> >  - add interrupts, reset-gpios and vref-supply to the example
> >  - fix missing additionalProperties/unevaluatedProperties warning in ch=
annels
> >  - remove ti,gain and ti,datarate as they aren't fixed hw properties
> >  - remove unnecessary |
> > ---
> >  .../bindings/iio/adc/ti,ads1119.yaml          | 155 ++++++++++++++++++
> >  MAINTAINERS                                   |   7 +
> >  2 files changed, 162 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads111=
9.yaml
> >  =20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i=
io/adc/ti,ads1119.yaml: single-channel: missing type definition
>=20
> doc reference errors (make refcheckdocs):
>=20
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202406=
17183215.4080-2-francesco@dolcini.it
>=20
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.

Just for the record (and so I remember when I get to reviewing the driver
patch).

This should note dependency on
dd471a2b7759 ("dt-bindings: iio: adc: Add single-channel property")
but seeing as that is only char-misc.git/char-misc-next
I suspect that won't help the bot much!

>=20
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>=20


