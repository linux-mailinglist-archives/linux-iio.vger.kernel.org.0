Return-Path: <linux-iio+bounces-1665-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A3382D1BB
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 18:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785B7281D60
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 17:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F33FDDB5;
	Sun, 14 Jan 2024 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/DzUC4p"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA5CEAE3
	for <linux-iio@vger.kernel.org>; Sun, 14 Jan 2024 17:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B141C433C7;
	Sun, 14 Jan 2024 17:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705253627;
	bh=xPfc01Bev6avUkZcJRtKmBsKV9Mc7pkDCqGbGsxgxy0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j/DzUC4pvQlDPPIC77jYrT/mOLRGi9B8ByW1yvtvGp+lB17MTJIaMWRhaD1DC5kyg
	 V0ARRQG27G1ZAtfeNZs2bjsaK75auZM6g1zyDEN3809G1NqhUuuj2a4laUCx+6srHh
	 WHAgGLpx7RssVfxTg2lgJZlEhly0ovnzMCir8tw8emKoAOKSBFJUqLfydrADypjP0k
	 rrlQDQt1YdiicjJniy7cczzp/XJX+DUoatE2RPA3f8twqyBj3Al8H/YbLWy0c6gp4X
	 E+AZSVZJDJF0tiAX/G47ZgSGWriOs0/j6CWNHHmQWSbJ1MMrxwudOVOoL6ZOaSaPdJ
	 I7gQzG+8jr+VQ==
Date: Sun, 14 Jan 2024 17:33:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC PATCH V2 00/10] IIO: Use the new cleanup.h magic
Message-ID: <20240114173336.360443cb@jic23-huawei>
In-Reply-To: <CAMknhBF1fyop-s38psUmKc8KVZ30psEtica3g2tZPczYN70=DA@mail.gmail.com>
References: <20231217173548.112701-1-jic23@kernel.org>
	<CAMknhBF1fyop-s38psUmKc8KVZ30psEtica3g2tZPczYN70=DA@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 17 Dec 2023 19:10:48 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On Sun, Dec 17, 2023 at 11:36=E2=80=AFAM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > A lot of the advantages of the automated cleanup added for locks and si=
milar
> > are not that useful in IIO unless we also deal with the
> > iio_device_claim_direct_mode() / iio_device_release_direct_mode()
> > calls that prevent IIO device drivers from transitioning into buffered
> > mode whilst calls are in flight + prevent sysfs reads and writes from
> > interfering with buffered capture if it is enabled.
> >
> > Relies on Peter Zilstra's conditional cleanup handling which is queued
> > up for the merge window in the tip tree. This series is based on
> > a merge of tip/master into iio/togreg.
> >
> > All comments welcome. If this looks positive I'll make use of it in a
> > lot more drivers, but hopefully these give an idea of how it will work.
> >
> > The need to always handle what happens after
> > iio_device_claim_direct_scoped() {} is a little irritating but the
> > compiler will warn if you don't do it and it's not obvious how to
> > let the compiler know the magic loop (hidden in the cleanup.h macros)
> > always runs once.  Example:
> >
> >         iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> >                 return 42;
> >         }
> >         /* Can't actually get here, but compiler moans if no return val=
 */
> >         return -EINVAL; =20
>=20
> Maybe better would be?
>=20
>         unreachable();

Interesting thought, but there is very little precedence for using that in =
the kernel.
+ I think it's a C23 feature so we'd be relying on whether gcc and clang ha=
ppened
to implement it rather than being sure it was available.

Jonathan


>=20
> > } =20


