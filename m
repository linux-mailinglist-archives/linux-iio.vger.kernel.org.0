Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A013309229
	for <lists+linux-iio@lfdr.de>; Sat, 30 Jan 2021 06:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbhA3FXn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Jan 2021 00:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbhA3FQY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jan 2021 00:16:24 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4036BC06174A;
        Fri, 29 Jan 2021 21:15:41 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id o20so7562547pfu.0;
        Fri, 29 Jan 2021 21:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DajhKcQbvSudZ+FOJNrz2aW0zOcE1tiQUOXaXnxB8PI=;
        b=A2wpAIaWTg4pDD9bNSTe4FEpzxuaqCYRaCVihvKx9wk4a53sZUM30exdllaZC+58wB
         DcS/Eju4Mj+AWigJelaiXevcBUWJgdFgRGpphd01ISsYAwKghf1M6aksu+BlnwN6eX8w
         2LctfS3dvly0L7a/zRbjYVfOCKG0X2vW3nIh5bYs0+u4Y4OZ6ZoeUJaKj9qOUh7XeBoL
         RsILgZWUtTyoktjsIFoSGaxIv5MTTFaN4KJSZe5FBaZV5hTghnl1KrHqz1cmWfdOB+EH
         +x1t/hUWbaWdRZGKDmXZMXVrYhScbRb2bbsA1he8ykO28gGC1Dn0efZe94Q/Xan9wJEq
         elPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DajhKcQbvSudZ+FOJNrz2aW0zOcE1tiQUOXaXnxB8PI=;
        b=b/e4jLpodm4lg8QlXMewuFFDiCGVqTQKbSfFe1Z5wRBpoz87HiZcuydxYPyW7ZVnmf
         /MR7O+9tGFnCLq+u4hCmynGPzeNM73rKSTgjGHKk3b0wPs5PiOfMQDp7msXL/WoTHCyY
         7ZUqemvP4Wqq4sjOTHyGNWTUb9U242ceHle7xrMKUPn6zIbhoZrMFGTUvxZt8t4nDeMx
         HNVZLfma9uzH/Qs+usErZROUgqXCxMe29E5oZfZugZahEZWg/tBB6TYprR9zAKPY4c7u
         OrT2VIssjRQVMJzCi/HF6jr2mmLsNgM9CvfIYSQ3ldRNw92qtQkfvCRMkjspN9pDVrwh
         WKmw==
X-Gm-Message-State: AOAM531iNEiYYDuGjw03qx/yChFrUSRoMvewi0CR+wCcF8ve3yMfV/OR
        i4tWcEZI4kiVoDFKGjaw/lg=
X-Google-Smtp-Source: ABdhPJz3xXOhtRoebqWMcQVAVlzvOHOj3KQTzng9Dt2tFdWx6XxcAnUKxQc98am3f2V4rV+jkl4rog==
X-Received: by 2002:a65:62cd:: with SMTP id m13mr7931884pgv.108.1611983740662;
        Fri, 29 Jan 2021 21:15:40 -0800 (PST)
Received: from shinobu (113x33x126x33.ap113.ftth.ucom.ne.jp. [113.33.126.33])
        by smtp.gmail.com with ESMTPSA id v8sm10269068pfn.114.2021.01.29.21.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 21:15:39 -0800 (PST)
Date:   Sat, 30 Jan 2021 14:15:29 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        a.fatoum@pengutronix.de, david@lechnology.com,
        linux-iio@vger.kernel.org, patrick.havelange@essensium.com,
        alexandre.belloni@bootlin.com, mcoquelin.stm32@gmail.com,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel@pengutronix.de, fabrice.gasnier@st.com,
        syednwaris@gmail.com, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, alexandre.torgue@st.com
Subject: Re: [PATCH v7 3/5] counter: Add character device interface
Message-ID: <YBTrcYgbXfKYaQnX@shinobu>
References: <cover.1608935587.git.vilhelm.gray@gmail.com>
 <57bc509273bf288d74835e6ebdaebf27b4991888.1608935587.git.vilhelm.gray@gmail.com>
 <20210128090113.GA8734@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mYrx736tSU4e+spo"
Content-Disposition: inline
In-Reply-To: <20210128090113.GA8734@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--mYrx736tSU4e+spo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 28, 2021 at 10:01:13AM +0100, Oleksij Rempel wrote:
> Hello William,
>=20
>=20
> On Fri, Dec 25, 2020 at 07:15:36PM -0500, William Breathitt Gray wrote:
> > This patch introduces a character device interface for the Counter
> > subsystem. Device data is exposed through standard character device read
> > operations. Device data is gathered when a Counter event is pushed by
> > the respective Counter device driver. Configuration is handled via ioctl
> > operations on the respective Counter character device node.
> >=20
> > Cc: David Lechner <david@lechnology.com>
> > Cc: Gwendal Grignou <gwendal@chromium.org>
> > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> ...
> > +struct counter_event {
> > +	__aligned_u64 timestamp;
> > +	__aligned_u64 value;
> > +	struct counter_watch watch;
> > +	__u8 errno;
>=20
> This variable clashed in user space, as soon as you include errno.h,
> with the libc's "magic" definition of errno. What about "err" instead.
> I'm not sure it an __u8 is the proper type, IIRC usually it's an int.
>=20
> Regards,
> Oleksij
> --=20
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

Sure, I can rename this to avoid a possible clash with libc's errno.
Maybe "status" would be more apt to indicate that this is an exit status
for the event -- the code returned may simply be a warning and not
necessarily a critical error.

Regarding the datatype for this value, I've opened up the discussion in
my reply to David Lechner [1], so perhaps we can continue it there.

[1] https://lkml.org/lkml/2021/1/30/5

William Breathitt Gray

--mYrx736tSU4e+spo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmAU63EACgkQhvpINdm7
VJLsxRAAhlCPUhj65vzfuqQStMkmCoKCekEBmx0CS9yJR2Ilrcqm0yvEZdq5q/c4
/FjnucZRerDshexfeRaaDg4h8guEXzp8YcmM74NTEn8tpsvwNVFWFcbwbePlvHTt
VtU6qRRN8Bu50wVwdqchRiMuJA9jcAR/5YcfGslq7bxGcvEhQgNvlrjI+NG9tNUU
smKjjeqBW1AMMFs7CQ4i2QwNA+Vdfy3/Fun9Qsx41zMHAV8/c7UVbIBF3XsqdJHl
AAphNutr43FIjqrvb3MMVrk06sQ0f8SjEjypX6jODB0dzug5JDtnt1/MdvBO5gSN
e6/QLq4wgz8Rvl6YECPFBZvt9Bk31tmPWsUg6JQduASolLoM7kCW4XDIGzeHBEiT
ESipbOGVVeM3WQlON5+bf9li7ARIPEFajcOViw1R8LbASwSXv1MOuDoLHHHfVRg4
kVFJCD0K/g635AkOHB/Nve9ju0x15u7aJOibOzU6YyyuY+kkj1Yir8QMYf2IBUvA
CMHkZwxt2uSIFvjVdXrOFuHCoqQnRSIL+USgBk3T/NtCMrGDaPd2RDEE0VL2+O0Z
T2Dwuzzd1QnCYrZWQFgjaPOgUIPYf1sRWUpkr4s1//RQN+kLCEepauTHgApP9+4m
7peK1qgaGSNZYjq7lcdzv8J410JU6D9ZgIGe3BpUhLqGGBDHQcE=
=9dBE
-----END PGP SIGNATURE-----

--mYrx736tSU4e+spo--
