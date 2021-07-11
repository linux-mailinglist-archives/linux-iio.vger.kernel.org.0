Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8253C3BDC
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jul 2021 13:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhGKLbH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Jul 2021 07:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbhGKLbH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Jul 2021 07:31:07 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD436C0613DD;
        Sun, 11 Jul 2021 04:28:20 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id 109so1453398uar.10;
        Sun, 11 Jul 2021 04:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2UbdQq4lzRnyLqpnoKRSKm5CIBGEvXxu2D17blGP0rc=;
        b=uZO275xN/xrbBY/7UUArNmoCsAwrZGS9wg9y7eVGgpV7a3h2KA794rjOITby78slb3
         kk/o6kwBR4DF9m+u76fTJW2UzfgQQv7R7p6rjJ/5uhkYGP4ywLvbd/aVfq1pYTMhavl0
         xYxzOXpePRViDIGKb5y4VA+AN1+RfZtp2gkqHX4YFetudLxMorwL0xLn610Pfjn1f5zH
         aTfMixTPHU52Nj1BpRHOkKHLpnpIDw2BLGx+Ndz31IMFP+reL+o9al5Wg546PoL/tEGj
         42zkH9BYvc3dy3o60lTTZYEnMcSBFtwwEN50xPEj3Xe4NPbQkgblk9XG6t67wffNNDCH
         axQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2UbdQq4lzRnyLqpnoKRSKm5CIBGEvXxu2D17blGP0rc=;
        b=E8MyPgxWXyGvePirIU3HubiH+Wbc2561nhngEvTK+UN5feOlt03Ij4xt3jo0DC1a/V
         Z7gsWmBGoV/98k2H4hDj8HcSgTVBOqotn6o59Mo/o5QkSryH/+Xs96uiNPEcnXqSS7OR
         H98ak30JgugDsxwHLeLnCYuzp1MqYhuibV0LLRN7QlgdlKQ6bft+lm1erq5CYTXejZvw
         t7nDHSShr5TwLZl0wsCiAo0jy4ps0vk6xVsUQYt6+zY9QkvM0lfXFyTAvS9U6dg1A3DS
         9GcJhhLaQafH5RnRjppdFE9LZVddDlr6RIria2V2DYN0dxLdbph4HgyMubuSDqYVoGeh
         Gezg==
X-Gm-Message-State: AOAM5335zkyS7oK8mevuwEPdNkZVGRiA/qG49qOJLSBzUgFtO/9OeoN0
        ALIQZSnWOQTk+5LiBZiW4ME=
X-Google-Smtp-Source: ABdhPJyfXiuANdIugYW/0ijyHB9PsLd9AbrGVY8e174gPdjELQV0JHTLolVn9IfYR+kXf3ROujFpgA==
X-Received: by 2002:ab0:d97:: with SMTP id i23mr11710027uak.61.1626002899806;
        Sun, 11 Jul 2021 04:28:19 -0700 (PDT)
Received: from shinobu ([193.27.12.133])
        by smtp.gmail.com with ESMTPSA id m16sm1558726vkm.47.2021.07.11.04.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 04:28:19 -0700 (PDT)
Date:   Sun, 11 Jul 2021 20:28:11 +0900
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
        jarkko.nikula@linux.intel.com, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v12 12/17] tools/counter: Create Counter tools
Message-ID: <YOrVy7Ba117s1maQ@shinobu>
References: <cover.1625471640.git.vilhelm.gray@gmail.com>
 <e97aa3e529f54d5651df7edcc1b43a8157d9e9c3.1625471640.git.vilhelm.gray@gmail.com>
 <343a2bd3-38b7-7462-bc52-d3f6493bede0@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PD3Ct3y1jwnkQ/rs"
Content-Disposition: inline
In-Reply-To: <343a2bd3-38b7-7462-bc52-d3f6493bede0@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--PD3Ct3y1jwnkQ/rs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 10, 2021 at 11:53:35AM -0500, David Lechner wrote:
> On 7/5/21 3:19 AM, William Breathitt Gray wrote:
> > This creates an example Counter program under tools/counter/*
> > to exemplify the Counter character device interface.
> >=20
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
>=20
>=20
> > --- a/tools/Makefile
> > +++ b/tools/Makefile
> > @@ -12,6 +12,7 @@ help:
> >   	@echo '  acpi                   - ACPI tools'
> >   	@echo '  bpf                    - misc BPF tools'
> >   	@echo '  cgroup                 - cgroup tools'
> > +	@echo '  counter                - Counter tools'
>=20
> nit: other descriptions start with lower case letter, so to be
> consistent, this should too

Ack.

> > --- /dev/null
> > +++ b/tools/counter/counter_example.c
> > @@ -0,0 +1,95 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Counter - example userspace application
> > + *
> > + * The userspace application opens /dev/counter0, configures the
> > + * COUNTER_EVENT_INDEX event channel 0 to gather Count 0 count and Cou=
nt
> > + * 1 count, and prints out the data as it becomes available on the
> > + * character device node.
> > + *
> > + * Copyright (C) 2021 William Breathitt Gray
> > + */
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <linux/counter.h>
> > +#include <stdio.h>
> > +#include <string.h>
> > +#include <sys/ioctl.h>
> > +#include <unistd.h>
> > +
> > +struct counter_watch watches[2] =3D {
>=20
> nit: this can be static

Ack.

> > +	{
> > +		/* Component data: Count 0 count */
> > +		.component.type =3D COUNTER_COMPONENT_COUNT,
> > +		.component.scope =3D COUNTER_SCOPE_COUNT,
> > +		.component.parent =3D 0,
> > +		/* Event type: Index */
> > +		.event =3D COUNTER_EVENT_INDEX,
> > +		/* Device event channel 0 */
> > +		.channel =3D 0,
> > +	},
> > +	{
> > +		/* Component data: Count 1 count */
> > +		.component.type =3D COUNTER_COMPONENT_COUNT,
> > +		.component.scope =3D COUNTER_SCOPE_COUNT,
> > +		.component.parent =3D 1,
> > +		/* Event type: Index */
> > +		.event =3D COUNTER_EVENT_INDEX,
> > +		/* Device event channel 0 */
> > +		.channel =3D 0,
> > +	},
> > +};
> > +
> > +int main(void)
> > +{
> > +	int fd;
> > +	int ret;
> > +	struct counter_event event_data[2];
> > +
> > +	fd =3D open("/dev/counter0", O_RDWR);
> > +	if (fd =3D=3D -1) {
> > +		perror("Unable to open /dev/counter0");
> > +		return -errno;
>=20
> errno is no longer valid after calling perror(). Since this
> is example code, we can just return 1 instead (exit codes
> positive number between 0 and 255 so -1 would be 255).

Ack.

> > +	}
> > +
> > +	ret =3D ioctl(fd, COUNTER_ADD_WATCH_IOCTL, watches);
> > +	if (ret =3D=3D -1) {
> > +		perror("Error adding watches[0]");
> > +		return -errno;
> > +	}
> > +	ret =3D ioctl(fd, COUNTER_ADD_WATCH_IOCTL, watches + 1);
> > +	if (ret =3D=3D -1) {
> > +		perror("Error adding watches[1]");
> > +		return -errno;
> > +	}
> > +	ret =3D ioctl(fd, COUNTER_ENABLE_EVENTS_IOCTL);
> > +	if (ret =3D=3D -1) {
> > +		perror("Error enabling events");
> > +		return -errno;
> > +	}
> > +
> > +	for (;;) {
> > +		ret =3D read(fd, event_data, sizeof(event_data));
> > +		if (ret =3D=3D -1) {
> > +			perror("Failed to read event data");
> > +			return -errno;
> > +		}
> > +
> > +		if (ret !=3D sizeof(event_data)) {
> > +			fprintf(stderr, "Failed to read event data\n");
> > +			return -EIO;
> > +		}
> > +
> > +		printf("Timestamp 0: %llu\tCount 0: %llu\n"
> > +		       "Error Message 0: %s\n"
> > +		       "Timestamp 1: %llu\tCount 1: %llu\n"
> > +		       "Error Message 1: %s\n",
> > +		       (unsigned long long)event_data[0].timestamp,
> > +		       (unsigned long long)event_data[0].value,
> > +		       strerror(event_data[0].status),
> > +		       (unsigned long long)event_data[1].timestamp,
> > +		       (unsigned long long)event_data[1].value,
> > +		       strerror(event_data[1].status));
> > +	}
>=20
> Aren't the Count 0 and Count 1 events independent? Why should we expect to
> always get both events at the same time in the same order?

Watch 0 and Watch 1 are both triggered by the same event: a
COUNTER_EVENT_INDEX event on device event channel 0. If we had set
channel to 1 for Watch 1, then we would have two independent events, but
in this case both Watches have their respective channel set to 0.

To make the sequence of events clearer, here's a timeline:

* The user configures the watch list via COUNTER_ADD_WATCH_IOCTL.

* The watch list consists of Watch 0 and Watch 1. Watch 0 is configured
  to report the Count 0 count, while Watch 1 is configured to report the
  Count 1 count. Both watches are configured to trigger on the same
  event (COUNTER_EVENT_INDEX on device event channel 0).

* The user enables Counter events via COUNTER_ENABLE_EVENTS_IOCTL.

* The user calls read() from userspace and blocks until data is
  available in the Counter events list kfifo; this corresponds to
  wait_event_interruptible() in counter_chrdev_read().

* A COUNTER_EVENT_INDEX event occurs on device event channel 0.

* All Watches in the watch list that are waiting for COUNTER_EVENT_INDEX
  on device event channel 0 will now trigger; both Watch 0 and Watch 1
  will trigger, one after the other.

* A read operation is performed for the Count 0 count component; the
  data is pushed to the Counter event list.

* A read operation is performed for the Count 1 count component; the
  data is pushed to the Counter event list.

* Counter subsystem notifies that data is available in the Counter
  events list kfifo; this corresponds to the wake_up_poll() in
  counter_push_event().

* The userspace read() call returns the Counter event list data.

So in the counter_example.c reference code, we will always get both
event data elements returned to the user at the same time (with the
exception of errors which break early).

William Breathitt Gray

--PD3Ct3y1jwnkQ/rs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmDq1boACgkQhvpINdm7
VJK6HQ//dIi8jTzPIXeL6Knwf7G4fe8H9LQroDGDqCGexaFo0UpsuCsGaeJmXmrB
pOiHPae9g2jiJU0z8z22nKjSogQEGf/gl5ZwoRTDjzNDh7cjxjgwdGSKne8ss4WX
oC8bkBI9UQVzG6t6+aHP6+BLkNfhV/eeJYG0P/Oc33ydZ+UAgKNk97bZPdTy2eml
Yh3f/EqqkDlKMRaQl6bKc/4rm4qtRmhG2bYAtmQb+rDj4J98zR5nXSm2J8j+cJw0
cT8G91vBlpIZ5nj8fOHMkv67F/+/7xfYDOaKTxnx9jixnOUKj1z2hWZAjlGvYlbr
KWqblaysowmOw4Lgi60oT4DGQ0yYbtkfh0J+9AUyi0OMRc9sih8Gzz6/+KPh6yIY
eCNSaqjaJxVEh4j75OKFGj1+rWQrQyfu4voaGUxT17pEpQiKlUsidTU5VN23Apu2
jdbDtYltreEVaT6X0AoDOankevkepDo5kTev9Ltv3Y7VOVCg/yqNeoG2x1AEnr7z
xV30LUWv/ATDNp0NNT/BngzXxn0HG+gtcxFq8pBfmYUUFbj6scVWVGhcaM+VIipO
Kc94JZ7ixz/nCo8nBJQ482I5vpQ8hqOfmW2KCPIOutqfpAf+jV/yx/IaTN4Lf//6
YQAPl8tFXfuB61KoABX8JoIeHQ2j8b9vikHVN3D7TRZBAfTYiEs=
=e6Uj
-----END PGP SIGNATURE-----

--PD3Ct3y1jwnkQ/rs--
