Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2608C3226F2
	for <lists+linux-iio@lfdr.de>; Tue, 23 Feb 2021 09:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhBWIP0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Feb 2021 03:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhBWIPY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Feb 2021 03:15:24 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BF1C061574;
        Tue, 23 Feb 2021 00:14:44 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id k22so9363413pll.6;
        Tue, 23 Feb 2021 00:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6QVPlsgRJiJCSIqYUUMXsd4yZA1p/Hu+W1ld8bR+c0k=;
        b=Kw5WT1yuRR8LzvAIGoyDmijKFRn5uET7bx/sWIdrRtqj4FD/J8KOZNDlDR5AxI/caa
         oAKdjF9PL1rbX+zJPY97s5MI+hlktvG/aD621PU7VuwKWUIwjeuP0Wr2HiOAdBBN2Gqq
         x/s+stukp95b3oHwS3PaV+Dgp0ukFiIdkgIOg8ycRPRwrcHxjjoKjDYM9l7MpvfcqHJB
         k7bC4L84Xvu4ByPAjcufR+DEeFee+VK9nCf4R0VC8utpWUpZWrgdEAmPrjBkGIenTo9I
         b6f8BC5q8UwfiT53jq7KxcS/Tsnae1VK5lngIFsj2DHrXvl4NCSfgB+XXS5lfOxhvzgD
         j5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6QVPlsgRJiJCSIqYUUMXsd4yZA1p/Hu+W1ld8bR+c0k=;
        b=tg8gEpUbS3lcpmilxIsduxj6sZkLY9cyHJtoHQQawdoFsGNJhELt8HuDu/J/uduDWE
         N0sFyNvdWeBF+BZ3SX7nT3OtjQzSpn6AxRCQDcWkGCuOZBJjBFCfH/alU9QYV4IG0G0z
         k7kQQ2Tud8n1Dm816uC4EiyaXMdHyBdo15fRjxbM9TxtxWoTYdjfoaN6/u7QXjXLY2WP
         MJBJq3M2c9EJYMCQoK5jwHdaF8HE0c/6cQDWUjf6oMyljKMMmo2JMk/kdJS2/8WUK4KD
         A3eXL7c58ciE7OlhJT8zpflMIXFoXoQ0IYxuR+b4Qhw7v1NwVrNVQQW4unqwUwGXYN52
         zC6Q==
X-Gm-Message-State: AOAM533Sy/E59mg1MuBk7kKluT9bkG+ROQ3GZ1QbIOqD8fFbHBoM95AW
        6s577V47ns/s/5AYsiJ/uNIYpZRiWmG6Dg==
X-Google-Smtp-Source: ABdhPJyWOwFhq0GI/yzhXdE2wyLpy4T2B8rQPgj0g7JqCQxzawkkKW3PGLcX//qqY5UVVTUpw9gggw==
X-Received: by 2002:a17:90a:404f:: with SMTP id k15mr27330246pjg.220.1614068084180;
        Tue, 23 Feb 2021 00:14:44 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id c18sm21902533pfi.167.2021.02.23.00.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 00:14:43 -0800 (PST)
Date:   Tue, 23 Feb 2021 17:14:38 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v6 0/2] add support for GPIO or IRQ based evemt counter
Message-ID: <YDS5bp9vsG25nDeT@shinobu>
References: <20210216081356.3577-1-o.rempel@pengutronix.de>
 <YDMNiBjnJKanhTUH@shinobu>
 <20210223071630.lazyuvhr4xgqhafi@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WaZvC677jfRnJHXr"
Content-Disposition: inline
In-Reply-To: <20210223071630.lazyuvhr4xgqhafi@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--WaZvC677jfRnJHXr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 23, 2021 at 08:16:30AM +0100, Oleksij Rempel wrote:
> Hi William,
>=20
> On Mon, Feb 22, 2021 at 10:48:56AM +0900, William Breathitt Gray wrote:
> > On Tue, Feb 16, 2021 at 09:13:54AM +0100, Oleksij Rempel wrote:
> > > changes v6:
> > > - rename it to interrupt-counter
> >=20
> > Hi Oleksij,
> >=20
> > Sorry to nitpick again, I think "irq-counter" as Jonathan suggested in
> > an earlier review would be a better name afterall. Would you be able to
> > rename this driver to use that name instead?
>=20
> I would prefer not to rename it. IRQ (Interrupt Request) is a signal
> outside of the system. Below some frequency rate, amount of counted
> ISR (interrupt service routine) calls or events would be equal to the act=
ual
> IRQs. If frequency is too high, we will count ISR, but not IRQs. In
> any case, interrupt-counter is more or leas neutral, without triggering
> too many wrong assumptions.
>=20
> Regards,
> Oleksij
> --=20
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

I suppose "interrupt-counter" should be fine in this context then, so
perhaps a rename isn't really necessary afterall.

William Breathitt Gray

--WaZvC677jfRnJHXr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmA0uWEACgkQhvpINdm7
VJJ9gw//W0Nw3A0b6H36jFtb1PwrQRx2rrFJiO7WeGDl0IxpGkDh5p5D48LcF/sB
2MD6nCyE/MZUqyFiJObPUmsiUrUQ9R1tPOdscDzu6a8dGpazWv5gt8/abuFMTMJQ
3J0Tflc3swtWZiNSVYLhOMs8v+q4lYjjQRIFFDmOVUTy5c6wSb+2p8WYkN63b+H2
o7Fhj4xBspJDJvaTeDJKPRn1BWgb8RHMdsviu2m34HsiTR8oXawXCWsi8U+z/bP4
Up7xbXEtWQJ2KIlOXZrF7w+75d0WKa3V+K4+63sktDpByz3T5/CTD82TfJr/nMaq
oiExuPjlagyNlu8IjXHZea9Yya1hp+EqepLfgeqC+HUhSG6J1F5M5HEBCXY6p59h
g7O8fOdbSp/lzSRTZk3SkW+EZXXjD4WUM21ywMBamm4QvBm5aBp8FrQ4MsqE2HYU
qJ7I716wknX63kxgHbnbPqCVPfPRj81VGTeoZee17Imf0LwE9h2xvBKDz//VD8SL
Bn+UkaSSaoTVADL25A7oPgsgv9uM5/myMLDJj2Vl2jZ/ip9el+TSgTQAoNtEBbj9
NiFSMfaVp/gsVvsAT3vDjABRSl1OgZb+7dPwGYQgyMVrjK+3/M/Z54f9ZKBF+cw8
Z56Vfi4MbggTF8iTt4Wfg68iT96kjdeHMoRGdZcplb5zCaIvcAU=
=8gCY
-----END PGP SIGNATURE-----

--WaZvC677jfRnJHXr--
