Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687402A9654
	for <lists+linux-iio@lfdr.de>; Fri,  6 Nov 2020 13:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgKFMmf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Nov 2020 07:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgKFMmf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Nov 2020 07:42:35 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2811C0613CF
        for <linux-iio@vger.kernel.org>; Fri,  6 Nov 2020 04:42:34 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id s14so836840qkg.11
        for <linux-iio@vger.kernel.org>; Fri, 06 Nov 2020 04:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mmSROBLr7qTyDK5MeM29D+hPI+10Zlk+TD1mvS+sayA=;
        b=fLIkLfFLJao5C5NhVKY9MYO0q9vG2+SyXw6EleHWU0ykhsL5/MGhuN1gY8+T4AtM+r
         bJwVq9gmxCE9AOIY4W1b/4XMcek6fBSKiY+3AlYJujQ65TLY4uKvhDKn6IiY+sl5wzTF
         2K3sDSy58RcC+D8i9pxvIMXh96kBDn4i5SsrNy6TKLRaJJJqxJ4E6OOr5LnLoi2NAPtG
         3inSqyEl1/DMp8+VHeEpP7aN3GKl60xDXaQT8QJsHgbEPK4uIm11u3AiefZMfgGlK5Sy
         PpkjfWJjx1fzE9/Dmwt1BfdLaqiKIf2FGMbyRWlw/BzNePNiDHar2yIVKjJbJbQKAY4F
         gdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mmSROBLr7qTyDK5MeM29D+hPI+10Zlk+TD1mvS+sayA=;
        b=jr2zFiui6CcYGKZtcrvx7OLtlKWidLquL3hQfS4K/wn9ZQKrIDhtK4fYx5+cPtzkes
         DB0D0uWYwFutdDuyrO7G0M2PBe/dFqyZquGwTTvlhJoXrznLpEZTdapAuyTPOQ3QG+GF
         +m4DhKZZX4cvpAYk7l4reezoX36zmJBTJFqXVLoSyfCRpVQZe76ieR7U+MvEdVXmG9eA
         vipf1c24Q7473BVGRNl1NLuuyUzyVap+tL+mLnsOKTh22pQbKi5i8Nz3g65Blt+1my3T
         STCwk2GrjGr6e+YX+2/wR+5ukkmXnrDcyWnf8DbiOVTabh+Erj3tYtwc8Fem2muEVJms
         03gA==
X-Gm-Message-State: AOAM533Ub6ME2LwsQPuueF23tU20/a3FAjABLfh8NmHe2YCZ2+N50kDI
        V1W6lvNDziZoRr30ta1oOXA=
X-Google-Smtp-Source: ABdhPJz+x7n4rUjf4oIoJdeh6d8gec6X3dn+fZEHdSdzVcqy/djqfsTjZZnpdAHVnrTYcxSoPB/C+g==
X-Received: by 2002:a37:a80b:: with SMTP id r11mr1232848qke.380.1604666554176;
        Fri, 06 Nov 2020 04:42:34 -0800 (PST)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id h9sm387832qth.78.2020.11.06.04.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 04:42:33 -0800 (PST)
Date:   Fri, 6 Nov 2020 07:42:17 -0500
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Holger Assmann <h.assmann@pengutronix.de>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-iio@vger.kernel.org
Subject: Re: Counter device Interface for reading out input capture
Message-ID: <20201106124217.GA4015@shinobu>
References: <e8c99989-f018-dd90-2144-e09c05a3731b@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <e8c99989-f018-dd90-2144-e09c05a3731b@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2020 at 07:46:14PM +0100, Ahmad Fatoum wrote:
> Hello Benjamin,
> Hello Fabrice,
>=20
> In the stm32-timer-cnt driver I find unused #defines for TIM_CCMR_MASK and
> TIM_CCER_MASK, which to me hint that support for the "input capture mode"=
[1]
> was implemented but removed prior to upstreaming.
>=20
> It doesn't look like the counter device API is yet made to support such
> an input capture mode (latching a counter value on an external event, e.g.
> to timestamp incoming rising edges to measure jitter between pulses).
>=20
> I am still very new to this, so I figured I ask whether you already have
> thoughts (or maybe code to share) on how to best integrate this with the
> counter device API.
>=20
> I've added linux-iio/linux-stm32 to the CC as well, so if someone else
> has an idea how to best do this, please share.
>=20
> [1]: 40.3.7 in RM0436 rev 3
>=20
> Cheers,
> Ahmad
>=20
> --=20
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

Hi Ahmad,

Regarding the Counter subsystem, I'm developing a Counter character
device API that supports timestamps for counter devices:
https://lore.kernel.org/linux-arm-kernel/157d1edf-feec-33b5-7ad5-94f99316ca=
6e@lechnology.com/T/

My aim is to get this functionality picked up for the Linux 5.11 merge
window. I have one more revision at least that should be ready in a
couple weeks -- I'll CC you for that patchset to keep you in the loop;
I force-push periodically to my personal repo when as I develop, so you
can take a look at the current state of this next revision if you're
curious:
https://gitlab.com/vilhelmgray/iio/-/tree/counter_chrdev_v6

Sincerely,

William Breathitt Gray

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl+lRJEACgkQhvpINdm7
VJJo5RAAi1RnWj35dtmsJ5bISyBJFuQsbOFlQ38c5s7gHy6I9/02Yo2kU6JDYB6B
qL2J/FCVaP6FI9ufoWnfKsy2e2Un33gvJ261GL60sfL7UcEUCUKdvFb0iBiDcoFA
CLtNRDqsT0fx/yFNgr7nzRdnBZIjKAzDY7ObEpLBxkFKBSVfjxlIUut2ATetTdmM
j1kvzOrBjzqxxp7WxkysJB7b8lU+S/oXvlW6cwKgcwDu+9guCvzlh2GEQMBHWRsb
6ndxohTkV2rO+JCTrDYJ5SusZq9WPv2s1xbj5w3A1mXxfWlMqYYZdT8TtXBXrmAB
H7aG2D9FPSwztJX4HKSDzFuBZbpiHHpWpYjTfr+enYJibi7pqVJL+isA6HvOPZRa
H8LuudhNtZotEaQNvOqzEumgHf8auWO38OQ1BczmRZdnQPlKGjgoEv20oSsevBli
vJRycnjgrN7uJtcPfafPAMnbEczO5bNczkbHxZOv0nExPtwko806MDRrYwFsE5MO
F1CjeUz4uEQ5lW41RYPwbV4SZSYVXR0Tk93vySY6CVkpuFI4L/qgQ7cdSsuskXmI
6fnVAmNcqYbYWtAkcsoOt9OKvJkXgo4oTkuoJMNVar5jLbl635jcb/mgwFCeTnBG
95tl27AdMquOj9O1kLvYgNHQbW9ZAo8Zt62BZhWGFARIdcHladw=
=3mUG
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
