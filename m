Return-Path: <linux-iio+bounces-11053-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2909ADD02
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 09:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4955F1F234B0
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 07:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57987187856;
	Thu, 24 Oct 2024 07:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Toq6ut2J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02566F305;
	Thu, 24 Oct 2024 07:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729753452; cv=none; b=fsYyTZ1aOvqgigerYbaXu+U3L+PbQ+Mze4OaWfHl2KVX4Kr9FQEdK8IvZ1zHWAqKIIXvFM1s2FTpczW6ipyFUDIRURVda13gjLs44z+bdVfhuZy55u4Byu4xL07wMCj4YrRhg+5iZRVzlhxktWy/YBmAx17vssONEle4oM/SLmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729753452; c=relaxed/simple;
	bh=mDC/8Q59Kp9X3A7MbNw+GloLWP3YocOvDtvtbVfdKL0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=spMhxGzrVT5odrcHbwpd3/LTzOk1NExpMSyEIb12XHwjc8m9K7L01/nTRB8y8bX+CyTboSFt6dTWRIXv2oqZG5xOfmHVsYDVXSpaZAtNwhxhnv/vl+ycodZK5rd+Lf9Lv8HCcuqJI5DL7oJtey72tNDMeuAQmZihHaJArHBPtd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Toq6ut2J; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d50fad249so370352f8f.1;
        Thu, 24 Oct 2024 00:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729753448; x=1730358248; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gaO5ZJCKrm/xR1gk3wMiIjpwWvNXeWYk0cMuBrThX8I=;
        b=Toq6ut2J7KnxkraQpRK29djiMHF2qt483ZagFn+i+DtXz0XoT32BdMVoEdpdcZqZo3
         3EL02iLAzTHJ7V4Kwd8LFf4eObTfBrk3LFugfXD+mMPsbiRswXbFeormpyoeyNSmHoCu
         gsXVsW0W1INtKKCqHdq7+GlDnLkb8477kRpvHXIBSTpBZmLy5Pvav8hsxr78WX77iTEx
         Yk1f0hhAFuYDLec2DCAy6R1RhVyKrvOMCeUMHVpLgTlXYk77Yc1eR00V6wzvN4hxTRAS
         spZE3keBsvUcf0yzC57X13fdOjPd28a8q3OrzbAlr9FJCkIHKf8xxR6XrvuMs+fSyBH7
         kixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729753448; x=1730358248;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gaO5ZJCKrm/xR1gk3wMiIjpwWvNXeWYk0cMuBrThX8I=;
        b=cJDisMhgW7dnG49WAhK9pHsK6g4B348J6846/QzVbCWX3B4saD7bxcOYebOOe0F8H7
         dqIfepuINGXTYVxCiilKXNXu8QNsoc6aOizE2GDs6ZEHkrcG6392JImBWJnqbk1wsCLx
         tkbs7xEfb9IqgmSEdWcBXgUCBMZU3mG4YOWbcexmaz15TQRfRslKbPv0E0y2wXH7xu6/
         KsIghWb6UDzuh3bg3j+G2u/Qruh8uxHMQaoOiBrZ0bk0Ev2XuRZRcJYqXLn1rKuKuwWj
         l2y2LkhWOShEeGgCnbOIguTmx8xlkT00VyLeG56+Aua1Gg8cMdamaocord1VQGZGN7uQ
         21ug==
X-Forwarded-Encrypted: i=1; AJvYcCW2WeGf+Zr+GKXrLlLUcVOQfUaUCPWoRGEg/Sv+6nyS/52dx5dI5S9OwtkHn5zP78FFNb8c3pI2xfOH@vger.kernel.org, AJvYcCXNHXcIy9fUvZdRAhsivYfexao8Y4NR1Lt7WONUlSi6u/BS1XttZ/O0vJVfLGQhFhcaLjXTQTDFX77E@vger.kernel.org, AJvYcCXr5CSudVxDCkg0oQiHYz2uvkz/DuOMdicELdmVg/3qeRAHTluDjWEW2fPbA/fNgeyQdTzwkUFSJMoo7fMJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn0JuCmay0NPjPV7ZlCUqceuZSM+6l4Qgp8BXBXWRVCLILCyVn
	JUQPWXlRkFDBnx7MF+BRxbQj5y+zP02wg73v7wasOzI6/201Acf5
X-Google-Smtp-Source: AGHT+IHo5m6TFs7UWYRTvOo3gKx6qOYaFwuywUAmYUpYXCZ604f0zwHp6Hak2iSl/iXSgbzUBbI+Dg==
X-Received: by 2002:a5d:6b03:0:b0:37d:476d:2d58 with SMTP id ffacd0b85a97d-380458d5b69mr644802f8f.45.1729753447630;
        Thu, 24 Oct 2024 00:04:07 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9b41fsm10502004f8f.93.2024.10.24.00.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 00:04:07 -0700 (PDT)
Message-ID: <172316a342407e74840894f553d7647a19fd89d4.camel@gmail.com>
Subject: Re: [PATCH v7 4/8] iio: dac: adi-axi-dac: extend features
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
 dlechner@baylibre.com, Mark Brown <broonie@kernel.org>
Date: Thu, 24 Oct 2024 09:04:06 +0200
In-Reply-To: <20241023-nifty-electable-64d3b42bce3b@spud>
References: 
	<20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
	 <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-4-969694f53c5d@baylibre.com>
	 <b1ac7d51280caf729d192ca871c26260fdf3697c.camel@gmail.com>
	 <20241022-napped-labored-6956ce18d986@spud>
	 <7a4f8c718029c8c57596d950495fcf28562c6e78.camel@gmail.com>
	 <20241023-nifty-electable-64d3b42bce3b@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-23 at 16:22 +0100, Conor Dooley wrote:
> On Wed, Oct 23, 2024 at 04:56:39PM +0200, Nuno S=C3=A1 wrote:
> > On Tue, 2024-10-22 at 18:21 +0100, Conor Dooley wrote:
> > > On Tue, Oct 22, 2024 at 02:36:44PM +0200, Nuno S=C3=A1 wrote:
> > > > On Mon, 2024-10-21 at 14:40 +0200, Angelo Dureghello wrote:
> > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > >=20
> > > > > Extend AXI-DAC backend with new features required to interface
> > > > > to the ad3552r DAC. Mainly, a new compatible string is added to
> > > > > support the ad3552r-axi DAC IP, very similar to the generic DAC
> > > > > IP but with some customizations to work with the ad3552r.
> > > > >=20
> > > > > Then, a series of generic functions has been added to match with
> > > > > ad3552r needs. Function names has been kept generic as much as
> > > > > possible, to allow re-utilization from other frontend drivers.
> > > > >=20
> > > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > > ---
> > > >=20
> > > > Looks mostly good,
> > > >=20
> > > > one minor thing that (I think) could be improved
> > > > > =C2=A0drivers/iio/dac/adi-axi-dac.c | 269
> > > > > +++++++++++++++++++++++++++++++++++++++--
> > > > > -
> > > > > =C2=A01 file changed, 255 insertions(+), 14 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-=
axi-dac.c
> > > > > index 04193a98616e..9d6809fe7a67 100644
> > > > > --- a/drivers/iio/dac/adi-axi-dac.c
> > > > > +++ b/drivers/iio/dac/adi-axi-dac.c
> > > > > @@ -46,9 +46,28 @@
> > > > > =C2=A0#define AXI_DAC_CNTRL_1_REG			0x0044
> > > > > =C2=A0#define=C2=A0=C2=A0 AXI_DAC_CNTRL_1_SYNC			BIT(0)
> > > > > =C2=A0#define AXI_DAC_CNTRL_2_REG			0x0048
> > > > > +#define=C2=A0=C2=A0 AXI_DAC_CNTRL_2_SDR_DDR_N		BIT(16)
> > > > > +#define=C2=A0=C2=A0 AXI_DAC_CNTRL_2_SYMB_8B		BIT(14)
> > > > > =C2=A0#define=C2=A0=C2=A0 ADI_DAC_CNTRL_2_R1_MODE		BIT(5)
> > > > > +#define=C2=A0=C2=A0 AXI_DAC_CNTRL_2_UNSIGNED_DATA		BIT(4)
> > > > > +#define AXI_DAC_STATUS_1_REG			0x0054
> > > > > +#define AXI_DAC_STATUS_2_REG			0x0058
> > > > > =C2=A0#define AXI_DAC_DRP_STATUS_REG			0x0074
> > > > > =C2=A0#define=C2=A0=C2=A0 AXI_DAC_DRP_STATUS_DRP_LOCKED		BIT(17)
> > > > > +#define AXI_DAC_CUSTOM_RD_REG			0x0080
> > > > > +#define AXI_DAC_CUSTOM_WR_REG			0x0084
> > > > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_WR_DATA_8		GENMASK(23, 16)
> > > > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_WR_DATA_16		GENMASK(23, 8)
> > > > > +#define AXI_DAC_UI_STATUS_REG			0x0088
> > > > > +#define=C2=A0=C2=A0 AXI_DAC_UI_STATUS_IF_BUSY		BIT(4)
> > > > > +#define AXI_DAC_CUSTOM_CTRL_REG			0x008C
> > > > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_ADDRESS		GENMASK(31, 24)
> > > > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_SYNCED_TRANSFER	BIT(2)
> > > > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_STREAM		BIT(1)
> > > > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA	BIT(0)
> > > >=20
> > > > ...
> > > > =C2=A0
> > > > > =C2=A0static int axi_dac_probe(struct platform_device *pdev)
> > > > > =C2=A0{
> > > > > -	const unsigned int *expected_ver;
> > > > > =C2=A0	struct axi_dac_state *st;
> > > > > =C2=A0	void __iomem *base;
> > > > > =C2=A0	unsigned int ver;
> > > > > @@ -566,14 +780,29 @@ static int axi_dac_probe(struct platform_de=
vice
> > > > > *pdev)
> > > > > =C2=A0	if (!st)
> > > > > =C2=A0		return -ENOMEM;
> > > > > =C2=A0
> > > > > -	expected_ver =3D device_get_match_data(&pdev->dev);
> > > > > -	if (!expected_ver)
> > > > > +	st->info =3D device_get_match_data(&pdev->dev);
> > > > > +	if (!st->info)
> > > > > =C2=A0		return -ENODEV;
> > > > > +	clk =3D devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
> > > > > +	if (IS_ERR(clk)) {
> > > >=20
> > > > If clock-names is not given, then we'll get -EINVAL. Hence we could=
 assume
> > > > that:
> > > >=20
> > > > 		if (PTR_ERR(clk) !=3D -EINVAL)
> > > > 			return dev_err_probe();
> > >=20
> > > clock-names isn't a required property, but the driver code effectivel=
y
> > > makes it one. Doesn't this lookup need to be by index, unless
> > > clock-names is made required for this variant?
> >=20
> > Likely I'm missing something but the driver is not making clock-names m=
andatory,
> > is it?
>=20
> Did you miss the "for this variant"? Maybe I left the comment in not

I guess so :)

> exactly the right place, but I don't think the code works correctly for
> the new variant if clock-names aren't provided:
>=20
> +	if (st->info->has_dac_clk) {
> +		struct clk *dac_clk;
> +		dac_clk =3D devm_clk_get_enabled(&pdev->dev, "dac_clk");
> +		if (IS_ERR(dac_clk))
> +			return dev_err_probe(&pdev->dev, PTR_ERR(dac_clk),
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get dac_clk clock\n");
> +
> +		/* We only care about the streaming mode rate */
> +		st->dac_clk_rate =3D clk_get_rate(dac_clk) / 2;
>=20
> Isn't this going to cause a probe failure?

Exactly. And that goes in line with what I wrote about the bindings not des=
cribing
(currently) this. So yes, for the new variant (which has 'has_dac_clk' set =
to true)
clock-names is indeed mandatory and probe will fail if it's not given.

> =20
> > At least for the s_axi_aclk, we first try to get it using clock-names a=
nd if
> > that fails we backup to what we're doing which is passing NULL (which
> > effectively get's the first clock in the array).
> >=20
> > The reasoning is that on the generic variant we only need the AXI clk a=
nd we
> > can't now enforce clock-names on it. But to keep things flexible, this =
was
> > purposed.
>=20
> Why not always just get the first clock by index and avoid the
> complexity?

And that was also suggested in the previous version but then Jonathan sugge=
sted this
[1]. I agree things now are a bit confusing because we expect clock-names t=
o be
optional for the generic but mandatory for this new variant and the code is=
 not being
that explicit about it.

>=20
> > Another alternative that might have more lines of code (but simpler to
> > understand the intent) is to have (for example) a callback get_clocks f=
unction
> > that we set depending on the variant. And this also makes me realize th=
at we
> > could improve the bindings. I mean, for the generic dac variant we do n=
ot need
> > clock-names but for this new variant, clock-names is mandatory and I'm =
fairly
> > sure we can express that in the bindings.
>=20
> Right. You can "edit" required in the if/then/else branch for the new
> variant.

Yeah, and IMO that should be set in the bindings (it would help understandi=
ng what
the driver is actually doinfg.

[1]: https://lore.kernel.org/linux-iio/20241019160817.10c3a2bf@jic23-huawei=
/

- Nuno S=C3=A1


