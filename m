Return-Path: <linux-iio+bounces-19551-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4517AB8CDC
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 18:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4FFE1BA834B
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 16:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E9D253F00;
	Thu, 15 May 2025 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOUMa/Of"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2066253B56;
	Thu, 15 May 2025 16:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328013; cv=none; b=bj4aiG3ajhUvCATfrn0XNan7nNF8arqqMBENO+mZ956qfso0zUwu63vl9zLSGHJh7jLAB/u6ntu4TM7pte3+UGc+pi6aQiIcusO5w8NuSZJq1hKUYu9rMJbdstmTA8Jp1gPti4cqB7Zs97/ZctDAFvnbXr8YvXJKyTM1ntPnbRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328013; c=relaxed/simple;
	bh=p8wlX+CxjJDQW9hZmMeNz7tUVN6QmK2wRYdGGqNklJI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GzIVh1aARd7iQ5ijKDUKKk8POTFmSocHCTRmTRuk3besInYpaButP5x9oar8Mp9c3mLJvfIY0uxg0mX4DwXoNh0y7of5Jafk376eP2zrabv/bwSkj47YtsAFQtJ973nzT1SE+gi+KjtM6JtkYR90CVLIsrNd6iQVLXdEA8PWrFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOUMa/Of; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4052C4CEE7;
	Thu, 15 May 2025 16:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747328013;
	bh=p8wlX+CxjJDQW9hZmMeNz7tUVN6QmK2wRYdGGqNklJI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nOUMa/OfEJy1OLR374OYHo3b/Cd//LUfdzEuBDhIo4dmF/EE/2rBId2rKEOU45LOO
	 bvu2w0EpDPbZGon6URZrgr3HzWPgmc5qywzWo+9d3IfHNKR0xbSKje7ydaswdW+vOp
	 b7YvVovtu2CPrfK4pRjKX7GBlwooDpLQMjQYlVMTfVKHyEQnMabRjgLuJTIBb1lkLr
	 qqgigbgloxGW1nHu42AlQYzmmXhAA5ZqPXWZafBDPcpLgebAqlhWDbSjyy7ITyKYkr
	 +MNj+Rj9DCXYasgpwzeUTur+j9MHhXgoBBK6Z7oUDKa4kmJhKEwFkHMT/P0oLTJUnv
	 dD7xhFvzp31XQ==
Date: Thu, 15 May 2025 17:53:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrew Ijano <andrew.ijano@gmail.com>
Cc: andrew.lopes@alumni.usp.br, gustavobastos@usp.br, David Lechner
 <dlechner@baylibre.com>, nuno.sa@analog.com, andy@kernel.org,
 jstephan@baylibre.com, linux-iio <linux-iio@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: accel: sca3000: replace usages of internal read
 data helpers by spi helpers
Message-ID: <20250515175326.67615d3b@jic23-huawei>
In-Reply-To: <CANZih_SmneYr+jK9Apuif66vfCcpni7K+CzMk32-hZt-LRrZWw@mail.gmail.com>
References: <20250510190759.23921-1-andrew.lopes@alumni.usp.br>
	<20250511123416.729eb50f@jic23-huawei>
	<CANZih_QHNEuFTQ2NysUVOJ-PmrL-ASFeG5b8xBTbRSG=3ho-vw@mail.gmail.com>
	<CANZih_SmneYr+jK9Apuif66vfCcpni7K+CzMk32-hZt-LRrZWw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> > >  }
> > > @@ -432,13 +434,13 @@ static int sca3000_print_rev(struct iio_dev *indio_dev)
> > >       struct sca3000_state *st = iio_priv(indio_dev);
> > >
> > >       mutex_lock(&st->lock);  
> >
> > Another patch to use guard(mutex)(&st->lock); etc would be help clean this
> > up by allowing direct return in the error path.  
> 
> Great! In this case, would you suggest the following order?
> 1. One patch for general style changes, like the removal of error_ret labels;
> 2. Another patch for spi changes;
> 3. And another one for using guard(mutex)(&st->lock).

That order is fine.

J

