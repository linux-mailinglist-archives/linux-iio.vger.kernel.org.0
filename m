Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0718320F4D
	for <lists+linux-iio@lfdr.de>; Mon, 22 Feb 2021 03:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhBVCHk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 21:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbhBVCHg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Feb 2021 21:07:36 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A363EC061574;
        Sun, 21 Feb 2021 18:06:56 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id p21so9289129pgl.12;
        Sun, 21 Feb 2021 18:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xhNLe44uyMs5LsbL1fgroHtE+9CupcOCuWpPW2Az258=;
        b=KynMqR0wo5FgwY+V9XdF2O+8jfUZgqyYNukNNB1c+p9SUIFRkLGKZsTbGh4IPPWkhL
         b5VntJ6Uhc0omSr64yZaUVhPPX/3wEnLu5/CavIeuPXM6JZS9vx7XLPx8OEdMy1o81EZ
         YeoF4hUH9vAmRWxy0b22RGH3jnfZ7AgIfv+fnYSexdB621syQKOKCiY/FD84oeJN4w7O
         rySwOIQHqT2a1lnqi9un8lfJG4RqOfhE6KvWLPUDgAIiIaVg6tYZ3t/hFi2/5gvYcyYA
         0p3qs6k8iG8+j4gsy6WMdnchkPrFt0Yzdo4jBIflH+bVbFvEZB/PQlf2gIexkPmRz6cy
         Dd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xhNLe44uyMs5LsbL1fgroHtE+9CupcOCuWpPW2Az258=;
        b=SKWab0oS7lfHRIErU4mxyj86v1zB03VC+564Xn/Dg7ACCHHZ8T0hywvaV6iISd2HM/
         vYrop5/a2S3J1ui6U2J/HR8+P/m+xCkoHq7Yk/RIkxippsoj3TytFrW0RZeEvckaKM7i
         Xu4fIakzZo2W2/MDGVt5gWWl6A2hy64Dw//vkV9gftNyPvWYMQ1ZXbZQjwTMgDswHTm9
         VvTw95mUubymaDy+ZNkxrY7hgle8FNXtcLpHH6SuLSzpYE5Vjuyh4Oxr4RY2Co9mYPY9
         RX5ov6ej2+CeZ74k4/0qKlcPRlGkmuHn+etAN/P7IrTURxubAO5T7U422A0bPjj8joD3
         udhw==
X-Gm-Message-State: AOAM533SvWdsi+Z0pWXnWaysq0VnEUXz/aKBpE42snrfVW+K438sHAjZ
        0l5FlKU6Q3oVpPkGiHC7U5w=
X-Google-Smtp-Source: ABdhPJxpMtqDfZcoaUP4OMF63Yuj9xoqMlPgDRHHMencsT4VGb5ipoLyD9samLQ2h1eZjqZlhH/0pQ==
X-Received: by 2002:a62:1c0a:0:b029:1ed:3472:36c0 with SMTP id c10-20020a621c0a0000b02901ed347236c0mr13700373pfc.64.1613959616130;
        Sun, 21 Feb 2021 18:06:56 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id c22sm15165633pfl.169.2021.02.21.18.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 18:06:55 -0800 (PST)
Date:   Mon, 22 Feb 2021 11:06:49 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     jic23@kernel.org, kernel@pengutronix.de,
        linux-stm32@st-md-mailman.stormreply.com, a.fatoum@pengutronix.de,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de
Subject: Re: [PATCH v8 03/22] counter: 104-quad-8: Return error when invalid
 mode during ceiling_write
Message-ID: <YDMRuTfazBev7fon@shinobu>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
 <2be0c071e7730ea16b8faa1efcd3d0d908e7f9db.1613131238.git.vilhelm.gray@gmail.com>
 <8e7daaad-e824-a823-1465-327cbc90ab23@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/YbOQ52TSX5QvpA5"
Content-Disposition: inline
In-Reply-To: <8e7daaad-e824-a823-1465-327cbc90ab23@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--/YbOQ52TSX5QvpA5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 20, 2021 at 10:30:03AM -0600, David Lechner wrote:
> On 2/12/21 6:13 AM, William Breathitt Gray wrote:
> > The 104-QUAD-8 only has two count modes where a ceiling value makes
> > sense: Range Limit and Modulo-N. Outside of these two modes, setting a
> > ceiling value is an invalid operation -- so let's report it as such by
> > returning -EINVAL.
> >=20
> > Fixes: fc069262261c ("counter: 104-quad-8: Add lock guards - generic in=
terface")
> > Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> >   drivers/counter/104-quad-8.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> > index 9691f8612be8..f0608b21196a 100644
> > --- a/drivers/counter/104-quad-8.c
> > +++ b/drivers/counter/104-quad-8.c
> > @@ -714,13 +714,14 @@ static ssize_t quad8_count_ceiling_write(struct c=
ounter_device *counter,
> >   	switch (priv->count_mode[count->id]) {
> >   	case 1:
> >   	case 3:
> > +		mutex_unlock(&priv->lock);
> >   		quad8_preset_register_set(priv, count->id, ceiling);
> > -		break;
> > +		return len;
> >   	}
> >  =20
> >   	mutex_unlock(&priv->lock);
> >  =20
> > -	return len;
> > +	return -EINVAL;
> >   }
> >  =20
> >   static ssize_t quad8_count_preset_enable_read(struct counter_device *=
counter,
> >=20
>=20
> What happens if the register is written to when in the wrong mode?
>=20
> If it doesn't hurt anything, I would suggest always writing the register
> instead so that users don't have to know worry about the fact that the mo=
de
> has to be set first.

Unfortunately this register is used for two different functions: as a
ceiling limit and as a preset value. When we're in the preset mode, the
value of this register will be used to set the counter value when an
interrupt occurs; whereas in ceiling mode, this value is used as the
upper counting limit for the counter. We should only set this value when
in the correct mode, lest we end clobbering the value for the other mode
(e.g. user sets ceiling value, but driver unexpectantly changes the
preset value).

William Breathitt Gray

--/YbOQ52TSX5QvpA5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmAzEbkACgkQhvpINdm7
VJL1CxAA42q+QCnTGNHPlJqhKTHAXIJHaKfmrLkcN2wDB/ceG4KPrs0Gr+Cpuw5B
wF9WlOmZCM8IAS1oC/flSZ0Uaziurx573EsBHCOYeHn1Tu0ITD2UyaqOYdFAmRKJ
PR5p6BdZqiZUeBa21fdMNg30vvkRyS94JcML889YF7KkDcsOHAld8virOD3dabhB
S5Kw/8eXSR05ajgnlLnlgy6BzjzgKWXVNqRWZBQHbDN0JeI6m7vxRMhcIWe4V5QQ
EK0pt1Hl6AsyxRqShZxKcknVRJ1Q2rbhnDIc8N7cxn+HolEBtEtxibh8GDMr4Vyq
xfCtZCnX6fUrp99L/boKOnnXTyPeJBhzpSXsD8+L0vWlHoPM7fxXxJrlj+X4JB0/
VpX/Uc4ub+EGQmidRim6znDBRiHWHcbk8Mirn2fU53ZYf5fwnGb9gxw+5z6WzEFA
RxrQCW8OySzNReQQNUELfxqKFpK2QIl+ox/R0yasDgAry3d55wcMD9kziKIiyi+W
QIbQfSLgI8IjteB8lIRmESQmBVs/FybUCULwElDI5/cta1gYRVBRm506b4Adwcx0
abgc8VK2A/0EySUKYpme61aQikIwyFJxBl7I1zpeY+ZleHqVTQhxsDWFieCMHvvH
GY0CUSAR58XdUskJjxj/N0PqmLHHbaxALhuCsL1nZET2to+WSQ8=
=3uyq
-----END PGP SIGNATURE-----

--/YbOQ52TSX5QvpA5--
