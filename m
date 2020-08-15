Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF2E24526F
	for <lists+linux-iio@lfdr.de>; Sat, 15 Aug 2020 23:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgHOVvE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Aug 2020 17:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbgHOVuy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Aug 2020 17:50:54 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBCCC0F26D2;
        Sat, 15 Aug 2020 10:24:04 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id d14so11255957qke.13;
        Sat, 15 Aug 2020 10:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HnO8ySn99wiYKJRBKH7R7CHnt3CnVqgZ16aaVTDsdIA=;
        b=hBc8Pa8i6phyMNbFEwe0sfNgfeDIHRCp5rmIjFYiqXNa9wBqrjfeak4WYgrnUvuBch
         N5h4olykSIfetVAon7mSgJQZYnLxRlnyGyDOwtxLWaTnNueQgSsj9c9NfgQftRz86UhD
         l6suIlC3XuEtUnJhysXLbP4tn6bWSO60vts9Kg62LK6/tA9GACUBFGlcX8JdxW644vM/
         qc1sJ3WHVdep7IFPNx1d8euT2h44O4Q+IYZIJ7Wgld/lHi85wSuZCTcA+XDwO4WWTQVs
         wU8izH9xtZO0lQl8RcE7H1UW7dkHPY1nXIOF8oH31lWND5T8aodSrCW82lFQ/sGLTFf5
         IcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HnO8ySn99wiYKJRBKH7R7CHnt3CnVqgZ16aaVTDsdIA=;
        b=T7/ksaxMEScOchvVmCkS/nzlfT0q+kXQOINIreo464skbf2DDtP2bvGTPZuy4Lqp1K
         cbCwzNUkFnEVmRpDBw7E/ldnGYn+rfKWc/FlbQNdK3/xf7ls5AiHZ14vDiICVQf14q9+
         dErVwLjiq7bOLig6+VVtiFU35L+//Y7m5OQUTny7qEyy95dVLY32K4MgzwMVcC512gUN
         RPxdeesHH+7fgBj2+eVGZJdDQYyPgyHrXvNXzlbrbWe9xp9gqaBgKw5m9ggotGijUlUG
         Fb6NXlmmQw0YAtFnYGIPd8VhPOgWiEfZwKXvO2zvnKIIYj3KmsT9PXnDiAAFnJr18Chm
         0GoQ==
X-Gm-Message-State: AOAM532yD6Ewg54sfn5Tk4grtCdWo2O0+ny3OJRK4Xlb5Il5/3ucM8SO
        0sj+E03BbPkyrdTPasv2jZY=
X-Google-Smtp-Source: ABdhPJxLrKfqc2+Hxa1KySAQMZCRflp9mpZXqdRviGeYaFZnTwwALF9S79Q6jzehxEz0ugE5cIu6ug==
X-Received: by 2002:a37:6703:: with SMTP id b3mr6562187qkc.111.1597512242816;
        Sat, 15 Aug 2020 10:24:02 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id h13sm13485387qtu.7.2020.08.15.10.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 10:24:01 -0700 (PDT)
Date:   Sat, 15 Aug 2020 13:23:59 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Subject: Re: [PATCH v4 3/5] counter: Add character device interface
Message-ID: <20200815172359.GB6974@shinobu>
References: <cover.1595358237.git.vilhelm.gray@gmail.com>
 <08b3ac7349a59ba7fa5cd438bbe78360842ccd11.1595358237.git.vilhelm.gray@gmail.com>
 <415ee9ad-255e-cee7-22a6-ffa977999691@lechnology.com>
 <20200809145107.GA6542@shinobu>
 <ddf07574-56f3-ad5f-b417-6ed9a3ba78cb@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Content-Disposition: inline
In-Reply-To: <ddf07574-56f3-ad5f-b417-6ed9a3ba78cb@lechnology.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2020 at 06:02:16PM -0500, David Lechner wrote:
> On 8/9/20 9:51 AM, William Breathitt Gray wrote:
> > On Tue, Jul 28, 2020 at 07:20:03PM -0500, David Lechner wrote:
> >> On 7/21/20 2:35 PM, William Breathitt Gray wrote:
> >>> This patch introduces a character device interface for the Counter
> >>> subsystem. Device data is exposed through standard character device r=
ead
> >>> operations. Device data is gathered when a Counter event is pushed by
> >>> the respective Counter device driver. Configuration is handled via io=
ctl
> >>> operations on the respective Counter character device node.
> >>
> >> This sounds similar to triggers and buffers in the iio subsystem. And
> >> I can see how it might be useful in some cases. But I think it would n=
ot
> >> give the desired results when performance is important.
> >>
> >> Thinking through a few cases here...
> >>
> >> Suppose there was a new counter device that used the I2C bus. This wou=
ld
> >> either have to be periodically polled for events or it might have a
> >> separate GPIO line to notify the MCU. In any case, with the proposed
> >> implementation, there would be a separate I2C transaction for each data
> >> point for that event. So none of the data for that event would actually
> >> be from the same point in time. And with I2C, this time difference cou=
ld
> >> be significant.
> >>
> >> With the TI eQEP I have been working with, there are special latched
> >> registers for some events. To make use of these with events, we would =
have
> >> add extensions for each one we want to use (and expose it in sysfs). B=
ut
> >> really, the fact that we are using a latched register should be an
> >> implementation detail in the driver and not something userspace should=
 have
> >> to know about.
> >>
> >> So, I'm wondering if it would make sense to keep things simpler and ha=
ve
> >> events like the input subsystem where the event value is directly tied
> >> to the event. It would probably be rare for an event to have more than
> >> one or two values. And error events probably would not have a value at
> >> all.
> >>
> >> For example, with the TI eQEP, there is a unit timer time out event.
> >> This latches the position count, the timer count and the timer period.
> >> To translate this to an event data structure, the latched time would
> >> be the event timestamp and the position count would be the event value.
> >> The timer period should already be known since we would have configured
> >> the timer ourselves. There is also a count event that works similarly.
> >> In this case, the latched time would be the event timestamp and the
> >> latched timer period would be the event value. We would know the count
> >> already since we get an event for each count (and a separate direction
> >> change event if the direction changes).
> >=20
> > There are use-cases where it would be useful to have the extension reads
> > occur as close to the event trigger as possible (e.g. multiple-axes
> > positioning with boundary sensor flags) so I don't think this
> > functionality should be completely abadoned, but I think your argument
> > for standard event types makes sense.
> >=20
> > We could treat those extensions reads as an optional feature that can be
> > enabled and configured by ioctls. However, the use-case you are
> > concerned with, we can redesign Counter events to return specific data
> > based on the specific event type.
> >=20
> > For example, we could have a COUNTER_EVENT_INDEX which occurs when an
> > Index signal edge is detected, and the return data is the Count value
> > for that channel; we can also have a COUNTER_EVENT_TIMEOUT which occurs
> > when a unit timer times out, and returns the data you mentioned you are
> > interested in seeing.
> >=20
> > These Counter event types would be standard, so user applications
> > wouldn't need to know driver/device implementation details, but instead
> > just follow the API to get the data they expect for that particular
> > event type. Would this kind of design work for your needs?
>=20
>=20
> Yes. After trying (and failing) to implement my suggestions here, I
> came to the conclusion that it was not sufficient to only have one
> value per event. And it doesn't seem as obvious as I initially thought
> which should be the "standard" value for an event in some cases.

I agree, after thinking this over a second I realized it's not as
apparent as I had hoped to determine what value would be most useful in
general. I think the uses of counter devices are too varied, so it's
probably best to leave it to the user to choose what value they want to
gather for the respective events.

The good thing is that the interface is flexible enough for us to
defined new COUNTER_COMPONENT_TYPE_XXX types to extend the kind of data
that can be gathered on an event push. This provides us with a path we
can go down to implement the kind of data read you need without the
latency overhead of executing multiple Counter Extension read
operations (allowing for a single I2C transaction instead for example).

However, standard event types (e.g. COUNTER_EVENT_INDEX) are something I
find prudent to define, lest each driver end up with their own differing
definitions of what "Event 0" actually means.

> >>>
> >>> When `counter_push_event(counter, 1)` is called for example, it will =
go
> >>> down the list for Event 1 and execute the read callbacks for Signal 0,
> >>> Signal 0 Extension 0, and Extension 4 -- the data returned for each is
> >>> pushed to a kfifo as a `struct counter_event`, which userspace can
> >>> retrieve via a standard read operation on the respective character
> >>> device node.
> >>>
> >>> Userspace
> >>> ---------
> >>> Userspace applications can configure Counter events via ioctl operati=
ons
> >>> on the Counter character device node. There following ioctl codes are
> >>> supported and provided by the `linux/counter.h` userspace header file:
> >>>
> >>> * COUNTER_CLEAR_WATCHES_IOCTL:
> >>>     Clear all Counter watches from all events
> >>>
> >>> * COUNTER_SET_WATCH_IOCTL:
> >>>     Set a Counter watch on the specified event
> >>>
> >>> To configure events to gather Counter data, users first populate a
> >>> `struct counter_watch` with the relevant event id and the information
> >>> for the desired Counter component from which to read, and then pass it
> >>> via the `COUNTER_SET_WATCH_IOCTL` ioctl command.
> >>>
> >>> Userspace applications can then execute a `read` operation (optionally
> >>> calling `poll` first) on the Counter character device node to retrieve
> >>> `struct counter_event` elements with the desired data.
> >>>
> >>> For example, the following userspace code opens `/dev/counter0`,
> >>> configures Event 0 to gather Count 0 and Count 1, and prints out the
> >>> data as it becomes available on the character device node:
> >>>
> >>>       #include <fcntl.h>
> >>>       #include <linux/counter.h>
> >>>       #include <poll.h>
> >>>       #include <stdio.h>
> >>>       #include <sys/ioctl.h>
> >>>       #include <unistd.h>
> >>>
> >>>       struct counter_watch watches[2] =3D {
> >>>               {
> >>>                       .event =3D 0,
> >>>                       .component.owner_type =3D COUNTER_OWNER_TYPE_CO=
UNT,
> >>>                       .component.owner_id =3D 0,
> >>>                       .component.type =3D COUNTER_COMPONENT_TYPE_COUN=
T,
> >>>               },
> >>>               {
> >>>                       .event =3D 0,
> >>>                       .component.owner_type =3D COUNTER_OWNER_TYPE_CO=
UNT,
> >>>                       .component.owner_id =3D 1,
> >>>                       .component.type =3D COUNTER_COMPONENT_TYPE_COUN=
T,
> >>>               },
> >>>       };
> >>>
> >>>       int main(void)
> >>>       {
> >>>               struct pollfd pfd =3D { .events =3D POLLIN };
> >>>               struct counter_event event_data[2];
> >>>
> >>>               pfd.fd =3D open("/dev/counter0", O_RDWR);
> >>>
> >>>               ioctl(pfd.fd, COUNTER_SET_WATCH_IOCTL, watches);
> >>>               ioctl(pfd.fd, COUNTER_SET_WATCH_IOCTL, watches + 1);
> >>
> >> What enables events? If an event is enabled for each of these ioctls,
> >> then we have a race condition where events events from the first watch
> >> can start to be queued before the second watch is added. So we would
> >> have to flush the chardev first before polling, otherwise the assumpti=
on
> >> that event_data[0] is owner_id=3D0 and event_data[1] is owner_id=3D1 is
> >> not true.
> >=20
> > That's a good point, we could theoretically have a situation where an
> > event is pushed before the configuration of watches is complete. I'm not
> > sure if the solution is to implement an enable/disable ioctl to control
> > when events are recorded, or a flush ioctl to remove the invalid events
> > in the queue.
> >=20
> >> This is also racy if we want to clear watches and set up new watches
> >> at runtime. There would be a period of time where there were no watches
> >> and we could miss events.
> >=20
> > I'm not sure how typical this use-case is -- would an operator ever want
> > to change watch configuration on-the-fly? I assumed watches configured
> > once at the start of a production run, and then stay essentially static
> > until the production stops.
>=20
> The use case I am thinking of is measuring motor speed in robotics. At
> low speed, we need an event for each count increase. But at high speed,
> this would be too many events and we instead need a periodic event based
> on the timer timeout. A maneuver may require operating at both high and
> low speeds without stopping and so we would want to be able to switch
> back and forth without interruption.

That's a fair use case, and I think have a well-defined swap mechanism
in place is good regardless, so I'll go ahead implement this.

> >=20
> > Well regardless, if we want to support this kind of functionality we
> > will need to implement a kind of atomic replacement for all watches with
> > new ones. This shouldn't be too difficult to achieve: buffer the desired
> > watches instead, and then activate them together atomically via a new
> > ioctl command.
> >=20
> >> With my suggested changes of having fixed values per event and generic
> >> events, we could just have a single ioctl to enable and disable events.
> >> This would probably need to take an array of event descriptors as an
> >> argument where event descriptors contain the component type/id and the
> >> event to enable.
> >=20
> > I agree with having specified data for particular event types, but I
> > think we should still be able to support general extension watches as an
> > optional functionality. In fact, I don't think we'll need to implement
> > enable/disable event ioctl commands.
> >=20
> > The current implementation only records events if the user is watching
> > for them (i.e. a watch has been set); if no one is watching for these
> > events, they are just silently dropped by the counter_event_push
> > function. If we implement an ioctl to atomically set the watches, there
> > is no need to explicitly enable/disable events: events will always
> > report the specified data for those their respective type -- the watch
> > data is extra optional data and will start flowing automatically when
> > atomically activated.
> >=20
>=20
> This sounds reasonable to me.

Ack. :-)

William Breathitt Gray

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl84GiUACgkQhvpINdm7
VJJhRQ/+O0RouM5Kkp49LY8+FqOa33Pm0SvXB1en9eITdVamkDfP4YgqChyvMRNY
ML8EacNrxH/qL9HULkHVMtPPxOFrBaBQ1lL8Rl8mMJCiLETd7GmWsuv6tLCRGeXp
GgHbOX+3MTnICeTxie+cXElJSgAe5sW7FXlXEhQ71m7PCtFKFAq/dCSwMiTMzqyI
dPJg0+XyejKGNexLtlboKMGcX5v5s1O1CDW5uX9vrUrhZbsCsx4ELjgafUOMTXOM
elklQOIj1M/8Ccxr6CRV6i0V+TeWvdOD1YAGOv+rb9yyMhWHIwBtCIg0ZAMTEYQ7
I3qQ5hvfFpaMNYuSrThQorbgYn2Ap0lU7x7cH2J+lAeAqr5XoJjvbgvj5AOwI9ew
TksvgUT1TdqPXOJNVwE9/B2XbylXIJdGYT15DvTerpZZv4Ycp+CLL5GNhlIovOFG
i4Aiu3RxSqK0Nf8ENxApthEIndyuesZEjwPyHxxmBfMgUKSC4DgxBxIX4y9xaJEP
wWRcf6tQ3Ty09VaWBmUHRAioozDgrRTtLdUDXJex285HrTYgxZLne7QYpXNpj1Ip
0Cp8KvXWG0v37h+4Vio5MHw8wKZSKCMZn64msy4sQiF4ieOcps2Mw/KOw6PbgLy8
rbBgCkiHPX7RaadTlezjtufL5ns+/QnzL6H595ITEXwrwIVdsT8=
=os1s
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
