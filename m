Return-Path: <linux-iio+bounces-24519-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D15BA6CD1
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 11:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47347171EAD
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 09:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E952D24B4;
	Sun, 28 Sep 2025 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHoiUTtC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E4A22370A;
	Sun, 28 Sep 2025 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759050766; cv=none; b=JeWO3klYng+6Qu7JyNdZh+nZRCjbHkkIoLyTokEXJZVyyWg3OcQ056dDIB2oCtD3WuyMi5YRqf7QlDglhmcRaJ47A2OclPHf6re/OI0k75/5F9HW+9hx3T9eMjjF6L4qEw+6c0thq5ucIVunpkuqwXv9RLivQ6MASbMej6SoyQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759050766; c=relaxed/simple;
	bh=gv0mwKjApzRim+uiFWzLIlgdmVsByXX1A64SY1PcRWo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kthuHnIzSjXkHnxDMdAuldcearIiVppntIPmdPJgeM6s6FqpvJzHv6QJsNAHx+xhgdbchepTAKgOtDg+ZD7dAcypoqL6mw9OLNp3oIpHe5r2/ggIIAQ2J4THb4JploBFtVv1d5WmAMYz7Q2vrsElgBD7ghbYO2bgWhrV23eA4Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHoiUTtC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D867BC4CEF0;
	Sun, 28 Sep 2025 09:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759050765;
	bh=gv0mwKjApzRim+uiFWzLIlgdmVsByXX1A64SY1PcRWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CHoiUTtCOxUXmJDcitLjRhowgfC8di6IWncVapUvoJvBG/m49eU76Zo9tVLpHskAH
	 ft2FbSEmjRqmZMzsnWQRsBxFf4mROY4E2Y1ZA32iMnnGr2vhXWVuvZdpCTVG0qJr7U
	 KKr6YkH6ZffLmbeZhy6aKPi5xWi85tAYdm4nRRg1vJRzUXTo2ZkerscLzFFoqKEYGI
	 QKkwFYyROUYiHf0qfqxBsjvhPFysTwwP+H+AzSR62j5NdWfoaNJ7z7RkYThIdkfhOK
	 9GQUEBVtpfeKnavVUSV/Ii/5XNaNZdWl6CcmeKE62/gxprKvmX5yjfMt2uPzTc3ZsE
	 o9AYwQ5jkD1BA==
Date: Sun, 28 Sep 2025 10:12:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: dan@dlrobertson.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: bma400: Refactor generic interrupt
 configuration
Message-ID: <20250928101241.27a51491@jic23-huawei>
In-Reply-To: <CAE3SzaRfeU9E78YNCofjgRZf76pDFEGxDdA9XwTF2_WAb8zj4Q@mail.gmail.com>
References: <20250925170942.259314-1-akshayaj.lkd@gmail.com>
	<CAE3SzaRfeU9E78YNCofjgRZf76pDFEGxDdA9XwTF2_WAb8zj4Q@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 28 Sep 2025 00:13:46 +0530
Akshay Jindal <akshayaj.lkd@gmail.com> wrote:

> On Thu, Sep 25, 2025 at 10:39=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gmai=
l.com> wrote:
> >
> > Refactor generic interrupt configuration to replace hard-coded
> > register values with logical macros and enums, thereby making the
> > configuration understandable and in-style with common kernel
> > patterns.
> >
> > Introduce a const struct with a helper to map event direction to the
> > corresponding generic interrupt and sanitize the input before use.
> >
> > Rename activity_event_en() to generic_event_en() to better describe
> > its role in activity and inactivity detection.
> >
> > No functional changes done.
> >
> > Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
> > ---

> Hello Reviewers,
> After waiting for a week, I have sent v2.
> Requesting your valuable feedback on this.
Hi Akshay,

Really minor process thing.

Even for a request like this, which should have been under the --- in the o=
riginal
post of v2, crop the content to what matters.

Also, no need to say this at all really!  You waited a reasonable amount of=
 time
given you had some reviews in during that week, and the rest of the comment
is kind of obvious.

So this reply mostly added noise to a busy review queue!

Jonathan


>=20
> Thanks,
> Akshay.


