Return-Path: <linux-iio+bounces-8831-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A15E9613FD
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2024 18:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3642C285245
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2024 16:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DBB1D174A;
	Tue, 27 Aug 2024 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="WjHlG5St"
X-Original-To: linux-iio@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4432A1CEAA2;
	Tue, 27 Aug 2024 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775935; cv=pass; b=QadJOE6kW3soYK2IovwFqBSiqny+AXyKvNqQPUxiLNqypQOseSCnXYfTv9EbkQz2mdr5h9gfbpSBwr16N9p77/4w+Zwlqf5128J9MfDlXstyr9zO0J1DolOxbu+cA3gDL8H7eZQlOXn/PLTURWwVtiVhIv20KmWrdEbi/8kjb3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775935; c=relaxed/simple;
	bh=L9/vXr6cbZax1DImJmmfs6FjZtQsHY3bRq1L5J6vlJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RitN4bLNoo0A0WCZ+1udM4b4ngEDPNWFlVtbyw5ieSugiyCmD8dyMROnwxbAOiBJD6jl+4MBOKShZQYEF5oh2xRNyNqTAJa/tEX35S0O3ceg3QiLAYswMWdYXAd/Yggmn0uI5jFjR21ANKLU8/gDoaB55PQzfVMrc+t83BOwYy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=WjHlG5St; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724775890; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MSKUbFsrVDDPOZscRNtfhYFaMDrSSxbq/DIbWJ7SWsXSILhUR4SWLyJ3R0LxrO0vXYQvyPgRx59wjK4Naknr3ZkwMW51sgxhpkWdVXtljRuuikhxxm12iq4Bko7hklUId5/xOZrEU7H41rZSoe8rZH7eihDOgE/Qb1Zx9oDipiw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724775890; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7xNeOrqXH8lGwbdUxuthbOlYViSQpDsND0/7JODQeiY=; 
	b=Eb5xUdpHTvqO8bCnH11kwJxY+MfLYEBMj/ANZ6FsZ2vjI9dV1IY3bohFra/RlXonzxmbtMD/zAwuvQN9ouydIeR+t2QBsTwWSSUCz2vI7cbEIJ6g0jpg15/CUL8p9jiUGzOTzoQFV8lVvc0SxAw4kA4wab9pRskSJyldet0hcy4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724775890;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=7xNeOrqXH8lGwbdUxuthbOlYViSQpDsND0/7JODQeiY=;
	b=WjHlG5StJmuecqVqPJh/DzVDatDu7wNk2DI05uXE8k65YaNM5Hh3kK8TFl+GNiB6
	ok87fDULgeQI5BWOKfaq24YUoXqmeJvFESDA7gF1t10lvDVdPB9kKSg0V8fGi0BF1YB
	3QZzQsFicnwWyOElCHPTO1IE9FBxiehxifICKCew=
Received: by mx.zohomail.com with SMTPS id 1724775888785598.5497949475847;
	Tue, 27 Aug 2024 09:24:48 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id C15D710604BD; Tue, 27 Aug 2024 18:24:42 +0200 (CEST)
Date: Tue, 27 Aug 2024 18:24:42 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
	quentin.schulz@free-electrons.com, mripard@kernel.org, tgamblin@baylibre.com, 
	aidanmacdonald.0x0@gmail.com, u.kleine-koenig@pengutronix.de, lee@kernel.org, 
	samuel@sholland.org, jernej.skrabec@gmail.com, wens@csie.org, conor+dt@kernel.org, 
	krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de, jic23@kernel.org, 
	jonathan.cameron@huawei.com, Chris Morgan <macromorgan@hotmail.com>, 
	Philippe Simons <simons.philippe@gmail.com>
Subject: Re: [PATCH V4 14/15] power: supply: axp20x_battery: add support for
 AXP717
Message-ID: <kpcnvalhcfzludd6ifjn4mkeipihkselgr3e4bzog2zfyap4jz@ib7cg2drpd4p>
References: <20240821215456.962564-1-macroalpha82@gmail.com>
 <20240821215456.962564-15-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rumth67p7agnd4xq"
Content-Disposition: inline
In-Reply-To: <20240821215456.962564-15-macroalpha82@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/224.300.3
X-ZohoMailClient: External


--rumth67p7agnd4xq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Aug 21, 2024 at 04:54:55PM GMT, Chris Morgan wrote:
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		ret = iio_read_channel_processed(axp20x_batt->batt_v,
> +						 &val->intval);
> +		if (ret)
> +			return ret;
> +
> +		/* IIO framework gives mV but Power Supply framework gives uV */
> +		val->intval *= 1000;
> +		return 0;

I see you followed the existing pattern for these two drivers. Can
you please add another patch, which converts both drivers to the
following pattern:

return iio_read_channel_processed_scale(adc_chan, &val->intval, 1000);

[...]

> +static int axp717_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_batt,
> +					  int val)
> +{
> +	switch (val) {
> +	case 4000000:
> +		val = AXP717_CHRG_CV_4_0V;
> +		break;
> +
> +	case 4100000:
> +		val = AXP717_CHRG_CV_4_1V;
> +		break;
> +
> +	case 4200000:
> +		val = AXP717_CHRG_CV_4_2V;
> +		break;
> +
> +	default:
> +		/*
> +		 * AXP717 can go up to 4.35, 4.4, and 5.0 volts which
> +		 * seem too high for lithium batteries, so do not allow.
> +		 */
> +		return -EINVAL;

4.35V and 4.4V batteries exists. You can find them when you search
for LiHV (Lithium High Voltage).

[...]

Otherwise LGTM,

-- Sebastian

--rumth67p7agnd4xq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbN/cMACgkQ2O7X88g7
+prguA//f9D896gM6SvqiOfkyD1b1S0E0pfZ3qnrud7tJVtIhxO0rjwA+nSM0596
Joe2DM36xbq+PxbQ1tNbUudPCRxNza+2qiq44iqnt6rAW99arNKA13OPqQMko8VZ
UbpmKS5mx9M8ZEACLzfXrClVR1g9kXb1wzLc6UCrlblDetSPRWeTN1BuOnvr88GU
jgwvhBLTfVXXKToUOL/G6bLM15L2KR/Evp5HN40l42yms/sgRzxDyq8/KfGpIseE
vzdNPel1EYJ7iUdkcDCi2eD9QoLGx7pqUipotCayLS1Jhg1M0+55UnLXI2Esm4lP
vKYlN4WD8AJwx7uEfeeRNPIsaxrVFUnZJ7YTSw1X+BitNVbBXWmMwpmife8o0/jT
Sa4KM374RaG0biAtruKfM4I/yHO3HdhiNEjqSj6mtXQjYZDl3H33SfdHqs/9IUSR
lI3nY1JRgsfvaN4sPngXfUg5NVlyFnqWy3fp2sdPdCZyL4wjUTWF7wMPFTUxaZgv
HdpL4j5txTDFyuVyqFjLOyFrHFLN11QX9jRIMYIXxdwCbBTS9p025w4hGwq2C+T+
31C1dFqy/3a5O6LzY5kjfLPpk6ngu8M1JqWyOtkA45aO5TTtwGFXpn4Lfc/M6wsD
iEUky6v1DLpItqgZF9rMuVsh0obZ47HK+1ezxRMAO+Qnu4TSraw=
=B61j
-----END PGP SIGNATURE-----

--rumth67p7agnd4xq--

