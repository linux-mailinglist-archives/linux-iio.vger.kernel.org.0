Return-Path: <linux-iio+bounces-11361-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F33B9B1A14
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 19:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3724D1C2124A
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 17:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BF41632E4;
	Sat, 26 Oct 2024 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jyt/e+e1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728E2538A;
	Sat, 26 Oct 2024 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729963934; cv=none; b=iZFzFzBfXP9lILv5VeLW46LA7GwIouhfSbijpgmD+r0rHeUqIECz4YxXF17Hr/EPeX0E9fCi714s6AHIQRWJlXwjrmjk831FO45RMp5U8dtjxKeUxpoqwgZ5OAvmFP2fagAbhTd5pGbO1IDkBPgPQGiOVeboXHssSfBuoK1eRtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729963934; c=relaxed/simple;
	bh=rUnZ5kkXLNBRuAKMSHv34gVmvS3aonfR4YgdC/gPSNA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NoI2VriDvXHFgLwb6aVNuS/Niwy9ne37FUeWn6BgC6rgvH8vM0j3eOhI+j09YnaEDo4uuwXvJXkR5oU4JMdXFqLUCsTjMyRO1TJF0JXU9FY7t2JAeLpi1yU7CX3U1PL7MzpuxGYT6F5O3GNI3U2YmclgziF/zFWxE1ceD40lbRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jyt/e+e1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EFAC4CEC6;
	Sat, 26 Oct 2024 17:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729963934;
	bh=rUnZ5kkXLNBRuAKMSHv34gVmvS3aonfR4YgdC/gPSNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jyt/e+e1TUfiSaybDlBfL6DqdeKg48AL6kon8Q86LXdsMfXv50qkgbXZ3Dn0aLUQD
	 E8EQmf5ZyGsQW17qk8Kr2ZbXsuODpQn4TCUjij5zp0THokgGFZ342oXAFly3UYgKLU
	 wSvWgIgUcXs/YX/Sa0uTLLV8U76K8VSBZHR1JgksiTkWw2/5/4rGyA3gwpv5T02o73
	 myGqfi2LzD8ATDMjUpfuMAYI1O0w+QXw+l0h7rpx22FpJi+Zl9ypGKHdvqV6mVUZTs
	 VbTIg9zGRleYs3D14z9+7CB4IEz9yu5oNL8JFpf/vp1WzIP05VNaKeDLze66qKYP+d
	 WHLED7MN0iA1A==
Date: Sat, 26 Oct 2024 18:31:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Conor Dooley
 <conor@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier
 Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 4/8] iio: dac: adi-axi-dac: extend features
Message-ID: <20241026183131.6c75ce56@jic23-huawei>
In-Reply-To: <szncfysidctefmjb5u5l7kabyxa76rvuwao34nrue6menohfn2@4x7gyvmzat62>
References: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
	<20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-4-969694f53c5d@baylibre.com>
	<b1ac7d51280caf729d192ca871c26260fdf3697c.camel@gmail.com>
	<20241022-napped-labored-6956ce18d986@spud>
	<7a4f8c718029c8c57596d950495fcf28562c6e78.camel@gmail.com>
	<20241023-nifty-electable-64d3b42bce3b@spud>
	<172316a342407e74840894f553d7647a19fd89d4.camel@gmail.com>
	<szncfysidctefmjb5u5l7kabyxa76rvuwao34nrue6menohfn2@4x7gyvmzat62>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Oct 2024 12:29:29 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> On 24.10.2024 09:04, Nuno S=C3=A1 wrote:
> > On Wed, 2024-10-23 at 16:22 +0100, Conor Dooley wrote: =20
> > > On Wed, Oct 23, 2024 at 04:56:39PM +0200, Nuno S=C3=A1 wrote: =20
> > > > On Tue, 2024-10-22 at 18:21 +0100, Conor Dooley wrote: =20
> > > > > On Tue, Oct 22, 2024 at 02:36:44PM +0200, Nuno S=C3=A1 wrote: =20
> > > > > > On Mon, 2024-10-21 at 14:40 +0200, Angelo Dureghello wrote: =20
> > > > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > > > >=20
> > > > > > > Extend AXI-DAC backend with new features required to interface
> > > > > > > to the ad3552r DAC. Mainly, a new compatible string is added =
to
> > > > > > > support the ad3552r-axi DAC IP, very similar to the generic D=
AC
> > > > > > > IP but with some customizations to work with the ad3552r.
> > > > > > >=20
> > > > > > > Then, a series of generic functions has been added to match w=
ith
> > > > > > > ad3552r needs. Function names has been kept generic as much as
> > > > > > > possible, to allow re-utilization from other frontend drivers.
> > > > > > >=20
> > > > > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > > > > --- =20
> > > > > >=20
> > > > > > Looks mostly good,
> > > > > >=20
> > > > > > one minor thing that (I think) could be improved =20
> > > > > > > =C2=A0drivers/iio/dac/adi-axi-dac.c | 269
> > > > > > > +++++++++++++++++++++++++++++++++++++++--
> > > > > > > -
> > > > > > > =C2=A01 file changed, 255 insertions(+), 14 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/=
adi-axi-dac.c
> > > > > > > index 04193a98616e..9d6809fe7a67 100644
> > > > > > > --- a/drivers/iio/dac/adi-axi-dac.c
> > > > > > > +++ b/drivers/iio/dac/adi-axi-dac.c
> > > > > > > @@ -46,9 +46,28 @@
> > > > > > > =C2=A0#define AXI_DAC_CNTRL_1_REG			0x0044
> > > > > > > =C2=A0#define=C2=A0=C2=A0 AXI_DAC_CNTRL_1_SYNC			BIT(0)
> > > > > > > =C2=A0#define AXI_DAC_CNTRL_2_REG			0x0048
> > > > > > > +#define=C2=A0=C2=A0 AXI_DAC_CNTRL_2_SDR_DDR_N		BIT(16)
> > > > > > > +#define=C2=A0=C2=A0 AXI_DAC_CNTRL_2_SYMB_8B		BIT(14)
> > > > > > > =C2=A0#define=C2=A0=C2=A0 ADI_DAC_CNTRL_2_R1_MODE		BIT(5)
> > > > > > > +#define=C2=A0=C2=A0 AXI_DAC_CNTRL_2_UNSIGNED_DATA		BIT(4)
> > > > > > > +#define AXI_DAC_STATUS_1_REG			0x0054
> > > > > > > +#define AXI_DAC_STATUS_2_REG			0x0058
> > > > > > > =C2=A0#define AXI_DAC_DRP_STATUS_REG			0x0074
> > > > > > > =C2=A0#define=C2=A0=C2=A0 AXI_DAC_DRP_STATUS_DRP_LOCKED		BIT(=
17)
> > > > > > > +#define AXI_DAC_CUSTOM_RD_REG			0x0080
> > > > > > > +#define AXI_DAC_CUSTOM_WR_REG			0x0084
> > > > > > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_WR_DATA_8		GENMASK(23, 16)
> > > > > > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_WR_DATA_16		GENMASK(23, 8)
> > > > > > > +#define AXI_DAC_UI_STATUS_REG			0x0088
> > > > > > > +#define=C2=A0=C2=A0 AXI_DAC_UI_STATUS_IF_BUSY		BIT(4)
> > > > > > > +#define AXI_DAC_CUSTOM_CTRL_REG			0x008C
> > > > > > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_ADDRESS		GENMASK(31,=
 24)
> > > > > > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_SYNCED_TRANSFER	BIT(=
2)
> > > > > > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_STREAM		BIT(1)
> > > > > > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA	BIT(0)=
 =20
> > > > > >=20
> > > > > > ...
> > > > > > =C2=A0 =20
> > > > > > > =C2=A0static int axi_dac_probe(struct platform_device *pdev)
> > > > > > > =C2=A0{
> > > > > > > -	const unsigned int *expected_ver;
> > > > > > > =C2=A0	struct axi_dac_state *st;
> > > > > > > =C2=A0	void __iomem *base;
> > > > > > > =C2=A0	unsigned int ver;
> > > > > > > @@ -566,14 +780,29 @@ static int axi_dac_probe(struct platfor=
m_device
> > > > > > > *pdev)
> > > > > > > =C2=A0	if (!st)
> > > > > > > =C2=A0		return -ENOMEM;
> > > > > > > =C2=A0
> > > > > > > -	expected_ver =3D device_get_match_data(&pdev->dev);
> > > > > > > -	if (!expected_ver)
> > > > > > > +	st->info =3D device_get_match_data(&pdev->dev);
> > > > > > > +	if (!st->info)
> > > > > > > =C2=A0		return -ENODEV;
> > > > > > > +	clk =3D devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
> > > > > > > +	if (IS_ERR(clk)) { =20
> > > > > >=20
> > > > > > If clock-names is not given, then we'll get -EINVAL. Hence we c=
ould assume
> > > > > > that:
> > > > > >=20
> > > > > > 		if (PTR_ERR(clk) !=3D -EINVAL)
> > > > > > 			return dev_err_probe(); =20
> > > > >=20
> > > > > clock-names isn't a required property, but the driver code effect=
ively
> > > > > makes it one. Doesn't this lookup need to be by index, unless
> > > > > clock-names is made required for this variant? =20
> > > >=20
> > > > Likely I'm missing something but the driver is not making clock-nam=
es mandatory,
> > > > is it? =20
> > >=20
> > > Did you miss the "for this variant"? Maybe I left the comment in not =
=20
> >=20
> > I guess so :)
> >  =20
> > > exactly the right place, but I don't think the code works correctly f=
or
> > > the new variant if clock-names aren't provided:
> > >=20
> > > +	if (st->info->has_dac_clk) {
> > > +		struct clk *dac_clk;
> > > +		dac_clk =3D devm_clk_get_enabled(&pdev->dev, "dac_clk");
> > > +		if (IS_ERR(dac_clk))
> > > +			return dev_err_probe(&pdev->dev, PTR_ERR(dac_clk),
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get dac_clk clock\n");
> > > +
> > > +		/* We only care about the streaming mode rate */
> > > +		st->dac_clk_rate =3D clk_get_rate(dac_clk) / 2;
> > >=20
> > > Isn't this going to cause a probe failure? =20
> >=20
> > Exactly. And that goes in line with what I wrote about the bindings not=
 describing
> > (currently) this. So yes, for the new variant (which has 'has_dac_clk' =
set to true)
> > clock-names is indeed mandatory and probe will fail if it's not given.
> >  =20
> > >   =20
> > > > At least for the s_axi_aclk, we first try to get it using clock-nam=
es and if
> > > > that fails we backup to what we're doing which is passing NULL (whi=
ch
> > > > effectively get's the first clock in the array).
> > > >=20
> > > > The reasoning is that on the generic variant we only need the AXI c=
lk and we
> > > > can't now enforce clock-names on it. But to keep things flexible, t=
his was
> > > > purposed. =20
> > >=20
> > > Why not always just get the first clock by index and avoid the
> > > complexity? =20
> >=20
> > And that was also suggested in the previous version but then Jonathan s=
uggested this
> > [1]. I agree things now are a bit confusing because we expect clock-nam=
es to be
> > optional for the generic but mandatory for this new variant and the cod=
e is not being
> > that explicit about it.
> >  =20

If we need all the clocks for a variant to work, then can instead constrain=
 the clock
names if present.  So basically enforce the indexing.

I think just requiring clock-names for this variant is cleaner though!

Jonathan
> > >  =20
> > > > Another alternative that might have more lines of code (but simpler=
 to
> > > > understand the intent) is to have (for example) a callback get_cloc=
ks function
> > > > that we set depending on the variant. And this also makes me realiz=
e that we
> > > > could improve the bindings. I mean, for the generic dac variant we =
do not need
> > > > clock-names but for this new variant, clock-names is mandatory and =
I'm fairly
> > > > sure we can express that in the bindings. =20
> > >=20
> > > Right. You can "edit" required in the if/then/else branch for the new
> > > variant. =20
> >=20
> > Yeah, and IMO that should be set in the bindings (it would help underst=
anding what
> > the driver is actually doinfg.
> > =20
>=20
> ok, thanks, so=20
>=20
> so modified yaml in this way:
>=20
>   clocks:
>     minItems: 1
>     maxItems: 2
>=20
>   clock-names:
>     items:
>       - const: s_axi_aclk
>       - const: dac_clk
>     minItems: 1
>=20
>   '#io-backend-cells':
>     const: 0
>=20
> required:
>   - compatible
>   - dmas
>   - reg
>   - clocks
>=20
> allOf:
>   - if:
>       properties:
>         compatible:
>           contains:
>             const: adi,axi-ad3552r
>     then:
>       $ref: /schemas/spi/spi-controller.yaml#
>       properties:
>         clocks:
>           minItems: 2
>         clock-names:
>           minItems: 2
>       required:
>         - clock-names
>     else:
>       properties:
>         clocks:
>           maxItems: 1
>         clock-names:
>           maxItems: 1
>=20
> =20
> > [1]: https://lore.kernel.org/linux-iio/20241019160817.10c3a2bf@jic23-hu=
awei/
> >=20
> > - Nuno S=C3=A1
> >  =20
>=20
> Regards,
>   angelo
>=20


