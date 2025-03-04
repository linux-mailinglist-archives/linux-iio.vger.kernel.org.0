Return-Path: <linux-iio+bounces-16325-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D43CA4D93C
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 10:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07461673C7
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 09:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E2D1FCF6D;
	Tue,  4 Mar 2025 09:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnukOhcE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F06A1DFD8B;
	Tue,  4 Mar 2025 09:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081883; cv=none; b=CF8yWl0liAbKMFgqdA2s236jC1XgD0IAoSou82B7T02w2jwxHdBq+wmccs00fCZA3GNYrMNCgTIeTimtKmPgFTsjeYOO21Zrjyllm3jbR19anPGV7i6YSIeoT4Hi6mD/eDz2Bp1PPs/OMk+vTjODF0dhRFl38uIortCgktRA+Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081883; c=relaxed/simple;
	bh=3AC8YGVOMopiGMhE+q/wk3R/hqs4Zk918q6dZqSrKY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axXltGoguC8yYOiSsi7N874vtZrgJsRYXRwGAV+gHPwHfOlUKox8tBPlT+umJ4jxZq03qaO/kC0VNYxZVblRBmP8Rqw5mKCfPfgq2/qyFEOjOrjQVphYi3WXxn5vNjcNa5AoYXk2CM5uZHDHyQsjx4fCl5abh+C69oAjua77W+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnukOhcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A97C4CEE5;
	Tue,  4 Mar 2025 09:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741081882;
	bh=3AC8YGVOMopiGMhE+q/wk3R/hqs4Zk918q6dZqSrKY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TnukOhcELWDMHSi92I6AH2aVZA9crN168Hg83AUocvBIll0kQbw0l+fEnwj72lKJJ
	 b3l7qDO1A6XN/OiOYGlOzZkiN2L8wkfPQtFMYX7FP0ETLgIufnIpxVK12lRO60Vwbn
	 FOzW6bfq2OZ1q2lJp6qfDYvFRXw+uvRaFgOyophzj0eDVgP9G5AnvacAy8UsuVHExt
	 YNdPupAKT8/17iBibqkWQVI4pWS79b9nO0nT0WeEA0TTAQa0sx00gKJ8e6J+G+PRpW
	 sMsmCa7u4QWQ0Jo7HkcwyBjFYAzfI/zE5INB4pXxqNix5LhPtr98+WULFek4Pu9yPF
	 sXmvtFguS0miw==
Date: Tue, 4 Mar 2025 18:51:18 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH v6 1/3] include: uapi: counter: Add
 microchip-tcb-capture.h
Message-ID: <Z8bNFjh85p2jqK9C@ishi>
References: <20250227144023.64530-1-csokas.bence@prolan.hu>
 <20250227144023.64530-2-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8INrE+XEHmoL1yAg"
Content-Disposition: inline
In-Reply-To: <20250227144023.64530-2-csokas.bence@prolan.hu>


--8INrE+XEHmoL1yAg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 03:40:18PM +0100, Bence Cs=F3k=E1s wrote:
> Add UAPI header for the microchip-tcb-capture.c driver.
> This header will hold the various event channels, component numbers etc.
> used by this driver.
>=20
> Signed-off-by: Bence Cs=F3k=E1s <csokas.bence@prolan.hu>

Oops, I almost missed this one! Make sure I'm included in the To field
for the next revision. ;-)

By the way, b4 is a nifty tool that can save you some work and help you
prep patch series for submission.[^1]

> +/*
> + * The driver defines the following components:
> + *
> + * Count 0
> + * \__  Synapse 0 -- Signal 0 (Channel A, i.e. TIOA)
> + * \__  Synapse 1 -- Signal 1 (Channel B, i.e. TIOB)
> + */
> +
> +enum counter_mchp_signals {
> +	COUNTER_MCHP_SIG_TIOA,
> +	COUNTER_MCHP_SIG_TIOB,
> +};

Are these meant to be used to identify the Signals in the
microchip-tcb-capture.c file. You should set the the counter_signal id
members to these enum constants then. However, this enum doesn't need to
be exposed to userspace in that case.

Or is the purpose of this to match the parent ID of the Signal when
you create Counter watches? That won't work safely the way you intend
because the Counter subsystem creates the userspace parent IDs
independent of the kernelspace counter_signal struct id member.

Right now the Counter subsystem just happens to create these parent IDs
sequentially from 0 because it was a simple way to implement it at the
time we introduced the feature. However, there is nothing that ensures
this will stay that way in the future, and in fact the design intention
was exactly to allow the possibility of a future change to this area of
code.

In other words, there's no gurantee the parent ID in userspace will
remain the same even between driver reloads. The intended way for
userspace to behave is to first identify the desired Signals at startup
based on their "name" sysfs attribute and then set Counter watches and
such accordingly thereafter as desired.

If that is the only purpose of enum counter_mchp_signals, then we can
omit this patch from the series and you won't need to send it in the
next revision.

William Breathitt Gray

[^1] https://b4.docs.kernel.org/en/latest/

--8INrE+XEHmoL1yAg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZ8bNFgAKCRC1SFbKvhIj
K8vtAQDQtKdqNviMCtM14inLMV9gO9XK9+zhMyb3MGIEkiBZ6AEAmowtr8SAqf6v
JEe9IFPC1iVoe0A355hZA2t2H7E3LwE=
=Wees
-----END PGP SIGNATURE-----

--8INrE+XEHmoL1yAg--

