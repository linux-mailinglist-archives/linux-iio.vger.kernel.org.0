Return-Path: <linux-iio+bounces-16314-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1860AA4D436
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 08:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4549F16E80F
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 07:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1221F1F4722;
	Tue,  4 Mar 2025 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIIKFhwK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C176618CBF2;
	Tue,  4 Mar 2025 07:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741071724; cv=none; b=h1fm0l4rzxicWGXGSTRsuAlWoOfSKuHYYS77+GkCRbSVg4GnckP7cusxdX3+6MUoJiFjWmka6sILojHAkbnVFoexIMqjV6IfDlM92RCtwsWP+4MWHNcjgOO4i2jqn+UQvLW6NBMUGiQ62ujG7pixMeH+Bf4igSa7QcuSByxSEkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741071724; c=relaxed/simple;
	bh=ZQ5PhUftJ57V/Y5zzJkozL4WSOs8vgmNZIByf0cbzq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLi0LPMdWTfLuWnm0vOrN4+6XEpf4nGJhfzlrg5t6/U+siVtMMmJjCzRcppMTBNLzW4VmuZUSGLKBnXh8wC7JQzefLq98XtkBceZBxvWGirR4tHENbUqtWYKXXJx7UeJZzpvu4Wg2s8oTLFCoQOcsTXA0Ye9W26AuUfMJTaWg1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIIKFhwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C59CC4CEE9;
	Tue,  4 Mar 2025 07:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741071724;
	bh=ZQ5PhUftJ57V/Y5zzJkozL4WSOs8vgmNZIByf0cbzq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XIIKFhwKMX5MxV7LyUyuou3YED/sF9lUwEzbeR5T4NZAe6J8YFIEYE+TG55QLq7Af
	 VoxWFYm/TplcbQwg1nQ8SWKS6b+ebpJks+yziXdxoKrQ2xmY+Kro2p9ojLsjIxEdiN
	 E6iqEMq6jA2wL41fwv9kFfY5e8wtkK0JmN57j/bJfMWun48tODnvQtWZv4sl50sP9Y
	 WQfgmKoyULF1N7nfhR0ZUTVyxLgHG8HamoXDerWkyz0yNXBB189TA9JjFC/wq7pJ6n
	 PsjAjCpSK5fiD8cJiDNYnmzu0STcRcBFO92zc5emznyiNiQdBKKWNcb7oFTdLCneSw
	 h5KpP00mUgQlw==
Date: Tue, 4 Mar 2025 16:02:00 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH v6 2/3] counter: microchip-tcb-capture: Add IRQ handling
Message-ID: <Z8alaOTjZeRuXnUI@ishi>
References: <20250227144023.64530-1-csokas.bence@prolan.hu>
 <20250227144023.64530-3-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BpBnxHRSyKeOs9ok"
Content-Disposition: inline
In-Reply-To: <20250227144023.64530-3-csokas.bence@prolan.hu>


--BpBnxHRSyKeOs9ok
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 03:40:19PM +0100, Bence Cs=F3k=E1s wrote:
> Add interrupt servicing to allow userspace to wait for the following even=
ts:

Hi Bence,

This is a nitpick but keep the commit description with a maximum of 75
characters per line so we don't have formatting issues with how they
wrap.

> @@ -378,6 +444,15 @@ static int mchp_tc_probe(struct platform_device *pde=
v)
>  	counter->num_signals =3D ARRAY_SIZE(mchp_tc_count_signals);
>  	counter->signals =3D mchp_tc_count_signals;
> =20
> +	priv->irq =3D of_irq_get(np->parent, 0);
> +	if (priv->irq =3D=3D -EPROBE_DEFER)
> +		return -EPROBE_DEFER;

In theory, the error code could be something else if of_irq_get() failed
for any other reason. Handle all those error cases at once by checking
IS_ERR(priv->irq) rather than just -EPROBE_DEFER. Then you can just
return dev_err_probe() with priv->irq for the error code.

> diff --git a/include/uapi/linux/counter/microchip-tcb-capture.h b/include=
/uapi/linux/counter/microchip-tcb-capture.h
> index 7bda5fdef19b..ee72f1463594 100644
> --- a/include/uapi/linux/counter/microchip-tcb-capture.h
> +++ b/include/uapi/linux/counter/microchip-tcb-capture.h
> @@ -12,6 +12,17 @@
>   * Count 0
>   * \__  Synapse 0 -- Signal 0 (Channel A, i.e. TIOA)
>   * \__  Synapse 1 -- Signal 1 (Channel B, i.e. TIOB)
> + *
> + * It also supports the following events:
> + *
> + * Channel 0:
> + * - CV register changed
> + * - CV overflowed
> + * - RA captured
> + * Channel 1:
> + * - RB captured
> + * Channel 2:
> + * - RC compare triggered
>   */
> =20
>  enum counter_mchp_signals {
> @@ -19,4 +30,11 @@ enum counter_mchp_signals {
>  	COUNTER_MCHP_SIG_TIOB,
>  };
> =20
> +enum counter_mchp_event_channels {
> +	COUNTER_MCHP_EVCHN_CV =3D 0,
> +	COUNTER_MCHP_EVCHN_RA =3D 0,
> +	COUNTER_MCHP_EVCHN_RB,
> +	COUNTER_MCHP_EVCHN_RC,
> +};

These would be better as preprocessor defines in case we need to
introduce new events to channel 1 or 2 in the future. That would allow
us to insert new events easily to existing channels without having to
worry about its actual position in an enum list.

One additional benefit is if we do end up introducing more Counts for
the module. In that situation we would have multiple CV and RA/RB/RC per
Counter device, but we can easily define a preprocessor macro to
calculate the channel offset given the Count index. However, with enum
structure we would have to manually add and maintain redundant defines
for each Count, which is far less ideal.

William Breathitt Gray

--BpBnxHRSyKeOs9ok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZ8alaAAKCRC1SFbKvhIj
KwgVAQC3uPc49wX760fObL8equIESUZ04H8MdACkUI4Mi1fhsAD9EpFDTNaLDOaL
s4w9rvq5ikY9mEWoKsn3ojlscOGeHQ0=
=nSNc
-----END PGP SIGNATURE-----

--BpBnxHRSyKeOs9ok--

