Return-Path: <linux-iio+bounces-12381-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2789D17BE
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 19:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CEC81F22431
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 18:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075AD1DE4E7;
	Mon, 18 Nov 2024 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YmeX9sal"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C7419DF4A
	for <linux-iio@vger.kernel.org>; Mon, 18 Nov 2024 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731953547; cv=none; b=t1CYiVGCnPGs9gXeWCoBZjXXP6jTpwxlBUai2VsbrOMydFgAYaeNYtR1mUelzTU5+RFl1w1kz/MdYSuTpOO06KtjwejJ26jc54ig9AOzvwGqFMSTaMpLqBHJYMwjvYA/nOmmiuihNt6djKFZSEsoT4968RqFgENHqhcs9dGunIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731953547; c=relaxed/simple;
	bh=cNCrkBVi8e0UePks8S5Wp4+DycAXRjjMvOZfOWc7xQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOjsI5cdgPrNrqXFi/JfZs0zhWi+yEAlGar8lasj0KhUtOrrCc8op3ri3C8gXVgKB9TAUsS6D9og1H6JdDHwr63ObZn8iUJzFbOnYXQevuHG0rJqGWLEN++pMTQU8Mv2/KHoOPvuHL1gE6BKRXph/FAW93I1Btw/KGFNg/G0Eko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YmeX9sal; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431695fa98bso37012105e9.3
        for <linux-iio@vger.kernel.org>; Mon, 18 Nov 2024 10:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731953544; x=1732558344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hn7sGWlm1TD313KUHIfazPRQ1br1Z1XolPg22hoNMeQ=;
        b=YmeX9saltr+2V0iPXEMU0dht4Xttw+syfIwGf4EOaeZVOLNO/rmGKLko6Qcito8YOR
         EKqxw05vXP2wKQLfAm7wDuDvaZQZB2eZaWGLj8wfFqKzliKLlIS/Yg48UkxMIiluWAra
         GWEqWW+r5buLNeMtXnWofbTJHGLeyzRTXOjf4O+BYNn9YZHzfqtdZ+v5ArUHG5Ya3Ukn
         cNie4sOgN6rstbheJpQPpxbtn5DuS1OFa3tCYB87k1yhouAzXC5BZ5qNaK4B3XY7y0Px
         DPpRPEpFQN16EvTePDasXkcCIaAcotygSwySpbpjalbMYoIg2hDDZ4U59H1aqQD4GDbj
         mbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731953544; x=1732558344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hn7sGWlm1TD313KUHIfazPRQ1br1Z1XolPg22hoNMeQ=;
        b=QMXzTn63figBfSdjQcjEA2Epxf2dkJCLqh1os0YgYmcryR0JPQOBaYrZxsPzWKx1k6
         i5dAq5EiFvUIFQz9lkI7wCW9QNOSljbhOWgQ4V1xSedObiMQJvpksxKdim1A/Ls2c33q
         EE80IUD5q/435REFv8YaN5c7tuuwb68YExtPehlcwLC4M1f9htT+LoZS/VblsGun4CDx
         VuCpUfmvGk7yXhwAtL+EZSAxjPBk5h3VuxHI1BLwjqAniTDAAMDTlyHfgkn5b5urW48s
         HkLTXqsmribVQ8D4bSyc0P0EHISGjDOPwrE+hYL9dCVL5xhewBA+Tdb0Yx91bxrAO0uJ
         fXjg==
X-Forwarded-Encrypted: i=1; AJvYcCXFWxFdPQMOKEy6UUUqr22uLuAnErI4may3YYdyGym/gzOv98EuZEXCS2yQPg2na6zgHt55NqKqU2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLLNss1TODENMVCnx5WF4o6w7vGYXQJpKa5VhKvDzaII5Sc6QB
	gJppdkxMJcqr89H5e4/Zx1gRwQtRGHH9zWE9eYrwl5PHz7VkM/AOnysvAGTIUHM=
X-Google-Smtp-Source: AGHT+IEgkngPuCGI2vmA5ibHm9YJm7IBhf6FJhITuT6WGdtQOE+cLuVvhdr3O6FhZ08gVWjFpM+NPQ==
X-Received: by 2002:a05:600c:4e12:b0:431:5d4f:73b9 with SMTP id 5b1f17b1804b1-432df77c7ccmr102866625e9.26.1731953543734;
        Mon, 18 Nov 2024 10:12:23 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d4788d14sm144661275e9.0.2024.11.18.10.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 10:12:23 -0800 (PST)
Date: Mon, 18 Nov 2024 19:12:22 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Dumitru Ceclan <dumitru.ceclan@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 0/4] iio: adc: ad7124: Make it work on de10-nano
Message-ID: <fsx4mtvhqfoszazxflokargabseia2vs44necuuvinyhw5ggjf@c73ibquopv42>
References: <20241028160748.489596-6-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w6gu74c4kyyeoian"
Content-Disposition: inline
In-Reply-To: <20241028160748.489596-6-u.kleine-koenig@baylibre.com>


--w6gu74c4kyyeoian
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/4] iio: adc: ad7124: Make it work on de10-nano
MIME-Version: 1.0

Hello,

On Mon, Oct 28, 2024 at 05:07:49PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> this is iteration v2 to make ad7124 work on de10-nano. (Implicit) v1 is
> available at
> https://lore.kernel.org/linux-iio/20241024171703.201436-5-u.kleine-koenig=
@baylibre.com.
>=20
> The changes since v1:
>=20
> - Write 0 instead of 0x0001 to disable channels. While 0x0001 is the
>   reset default value for these registers (apart from the channel 0 one)
>   there is no sensible reason to use that value (i.e.
>   AD7124_CHANNEL_AINP(0) | AD7124_CHANNEL_AINM(1)) as the value is
>   reprogrammed before use anyhow. This addresses the feedback that the
>   magic value 0x0001 should better be constructed using register bit
>   field defintions.
>=20
> - Add maxItems: 1 to the new property defined in the binding patch (Krzys=
ztof)
>=20
> - Rename property to rdy-gpios (Rob)
>=20
> - Use rdy-gpios only for gpio reading and continue using the usual irq
>   defintion for the interrupt (Jonathan). I was surprised I can use both =
the
>   GPIO as input and the matching irq.
>=20
> - patch #1 is new, and use GPIO_ACTIVE_LOW in the gpio descriptor
>   instead of 2.
>=20
> Jonathan voiced concerns about the reliability of this solution and
> proposed to implement polling. I'm convinced the solution implemented
> here is robust, so I see no need to implement polling today.
>=20
> Still open questions:
>=20
>  - Is rdy-gpios the right name. The line is named =CC=85R=CC=85D=CC=85Y, =
so maybe nrdy-gpios? Or
>    nRDY-gpios?

David said that rdy-gpios looks right in combination with the
GPIO_ACTIVE_LOW flag. Makes sense to me to negate only in a single
location.

>  - Jonathan wanted some input from ADI about this series and the
>    hardware details.

I think the hardware is understood now reasonably well and from the
discussion with tglx it's also clear that the issue is expected and
fixed at the right place. Although probably not all hardware
configurations can benefit from the modification, I still consider this
a beneficial modification because it allows at least some (most?)
machines to use the irq instead of polling.

There is a patch series on the list for ad7124
(https://lore.kernel.org/linux-iio/cover.1731404695.git.u.kleine-koenig@bay=
libre.com/)
that for now didn't get feedback, and I found another race condition in
the sigma_delta driver helper and now wonder how to proceed here. If we
agree in general that the rdy-gpios patches are ok to be applied, I'd
base the fix for the latest race condition on top of these. Should I
better collect all in-flight patches in a single series, or just post
the new patches (with a proper --base=3D parameter to format-patch)?

Best regards
Uwe

--w6gu74c4kyyeoian
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmc7g4MACgkQj4D7WH0S
/k74qQgAsZWq3bH7ygYjtAantwuNszIqE+0srMrnHpbiev+IqDEsBDPKRLj+qNSS
JXfJzOwR2O8IMEPmwlvu5WXF7fDnm4ili7e+WO0vOpjNZPjsxDDvYXeRIidMilqK
uKt82b4bFN4y9vASOSgyA0CYeQ1BCFkwthGSFnOMp+sfbJdSj9Ll8iF7NrGxqwcK
3SjlaEiXsSxBgYdid/Oo7C1/Hp0R6+lCVhSiSDqKC8zwwswZztMnsoXP5LFr2Tx7
IsWJqh8qsmF9NMuBvXrCkbkUGrXZwxFmheiup1ASJtaw3CsSlVJgODbWfYQWRQep
TW/oZYWjqnZToW/PEkTV0W02dupc0w==
=i7s1
-----END PGP SIGNATURE-----

--w6gu74c4kyyeoian--

