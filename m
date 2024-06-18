Return-Path: <linux-iio+bounces-6530-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0959290DB34
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 20:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9FF4284F55
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 18:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD4E14D435;
	Tue, 18 Jun 2024 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SO9JXZWJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CAE14D718;
	Tue, 18 Jun 2024 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718733608; cv=none; b=oPWFrmbQ9rxIGdtC56Yps3GA+A0/Lq1sLxooPSp+k3YyfrUcPIiZoOqS8ofTiGM+w9bEHZuZ92SWlsgpSzxpPlqy+6YWK6Sk3XEfyUrfH2FMi7xogAHMZwtQ368Y+H2kh4j/v7aespubaY8tpIhwXO9U7XRUUU/YiCSQpN1dqFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718733608; c=relaxed/simple;
	bh=vdLqYT3yxGwrogUijhrPQGbsyui/K4rhU6ujDIkV/qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lxz5t3ug6dGj72tvY+2yJh5zOkLrw0ewueSYAcnmVkTRKwKUdx8sTbHfvpX8lBrsQULX3sKFQWE85IkvLtYu7+B29yAueZHZmX/QFG14T9qJdDIeq6DAebdqfY60U7wHuk59GVDO9+mQPRjiB+cEQEU8CIP2K75TYkdgpk3L2uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SO9JXZWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0B0C4AF1A;
	Tue, 18 Jun 2024 18:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718733607;
	bh=vdLqYT3yxGwrogUijhrPQGbsyui/K4rhU6ujDIkV/qY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SO9JXZWJ4Cfc9gwWhkxjzs/Yl3HTaFP1N/qXTDNuvLU4EBOfQYgB7rQzAm3tBqMnY
	 4mqcay6bgLTj5HmYFrEd0Ct3vqG/jDGIHEcStkxHYouTUjzgWWF8Uk8iZfeqmjwOei
	 MH6QDazUYIhDGYEJqMlyCrygE9dA537nNwSdiEFSWL9yZKRK7wD8JCMDMoLlUiDDQN
	 sP23FbV0SdxfGOyDJeLhnt9lrn0+65vVjXoWZTBmjXA0H46bjhFzdrCfuabTVj08Ix
	 +Z4atmlqRLUYlDaRYmtg0/uoVrVB6GrDZHbyBfmM3DkHnGHhtIJMReX4ug0QhXcit/
	 NIAZYpZo6IEyw==
Date: Tue, 18 Jun 2024 19:00:03 +0100
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: adc: add AD4695 and similar ADCs
Message-ID: <20240618-hexagram-clamp-e716d5bcaa12@spud>
References: <20240617-iio-adc-ad4695-v2-0-63ef6583f25d@baylibre.com>
 <20240617-iio-adc-ad4695-v2-2-63ef6583f25d@baylibre.com>
 <171865982439.3455065.3692466445202658610.robh@kernel.org>
 <993ef797-51e8-4a57-adf3-1599d9fccba6@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TuAqhHoboYrfF8LU"
Content-Disposition: inline
In-Reply-To: <993ef797-51e8-4a57-adf3-1599d9fccba6@baylibre.com>


--TuAqhHoboYrfF8LU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 05:06:29PM -0500, David Lechner wrote:
> On 6/17/24 4:30 PM, Rob Herring (Arm) wrote:
> >=20
> > On Mon, 17 Jun 2024 14:53:13 -0500, David Lechner wrote:
> >> Add device tree bindings for AD4695 and similar ADCs.
> >>
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >> ---
> >>
> >> v2 changes:
> >> * Drop *-wlcsp compatible strings
> >> * Don't use fallback compatible strings
> >> * Reword supply descriptions
> >> * Use standard channel properties instead of adi,pin-pairing
> >> * Fix unnecessary | character
> >> * Fix missing blank line
> >> * Add header file with common mode channel macros
> >> ---
> >>  .../devicetree/bindings/iio/adc/adi,ad4695.yaml    | 290 ++++++++++++=
+++++++++
> >>  MAINTAINERS                                        |  10 +
> >>  include/dt-bindings/iio/adi,ad4695.h               |   9 +
> >>  3 files changed, 309 insertions(+)
> >>
> >=20
> > My bot found errors running 'make dt_binding_check' on your patch:
> >=20
> > yamllint warnings/errors:
> >=20
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/iio/adc/adi,ad4695.yaml: single-channel: missing type definition
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/iio/adc/adi,ad4695.yaml: common-mode-channel: missing type definition
> >=20
> > doc reference errors (make refcheckdocs):
> >=20
> > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/2024=
0617-iio-adc-ad4695-v2-2-63ef6583f25d@baylibre.com
> >=20
> > The base for the series is generally the latest rc1. A different depend=
ency
> > should be noted in *this* patch.
> >=20
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> >=20
> > pip3 install dtschema --upgrade
> >=20
> > Please check and re-submit after running the above command yourself. No=
te
> > that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> > your schema. However, it must be unset to test all examples with your s=
chema.
> >=20
>=20
> I think the problem is that I don't have a well-known commit as the
> base-commit in my cover letter (oversight on my part).

I think for his bot it needs, as written above, to be "in *this* patch".
I'm not sure if that's to allow for manual review, or something the bot
does automagically however.

> single-channel and common-mode-channel are recent additions to the
> common iio/adc.yaml so the types are defined there.
>=20
> make dt_binding_check did pass for me locally before sending the series.

--TuAqhHoboYrfF8LU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnHLIwAKCRB4tDGHoIJi
0k9oAQDJh9OUEoMBxT+qaoCB8mzhkxI04SBsm0hizJ307u2OuAEAv3hQnhWROWsi
GyEp3ufS78WPrPocqXjzHWIV5dpJCQY=
=/fov
-----END PGP SIGNATURE-----

--TuAqhHoboYrfF8LU--

