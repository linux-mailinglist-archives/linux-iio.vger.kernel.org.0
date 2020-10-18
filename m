Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D061291873
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 19:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgJRRAx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 13:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgJRRAw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Oct 2020 13:00:52 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91852C061755;
        Sun, 18 Oct 2020 10:00:52 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id t20so3345525qvv.8;
        Sun, 18 Oct 2020 10:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yujdBFkB3q9BJOlLyxki4mfbDVMsL1vTCbWLy+8lBMI=;
        b=ckCk2q5o7v5szVHaKyMuoygGUpGpXeHpABpm15X5HGebGvr8zNeCDhewOPLjOW8A5b
         A5x/7L8hq2WdlVgKkh1UYfhHANwghKNGHSIOyJhNTyFsieNldRv21X+BdSfHRSu5M7mN
         3ggajcXaSDzRot4fErq7UAhFR+sdjSiUEtSFhuUIDMlYSlPa6gr1pSRDZADp/WZr8Rdm
         jig16l6Ayiq0oia9m3BHJFZfxWFbwXlcwQmw/7pqh0p23TbDwQyI7WLXrPxw4zxWTv/2
         AP/Ouj31L1EjMIVL+jzKE2F1VC6mRA9gT4+h/wDfiwsz3aSkifcJGxq8g6+/wpzeR0A2
         vxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yujdBFkB3q9BJOlLyxki4mfbDVMsL1vTCbWLy+8lBMI=;
        b=KldCXSD1Stq+GVJkuYv7ZN9tTa5HiwTBEUfp1BTqGy+Vf/Rv9ov3CrVK/u3FxiHtW7
         rb2wsBSr5g6K6NuG167yfJ4ePthb4QZKFn48O7JKTEXNICeNyGFK4L4sEUFnyUbFJHAf
         55+mOpkUc3vVKpONjFqhVtWUdxi4svq3tgbHURYQ3TEyYFVbbjbThGWVAnWCLWYVYQco
         LHa17aaZN8vsZKxyw+Sg2yI+lL2OwBlyPMIcHlANeATbhR2+OR53L9DQ+XOyXUP7TXDK
         wBj0+YFJZKLCHE3+MJFU5+c0Wok8VW2VaBxPSn0/jAd5YmksCVEgz4k+MJgagoRk9XPs
         sEvA==
X-Gm-Message-State: AOAM5339U+jUIp4OUHo7u9ROpwOkcT4lvpdCUQ/2f+ysnZjBPQlaMFLt
        My+Al0secxiyG7XH1VUIuYA=
X-Google-Smtp-Source: ABdhPJxNlnIU6xr+cJt+OBz08lremIvgnYee2WsNAYN7ymK0uJnexErasR91ZvKozAYXToooGtHP/w==
X-Received: by 2002:a0c:b902:: with SMTP id u2mr12852355qvf.7.1603040451750;
        Sun, 18 Oct 2020 10:00:51 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id k17sm3334285qki.5.2020.10.18.10.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 10:00:50 -0700 (PDT)
Date:   Sun, 18 Oct 2020 13:00:48 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Subject: Re: [PATCH v5 1/5] counter: Internalize sysfs interface code
Message-ID: <20201018170048.GF231549@shinobu>
References: <cover.1601170670.git.vilhelm.gray@gmail.com>
 <e38f6dc3a08bf2510034334262776a6ed1df8b89.1601170670.git.vilhelm.gray@gmail.com>
 <17c22445-d523-07f8-d1ff-59e8dbc73cc8@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GV0iVqYguTV4Q9ER"
Content-Disposition: inline
In-Reply-To: <17c22445-d523-07f8-d1ff-59e8dbc73cc8@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--GV0iVqYguTV4Q9ER
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2020 at 08:38:40PM -0500, David Lechner wrote:
> On 9/26/20 9:18 PM, William Breathitt Gray wrote:
> > +static ssize_t counter_comp_u8_store(struct device *dev,
> > +				     struct device_attribute *attr,
> > +				     const char *buf, size_t len)
> > +{
> > +	const struct counter_attribute *const a =3D to_counter_attribute(attr=
);
> > +	struct counter_device *const counter =3D dev_get_drvdata(dev);
> > +	struct counter_count *const count =3D a->parent;
> > +	struct counter_synapse *const synapse =3D a->comp.priv;
> > +	const struct counter_available *const avail =3D a->comp.priv;
> > +	int err;
> > +	bool bool_data;
> > +	u8 data;
> > +
> > +	switch (a->comp.type) {
> > +	case COUNTER_COMP_BOOL:
> > +		err =3D kstrtobool(buf, &bool_data);
> > +		data =3D bool_data;
> > +		break;
> > +	case COUNTER_COMP_FUNCTION:
> > +		err =3D find_in_string_array(&data, count->functions_list,
> > +					   count->num_functions, buf,
> > +					   counter_function_str);
> > +		break;
> > +	case COUNTER_COMP_SYNAPSE_ACTION:
> > +		err =3D find_in_string_array(&data, synapse->actions_list,
> > +					   synapse->num_actions, buf,
> > +					   counter_synapse_action_str);
> > +		break;
> > +	case COUNTER_COMP_ENUM:
> > +		err =3D __sysfs_match_string(avail->strs, avail->num_items, buf);
> > +		data =3D err;
> > +		break;
> > +	case COUNTER_COMP_COUNT_MODE:
> > +		err =3D find_in_string_array(&data, avail->enums,
> > +					   avail->num_items, buf,
> > +					   counter_count_mode_str);
> > +		break;
> > +	default:
> > +		err =3D kstrtou8(buf, 0, &data);
> > +		break;
> > +	}
>=20
> In this function, return values are not always errors. So it would make
> sense to call the err variable ret instead and check for ret < 0 below.
>=20
> Setting enums to a value with index > 0 fails currently because of this.

Thank you for pointing this out, I'll fix this.

William Breathitt Gray

> > +	if (err)
> > +		return err;
> > +
> > +	switch (a->scope) {
> > +	case COUNTER_SCOPE_DEVICE:
> > +		err =3D a->comp.device_u8_write(counter, data);
> > +		break;
> > +	case COUNTER_SCOPE_SIGNAL:
> > +		err =3D a->comp.signal_u8_write(counter, a->parent, data);
> > +		break;
> > +	case COUNTER_SCOPE_COUNT:
> > +		if (a->comp.type =3D=3D COUNTER_COMP_SYNAPSE_ACTION)
> > +			err =3D a->comp.action_write(counter, count, synapse,
> > +						   data);
> > +		else
> > +			err =3D a->comp.count_u8_write(counter, count, data);
> > +		break;
> > +	}
> > +	if (err)
> > +		return err;
> > +
> > +	return len;
> > +}
>=20

--GV0iVqYguTV4Q9ER
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl+MdMAACgkQhvpINdm7
VJKeBw//TwierwwomvmWRWfZmlmzByWQ0Q7nkMtO2BRaENfqcAsKHsPcQL6HjwT7
73s0pwxRoUV/l2SXpb/YQCAGwVHdVLEDXPxYRIHFoC5dCV86zlQxztpNjYhQSi7E
z6ztS9vXxVr4zFxvcOErIujSx1OCfEFMuXNeM7jguaOdy0Pj0l0o8eJ+crxlOgsP
YfTSnWFCF99W/An/uealjV379jc+TywdEiWOHbtB5vLgvQZ/lpLSLLqypq1i+lXX
wcFeTJxqrjGRzbCX7wnK5OEqBMSCv8rSSM5/iSW82KPcN2bI+8GjlIbdOorgrQHy
+o3d0fEAgUU8F7twCEPtA08hZuEbtdlSC8R8aL7nAplRZ0TnLwv1W9VR7nwZ/X9Y
MD2nMl6BX8t4sbccQCa+RYhbgD8DuEeSBRqRPDORpljKF2S8i6yfDxqlXJPkZ3po
DvjaPhCJr9jVgb300ZFYhtELNkH1zrcvlY5l8QIX/WxDYmASg//h/+v4duOxBPuw
DYysQMzezGzsWuUzsJppcRsSyPFDFrBWo6s/irk8tn0rRkr54vLhMmvXWxa0G0fX
YdrtsY08lCP2LzAOQ51axaqq/w9xKZbfgq3efugA3lPdpvMsCR3Iivu10tdEcoaZ
APv6EFt2nxwgyWPIxmDBaSpl9jnTW1znv/KeDR9ZrA8Z/rvhAAI=
=rCo9
-----END PGP SIGNATURE-----

--GV0iVqYguTV4Q9ER--
