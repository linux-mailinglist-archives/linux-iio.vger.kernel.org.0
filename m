Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D69429EAB
	for <lists+linux-iio@lfdr.de>; Tue, 12 Oct 2021 09:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbhJLHdT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Oct 2021 03:33:19 -0400
Received: from www.zeus03.de ([194.117.254.33]:57834 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232530AbhJLHdS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 12 Oct 2021 03:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=k+hc0LSqnRlLyAmA5ndee0bb+bdx
        PickL2OMT3KDJ2A=; b=QpNcJGSvkhsSbw9V3qrSHAVeGitvSJ++ylGiq1zM1qyF
        vYBQ9Mvt6APCO/hsl8CeqzqX7Qj7Ml3vuJQbXwpEuSQsHQH33f114ShA18/Kee7v
        UNkTFxv+/aFN+dPF3ci2vmz2BEsFjQPhWKCcgJUuM5b6a2EJr+3ePlfnnOZZjks=
Received: (qmail 116915 invoked from network); 12 Oct 2021 09:31:15 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Oct 2021 09:31:15 +0200
X-UD-Smtp-Session: l3s3148p1@rRNs1CLOgNggAwDPXw9GALaHP6nygzLh
Date:   Tue, 12 Oct 2021 09:31:11 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 6/9] iio: common: cros_ec_sensors: simplify getting
 .driver_data
Message-ID: <YWU5v8aH3wtsAMlp@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org
References: <20210920090522.23784-1-wsa+renesas@sang-engineering.com>
 <20210920090522.23784-7-wsa+renesas@sang-engineering.com>
 <716533b5-380d-be72-b45e-d9909f09286b@collabora.com>
 <20210925155445.1edf4752@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H8wWZOzgwv6hePvi"
Content-Disposition: inline
In-Reply-To: <20210925155445.1edf4752@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--H8wWZOzgwv6hePvi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

> It's not something that ever bothered me that much, but we have had debat=
es in
> the past about whether there are semantic issues around this sort of clea=
nup
> as it mixes
>=20
> platform_set_drvdata() with device_get_drvdata()

Yeah, I see this concern. Mixing the two makes reading the code a bit
more difficult. As I said, it wasn't so easy to convert set_drvdata, but
I will have another go at this.

> Whilst they access the same pointer today, in theory that isn't necessari=
ly
> always going to be the case in future and it isn't necessarily apparent
> to the casual reader of the code.

That one I don't really see. *_get_drvdata() should always get
'dev->driver_data' and the prefix just tells from what namespace we
come. If you want to change that, a lot of things will break loose, I'd
think. Even in the unlikely case of platform_device gaining a seperate
driver_data(?), it probably should be named *_get_pdrvdata(), or?

Thanks and happy hacking,

   Wolfram


--H8wWZOzgwv6hePvi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmFlObsACgkQFA3kzBSg
KbYHVxAAjVE/Na4B2QboUrgsaxXsyQVAW6iHuD1YLul89LLjniraw9jmgty2R1at
CYAfsZ2X3vK9/uoGcHVnH6eqCHZETvD9B1fqHUXP3GsPibLGCFrd8jF1qbHgo6hA
jDJlcvffRpWymJEylM1EySX4MOpaStFWmhTzhuGKFhpk5FdPD6/5Y1tMNyNL1ftO
rrCYEwtzhyIJNCTTh/825Fzal3WnhaUnYLijCBip/43LEhpEGPU0bHqe14AkToYj
yY9kfGU4gHD742fTOOGTqOmFLSY+7J7r/zp7dwlx+84Fee+1x+kCnXoCalqD/jQy
r5Zlaij6C4KroQ6/8K17TgGKP+H4cfy7ZqJj0rJEvcsW/uM7txG5r3qBj2vzIMEK
qyNlQWm8CxPuwKjZ1vSBIpb0NkE5Qqn2+ekY7gi+ckHQUCZNBcOunCr3K+w52a98
k1dRoMWGYy1657yUQgZoi1AvGEGYs1u8RLLNVfykwcIqntUbsZJpL0ZxbYe+4bYz
cDBOc4eTME75Vu6EREOuUQk7V+OxEasO1UfH+LV7S0seduchTXBxjeJKdNalprFa
BxuUPEFw91ldNO0O6JI3hzRLp8VRn5tRlDoBO7T01AALyxDDgqYGKjp4JC+TE7tP
L//s2Wt0fLoZcnAlnswb6HL/67Bx7vB7e28ksM+qgokAXQPTXk4=
=Xx+O
-----END PGP SIGNATURE-----

--H8wWZOzgwv6hePvi--
