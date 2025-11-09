Return-Path: <linux-iio+bounces-26095-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E8FC44285
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 17:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563251884708
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 16:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73C3303A2A;
	Sun,  9 Nov 2025 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNgRTevb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613691FAC42;
	Sun,  9 Nov 2025 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762706326; cv=none; b=C+1KlKycPJYpb9rAqIS3xmNPlWwf2BbNFNNQN6VU70XRkuciu7m1wYBVlza82XDWIGK7yZSJ3fO8S7N/oFuFoIZtvolXUM9Lbq8DnRgSh9xKTlUvk96pyDICaqqwZEe6FTkjToi+YFI86ADsZvB4DMJiF3sf+LmBhfE89vuKQ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762706326; c=relaxed/simple;
	bh=tyUFY2EVCKcCKGylmHqPrCF4+Regt0Z1xbdOg2MeKdA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HVjWedI5svUc7nRuHNg8Kyko1eU7Sx4Iakx5OoPF0Dg+U1/t+mlWp1PZXu9leOPpZ9GWWAeBRuMYf4ZbHJKO9nFyjnvfuqnzBarjK9wAC6RxhlP8O9N2f6Gv/DVVwAIvp0P0qbThlmQiOJXIwx+7ivYP1USrkFP+F+W5WlLr7n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNgRTevb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD15C4CEF7;
	Sun,  9 Nov 2025 16:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762706325;
	bh=tyUFY2EVCKcCKGylmHqPrCF4+Regt0Z1xbdOg2MeKdA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nNgRTevbyQn1SM/yHdbbKUOALQlamILo5IBnDJLl6QKMPiqf/+qLJ+0UGcOr2cVRX
	 RB2ynW5psFNYszlXuxEv2MyT40C+LF0irdT3G/Wg+gCx+omekS5ahGuFm3YwlSlKOf
	 Dl8Pf5m+v3Qs4lCTESzn+JmtVTEMG3Sajg5yRi3vsb+Kwba7Wqw7Ml/vwt+WaqjBFk
	 9yajWV4RxeR92P4pp1GJOj4G+ow5ML4BAx3LrPXHV6V8lM/fNZFROJiGDafatEgy4h
	 pdV/L1ZxcA4tRawWuCZ0mLp3G2OfrnM2T2X4lmw/wetbqTMhgt4YoyIBg5Sd57/7pC
	 CCl/keBUksy9A==
Date: Sun, 9 Nov 2025 16:38:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Antoni Pokusinski <apokusinski01@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: mpl3115: use get_unaligned_be24 to retrieve
 pressure data
Message-ID: <20251109163840.64144586@jic23-huawei>
In-Reply-To: <aQ1MfTu24hhk-dKP@debian-BULLSEYE-live-builder-AMD64>
References: <20251105095615.4310-1-apokusinski01@gmail.com>
	<20251105095615.4310-2-apokusinski01@gmail.com>
	<aQ1MfTu24hhk-dKP@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Nov 2025 22:33:49 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 11/05, Antoni Pokusinski wrote:
> > The pressure measurement result is arranged as 20-bit unsigned value
> > residing in three 8-bit registers. Hence, it can be retrieved using
> > get_unaligned_be24 and by applying 4-bit shift.
> > 
> > Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> > ---
> >  drivers/iio/pressure/mpl3115.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c  
> ...
> >  
> > -		*val = be32_to_cpu(tmp) >> chan->scan_type.shift;
> > +		*val = get_unaligned_be24(tmp) >> 4;  
> hmm, now the number of bits shifted is dissociated from the channel characteristics.
> We can do
> 		*val = get_unaligned_be24(tmp) >> (24 - chan->scan_type.realbits);
This encodes that the field is always aligned to the maximum bit. Whilst it might
be true, there is nothing inherent that says it must be.

I'm not sure why we aren't using chan->scan_type.shift though.

> or maybe
> 		*val = get_unaligned_be24(tmp) >> (sizeof(tmp) - chan->scan_type.realbits);

That one needs a BYTES_TO_BITS factor too.

> but it starts becoming too long IMO. Even longer if `tmp` gets a more meaningful
> name. Ah well, any of the three forms should work the same at the end of day so
> no strong opinion.
> 
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> 
> >  		return IIO_VAL_INT;
> >  	}
> >  	case IIO_TEMP: { /* in 0.0625 celsius / LSB */
> > -- 
> > 2.25.1
> >   


