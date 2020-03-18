Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B38841893F7
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 03:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCRCS5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 22:18:57 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46210 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgCRCS5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Mar 2020 22:18:57 -0400
Received: by mail-qk1-f196.google.com with SMTP id f28so36280361qkk.13;
        Tue, 17 Mar 2020 19:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=25IWALHi+NXst7Xu28sZVkGuORaxg4iwbvG83wUoJp4=;
        b=eaTbqq+UVTkedK7NahvYddiAh+YVk+5cNhsSvqCmgNFao1/su/WGBuQYEWTwbMOyKq
         BM6FXNLPFAObqA8MGgdPcLHRKAxtw1sKWibrzO4Gb6/b60J4+OuTrxSo8JdaoCjAG7E0
         6LmG17fWhGIf0G4GgHrKf7gVbtHdR23YLZLIPNIQkgJVV/DcR+GU/j67bsxOeyliVhA+
         F1X6elvUndBvHahQh3Doi8CEeD7zaAk4DVw64TO6QxfvcD1Mpv09+Ttm5SSmF5Hs+hXl
         6Iv2oFRD/+YpKutXWqTcoUoOtQ4/dU88NQERIQh+c5O3Is6W5FTMuYYw99zqoTOsOnnP
         ahYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=25IWALHi+NXst7Xu28sZVkGuORaxg4iwbvG83wUoJp4=;
        b=YfN+OqyY0+dBD5VFg+96V5TVxqLZGfU0V5oY0Z12Rcl6iZZWoL9nzlxf3ws5FPCV25
         VinQCeIXGx5Tf25T088GaS90Pgi2wr2bueWMwAdryAjki5PIO8tBoJ7gAfqJ6euYjv3q
         BL6irnv+X7B81kRieuRKCvkdVgWtpUAtj3A1UFIOpJsKkPLp2sNITcL7Dn5s2EdlweXL
         UhMN/tgqQtmOV2HgN3DDXVCNLSZGGYhBmfGSM09vZD71Q5yDhwvVlhXZRFBP7Pv2ODy8
         +2lwIoeJyuHzuHj5XReUmyB5p1HK0SwMuUaRFUGcfOJqjactHO9cvJWT/mFfgHxbRK81
         yY0w==
X-Gm-Message-State: ANhLgQ3iNAU397JRcqls+erHBVRfs59+a+7Y5o9YlvNXBRlnUmbCztSA
        7UHw4PYqv0wBUqXjQCGnCEnWCSE9ZTC5cA==
X-Google-Smtp-Source: ADFU+vtobpMVyykQ44fsZh0a89BryFL33+quNDJSwtHkSbz7z8g2/fzShZU3zABRZTarB7knUhsvwQ==
X-Received: by 2002:a37:7f03:: with SMTP id a3mr1892552qkd.121.1584497936401;
        Tue, 17 Mar 2020 19:18:56 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id z43sm3722493qtb.92.2020.03.17.19.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 19:18:55 -0700 (PDT)
Date:   Tue, 17 Mar 2020 22:18:53 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Syed Nayyar Waris <syednwaris@gmail.com>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] counter: 104-quad-8: Add lock guards - filter
 clock prescaler
Message-ID: <20200318021853.GC45571@icarus>
References: <20200316125046.GA447@syed.domain.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline
In-Reply-To: <20200316125046.GA447@syed.domain.name>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2020 at 06:20:46PM +0530, Syed Nayyar Waris wrote:
> Add lock protection from race conditions to the 104-quad-8 counter
> driver for filter clock prescaler code changes. Mutex calls used for
> protection.
>=20
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> ---
> Changes in v5:
>  - Change spin lock calls to mutex lock calls.
>  - Modify the title description.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl5xhQ0ACgkQhvpINdm7
VJLYCRAAsfIrrgeI1WGLGZIe1SbDnRRQ69JHBsoloeYESw2e3a7XVfXJlmTdmZq9
XnpEGwEa8HEdN6QU+q6UfimmN9jV3Y/AYkpZXoiNsMEZZW0qUHFGhBnnE5FbU8W5
4O5/mafRL7yBgv7mkdP+LEPCDKawLh72ioUkxG+nbrD7/dPXKmjLurBqHDU1a3i+
9Gmc+uPmPBEPpqzmXzrnmzItBDj5bkAXjsitJLw7S1Lkbf5MRQ6A0pIQvkKeBy7C
drtollv4B58amC0EZ/cZCenq7nvwZTvHBFrnEBHSzjqlGpT9E+5eWfJ+Uj3IylNw
3TcpRH4vVXRgwp0NmpGERC694Rt44IUhSuMbElJBSFiwFCAhUBLzMhpdx98Y1Jwh
bXtFSeK1AwzzupHlm7mlQn2qnTy9DKMoc+rp8esxFmuCFMgxQwZv/jvaRurxmCsS
lUnvMsXtyTwhuYfJ5HHtm4j0lZsqR8zemTVqa8R7dLpcVINcdxyhzUT4fobeklaL
NVHFSca9TeDCy8QwF9PhGTiiR5VoOiCk6x9kb7cYqBcxz+oPyVQwdaoyaYjnHmXa
12aIAsovDvs2vUOcnPGqmS4foRfOePK7ql8S01cc0TPl5idTP/0uypUP1zLQC0Zh
bhbNKcVpI/YXipRlshuEna+8/uRjGS6tGh3flUi3oBG6uNG5l84=
=mpe2
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--
