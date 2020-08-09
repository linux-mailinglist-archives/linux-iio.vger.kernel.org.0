Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C020D23FED2
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 16:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgHIOv2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 10:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgHIOv1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Aug 2020 10:51:27 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C9AC061756;
        Sun,  9 Aug 2020 07:51:27 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id b2so3067667qvp.9;
        Sun, 09 Aug 2020 07:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BZtBKlgri4TkTnE2aSnSUNMWxmvTviox3gYBSXakEG8=;
        b=VsjSFE7rNTeRHd/PLdnYQJ+qnYZZ60N/8S2FPZeoCiYahT9qZyLzO37mPUhegxwalq
         RLjNYb0DY/xydOIoav9TAFwRVbenbn1JxvzCxrQXlJwbZxhRpW82jKFuhMHgs3rT5Gev
         gDvxnPTMFHWlKnq546kQ1GrpnW6TnyfkYnQSeWXvMhIvwBzbpUWtDzKwf2ZWqlvvcWBL
         QvAiujNEXe1YmxKbWCCBEwZcj/ziWEGc2jjHz6ky3vWz6GkUZp3ZuXUhp8ktXU9lm2lg
         jzKpTVtk/WfRvqj/Km6+tOpYNqm0N4I//10Pz1ZK9Ge7LFsxa8sqWR7EAbXzQWlkOgYr
         2Ifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BZtBKlgri4TkTnE2aSnSUNMWxmvTviox3gYBSXakEG8=;
        b=BMxfghMxsvvxkWa9frEEKz5JMmR/Zv3Jnp8NU9QheXTse9jGwysbsUS0CqOsln/R7l
         O1tzCw/eWzBcztSG5S5ti5vmyYS3TCLDNZ+DyJnJtSrLX0/lCSxkF6WpoBJ91+x6Y9h9
         ap6GOO7Tc87Qs3T10dSG7xSpGfiMMnhfYdnGHaFk2WoxkZ/RfJ9fjewD62ms3W+Ip1y6
         JP1kW9mkCNKSmryulS+32/3TfitH0IOyIYgBhXjsCY7Hs30emycdkhj7xpR+A6h/BalR
         DXa9hXFcrX0SzdW6Wn85Tb5NLNBFY1zhyBKJf92gfCM1GREgIw7i3iZq7RAEaL8GEVF5
         qf+Q==
X-Gm-Message-State: AOAM530yt+1YW6o7iHXf9uFNrX1v/1ytV6mN5e4JG6nh58mlR/ckCk3z
        wiiAMZDXPAnUxmZ9NpSytO3+LvEJ34A=
X-Google-Smtp-Source: ABdhPJxCmk7THhFjP7/N4JrJXHVOZ9ivg3IcNpIUHpDGDDuRAKtK+kWYRVuosNo2PJYJpBriM1Pl8g==
X-Received: by 2002:ad4:46ac:: with SMTP id br12mr24211039qvb.236.1596984684251;
        Sun, 09 Aug 2020 07:51:24 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id t8sm14064330qtc.50.2020.08.09.07.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 07:51:23 -0700 (PDT)
Date:   Sun, 9 Aug 2020 10:51:07 -0400
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
Message-ID: <20200809145107.GA6542@shinobu>
References: <cover.1595358237.git.vilhelm.gray@gmail.com>
 <08b3ac7349a59ba7fa5cd438bbe78360842ccd11.1595358237.git.vilhelm.gray@gmail.com>
 <415ee9ad-255e-cee7-22a6-ffa977999691@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <415ee9ad-255e-cee7-22a6-ffa977999691@lechnology.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2020 at 07:20:03PM -0500, David Lechner wrote:
> On 7/21/20 2:35 PM, William Breathitt Gray wrote:
> > This patch introduces a character device interface for the Counter
> > subsystem. Device data is exposed through standard character device read
> > operations. Device data is gathered when a Counter event is pushed by
> > the respective Counter device driver. Configuration is handled via ioctl
> > operations on the respective Counter character device node.
>=20
> This sounds similar to triggers and buffers in the iio subsystem. And
> I can see how it might be useful in some cases. But I think it would not
> give the desired results when performance is important.
>=20
> Thinking through a few cases here...
>=20
> Suppose there was a new counter device that used the I2C bus. This would
> either have to be periodically polled for events or it might have a
> separate GPIO line to notify the MCU. In any case, with the proposed
> implementation, there would be a separate I2C transaction for each data
> point for that event. So none of the data for that event would actually
> be from the same point in time. And with I2C, this time difference could
> be significant.
>=20
> With the TI eQEP I have been working with, there are special latched
> registers for some events. To make use of these with events, we would have
> add extensions for each one we want to use (and expose it in sysfs). But
> really, the fact that we are using a latched register should be an
> implementation detail in the driver and not something userspace should ha=
ve
> to know about.
>=20
> So, I'm wondering if it would make sense to keep things simpler and have
> events like the input subsystem where the event value is directly tied
> to the event. It would probably be rare for an event to have more than
> one or two values. And error events probably would not have a value at
> all.
>=20
> For example, with the TI eQEP, there is a unit timer time out event.
> This latches the position count, the timer count and the timer period.
> To translate this to an event data structure, the latched time would
> be the event timestamp and the position count would be the event value.
> The timer period should already be known since we would have configured
> the timer ourselves. There is also a count event that works similarly.
> In this case, the latched time would be the event timestamp and the
> latched timer period would be the event value. We would know the count
> already since we get an event for each count (and a separate direction
> change event if the direction changes).

There are use-cases where it would be useful to have the extension reads
occur as close to the event trigger as possible (e.g. multiple-axes
positioning with boundary sensor flags) so I don't think this
functionality should be completely abadoned, but I think your argument
for standard event types makes sense.

We could treat those extensions reads as an optional feature that can be
enabled and configured by ioctls. However, the use-case you are
concerned with, we can redesign Counter events to return specific data
based on the specific event type.

For example, we could have a COUNTER_EVENT_INDEX which occurs when an
Index signal edge is detected, and the return data is the Count value
for that channel; we can also have a COUNTER_EVENT_TIMEOUT which occurs
when a unit timer times out, and returns the data you mentioned you are
interested in seeing.

These Counter event types would be standard, so user applications
wouldn't need to know driver/device implementation details, but instead
just follow the API to get the data they expect for that particular
event type. Would this kind of design work for your needs?

> >=20
> > A high-level view of how a count value is passed down from a counter
> > driver is exemplified by the following:
> >=20
> >                   ----------------------
> >                  / Counter device       \
> >                  +----------------------+
> >                  | Count register: 0x28 |
> >                  +----------------------+
> >                          |
> >                   -----------------
> >                  / raw count data /
> >                  -----------------
> >                          |
> >                          V
> >                  +----------------------------+
> >                  | Counter device driver      |----------+
> >                  +----------------------------+          |
> >                  | Processes data from device |   -------------------
> >                  |----------------------------|  / driver callbacks /
> >                  | Type: u64                  |  -------------------
> >                  | Value: 42                  |          |
> >                  +----------------------------+          |
> >                          |                               |
> >                   ----------                             |
> >                  / u64     /                             |
> >                  ----------                              |
> >                          |                               |
> >                          |                               V
> >                          |               +----------------------+
> >                          |               | Counter core         |
> >                          |               +----------------------+
> >                          |               | Routes device driver |
> >                          |               | callbacks to the     |
> >                          |               | userspace interfaces |
> >                          |               +----------------------+
> >                          |                       |
> >                          |                -------------------
> >                          |               / driver callbacks /
> >                          |               -------------------
> >                          |                       |
> >                  +-------+---------------+       |
> >                  |                       |       |
> >                  |               +-------|-------+
> >                  |               |       |
> >                  V               |       V
> >          +--------------------+  |  +---------------------+
> >          | Counter sysfs      |<-+->| Counter chrdev      |
> >          +--------------------+     +---------------------+
> >          | Translates to the  |     | Translates to the   |
> >          | standard Counter   |     | standard Counter    |
> >          | sysfs output       |     | character device    |
> >          |--------------------|     |---------------------+
> >          | Type: const char * |     | Type: u64           |
> >          | Value: "42"        |     | Value: 42           |
> >          +--------------------+     +---------------------+
> >                  |                               |
> >           ---------------                 -----------------------
> >          / const char * /                / struct counter_event /
> >          ---------------                 -----------------------
> >                  |                               |
> >                  |                               V
> >                  |                       +-----------+
> >                  |                       | read      |
> >                  |                       +-----------+
> >                  |                       \ Count: 42 /
> >                  |                        -----------
> >                  |
> >                  V
> >          +--------------------------------------------------+
> >          | `/sys/bus/counter/devices/counterX/countY/count` |
> >          +--------------------------------------------------+
> >          \ Count: "42"                                      /
> >           --------------------------------------------------
> >=20
> > Counter character device nodes are created under the `/dev` directory as
> > `counterX`, where `X` is the respective counter device id. Defines for
> > the standard Counter data types are exposed via the userspace
> > `include/uapi/linux/counter.h` file.
> >=20
> > Counter events
> > --------------
> > Counter device drivers can support Counter events by utilizing the
> > `counter_push_event` function:
> >=20
> >      int counter_push_event(struct counter_device *const counter,
> >                             const u8 event);
> >=20
> > The event id is specified by the `event` parameter. When this function
> > is called, the Counter data associated with the respective event is
> > gathered, and a `struct counter_event` is generated for each datum and
> > pushed to userspace.
> >=20
> > Counter events can be configured by users to report various Counter
> > data of interest. This can be conceptualized as a list of Counter
> > component read calls to perform. For example:
> >=20
> >      +------------------------+------------------------+
> >      | Event 0                | Event 1                |
> >      +------------------------+------------------------+
> >      | * Count 0              | * Signal 0             |
> >      | * Count 1              | * Signal 0 Extension 0 |
> >      | * Signal 3             | * Extension 4          |
> >      | * Count 4 Extension 2  |                        |
> >      | * Signal 5 Extension 0 |                        |
> >      +------------------------+------------------------+
>=20
> In the current implementation, I can't tell if the event number correspon=
ds
> to the individual counter or some device-specific interrupt bits. In eith=
er
> case, it seems like it would be better to have a generic enum of possible
> counter events like overflow, underflow, direction change, etc.

In the current implementation, the event number is arbitrarily chosen by
the driver author. It would be best to have these well defined, and I
think a group of standard Counter events would be the way to go as you
point out. We can define a few common ones we expect for this
introduction patch, and expand it from there if new types of events are
necessary for future drivers.

> >=20
> > When `counter_push_event(counter, 1)` is called for example, it will go
> > down the list for Event 1 and execute the read callbacks for Signal 0,
> > Signal 0 Extension 0, and Extension 4 -- the data returned for each is
> > pushed to a kfifo as a `struct counter_event`, which userspace can
> > retrieve via a standard read operation on the respective character
> > device node.
> >=20
> > Userspace
> > ---------
> > Userspace applications can configure Counter events via ioctl operations
> > on the Counter character device node. There following ioctl codes are
> > supported and provided by the `linux/counter.h` userspace header file:
> >=20
> > * COUNTER_CLEAR_WATCHES_IOCTL:
> >    Clear all Counter watches from all events
> >=20
> > * COUNTER_SET_WATCH_IOCTL:
> >    Set a Counter watch on the specified event
> >=20
> > To configure events to gather Counter data, users first populate a
> > `struct counter_watch` with the relevant event id and the information
> > for the desired Counter component from which to read, and then pass it
> > via the `COUNTER_SET_WATCH_IOCTL` ioctl command.
> >=20
> > Userspace applications can then execute a `read` operation (optionally
> > calling `poll` first) on the Counter character device node to retrieve
> > `struct counter_event` elements with the desired data.
> >=20
> > For example, the following userspace code opens `/dev/counter0`,
> > configures Event 0 to gather Count 0 and Count 1, and prints out the
> > data as it becomes available on the character device node:
> >=20
> >      #include <fcntl.h>
> >      #include <linux/counter.h>
> >      #include <poll.h>
> >      #include <stdio.h>
> >      #include <sys/ioctl.h>
> >      #include <unistd.h>
> >=20
> >      struct counter_watch watches[2] =3D {
> >              {
> >                      .event =3D 0,
> >                      .component.owner_type =3D COUNTER_OWNER_TYPE_COUNT,
> >                      .component.owner_id =3D 0,
> >                      .component.type =3D COUNTER_COMPONENT_TYPE_COUNT,
> >              },
> >              {
> >                      .event =3D 0,
> >                      .component.owner_type =3D COUNTER_OWNER_TYPE_COUNT,
> >                      .component.owner_id =3D 1,
> >                      .component.type =3D COUNTER_COMPONENT_TYPE_COUNT,
> >              },
> >      };
> >=20
> >      int main(void)
> >      {
> >              struct pollfd pfd =3D { .events =3D POLLIN };
> >              struct counter_event event_data[2];
> >=20
> >              pfd.fd =3D open("/dev/counter0", O_RDWR);
> >=20
> >              ioctl(pfd.fd, COUNTER_SET_WATCH_IOCTL, watches);
> >              ioctl(pfd.fd, COUNTER_SET_WATCH_IOCTL, watches + 1);
>=20
> What enables events? If an event is enabled for each of these ioctls,
> then we have a race condition where events events from the first watch
> can start to be queued before the second watch is added. So we would
> have to flush the chardev first before polling, otherwise the assumption
> that event_data[0] is owner_id=3D0 and event_data[1] is owner_id=3D1 is
> not true.

That's a good point, we could theoretically have a situation where an
event is pushed before the configuration of watches is complete. I'm not
sure if the solution is to implement an enable/disable ioctl to control
when events are recorded, or a flush ioctl to remove the invalid events
in the queue.

> This is also racy if we want to clear watches and set up new watches
> at runtime. There would be a period of time where there were no watches
> and we could miss events.

I'm not sure how typical this use-case is -- would an operator ever want
to change watch configuration on-the-fly? I assumed watches configured
once at the start of a production run, and then stay essentially static
until the production stops.

Well regardless, if we want to support this kind of functionality we
will need to implement a kind of atomic replacement for all watches with
new ones. This shouldn't be too difficult to achieve: buffer the desired
watches instead, and then activate them together atomically via a new
ioctl command.

> With my suggested changes of having fixed values per event and generic
> events, we could just have a single ioctl to enable and disable events.
> This would probably need to take an array of event descriptors as an
> argument where event descriptors contain the component type/id and the
> event to enable.

I agree with having specified data for particular event types, but I
think we should still be able to support general extension watches as an
optional functionality. In fact, I don't think we'll need to implement
enable/disable event ioctl commands.

The current implementation only records events if the user is watching
for them (i.e. a watch has been set); if no one is watching for these
events, they are just silently dropped by the counter_event_push
function. If we implement an ioctl to atomically set the watches, there
is no need to explicitly enable/disable events: events will always
report the specified data for those their respective type -- the watch
data is extra optional data and will start flowing automatically when
atomically activated.

William Breathitt Gray

> >=20
> >              for (;;) {
> >                      poll(&pfd, 1, -1);
> >=20
> >                      read(pfd.fd, event_data, sizeof(event_data));
> >=20
> >                      printf("Timestamp 0: %llu\nCount 0: %llu\n"
> >                             "Timestamp 1: %llu\nCount 1: %llu\n",
> >                             (unsigned long long)event_data[0].timestamp,
> >                             (unsigned long long)event_data[0].value_u64,
> >                             (unsigned long long)event_data[1].timestamp,
> >                             (unsigned long long)event_data[1].value_u64=
);
> >              }
> >=20
> >              return 0;
> >      }
> >=20
> > Cc: David Lechner <david@lechnology.com>
> > Cc: Gwendal Grignou <gwendal@chromium.org>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
>=20

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl8wDUMACgkQhvpINdm7
VJJ+aQ//aYl5Nh3OTkDLViHGYIqbS1E18rKNOsojm35X0QphXCY3cSvedRFkdSGe
LTOqDcMcSE88yT8psfTT0pqWUyPIyd9cTq1Qqe9C/0rVV7CN1cnMEPSWtB/GcFXf
md7SVNToX88e03gv8nrMdPpk3CHC8fdpNPxxgADOhwLs7sl8upg8UPrB1zx+P4Od
TLLvreG/JZJdqbCJDgrQtGBH2ebQYa+sjggR+jAeZltNOBsXqoaGS4/ND0AGTdUv
gDAiX3ZMTPVr2aXbJVzOdSB5ZCE0weyQahb4saYKEhWU/r0g9pqgiaoDKEeb+meh
iWJzCf3QJB8p+ZCRutm5gUipBLsnwrT2InaIyFBUZ9mpb/cSMCR91KeEeQ9BulfX
nb3q0ZD/l92iDanVg/DRnwbWbRra4U9gG6+AAFO8q1IVu5FCdLICQ/zK8k9HYsMY
JsalGleavxr3xyTFPTpzQsvBNxcbKzSHFPbBGXKqU0CTLMSgi2BEd/5YF6O08xoC
dJg1CAErJY0Y/oMn+NRfjhCD5WUhynEFuCkoNzQ6SkFQX/bp6nhdmgNNh1dFWmSK
vUUHww/TBilDooxbW7TLr19IsJWpKHpLPlPY6K866ObtUNk8yCb4ddYcHkJIZQ18
s//fD8hHGse3at7Th2h4j2Si1ek7qsRX8vG+apEg6FSERLm20Sg=
=VM/9
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
