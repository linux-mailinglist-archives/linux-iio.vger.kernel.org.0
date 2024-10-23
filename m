Return-Path: <linux-iio+bounces-11007-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E9B9ACEA4
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 17:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C9F11C24E2D
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 15:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1FC1CACE1;
	Wed, 23 Oct 2024 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZANycmS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C469C1C8FB3;
	Wed, 23 Oct 2024 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696981; cv=none; b=sfnNyJ+qb9Zh9ZZqLi2937p9hY6FRuI1q/U/SvgixmOWvlSf2k/kMzLSOSgPeL8vYyR/ZcpOuwV70dOdGA0Vn/ZF5WAt+onvFnS1N0pbyYQnbh1wbO6TNHWtoLfLDHfbJQ5uB5eAsOeJjpfnJjDZ/l+8ErXbqI1+nWaoEEREcRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696981; c=relaxed/simple;
	bh=KXkbSwlGbCZMCSuO/HqUDNu6DmitH+pQc626B5yFwFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrUeiVPbbcNJ2uewd/hfhbWJeqOIq4Vu8X4qmRAWKU6UfPBlZ1BzzY182rZQkTQmxZ6bmdU6sSHwZrmHzNEoXOAWUEFkSUoX/l21zUcglCrFei3sp4/IaOAsrCtip30k9DNT+k5N2S+h+k8DfMv6iNu0QVdLf122UIMl/dM9YZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZANycmS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613FCC4CECD;
	Wed, 23 Oct 2024 15:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729696981;
	bh=KXkbSwlGbCZMCSuO/HqUDNu6DmitH+pQc626B5yFwFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZANycmSnzGOxPgI8KK5fXhNpNn4LV5haxmCQJgpwlbzvIB72HJjTJduSk7C4D/jN
	 c5HH9n6mNDhJd0ezGRDc8IvN++xEk3uF4DcpNNCizXGBiHGeKcJAlwUDp5n3Q50OWP
	 7FIqAxTJ8wQfx6lBAu0hp7G2rhrdzRRWIhpV8fN9M1nRFaGyyV0FDMkmPAgnrwN+Kq
	 JYDGS0EI20ZY6nlDRypzZDK/sEdXGgVBOWXTDdsDlMPbt70hwAyVgp0U0l2sxmrEOw
	 WW6tqv+aXe45a+z9RtrpPHQ7Z+k1DymCwsCSJoHKaFLsRX6OuNm9ZXRHrDEy7sezVU
	 N3JYrItlnmN5Q==
Date: Wed, 23 Oct 2024 16:22:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dlechner@baylibre.com,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 4/8] iio: dac: adi-axi-dac: extend features
Message-ID: <20241023-nifty-electable-64d3b42bce3b@spud>
References: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
 <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-4-969694f53c5d@baylibre.com>
 <b1ac7d51280caf729d192ca871c26260fdf3697c.camel@gmail.com>
 <20241022-napped-labored-6956ce18d986@spud>
 <7a4f8c718029c8c57596d950495fcf28562c6e78.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FcRsxxiByCiYsStm"
Content-Disposition: inline
In-Reply-To: <7a4f8c718029c8c57596d950495fcf28562c6e78.camel@gmail.com>


--FcRsxxiByCiYsStm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 04:56:39PM +0200, Nuno S=E1 wrote:
> On Tue, 2024-10-22 at 18:21 +0100, Conor Dooley wrote:
> > On Tue, Oct 22, 2024 at 02:36:44PM +0200, Nuno S=E1 wrote:
> > > On Mon, 2024-10-21 at 14:40 +0200, Angelo Dureghello wrote:
> > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > >=20
> > > > Extend AXI-DAC backend with new features required to interface
> > > > to the ad3552r DAC. Mainly, a new compatible string is added to
> > > > support the ad3552r-axi DAC IP, very similar to the generic DAC
> > > > IP but with some customizations to work with the ad3552r.
> > > >=20
> > > > Then, a series of generic functions has been added to match with
> > > > ad3552r needs. Function names has been kept generic as much as
> > > > possible, to allow re-utilization from other frontend drivers.
> > > >=20
> > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > ---
> > >=20
> > > Looks mostly good,
> > >=20
> > > one minor thing that (I think) could be improved
> > > > =A0drivers/iio/dac/adi-axi-dac.c | 269
> > > > +++++++++++++++++++++++++++++++++++++++--
> > > > -
> > > > =A01 file changed, 255 insertions(+), 14 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-ax=
i-dac.c
> > > > index 04193a98616e..9d6809fe7a67 100644
> > > > --- a/drivers/iio/dac/adi-axi-dac.c
> > > > +++ b/drivers/iio/dac/adi-axi-dac.c
> > > > @@ -46,9 +46,28 @@
> > > > =A0#define AXI_DAC_CNTRL_1_REG			0x0044
> > > > =A0#define=A0=A0 AXI_DAC_CNTRL_1_SYNC			BIT(0)
> > > > =A0#define AXI_DAC_CNTRL_2_REG			0x0048
> > > > +#define=A0=A0 AXI_DAC_CNTRL_2_SDR_DDR_N		BIT(16)
> > > > +#define=A0=A0 AXI_DAC_CNTRL_2_SYMB_8B		BIT(14)
> > > > =A0#define=A0=A0 ADI_DAC_CNTRL_2_R1_MODE		BIT(5)
> > > > +#define=A0=A0 AXI_DAC_CNTRL_2_UNSIGNED_DATA		BIT(4)
> > > > +#define AXI_DAC_STATUS_1_REG			0x0054
> > > > +#define AXI_DAC_STATUS_2_REG			0x0058
> > > > =A0#define AXI_DAC_DRP_STATUS_REG			0x0074
> > > > =A0#define=A0=A0 AXI_DAC_DRP_STATUS_DRP_LOCKED		BIT(17)
> > > > +#define AXI_DAC_CUSTOM_RD_REG			0x0080
> > > > +#define AXI_DAC_CUSTOM_WR_REG			0x0084
> > > > +#define=A0=A0 AXI_DAC_CUSTOM_WR_DATA_8		GENMASK(23, 16)
> > > > +#define=A0=A0 AXI_DAC_CUSTOM_WR_DATA_16		GENMASK(23, 8)
> > > > +#define AXI_DAC_UI_STATUS_REG			0x0088
> > > > +#define=A0=A0 AXI_DAC_UI_STATUS_IF_BUSY		BIT(4)
> > > > +#define AXI_DAC_CUSTOM_CTRL_REG			0x008C
> > > > +#define=A0=A0 AXI_DAC_CUSTOM_CTRL_ADDRESS		GENMASK(31, 24)
> > > > +#define=A0=A0 AXI_DAC_CUSTOM_CTRL_SYNCED_TRANSFER	BIT(2)
> > > > +#define=A0=A0 AXI_DAC_CUSTOM_CTRL_STREAM		BIT(1)
> > > > +#define=A0=A0 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA	BIT(0)
> > >=20
> > > ...
> > > =A0
> > > > =A0static int axi_dac_probe(struct platform_device *pdev)
> > > > =A0{
> > > > -	const unsigned int *expected_ver;
> > > > =A0	struct axi_dac_state *st;
> > > > =A0	void __iomem *base;
> > > > =A0	unsigned int ver;
> > > > @@ -566,14 +780,29 @@ static int axi_dac_probe(struct platform_devi=
ce
> > > > *pdev)
> > > > =A0	if (!st)
> > > > =A0		return -ENOMEM;
> > > > =A0
> > > > -	expected_ver =3D device_get_match_data(&pdev->dev);
> > > > -	if (!expected_ver)
> > > > +	st->info =3D device_get_match_data(&pdev->dev);
> > > > +	if (!st->info)
> > > > =A0		return -ENODEV;
> > > > +	clk =3D devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
> > > > +	if (IS_ERR(clk)) {
> > >=20
> > > If clock-names is not given, then we'll get -EINVAL. Hence we could a=
ssume
> > > that:
> > >=20
> > > 		if (PTR_ERR(clk) !=3D -EINVAL)
> > > 			return dev_err_probe();
> >=20
> > clock-names isn't a required property, but the driver code effectively
> > makes it one. Doesn't this lookup need to be by index, unless
> > clock-names is made required for this variant?
>=20
> Likely I'm missing something but the driver is not making clock-names man=
datory,
> is it?

Did you miss the "for this variant"? Maybe I left the comment in not
exactly the right place, but I don't think the code works correctly for
the new variant if clock-names aren't provided:

+	if (st->info->has_dac_clk) {
+		struct clk *dac_clk;
+		dac_clk =3D devm_clk_get_enabled(&pdev->dev, "dac_clk");
+		if (IS_ERR(dac_clk))
+			return dev_err_probe(&pdev->dev, PTR_ERR(dac_clk),
+					     "failed to get dac_clk clock\n");
+
+		/* We only care about the streaming mode rate */
+		st->dac_clk_rate =3D clk_get_rate(dac_clk) / 2;

Isn't this going to cause a probe failure?

> At least for the s_axi_aclk, we first try to get it using clock-names and=
 if
> that fails we backup to what we're doing which is passing NULL (which
> effectively get's the first clock in the array).
>=20
> The reasoning is that on the generic variant we only need the AXI clk and=
 we
> can't now enforce clock-names on it. But to keep things flexible, this was
> purposed.

Why not always just get the first clock by index and avoid the
complexity?

> Another alternative that might have more lines of code (but simpler to
> understand the intent) is to have (for example) a callback get_clocks fun=
ction
> that we set depending on the variant. And this also makes me realize that=
 we
> could improve the bindings. I mean, for the generic dac variant we do not=
 need
> clock-names but for this new variant, clock-names is mandatory and I'm fa=
irly
> sure we can express that in the bindings.

Right. You can "edit" required in the if/then/else branch for the new
variant.

--FcRsxxiByCiYsStm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxkUvwAKCRB4tDGHoIJi
0iH0AQDT3WZkbiqQZikEUWqx6FC6ZERzFp5cE6EJ0uvCHfGrpwD+MwupjN9w4Yz7
A9SQRFg6vReiv04lQ/Myk3KErlH/8Qg=
=anK4
-----END PGP SIGNATURE-----

--FcRsxxiByCiYsStm--

