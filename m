Return-Path: <linux-iio+bounces-26244-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BF7C609E4
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 19:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CFC9E35222E
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 18:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BDB2FB98D;
	Sat, 15 Nov 2025 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOxNBXsn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FFE14EC73
	for <linux-iio@vger.kernel.org>; Sat, 15 Nov 2025 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763230994; cv=none; b=NrrUFCeNrfSda4HEFOuXf4lyLYVx7Veru/KO3Gy7hj0HNcNFJvfAM3q09ZlnHQlV1t7c0i2YsQTs4gH+JGPfYwidBwE+Rkxqya8hhp7l3L0ZKrE0GLuRK1RDyOp0lO8tOg9M9C27h4W3eW3hHSJzbLxxYSGDQVGn1Nb+k4wAwCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763230994; c=relaxed/simple;
	bh=hKDdlhbAnXzzEFgRDfku4f9LHMD14SZjsqSJlFCMJbs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/jidXC5bmayQHGwTtct6p8mZcz38eh2eX+P9zjN4sBs3n8Is3zBvZT3k81u58ovCDyH5FpHFSs6as553ec0IU4hMWNuf910hcpZNjCoWfh9UFjdsDL/nAUDucjE+3qop41NDVr7/oh1ze8B9xswFr/uLvRyQyGDPsCUkgQoEtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOxNBXsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631A6C4CEF5;
	Sat, 15 Nov 2025 18:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763230993;
	bh=hKDdlhbAnXzzEFgRDfku4f9LHMD14SZjsqSJlFCMJbs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lOxNBXsnSs2d6OnFpuquaaT/AGtZEtCZuPiHsyfY8pqxVfae2+Pc7p0ekEq+SifXl
	 5vmO6HJICu38xyvLvmGJYw6M1HclgNexwQ28cuML+Eo7svwsWpdvrarZOQd0kgXXu3
	 QXKXcKxC1I8MeM1MMaGzq0B/XfN9M+4fdybeUkUTIYbNyApMxZbtsDuJs24B6Qi35t
	 9l64cK/GJORcb2dmOCQChU/afTnKGK851Tp6n32bQj1b3+IB+5mllsM/7aPktXINQM
	 Dozz1y/qKsdeTkk/vzVB22c46lJWNXQsyrskOPXaDABV5rCETlCk6VcCg1PM8aHEz8
	 BNkff+qoRhvAA==
Date: Sat, 15 Nov 2025 18:23:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Marek Vasut
 <marek.vasut@mailbox.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, Hans de Goede <hansg@kernel.org>, Marek
 Vasut <marek.vasut+bmc150@mailbox.org>, linux-iio@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] iio: accel: bmc150: Do not configure IRQ registers if
 no IRQ connected
Message-ID: <20251115182253.1f7ee5c2@jic23-huawei>
In-Reply-To: <aN1yMAeB6oDIp6k2@eldamar.lan>
References: <20250613124648.14141-1-marek.vasut+bmc150@mailbox.org>
	<79946c40-e2ce-4fbc-a6b2-b37f6fd69d1d@kernel.org>
	<6oyvsvp2erynwu3evulbg6gtdryabeuoo46qzku2grxg3jxptf@jszhnvmj2ffc>
	<30fb5c19-d4e5-4740-afc4-c15b256a99e0@mailbox.org>
	<aID9byW4WOsUExHR@smile.fi.intel.com>
	<aN1yMAeB6oDIp6k2@eldamar.lan>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 1 Oct 2025 20:25:52 +0200
Salvatore Bonaccorso <carnil@debian.org> wrote:

> Hi,
>=20
> On Wed, Jul 23, 2025 at 06:19:11PM +0300, Andy Shevchenko wrote:
> > On Tue, Jul 22, 2025 at 04:48:45PM +0200, Marek Vasut wrote: =20
> > > On 7/22/25 10:55 AM, Uwe Kleine-K=C3=B6nig wrote: =20
> > > > On Mon, Jun 16, 2025 at 02:42:54PM +0200, Hans de Goede wrote: =20
> >=20
> > ...
> >  =20
> > > > I don't have a system that triggers the problem, but there is
> > > > https://bugs.debian.org/1106411 which I guess is the same problem. =
=20
> > >=20
> > > I think the debian person is on CC here already. =20
> >=20
> > You can even Cc that bug report, messages will be added to it. =20
>=20
> I have bit lost the overview: Was there any conclusion on the right
> patch to address this issue?
>=20
> For context: In Debian we got a couple of reports more to the original
> one above, https://bugs.debian.org/1102522 and
> https://bugs.debian.org/1112643 , so we defintively would be
> interested to se the issue addressed.
>=20
> Happy as well to help affected user to test a proposed patch if
> needed, just let me know.
>=20
> Regards,
> Salvatore

Restarting this thread as we had some useful debug info recently.
I'm not sure we captured all the relevant info in the original
thread. Key here is the situation is.

1. No interrupts wired.
2. We could use it with an external trigger so don't want to disable
   the buffered support
3. The chip has a fifo mode.  That is enabled when buffer enable occurs
   with no trigger set.

It is that fifo mode I think that is tripping things up.  We should
restrict that alone when irqs aren't provided.

Now the fix is actually easy and was suggested earlier in this thread
(just don't register the buffer) but the reasoning why that is less
obvious.=20

In general we'd want to be able to use the buffer with another trigger
and so we'd want to register the buffer anyway even if not interrupts,
however as things currently stand the driver doesn't allow other triggers
anyway and doesn't register any of it's own if not interrupts. Thus
having the buffer registered is pointless.

Hence Uwe's fix is the right one I think.

Jonathan



