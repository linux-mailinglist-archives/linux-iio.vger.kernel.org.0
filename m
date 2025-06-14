Return-Path: <linux-iio+bounces-20640-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C337EAD9CA5
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 14:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A749178EDD
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 12:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C73F27A135;
	Sat, 14 Jun 2025 12:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGC2gZAG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B561C54AF;
	Sat, 14 Jun 2025 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749902869; cv=none; b=mZJ4TkWJ9AGiaor8YeuQZR1wuLqLyHR2ri/oyuLdBbIe06fm9bREEbpJWyxGeZ17Tl4TJIXR3miPQZU07C5URzzfwmV/nXZjVpjvseiraeNF6zocXh0TSzPzPV98BpvkOSDZ3cgUOGCtZY2HTn/46WYnO9NBBwlfM3PCoOJGAG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749902869; c=relaxed/simple;
	bh=CipqOrisvyxgV5h4+laP9fsp1V2U/t4CBUheeMs6ZVk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jd3pV48PghOyZX1wHYoRJRyGL7ZJugsfcEDByk5anRITahhKA0VI17bBMmy2CZGl70fEZAfnZ1No6AMrlFHw/tK4g8WAv22YJHIOZ0mrj04ksr0P7NjE2iZe4O/4+aL1hcYqbSkymZeZeR5xWtdZW+Re5/7Dx/Ajg7e5Xsevc5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGC2gZAG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAB0C4CEEB;
	Sat, 14 Jun 2025 12:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749902868;
	bh=CipqOrisvyxgV5h4+laP9fsp1V2U/t4CBUheeMs6ZVk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fGC2gZAGlfZHJBCF6vt6rZWPGDyn4Vso0w414xdP4S3YMaakzut1/tNNSl72cT6U9
	 O2zdrkuxZJewrlAgkFvFD/ZQ8YiMLTKQN/FoSO0DB6HuvNxvqdPXcXr93PikYiW2+i
	 rQ+y+U8MQwrAWsHp61VbzcsEIV3zWVRmm76zln14nX1Y6XLNcoR7/R8rrv8TQuLBOA
	 1VDpGD97W7K+DMkEftBuFuYH/tG6t/B0KONYQewKiFSc5jvfZqz3IKbQOdpcGeyzzL
	 N0Zh4IZ7kNzN0b79INuHm+A1xF2iZ1KBRpasfM5uSFGZbTcEBNiNJafT3ctvESaGY8
	 cEU3yfeO6cvbA==
Date: Sat, 14 Jun 2025 13:07:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] iio: amplifiers: ada4250: various cleanups
Message-ID: <20250614130741.22727cac@jic23-huawei>
In-Reply-To: <aErQ9AM_aZRTr8eH@smile.fi.intel.com>
References: <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-0-bf85ddea79f2@baylibre.com>
	<aErQ9AM_aZRTr8eH@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 16:07:00 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Jun 11, 2025 at 04:33:00PM -0500, David Lechner wrote:
> > While investigating some potential bugs, we noticed quite a few
> > opportunities for small improvements in the ada4250 driver.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> for non-commented patches. Otherwise, feel free to add it there
> if my suggestion / assumptions are wrong.
> 

I think, with exception of request for pahole (which is a nice to have
to my eyes rather than a requirement) I think all addressed by David
so applied and tag picked up.

For the pahole thing only thing I can imagine it doing is showing
a less obvious additional move is useful as this one was about as
obvious as they come if IIO_DMA_MINALIGN isn't huge (in which case
it makes no difference as we have a big hole!)

Jonathan

