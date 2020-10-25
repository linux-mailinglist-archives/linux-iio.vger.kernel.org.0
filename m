Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6474E2981BA
	for <lists+linux-iio@lfdr.de>; Sun, 25 Oct 2020 13:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416116AbgJYM4P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Oct 2020 08:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416117AbgJYM4P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Oct 2020 08:56:15 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B80C0613CE;
        Sun, 25 Oct 2020 05:56:14 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id x20so5938433qkn.1;
        Sun, 25 Oct 2020 05:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dW6wQtx+CemqlF8Wph1tzg0pja08Z9O004Vy7mx2JnA=;
        b=qI254pdSKPJ5rsI3UGK2qp/UfOvOsA+m62PqibOeP3UNFzbeGlY5CoCnZYqylATVlh
         NTuF9Jkoj5E4oNI2L1nIlFrVAHcHSEPueQj9KWc/8CBU3d6oL1zT+YtV8XrwpMqF8nEA
         l+j+3+BnjJZyHwPP+yui8ddYSM6tHDx70MzOFNvK99KZS7qxtZ9lCxzYzpg+of5b1s6i
         o0LOWC0qQcEos7RDkvP1C89ZSGwWuk7Y/22GekU4MjgxMpuyfuphjHQbIkuqWRgR5kXc
         5W5eB0eK0wU5hRsBz8LFFzj3w805PGfWxjHdvM4H9jcfq3ngNXqR4sUfpbv7shYIP6mX
         TUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dW6wQtx+CemqlF8Wph1tzg0pja08Z9O004Vy7mx2JnA=;
        b=c5siJA6s4slmpvJZjVMbIs34ZTaM7lq0cCycVOssDleOgSEVDDemFjW1dUF7LZuGWR
         yyyreJKb/gjj8QX3ipPhd3jKtnwhK9mvYuF9GVqTIDZd07INj1STqhtWgAv6arCNy7Dr
         BGGKl+lg4QnhQr/I79ODuyB5RlhvBJyTQ+6CY6nEVse0k80nTi/IR6JiVvfBz25cdTqH
         awJRnNK6alwEilvYr11BbadqOcC9RzMOM8kArf03rQIPY7KS9bPIi4k7m7sZkhtqu+FV
         MQRCQVoktUpn5KcwG/XfqTALtT1iGvEwPjdEeb19tq5nDQscWg92oG9GXe/ef7uyOiOv
         LcAw==
X-Gm-Message-State: AOAM530qJZoI84UUiAkMzi5nf2tah5A98Cv4Dlh8yp1yirfHD0yFT58T
        iYeU4qUQRtaqpMpiwX3v9e8=
X-Google-Smtp-Source: ABdhPJz84hctLYUYMFmsNSoipZYjD3+Zg11EwoNyVCHyT7SC4OtHb1h5TbW9oMPHx9yRFkAw5hdvVQ==
X-Received: by 2002:a05:620a:15c7:: with SMTP id o7mr12116691qkm.262.1603630573927;
        Sun, 25 Oct 2020 05:56:13 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id j25sm4583718qkk.124.2020.10.25.05.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 05:56:12 -0700 (PDT)
Date:   Sun, 25 Oct 2020 08:55:57 -0400
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
Message-ID: <20201025125557.GA3458@shinobu>
References: <cover.1601170670.git.vilhelm.gray@gmail.com>
 <00be1fccc672c5207f3b04fe4cc09c29e22641f4.1601170670.git.vilhelm.gray@gmail.com>
 <181eb08a-be0a-f7cc-259d-b2a0f279950b@lechnology.com>
 <20201018164905.GD231549@shinobu>
 <fe46666a-4b2f-31f4-b91d-50c33aba0e56@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <fe46666a-4b2f-31f4-b91d-50c33aba0e56@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2020 at 10:53:32AM -0500, David Lechner wrote:
> >>> +
> >>> +static int counter_chrdev_release(struct inode *inode, struct file *=
filp)
> >>> +{
> >>> +	struct counter_device *const counter =3D filp->private_data;
> >>> +	unsigned long flags;
> >>> +
> >>> +	put_device(&counter->dev);
> >>
> >> put_device() should be at the end of the function in case it is the la=
st
> >> reference.
> >=20
> > put_device() shouldn't affect the counter_device events members, so I
> > don't think there's a difference in this case if it's called at the
> > beginning or end of the counter_chrdev_release function.
> >=20
>=20
> It isn't possible the some memory allocated with devm_kalloc() could be
> be referenced after calling put_device() now or in the future?

You're right, if put_device() is called before then we could end up in a
garbage state where the device memory is released but events list has
not yet been freed. I'll move put_device() to after the events list is
freed then.

> >>> diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counte=
r-sysfs.c
> >>> index e66ed99dd5ea..cefef61f170d 100644
> >>> --- a/drivers/counter/counter-sysfs.c
> >>> +++ b/drivers/counter/counter-sysfs.c
> >>
> >>
> >> Not sure why sysfs changes are in the chrdev patch. Are these
> >> changes related somehow?
> >=20
> > Sorry, I forgot to explain this in the cover letter. The changes here
> > are only useful for the character device interface. These changes
> > introduce the extensionZ_name and extensionZ_width sysfs attributes.
> >=20
> > In the character device interface, extensions are selected by their id
> > number, and the value returned depends on the type of data. The new
> > sysfs attributes introduced here allow users to match the id of an
> > extension with its name, as well as the bit width of the value returned
> > so that the user knows whether to use the value_u8 or value_u64 union
> > member in struct counter_event.
> >=20
>=20
> Are we sure that all value types will always be CPU-endian unsigned
> integers? Or should we make an enum to describe the data type instead
> of just the width?

It should be safe to assume that the character device interface will
only ever return CPU-endian unsigned integers. The device driver should
handle the conversion of any strange endianness from the device before
the character device interface, while userspace is the one responsible
for interpreting the meaning of count in the context of the application.

Let's create a scenario for the sake of example. Suppose we want to use
a counter device to track the vertical position of a component moved by
a linear actuator. The operator considers some vertical position as the
horizon, where anything above would be a positive position and anything
below a negative position. The counter device stores its count in
big-endian format; but the system CPU expects little-endian.

The flow of data for this scenario would look like the following (where
BE =3D big-endian, LE =3D little-endian):

+----------+         +---------------+          +--------+
| Raw data | - BE -> | Device driver | -> LE -> | chrdev | - u64 ->
+----------+         +---------------+          +--------+

At this point, the userspace application would read the unsigned integer
=66rom the character device and determine how to interpret the position --
whether the count be converted to a signed value to represent a negative
physical position.

Whether or not a position should be considered negative is dependent on
the user application and context. Because the character device does not
know the context of the user application, it should only provide
unsigned integers in order to ensure a standard interface for counter
devices; userspace will be responsible for interpreting those counts to
something meaningful for the context of their applications.

William Breathitt Gray

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl+VddMACgkQhvpINdm7
VJL5EQ//cg58+imqX6jyWtytVNlM4xXCNghBQJ0b1YWtd+kNxWijJUuiCh6XQtS7
hIkDD6iXipyHCy6NAm2TQmLpMiiZGCZzBdeAEWpXU3ZeyTa0gmxKjuLLDg3ZoqS4
dt6zEHZVPvDExSPsISqIx+Uez4wypRgh2ExF/lMB9XDBWblvLgS7jt7Aqvqh41sa
XscbJjxqTFskoh2D/ka8WX4UXGuXh9kxmwuiXwDnMcu6ct3+H1lq1UZ6jbeWMcIQ
z+CteMRjZ4b0kZnz5XCxtEZ7HBc79bxkE3bN+LF7fdpSOa9DcoShWdWwqZB/UuOx
dhAiIiIo2sUyrHNJkfkOfh6yjGaQ7LXv2Q6aseoHS1h6119aflBUefJGvE6AhyG7
8MNdfuWf4V5H+ete24BTPduUynHfIdV5D9lA2V42p0CkLnVlfQ75SFutqt5aUlUV
mukprRWXGySjRg8D6WrKAqr6sY5WEqe8hxfxzFzbjXYrRo6ZgkSBWJx82b+KZOlt
xwWL+UiyezTiYe2Updyl37yKyJjzQ5Mfrpt44Z6GPzXmVecuJJC/gIBJW1o6bn39
/JgcFw0DObC7DQuqnf6sCIGT+6V3L5v6yr5pR83WtueeZ4jZAc2pDh+svn+rUv4x
BcTTdAs2HR9OYOD8QVDEAkonmtikk35m/G8j+mcAi91TmAE2pdo=
=NtZ8
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
