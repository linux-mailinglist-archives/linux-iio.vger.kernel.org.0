Return-Path: <linux-iio+bounces-20123-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B605ACACBF
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 12:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF66171FE8
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 10:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A5A202F9A;
	Mon,  2 Jun 2025 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="EpHoT49N"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch [79.135.106.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54091FFC5D;
	Mon,  2 Jun 2025 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748861431; cv=none; b=T35o1wRan1And5aF5AFeHt+Jx6x4Zr5FHLJDqDyeIbcF/bDYeAsVxR2WH1PPcdMC+Xa4Z1JaicjF2QxmOGfRD5/q9Vjw/nRqoAKurIseec7OVmFoJ/DC2aUOTsfBZUjaQ7a/aNjOcURTbWFB2jn4+O1U8jmdUUOaeKa1FVIAol0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748861431; c=relaxed/simple;
	bh=uKSIPTGI8grQKL93La9zZdaSme3BTPzgB8WrRUBiXyU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sH1+jKBJ9V0zKySk0Do6mNofxlVKVwA/bBjZ1kup+7ucvrtGsxQKTXj76aRfS60ayo+ByADymrd3Ss4Ajc8RtY5hNGCKnym5JEbZowjUTSDVHCKrwYbos/n41yc+qP4gc24c3T/5I3RwTSF364+d29MCDqg11R62Zp8mUanFn6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=EpHoT49N; arc=none smtp.client-ip=79.135.106.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1748861419; x=1749120619;
	bh=gEDAzBtI/ychlnWYt1/dVWSXOLsB0ngevZrbS1LZoSE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=EpHoT49N7K+HcgtVgjToh24lzfiY4pGuP+K863DWlKlSyuf+X5ss2Y7ydq5mNoeq7
	 WpexvFK9I9vzXWabGAT8tYO/RbGv7ta7mFmNlRp2hXEqdhkHP64IzAqI0n0SSgo5fm
	 oZm5fzFgw5pTx39v0+gTjjzh1PtZg07vjd+bWPWyG0kNX/px2fnbC23VJO0O03lfhx
	 HwV1TI86BwnFXvQi7IO3b6GM3LQXyNUx6q5zGXCOwJ88Ag5Bf8ezXGwtEf5clkUsUk
	 NXwx5W06UBa97FrVmhoCviUdISyHAZvhKlbKCwP9ni+7rtyuEAajB7/xTjw/eWJcZH
	 4eMqZbKqFL0sA==
Date: Mon, 02 Jun 2025 10:50:14 +0000
To: Jonathan Cameron <jic23@kernel.org>
From: Sean Nyekjaer <sean@geanix.com>
Cc: David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: fxls8962af: Fix use after free in fxls8962af_fifo_flush
Message-ID: <x6lmsxsz6njt22z23l3nbetlstkwn4jk5ohgtpyd23idwleeg5@szatvfu4drjj>
In-Reply-To: <20250531175302.05b2da17@jic23-huawei>
References: <20250524-fxlsrace-v1-1-dec506dc87ae@geanix.com> <20250531175302.05b2da17@jic23-huawei>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 07b493bb5879b729bcd70292aac626866652aa57
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sat, May 31, 2025 at 05:53:02PM +0100, Jonathan Cameron wrote:
> On Sat, 24 May 2025 12:34:09 +0200
> Sean Nyekjaer <sean@geanix.com> wrote:
>=20
> > fxls8962af_fifo_flush() uses indio_dev->active_scan_mask (with
> > iio_for_each_active_channel()) without making sure the indio_dev
> > stays in buffer mode.
> > There is a race if indio_dev exits buffer mode in the middle of the
> > interrupt that flushes the fifo. Fix this by calling
> > iio_device_claim_buffer_mode() to ensure indio_dev can't exit buffer
> > mode during the flush.
> >
> > Unable to handle kernel NULL pointer dereference at virtual address 000=
00000 when read
> > [...]
> > _find_first_bit_le from fxls8962af_fifo_flush+0x17c/0x290
> > fxls8962af_fifo_flush from fxls8962af_interrupt+0x80/0x178
> > fxls8962af_interrupt from irq_thread_fn+0x1c/0x7c
> > irq_thread_fn from irq_thread+0x110/0x1f4
> > irq_thread from kthread+0xe0/0xfc
> > kthread from ret_from_fork+0x14/0x2c
> >
> > Fixes: 79e3a5bdd9ef ("iio: accel: fxls8962af: add hw buffered sampling"=
)
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>=20
> That's nasty and a case I'd never thought about.  Most of the
> races around disabling end up with an extra sample or two which then gets
> dropped because there are no buffers enabled.
>=20
> We need to consider the active scan mask as part of the buffer state.
> So effectively taking mlock if we enter this code will delay the state
> transition (and change of active_scan_mask until after this interrupt is =
done).
>=20
> If David's synchronize_irq() is enough maybe that's a lighter weight path=
?

I agree if David's proposal is sufficient, I can try it.
It's something we have seen once in some unrelated testing, so it's
quite hard to reproduce :/

/Sean


