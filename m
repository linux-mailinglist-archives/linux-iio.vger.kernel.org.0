Return-Path: <linux-iio+bounces-27301-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4217CCD4520
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 20:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 098323006A4D
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 19:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482C02FF66C;
	Sun, 21 Dec 2025 19:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxrvQ47/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025E1286897;
	Sun, 21 Dec 2025 19:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766346524; cv=none; b=Xl3D0UekbwV38R/hKL+UxZiUmIGsp+x9CVNPUsuLycU8fnQoO2dFyLxKoQ76MItmEHixPztTMpWuRtY6kgIbItCO/m0CltEJFJ9CrQmph5sc0GMD/MTJRbEbfqeWjNMAzD2+Qt3Puu/k7vRkbiNW22/tf48frYrbEfgzeaUGAoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766346524; c=relaxed/simple;
	bh=/F2BzLQfSHQEFB46RNmMVY8TQCd7GTq64903j25nBpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4c3dVoK/b735PRc/pQ9g3hNhAUfkiXxKE2aIPDhlY2B+ojFGGVcBMV4OHKA7VBetNgR0eFROrPa3swQeb7FUwE7e2v+n2wl2GkYRLQ/bH8TLarkBjHd4czc2rJ4aJA90UcVp8lBisSiTSkxFOULV0ntkiKfPU3wA3QPoXNc9qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxrvQ47/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F90EC4CEFB;
	Sun, 21 Dec 2025 19:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766346523;
	bh=/F2BzLQfSHQEFB46RNmMVY8TQCd7GTq64903j25nBpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VxrvQ47/1xx3WvHLombnSHJ6TDXTNQq0D8oGVVj17869NuvMohAMg2wT0AHNfp5+4
	 ot8i2u6QHTDx8TpId+643beEagpLSQZnUFp43/vvuZeGDm5cgQ/TFgHKd7Ca2uPR2M
	 tk5hwonPSBiitgAHIm9HzW30ArYMKTIwe5sABByHWHoHjZ7fWgJj+LIvv1C6NfsYVr
	 UwIf69Nk4Ylgx0B3caI38P/TxO7y7tsycp6bYlaCu7d4nI3pv9Q83gOGMzPNyI4w1J
	 fGpjucm82diUfRJ5lEnwxFF9L76RDD92OsDK2qZoWvqo9s1z52G9CM2MHYxlytIpAP
	 iDz1nRgKplTEA==
Date: Sun, 21 Dec 2025 19:48:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Yury Norov <yury.norov@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7606_spi: use bitmap_full() in
 ad7606_spi_update_scan_mode()
Message-ID: <20251221194834.0dd42eb4@jic23-huawei>
In-Reply-To: <e1284b0c-3ad5-4c54-aa58-30f416aa98f8@baylibre.com>
References: <20251216001808.333053-1-yury.norov@gmail.com>
	<aUCmZk0S_tq3SOOY@yury>
	<e1284b0c-3ad5-4c54-aa58-30f416aa98f8@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Dec 2025 18:26:46 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 12/15/25 6:23 PM, Yury Norov wrote:
> > On Mon, Dec 15, 2025 at 07:18:06PM -0500, Yury Norov (NVIDIA) wrote:  
> >> bitmap_empty() is more verbose and efficient, as it stops traversing
> >> scan_mask as soon as the 1st set bit found.  
> >  
> > Ah, please read this as:
> > 
> > bitmap_full() is more verbose and efficient, as it stops traversing
> > scan_mask as soon as the 1st unset bit found.
> >   
> 
> I think you mean "bitmap_full() is less verbose"?
> 
> This isn't a hot path, so efficiency isn't important.
> 
> This makes the code easier to understand anyway, so a worthy change.
> 
Tweaked patch description as discussed (with a more inserted
before efficient as it's "less verbose and more efficient" and applied.

Thanks,

Jonathan
> 
> > Sorry for miswording the commit message.
> >   
> >> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> >> ---
> >>  drivers/iio/adc/ad7606_spi.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
> >> index f28e4ca37707..7e17ccbcedd0 100644
> >> --- a/drivers/iio/adc/ad7606_spi.c
> >> +++ b/drivers/iio/adc/ad7606_spi.c
> >> @@ -345,7 +345,7 @@ static int ad7606_spi_update_scan_mode(struct iio_dev *indio_dev,
> >>  		 * has no way of demuxing the data to filter out unwanted
> >>  		 * channels.
> >>  		 */
> >> -		if (bitmap_weight(scan_mask, num_adc_ch) != num_adc_ch)
> >> +		if (!bitmap_full(scan_mask, num_adc_ch))
> >>  			return -EINVAL;
> >>  	}
> >>  
> >> -- 
> >> 2.43.0  
> 
> With the commit message fixed:
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 


