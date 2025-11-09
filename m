Return-Path: <linux-iio+bounces-26107-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86483C44394
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 18:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F283B3657
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 17:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C814305055;
	Sun,  9 Nov 2025 17:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bys4K04C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A542765FF;
	Sun,  9 Nov 2025 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762708493; cv=none; b=sdmu+5RtFrcTI7l34jQzJ5tEh4MCuHNA4Fq04ouKfJ70/w5XNkwFfcY91NS9rjCYKKhKKNfLPhqNKNMuwfDXlFQImOIhU5ISABbu2m4LlVNe8i+PdDOcgo59V2rqoBdJvtk7dAaVBMWErpwxrmdcaHrrjBKjpiqg8lsjxOJ6zVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762708493; c=relaxed/simple;
	bh=CSCIaZN7/P/wHRAqhtJfxVcJKevgiJvzZ1FjoMQY9ko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rKfVyEnX9zG4K74EcJf5eOCIFC8P0eRWmp2U7UeAoDwC0h0rd5dh0E02g2aipGYQfu2wrr9UsA6hm1vwetDxb8rR0l3gU80SsWBZ4Ni9N5kxtl8hZ62sDlW16N/gxmnpDkPKp4tGJWq4oP1dZR87ZT/cUAb67bXsKAOwO2cDdgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bys4K04C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D583AC19422;
	Sun,  9 Nov 2025 17:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762708492;
	bh=CSCIaZN7/P/wHRAqhtJfxVcJKevgiJvzZ1FjoMQY9ko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bys4K04CgEbZ4MuKYMz7PGNO5UvQ9awSuRSznxPeahXdYXM96+btw1NXBPQ+G6Yn/
	 um2GEJqZwws9IOFYsVS5PRaeHWLB0rHUgfit2vwPvQZNxV0onqlWg+B1uc+C798hj8
	 UL6P9kyHrec/5vChaxaZhFw2F9OMk8X1SwT+KvLltUB6NVmBCsg5ZWF6SF+TPWry4W
	 n/PPU8ZrTqskgU1tAyD03/CRG+zLC2RLUJLFxXjzuiNmH31czRqlqq4UT7+rsPmSgC
	 J2iIsWwf2IaSFJEzy0eCXl7KL+yAZ01Z2nudEioFH04jwIOd8PgvEDjul2DY6cZb4M
	 KgMYwOdbzTWaA==
Date: Sun, 9 Nov 2025 17:14:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Luca Weiss" <luca.weiss@fairphone.com>
Cc: "David Lechner" <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Documentation of iio_read_channel_processed return value
Message-ID: <20251109171422.0463d885@jic23-huawei>
In-Reply-To: <DE3I8OHQQD0F.2VTQS2PET9MI0@fairphone.com>
References: <DE3I8OHQQD0F.2VTQS2PET9MI0@fairphone.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 08 Nov 2025 18:55:08 +0100
"Luca Weiss" <luca.weiss@fairphone.com> wrote:

> Hi all,
> 
> I've noticed that the docstring in include/linux/iio/consumer.h for
> iio_read_channel_processed (and likely some other functions in there) is
> wrong because it's saying "Returns an error code or 0." while often it's
> returning e.g. IIO_VAL_INT. In some code paths it's actually returning 0
> but it seems in standard cases it's not.
Hmm. Looks like we have a bug in handling the path that ends up in iio_multiple_value()

I think we just want to change iio_read_channel_processed_scale() to check
that the return value of iio_mutliple_value() < 0 and return ret if so, otherwise
return 0

So to me smells like a bug and the documentation is correct.

Good catch, perhaps spin a patch like the above?  This is made more complex
because a few drivers seem to assume IIO_INT_VAL such as iio/afe/iio-rescale.c so
we will need to fix those up as well.

J

> 
> Could the docstring please be updated so this is clear to users of this
> function? I don't understand IIO well enough to confidently propose
> changes there myself.
> 
> Thanks and kind regards
> Luca


