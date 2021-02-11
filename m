Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22468319738
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 00:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhBKX46 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Feb 2021 18:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhBKX44 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Feb 2021 18:56:56 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F5BC061574;
        Thu, 11 Feb 2021 15:56:16 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id b24so5525206qtp.13;
        Thu, 11 Feb 2021 15:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fn9ECLUi2tPSHi7X9/WE7UqWMZvrqWVcR0Z02vtxJFM=;
        b=REJNTNOWdXeu6f7LaWhf4cwIC55Mp0Qq8gBt7jCVoL6KCO1/EAgCoGXxCqBOqz0R7n
         ZGIOkeZwLsQiEcXJN2Mjl9w/ExaghyhnqMXFeteGj0ofoZc9cl0dBp/HPLIuA0aITzZp
         NhR175zCa86KTLhRczWqtxri9/wYrpL7n8PRcor6nF2/BlN7BPqG1ifNJnDSNEWI/NKw
         AWIfMLGk9ZbaEFUXj6jhTCoHD8zQ/Q+VyM53pYwVRHTpYUUOj72MMNQluSvV8JIif/HR
         FpWiVfomx1VKHmtNFqAOoClRumweAZLsUn4VsRl4Gt+VQkhkKM+F3FGHuexGnjTrdSGh
         PhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fn9ECLUi2tPSHi7X9/WE7UqWMZvrqWVcR0Z02vtxJFM=;
        b=GYIoy6v3bSIKFspHUmxWRK8cDzYk8hOE57I6xbVZzrIwftVQ49lJYE7la1VkPE0ss8
         MbUnV6/K+mdvpoC/p1JNWd+OQ/amdjdgYE2wKrPo70nBZO0JXRf4blwNnd4pONMkvNc0
         iw9IyriA2dmtbSdW1mWJ2z86b6MCb67NdVUlnJKCteOytZLhfJazS0t2ehUhWJbc2UL9
         sbwpGec0eLdVO5vnCDntp/6ELGtWXniyFvNyELGw3P2wXbNcuZdt+rDYF9F0DHkiUnOC
         SJhXLc+Ubz/wOBqZaEJnupdKScgPxsDQMhr4vmc/n2RtlUTLX3Dyz1nyT9MoWR96OW0q
         b61g==
X-Gm-Message-State: AOAM532wSxXBdtzkcdpWYCihelz1EfAGYcGxNfbXtIzoi8njS7CAGLcK
        H1ndlgNztXeME+KXbPWqlaI=
X-Google-Smtp-Source: ABdhPJyuiD3jKQsR4lp7R1jCbPxoM1hsEvSszFs2HWKuwJSZ2Og5Sp0UmJRyNNsX1qJjFZf+0wYnTg==
X-Received: by 2002:ac8:498e:: with SMTP id f14mr215580qtq.286.1613087775410;
        Thu, 11 Feb 2021 15:56:15 -0800 (PST)
Received: from shinobu ([193.27.12.132])
        by smtp.gmail.com with ESMTPSA id l66sm5143121qkd.21.2021.02.11.15.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 15:56:14 -0800 (PST)
Date:   Fri, 12 Feb 2021 08:56:04 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     jic23@kernel.org, kernel@pengutronix.de,
        linux-stm32@st-md-mailman.stormreply.com, a.fatoum@pengutronix.de,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Subject: Re: [PATCH v7 5/5] counter: 104-quad-8: Add IRQ support for the
 ACCES 104-QUAD-8
Message-ID: <YCXEFMJOoOhyhfBu@shinobu>
References: <cover.1608935587.git.vilhelm.gray@gmail.com>
 <bb2db54669ef27515da4d5f235c52e0b484b5820.1608935587.git.vilhelm.gray@gmail.com>
 <7a78ad95-9eba-277d-25da-ddf68357b969@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p7kKPpmXtdPwRZVn"
Content-Disposition: inline
In-Reply-To: <7a78ad95-9eba-277d-25da-ddf68357b969@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--p7kKPpmXtdPwRZVn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 30, 2020 at 11:36:45AM -0600, David Lechner wrote:
> On 12/25/20 6:15 PM, William Breathitt Gray wrote:
>=20
> > diff --git a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8 b/D=
ocumentation/ABI/testing/sysfs-bus-counter-104-quad-8
> > index eac32180c40d..0ecba24d43aa 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> > +++ b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> > @@ -1,3 +1,28 @@
> > +What:		/sys/bus/counter/devices/counterX/countY/irq_trigger
>=20
> Do we really need this sysfs attribute? Shouldn't interrupts be configured
> _only_ by the chrdev interface?

I think this attribute can go away because we can implicitly figure out
the correct IRQ configuration from the struct counter_watch data when a
user executes a COUNTER_ADD_WATCH_IOCTL ioctl command.

However, I need some help deciding on an appropriate behavior for
conflicting counter_watch configurations. Let me give some context
first.

The 104-QUAD-8 features 8 channels (essentially 8 independent physical
counters on the device). Each channel can independently issue an event,
but any particular channel can only be set to a single kind of event
(COUNTER_EVENT_INDEX, COUNTER_EVENT_OVERFLOW, etc.).

The purpose of the irq_trigger sysfs attribute I introduced in this
patch is to allow the user to select the event configuration they want
for a particular channel. We can theoretically figure this out
implicitly from the struct counter_watch request, so this sysfs
attribute may not be necessary.

However, how do we handle the case where a user executes two
COUNTER_ADD_WATCH_IOCTL ioctl commands for the same channel but with
different event selections? I'm considering three possible behaviors:

* Fail the second ioctl call; event selection of the first struct
  counter_watch takes precedence and thus second is incompatible.
* Issue a dev_warn() indicating that the second struct counter_watch
  event selection will now be the event configuration for that channel.
* Don't notify the user, just silently reconfigure for the second struct
  counter_watch event selection.

I'm suspecting the first behavior I listed here (ioctl returning failed)
is the most appropriate as a user is explicitly made known of this
particular device's inability to support more than one type of event per
channel.

What do you think?

William Breathitt Gray

--p7kKPpmXtdPwRZVn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmAlxAMACgkQhvpINdm7
VJJejBAAzJHKhvvQx5+lsNzKsvoLOZi+R4kk9Amkh2HH90O+UyagdXEHac++XOto
K9fWenvVvr9x4XVCxB62Z65YkRnQDNdWdrZ7WLNkk1L5a/RL7ePJiozsjuaWAXVQ
j6/uKv7ho45A5d5vQsdhdwBxfwNIRDQDqYqrLo8NYsl9ScBGQ1Wq1cYDWKG1HGuJ
Is72OgyL3Mf2U5JSHIv/jk5Ox9YMLnJwr8XSQCZKldS42ieddRxd7vyxYJ4ePr9m
Z/jhjczp0TVuXw7Ika0G1IreRwEfxWHqNJ9mtqFRbRzxLblcHqmMLcrNG4AUIMWN
doEozsnwAIldaAxDljw2f6ZPQ7b8hd0PK8bieb901oNvEFf7kv8G1cOwfsuHvzYs
GH/08NBtwvAk0RFiNQhrm6OowZmgUO2KAjWr9PQdXXOjit+1mgsvW1BdBEjO0i3D
DPDkb+I+ZrnB5VeRxqudTGakFmuE6YXGM2ubxtSx1otNi7TdZKJhsEUU9JzUkf1J
/BmOikFg/8yv/YoodDqCzymjOgxqUWSriQSIretaHz+rQR3/PD5xbqVnTe3pMUiR
LRUVcwil/5DIZV0NdHqzbip3DK2OIzoQjHp2sIH+evT5Z0XtWiSgiZAs1lX9vuT3
5KpsAcytNu5TUzaXnMZ9tAzAWZ3X0TQk4zc9KD+U3XdymZz97ys=
=O8ar
-----END PGP SIGNATURE-----

--p7kKPpmXtdPwRZVn--
