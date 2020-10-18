Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F8229186E
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 18:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbgJRQ62 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 12:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgJRQ62 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Oct 2020 12:58:28 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9805FC061755;
        Sun, 18 Oct 2020 09:58:26 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id bl9so3335742qvb.10;
        Sun, 18 Oct 2020 09:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HJanRkOnYDRWWUUxMT+SX3xeE/WoWNZDclqoOIIZ6ik=;
        b=fvbVbd6bP0z7Vuuq+jqTEeUxxfKwXFaectxEGgR9FBXrWbQRPTqxDDp12hv7pyjgny
         pVkvJW2CkducvZ6zcT1Qg0RHQcsGRQ0FhijtX46wCeavXfhFRtyCnOyLjRs5MWQ9WPvQ
         gg5G9PlVyumf0QRB680kMp51sPQ6IHY4uqL2GYT6DCGRgnVz0RzxExcK+XR6LftDCd0U
         YJFevQR8R/XSy5mGZ+5t5z5pBJ23cZlNqC/oAw11/HkRs75AFqDH8WxVaKZqsErwqASc
         TwBvFGoV/fp1AX7pspMG1+psZXZFyGFkHafZmjY71NNHWOOGsyPr7xn5psISVrrjxveJ
         xJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HJanRkOnYDRWWUUxMT+SX3xeE/WoWNZDclqoOIIZ6ik=;
        b=KkeL16JvAWgNQz/O1gSP1XpmVEgy0FFvZnItUKW/deP/cjjcDVnm6F4tV3/hAhLWAA
         XwF8owc4JVaFCA2gNU4DmoIuL82/DLlbpdpW5Mt0cy/mFBG3gf8jvkEPbvTf3GKoW8fI
         O9D7ronkDIQLJvBiw+Ih4BNLs3DlR6ryqnCHhDk5rpqJ3Tvj5wGSccSj60Q0GrTiQ0oN
         iZoZmg7gFJ1w1mCtboZy61xJS5ic48Nld7LtBAjs41kwifb+nxcJmbyM7gRUWYCLyxiM
         MqyDMxhuvyCmQrQNjro7pHyjDx8CTJKwTWgq7PjWiKtxfIEO+AYpLe5meJdh+aveCJhl
         aAXA==
X-Gm-Message-State: AOAM533e00KbM4hct28OjdnNISKAwy3dRqQWYSPFLCtyM+5nX3NfgyC+
        yeFarqDhCEwAiba5wGHKM/jSolv/pXUoGg==
X-Google-Smtp-Source: ABdhPJxjcZwbX9ypE+uUB13PJDlMX4ZiI7bkB4E/9sDUMmaq7Hljo6yZcmPmqM5wbZ5FOb82iKUy0w==
X-Received: by 2002:ad4:43e5:: with SMTP id f5mr13696233qvu.12.1603040305761;
        Sun, 18 Oct 2020 09:58:25 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id g5sm3325325qto.39.2020.10.18.09.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 09:58:24 -0700 (PDT)
Date:   Sun, 18 Oct 2020 12:58:22 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Subject: Re: [PATCH v5 3/5] counter: Add character device interface
Message-ID: <20201018165822.GE231549@shinobu>
References: <cover.1601170670.git.vilhelm.gray@gmail.com>
 <00be1fccc672c5207f3b04fe4cc09c29e22641f4.1601170670.git.vilhelm.gray@gmail.com>
 <cc1f7e4d-18d1-bc28-8ce3-e3edcd91bcab@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="idY8LE8SD6/8DnRI"
Content-Disposition: inline
In-Reply-To: <cc1f7e4d-18d1-bc28-8ce3-e3edcd91bcab@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--idY8LE8SD6/8DnRI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2020 at 05:40:44PM -0500, David Lechner wrote:
> On 9/26/20 9:18 PM, William Breathitt Gray wrote:
> > +static ssize_t counter_chrdev_read(struct file *filp, char __user *buf,
> > +				   size_t len, loff_t *f_ps)
> > +{
> > +	struct counter_device *const counter =3D filp->private_data;
> > +	int err;
> > +	unsigned long flags;
> > +	unsigned int copied;
> > +
> > +	if (len < sizeof(struct counter_event))
> > +		return -EINVAL;
> > +
> > +	do {
> > +		if (kfifo_is_empty(&counter->events)) {
> > +			if (filp->f_flags & O_NONBLOCK)
> > +				return -EAGAIN;
> > +
> > +			err =3D wait_event_interruptible(counter->events_wait,
> > +					!kfifo_is_empty(&counter->events));
> > +			if (err)
> > +				return err;
> > +		}
> > +
> > +		raw_spin_lock_irqsave(&counter->events_lock, flags);
> > +		err =3D kfifo_to_user(&counter->events, buf, len, &copied);
> > +		raw_spin_unlock_irqrestore(&counter->events_lock, flags);
> > +		if (err)
> > +			return err;
> > +	} while (!copied);
> > +
> > +	return copied;
> > +}
>=20
> All other uses of kfifo_to_user() I saw use a mutex instead of spin
> lock. I don't see a reason for disabling interrupts here.

The Counter character device interface is special in this case because
counter->events could be accessed from an interrupt context. This is
possible if counter_push_event() is called for an interrupt (as is the
case for the 104_quad_8 driver). In this case, we can't use mutex
because we can't sleep in an interrupt context, so our only option is to
use spin lock.

William Breathitt Gray

--idY8LE8SD6/8DnRI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl+MdC4ACgkQhvpINdm7
VJKtZA/+NKz/zDPUYG1k3eRF+qrTFSszN6ZaQVFDVW2dNUUxCvZtcCZ8x2hZx/n9
1hWhczCgYYpeYM6ahWC+JRwebm1vUqc/U3KbKRXVpJVg4dot5+A9jqiXtevPA99D
RctZMaJLJ/1UGh2R4Pkiew5YtStfcqMlblDrIBCZiwCEY5mIs+6kR0CgaQUwG/sx
M777scU4ixIM+o5m6XJoLkgh9Lv89KnESESl/XBBYXfcN7zYBXtEcmf4ixQhuO+Y
ehpfmgpCcuBhrOVYjqzDN4h+dopSUVpI8QzTTe9Rpu8FgpoONnPm9O5cpD2rFvlL
AVCEi9U+OCkiWvh5WozChmBVSkvnzRgQe6y2silU47bGfFumj9LSgb/QMLKNCXpz
VgI4psvFiUPq17+PMXeNUH3+1v5FEaVjOQ1gBgl1Er9KPP2u9ixifrTkkssBzFAI
luF4Z0nsEkK+ezF5oDT1IlSIZILChd8Lb2IGkXSebNQ/SQ2bAom+QNd8Spo1tIJR
C2inE32wpPyUniISW+Hl6rxjM/uUKYiUh6WPjYx98u4tCrcHkBtZ5N3Pq59HrS5s
tD6kyEScmGR+R/x6uvkdkgxSRSScFItkDFI8fo6765W3Fb7GAK9B8Clt//SMxgct
NJDo7dKl/bsALJyLe2s/bHJNteD0o5S0jlU8fedIrB819/lqF54=
=oUCr
-----END PGP SIGNATURE-----

--idY8LE8SD6/8DnRI--
