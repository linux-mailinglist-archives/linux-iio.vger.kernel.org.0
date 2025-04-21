Return-Path: <linux-iio+bounces-18407-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F966A94FDC
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B41C7A2CE0
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 11:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0C72620D1;
	Mon, 21 Apr 2025 11:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rr2SJFrz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44001208AD;
	Mon, 21 Apr 2025 11:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745233677; cv=none; b=mk2bdvp8o45Mhar5DU05ib2XxLMJyr6SwGqKAJOEqSEZ7OXfkW3WXz7iaC4lWE+SIK1DRfrN6w/jWxd4gekEeWf39RrezZJSHhfi7pU8tNS1m8oxz/IfbbaJDZBBItV8vJIIgwphJFY6CU0HqB56535XU5rca5OJB6Nkrc75OPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745233677; c=relaxed/simple;
	bh=lLnJWLHIzUQMPtcbn35c+xkIi0n5+jhxfuoOixu+odQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ffbmpI9OrW533xA9s2aZU2dHGvjzhVDq+WF4VE2i9AAnlwE7p+PZMOZBV+AbEfzqLNZfQS8wEMS++8creQxq71+9GNcKXvfd8XLpcEOQAkG1Q3u3C1gyFTFKOBPgEVnd17+7hhweCuSl3OTVInloUH/4HYUn4EhZnwx+vSrLw/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rr2SJFrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC12C4CEE4;
	Mon, 21 Apr 2025 11:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745233676;
	bh=lLnJWLHIzUQMPtcbn35c+xkIi0n5+jhxfuoOixu+odQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rr2SJFrzuo/TGHuP24xGYf+xqIY7EZ/mdAdkN4zKmF6VECmnISqBcPZZwALfO3fqe
	 qyRqgrxkyMtg5X2z07sAo8P+X8qQvv3IxHrtZ7Okmw6oq4a+UFYc+/G9RioaeuaNuG
	 qhlLs9YD75msQjrsWu4uPZ9uN4G/WNAx8Q+aAczC/D1/EvpmsFB7eE1ZFTGa+B1+rT
	 YAkJwVVE8VLSZNz9dOEsDYbRs5ozRhxlf3apNL98rsPFPYj30hoEj/qqf4EEGxjPnS
	 2KQWCKxahoKKYPf0aC85Q6MbH6asJg4a313cuROOfVXeTF5Cp5B2BAbYBlWYnAlc01
	 s9HR4xdBtJQXQ==
Date: Mon, 21 Apr 2025 12:07:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 Michael.Hennerich@analog.com, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] iio: frequency: Use SLEEP bit instead of RESET to
 disable output
Message-ID: <20250421120749.66b04533@jic23-huawei>
In-Reply-To: <CAKUZ0zLMAZFHwvuqfoL6JZfphYRhtjkqOyi50_ZffbA7-4MCew@mail.gmail.com>
References: <20250417135434.568007-1-gshahrouzi@gmail.com>
	<aAQZrhBLQCa0TjOJ@debian-BULLSEYE-live-builder-AMD64>
	<CAKUZ0zLMAZFHwvuqfoL6JZfphYRhtjkqOyi50_ZffbA7-4MCew@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 19 Apr 2025 21:41:50 -0400
Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:

> On Sat, Apr 19, 2025 at 5:45=E2=80=AFPM Marcelo Schmitt
> <marcelo.schmitt1@gmail.com> wrote:
> >
> > On 04/17, Gabriel Shahrouzi wrote: =20
> > > According to the AD9832 datasheet (Table 10, D12 description), setting
> > > the RESET bit forces the phase accumulator to zero, which corresponds=
 to
> > > a full-scale DC output, rather than disabling the output signal.
> > >
> > > The correct way to disable the output and enter a low-power state is =
to
> > > set the AD9832_SLEEP bit (Table 10, D13 description), which powers do=
wn
> > > the internal DAC current sources and disables internal clocks.
> > >
> > > Fixes: ea707584bac1 ("Staging: IIO: DDS: AD9832 / AD9835 driver")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > > --- =20
> > Looks okay.
> >
> > Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> >
> > Unrelated to this patch but, if anybody be looking to work on getting t=
his out
> > of staging, I think maybe this driver could use out_altvoltage_powerdow=
n ABI
> > instead of this custom out_altvoltageX_out_enable.
> > Crazy thing this driver doesn't declare a single IIO channel.
> > Seems to be somewhat ancient IIO driver. =20
> I can start tackling this.
This has crossed with a series from Siddarth.

Take a look at what is in:
https://web.git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=
=3Dtesting&id=3Daa703203cbbca22ac46d42d4cd41232491827152

Please rebase this one on top of that as I think the bug is still there?

Given there is work going on for this driver and the bugs are ancient, I'll
not take any patches through the fixes tree for now. Instead I'll just queue
them up for the next merge window.

Thanks,

Jonathan

> >
> > Regards,
> > Marcelo =20
>=20


