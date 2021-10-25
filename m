Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2600439061
	for <lists+linux-iio@lfdr.de>; Mon, 25 Oct 2021 09:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhJYHc2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Oct 2021 03:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbhJYHc1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Oct 2021 03:32:27 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223C3C061745;
        Mon, 25 Oct 2021 00:30:06 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r2so10030061pgl.10;
        Mon, 25 Oct 2021 00:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fW8mdh/khiooAdEd3/lCLkARLYrF/8I26bq7FLCm5w4=;
        b=HLUlj0diPV5+3KrGYZOQi1o1P4X28jWhJr0CkO3YDOeL2OILCPcpalIAhwWqx7uiB5
         jdvCe1Zzi0QDdb+NNrZrbTFhDHLlE8CEBGufTOnBU8QMS1N3yR2rj++67ThFtznMuvkl
         l6LFVVCeuwFyssunRj7AkXbiBZ5PNOhEmJKL0pGcAUiTNlFm9EmKY2K5ArydLT8UO8WL
         1nxrMD/rMsomTmspyuk9l6IG3qtLLanhkgLjo7ekReblnBTNhtvAlpjn8B+c7MEJKrul
         6BgpJow+FEE8aCUo6CdyKVusNs8cyVonXYhcEPMX/rhmT0Q9Nqhg+94oecv2K93UjkLf
         iowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fW8mdh/khiooAdEd3/lCLkARLYrF/8I26bq7FLCm5w4=;
        b=y/BKaRTijKcEmxqmVxGXvypcxkZRA72VDu/TOrLGVoMxKPNajhbvM2+RTkgABtSPCq
         3S0tfRzxQVblIhsWuBxCY/BTlme0716/0jMaPo4A75+Qi6+hguRRJHZGJczaSAsxXrIg
         KKFGz9ZX3tjov9cwwaeLVZ+FTj3U/goXlvoCnY+Qf+M/Yb6rx/ejFsmVyOBOGh62uaqM
         YILZmuQQ0JxgGuA+A17CKagShOaP+ag7NKvdNLuvylTtrHEnH7oJH+iPFxlpusdPiYIx
         y1aQ+8wpoILwTfnMJr0+9D1TJxRRQsi2UPOInJ0vBXRthchatateDCChyjLbshcFmqcQ
         8p0w==
X-Gm-Message-State: AOAM533XephKOq5RgX7iDLKG1RcYEUbqdlJdryfLXWPmkt4UvLoaCl6v
        4acY+H+WUBaio/eKswOY4qfzVbEv/VY=
X-Google-Smtp-Source: ABdhPJz2C6UvU3w7d/Tjyl5RHBXO+p9b6BQ3nAcvqHrp24G13uUuZUxBwusmdJS0YX8wvZuJ1nn8Ow==
X-Received: by 2002:a63:330f:: with SMTP id z15mr9290692pgz.42.1635147005610;
        Mon, 25 Oct 2021 00:30:05 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id d2sm5142348pfv.30.2021.10.25.00.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 00:30:04 -0700 (PDT)
Date:   Mon, 25 Oct 2021 16:29:55 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] counter/ti-eqep: add support for direction
Message-ID: <YXZc8wdOuf0/6rwQ@shinobu>
References: <20211017013343.3385923-1-david@lechnology.com>
 <20211017013343.3385923-3-david@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Z6tfghDNuu3LFJB4"
Content-Disposition: inline
In-Reply-To: <20211017013343.3385923-3-david@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Z6tfghDNuu3LFJB4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 16, 2021 at 08:33:37PM -0500, David Lechner wrote:
> This adds support for direction to the TI eQEP counter driver. It adds
> both a direction attribute to sysfs and a direction change event to
> the chrdev. The direction change event type is new public API.
>=20
> Signed-off-by: David Lechner <david@lechnology.com>

Just one minor comment below regarding the IRQ handler; the rest of the
patch is fine.

> ---
>  drivers/counter/ti-eqep.c    | 33 +++++++++++++++++++++++++++++++++
>  include/uapi/linux/counter.h |  2 ++
>  2 files changed, 35 insertions(+)
>=20
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index b7c79435e127..9881e5115da6 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -106,6 +106,15 @@
>  #define QCLR_PCE		BIT(1)
>  #define QCLR_INT		BIT(0)
> =20
> +#define QEPSTS_UPEVNT		BIT(7)
> +#define QEPSTS_FDF		BIT(6)
> +#define QEPSTS_QDF		BIT(5)
> +#define QEPSTS_QDLF		BIT(4)
> +#define QEPSTS_COEF		BIT(3)
> +#define QEPSTS_CDEF		BIT(2)
> +#define QEPSTS_FIMF		BIT(1)
> +#define QEPSTS_PCEF		BIT(0)
> +
>  /* EQEP Inputs */
>  enum {
>  	TI_EQEP_SIGNAL_QEPA,	/* QEPA/XCLK */
> @@ -286,6 +295,9 @@ static int ti_eqep_events_configure(struct counter_de=
vice *counter)
>  		case COUNTER_EVENT_UNDERFLOW:
>  			qeint |=3D QEINT_PCU;
>  			break;
> +		case COUNTER_EVENT_DIRECTION_CHANGE:
> +			qeint |=3D QEINT_QDC;
> +			break;
>  		}
>  	}
> =20
> @@ -298,6 +310,7 @@ static int ti_eqep_watch_validate(struct counter_devi=
ce *counter,
>  	switch (watch->event) {
>  	case COUNTER_EVENT_OVERFLOW:
>  	case COUNTER_EVENT_UNDERFLOW:
> +	case COUNTER_EVENT_DIRECTION_CHANGE:
>  		return 0;
>  	default:
>  		return -EINVAL;
> @@ -371,11 +384,27 @@ static int ti_eqep_position_enable_write(struct cou=
nter_device *counter,
>  	return 0;
>  }
> =20
> +static int ti_eqep_direction_read(struct counter_device *counter,
> +				  struct counter_count *count,
> +				  enum counter_count_direction *direction)
> +{
> +	struct ti_eqep_cnt *priv =3D counter->priv;
> +	u32 qepsts;
> +
> +	regmap_read(priv->regmap16, QEPSTS, &qepsts);
> +
> +	*direction =3D (qepsts & QEPSTS_QDF) ? COUNTER_COUNT_DIRECTION_FORWARD
> +					   : COUNTER_COUNT_DIRECTION_BACKWARD;
> +
> +	return 0;
> +}
> +
>  static struct counter_comp ti_eqep_position_ext[] =3D {
>  	COUNTER_COMP_CEILING(ti_eqep_position_ceiling_read,
>  			     ti_eqep_position_ceiling_write),
>  	COUNTER_COMP_ENABLE(ti_eqep_position_enable_read,
>  			    ti_eqep_position_enable_write),
> +	COUNTER_COMP_DIRECTION(ti_eqep_direction_read),
>  };
> =20
>  static struct counter_signal ti_eqep_signals[] =3D {
> @@ -442,6 +471,10 @@ static irqreturn_t ti_eqep_irq_handler(int irq, void=
 *dev_id)
>  	if (qflg & QFLG_PCU)
>  		counter_push_event(counter, COUNTER_EVENT_UNDERFLOW, 0);
> =20
> +	if (qflg & QFLG_QDC)
> +		counter_push_event(counter, COUNTER_EVENT_DIRECTION_CHANGE, 0);
> +
> +
>  	regmap_set_bits(priv->regmap16, QCLR, ~0);

As mentioned in the previous patch comments, you should try if possible
to clear only the interrupt flags for the events that you're actually
handling here.

William Breathitt Gray

> =20
>  	return IRQ_HANDLED;
> diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
> index d0aa95aeff7b..36dd3b474d09 100644
> --- a/include/uapi/linux/counter.h
> +++ b/include/uapi/linux/counter.h
> @@ -61,6 +61,8 @@ enum counter_event_type {
>  	COUNTER_EVENT_THRESHOLD,
>  	/* Index signal detected */
>  	COUNTER_EVENT_INDEX,
> +	/* Direction change detected */
> +	COUNTER_EVENT_DIRECTION_CHANGE,
>  };
> =20
>  /**
> --=20
> 2.25.1
>=20

--Z6tfghDNuu3LFJB4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmF2XPMACgkQhvpINdm7
VJKxeA/8DewMQEyK3pp4VpxYxuNG6LPLY+nhb76EqIUWyXaIw+4T8O49alUWs6KP
xLNO/uuz/aBdNp6aBEvrqhi6SMdzc60kn30bJil/HV3/elkdBafLR+m+BS4HHuyL
SAeBPmXgf0bYSofZ5KkV6+bnq02le15ang5HqO982S4geNc2tU72IJu+5NWVDQW+
ztMkGDmgXrPH6kfCduwqgFj3qlnIxuNRufr6lgQ+NaWccuefLIjZsYXeNcUeZ9eB
qhFy75eR52M1bAgZ11DiA10fPn01pXkDiPgsen8Q8Xck77gvlGODyukhYAzjnMvx
zFLa4klYbxMQ02CRfOty5UN6R+acuWdLSbBgjhVcG6b7UwY3Vf/DKABbDos6NGLC
3hzDbip5knfdMhPkKqk2V7LsyllKzVg1U6WdsyXzxk4N97GTPfBtG83nfKmiow3N
Yu2QRv7fTHDrAEXihs+vSgEkCyxmzQOtx07vKtly1M8ChEVhfJGcgyueipqFChrb
p6yOBYZky6lyUoaFsjcH+JTVQZrlEgeQQDvaVTO5DuJgfLNSWtM/I/n5e+8rsNYL
LvXUR0+CyxWzyORRpoJJHmS3g6WzX1UwHzjMIaugd0BhNisLIYT0GrfBJrS3mxV0
LNo4dPIDNEpPT4XDJ7t5JWxO5Tqms+EANyxeKj/M/wWq3al1DNs=
=y+ay
-----END PGP SIGNATURE-----

--Z6tfghDNuu3LFJB4--
