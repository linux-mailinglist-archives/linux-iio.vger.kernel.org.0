Return-Path: <linux-iio+bounces-3243-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3044E86D2B7
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 19:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3C5283212
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 18:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490C7134430;
	Thu, 29 Feb 2024 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="goCQmnLZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5719813441F
	for <linux-iio@vger.kernel.org>; Thu, 29 Feb 2024 18:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709233098; cv=none; b=o5diO07o9D9ED45CNlhfXzI4cHuUjWMVlxP2HUGDJCmDt3t4jSdgo36AO9fMf23t+K1ZbDb2iR1B8mHgrncITmnqscjVIZUcIFFMmTQIc/5EkCa/xfwxrGRs4q6SHEYYvyLZSmyzrCDdnF2L8uXVCwGEpHw1hT7508WsfIQUrv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709233098; c=relaxed/simple;
	bh=qS96ijGQ0VA9eqcSA1aKuuwW+o+9E9lQmPLX2nzFYgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rq5nDMQ4FQflEfGw9VDEKSqM5RSbjUxone9rJC45PPlNZZJePBZqh+VqzCLdHNJKiewGoWlRiCChG93FcrnXMHo+sk3VG0PzT7WyV7gzc1XMY1oGsM+ofa94wckZJdTOQ+7TS0GKtJJmnXvSYhmtN9+zI5p0wulbDGpo/ptL+Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=goCQmnLZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412bf3d52d7so6265395e9.2
        for <linux-iio@vger.kernel.org>; Thu, 29 Feb 2024 10:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709233094; x=1709837894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QOMkV8+zwYA3EDl4Oj8veMVbhFWWtMnCBkuFp1N+OIc=;
        b=goCQmnLZC19UjZUzaztMnc8jAHvVxejo6gaBAgbQyHaOCNU7OwRBUyKDMGECpjq8Uq
         FbEI916TxXfRHu+zu65EfcNctTFzOEvLe4D1QXNtfoaFD7irqkvGQQrkVCTY5iwDT52C
         vKhjmhzVMnMfqoOSmcO6YUqmHqpZJdV8CZc9B4u8d9UxmordwLQFU52ZZBSAC8mcREfD
         RsUWA+/ACI3PBDqXUJ3PIAjWnn/vvzIeZOTj6r3viPkhbqfCBdpKzCNHyG2DEs4+30t3
         xOkjR/rOLlwChYdbwn8ijwR2VaEn6oD9GXslLMN6etGqPWtB5udvdd12z2dHpcq2+ZKW
         jqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709233094; x=1709837894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOMkV8+zwYA3EDl4Oj8veMVbhFWWtMnCBkuFp1N+OIc=;
        b=lLIb29Q+LTd/aAOuwXyoRD5f9o4fL7a+8Wkn5AmZx9ltfNY4CTFM5Q9A3VV39SABcF
         6QYCij36eyfj9r6o5Bm72KSa3IVbTjqwUC3LvrABMkaN7iFk7PpGcKcy8ySDFH5hjHdY
         REwd/f3NhUGZfEGriZRFWyNga38jisH2zS4u4Q2a2NoEMCR66jQiRy+AXp/TCVZhlfLG
         RudxXMhDTCqAYDTku0HLLMYdZK9LIEraOEz15kWMnyU/MS9GHK2ouZszJkYI1nHIoJBw
         aL5n1cEU18kaMJcoSH74op2F5i78D3umTFS+1O/OzL5rytpMJp1F4XDumrl8/uuNXJuZ
         kOOw==
X-Forwarded-Encrypted: i=1; AJvYcCWBqVRiFeUjPMzES5Z+5xEhmb4m7ZIuIeiY9nX3BdlIX38rDNGM66JviTueVXPEQRSpFyAv1VE7KXcNJ/7fPyx4m1B+iRnf5Lc8
X-Gm-Message-State: AOJu0YxxQuzcHZlkqU10hExE7DJ+RQt42hMzjy2V7+lN/P3mLe2aJgd2
	hOmEHfsBkJ+iN9ExZiPr9Co3j4g6j+zWGoN+zb+LdmVM9HZq4sb2riZqP1qnxaI=
X-Google-Smtp-Source: AGHT+IE6N6/fBwdedrFzOy5DgpuEwQoJ27wC7Wfz2Gw6PuOexlU0y1KaywrIq7wNyzeVlhR8897a1g==
X-Received: by 2002:a05:600c:1d24:b0:412:b74a:452a with SMTP id l36-20020a05600c1d2400b00412b74a452amr2732349wms.29.1709233094459;
        Thu, 29 Feb 2024 10:58:14 -0800 (PST)
Received: from ishi ([185.243.57.250])
        by smtp.gmail.com with ESMTPSA id fc18-20020a05600c525200b00412aeb77bbcsm2863560wmb.19.2024.02.29.10.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:58:14 -0800 (PST)
Date: Thu, 29 Feb 2024 13:58:08 -0500
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, alexandre.torgue@foss.st.com, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Julien Panis <jpanis@baylibre.com>,
	Syed Nayyar Waris <syednwaris@gmail.com>
Subject: Re: [PATCH v3 04/10] counter: stm32-timer-cnt: introduce clock signal
Message-ID: <ZeDTwKMP7MX0Nlx5@ishi>
References: <20231220145726.640627-1-fabrice.gasnier@foss.st.com>
 <20231220145726.640627-5-fabrice.gasnier@foss.st.com>
 <ZZwm7ZyrL7vFn0Xd@ubuntu-server-vm-macos>
 <599a7357-b4d6-4581-9d5c-c1d0ade3e410@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="el6dlSHLw0+sJrWy"
Content-Disposition: inline
In-Reply-To: <599a7357-b4d6-4581-9d5c-c1d0ade3e410@foss.st.com>


--el6dlSHLw0+sJrWy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 06:43:20PM +0100, Fabrice Gasnier wrote:
> On 1/8/24 17:46, William Breathitt Gray wrote:
> > On Wed, Dec 20, 2023 at 03:57:20PM +0100, Fabrice Gasnier wrote:
> >> Introduce the internal clock signal, used to count when in simple risi=
ng
> >> function. Also add the "frequency" extension to the clock signal.
> >>
> >> With this patch, signal action reports a consistent state when "increa=
se"
> >> function is used, and the counting frequency:
> >>     $ echo increase > function
> >>     $ grep -H "" signal*_action
> >>     signal0_action:none
> >>     signal1_action:none
> >>     signal2_action:rising edge
> >>     $ echo 1 > enable
> >>     $ cat count
> >>     25425
> >>     $ cat count
> >>     44439
> >>     $ cat ../signal2/frequency
> >>     208877930
> >>
> >> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> >=20
> > Reviewed-by: William Breathitt Gray <william.gray@linaro.org>
> >=20
> > The code is all right, but some minor suggestions below.
> >=20
> >> +static struct counter_comp stm32_count_clock_ext[] =3D {
> >> +	COUNTER_COMP_SIGNAL_U64("frequency", stm32_count_clk_get_freq, NULL),
> >=20
> > It might be worth introducing a new COUNTER_COMP_FREQUENCY() macro now
> > that we have a second driver with the 'frequency' extension
> > (ti-ecap-capture also has 'frequency'). But it's up to you if you want
> > to add a precursor patch to this series, or I'll introduce it separately
> > myself in a independent patch.
>=20
> Thanks for suggesting.
>=20
> I added a precursor patch to this series.
> I guess you wishes to see it used in both ti-ecap-capture and
> stm32-timer-cnt. I only cared about stm32-timer-cnt in this series.
>=20
> Can I let you do ti-ecap-capture change if/when you're going to apply it?

Thanks Fabrice, I'll pick up the precursor patch so we an start using it
in other drivers. Syed will take on the ti-ecap-capture change, and I've
CC'd Vignesh and Julien to this email as well so they are aware of the
incoming patch.

William Breathitt Gray

--el6dlSHLw0+sJrWy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZeDTwAAKCRC1SFbKvhIj
K3yKAP9au8psfZPV7oz/mKiqINUHWTZ0uA0altrVA9qTHRrJWQEA6q36cJEVxyKY
FxE179tE7UvScdEB6mKG/o/bFy2hVQk=
=nCx4
-----END PGP SIGNATURE-----

--el6dlSHLw0+sJrWy--

