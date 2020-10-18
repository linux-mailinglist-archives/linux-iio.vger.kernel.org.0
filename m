Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5282917EF
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 16:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgJROuc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 10:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgJROuc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Oct 2020 10:50:32 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45D3C061755;
        Sun, 18 Oct 2020 07:50:31 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f21so5972024qko.5;
        Sun, 18 Oct 2020 07:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SAR/XwyrV6/GhmfSQONbkaQBYVb9H0s6Kue9beJBth4=;
        b=JTI2e5NAUd29QUk7IAO/UujFkW7VqQUT/vAvWxpuKmwxz9QQWfeEreCx6Zh4dz6Tr8
         IO91zoDvhoUooCbNxqcSEEoLCMPKQUKOM0bON1SBHoK7TQvzniBjAPYq3/kSAg/Ccy59
         7xtet0KPqZPk6qmuItKvRKc+qdkvQnZlWA9HwsOraTd1f9AJRJ6qoAqHMrU0Tz7GOkyp
         qkxYz4E9FXFeoME1aY1wglsMSh6Pp3BhH8KKUX+BIRcSxTvYz6R5W5QWh+RDon+1r7oM
         XaR1PZMATSGO7mWRGmoVcT1ROk9Rl1qAdwjxBL6eO1escGCdaaT+t/S/TDFGqq79OJNL
         +leQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SAR/XwyrV6/GhmfSQONbkaQBYVb9H0s6Kue9beJBth4=;
        b=NGSUDgoI5Vvh/xOLN2JqpobjdxaLKbQ9kmnYJXV6Geg73FplQCB1GG4BgxP53tdPSA
         lnYqrLRYyyV7JROdNB+g0G3mlL1QC1pvNreRFoMZ9sXZsUGg67ancaOzQsfH+wu0tOHF
         2BDpVeRADqejipRPOBMCa09t/engMjpQoa64X2U1H8zkBzvbvdF57h7uKdbnZf6kmmQ/
         P4U0KCyD3a1y5anY8eYzqcCsOJ3WsxsAbjItykAm0vD+2bj0KNlxS5BIwJg28GlYVWw0
         CjfNQWKd0RCmH/AdLesyLh5Halw+xqAOFOxrkSW6gwtkS/DGYOUCkH9d8hKbAhFRdt8n
         P5aA==
X-Gm-Message-State: AOAM533RV6pxJcCCZkEhQQdYjSptrhAJgQCY5mVJLh+mSHmM0gWbxO45
        30nk3RwhtIlvJTEWtIKBaCE=
X-Google-Smtp-Source: ABdhPJzrSY4sikkyntHRR72cF6xgM2PD32fOeKkMij2G1c4qQN3ccKlatHl+iLzl5vh5vkcodawv6g==
X-Received: by 2002:a37:2c03:: with SMTP id s3mr10548074qkh.91.1603032630993;
        Sun, 18 Oct 2020 07:50:30 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id w6sm3230710qkb.6.2020.10.18.07.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 07:50:30 -0700 (PDT)
Date:   Sun, 18 Oct 2020 10:50:25 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Subject: Re: [PATCH v5 5/5] counter: 104-quad-8: Add IRQ support for the
 ACCES 104-QUAD-8
Message-ID: <20201018145025.GC231549@shinobu>
References: <cover.1601170670.git.vilhelm.gray@gmail.com>
 <7a829fe8cba3ae222796328f832bd2546769e6ac.1601170670.git.vilhelm.gray@gmail.com>
 <a0e54a35-eed6-a938-dd4e-4f602d3b50c0@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline
In-Reply-To: <a0e54a35-eed6-a938-dd4e-4f602d3b50c0@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2020 at 07:13:32PM -0500, David Lechner wrote:
> On 9/26/20 9:18 PM, William Breathitt Gray wrote:
> > +static irqreturn_t quad8_irq_handler(int irq, void *quad8iio)
> > +{
> > +	struct quad8_iio *const priv =3D quad8iio;
> > +	const unsigned long base =3D priv->base;
> > +	unsigned long irq_status;
> > +	unsigned long channel;
> > +	u8 event;
> > +	int err;
> > +
> > +	irq_status =3D inb(base + QUAD8_REG_INTERRUPT_STATUS);
> > +	if (!irq_status)
> > +		return IRQ_NONE;
> > +
> > +	for_each_set_bit(channel, &irq_status, QUAD8_NUM_COUNTERS) {
> > +		switch (priv->irq_trigger[channel]) {
> > +		case 0:
> > +			event =3D COUNTER_EVENT_OVERFLOW;
> > +				break;
> > +		case 1:
> > +			event =3D COUNTER_EVENT_THRESHOLD;
> > +				break;
> > +		case 2:
> > +			event =3D COUNTER_EVENT_OVERFLOW_UNDERFLOW;
> > +				break;
> > +		case 3:
> > +			event =3D COUNTER_EVENT_INDEX;
> > +				break;
> > +		default:
> > +			/* We should never reach here */
> > +			return -EINVAL;
>=20
> This is not a valid return value for an IRQ handler. Maybe WARN_ONCE inst=
ead?

Ack.

> > +		}
> > +		err =3D counter_push_event(&priv->counter, event, channel);
> > +		if (err)
> > +			return err;
>=20
> Same here. Otherwise, I think we could end up with interrupts in an endle=
ss
> loop since the interrupt would never be cleared.

Good point, I'll change this and the one above.

William Breathitt Gray

> > +	}
> > +
> > +	/* Clear pending interrupts on device */
> > +	outb(QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC, base + QUAD8_REG_CHAN_OP);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
>=20

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl+MVjEACgkQhvpINdm7
VJJ/2g/9H84UNACWIgJbKmcgPdOuv42qHwZ0jla3LA3Sa/Le+jjyRPXhlC0po31D
Q02H/GXunXfanDa3dRcI+4wKobRonBxnD4qvQcv9PMY4KWIxiqRUzIToz6PG4Frl
U1lod6lMw7tmTBAov69D+faZv7q46UiuJ4fNpZjzhgy+Ut78SsR5x/FSM8W+y2Xe
VeWYX3MPk7xrVMDdwFZN8x8lCKUgwlDBIPgLW9SoGaoqJfXSa4EZejluUo8jztlz
yehC6XuGu0gkIvfWq2PTqAX8wciFoxv1xHZ0+4Rgyw+7qW3sXFT+rWGygxiyxAe6
qr1DJ9r9JkSLTNYuMkdn2g6jhoH98mrkSbhi5uwf34H5At874zqFI3tcgG8s05fO
drKQeA1WjVDp7TaEF1OfXfqKkuiKL0+YUB6fxQpZ53KvT2tRSSl/9A7z/JCkGyKX
8pSntpr1rI9ZR9dxzk6nblOoZX7KYO1K4hZ0Eby1E3YI/y7IrzAADYuB2t0MzVfn
qQMXT8LzKtaE/pIQk9IfnOevFFKhfchknxxtXW4I0ak6RlKuo7Ai7IPUeuQvukEK
pM63pZ41G5Y6uzefTecb+kg33cVMC2shKU2hRJYzL0o5z2CcQUAyCKuFuBM1k4LX
sxYRf3wetepvzBMF6YUzCpcR8fBQP/kuVR3PYd5sche8IpphpK0=
=xuQj
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
