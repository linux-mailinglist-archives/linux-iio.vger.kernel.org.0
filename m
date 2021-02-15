Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA2731B7C6
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 12:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhBOLGK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 06:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhBOLGJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 06:06:09 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1694C061756;
        Mon, 15 Feb 2021 03:05:28 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id z6so3987887pfq.0;
        Mon, 15 Feb 2021 03:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=skRj3SiFYGU2FzoN8kd7HGllD8VylOwSjGHxSNwYAec=;
        b=FaxRQ5deUk0JFii2YaZJibjTP24hmSM8BZR0+RLufkX2FYW6uqMaE3Sp4YHHvAmYQ6
         jeQ+TdgDHS6sN/7cJ27uyXQ67xSlR9jsnD71Byalm5LZ+o/nJlxIWR2qB6S28iLjHxWt
         fCc7BFQgAkC4rAaz9iouSxSHLoFY+0q3BoA03iwTEEGKhRdfX65N+tbVQu7QWRsE4lxP
         pAgQa5myRn9CslysXU/jsocFy6WSOt8F1LNtnetUpNjd9aWuU7taeoV+uTZiXRnchqht
         +xg2vfa6waKGRp8ysp91PepEPVSyNtQK6+UwItBeC6A/umMJF0QHUpqZxhSFozgDxnk3
         EOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=skRj3SiFYGU2FzoN8kd7HGllD8VylOwSjGHxSNwYAec=;
        b=HxPoZ20zRTkgetqJlf9ydFS14D4LQqhq9bNPwYWpObnitO8DPA+DXqDzdpieKT5J5q
         hq1soEwt6aBuHSXHkWjL1/HAsMpzOyJOZs9rTZcYODUdtukVwQRRtZtvkyeCbYklguVZ
         gG6racaiFIIH/ERftVZlPh3giAo5haxp4kAH5xs9oIH/3fm3tCt0N1S0yy3zIQgdB10U
         TxMS0nHK1C0ZVX6yWGfILDyeHr7yOlW+R44+E1wnzlyv3momQOd0Xv3zarUenQYs+lpg
         BFr8Jb9y1KKGy7eSO3NZjkRXXmD872IB+h80n5uE9q4Spkag77MKOTSf7iGDm0PacZR2
         q/Ow==
X-Gm-Message-State: AOAM530HO+qGzMyFzWK7KzhidmfGKzRhwE4oh7EbbHgJwk6sX4z/GZTQ
        GUoviiAct0T/9uIvG7MtLE8=
X-Google-Smtp-Source: ABdhPJyL0U399rgcXtbM41RY2V0OAgXVvbu7kbig2ImxEBX+/o63OOWU7N7ZrsIB0Rpe5hxKxMPmXg==
X-Received: by 2002:a63:c60b:: with SMTP id w11mr14098269pgg.215.1613387128336;
        Mon, 15 Feb 2021 03:05:28 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id v1sm2379937pjh.29.2021.02.15.03.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 03:05:27 -0800 (PST)
Date:   Mon, 15 Feb 2021 20:05:20 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de
Subject: Re: [PATCH v8 01/22] docs: counter: Consolidate Counter sysfs
 attributes documentation
Message-ID: <YCpVcInGhe382jXf@shinobu>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
 <362a71a1eba98108d009db8c929170a6ed8cf110.1613131238.git.vilhelm.gray@gmail.com>
 <20210214165752.59d41f98@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Z1Nwiqk3OqT2bUBx"
Content-Disposition: inline
In-Reply-To: <20210214165752.59d41f98@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Z1Nwiqk3OqT2bUBx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 14, 2021 at 04:57:52PM +0000, Jonathan Cameron wrote:
> On Fri, 12 Feb 2021 21:13:25 +0900
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>=20
> > Duplicate ABIs are not valid, so let's consolidate these sysfs
> > attributes into the main sysfs-bus-counter documentation file.
>=20
> This is sensible to do, but is there any duplicate ABI?  I went
> looking for any resulting build problems and couldn't see what was
> actually duplicated.
>=20
> Jonathan

There's no duplication currently, so this is just a preventative
measure. These files were started for the purpose of permitting future
duplication; now that duplication is explicitly disallowed, we're better
off consolidating these now in order to prevent fragmentation of the
documentation.

William Breathitt Gray

--Z1Nwiqk3OqT2bUBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmAqVUsACgkQhvpINdm7
VJL2fQ//UMSW3JVs9UZ4whCZuEsMnzlKrLYLeY6s2SYByXA6mjOQwUsGoBwSdKGo
l1Eir4rSVWbCumt+wP6aGDNNK6lCy9SeNY5pyVKdxAn0zn5HMAl2NCPlw7NNkJa5
Q6Os47gfO8SzkcKZGpEAiKFT67py+lJTrBM1b8pb4Dyqn9/wmj8jTTMbrsziyx0y
L30uc2ywYiN3EUMbWs9OGgV2c7CPlnK3CawORqIfZIRW4vpCRsA08nKGNKzwJIIV
3yILgcHWACBDyaHYYahavAD6ZOIah20nBns/goJ4gUcoKe1Xw2XjthSkgk5+Srrl
CvAZAQycYuISG2ieQWZUBMHH8OG/iI683RWBmww8KstSSFOfTvsOdSwFp4R/9OV+
u52ONKDHklV1XhT4vlLpbLo5TOZppjwCpgUMQ/6AX2vCLSwjad9lbPy2izCk8xyu
VyoUdl8L8CyFb8wzsZ+Mb0LZa/tslC5iMIl+r32710t8i0u426MzJkUcNZroddcT
sidFuXWAECPyExu0hRCjfYLXf9NS57vI7Sya/pwAWmHg4JPRqIthkLatFwbZWiDS
XVDtUQNPmXPlNYrOyWn20xxUEJHKbRTe5yMv5kHiK3dv9PLI11tp4ZKKGYNGzbuW
w87j+h++r238nsrQV+pVXYf1UqWJ7mLQCIrIexEGy6qSYtCmZrw=
=hPFv
-----END PGP SIGNATURE-----

--Z1Nwiqk3OqT2bUBx--
