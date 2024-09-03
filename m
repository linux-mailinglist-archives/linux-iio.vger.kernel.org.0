Return-Path: <linux-iio+bounces-9104-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 442A496AC2D
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 00:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6BECB240BC
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 22:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228D11D5888;
	Tue,  3 Sep 2024 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MEXBPFRg";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="EkqoBtoD"
X-Original-To: linux-iio@vger.kernel.org
Received: from a7-49.smtp-out.eu-west-1.amazonses.com (a7-49.smtp-out.eu-west-1.amazonses.com [54.240.7.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B541EBFE4;
	Tue,  3 Sep 2024 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725402372; cv=none; b=cpAjIhgjNSycgI8VMs3fIX7w5B7eUs4cYwSmEKFpia+7VX0/6iZYjcFoYNCunssLbUhSM+m0zs6nWoTj38PXOYUAUM74yeeJskS7VGX6PPVqdFKquI6A2LjXRhrQW4BkMmJn4zqrynAe7zyZNMKV0Y6Wn8QXXKyJWz7Su3sOkyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725402372; c=relaxed/simple;
	bh=J75C0zW3aFD9/wWABSs9a0MGOHQsWYII8iomrBYquwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cygvHyDJ3UYjOf3vkNW0+5TtH9aSfH73H1EjogbiCbHmtsGHRSdedrbqAzBk75Gs+BVNxXSqxqniEegtYpMtN7USvAkZEg6orBVfXpjiPqZP5m1MoEa8Nsxtx8rn+59BDKMJPD3JC2y0SvdalH1C/HHhsWvtFuItV1U97o7jCpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MEXBPFRg; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=EkqoBtoD; arc=none smtp.client-ip=54.240.7.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1725402367;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
	bh=J75C0zW3aFD9/wWABSs9a0MGOHQsWYII8iomrBYquwQ=;
	b=MEXBPFRgWQzDuhb4aVPME+9Kz2deQ65lINz1o1mGUKLs32qYu18Mrn9xFasjDxaP
	3+RL2g1YU6QKnBGHi5GAVMrN8jcFd+yYBNMB9k39HDTXwNd9wnFrvsgCyY1eoVrDlVz
	gnp21UzehZ/c74v9AXGD6YiwBn/pUnovJfykY0/g2lYbjwoIRQwHoPDqIOPoRmXQKwX
	qB5LQKNmcJtJC7Sl7BnomSp+sKYaiE24GnClGQAJEosT8Y8zpiPMmTNuhUSkixF9LEw
	c1gvnZGViAKu9U9wt2t531g8AaLrfvE5QNUWR9MHH/HCJ3KXWb2yhpy6cWYdz1enPV4
	1MvtoSWdZA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1725402367;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
	bh=J75C0zW3aFD9/wWABSs9a0MGOHQsWYII8iomrBYquwQ=;
	b=EkqoBtoDhy7s0jSAZhVw5zM0N10sN2c5ethkUQsDhM5fhjrGzto4Z3RloidOQO78
	7VFdFxnOfiFVnDIwZrUNbsTLXrGgQsNZjhUzV2WKyQj/R0LDjpzPjHbouW6e7jFQ2fX
	SHYv+atVdMhujose+YekUUYPOfwxdzb9rgUQ53N0=
Date: Tue, 3 Sep 2024 22:26:07 +0000
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-sunxi@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
	quentin.schulz@free-electrons.com, mripard@kernel.org, 
	tgamblin@baylibre.com, aidanmacdonald.0x0@gmail.com, 
	u.kleine-koenig@pengutronix.de, lee@kernel.org, samuel@sholland.org, 
	jernej.skrabec@gmail.com, wens@csie.org, conor+dt@kernel.org, 
	krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de, 
	jic23@kernel.org, jonathan.cameron@huawei.com, 
	Philippe Simons <simons.philippe@gmail.com>
Subject: Re: [PATCH V4 14/15] power: supply: axp20x_battery: add support for
 AXP717
Message-ID: <01020191b9fec51a-2b9bc6b4-37b6-4651-9127-b0ab066262b3-000000@eu-west-1.amazonses.com>
References: <20240821215456.962564-1-macroalpha82@gmail.com>
 <20240821215456.962564-15-macroalpha82@gmail.com>
 <kpcnvalhcfzludd6ifjn4mkeipihkselgr3e4bzog2zfyap4jz@ib7cg2drpd4p>
 <MN2PR16MB2941BBB5A36AE70195F3D1B2A5972@MN2PR16MB2941.namprd16.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f3sncq3laka6j44d"
Content-Disposition: inline
In-Reply-To: <MN2PR16MB2941BBB5A36AE70195F3D1B2A5972@MN2PR16MB2941.namprd16.prod.outlook.com>
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.03-54.240.7.49


--f3sncq3laka6j44d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 29, 2024 at 08:11:09PM GMT, Chris Morgan wrote:
> On Tue, Aug 27, 2024 at 06:24:42PM +0200, Sebastian Reichel wrote:
> > On Wed, Aug 21, 2024 at 04:54:55PM GMT, Chris Morgan wrote:
> > > +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> > > +		ret =3D iio_read_channel_processed(axp20x_batt->batt_v,
> > > +						 &val->intval);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		/* IIO framework gives mV but Power Supply framework gives uV */
> > > +		val->intval *=3D 1000;
> > > +		return 0;
> >=20
> > I see you followed the existing pattern for these two drivers. Can
> > you please add another patch, which converts both drivers to the
> > following pattern:
> >=20
> > return iio_read_channel_processed_scale(adc_chan, &val->intval, 1000);
>=20
> Would it be okay if I sent a patch series on top of this one (rather
> than rebasing now that some of these are starting to get pulled)?
>=20
> It's probably a simple enough change so I don't mind.

Yes, please make this a follow-up patch and update all occurances of
the pattern in axp20x_ac_power.c, axp20x_battery.c and
axp20x_usb_power.c.

Thanks!

> > > +		 * AXP717 can go up to 4.35, 4.4, and 5.0 volts which
> > > +		 * seem too high for lithium batteries, so do not allow.
> >=20
> > 4.35V and 4.4V batteries exists. You can find them when you search
> > for LiHV (Lithium High Voltage).
>=20
> Do you think I should add it then? Full disclosure, I basically opted
> to not add this because while this series was written more or less
> exclusively off of the datasheet I did peek at the BSP implementation
> and I think they restricted these voltages. Again, as a fast-follow
> once these patches finish getting pulled (I can start work on it now
> though).

Feel free to ignore that information. Support can always be added later
once somebody needs to use the chip with a LiHV battery.

-- Sebastian

--f3sncq3laka6j44d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbXjPwACgkQ2O7X88g7
+pqfNQ//b9NVzVqyM1E6kjRdA9UPORt9gmyCNkVelM/Azk9IISpM9rsV+glJ0qcr
l/6Y1b9kYMG4aEf0h52WeXVh7lAutxPTwrW13KqmWuj7Kv5aE2dhUAOWN07RhC4w
P3cA2y1nP9lOrS4NR4Pc1NXU1PxkQW9BPSF/UessK9h2lkWVNw3BQJhGrcblnvZi
k+qDB0k801cuWaraHvVrU5RgpVSl4GS8d9HTIpnoag3BIIgBVGZShMLxSEGNHKis
MWTNRWC1ZTHfyM8hpIECmYEjuOaaOTyY48iuhEHO4h1yQLxGCNhyQYl+CnnM9ntF
sgTAsWAywAulpUb5clG50ewC66SZrGTfud7Nbo943Js4H0cs1L351KlkFVXaZ9m5
iXAjFpPreH+9EFtBRBzg45k6JfJObXbZAKxWwMNhtckmh2Y9qHmBXL6LykYxpWut
iCP7SlUjPAyWLJb/h0BG4fItRZebmb+dTyALl2xdceTDUvv5RicBA+GCyIcIINLb
ak536WLkIgM16VfHA3qL1xI7wlEXBSSJfSL4TBFNMR0UMIaVs6mgLFh/sq3dh66H
t0mNAshlYlYbnp9C9HNY2GdV9h/m8VPWNetiOpf6hKDZItUEoGvx0kLnvCckbsLo
5hePZpjMpBd5iFnNprVA9kp3BryXybT84Wz78Iazq4Qdg2YzOjY=
=c/Zb
-----END PGP SIGNATURE-----

--f3sncq3laka6j44d--

