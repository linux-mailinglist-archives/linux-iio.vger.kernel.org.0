Return-Path: <linux-iio+bounces-9826-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70B698900B
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 17:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F34CE1C20AB7
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 15:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B16225DA;
	Sat, 28 Sep 2024 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kymhrOYf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C171622089;
	Sat, 28 Sep 2024 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727536916; cv=none; b=KznWaKnO8zgajk2S2NHZRdIZaE6FPi8i9HIaNf++VCT7lrcY2NtdvyREZ2LVtagzLEqxY2Gsb6KbKbRSrNLtrXajuL/FymKLtjtWPFDbJ5jHZiqpfO9v5Zo05QhHpSpvh/BRfbqm5KnZaei8w/n/+jhGtQoZMzZ28G38KgG/ySk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727536916; c=relaxed/simple;
	bh=xEpbglZAB94SfhkjczaaLYR8FsQyLsG/79YvIqhDwTc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jYO6DPV2TdFK8sj9aQio1y7wvQDJwYJvbkXy3YuDq2EVKbuSv31L5wlis6Fq1TP2R0lQXk9WwlSR0YHjQOBygd5U+n42Vh1hm38Rwuc9dJZasvgkEh9etJBeU93qbNSCLSLSTphxTYMDaK9ohzX3jOizTHgosmzK6OxIWukOMpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kymhrOYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A2BC4CEC3;
	Sat, 28 Sep 2024 15:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727536916;
	bh=xEpbglZAB94SfhkjczaaLYR8FsQyLsG/79YvIqhDwTc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kymhrOYfj4ZQkXvGhbK90rtOUB34bhzZ4EV3Ykma5bmHBTD0LFFZofO2gSMfr7Q8L
	 Yz+GZYbN44+7oOIlS0zcsS7gQjZQLxYBSZKtoOrZ0wWNMMPW07thugazhdfHxgpIcX
	 ZNGQ+fib03CON45MdTqYEK2e9eOW0zcdX/93xrtPgbRzIScQThH2P/u0v053pprAow
	 KkPWUvNxQZ6hQ0u2yOvlkYXxucbnMf5qa5DHuqn8lyT9Gzs8+tZT+P3DhPvX2DjOp4
	 kpdBup//hYfXf4AM1wIn6o7pzYDwNc2yPaqV3TUH0nAs9EqPe7sPXBfTdwcMviFWAc
	 3ZiOtoZW53cLA==
Date: Sat, 28 Sep 2024 16:21:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Steven Davis <goldside000@outlook.com>
Cc: hridesh699@gmail.com, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: iio: Fix alignment warning
Message-ID: <20240928162146.64251df8@jic23-huawei>
In-Reply-To: <SJ2P223MB102630DA926C5006D12E5132F7622@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>
References: <20240918174320.614642-1-hridesh699@gmail.com>
	<SJ2P223MB102630DA926C5006D12E5132F7622@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Sep 2024 15:42:56 -0400
Steven Davis <goldside000@outlook.com> wrote:

> On Wed, 18 Sep 2024 at 23:13:19 +0530, Hridesh MG wrote:
> > Reported by checkpatch:
> >
> > CHECK: Alignment should match open parenthesis
> >
> > Signed-off-by: Hridesh MG <hridesh699@gmail.com>  
>   Acked-by: Steven Davis <goldside000@outlook.com>
Applied.

Thanks,

Jonathan
> > ---
> > drivers/staging/iio/impedance-analyzer/ad5933.c | 6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)  
> 
> > diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> > index 4ae1a7039418..d5544fc2fe98 100644
> > --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> > +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> > @@ -628,9 +628,9 @@ static void ad5933_work(struct work_struct *work)
> > 		int scan_count = bitmap_weight(indio_dev->active_scan_mask,
> > 					       iio_get_masklength(indio_dev));
> > 		ret = ad5933_i2c_read(st->client,
> > -				test_bit(1, indio_dev->active_scan_mask) ?
> > -				AD5933_REG_REAL_DATA : AD5933_REG_IMAG_DATA,
> > -				scan_count * 2, (u8 *)buf);
> > +				      test_bit(1, indio_dev->active_scan_mask) ?
> > +				      AD5933_REG_REAL_DATA : AD5933_REG_IMAG_DATA,
> > +				      scan_count * 2, (u8 *)buf);
> > 		if (ret)
> > 			return;
> > 
> > -- 
> > 2.46.0  


