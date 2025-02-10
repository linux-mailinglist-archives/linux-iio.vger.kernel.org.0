Return-Path: <linux-iio+bounces-15292-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5FBA2F834
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 20:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C0216814E
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 19:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A311A4E77;
	Mon, 10 Feb 2025 19:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1MRmFpA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017DA25E44F;
	Mon, 10 Feb 2025 19:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739214591; cv=none; b=Ajl2pk7tfO4X+5Rc9+0hFQitpAHWEipYfH9Y6/6KPQMYvNXsU3FcqNnegzp/qxYyevpCcAcILhSjFfaNJJF11S6e0fXAxPzECjQa7+cT8RZT31jBGpbWHWqrrU6UIj/Caf4arslqyZP5LZp0khzFmHFachpn4T7i6xmDcvDUjAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739214591; c=relaxed/simple;
	bh=aCLNQIrSFQWo14AkgM7qkgjn1MlddPExJ7pM8g/43I0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+/uKnjPz66mRrugAkwKr1vgCd2tA3Bx+FMF1LIPd9yWcWI4EFWGrGkzg1bDG0V/4W9MvWWAIaxml1hHy/QjOGg3LAki/Y+DwY4fFRqnpuZC1rHXXqVo4fiPyIrOxijaikcOcSiPJk3M9KOaW5hrYv9ETE3IGTKzep6KjLIXkiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1MRmFpA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3101C4CED1;
	Mon, 10 Feb 2025 19:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739214590;
	bh=aCLNQIrSFQWo14AkgM7qkgjn1MlddPExJ7pM8g/43I0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r1MRmFpAXIkMtq/PZ4tsjVgPSQsaS2FnLHxqJGsncADr3K1ThXKymGOT+NueuDbsn
	 liXcQJIDs5K3+cLSNg4ujdp9tDJ4cWoKqqe/4croJOLNFNiUpyyguy4EP0aQED1wts
	 3ttbR+kjn1qj2ELVz4em+Qxm6eXtRhxiNoWQbdhO8dMEdVg1sYWAKWngYQuqyrTijS
	 jGZ+bKGm6sGgz93LU/XpkTvw2Tj9pBYl4siAQ6iDQc/rOqBgcTJQPRPuq5lBTPzKO8
	 8bF60MtrimywT0GT/P/9TYSau9AXj0tYT1jJ/MXyR0DhTs1+PJOlDNfjYxdS7vEDpI
	 En9+xpFWRUI6g==
Date: Mon, 10 Feb 2025 19:09:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Hermes Zhang <chenhuiz@axis.com>
Cc: Hermes Zhang <Hermes.Zhang@axis.com>, robh@kernel.org, lars@metafoo.de,
 krzk+dt@kernel.org, kernel@axis.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: chemical: add support for Sensirion
 SEN5x/SEN6x
Message-ID: <20250210190942.21ba97cc@jic23-huawei>
In-Reply-To: <1237314b-78a8-a871-ea24-f3011766606b@axis.com>
References: <20250206061521.2546108-1-Hermes.Zhang@axis.com>
	<20250206061521.2546108-4-Hermes.Zhang@axis.com>
	<20250208161501.7b6c6c17@jic23-huawei>
	<1237314b-78a8-a871-ea24-f3011766606b@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 17:16:57 +0800
Hermes Zhang <chenhuiz@axis.com> wrote:

> Hi Jonathan,
> 
> Thanks a lot for your review. I will fix most of them in v2, just one 
> question below.
> 
> Best Regards,
> Hermes
> 
> 
> On 2025/2/9 0:15, Jonathan Cameron wrote:
> > On Thu, 6 Feb 2025 14:15:17 +0800
> > Hermes Zhang <Hermes.Zhang@axis.com> wrote:
> >
> >  
> >> +
> >> +	state->last_update = jiffies;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static ssize_t status_show(struct device *dev, struct device_attribute *attr,
> >> +			   char *buf)
> >> +{
> >> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >> +	struct sen_common_state *state = iio_priv(indio_dev);
> >> +	int status;
> >> +	int ret;
> >> +
> >> +	ret = sen_common_status(state->client, &status);  
> > This is custom ABI. So it would need documentation and will need
> > to overcome quite a high barrier.
> >
> > Superficially this looks like debug perhaps that should be
> > in debugfs?  
> 
> The status is one of the support commands from the chip, we (from 
> userspace) could read it and notify customer if the sensor is wrong or 
> not. So it is ued in normal usage, regarding the ABI, I see your point, 
> so instead of my way, do you have any suggestion for how to handle it in 
> iio? Thanks.

What is actually reporting?  I hope something more specific than
'wrong'.  Also when do you read it?  Standard software is never going to
so you may be better of doing some scheduled reading or reading it
on the back of a channel read.  Unfortunately the nature of failure modes
is that they are not easy to describe in a generic ABI - sometimes
our best bet is to just log an error (rate limited).

Some of these look like they mean the data read is garbage when they
are happening?

Jonathan


> 
> Best Regards,
> 
> Hermes
> 
> 


