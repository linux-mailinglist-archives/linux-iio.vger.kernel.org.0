Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2132981DC
	for <lists+linux-iio@lfdr.de>; Sun, 25 Oct 2020 14:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416239AbgJYNSP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Oct 2020 09:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgJYNSO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Oct 2020 09:18:14 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C68FC0613CE;
        Sun, 25 Oct 2020 06:18:14 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id r7so5968034qkf.3;
        Sun, 25 Oct 2020 06:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MO3IwgFsTuuAQb69apcANcklu+gz2Tub8fis0XXwpSs=;
        b=LlUxpVS1OaD+CeUBXrHMQWS+9BXnKIfgj5wmrUKZT5pL+Y/rDiYUzqZN7mkbI83bDM
         pO12lEGNkAYK2ITrMnQPoJUxojGxCJM9uXUJjfOPGP3olHT8+ZfFhq4g9m1UO6WUqhRq
         skojFLE08/yUGaP9dAdnYgCVWLYuZe8/nOtl/fyM4ycl4dwkXroiB3VWnYfaZ2iO8QzM
         3zKdF4u3wMKG1JSAVnQRznN46F0cTTIU78q4NsUxbgBNYIaZ015R50+Vf1xQpeD+xbZB
         NnRqiHY8uCsBhaUymXn8u9VZZFwOpOsA+luVzJ6FQcKxSsfbG9R4CjzuB/kjYLN3l4L0
         fL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MO3IwgFsTuuAQb69apcANcklu+gz2Tub8fis0XXwpSs=;
        b=NH+SMx0MjYjy1NJztam1tW8rTbsb9zJMAdfJ/EDblrQxtrWxTQcdFXlfFuiYEEfpWS
         vw9+kRpxK4kA26KWRCnuro6ljMt7EDWvQUV+Zx96qTjc3idawzJBiDbvBB4G5qhXaVJ8
         KmibCSfvCemen/gsPc3AUQmOXp4cozNN7oWDhLQYMd3Xfn+0XI/b9n70BSfoOs8xdrff
         2gb4YK6yWnCRZuLW8aIzvXf9rj2h3W4x7LTNByHSdawQVrPLyp+5gAZA3uGiY5SakrLv
         JpjsgcUDL8gG71jgZivn7RG+FvqxNzgNzQSwqF4a4L8yN1Hsm6rTfgcGygcngBYINkxA
         sdpw==
X-Gm-Message-State: AOAM533Ykvekd+jeK9fsIFl0Zmwxaw4W92q71SPQBZ//fIVZ8btrNtT1
        ojZRapbRCc8lwVSyq4wLg/c=
X-Google-Smtp-Source: ABdhPJyXtkIjzFGKZ/fvA7asDRtn9qRjAGXlMjQJcK/CHKeVOyeYYuoPCcNoY09Y9eflMTPcCm3SuA==
X-Received: by 2002:a37:a407:: with SMTP id n7mr11745316qke.248.1603631893378;
        Sun, 25 Oct 2020 06:18:13 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id 19sm4563158qki.33.2020.10.25.06.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 06:18:12 -0700 (PDT)
Date:   Sun, 25 Oct 2020 09:18:09 -0400
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
Message-ID: <20201025131809.GB3458@shinobu>
References: <cover.1601170670.git.vilhelm.gray@gmail.com>
 <00be1fccc672c5207f3b04fe4cc09c29e22641f4.1601170670.git.vilhelm.gray@gmail.com>
 <cc1f7e4d-18d1-bc28-8ce3-e3edcd91bcab@lechnology.com>
 <20201018165822.GE231549@shinobu>
 <f2bac8b2-108d-fa4c-cb63-8ff85ce04d1f@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
In-Reply-To: <f2bac8b2-108d-fa4c-cb63-8ff85ce04d1f@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2020 at 11:06:42AM -0500, David Lechner wrote:
> On 10/18/20 11:58 AM, William Breathitt Gray wrote:
> > On Wed, Oct 14, 2020 at 05:40:44PM -0500, David Lechner wrote:
> >> On 9/26/20 9:18 PM, William Breathitt Gray wrote:
> >>> +static ssize_t counter_chrdev_read(struct file *filp, char __user *b=
uf,
> >>> +				   size_t len, loff_t *f_ps)
> >>> +{
> >>> +	struct counter_device *const counter =3D filp->private_data;
> >>> +	int err;
> >>> +	unsigned long flags;
> >>> +	unsigned int copied;
> >>> +
> >>> +	if (len < sizeof(struct counter_event))
> >>> +		return -EINVAL;
> >>> +
> >>> +	do {
> >>> +		if (kfifo_is_empty(&counter->events)) {
> >>> +			if (filp->f_flags & O_NONBLOCK)
> >>> +				return -EAGAIN;
> >>> +
> >>> +			err =3D wait_event_interruptible(counter->events_wait,
> >>> +					!kfifo_is_empty(&counter->events));
> >>> +			if (err)
> >>> +				return err;
> >>> +		}
> >>> +
> >>> +		raw_spin_lock_irqsave(&counter->events_lock, flags);
> >>> +		err =3D kfifo_to_user(&counter->events, buf, len, &copied);
> >>> +		raw_spin_unlock_irqrestore(&counter->events_lock, flags);
> >>> +		if (err)
> >>> +			return err;
> >>> +	} while (!copied);
> >>> +
> >>> +	return copied;
> >>> +}
> >>
> >> All other uses of kfifo_to_user() I saw use a mutex instead of spin
> >> lock. I don't see a reason for disabling interrupts here.
> >=20
> > The Counter character device interface is special in this case because
> > counter->events could be accessed from an interrupt context. This is
> > possible if counter_push_event() is called for an interrupt (as is the
> > case for the 104_quad_8 driver). In this case, we can't use mutex
> > because we can't sleep in an interrupt context, so our only option is to
> > use spin lock.
> >=20
>=20
>=20
> The way I understand it, locking is only needed for concurrent readers
> and locking between reader and writer is not needed.

You're right, it does say in the kfifo.h comments that with only one
concurrent reader and one current write, we don't need extra locking to
use these macros. Because we only have one kfifo_to_user() operating on
counter->events, does that mean we don't need locking at all here for
the counter_chrdev_read() function?

William Breathitt Gray

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl+VexEACgkQhvpINdm7
VJICoBAAw8HLhwVk1o7CRK0hVoeMc0fdPh59yHCvT33kbxnA92J0zxnjH+MuGVAJ
kOWu3CLQ1s0+qhTGMmSfGUUCODAsN9+2IE+it0LnW1cbHw0xw7MBK0vaIkyAKNG4
T3eWQCUYGEwDFWRqSvSCIUBJlAEQPVKcgyntEdgPASaWheL4Do/iGg6QvV3KRVb2
gnzdcQO5sgN+2YVVlhoB3KoeJRVTgskq+S/9b7tw3yDxtyxMCX8huiKXsm0jHMiZ
fX8pxf0ni/ht/RLcpTjX7r0n34aL8HU3Owfqkq8DGsYiQ5Jc8AdJ6OAI2hgPifpZ
NzwyeFfxAtohot+GZa5RsXewEK8M0kHxnO2MyaxUTrVNZ623p6aWm3h3gNiwpuFg
2V+mDCSTPN5y0q0Bg0k6n3c7cGWnItY9/UJnNJiUg8zinEzWfM5jwcM6LAOVj5pS
EEdlzXu6IFR+T16m7N2bdR1EcAyB95OFkFL0IX9oOLcXYRmWRHQIBiFoEJXitNYQ
X7ZXuKQmQpNoFP6kR4oRkvT/SQlt/jXJMw745PJKOgnQnOpV0dGYt8CMZnjI350k
WJzvTVmWLSq3xzuXzB7egNqDUzl3u3GZiYBU7PkzTRAmxM3ZcCcKbntbMwOshYZz
NKIcZpApO1tXWlSfm3A81N+heHtPlKFgxjHqxsQPbRaWzm1h5MU=
=jRkJ
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
