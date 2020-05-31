Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695691E97D6
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 15:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgEaNcD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 09:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbgEaNcC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 May 2020 09:32:02 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AC3C061A0E;
        Sun, 31 May 2020 06:32:02 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w3so6658228qkb.6;
        Sun, 31 May 2020 06:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7mjQPFZLDY3zOJxS6K+hwBYDZ7ogeoyTkdPn+NbadQA=;
        b=OvQUeyLfMwrvAin4ZW+rJVAV3Brt0cXRGFYFkbwhjGFNAlulLUWx2u+XlDicCYbIIv
         cngSvARYr/W1RWxz62Nu9/fYPz98+YYIE53Mv5wST7j3b2/BZ+Ck8mzn/gm3kX/kiIjA
         fAg42ScpwGAu2VBrl+wgSz0uMRL2n4sMzy7Peq2EXcpiI5HB2Cz5TRdsCHZmpxEQrbaM
         2hffWRCVFTk9uMmbVPUtjrifiAiqSS0uiWVBuJWkpUpP2QcBBHBKVdp+9FZbIqMo9v8k
         i1wOJg8tK0Q6N7B/MBkUAO30R4AE8SPalg+BkZoLrEosrQxINBJg49zXwiwBVsqLoOiF
         QIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7mjQPFZLDY3zOJxS6K+hwBYDZ7ogeoyTkdPn+NbadQA=;
        b=UHkDNI0fzpUUUeYWzjR6msjvFaMIt4duXX8dho2Nm+s57wPoIIgWdUK8EarGtXYjRn
         XfvrQxDlOlOC1WrlXBZR1Fuw0Pqc0q1Bvl6Pl05t4bo5Sqtdpna3oI2OXwPp6FdORyrv
         ZLHXJCVj4TJGlADRhDsfNHY4+AUIvaUtfso5SVtNTX7jIRpymFzWpk0hdQoaacdfqXw8
         ttfPNfJZpkuK1EggB68bTz6O320guwmXFz1cc14iIddMyY0o4FnVU9QskX7rAxdyPMyR
         zUSg5LdpM2sl3iX+8eSnCJ5J3OKhx5qmIWdm/8AJzpP7f/YS7mxQvNxnkAqSOWCkAm9a
         Peaw==
X-Gm-Message-State: AOAM5334ZwMFcbucFp/aMtnIXeBqIsiMoUsx9IcQygfkC8WJ4wb3vhrD
        cK4JHJw5yAoN0ikEJonrsVs=
X-Google-Smtp-Source: ABdhPJyLqWvBTi+Blweff9xoUoSmEYagIdQTmznRqhCCEj/Zz7hVlATzQXnLTG1Q06c2kaU18tdn4w==
X-Received: by 2002:a05:620a:1f6:: with SMTP id x22mr15510121qkn.199.1590931921668;
        Sun, 31 May 2020 06:32:01 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id q187sm11366164qka.34.2020.05.31.06.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 06:32:00 -0700 (PDT)
Date:   Sun, 31 May 2020 09:31:47 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, david@lechnology.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Subject: Re: [PATCH v2 4/4] docs: counter: Document character device interface
Message-ID: <20200531133131.GA6725@shinobu>
References: <cover.1589654470.git.vilhelm.gray@gmail.com>
 <db0a9206d31c82f8381316ef5ff9872bfb53665b.1589654470.git.vilhelm.gray@gmail.com>
 <20200529132604.GB1339@bug>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <20200529132604.GB1339@bug>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2020 at 03:26:04PM +0200, Pavel Machek wrote:
> On Sat 2020-05-16 15:20:02, William Breathitt Gray wrote:
> > This patch adds high-level documentation about the Counter subsystem
> > character device interface.
> >=20
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> >  Documentation/driver-api/generic-counter.rst | 112 +++++++++++++------
> >  1 file changed, 76 insertions(+), 36 deletions(-)
> >=20
> > diff --git a/Documentation/driver-api/generic-counter.rst b/Documentati=
on/driver-api/generic-counter.rst
> > index 8f85c30dea0b..58045b33b576 100644
> > --- a/Documentation/driver-api/generic-counter.rst
> > +++ b/Documentation/driver-api/generic-counter.rst
>=20
> > +
> > +Counter chrdev
> > +--------------
> > +Translates counter data to the standard Counter character device; data
> > +is transferred via standard character device read/write calls.
> > +
> > +Sysfs Interface
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Several sysfs attributes are generated by the Generic Counter interfac=
e,
> > +and reside under the `/sys/bus/counter/devices/counterX` directory,
> > +where `X` is to the respective counter device id. Please see
> > +Documentation/ABI/testing/sysfs-bus-counter for detailed information on
> > +each Generic Counter interface sysfs attribute.
> > +
> > +Through these sysfs attributes, programs and scripts may interact with
> > +the Generic Counter paradigm Counts, Signals, and Synapses of respecti=
ve
> > +counter devices.
> > +
> > +Counter Character Device
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > +
> > +Counter character device nodes are created under the `/dev` directory =
as
> > +`counterX`, where `X` is the respective counter device id. Defines for
> > +the standard Counter data types are exposed via the userspace
> > +`include/uapi/linux/counter-types.h` file.
> > +
> > +The first 196095 bytes of the character device serve as a control
> > +selection area where control exposure of desired Counter components and
> > +extensions may be selected. Each byte serves as a boolean selection
> > +indicator for a respective Counter component or extension. The format =
of
> > +this area is as follows:
> > +
> > +* For each device extension, a byte is required.
> > +* For each Signal, a byte is reserved for the Signal component, and a
> > +  byte is reserved for each Signal extension.
> > +* For each Count, a byte is reserved for the Count component, a byte is
> > +  reserved for the count function, a byte is reserved for each Synapse
> > +  action, and byte is reserved for each Count extension.
> > +
> > +The selected Counter components and extensions may then be interfaced
> > +after the first 196095 bytes via standard character device read/write
> > +operations. The number of bytes available for each component or
> > +extension is dependent on their respective data type: u8 will have 1
> > +byte available, u64 will have 8 bytes available, strings will have 64
> > +bytes available, etc.
>=20
> This looks like very, very strange interface, and not described in detail
> required to understand it.
>=20
> Could you take a look at input subsystem, /dev/input/event0? Perhaps it i=
s=20
> directly usable, and if not something similar should probably be acceptab=
le.
>=20
> Best regards,
> 									Pavel

Yes, I don't think this is a good interface afterall. I'm implementing a
different design for v3 that should be more intuitive. The input
subsystem could be useful for streams of events such as timestamps, so
I'll take a look at it as well in case something similar to it could be
used.

William Breathitt Gray

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl7TscMACgkQhvpINdm7
VJLU9hAAjZE3eFls1/dM0bpj9fivaZE+WCka2FakUqh0/3e48BVKe4lgLXBKxvBV
EYJrNH9fastmhGjWwI2JU9nVaTMUMeDZMtQFX6WccLR6wbZbncR6eDv/N2sn0VNB
jqQ+QdidLI+0tHJIVhQCzgEE0G6J6OMlUI1XkolNQVFKc2AWyxVFOKYcXWVlOaJF
5RuNDd067JuwqUncPfnInAMsI/5310+8UTEDza3twfjg61EI5wzU/PB7CzeE5rpz
uXex2BiRUcR/QQiNP1KjhrIyawQkBGhx4LKcqFGlx5QTwec/Jg7NmjyWEnSsboZg
AnHu1w+b2UbsHhWWRSHDWB1m7qM+zKhDYTYVOr5d0u0qgvitqeOsOaux34/tNMTT
cc4PTlf5zZFozDvTsilbLhNf5OhkIp5emAVCG5lXF4i0r7Q/jcRI0ScHZ3BSmL1p
unxD66ZbwtxHej5HJWAdZ1VPGr0gjWL29q+cxK3B7RqOUgl5ZwYnKgUaqbJAOM6Q
2K8z+BqLVH975M33jnPm0PSRyCxLfYPN+vKcEgw/ly3Z/3b3LYePtsuxc7bo8kVA
7uNPKFaSp2VW1XCaAd0hqBx3/q/LZEQjaPGVFtWkrMpv/vnsJVWSPAoJO9+9T/zS
HZ5TugHnAaPTVx7eo+0u7rzLOVv2wS5v0G0MU4KMwiN85Ws1Umo=
=ca5o
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
