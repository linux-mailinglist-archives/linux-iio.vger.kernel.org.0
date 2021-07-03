Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC19C3BA841
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jul 2021 12:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhGCKoX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Jul 2021 06:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhGCKoW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Jul 2021 06:44:22 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50189C061762;
        Sat,  3 Jul 2021 03:41:48 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b5so7216164plg.2;
        Sat, 03 Jul 2021 03:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4KvK7Sqawc/qFEoNceXD+lmtUnYGz4Pj5zrvgWBaRao=;
        b=brcjtOpAbaGPW9dltdVwN6s1X8KsSyWk/Iq18RE6RoMLGzdWFwA331I1+VZoHL93mg
         ztE3dOxVnT8zdO3gsp1gU05sk8JQqiaaeoZVD4rtTxSXHgnzReA0dIZLORaY3dziLuu5
         34uFeyGWmy34gTXM1VKq6LhXJxRSytwey7F47xqrIkgyF41OyM4XFKh4mjUGuRGAqvjD
         RNmaCXGJ78CMGeEYtdP/ssWuDen5+kWQ8kuVWa7C7vMAtfe2gQ9913h40qycq2MWYAJR
         EYoP/HAWSqkLox2miJ+5Ln8Pj5f5dr7ooQX1Zwuy5e4ZIANKRASJUs8MxSRpRR+OeE1t
         ixtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4KvK7Sqawc/qFEoNceXD+lmtUnYGz4Pj5zrvgWBaRao=;
        b=PBMceOP1bqsgs6J68oNi7Apdy8MUm+bz9SKN81JalYyQANdmhxeSreYE2LS5GW4Upv
         DLWc4O9Ow40phU6/3AEGBe6lBB1HjAwaheVUFil8VHd/12IUcLs1eHgwwcIlF4wWPvxq
         fgAj/pdknOFtaX0lk5L+XjYMX3BEgtB+o/baXxfKPYp6JAQ6eYLwjsDNFR50BdWoFB9W
         xrVtHTT+XFJHifPY6sZBZmkKXz9DurwIle8V8klakVDUW4WRH3w3442tO1uWp/vCB+RI
         wj0pxZ8GcxnP4mK6IWSVRswDuF5/HicHSZ21YM1DUdNKE/QHKbRnDGQkE95of9fmWEIw
         TDkg==
X-Gm-Message-State: AOAM533Xmu0K/w80r0i7OXqZ0V39EzADaNJ590wuozMgWbn/COBjt0ZK
        5z6/kfwhGL9YNe0DX3ac2zU=
X-Google-Smtp-Source: ABdhPJz9ZT6oBH6j3WHoMG4b8h7HGXy4IMOhQLxEA1ATKXxW9ka7MANk/isrD1hZVGsLygxEvtO1uw==
X-Received: by 2002:a17:902:864c:b029:10d:8c9e:5f56 with SMTP id y12-20020a170902864cb029010d8c9e5f56mr3611515plt.8.1625308907677;
        Sat, 03 Jul 2021 03:41:47 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id h1sm15145928pji.14.2021.07.03.03.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 03:41:46 -0700 (PDT)
Date:   Sat, 3 Jul 2021 19:41:39 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH v11 18/33] counter: Return error code on invalid modes
Message-ID: <YOA+456Ns2PKdKa8@shinobu>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
 <6f74bf8b237340ef079b7d3e3553f47434f47f67.1623201081.git.vilhelm.gray@gmail.com>
 <20210609164731.2180e4e4@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L0zbxqWKRF+f1jGx"
Content-Disposition: inline
In-Reply-To: <20210609164731.2180e4e4@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--L0zbxqWKRF+f1jGx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 09, 2021 at 04:47:31PM +0100, Jonathan Cameron wrote:
> On Wed,  9 Jun 2021 10:31:21 +0900
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> > diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm3=
2-lptimer-cnt.c
> > index c19d998df5ba..78f383b77bd2 100644
> > --- a/drivers/counter/stm32-lptimer-cnt.c
> > +++ b/drivers/counter/stm32-lptimer-cnt.c
> > @@ -206,9 +206,10 @@ static int stm32_lptim_cnt_function_set(struct cou=
nter_device *counter,
> >  		priv->quadrature_mode =3D 1;
> >  		priv->polarity =3D STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES;
> >  		return 0;
> > +	default:
> > +		/* should never reach this path */
> > +		return -EINVAL;
>=20
> In this particular case we are already exhaustive.  So we should have nei=
ther default
> nor ideally the return below. =20
>=20
> If we have a local variable of the relevant enum type, then I think the c=
ompiler
> should be able to tell this is exhaustive and usefully it will then issue
> a warning should the enum gain more entries in future.

I tried using a local variable of type enum stm32_lptim_cnt_function,
but unfortunately the compiler is not able to tell this is exhaustive --
I think it's because 'function' is of type enum counter_function which
can theoretically have a value outside enum stm32_lptim_cnt_function.

>=20
> >  	}
> > -
> > -	return -EINVAL;
> >  }
> > =20
> >  static ssize_t stm32_lptim_cnt_enable_read(struct counter_device *coun=
ter,
> > @@ -326,9 +327,10 @@ static int stm32_lptim_cnt_action_get(struct count=
er_device *counter,
> >  	case STM32_LPTIM_ENCODER_BOTH_EDGE:
> >  		*action =3D priv->polarity;
> >  		return 0;
> > +	default:
>=20
> Same in this path.
>=20
> > +		/* should never reach this path */
> > +		return -EINVAL;
> >  	}
> > -
> > -	return -EINVAL;
> >  }
> > =20
> >  static int stm32_lptim_cnt_action_set(struct counter_device *counter,
> > diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> > index 65df9ef5b5bc..878725c2f010 100644
> > --- a/drivers/counter/ti-eqep.c
> > +++ b/drivers/counter/ti-eqep.c
> > @@ -157,44 +157,39 @@ static int ti_eqep_action_get(struct counter_devi=
ce *counter,
> >  		 * QEPA and QEPB trigger QCLK.
> >  		 */
> >  		*action =3D TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES;
> > -		break;
> > +		return 0;
> >  	case TI_EQEP_COUNT_FUNC_DIR_COUNT:
> >  		/* In direction-count mode only rising edge of QEPA is counted
> >  		 * and QEPB gives direction.
> >  		 */
> > -		switch (synapse->signal->id) {
> I'd rather see this as
>=20
> case TI_EQEP_SIGNAL_QEPA:
> caes TI_EQEP_SIGNAL_QEPB:
>=20
> To make it clear what the two cases are.  Then we don't need the default
> assuming the type is right so the compiler should be able to see
> that we have been exhaustive.

I can refactor this back to a switch statement as you suggest, but we'll
need the default case for the same reason as mentioned above.

William Breathitt Gray

>=20
> > -		case TI_EQEP_SIGNAL_QEPA:
> > -			*action =3D TI_EQEP_SYNAPSE_ACTION_RISING_EDGE;
> > -			break;
> > -		default:
> > +		if (synapse->signal->id =3D=3D TI_EQEP_SIGNAL_QEPB)
> >  			*action =3D TI_EQEP_SYNAPSE_ACTION_NONE;
> > -			break;
> > -		}
> > -		break;
> > +		else
> > +			*action =3D TI_EQEP_SYNAPSE_ACTION_RISING_EDGE;
> > +		return 0;
> >  	case TI_EQEP_COUNT_FUNC_UP_COUNT:
> >  	case TI_EQEP_COUNT_FUNC_DOWN_COUNT:
> >  		/* In up/down-count modes only QEPA is counted and QEPB is not
> >  		 * used.
> >  		 */
> > -		switch (synapse->signal->id) {
> > -		case TI_EQEP_SIGNAL_QEPA:
> > -			err =3D regmap_read(priv->regmap16, QDECCTL, &qdecctl);
> > -			if (err)
> > -				return err;
> > -
> > -			if (qdecctl & QDECCTL_XCR)
> > -				*action =3D TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES;
> > -			else
> > -				*action =3D TI_EQEP_SYNAPSE_ACTION_RISING_EDGE;
> > -			break;
> > -		default:
> > +		if (synapse->signal->id =3D=3D TI_EQEP_SIGNAL_QEPB) {
> >  			*action =3D TI_EQEP_SYNAPSE_ACTION_NONE;
>=20
> Same as above
>=20
> > -			break;
> > +			return 0;
> >  		}
> > -		break;
> > -	}
> > =20
> > -	return 0;
> > +		err =3D regmap_read(priv->regmap16, QDECCTL, &qdecctl);
> > +		if (err)
> > +			return err;
> > +
> > +		if (qdecctl & QDECCTL_XCR)
> > +			*action =3D TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES;
> > +		else
> > +			*action =3D TI_EQEP_SYNAPSE_ACTION_RISING_EDGE;
> > +		return 0;
> > +	default:
> > +		/* should never reach this path */
> > +		return -EINVAL;
> > +	}
> >  }
> > =20
> >  static const struct counter_ops ti_eqep_counter_ops =3D {
>=20

--L0zbxqWKRF+f1jGx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmDgPs8ACgkQhvpINdm7
VJIM8RAAtBnjAxwzeOr7wd4UDb/xNOayc/BVMzHyG14uLcLDZ+eaTt0Ybed2vyEX
zrKiWV1Bg+73uN6VCTP48Yy+LUo/q92I/N9dumD6GjB28VbfWfwPmQbZqT5lLZxy
iSfj8IjE6zxf+TYjf7AM4PlAC986ToeMije/uHhUtz5YBq53KGAhLEs4UXbI3cKk
XLrobHYcaHp+3nUoxdSOID7z926IvGDkHt/RIOD84h/dykAroC9WG8039mK5qTKV
FnnbuiVgxVSFl31Z2Ex8MPekQWJ/bHjztiYMdwwy5Cv8jzP6mDXgTGfHoBRBxOHL
Aa6sWtzV5AxJ04w4wV/F/jDMV89bBcV+IHT0PM3v6KUksh9Vj6Bhzwrwc6DWOhl6
2aqfs5Au90wxaPZny4dZvBYDUe/bNza/AaRukjTaWz1ke4c1CK01JIdQfVwL3EJu
ZJwfM6EWXsXQZR72DGR+EvU0umBcD7XSVh8MqHW+t2S7URLSWXtX2jp22Eyk0Afn
gfyG0djNGc1y8goafISDyMkibAaeBAHmSorfRcpdiK8hxdmjeXxmJbFqn/5Cx+TZ
tN34+RWYAFwhrlPcDjVwn/PjjzcKjuGlTPFVRfmXyjDP9SzG1XrlZrvOC/LwoHRD
YORaHeAYv5oYP9ZTFm8YZ/d7VICKCdd3+JZz0cjDzMA/QESdIPY=
=1NPf
-----END PGP SIGNATURE-----

--L0zbxqWKRF+f1jGx--
