Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6460F439021
	for <lists+linux-iio@lfdr.de>; Mon, 25 Oct 2021 09:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhJYHPm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Oct 2021 03:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhJYHPm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Oct 2021 03:15:42 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94FDC061745;
        Mon, 25 Oct 2021 00:13:20 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id g184so10023968pgc.6;
        Mon, 25 Oct 2021 00:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lmZ5KTa1G3hCmguSsJrMoe/12GbwtoRlM0rQatKzw3o=;
        b=T4sw9o3Ir6Zs0Cr6J7fUuFMcJV9VTQ1u9dpFlqBX66vo81q00+bNTGR2a6KzukyIzs
         beEnjaZp80KSle5Z86/IFThbKiL+t3c8jvXxJGnYTHTSTRsLeePRDsIeqg7LrXXsEOJc
         JtFERmytFdguOEW35KN4EQh8OEjtVVNqWHLubIEyV5Hbbm2aXSDKep+Mqi34qz48FI2t
         7Y93UN6m6K4gu8bq9otqpugVl+4vpmEnBZP/htq/KsFyqGxyUMg1tcV/UN7Dq+vgStQS
         FiiqIrg95Mc83jVHB3h1Bo247jfyodyh2Z1/IcGKBcK1OCE0jW8/CoOXx5UDKWL6Xjf0
         d8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lmZ5KTa1G3hCmguSsJrMoe/12GbwtoRlM0rQatKzw3o=;
        b=jw/IjO3dNiRZx1Z5qd0J2x8Bvlp8F5miUntr/Ti9uWA4PjW62RtH9cn5CJEVnoMe28
         nmsmhwHulx1f/ITsK83M+fKYa+J48Wb1Upi63PmzxpAxvlTjMNxTjLqPIcEwJ5TDWeDr
         ePXiebsrh16CY/5XZz+uyqp6/rAuUhpPB8NX18asyI4k06aeF3HF6RHCs10jw7xoWmdm
         YVwTuI7YKVDFGvJweQQz31QO901qYprT9ZT3YgYA+pN5SG/93GcNx9l6nYJ5wyRLLP3b
         gJOjMBdYKqx1/6Otf0+ShqgRJy0PlMgZ+Az314WirMnb7AE87BCl5jQ33ilv5tO0Ab5R
         eYiw==
X-Gm-Message-State: AOAM533BbTMmke5O5Rf/3M4pLL29Fqzd1MsAbdf6Z8rkYQrmCnnfgv5R
        0v6fCGwyK06ot0AqQLSsb1M=
X-Google-Smtp-Source: ABdhPJwzxAfT0bBdHAdExQ0Akju3lVNjVLPQAgRh1jN5CwZICS8HJy2aqC/YQ1nN6SsBoB1gJA53lg==
X-Received: by 2002:a05:6a00:1506:b0:44c:d702:4e12 with SMTP id q6-20020a056a00150600b0044cd7024e12mr16723089pfu.54.1635146000165;
        Mon, 25 Oct 2021 00:13:20 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id j5sm3485597pjs.2.2021.10.25.00.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 00:13:19 -0700 (PDT)
Date:   Mon, 25 Oct 2021 16:13:14 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] counter/ti-eqep: implement over/underflow events
Message-ID: <YXZZCn9O4xSTHMx5@shinobu>
References: <20211017013343.3385923-1-david@lechnology.com>
 <20211017013343.3385923-2-david@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VE2Y86mnoSfYxMJy"
Content-Disposition: inline
In-Reply-To: <20211017013343.3385923-2-david@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--VE2Y86mnoSfYxMJy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 16, 2021 at 08:33:36PM -0500, David Lechner wrote:
> This adds support to the TI eQEP counter driver for subscribing to
> overflow and underflow events using the counter chrdev interface.
>=20
> Since this is the first event added, this involved adding an irq
> handler. Also, additional range checks had to be added to the ceiling
> attribute to avoid infinite interrupts.
>=20
> Signed-off-by: David Lechner <david@lechnology.com>

Hi David,

This looks functionally okay, but I have a couple minor comments inline.

> ---
>  drivers/counter/ti-eqep.c | 119 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 117 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index 09817c953f9a..b7c79435e127 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -7,6 +7,7 @@
> =20
>  #include <linux/bitops.h>
>  #include <linux/counter.h>
> +#include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> @@ -67,6 +68,44 @@
>  #define QEPCTL_UTE		BIT(1)
>  #define QEPCTL_WDE		BIT(0)
> =20
> +#define QEINT_UTO		BIT(11)
> +#define QEINT_IEL		BIT(10)
> +#define QEINT_SEL		BIT(9)
> +#define QEINT_PCM		BIT(8)
> +#define QEINT_PCR		BIT(7)
> +#define QEINT_PCO		BIT(6)
> +#define QEINT_PCU		BIT(5)
> +#define QEINT_WTO		BIT(4)
> +#define QEINT_QDC		BIT(3)
> +#define QEINT_PHE		BIT(2)
> +#define QEINT_PCE		BIT(1)
> +
> +#define QFLG_UTO		BIT(11)
> +#define QFLG_IEL		BIT(10)
> +#define QFLG_SEL		BIT(9)
> +#define QFLG_PCM		BIT(8)
> +#define QFLG_PCR		BIT(7)
> +#define QFLG_PCO		BIT(6)
> +#define QFLG_PCU		BIT(5)
> +#define QFLG_WTO		BIT(4)
> +#define QFLG_QDC		BIT(3)
> +#define QFLG_PHE		BIT(2)
> +#define QFLG_PCE		BIT(1)
> +#define QFLG_INT		BIT(0)
> +
> +#define QCLR_UTO		BIT(11)
> +#define QCLR_IEL		BIT(10)
> +#define QCLR_SEL		BIT(9)
> +#define QCLR_PCM		BIT(8)
> +#define QCLR_PCR		BIT(7)
> +#define QCLR_PCO		BIT(6)
> +#define QCLR_PCU		BIT(5)
> +#define QCLR_WTO		BIT(4)
> +#define QCLR_QDC		BIT(3)
> +#define QCLR_PHE		BIT(2)
> +#define QCLR_PCE		BIT(1)
> +#define QCLR_INT		BIT(0)
> +
>  /* EQEP Inputs */
>  enum {
>  	TI_EQEP_SIGNAL_QEPA,	/* QEPA/XCLK */
> @@ -233,12 +272,46 @@ static int ti_eqep_action_read(struct counter_devic=
e *counter,
>  	}
>  }
> =20
> +static int ti_eqep_events_configure(struct counter_device *counter)
> +{
> +	struct ti_eqep_cnt *priv =3D counter->priv;
> +	struct counter_event_node *event_node;
> +	u32 qeint =3D 0;
> +
> +	list_for_each_entry(event_node, &counter->events_list, l) {
> +		switch (event_node->event) {
> +		case COUNTER_EVENT_OVERFLOW:
> +			qeint |=3D QEINT_PCO;
> +			break;
> +		case COUNTER_EVENT_UNDERFLOW:
> +			qeint |=3D QEINT_PCU;
> +			break;
> +		}
> +	}
> +
> +	return regmap_write_bits(priv->regmap16, QEINT, ~0, qeint);
> +}
> +
> +static int ti_eqep_watch_validate(struct counter_device *counter,
> +				  const struct counter_watch *watch)
> +{
> +	switch (watch->event) {
> +	case COUNTER_EVENT_OVERFLOW:
> +	case COUNTER_EVENT_UNDERFLOW:
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static const struct counter_ops ti_eqep_counter_ops =3D {
>  	.count_read	=3D ti_eqep_count_read,
>  	.count_write	=3D ti_eqep_count_write,
>  	.function_read	=3D ti_eqep_function_read,
>  	.function_write	=3D ti_eqep_function_write,
>  	.action_read	=3D ti_eqep_action_read,
> +	.events_configure =3D ti_eqep_events_configure,
> +	.watch_validate	=3D ti_eqep_watch_validate,
>  };
> =20
>  static int ti_eqep_position_ceiling_read(struct counter_device *counter,
> @@ -260,11 +333,17 @@ static int ti_eqep_position_ceiling_write(struct co=
unter_device *counter,
>  					  u64 ceiling)
>  {
>  	struct ti_eqep_cnt *priv =3D counter->priv;
> +	u32 qposmax =3D ceiling;
> =20
> -	if (ceiling !=3D (u32)ceiling)
> +	/* ensure that value fits in 32-bit register */
> +	if (qposmax !=3D ceiling)
>  		return -ERANGE;
> =20
> -	regmap_write(priv->regmap32, QPOSMAX, ceiling);
> +	/* protect against infinite overflow interrupts */
> +	if (qposmax =3D=3D 0)
> +		return -EINVAL;

Would you be able to explain this scenario a bit further? My expectation
would be that an overflow event would only occur if the position
increased past the ceiling (i.e. increased to greater than 0). Of
course, running the device with a ceiling of 0 effectively guarantees
overflow eventss with every movement, but I would expect a stationary
device to sit with a position of 0 and thus no overflow events.

> +
> +	regmap_write(priv->regmap32, QPOSMAX, qposmax);
> =20
>  	return 0;
>  }
> @@ -349,6 +428,25 @@ static struct counter_count ti_eqep_counts[] =3D {
>  	},
>  };
> =20
> +static irqreturn_t ti_eqep_irq_handler(int irq, void *dev_id)
> +{
> +	struct ti_eqep_cnt *priv =3D dev_id;
> +	struct counter_device *counter =3D &priv->counter;
> +	u32 qflg;
> +
> +	regmap_read(priv->regmap16, QFLG, &qflg);
> +
> +	if (qflg & QFLG_PCO)
> +		counter_push_event(counter, COUNTER_EVENT_OVERFLOW, 0);
> +
> +	if (qflg & QFLG_PCU)
> +		counter_push_event(counter, COUNTER_EVENT_UNDERFLOW, 0);
> +
> +	regmap_set_bits(priv->regmap16, QCLR, ~0);

I agree with Jonathan here, it looks like this is unconditionally
clearing all interrupt flags but it's possible new ones could have
appear between the time after you read QFLG to here. Is it possible to
clear just the interrupt flags you've handled here instead of all?

William Breathitt Gray

> +
> +	return IRQ_HANDLED;
> +}
> +
>  static const struct regmap_config ti_eqep_regmap32_config =3D {
>  	.name =3D "32-bit",
>  	.reg_bits =3D 32,
> @@ -371,6 +469,7 @@ static int ti_eqep_probe(struct platform_device *pdev)
>  	struct ti_eqep_cnt *priv;
>  	void __iomem *base;
>  	int err;
> +	int irq;
> =20
>  	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> @@ -390,6 +489,15 @@ static int ti_eqep_probe(struct platform_device *pde=
v)
>  	if (IS_ERR(priv->regmap16))
>  		return PTR_ERR(priv->regmap16);
> =20
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	err =3D devm_request_threaded_irq(dev, irq, NULL, ti_eqep_irq_handler,
> +					IRQF_ONESHOT, dev_name(dev), priv);
> +	if (err < 0)
> +		return err;
> +
>  	priv->counter.name =3D dev_name(dev);
>  	priv->counter.parent =3D dev;
>  	priv->counter.ops =3D &ti_eqep_counter_ops;
> @@ -409,6 +517,13 @@ static int ti_eqep_probe(struct platform_device *pde=
v)
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);
> =20
> +	/*
> +	 * We can end up with an interupt infinite loop (interrupts triggered
> +	 * as soon as they are cleared) if we leave this at the default value
> +	 * of 0 and events are enabled.
> +	 */
> +	regmap_write(priv->regmap32, QPOSMAX, UINT_MAX);
> +
>  	err =3D counter_register(&priv->counter);
>  	if (err < 0) {
>  		pm_runtime_put_sync(dev);
> --=20
> 2.25.1
>=20

--VE2Y86mnoSfYxMJy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmF2WPoACgkQhvpINdm7
VJI+aQ/+KFEK9bDsRjvHxSP/kRlh8ke6YqbX+Za8GUFQ9UFhyXtVEuTFfkcQCgIj
z+PO/qBcdLRkElNT2tK4EvSCxfVm+aGa2XqIGRz6MwvED2YFlt1soXtSZNGTQkDS
R56aaLsgIe35XEoaKvd6WYPxnY+XNgNplDE8nzYxQUpONqcTWjJSBYNFxqLKaH6s
QV53u2IKhAcgfDHXB53x+z3+tDx+7q9b1wdr7yz6F7X43dEAycRND8Q00FHLtafk
+3dZ3MjvjGDcn0+OF2nlm9Xl1Zftaf8mGWTxszYbYrgJGE2otJ5ANn+D0NpLOvzQ
aXVoq44fbJhHn6QoZPEJOevdlwWs/muugT+9JaMRB3EDxCvyAEn7JKApJUDeRzyM
UbMjUlmkrwWqnAT4aut7dqiRh4SWB6Ajo41V6A2CFohEXtvxhCbZh8hFF+m84/+/
vH5xYncYG+6JEzbo8t8oKLhuVLMPMrboYG3iXG6JyKHCDKmQXwpKZLb9qStaPGVh
KXH+Kvdpvm3EpgiHpBZw++ztwrQJMvdx+qNcdANENEA1HLaRpaHOqIdhLdCM4t1l
yEGWCpCKEId4MmA16o1LvOZ/e1q+F4fvEGREzhBO4yjmL2An10VgIvLrU3CIHmhm
IwPHZPz2/WwNwCXK1dFycFquhGQbPSkpjHLgoqQ0T6mBpidGMGc=
=khc0
-----END PGP SIGNATURE-----

--VE2Y86mnoSfYxMJy--
