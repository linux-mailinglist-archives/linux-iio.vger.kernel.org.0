Return-Path: <linux-iio+bounces-21643-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F73B04762
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jul 2025 20:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C674A568D
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jul 2025 18:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DD627281C;
	Mon, 14 Jul 2025 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaxEzzxN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B982E36F0;
	Mon, 14 Jul 2025 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752517569; cv=none; b=gs1LwzBBXfDvU3jtWcXXCKKGmFWb2k1MHl7IFfMkvW1636w2jsQeqYHJwxlV5jfZpjt68liNphVo6AWkURk1DDpde5gheMJA4nQNjm2Z26FXuLlEqW1gQrY7udpgV8bz0nHXxAKuuZqlFC5fNUVEG9oEc6+wVOHZIySHqAvhvbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752517569; c=relaxed/simple;
	bh=7uBns91Heru1Lk/QqFnv8FFg/H39zOIOGE/9a3GPCQk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PTyfCIIFpiqMt9bdCqcMiynzUoVll1hyzX+fmTTyo2H2UE1DbNGwxckDSauAYjW3UXM1ixmTDQJRjUIKGMemfBn9m/6OEvcUyg3woIoksrJN3J/4im08KiCj2nQe9kQfNcD3rszT0fHMemSbooCaPNEdGGhl50DpMnjr0xb7TcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaxEzzxN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335D6C4CEED;
	Mon, 14 Jul 2025 18:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752517569;
	bh=7uBns91Heru1Lk/QqFnv8FFg/H39zOIOGE/9a3GPCQk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BaxEzzxNffQY/0JtNdPrTPM2eEBwC+Zsi1jnfuo830EZvpeS5ATpllJgxl+p/Q1HE
	 Hd3QHpixj6irMwkaoUhcvfK9tGGG5Tan1welVG107/x0AlHFFK1IO30zUyhpwP0Qdi
	 a6BXU1JNv10W7fc9Er/VHplVFRBc4w68XwtPJXy9CMn9SC+EpQEkzH3mKcecsVTGad
	 5uvxGJppEKch8M0nGDdhC1Zp2ISkJacaa0pPdDFWtih2aSm901ubvqzgFAvW7rAomn
	 msw7eoifsy+/siRnLClx0HsmSRgyCXBKgsfT2OUkjvFc1jdVonMlrz4dppkUENDjtA
	 Dzms5ziqK6UQw==
Date: Mon, 14 Jul 2025 19:26:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: sx9500: use stack allocated buffer for
 scan data
Message-ID: <20250714192603.5ed6ebdf@jic23-huawei>
In-Reply-To: <c4d143f1-0649-4f64-ac71-419a4b2b0fca@baylibre.com>
References: <20250711-iio-use-more-iio_declare_buffer_with_ts-4-v1-1-1a1e521cf747@baylibre.com>
	<aHE-8VDgQ7WuoA_y@smile.fi.intel.com>
	<20250713145533.5a3d4336@jic23-huawei>
	<20250713145810.31853bc7@jic23-huawei>
	<c4d143f1-0649-4f64-ac71-419a4b2b0fca@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Jul 2025 11:47:56 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/13/25 8:58 AM, Jonathan Cameron wrote:
> > On Sun, 13 Jul 2025 14:55:33 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> >> On Fri, 11 Jul 2025 19:42:25 +0300
> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >>  
> >>> On Fri, Jul 11, 2025 at 10:47:57AM -0500, David Lechner wrote:    
> >>>> Use IIO_DECLARE_BUFFER_WITH_TS() to declare a stack allocated buffer
> >>>> in sx9500_trigger_handler(). Since the scan buffer isn't used outside
> >>>> of this function, it doesn't need to be in struct sx9500_data.
> >>>>
> >>>> By always allocating enough space for the maximum number of channels,
> >>>> we can avoid having to reallocate the buffer each time buffered reads
> >>>> are enabled.      
> >>>
> >>> Ag ood one!
> >>>
> >>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >>>     
> >>
> >> Applied.
> >>  
> > 
> > Actually on second thoughts - why not a more descriptive structure?
> > There are only a max of 4 channels and so the timestamp is always
> > in the same location.
> > 
> > Dropped for now.
> > 
> > Jonathan  
> 
> I didn't do that on this one since a variable number of scan
> elements are used. But if you prefer structs for anything up
> to 8 bytes, we can go with that.
I think that makes sense as we don't really care 'what' is in the
holes when fewer channels are enabled.

Jonathan


