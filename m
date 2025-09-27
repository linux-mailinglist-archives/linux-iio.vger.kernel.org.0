Return-Path: <linux-iio+bounces-24509-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F811BA628C
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 20:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF334189DA9C
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 18:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED585235354;
	Sat, 27 Sep 2025 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkixrEXc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57838287E;
	Sat, 27 Sep 2025 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758997560; cv=none; b=sTYUrA5Fc1a2YyLajP6/kBUdZKb4MtQSOHTqENABigQyX+hzzsEjeP4ij5yeDaRu8veoF9H0y/z7vpL8LDBWZVU0lQH/8BmI0UpEUlURdMook1MSWGG8PVpPKAPzGCm68myb5HDqmW0Gw8PlE5hqMBdfoAlpGM83QEdsRmK8I7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758997560; c=relaxed/simple;
	bh=5AohPTr2+c8jQEYpZTTD+q2W5++EaumlSV3+7UljG9E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CR9CNC+JLKdKkqsaYR47zsX9ZTIO//gv0RlreVWVDLLj4XzsvT0yiIHJJq+hFi2a6LbUWvzWXLGgBC/dLjWFTF8D/FWJW8HYKUtEHwbBtvGiL9jyJP1CutWRQB9G3WyZV+ix2Bz3j5/BPO+B8RfYQbhB9Wvty5c1xDP0IdUmuzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkixrEXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22905C4CEE7;
	Sat, 27 Sep 2025 18:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758997560;
	bh=5AohPTr2+c8jQEYpZTTD+q2W5++EaumlSV3+7UljG9E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FkixrEXcQu+SsQBatEpVz5iYXfeO/EBIbPMP+izHUsoDRnRb8if/Zs1oPm/2+l1iN
	 gPfzX0nmRGJ0L6MFCifQiLOnQ7IUxxMSQuep/TTielHnDxzP9DjUDHPtko0XekVNa6
	 j3sggWx7Jc+y71Oq3eS+u4bcjSfpzqi81a3RTZqQo4gHxwDPAGBtIF2TsGn5Csc/2N
	 PiTGFRLQFZMvj9UZt8gH5dD3UXPBYN/xSttRbhnc68fK9vLtXA615PFB0wKbBpS1E7
	 wk/YnRU2hbnsB0qrK3aVgtDLTMXcuRxN8mSQJc2Afi3N8bPkqyM6mwBXF0vi4QuY1X
	 7qFRhgbDz5oOQ==
Date: Sat, 27 Sep 2025 19:25:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Michael Hennerich 
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= 
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad7124: change setup reg allocation
 strategy
Message-ID: <20250927192551.2b81d838@jic23-huawei>
In-Reply-To: <3bbd51983f5bf67b6fd061f28b8b260370beac70.camel@gmail.com>
References: <20250923-iio-adc-ad7124-change-setup-reg-allocation-strategy-v2-1-d9bf01bb3ad8@baylibre.com>
	<3bbd51983f5bf67b6fd061f28b8b260370beac70.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Sep 2025 13:27:00 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2025-09-23 at 16:48 -0500, David Lechner wrote:
> > Change the allocation strategy of the 8 SETUP registers from a least-
> > recently-used (LRU) to a first-come-first-served basis.
> >=20
> > The AD7124 chips can have up to 16 channels enabled at a time in the
> > sequencer for buffered reads, but only have 8 SETUP configurations
> > (namely the OFFSET, GAIN, CONFIG and FILTER registers) that must be
> > shared among the 16 channels.=C2=A0 This means some of the channels mus=
t use
> > the exact same configuration parameters so that they can share a single
> > SETUP group of registers.=C2=A0 The previous LRU strategy did not keep =
track
> > of how many different configurations were requested at the same time,
> > so if there were more than 8 different configurations requested, some
> > channels would end up using the incorrect configuration because the slot
> > assigned to them would also be assigned to a different configuration
> > that wrote over it later.
> >=20
> > Adding such tracking to solve this would make an already complex
> > algorithm even more complex.=C2=A0 Instead we can replace it with a sim=
pler
> > first-come-first-serve strategy.=C2=A0 This makes it easy to track how =
many
> > different configurations are being requested at the same time.=C2=A0 Th=
is
> > comes at the expense of slightly longer setup times for buffered reads
> > since all setup registers must be written each time when a buffered read
> > is enabled.=C2=A0 But this is generally not considered a hot path where
> > performance is critical, so should be acceptable.
> >=20
> > This new strategy also makes hardware debugging easier since SETUPs are
> > now assigned in a deterministic manner and in a logical order.
> >=20
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > --- =20
>=20
> Hi David,
>=20
> LGTM
>=20
Agreed.
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the testing branch of iio.git.

