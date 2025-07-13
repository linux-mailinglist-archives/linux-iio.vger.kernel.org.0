Return-Path: <linux-iio+bounces-21606-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEE6B0314F
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 16:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328DC17A823
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 14:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67AC1F03D8;
	Sun, 13 Jul 2025 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQDacUnR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9472BA920;
	Sun, 13 Jul 2025 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752415319; cv=none; b=Z+Y75xAW8Zvq5ii4/r2JQ3wZA39e15vO5rEnB4gWScI699XhdjS6cY0ymqQcl8MPxJbug/GqnVyIgRGrbN0R7tbbz5bSEjcRs0FpkI96skkodoW2b44iTGnnjxFKgTiIJ3G9fwfAYu4Xxx9TmK5g2Fd76Ios6uyEcfh/Uc55UHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752415319; c=relaxed/simple;
	bh=EiiFDA4oGt9ZZBpT0IJ3IlFrat7RfYA9w3fcGggIXBM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldOJrHr+Khz5Y6MGhOJro+TStoSToC2kPHQ2N9kpxWB0jlrZ3WYl3Ca4EsAxbj+fEwobMUPvZlwJWV7J/h/7PTge6MvvwbKLiUMM+I5jcAaKeXsACGSmLJS6mOg4Y754EOr5e2mqmeEbOJ6Vpl1PT+q6ESxuwxpIYe/1xFl8VQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQDacUnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6675C4CEE3;
	Sun, 13 Jul 2025 14:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752415319;
	bh=EiiFDA4oGt9ZZBpT0IJ3IlFrat7RfYA9w3fcGggIXBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JQDacUnR4+4f3snK7EgWRHLzq0y/6XnQBS1+RbAPrXgv8b71cjfNiU7nta909V1fq
	 OaoaK/BSxgPF/kCH/lSoxU/h0y4Lfct/K2dO7xw8pmW1ixyIJ6HAwQG6ZSSmGo4iv4
	 mucqTPLh0FWkaigFcrnf9fgxZkvRhmD9/j+1l5ESkF1Mf1wyuzJcSnzvM2wR9LeE4O
	 ma+DUKFpJb61oifHU1jlnw/ZmUxoLBrsPIfAxvE5IBkHu9/slD4jhM29EbMEnmc7Rs
	 5Pb/MTGOQZmFsk0KT80sbN+RXVvAg7STOajaDUFuU4mGYHc/QrwPoQvYbR0CiJv1Gx
	 ajfH2IOGWrlhQ==
Date: Sun, 13 Jul 2025 15:01:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Andreas Klinger
 <ak@it-klinger.de>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: srf08: use stack allocated scan buffer
Message-ID: <20250713150151.17c02007@jic23-huawei>
In-Reply-To: <3372c362-96cb-4ca7-aeba-89a72e065dea@baylibre.com>
References: <20250711-iio-use-more-iio_declare_buffer_with_ts-6-v1-1-25c70b990d6c@baylibre.com>
	<aHE_ecZNTgRW79VU@smile.fi.intel.com>
	<3372c362-96cb-4ca7-aeba-89a72e065dea@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 12:07:10 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/11/25 11:44 AM, Andy Shevchenko wrote:
> > On Fri, Jul 11, 2025 at 11:07:20AM -0500, David Lechner wrote:  
> >> Use a stack allocated scan struct in srf08_trigger_handler(). Since the
> >> scan buffer isn't used outside of this function and doesn't need to be
> >> DMA-safe, it doesn't need to be in struct srf08_data. We can also
> >> eliminate an extra local variable for the return value of
> >> srf08_read_ranging() by using scan.chan directly.  
> > 
> > Why not with macro?
> >   
> 
> In cases like this where there are a fixed number of data values
> read, the existing pattern is to use the struct like this. Furthermore,
> IIO_DECLARE_BUFFER_WITH_TS() implies an array and usually we try to avoid
> arrays with only one element.
> 

I'd go a little further and say that to me structures are appropriate
even with multiple channels as long as they location of channels that
we are naming differently doesn't change.  That normally (but not always)
means the timestamp channel as the other channels tend to have the same
type.  So in practice if the channels take up 8 bytes or less before
the timestamp.

Jonathan

