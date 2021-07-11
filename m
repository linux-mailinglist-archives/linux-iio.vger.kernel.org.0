Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565233C3B92
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jul 2021 12:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhGKKoG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Jul 2021 06:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbhGKKoE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Jul 2021 06:44:04 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73C7C0613E8;
        Sun, 11 Jul 2021 03:41:16 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id j190so3251695vkg.12;
        Sun, 11 Jul 2021 03:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uSIeU9Xrm6MFsRdcAvqJwzm/06Dgie5NAiMN24JshYA=;
        b=GnRCuYox65Nvn/yJKM14od1VNX/q+4m6AMt/tenIK+ZUPI8++wpi+DbjxZDoEJzo0X
         BQGPsSGSaD7qN4VRISd43VBjSjSGMigBBAXPrK/TEktC3ImYdgoieEJ3yge1We5qTFte
         6NYwTAJZQCz2Q0vQ74jFGz6XL2nc4pzIjuSvJ66JYpMmjaMnQrmaiI9dh1x6GUssCefj
         mM+CixforZsmC0Rzc91fRdUeiVqIU2FfVIkV1ax0iVds9dCz5Jg7fCzkOqtr9oPAgyJb
         T8BLzLqhzJZQR4q3yb1dmZG1d+9zQLYyKAdBfBAEd1BjcCDmBuzeyAZa+3QYHXnnjB0y
         v23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uSIeU9Xrm6MFsRdcAvqJwzm/06Dgie5NAiMN24JshYA=;
        b=btaKfKzvqIcmUvLP7PhBuq80+qzJaxSJ7f4hNJiJbzToLFEatpLR0lXAXcwyJxu+/r
         /X3Wy+ploA9nh5/mBisocsDZpcHzukV+A6VSz6lEERlFesPPd77p6AYX7NKd+czXSuPQ
         JNi1RS2qTZjZVkoG3g2idZD56tu67x9fVQ+ur1IrcX77OBWRXjkuaVrBx0L0sH5EFMmo
         S/6auu8GMBBdYzXsCslgSxnkdlNK5ff4/SFzEEkCBTEz6L7l+mxt+1O4/TStrcZwFHQh
         1NAnvgmTqoaBsw749WhWxEk7ntMcUeNfQxgWe1PZeTiRwNoXify/PHPSy8AAX/NwXfa8
         cPlQ==
X-Gm-Message-State: AOAM531ZSEEnrWWb8KTUQ+JGpq62aaLVkz6RZe4bT40WqjK4lr4uJbb0
        v57CM39IVn4wNP/DZfbRkPU=
X-Google-Smtp-Source: ABdhPJxZofoDN0krXK3CMRsXndP+JzoeJBdlb9RcGd843oJbomuw8VvoUx+xxCiXQGzxQiSENjZMzw==
X-Received: by 2002:a1f:1d94:: with SMTP id d142mr39857184vkd.6.1626000075861;
        Sun, 11 Jul 2021 03:41:15 -0700 (PDT)
Received: from shinobu ([193.27.12.133])
        by smtp.gmail.com with ESMTPSA id d184sm1570664vsd.34.2021.07.11.03.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 03:41:15 -0700 (PDT)
Date:   Sun, 11 Jul 2021 19:41:07 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     jic23@kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        kernel@pengutronix.de, a.fatoum@pengutronix.de,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com
Subject: Re: [PATCH v12 11/17] docs: counter: Document character device
 interface
Message-ID: <YOrKw04fw43AEeWQ@shinobu>
References: <cover.1625471640.git.vilhelm.gray@gmail.com>
 <186e7a1cd7dc822cc9290683b463c3e675959e1a.1625471640.git.vilhelm.gray@gmail.com>
 <10ae3615-1fe4-0dce-5aa6-e865de2655a7@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dVrT+04cp+VrrbAK"
Content-Disposition: inline
In-Reply-To: <10ae3615-1fe4-0dce-5aa6-e865de2655a7@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--dVrT+04cp+VrrbAK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 10, 2021 at 03:15:06PM -0500, David Lechner wrote:
> On 7/5/21 3:18 AM, William Breathitt Gray wrote:
> > This patch adds high-level documentation about the Counter subsystem
> > character device interface.
> >=20
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> >   Documentation/driver-api/generic-counter.rst  | 185 ++++++++++++++----
> >   .../userspace-api/ioctl/ioctl-number.rst      |   1 +
> >   2 files changed, 145 insertions(+), 41 deletions(-)
> >=20
> > diff --git a/Documentation/driver-api/generic-counter.rst b/Documentati=
on/driver-api/generic-counter.rst
> > index f6397218aa4c..62a702e7f994 100644
> > --- a/Documentation/driver-api/generic-counter.rst
> > +++ b/Documentation/driver-api/generic-counter.rst
>=20
>=20
> > +
> > +Counter Character Device
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > +
> > +Counter character device nodes are created under the ``/dev`` directory
> > +as ``counterX``, where ``X`` is the respective counter device id.
> > +Defines for the standard Counter data types are exposed via the
> > +userspace ``include/uapi/linux/counter.h`` file.
> > +
> > +Counter events
> > +--------------
> > +Counter device drivers can support Counter events by utilizing the
> > +``counter_push_event`` function::
> > +
> > +        void counter_push_event(struct counter_device *const counter, =
const u8 event,
> > +                                const u8 channel);
> > +
> > +The event id is specified by the ``event`` parameter; the event channel
> > +id is specified by the ``channel`` parameter. When this function is
> > +called, the Counter data associated with the respective event is
> > +gathered, and a ``struct counter_event`` is generated for each datum a=
nd
> > +pushed to userspace.
> > +
> > +Counter events can be configured by users to report various Counter
> > +data of interest. This can be conceptualized as a list of Counter
> > +component read calls to perform. For example::
>=20
> Won't the :: here make this appear as text instead of an HTML table?
>=20
> (might need to change ~~~ to --- [top line] and =3D=3D=3D [middle line])

Ack, I'll change this to an HTML table.

> > +
> > +        +~~~~~~~~~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~~~~~~~~~+
> > +        | COUNTER_EVENT_OVERFLOW | COUNTER_EVENT_INDEX    |
> > +        +~~~~~~~~~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~~~~~~~~~+
> > +        | Channel 0              | Channel 0              |
> > +        +------------------------+------------------------+
> > +        | * Count 0              | * Signal 0             |
> > +        | * Count 1              | * Signal 0 Extension 0 |
> > +        | * Signal 3             | * Extension 4          |
> > +        | * Count 4 Extension 2  +------------------------+
> > +        | * Signal 5 Extension 0 | Channel 1              |
> > +        |                        +------------------------+
> > +        |                        | * Signal 4             |
> > +        |                        | * Signal 4 Extension 0 |
> > +        |                        | * Count 7              |
> > +        +------------------------+------------------------+
> > +
> > +When ``counter_push_event(counter, COUNTER_EVENT_INDEX, 1)`` is called
> > +for example, it will go down the list for the ``COUNTER_EVENT_INDEX``
> > +event channel 1 and execute the read callbacks for Signal 4, Signal 4
> > +Extension 0, and Count 4 -- the data returned for each is pushed to a
> > +kfifo as a ``struct counter_event``, which userspace can retrieve via a
> > +standard read operation on the respective character device node.
> > +
> > +Userspace
> > +---------
> > +Userspace applications can configure Counter events via ioctl operatio=
ns
> > +on the Counter character device node. There following ioctl codes are
> > +supported and provided by the ``linux/counter.h`` userspace header fil=
e:
> > +
> > +* COUNTER_ADD_WATCH_IOCTL:
> > +  Queues a Counter watch for the specified event. The queued watches
> > +  will not be applied until ``COUNTER_ENABLE_EVENTS_IOCTL`` is called.
> > +
> > +* COUNTER_ENABLE_EVENTS_IOCTL:
> > +  Enables monitoring the events specified by the Counter watches that
> > +  were queued by ``COUNTER_ADD_WATCH_IOCTL``. If events are already
> > +  enabled, the new set of watches replaces the old one. Calling this
> > +  ioctl also has the effect of clearing the queue of watches added by
> > +  ``COUNTER_ADD_WATCH_IOCTL``.
> > +
> > +* COUNTER_DISABLE_EVENTS_IOCTL:
> > +  Stops monitoring the previously enabled events.
>=20
> I wouldn't mind seeing more of this documentation in the actual header
> file and just referenced here with :c:macro:`COUNTER_ADD_WATCH_IOCTL`

Ack.

> > +
> > +To configure events to gather Counter data, users first populate a
> > +``struct counter_watch`` with the relevant event id, event channel id,
> > +and the information for the desired Counter component from which to
> > +read, and then pass it via the ``COUNTER_ADD_WATCH_IOCTL`` ioctl
> > +command.
> > +
> > +Note that an event can be watched without gathering Counter data by
> > +setting the ``component.type`` member equal to
> > +``COUNTER_COMPONENT_NONE``. With this configuration the Counter
> > +character device will simply populate the event timestamps for those
> > +respective ``struct counter_event`` elements and ignore the component
> > +value.
>=20
> To make sure I am understanding this correctly, scope + parent
> determines this part of the path:
>=20
> 	/sys/.../counterX/<scope><parent>/<component>
>=20
> Or in the case that scope =3D=3D COUNTER_SCOPE_DEVICE then parent
> is not applicable:
>=20
> 	/sys/.../counterX/<component>

Yes, that understanding is correct.

> I suggested parent_id instead of parent earlier, but maybe
> scope_id would be a better name? (Or rename scope to parent_type?)

I can see the benefit of more specific naming, but perhaps the current
names are clear enough when they appear in the context of user code. It
becomes rather obvious in a snippet of code that `component.scope`
refers to the scope type of a component while `component.parent` refers
to the specific parent of the component; I don't think the more verbose
`scope_type`/`parent_type` or `scope_id`/`parent_id` namings really add
much benefit here.

I'm not entirely opposed to renaming this, so if other maintainers also
feel this is better renamed then I'll change it. If we do change the
naming, then remaing `scope` to `scope_type` and `parent` to `parent_id`
might be the way to go; "scope_id" seems strange to me because I
envision `scope` as a type rather than an identifiable component.

William Breathitt Gray

--dVrT+04cp+VrrbAK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmDqyrAACgkQhvpINdm7
VJKKIA/+Kmcau65hlY3YM9GQBi1Yb1yKwxEJd8EusAFH+ZKZqS7iq9PPNfdBSoSg
D19UlOjTHN+T735ZVtlxOgjW6gH9t7HLpVRx7bUp1F3BwhMY6alDoH/wfbHv5fDv
Vf76N2yZqW5oBMIsl5PoIveu74huWZG77dKy5drFUb1hOmh4jMRZOOx3zYR0C5Co
9NRy8vjJBijy3WuELG2UbPcgh9b/SFXDt4ffsZNOJjFpPYSpYNnuuzWLcN+N5bzm
6vA7OaYao0JDKzzaWBQMUbMzF5EDxD+GgYdrtzgw5BSq75lS7TC3D5F+K6UxVwU0
VL82mrUxFG5KGK6muZWMlF9SGPx+IowqLcKUb4ZtBJ4RBphIyjCEVLpBTb2McCKs
PRqsWpKJvDWdEvCoBObJJOL2LJnnNMdaAu3Y9jp5P1WDDm7MJGRPQ29/NBmm1lIb
LX/+hj68lZBSeCHykHeCi8YVqU0wKdx1ELE71UQUSmOo0Vw7tV8YWnPkZUza8CJY
jrTlHbc0a/Vp2bD/dxJ3cfP83n75SlKTgibf7eApW5EWjiW6DAz9ZNIPnbYXxTo6
FqAppe5ucHuUFt4r0S+0hHWRI6nLuT76/L+NiaBRo3LaMApbJs+W6ak3JweFW7mD
rpV2XzMTziXyWfy4F/CKk0ZDMyJuxduRcfc4Qktrf82lV+67EZI=
=02sW
-----END PGP SIGNATURE-----

--dVrT+04cp+VrrbAK--
