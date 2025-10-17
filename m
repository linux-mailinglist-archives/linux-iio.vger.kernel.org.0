Return-Path: <linux-iio+bounces-25180-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A44EBE7B32
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 11:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 368A25670F2
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 09:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD7F32ED5E;
	Fri, 17 Oct 2025 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ZCfAQq1z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8FB32ED29
	for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692314; cv=none; b=pIBKMKMqIpLZB1v2xQdKUHvd+Iof4aERko/sxoc1Qplj6Y2BvtH5bTwY1pa8tjjcPnm3I+AtbuAWDNrJgCOwp8BMUFcq1Fu4JKbBQEThXkuWhG18D+ajO+ZZzkiPTY+JTWHK1NsCMJl4I1RB2MjM9tSwbu0cKiUag7PLgSbkngo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692314; c=relaxed/simple;
	bh=0hgg194Q/ekxMWTEcaeVe7kZCiTUQT1i7oIY+ktAtx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8hF6SG7PMfPPwksz3XDB97v+TFtjcbHUEnU8FBBNd06ez4iKl/biqmcth69c5+CG1Q015SDUAnSekW10WLMv6xhVw84NA+ktvbA7qcn7kwuv4RTwP1ub/o5KILvCJFrG1zSQxMRTlRUUX1c8SX59D4xXgYuP5xgVNEhUyHWDNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ZCfAQq1z; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=XU38
	XK8Y5L6BI7SVZs41SwdmXYWo1x2J+raJQ3DofEg=; b=ZCfAQq1zIgwN/KtLQOSM
	yk5JZGhvWc9FLwm5gWFXwH+PPqsLRx6E96vxP+X9FAC7D32Dg+mX8zx8I1olBM4m
	dj5mIKBm9E+cLTywGIFHIRdoI+CKaOwqkCKnolxCsP2e2cLUR6nFnvYgCOVaSPCc
	z+Jhoj/q5PpSF5G2kyeH80MV5NKdfwHTpaQBfPrLSsqyPgl3LIHT+/Sj+rYbr8pI
	6Gz49Ublwpo5/8mxU6AXWrkwxRPil+sAombQWLtSRTbGnYQ7hhICnheP4/+0SyG1
	Oq/BYmD4oVw9Fii1ttNN6Y1Vc5z81G4VYtEAZPiJi5njgN4Ou0m6TE2vAd8tVSqC
	jA==
Received: (qmail 4163213 invoked from network); 17 Oct 2025 11:11:49 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Oct 2025 11:11:49 +0200
X-UD-Smtp-Session: l3s3148p1@p+emH1dBON0gAwDPXwQHAL/S9V79e5yL
Date: Fri, 17 Oct 2025 11:11:49 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/4] iio: adc: Add support for the Renesas RZ/N1 ADC
Message-ID: <aPIIVUlHnvi0BXtN@shikoro>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
 <20251015142816.1274605-3-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/EqJJDSnotcPcZ45"
Content-Disposition: inline
In-Reply-To: <20251015142816.1274605-3-herve.codina@bootlin.com>


--/EqJJDSnotcPcZ45
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +static int rzn1_adc_read_raw_ch(struct rzn1_adc *rzn1_adc, unsigned int chan, int *val)
> +{
> +	u32 *adc1_data, *adc2_data;
> +	int adc1_ch, adc2_ch;
> +	u32 adc_data;
> +	int ret;
> +
> +	if (chan < 8) {
> +		/* chan 0..7 used to get ADC1 ch 0..7 */
> +		adc1_ch = chan;
> +		adc1_data = &adc_data;
> +		adc2_ch = -1;
> +		adc2_data = NULL;
> +	} else if (chan < 16) {
> +		/* chan 8..15 used to get ADC2 ch 0..7 */
> +		adc1_ch = -1;
> +		adc1_data = NULL;
> +		adc2_ch = chan - 8;
> +		adc2_data = &adc_data;
> +	} else {
> +		return -EINVAL;
> +	}

How about putting part of the logic into the setup function? So, here
only:

	if (chan >= 16)
		return -EINVAL

> +
> +	ret = pm_runtime_resume_and_get(rzn1_adc->dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_lock(&rzn1_adc->lock);
> +
> +	rzn1_adc_vc_setup_conversion(rzn1_adc, chan, adc1_ch, adc2_ch);

	rzn1_adc_vc_setup_conversion(rzn1_adc, chan);

And in that function:

> +static void rzn1_adc_vc_setup_conversion(struct rzn1_adc *rzn1_adc, u32 ch,
> +					 int adc1_ch, int adc2_ch)
> +{
> +	u32 vc = 0;
> +
> +	if (adc1_ch != -1)
> +		vc |= RZN1_ADC_VC_ADC1_ENABLE | RZN1_ADC_VC_ADC1_CHANNEL_SEL(adc1_ch);
> +
> +	if (adc2_ch != -1)
> +		vc |= RZN1_ADC_VC_ADC2_ENABLE | RZN1_ADC_VC_ADC2_CHANNEL_SEL(adc2_ch);
> +
> +	writel(vc, rzn1_adc->regs + RZN1_ADC_VC_REG(ch));
> +}

	if (ch < 8)
		vc |= RZN1_ADC_VC_ADC1_ENABLE | RZN1_ADC_VC_ADC1_CHANNEL_SEL(ch);
	else
		vc |= RZN1_ADC_VC_ADC2_ENABLE | RZN1_ADC_VC_ADC2_CHANNEL_SEL(ch - 8);

And a similar simplification for rzn1_adc_vc_wait_conversion().

Should work and the code is even more readable, I'd say. And has less
lines.


--/EqJJDSnotcPcZ45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmjyCFUACgkQFA3kzBSg
Kbb9xA//REppm1IeO+V8SP2avOxXXGrd9frH85ALT8nxSvi6YqgB/MxFXnSC0RcW
z1aA/t8QwAMHDote89j8jlpRaugXvcgNNxMvn4JVheYyU4aNZwu/IcyJ/qhhQkd9
dlXUfhUIM2hvowXEMagYfz85aOtev0rCl9FmWwS81RlQ6K8oKZZTU03m3R3r6sUb
3QhCkyP9UrzZgZxTm8euT+W4jU2ZCglrbEwqHEw+5k9zVc60un5TV+3a1tFzhFM2
FoGPv3Srpew1KmgUahaDcIzUXFczrwjR5S/CZRftI4KKWL1mP70gX/7pFwOZmGIt
RohyF7Aa4c56+ACb7BHi395BYpCofoPq9tN48+7C/SleydJLvNcuhvZR5cp6QMhZ
98Jd7jgRqYqEY7R7JLewFeitt4qJN+55fd5IVgKrTIaKfLXWeBKjw/V2AESIzzJQ
v2wDgcMOa2ssIveyDnb4Q982yNk1pzcVabyTRn4fkEweuauvzwj2L4CPDcne8acl
EFvv/QkxR1uV1Al7IkMqJ2LORT8GGb80XMpn7uZpIY8UwdyZYDTf5Nc6r0SOmNDe
tv8N0XSgQhSUFq0S7eNR1R0n4KpwzD+VkpMrWHGyX3vpiqO51Vnh0oVE3Tf74CaN
jR4mhnjf+BAZW8AVE6CFUxTwCjizamtvFirx/lUlCtOgli95bB4=
=x7ej
-----END PGP SIGNATURE-----

--/EqJJDSnotcPcZ45--

