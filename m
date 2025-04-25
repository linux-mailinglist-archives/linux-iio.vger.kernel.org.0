Return-Path: <linux-iio+bounces-18624-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33266A9C0D4
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 10:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271341BA6976
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 08:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ADC234963;
	Fri, 25 Apr 2025 08:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsrU7/G1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFB322F16C;
	Fri, 25 Apr 2025 08:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569159; cv=none; b=eZFHIx9roJqLINqdZNgfmzOiCY2JOTZMLTKOTSWFh7/NCo8alatu81o8HdD7gOIkSWEOw9SwuJZHxVd1f0zC4ktzd48s+L9bsLJ1M+Xna9lVWc27id3Vhhs9kSfDolIbprtSAkhKKJFnp0uJz0zOZJYHP8tMuJYKp53SluiMrRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569159; c=relaxed/simple;
	bh=OrwBz+EwRHtxPq45tTkIGnSGl2Ieqh3Kx4b1WiQTSnE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jxuCD6KRL5w4NYI81ply7iNUpT35+fEVlah/meQ2BKH4OdSMTy7+rGbFoXVfcStAfD6qU2nFsyBQHp2nqRBYfxrUYDfAJdrHDXg7rTUzkqrjRLDzzoyN0qE8s26wnCUr5W1qFiRxS7pHvHquGORcrapvddMAVEx0UIBiYFMuSfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsrU7/G1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922A0C4CEE4;
	Fri, 25 Apr 2025 08:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745569158;
	bh=OrwBz+EwRHtxPq45tTkIGnSGl2Ieqh3Kx4b1WiQTSnE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BsrU7/G1tEVDfu/Bxo/TouQqim+5s9/2Z/QB/85HcSw1rAk/+Epepgn2lRAEoyDwD
	 dq1HRL5BGOYFyGH/26VNSMK5fpSXI6vlZ2fZgn1WChC6uFE7kWi2BLZhLBo5qb1I8X
	 B1wbZRkIAwOef5Yhdv9AsKrbBCXrHmtJ56PwxHe6rrapD8fS5qDdBgjI+GMNPm3Xsq
	 nGpkx/aCkJm3qcIkPI8FwimjEFIgFPXvu/npVYaUpLAjLS3Vl0VzGXrnT7IH6qxgI+
	 NeR7uziCDCfdt1kqI0A5xL89GaEWIw8AoYhIzN68ZV+Wl+48T17u70+VMguZiW8aRq
	 cdCo1D53uFMcA==
Date: Fri, 25 Apr 2025 09:19:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 Michael.Hennerich@analog.com, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3 3/3] staging: iio: ad9832: Add minor improvements to
 ad9832_write_powerdown
Message-ID: <20250425091910.545bdce7@jic23-huawei>
In-Reply-To: <CAKUZ0zLgH9Ec5FMEjXa59-bBEVooEQUOeGuZ9OJw=A3P3OWp5A@mail.gmail.com>
References: <20250420175419.889544-1-gshahrouzi@gmail.com>
	<20250420175419.889544-4-gshahrouzi@gmail.com>
	<20250421124044.400628f1@jic23-huawei>
	<CAKUZ0zLgH9Ec5FMEjXa59-bBEVooEQUOeGuZ9OJw=A3P3OWp5A@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Apr 2025 18:29:57 -0400
Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:

> On Mon, Apr 21, 2025 at 7:40=E2=80=AFAM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Sun, 20 Apr 2025 13:54:19 -0400
> > Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:
> > =20
> > > Minimize size of type that needs to be used by replacing unsigned long
> > > with bool. Avoid redundancy by checking if cached power state is the
> > > same as the one requested.
> > >
Hi Garbiel,

Quick process comment given you are sending quite a few emails (which is gr=
eat!)

Please don't bother replying to say you are doing something suggested.
Focus any reply (including cropping irrelevant context) on what you want to
discuss.  If there is nothing to discuss your reply is effectively the chan=
ge
log of the next version of the series.

Even a simple email like this one takes a little time for reviewers to look
at and they gain no extra information from doing so.

Thanks,

Jonathan

