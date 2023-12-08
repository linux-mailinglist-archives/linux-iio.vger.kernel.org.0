Return-Path: <linux-iio+bounces-764-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D9C80A76F
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 16:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 891C22815E4
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 15:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8591530CF5;
	Fri,  8 Dec 2023 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R13ny3bt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4288130337;
	Fri,  8 Dec 2023 15:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7409DC433C8;
	Fri,  8 Dec 2023 15:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702049422;
	bh=RxJt1IRw23UP09MyvDYjKFY8QGbl8CX8IEuwGzGDpgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R13ny3btIbS4w0W3novK6XpflowpC1xFiBtWnPtqpUiq1nuPzfTgc9m11amAp63Sx
	 4jBPZRV2bvycN2CnwcswRVeRoFHk69GyEfJ86HnjqBNVmO6o5Gh4l2CI4xkX7bHL75
	 /aYuX0NIaZQR1tHtKZ7r3b/WCiWsjgUY0JoayDHYLSEE9A4BF93d3jv0wMsEJGBmPf
	 QMgdOu2FDSl9qlwZeDtFQGcV07RSH7tXBdh1KLrInT6bq5t8xyMcSv0fwtrvXtsXRY
	 T2/RxCFooy1qkuds85M1PCsUQ3b27vzg+08G9urJD7lKSSIXVBXW1SwZR+5PGOFrdI
	 AkM/2hKkTygBg==
Date: Fri, 8 Dec 2023 15:30:17 +0000
From: Conor Dooley <conor@kernel.org>
To: nuno.sa@analog.com
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v2 0/8] iio: add new backend framework
Message-ID: <20231208-corridor-outfit-ae0314b29186@spud>
References: <20231208-dev-iio-backend-v2-0-5450951895e1@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eoSVKmAJ/NfelqU5"
Content-Disposition: inline
In-Reply-To: <20231208-dev-iio-backend-v2-0-5450951895e1@analog.com>


--eoSVKmAJ/NfelqU5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 04:14:07PM +0100, Nuno Sa via B4 Relay wrote:
> This series depends on [1] and it only build on top of it. The point is
> to already speed up the reviewing of the framework. That obviously means
> that all those pacthes were dropped in v2.
>=20
> v1:
>  https://lore.kernel.org/linux-iio/20231204144925.4fe9922f@jic23-huawei/T=
/#m222f5175273b81dbfe40b7f0daffcdc67d6cb8ff
>=20
> Changes in v2:
>  - Patch 1-2 and 5
>    * new patches.
>  - Patch 6:
>    * Fixed some docs failures;
>    * Fixed a legacy 'conv' name in one of the function parameters;
>    * Added .request_buffer() and .free_buffer() ops;
>    * Refactored the helper macros;
>    * Added Olivier as Reviewer.
>  - Patch 7:
>    * Use new devm_iio_backend_request_buffer().
>  - Patch 8:
>    * Implement new .request_buffer() and .free_buffer() ops;
>=20
> Also would like to mention that in v2 I'm experimenting in having the
> DMA on the backend device (as discussed with David in v1). Does not look
> to bad but as I said before, I'm not seeing a big issue if we end up
> having the buffer allocation in the frontend.
>=20
> For the bindings folks:
>=20
> I'm introducing a new io-backends property in the ad9467 bindings but I'm
> not sure this is the way to do it. Ideally that new property become a
> generic schema and I'm guessing I should send a PULL to?
>=20
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/ii=
o/iio-consumer.yaml

That seems like the right thing to do to me, depending on how widespread
the use of these backends might be. What is seemingly missing though,
=66rom this cover and from the bindings patch in the series in particular,
is an explanation of what the "iio-backends" hardware actually is.

There is some text below, but it does not seem complete to me. Is the
idea that this "backend" is shared between multiple frontend consumers?
The one example is described as being "highly focused on ADI usecases"

Thanks,
Conor.

>=20
> (Jonathan, if you think that's not the right place, shout now :))
>=20
> I'm also deprecating 'adi,adc-dev' as it is not relevant anymore. In the
> driver code, we are actually breaking ABI but I'm taking a more
> conservative approach in the bindings. Ideally I would also remove it in
> the bindings :).
> =20
>=20
> As requested here we have a small diagram that illustrated on e typical
> usage of the new framework:
>=20
>                                            ------------------------------=
-------------------------
>  ------------------                        | -----------         --------=
----      -------  FPGA |
>  |     ADC        |------------------------| | AXI ADC |---------| DMA CO=
RE |------| RAM |       |
>  | (Frontend/IIO) | Serial Data (eg: LVDS) | |(backend)|---------|       =
   |------|     |       |
>  |                |------------------------| -----------         --------=
----      -------       |
>  ------------------                        ------------------------------=
-------------------------
> =20
> The above is highly focused on ADI usecases. But one can see the idea...
> The frontend is the real converter and is the one registering and
> handling all the IIO interfaces. Such a device can then connect to a
> backend device for further services/configurations. In the above
> example, the backend device is an high speed core capable of handling
> the high sample rate of these ADCs so that it can push that data further
> in the pipeline (typically a DMA core) so the user can process the
> samples with minimal losses.
>=20
> Jonathan, I was also tempted in including the diagram in the source
> file. Would that be a good idea?
>=20
> [1]: https://lore.kernel.org/linux-iio/20231207-iio-backend-prep-v2-0-a4a=
33bc4d70e@analog.com
>=20
> ---
> Nuno Sa (7):
>       dt-bindings: adc: ad9467: document io-backend property
>       dt-bindings: adc: axi-adc: deprecate 'adi,adc-dev'
>       driver: core: allow modifying device_links flags
>       iio: buffer-dmaengine: export buffer alloc and free functions
>       iio: add the IIO backend framework
>       iio: adc: ad9467: convert to backend framework
>       iio: adc: adi-axi-adc: move to backend framework
>=20
> Olivier Moysan (1):
>       of: property: add device link support for io-backends
>=20
>  .../devicetree/bindings/iio/adc/adi,ad9467.yaml    |   5 +
>  .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   |   4 +-
>  MAINTAINERS                                        |   8 +
>  drivers/base/core.c                                |  14 +-
>  drivers/iio/Kconfig                                |   5 +
>  drivers/iio/Makefile                               |   1 +
>  drivers/iio/adc/Kconfig                            |   3 +-
>  drivers/iio/adc/ad9467.c                           | 242 +++++++------
>  drivers/iio/adc/adi-axi-adc.c                      | 379 +++++----------=
-----
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c |   6 +-
>  drivers/iio/industrialio-backend.c                 | 386 +++++++++++++++=
++++++
>  drivers/of/property.c                              |   2 +
>  include/linux/iio/adc/adi-axi-adc.h                |  68 ----
>  include/linux/iio/backend.h                        |  68 ++++
>  include/linux/iio/buffer-dmaengine.h               |   4 +-
>  15 files changed, 727 insertions(+), 468 deletions(-)
> ---
> base-commit: 330c0f834ccbdbe6a89da475cb1c56893f3a8363
> change-id: 20231120-dev-iio-backend-d14b473a1d9f
> --
>=20
> Thanks!
> - Nuno S=E1
>=20

--eoSVKmAJ/NfelqU5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXM2iQAKCRB4tDGHoIJi
0lgFAP9hVMM+0foMZ39lHZxREYl1j4NJ9VRydAwMC8Q1ls3g1wD9EqYOPQMRXMRx
vlwyvuGpRHLVuQWvttO+WGitIDvAsQI=
=kq3S
-----END PGP SIGNATURE-----

--eoSVKmAJ/NfelqU5--

