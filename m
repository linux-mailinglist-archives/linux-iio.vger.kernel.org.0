Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE4632B400
	for <lists+linux-iio@lfdr.de>; Wed,  3 Mar 2021 05:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352713AbhCCEMO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Mar 2021 23:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbhCBX4L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Mar 2021 18:56:11 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992D9C0617A7;
        Tue,  2 Mar 2021 15:42:36 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id r5so14871392pfh.13;
        Tue, 02 Mar 2021 15:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fiAnoFjzacA0imTnyoKZQv76RqIEHnX2/K6oUxFXX4o=;
        b=EPlDnykTEOFwrrNi3VCTr2D0NAu7wA6HUJXPlvXRoxdtGjJWxudI+EHEjlDB+QbLsL
         /Dig1CEWUEbkI86kKdzt2MkqboP2zo9p5Csz/+Bp78OpGBZ2juV1ImJ/YI5pAxX/PMDx
         d8FEHsjy6PZ2z//B1TSxK6Fdra/ml7/EVUhs7bIIz2Ryc2QCoapDQYdt9q1j4hFYKr0R
         MSBdBTwNeUYpM9WAZxbngXJ5T7zB9gX4KIx4Za2BF/3n1Wuj6qcqKDrRHkDrn+dDdvIx
         WXHNJpMM+dwLkAri+AhVMV0Z8nlRjUSKAoQNXtgdmWkwxaGCUBT99J5aDWzs7DnGlN9R
         72cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fiAnoFjzacA0imTnyoKZQv76RqIEHnX2/K6oUxFXX4o=;
        b=NkP/i5FFNvw1SfP1ujJHZIH7gnrzWvtlSxm7Zir6euK/FK52QeyWr5BkGdydaYeqpS
         lmOCSdammJhh6VjKQdtt3RqnDLcuLN8iR07hERPlv7caCCLLDTNdjEN+cbW9Rva9dGkx
         GqCMLV5/MLTWSS/TCmmmyHl3R2zNWK6wloyYlY3avnELwt0VkHRDkK4LURAKcT/Y2HDn
         /uULLuaWcBJ50qzMsfQS/SyrjHIVKlV8lfmjlQOKsVraHSJ7lFsujdeWIUtBGuBs8+rQ
         ECJXsnuxd7flNoy2wWRGBYFktAkwzUv01JO3xvmlSlZzCK4b8FSChYFfu9Ns8deUKWul
         Ov2w==
X-Gm-Message-State: AOAM532TIDiNVXHSRWqXL5VIX8YBpZbQu1C6pvwS/Dw/f8VwDPkjpFmB
        BfvpBOM3QMNNQzyHFpWSVrNlcmc6FbU=
X-Google-Smtp-Source: ABdhPJw28iH7elPLbDmtvEvdF40fXJweRxOIP3ohvJ71aWvfcCbL8d8nufDoY6fKQt5phiAIhCJArg==
X-Received: by 2002:a65:5c85:: with SMTP id a5mr19936436pgt.355.1614728556132;
        Tue, 02 Mar 2021 15:42:36 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id h186sm21599877pgc.38.2021.03.02.15.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 15:42:35 -0800 (PST)
Date:   Wed, 3 Mar 2021 08:42:30 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     jic23@kernel.org, david@lechnology.com,
        alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com,
        olivier.moysan@foss.st.com, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: stm32-timer-cnt: fix ceiling write max value
Message-ID: <YD7NZiqCtmtmqJGg@shinobu>
References: <1614696235-24088-1-git-send-email-fabrice.gasnier@foss.st.com>
 <YD5SLrdttn+95M7N@shinobu>
 <e54d1446-b583-9625-1ab3-09e54d6a7456@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bCkxX5gdifsBCD9i"
Content-Disposition: inline
In-Reply-To: <e54d1446-b583-9625-1ab3-09e54d6a7456@foss.st.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--bCkxX5gdifsBCD9i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 02, 2021 at 06:03:25PM +0100, Fabrice Gasnier wrote:
> On 3/2/21 3:56 PM, William Breathitt Gray wrote:
> > Side question: if priv->ceiling is tracking the current ceiling
> > configuration, would it make sense to change stm32_count_ceiling_read()
> > to print the value of priv->ceiling instead of doing a regmap_read()
> > call?
>=20
> Hi William,
>=20
> Thanks for reviewing.
>=20
> I'd be fine either way. So no objection to move to the priv->ceiling
> (cached) value. It could also here here.
> By looking at this, I figured out there's probably another thing to fix
> here, for initial conditions.
>=20
> At probe time priv->ceiling is initialized to max value (ex 65535 for a
> 16 bits counter). But the register content is 0 (clear by mfd driver at
> probe time).
>=20
> - So, reading ceiling from sysfs currently reports 0 (regmap_read())
> after booting and probing.
>=20
> I see two cases at this point:
> - In case the counter gets enabled without any prior configuration, it
> won't count: ceiling value (e.g. 65535) should be written to register
> before it is enabled, so the counter will actually count. So there's
> room for a fix here.
>=20
> - In case function gets set (ex: quadrature x4), priv->ceiling (e.g.
> 65535) gets written to the register (although it's been read earlier as
> 0 from sysfs).
> This could be fixed by reading the priv->ceiling in
> stm32_count_ceiling_read() as you're asking (provided 1st case has been
> fixed as well)
>=20
> I'll probably prepare one or two patches for the above cases, if you agre=
e ?
>=20
> Best Regards,
> Fabrice

Looking through the driver, it doesn't seem like priv->ceiling is used
in any performance critical code, just the callbacks for count_write()
and function_set(). It might make more sense to remove priv->ceiling and
replace it with the regmap_read() calls where necessary so that we
always get the most current ceiling value from the device when needed.

As for the default ceiling value for the device at probe time, this
should probably be set to the max value because that is what a normal
user would expect when loading a Counter driver (a ceiling value of 0 at
startup is somewhat unintuitive).

If you prepare those two patches, then that should resolve this.

William Breathitt Gray

--bCkxX5gdifsBCD9i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmA+zVsACgkQhvpINdm7
VJJFfhAApkmoM+QVO5Ye1YiRiaPZVc4EraJ5xZXent7IGzIjHmwT8Z0mPz32vpVb
XI3Wab4NSUGT49jZxArKseAB8Q0ifCezMxTzgV10vAXPX1M7ys8rkT1lKQ77nuI0
3FGOVhSFX2Np29B1+TNTQWL9MqoH/vRk+IyZmWlMfoy2UkmxHo4zDCnAvx157bOD
ltBOol8XHodbZ4aSTooW5CnflMzPOetWEkc2w7BQ4MZaMJbQ8QGFTrTHd8N/V17+
KITYs3f0OHPBJL66O4+fLTfi66EZcy44OH+9+flDF2js8YZRX548z8T8yv6Vn2UK
eFHR0f1RTmBjL1BH6qvRdqZtwiBit6S40wcm7OxmC8HcLswReWLKd74v/ObEw9N9
2IfRhWtY+xw/G1G68OR4fuAw4xxU9K+lGXBF1G/UnD5zGCdBfDEbE3sIyHvheKWk
RnWlHD2KHfZlNL7e8pPabTHh/dX46D2NjAZbZTPYwB4y3vUPpbBaVJXH7TBAneEo
odk96y8aXnd9HItyeHVdb60Ie38NUsAhl0XOqI6ntrJ/XHzLHIeO313BXJ5p0J6y
WJRyrlJO8tZcl/K5KeQXohhuRRwmkAToM5GNvCPOn81tPMRZodNniuy59Y81PGaJ
5TQOBetBgKfy+I2EDWzzyFg7rQLBSG7d4wm6gHAqw9pO7RhjuXw=
=uxhN
-----END PGP SIGNATURE-----

--bCkxX5gdifsBCD9i--
