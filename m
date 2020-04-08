Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD801A27E8
	for <lists+linux-iio@lfdr.de>; Wed,  8 Apr 2020 19:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbgDHRY2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Apr 2020 13:24:28 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39394 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729416AbgDHRY2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Apr 2020 13:24:28 -0400
Received: by mail-qk1-f194.google.com with SMTP id b62so1010313qkf.6;
        Wed, 08 Apr 2020 10:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HsE0FdNQUdBILUMJI+9L+7PKuj3mLVujqM0DGf2eORU=;
        b=qZgDKwRBfLCXw5QWOprk//cA37v9wTV30oJ856gkXumHgDbS0CA9aXUFZRjLsOxqDE
         FpPNELnBxdeGU3vVQvMKXnanTwFqi8SAlJ8MYb/c3Fyjt3LrPqFY8Ald16MLHzSYCdQh
         HYMIitiyaghI7CaWBntXQF5r5Fe8oRRlPPMJsfo2AnPAfxFZ8OXLI2esSepdvb/TpNU2
         UYQv/snorw7LU1atbo/TvhpCvTmuf2SKJSnNWcP0wuf0n9WvCvjxKlv/VobUgcHO1E/Y
         brcXawQT4FM/QEedqk20/E5tHBM0SmgCJKXre9QLqY5eB0fgnP6EDyjCsl0uiWvgt88Q
         okDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HsE0FdNQUdBILUMJI+9L+7PKuj3mLVujqM0DGf2eORU=;
        b=ZEj74XArdqlTxLWqLTg0NIdwTqaFjbdDosvYB2ziFVIBnAtl+wq1v5TMYudOp1Z3GD
         YJmZRkhdy8joZ4CP+JSkwCv3qi+PBEaeDcqYIViOp9exFGpNk7GWQX8bYJBwWid0z1w3
         o5Sqb4kgR1wuHj4vutEvBoD5zan6dN49g1cpq4NOmvn1J/AX/jwAniWYSzdWyz+OfUL1
         zsL1GBTtBlvCzMuddtHQvRn0d5avljxVMpeMocYodionQbbonK7HPOzFot0T194KzSfm
         zelikx1tWWvaKoYuh8y/Fv4Zotsw+Nzf2VH5R8QcmUi6AHLPWZbrr2LwcFksESl4W7YF
         M36g==
X-Gm-Message-State: AGi0PuaFE1zJaNB7pEJL7Y5dFcECBsP6qbGawan0bUK/AmYl32uSM6zA
        W+BRWKrTYQWDfaKlxMUaHe8=
X-Google-Smtp-Source: APiQypLq+YxX7AEQ1/fkwlscPvuOJ4NNLNsdaUItHgUIZMocOcD6myauCj+uUyQniWYzYxLSvvKVQw==
X-Received: by 2002:a37:b702:: with SMTP id h2mr8849253qkf.491.1586366666956;
        Wed, 08 Apr 2020 10:24:26 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id e26sm9580792qto.90.2020.04.08.10.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 10:24:25 -0700 (PDT)
Date:   Wed, 8 Apr 2020 13:24:05 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Enrico Granata <egranata@chromium.org>,
        Collabora kernel ML <kernel@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nick Vaccaro <nvaccaro@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] counter: cros_ec: Add synchronization sensor
Message-ID: <20200408172405.GA25871@icarus>
References: <cover.1566563833.git.fabien.lahoudere@collabora.com>
 <d985a8a811996148e8cda78b9fe47bb87b884b56.1566563833.git.fabien.lahoudere@collabora.com>
 <20190826095612.7455cb05@archlinux>
 <8abbe9360938ab851d16c2c1494ba56034775823.camel@collabora.com>
 <6b50bdff184e6af664b7a61e0a8a2cddc5718f0a.camel@collabora.com>
 <20191110151408.GB3984@icarus>
 <20191111114955.00001031@huawei.com>
 <20191112011618.GA62259@icarus>
 <CAPUE2uvDiAfE68uCzWdTN3T2L_PR3JPeyGWDrc5ToLieEpGH1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <CAPUE2uvDiAfE68uCzWdTN3T2L_PR3JPeyGWDrc5ToLieEpGH1A@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2020 at 10:10:28AM -0700, Gwendal Grignou wrote:
> I resend a counter driver for the EC at
> https://patchwork.kernel.org/patch/11479437/
>=20
> I tried a timestamp only IIO sensor, but this is not allowed, as the
> timestamp channel is very specific: no extended parameters can be
> added.
> I did not add a COUNTER_COUNT_TALLY type, as a newer function
> COUNTER_COUNT_FUNCTION_INCREASE, fits the counter better.
> I am still using IIO_COUNT (inspired by the st counter driver) to
> gather the event in real time on the iio side.
>=20
> Gwendal.

Hi Gwendal,

Despite the silence I haven't yet forgotten about this. I'm working on
an update to the Counter subsystem code that should help develop a
real time timestamp functionality for counter drivers. It's not yet
complete right now, but I'm hoping to release it later this month. I'll
CC you when the time comes to keep you updated and make sure it fits for
use cases. :-)

I'll review your current EC patch for a counter driver in the coming
days -- I have some IRL work I'm taking care of this week but I should
be able to take a look this weekend or soon after.

Thanks,

William Breathitt Gray

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl6OCJEACgkQhvpINdm7
VJL7lA//bfs1FP8LBzWhR0KexQx7zXkVQiDaEWeRPjLpQPi143c0SLZx8IrJwIe1
VdJWA7gNXvHHnCcV7oZqCUBqJXIUrWA3b0Mavz2DISd2NoikrW1q1S/auJ2+xUJQ
mZueiLVh3SC3Jt2QU7wHxjTPbWUBQVCLvZ8AAn/JLWWADmPryawOMnPtwQpxaB2d
KiZdvW1XCI+4Hc3oujNidgTi0hqp/LjLO/IvN+QtiKfK0adWAFOIcItP7PAkhN2o
aIpbEwaSSfHgBqlKBAwOYDz8WJDohF2j/1CcbbsghFJ7so27Dwp4rPf6Tyy2h+kB
89Fj5YJAy4B4zAOA0tgU01zf+m0MZxQ4QkdS3hv27Rk8k/MF2HuMgC0DGoiySuzL
zTb/Cvn6cFoMMlXZ1HwlALzC2D7HsoLzkq/UvY0MpawuEiz8Ury0RghOaz+IluC2
egN/v5ucLw+1Ac+nHYfkU5KOzU8XX6LALXB+0E6UjE9Cwqv6j1tw9sVJcCDXpGQB
FXXjsyOMjsz9gZm90LDk8VhmsAbSptfEzmpwtuvdqVCVMkUvSmhqPLu8PpTmW8wC
Tj2Lv3WlnUNCzzyMxfIV1R1sAYEL2Vxk4/HssllCwAcku7WQIo/zVdRR+qnsQVQZ
S4gDOgC/zKN7prCcsCGSX3csv8zPwtPUh9mJdaP6zwRczc3ZY1w=
=Whhq
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
