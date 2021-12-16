Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42DF4780A1
	for <lists+linux-iio@lfdr.de>; Fri, 17 Dec 2021 00:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhLPXcA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 18:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhLPXb5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 18:31:57 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273C9C061574
        for <linux-iio@vger.kernel.org>; Thu, 16 Dec 2021 15:31:56 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id a23so450516pgm.4
        for <linux-iio@vger.kernel.org>; Thu, 16 Dec 2021 15:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IYkVdXAMM1FGo0JX0Zyjvw3eVz4fHmPEoGytHWrnI5c=;
        b=PgnIfzveoQ6x4Jvi5FmmxKVioNLW1OLLfa4ZJltyBjjCgzNe+fF2qDrHX/1/0OzWm4
         6ltqQnDVctpJlDs9/o7E+hVb3fd5UynfGqKNzmGVNewKmxKoZxmNRPXOwJMttObuYR1o
         vzPjXXwRhWRAqSMnTsz2ZxBfN0oXEMl+rA7UicomdllJ9M154FToNLqfFkO4uhwauhp3
         7jPDCZpVm+XyFu9oTngfm3oET9GWRghQa/ePSPJbVtTQF0SHlFjO0wLNwj8LkVOgvhW0
         ZJQg8dpnDbbj2IO8PPdSjOY28b3nXn9CzdiLIO2gmOWjK2zyEOVFFauT7dpQFelo964d
         kzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IYkVdXAMM1FGo0JX0Zyjvw3eVz4fHmPEoGytHWrnI5c=;
        b=M4Ki6Ie5JFx3iEi+SehuuH2TLz1eCs9Swq4aEKfArNOjkHRuEChmAfPOx5em3ZpGTm
         ME8DPMNfrZdNWLtMpG7p6VIJDckHJIFSLQS231nrdbt81s2TZFCMZn2LocQMkpr4h8Qe
         b+cwoev+4+J417IapqOSnLxMynJAHWxpQg1N7iw6DFmC4SZkv3f3kS2JKFXtfQeKLWHs
         BcaGcs5qep/CWZPItOGSGLxqTRTioe2jtzjDRg91qT2KDz+Zdmc3RWTtRP6BaLakuLdl
         S1S3c5l044HIA4J6z1nqvbdlttg6dCK+HAwZav66AHr6u/3xCLtM4KXROk10TiuFwwaV
         ylIA==
X-Gm-Message-State: AOAM5301HvdXAjKnrzVsJbrCVDU34aAJ7al4txogyZIvMxbetB5jro41
        ILm9cXm8Bvd/9Lli/WqfIO7w3rNuJUVY/A==
X-Google-Smtp-Source: ABdhPJweR0wNYahF3PVyFgAmoctgdVsbedrHe+iVKWwFS0mFQh4MdOAO+Rr96SGfLiYaQmFacC/c8A==
X-Received: by 2002:a63:5b1e:: with SMTP id p30mr453659pgb.288.1639697515621;
        Thu, 16 Dec 2021 15:31:55 -0800 (PST)
Received: from shinobu ([37.120.154.44])
        by smtp.gmail.com with ESMTPSA id pg14sm4222737pjb.37.2021.12.16.15.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 15:31:54 -0800 (PST)
Date:   Fri, 17 Dec 2021 08:31:49 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-iio@vger.kernel.org, David Lechner <david@lechnology.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH] counter: ti-eqep: Use container_of instead of struct
 counter_device::priv
Message-ID: <YbvMZUKj0V+W0pEv@shinobu>
References: <20211213114312.1406562-1-u.kleine-koenig@pengutronix.de>
 <YbrNr20FBb+ZMShv@shinobu>
 <20211216104915.62qfwjal5bz3x7g7@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BZkDPSvlzJ4nFggh"
Content-Disposition: inline
In-Reply-To: <20211216104915.62qfwjal5bz3x7g7@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--BZkDPSvlzJ4nFggh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 16, 2021 at 11:49:15AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> hello William,
>=20
> On Thu, Dec 16, 2021 at 02:25:03PM +0900, William Breathitt Gray wrote:
> > On Mon, Dec 13, 2021 at 12:43:12PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > Using counter->priv is a memory read and so more expensive than
> > > container_of which is only an addition. (In this case even a noop
> > > because the offset is 0.)
> > >=20
> > > So container_of is expected to be a tad faster, it's type-safe, and
> > > produces smaller code (ARCH=3Darm allmodconfig):
> > >=20
> > > 	$ source/scripts/bloat-o-meter drivers/counter/ti-eqep.o-pre drivers=
/counter/ti-eqep.o
> > > 	add/remove: 0/0 grow/shrink: 0/9 up/down: 0/-108 (-108)
> > > 	Function                                     old     new   delta
> > > 	ti_eqep_position_enable_write                132     120     -12
> > > 	ti_eqep_position_enable_read                 260     248     -12
> > > 	ti_eqep_position_ceiling_write               132     120     -12
> > > 	ti_eqep_position_ceiling_read                236     224     -12
> > > 	ti_eqep_function_write                       220     208     -12
> > > 	ti_eqep_function_read                        372     360     -12
> > > 	ti_eqep_count_write                          312     300     -12
> > > 	ti_eqep_count_read                           236     224     -12
> > > 	ti_eqep_action_read                          664     652     -12
> > > 	Total: Before=3D4598, After=3D4490, chg -2.35%
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > I'll pick this up and submit it with the rest of the Counter changes for
> > this cycle.
>=20
> This is great. The same transformation could be done for the other
> drivers using the priv pointer. Then priv could be removed from struct
> counter_device. Good idea?

Sure, that sounds reasonable. Create a patchset with the changes, CC the
respective driver maintainers, and we'll see if we can merge those too.

William Breathitt Gray

>=20
> A quick prototype patch yields:
>=20
> drivers/counter/104-quad-8.o
>   add/remove: 0/0 grow/shrink: 5/17 up/down: 76/-172 (-96)
>   Total: Before=3D11802, After=3D11706, chg -0.81%
> drivers/counter/ftm-quaddec.o
>   add/remove: 0/0 grow/shrink: 0/5 up/down: 0/-60 (-60)
>   Total: Before=3D5096, After=3D5036, chg -1.18%
> drivers/counter/intel-qep.o
>   add/remove: 0/0 grow/shrink: 0/10 up/down: 0/-116 (-116)
>   Total: Before=3D4867, After=3D4751, chg -2.38%
> drivers/counter/interrupt-cnt.o
>   add/remove: 0/0 grow/shrink: 0/6 up/down: 0/-60 (-60)
>   Total: Before=3D2841, After=3D2781, chg -2.11%
> drivers/counter/microchip-tcb-capture.o
>   add/remove: 0/0 grow/shrink: 1/6 up/down: 12/-68 (-56)
>   Total: Before=3D5920, After=3D5864, chg -0.95%
> drivers/counter/stm32-lptimer-cnt.o
>   add/remove: 0/0 grow/shrink: 0/10 up/down: 0/-140 (-140)
>   Total: Before=3D6458, After=3D6318, chg -2.17%
> drivers/counter/stm32-timer-cnt.o
>   add/remove: 0/0 grow/shrink: 0/11 up/down: 0/-132 (-132)
>   Total: Before=3D5504, After=3D5372, chg -2.40%
> drivers/counter/ti-eqep.o
>   add/remove: 0/0 grow/shrink: 0/10 up/down: 0/-120 (-120)
>   Total: Before=3D4598, After=3D4478, chg -2.61%
>=20
> (the ti-eqep object file got a bit smaller, probably because I removed
> the priv member from struct counter_device.)
>=20
> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |



--BZkDPSvlzJ4nFggh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmG7zFsACgkQhvpINdm7
VJKp+RAAvnmbmdybOyb+JXGpQAepzIFk16eBmYHtyb1lV65k7i6dCfJc25pBpLdg
gbL+L4SyRy+ddZd5FTFIdGC9r8ovcd9c6pO0+kVx0TP8oYR+HiWPXr0YcSdpVlwN
g0X936M9TDy4ZG2X7HCI5+CRF1/m+gC3VWD8yvYQDw/Fowoh0kF0uNyTWlWIjd33
4inV9LGx09Z+Zdn7gFHV8A3uAmpQOQIiJbYzSzc5K8tPtTQ3ZjwdFhbppcPq+ELF
3wrq1fJUwxW+hVmLBGPk3OSb17Y5kHMyxFaZ+A8uXSVZ7g7Gm0ryHwqUyG9xGnkW
LWciakM1Ghbr2wC3IjBiRDYdmTljMay1QznDj7T2LCeaQRr7ZJohN3i5eP092VD8
++Pn+lyGIZIsCYF8xW+995AgHF9Itr85zquKW0697xHhi9z8V9CzXd2jm021LCDU
G4OFwEVs9XvEZHq1yMbwZtdh3ybrOXFkDSHNTNJMfdQZEtWR0ExYrEKWrpx2muk5
5ImMPXTXQjy4nEJi4nodV9lJCJWRoroHO6jHa4qRFsxTi5JWhBlXh7uVbO/OjUuG
hdlkeuOjYgf2TilORF0LYbChFLO70BSkCKYfmehajEB2JpF7MAYLTcjp/sTrl3rV
1e0rC7P8OzUtXlXbbaDzO6tfVqLjDuHr4fiT3gMeJNvv+bwDefw=
=T7Jt
-----END PGP SIGNATURE-----

--BZkDPSvlzJ4nFggh--
