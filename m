Return-Path: <linux-iio+bounces-19734-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28E4ABD76D
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 13:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1274216E351
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 11:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A85727BF83;
	Tue, 20 May 2025 11:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqcfLobA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F36263F59;
	Tue, 20 May 2025 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742063; cv=none; b=t792ZZgY7hXO59qH31xXOElmchHAV05C+9SlUdBZzIKJv3OFslz9wz1NGEad6/W8uhACdzQVNmXUduBFDKpS+A88xwjUSy9AvuEstocnA9Sn/qS6/RtmOgvGLE6aVa5eDTBR4yvmRO1tOH9hi1zS7OZsp62+0Yn7unWPisAFDQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742063; c=relaxed/simple;
	bh=0LB3gKrRF3SFVit9CC5sVVaVIhIAGpiL+nMDYFs/lN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqXb9W9aGFln5R9Mhx4r4bQnD3Iu5511BpwekySlHBZ8J0xTifeRo9Dw/0ffeQm/qBkjPoQBjrer2Yb6cWGAZyosxptxY91+Zp1rgQpBB8zzLgqwAOpUhgUrmZHptlWniV/jR7TONPffEfpviXhlhc/LFM85Hw6oJm1fmt9ni34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqcfLobA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3ACFC4CEE9;
	Tue, 20 May 2025 11:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747742062;
	bh=0LB3gKrRF3SFVit9CC5sVVaVIhIAGpiL+nMDYFs/lN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PqcfLobAhQV2FBZve5MIeToYTg1PPfb92clxkq7Wb74DVWYgxkqB9QmQmmLJJDapG
	 sJyzIuO9JBHVt63utHY+PbNK5toAhJOfXlTnWEJ3ypvh+PtAXPfCBEAYCefYkpCAUt
	 8CUdvLIrh21EmJ5MErPP8/NfNxs/cCcKQHpdhF5ovtLnTd/j/9z8kzmEkwMB47KTc0
	 th9Izo7Wa8K6YRfsT2alL9ECLXtJwfutgARtGzOtxcJegOL1WT34roEW2Kg1dOyCRm
	 ukWFTV0L7RspaL4L4ftEPvdx+3y4Ew1lgrmC0Z8V9BBOE/8gp+BU1VE5ZXBUZGaa84
	 4rJ/86STpNoxA==
Date: Tue, 20 May 2025 20:54:19 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] counter: microchip-tcb-capture: Add watch validation
 support
Message-ID: <aCxtaya-1SXkPiob@ishi>
References: <F_LcZtjhYzQUlCmEka_20DiefdWFYYoq-u3JOct5ctrcMrJfTi3APjAWNAK97Mpluwkqgr9rQ-35KzO0Uuifow==@protonmail.internalid>
 <20250520-counter-tcb-v2-1-a0617d2d220a@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="35KqwYMATj7rtnUi"
Content-Disposition: inline
In-Reply-To: <20250520-counter-tcb-v2-1-a0617d2d220a@microchip.com>


--35KqwYMATj7rtnUi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 09:36:42AM +0530, Dharma Balasubiramani wrote:
> The Timer Counter Block (TCB) exposes several kinds of events to the
> Counter framework, but not every event is meaningful on every hardware
> channel. Add a `watch_validate()` callback so userspace may register only
> the combinations actually supported:
>=20
> * Channel 0 (COUNTER_MCHP_EVCHN_CV, COUNTER_MCHP_EVCHN_RA)
>    - COUNTER_EVENT_CAPTURE
>    - COUNTER_EVENT_CHANGE_OF_STATE
>    - COUNTER_EVENT_OVERFLOW
>=20
> * Channel 1 (COUNTER_MCHP_EVCHN_RB)
>    - COUNTER_EVENT_CAPTURE
>=20
> * Channel 2 (COUNTER_MCHP_EVCHN_RC)
>    - COUNTER_EVENT_THRESHOLD
>=20
> Any other request is rejected with `-EINVAL`, preventing undefined
> behaviour in userspace.

Hi Dharma

The requesting an invalid watch configuration wouldn't necessarily lead
to undefined beaviour in userspace -- at least as far as the Counter
character device interface is concerned. What would happen is that the
requested event is never pushed to that particular channel, so userspace
is left watching for an event that never arrives for that particular
watch: not an ideal situation, but not undefined.

>=20
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
> Tested the code on target (sam9x60_curiosity) using the following commands
>=20
> valid ones:
> ./counter_watch_events -d -wevt_change_of_state,chan=3D0
> ./counter_watch_events -d -wevt_ovf,chan=3D0
> ./counter_watch_events -d -wevt_capture,chan=3D0
> ./counter_watch_events -d -wevt_capture,chan=3D1
> ./counter_watch_events -d -wevt_threshold,chan=3D2
>=20
> invalid ones:
> ./counter_watch_events -d -wevt_threshold,chan=3D0
> ./counter_watch_events -d -wevt_threshold,chan=3D1
> Error adding watches[0]: Invalid argument
> ---
> Changes in v2:
> - Include COUNTER_MCHP_EVCHN_CV as well for the sake of completeness.
> - Adjust the code to ensure channel limitations.
> - Drop sorting in this patch, will be taken care seperately.
> - Link to v1: https://lore.kernel.org/r/20250515-counter-tcb-v1-1-e547061=
ed80f@microchip.com

Thank you for the changes. I have a minor adjustment suggestion below
that I believe makes the code look a little nicer.

> ---
>  drivers/counter/microchip-tcb-capture.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/mi=
crochip-tcb-capture.c
> index 1de3c50b9804..fe817f4f1edc 100644
> --- a/drivers/counter/microchip-tcb-capture.c
> +++ b/drivers/counter/microchip-tcb-capture.c
> @@ -337,6 +337,27 @@ static struct counter_comp mchp_tc_count_ext[] =3D {
>  	COUNTER_COMP_COMPARE(mchp_tc_count_compare_read, mchp_tc_count_compare_=
write),
>  };
>=20
> +static int mchp_tc_watch_validate(struct counter_device *counter,
> +				  const struct counter_watch *watch)
> +{
> +	if (watch->channel =3D=3D COUNTER_MCHP_EVCHN_CV || watch->channel =3D=
=3D COUNTER_MCHP_EVCHN_RA) {
> +		switch (watch->event) {
> +		case COUNTER_EVENT_CHANGE_OF_STATE:
> +		case COUNTER_EVENT_OVERFLOW:
> +		case COUNTER_EVENT_CAPTURE:
> +			return 0;
> +		default:
> +			return -EINVAL;
> +		}
> +	} else if (watch->channel =3D=3D COUNTER_MCHP_EVCHN_RB) {
> +		return (watch->event =3D=3D COUNTER_EVENT_CAPTURE) ? 0 : -EINVAL;
> +	} else if (watch->channel =3D=3D COUNTER_MCHP_EVCHN_RC) {
> +		return (watch->event =3D=3D COUNTER_EVENT_THRESHOLD) ? 0 : -EINVAL;
> +	} else {
> +		return -EINVAL;
> +	}

You can use the early returns to avoid the else statements, and some
other additional cleanups can be done as well:

    if (watch->channel =3D=3D COUNTER_MCHP_EVCHN_CV || watch->channel =3D=
=3D COUNTER_MCHP_EVCHN_RA)
    	switch (watch->event) {
    	case COUNTER_EVENT_CHANGE_OF_STATE:
    	case COUNTER_EVENT_OVERFLOW:
    	case COUNTER_EVENT_CAPTURE:
    		return 0;
    	default:
    		return -EINVAL;
    	}
   =20
    if (watch->channel =3D=3D COUNTER_MCHP_EVCHN_RB && watch->event =3D=3D =
COUNTER_EVENT_CAPTURE)
    	return 0;
   =20
    if (watch->channel =3D=3D COUNTER_MCHP_EVCHN_RC && watch->event =3D=3D =
COUNTER_EVENT_THRESHOLD)
    	return 0;
   =20
    return -EINVAL;

I think something like that looks a bit closer to the Linux kernel style
present in the other drivers, so that we're all consistent.

William Breathitt Gray

--35KqwYMATj7rtnUi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCaCxtawAKCRC1SFbKvhIj
K7HiAP44UJ7XosMcMhno78Iqokz8eFSyozTDzQrtDg4VKOEBrgEAxV0xujh56HbW
6qwUGvsDhrhwAhNzaC9eiCW4MtlD3QA=
=mwXK
-----END PGP SIGNATURE-----

--35KqwYMATj7rtnUi--

