Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882D9287077
	for <lists+linux-iio@lfdr.de>; Thu,  8 Oct 2020 10:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgJHIJO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Oct 2020 04:09:14 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:59738 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgJHIJO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Oct 2020 04:09:14 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7D1C01C0BA3; Thu,  8 Oct 2020 10:09:11 +0200 (CEST)
Date:   Thu, 8 Oct 2020 10:09:09 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, david@lechnology.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Subject: Re: [PATCH v5 4/5] docs: counter: Document character device interface
Message-ID: <20201008080909.GA31561@amd>
References: <cover.1601170670.git.vilhelm.gray@gmail.com>
 <54190f9875b81b6aa5483a7710b084053a44abb8.1601170670.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <54190f9875b81b6aa5483a7710b084053a44abb8.1601170670.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +        int main(void)
> +        {
> +                struct pollfd pfd =3D { .events =3D POLLIN };
> +                struct counter_event event_data[2];
> +
> +                pfd.fd =3D open("/dev/counter0", O_RDWR);
> +
> +                ioctl(pfd.fd, COUNTER_SET_WATCH_IOCTL, watches);
> +                ioctl(pfd.fd, COUNTER_SET_WATCH_IOCTL, watches + 1);
> +                ioctl(pfd.fd, COUNTER_LOAD_WATCHES_IOCTL);
> +
> +                for (;;) {
> +                        poll(&pfd, 1, -1);

Why do poll, when you are doing blocking read?

> +                        read(pfd.fd, event_data,  sizeof(event_data));

Does your new chrdev always guarantee returning complete buffer?

If so, should it behave like that?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9+ySUACgkQMOfwapXb+vKILgCdGWcMSFTNlT8BzJiXCxl8XH94
G+kAn1mYy8F8mA++sLAit6PznfuXTwgX
=pq8O
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
