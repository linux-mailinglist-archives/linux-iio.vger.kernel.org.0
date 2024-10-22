Return-Path: <linux-iio+bounces-10944-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF05B9AB4DE
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 19:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A292855CC
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 17:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7B71BCA1B;
	Tue, 22 Oct 2024 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hT0FzQ6Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9220C6EB7C;
	Tue, 22 Oct 2024 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617665; cv=none; b=A66l5zWhonNxgaoLAAchugVwkz8CeZ24bpIndxrxCVtlRGo+VgVkRmtrdSYyddeckxAHgwUvOykCvK42gegXye2cLV6LR5PRM2EwpluQp2GM8v01VnyJwF923+h0F5Vwgr3nRSb9ivcnuPrcS4aeoXD7Sibu/kyPb788k/2egI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617665; c=relaxed/simple;
	bh=Xk5gutzTyy9L+8sDdGxf/MzDuFdHh5gkcje73KuaIRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKopxsFbYnK9Gi6YQlbptwoBlWcHmp5DliAhZVbsSruK89OyN2bpQdxSRDL6QdcJy/Yc6Q9ve0VKQmPE0yC/uDzpyPwoVcQJidy+My3VcE8DeesInvbKmHBT2L7A5dcvFe9at+XO+GWtm0VVV4AyN0ZboC/6L+laNMdQDSRAXZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hT0FzQ6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4229BC4CEC3;
	Tue, 22 Oct 2024 17:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729617665;
	bh=Xk5gutzTyy9L+8sDdGxf/MzDuFdHh5gkcje73KuaIRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hT0FzQ6YIEMJNGQzYZNKdjjwqU79Ti/1vFNNSM6CODsVVxtwmqF1/YamfNLhCJRUu
	 bO+riaCDdp4e/8lD1qBrC5EBtQUjlGj69uIyEFPqvpto5jDfZidVa1iIBVIjsHDVaT
	 MebM3jkzBExC/931UEAbxA09OUyyvsyXhqACc7JhVHSvMU8qpsniG0ZL0zLG+wIiUP
	 ICPDijJVqWWFaYOwePSMNSTgMkwrXVxW7jUgb0QiHCg0CXFSwZYnAsOca4grEReFJe
	 A4GostZVrnzTU9XHCrjVMwK4SnZ3G7Pr2c+2D5LC55ZCDDk0Eoiy/8U3c5U29HhQtX
	 UUmkcUR68MGTw==
Date: Tue, 22 Oct 2024 18:21:00 +0100
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
Message-ID: <20241022-napped-labored-6956ce18d986@spud>
References: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
 <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-4-969694f53c5d@baylibre.com>
 <b1ac7d51280caf729d192ca871c26260fdf3697c.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GEYcqo5TSMEtxtrT"
Content-Disposition: inline
In-Reply-To: <b1ac7d51280caf729d192ca871c26260fdf3697c.camel@gmail.com>


--GEYcqo5TSMEtxtrT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 02:36:44PM +0200, Nuno S=E1 wrote:
> On Mon, 2024-10-21 at 14:40 +0200, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> >=20
> > Extend AXI-DAC backend with new features required to interface
> > to the ad3552r DAC. Mainly, a new compatible string is added to
> > support the ad3552r-axi DAC IP, very similar to the generic DAC
> > IP but with some customizations to work with the ad3552r.
> >=20
> > Then, a series of generic functions has been added to match with
> > ad3552r needs. Function names has been kept generic as much as
> > possible, to allow re-utilization from other frontend drivers.
> >=20
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
>=20
> Looks mostly good,
>=20
> one minor thing that (I think) could be improved
> > =A0drivers/iio/dac/adi-axi-dac.c | 269 ++++++++++++++++++++++++++++++++=
+++++++--
> > -
> > =A01 file changed, 255 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-da=
c.c
> > index 04193a98616e..9d6809fe7a67 100644
> > --- a/drivers/iio/dac/adi-axi-dac.c
> > +++ b/drivers/iio/dac/adi-axi-dac.c
> > @@ -46,9 +46,28 @@
> > =A0#define AXI_DAC_CNTRL_1_REG			0x0044
> > =A0#define=A0=A0 AXI_DAC_CNTRL_1_SYNC			BIT(0)
> > =A0#define AXI_DAC_CNTRL_2_REG			0x0048
> > +#define=A0=A0 AXI_DAC_CNTRL_2_SDR_DDR_N		BIT(16)
> > +#define=A0=A0 AXI_DAC_CNTRL_2_SYMB_8B		BIT(14)
> > =A0#define=A0=A0 ADI_DAC_CNTRL_2_R1_MODE		BIT(5)
> > +#define=A0=A0 AXI_DAC_CNTRL_2_UNSIGNED_DATA		BIT(4)
> > +#define AXI_DAC_STATUS_1_REG			0x0054
> > +#define AXI_DAC_STATUS_2_REG			0x0058
> > =A0#define AXI_DAC_DRP_STATUS_REG			0x0074
> > =A0#define=A0=A0 AXI_DAC_DRP_STATUS_DRP_LOCKED		BIT(17)
> > +#define AXI_DAC_CUSTOM_RD_REG			0x0080
> > +#define AXI_DAC_CUSTOM_WR_REG			0x0084
> > +#define=A0=A0 AXI_DAC_CUSTOM_WR_DATA_8		GENMASK(23, 16)
> > +#define=A0=A0 AXI_DAC_CUSTOM_WR_DATA_16		GENMASK(23, 8)
> > +#define AXI_DAC_UI_STATUS_REG			0x0088
> > +#define=A0=A0 AXI_DAC_UI_STATUS_IF_BUSY		BIT(4)
> > +#define AXI_DAC_CUSTOM_CTRL_REG			0x008C
> > +#define=A0=A0 AXI_DAC_CUSTOM_CTRL_ADDRESS		GENMASK(31, 24)
> > +#define=A0=A0 AXI_DAC_CUSTOM_CTRL_SYNCED_TRANSFER	BIT(2)
> > +#define=A0=A0 AXI_DAC_CUSTOM_CTRL_STREAM		BIT(1)
> > +#define=A0=A0 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA	BIT(0)
>=20
> ...
> =A0
> > =A0static int axi_dac_probe(struct platform_device *pdev)
> > =A0{
> > -	const unsigned int *expected_ver;
> > =A0	struct axi_dac_state *st;
> > =A0	void __iomem *base;
> > =A0	unsigned int ver;
> > @@ -566,14 +780,29 @@ static int axi_dac_probe(struct platform_device *=
pdev)
> > =A0	if (!st)
> > =A0		return -ENOMEM;
> > =A0
> > -	expected_ver =3D device_get_match_data(&pdev->dev);
> > -	if (!expected_ver)
> > +	st->info =3D device_get_match_data(&pdev->dev);
> > +	if (!st->info)
> > =A0		return -ENODEV;
> > +	clk =3D devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
> > +	if (IS_ERR(clk)) {
>=20
> If clock-names is not given, then we'll get -EINVAL. Hence we could assum=
e that:
>=20
> 		if (PTR_ERR(clk) !=3D -EINVAL)
> 			return dev_err_probe();

clock-names isn't a required property, but the driver code effectively
makes it one. Doesn't this lookup need to be by index, unless
clock-names is made required for this variant?

--GEYcqo5TSMEtxtrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxfe/AAKCRB4tDGHoIJi
0i2sAP45YDFwtSt/GUcsoW7PROW5pXqdvmVSpehhlInslpVBmQEAlwHiLUeV0efe
1vfCEwKCvA6j0s7TcoFcKzkvkvTgFgE=
=HtA6
-----END PGP SIGNATURE-----

--GEYcqo5TSMEtxtrT--

