Return-Path: <linux-iio+bounces-25283-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014C9BF2D92
	for <lists+linux-iio@lfdr.de>; Mon, 20 Oct 2025 20:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645623AF40C
	for <lists+linux-iio@lfdr.de>; Mon, 20 Oct 2025 18:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFC32C0F89;
	Mon, 20 Oct 2025 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BB+ENQ/p"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD052BF3F4
	for <linux-iio@vger.kernel.org>; Mon, 20 Oct 2025 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983257; cv=none; b=hwprlb9MCawIrZ06rL1vk0LW4jGXZSBJpsRfxjMQazjZUfmA2pDmwk10zG0UWVUXqVlNa1SydXr9S9izbuwzNAlIX42ueHp00/cFBuKzHWDbEjazDqSGsutGTTOP3O8EnV6Din2rm9L75OhKPOstTkyXbM9Ptb/YegIuleu+IB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983257; c=relaxed/simple;
	bh=eCEYB0ZDEuXHNw9kMvML7dJuEd+/Xpd/60R6LLqtBow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rW3iUyDZR4VJUis1YMxo/KgptXp0IIk3nRp+ufSUG8KQjbV24BrXqVhTwCcwLfBqlIVSceXW2Z4vOjoisitpayNidtco5CB8IfjDwakF9oi8J6jKpt4yDvE3zUw81UMHvKwqsJKeKT6gIZXY+zji90JTeIQjc7Ou/rt6ZALmnbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BB+ENQ/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63330C4CEF9;
	Mon, 20 Oct 2025 18:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760983257;
	bh=eCEYB0ZDEuXHNw9kMvML7dJuEd+/Xpd/60R6LLqtBow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BB+ENQ/pa8wtrEaCDMhsEexQ+lrAeOrLFEYOw+zKmP21IkWHzZiWwvJM82Rk6O0Nx
	 688lDIDuCZuD7cUakHn99KciDogVWek7rLDmypdKEFZhZ9jEf7DB5keqiFBVkf8u1U
	 aMQJFDv6CnQRyv+TJa2ZBgyWm703EWhMBvTOwype+jZnOp+P/0Cx1mna8ZibqleNdU
	 +09t+jSoxvmQXlWe1b6jeN/Ir+X9xDDITtjBwqdkc6SsQc5H7ACzwc8TmyvrjIv48p
	 YXlNbQTDmXhOq3CVrro7gKjGT7O1EKNIlN+u5qOvBYLWiCv2o0R1zZfC9X9b9om8TV
	 to/xddnI6aV5A==
Date: Mon, 20 Oct 2025 19:00:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrej Valek <andrej.v@skyrain.eu>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Puranjay Mohan
 <puranjay@kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 David Lechner <dlechner@baylibre.com>, Kessler Markus
 <markus.kessler@hilti.com>
Subject: Re: [PATCH v4] iio: accel: fix ADXL355 startup race condition
Message-ID: <20251020190032.0deb54a4@jic23-huawei>
In-Reply-To: <6ced29c5-bca2-4c29-beb4-b566f4d9bf17@skyrain.eu>
References: <20251006095812.102230-1-andrej.v@skyrain.eu>
	<20251014071344.151914-1-andrej.v@skyrain.eu>
	<20251018140825.006fcb7b@jic23-huawei>
	<6ced29c5-bca2-4c29-beb4-b566f4d9bf17@skyrain.eu>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Oct 2025 12:45:27 +0200
Andrej Valek <andrej.v@skyrain.eu> wrote:

> Hello Jonathan,
> 
> On 18.10.2025 15:08, Jonathan Cameron wrote:
> > On Tue, 14 Oct 2025 09:13:44 +0200
> > Andrej Valek <andrej.v@skyrain.eu> wrote:
> >  
> >> From: Valek Andrej <andrej.v@skyrain.eu>
> >>
> >> There is an race-condition where device is not full working after SW reset.
> >> Therefore it's necessary to wait some time after reset and verify shadow
> >> registers values by reading and comparing the values before/after reset.
> >> This mechanism is described in datasheet at least from revision D.
> >>
> >> Fixes: 12ed27863ea3 ("iio: accel: Add driver support for ADXL355")
> >> Signed-off-by: Valek Andrej <andrej.v@skyrain.eu>
> >> Signed-off-by: Kessler Markus <markus.kessler@hilti.com>  
> > It doesn't hugely matter but I was only asking for a reply with the single
> > line David sent. Not a new posting of the driver.  
> Ah ok, I misunderstood it then.
> >
> > Definitely don't ever send two v4 with any changes at all as that makes
> > it uncertain what automation will pick up.  Standard b4 string to grab this
> > patch grabs me two patches with two patches as it can't figure out they are
> > the same.  
> Sorry about that.
> >
> > Anyhow, applied carefully by hand to get just this one and marked for
> > stable inclusion.
> >
> > Thanks,
> >
> > Jonathan
> >  
> Ok, good to know and thanks for the guiding. Will try to do it better in 
> the future.
> 
> Btw, you swapped my name and surname again, at least in the commit 
> (author) :).

I'm confused.  Your
From: Valek Andrej <andrej.v@skyrain.eu>
line is at at the top of the patch.

If you have one of those it will ignore whatever email address the mail came from.
https://lore.kernel.org/all/20251014071344.151914-1-andrej.v@skyrain.eu/

So I think this is a git config issue your end if you'd prefer it listed as
Andrej Valek.

Jonathan

> 
> BR,
> Andy


