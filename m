Return-Path: <linux-iio+bounces-27590-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C36AD0EBE6
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 12:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BC643015168
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 11:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0012E338591;
	Sun, 11 Jan 2026 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxOO2JSH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D2CB640;
	Sun, 11 Jan 2026 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768132228; cv=none; b=M8Dwg4yAlnuofz8eGrupdLSgSiuxl/LhXHIbcoJpvyqaOUPd9s0ovbIkDatVOrwrhpb3G69c9q8KXOft5PLE7m8EF/jBlI7Yot8c1bD7QPnPau+36kKIERM157vfZtspbCDwksddxfhk4Bn79p5SyyB62fXUBtCTqPYTawls06k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768132228; c=relaxed/simple;
	bh=Wg3jSS2kMxPrmU0o08gArXQ2MGtq9XGcdEdlPy7k3F4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LY6cF7H5Y23phsv+lzsE98wZzzvomUb6Uw7P5qrL9D5EpZpbn+Yj1Mch8o4JzWJdZQP/0h+o8bYJ8IxaPFZPshDFCuF0betTf1K3RzMb1+704UIGLGmrEhklF8rQblz+aU2K3ev+ookAYhv/Hc73Zb3MSF6DgYTemnydWSm7LcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxOO2JSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8910C19423;
	Sun, 11 Jan 2026 11:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768132228;
	bh=Wg3jSS2kMxPrmU0o08gArXQ2MGtq9XGcdEdlPy7k3F4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MxOO2JSH9LLnkZMhyKpOvg5txIy3KJ5GyZiyZEflZIsp9pMNPvWsuTdVsJ35+DF7P
	 cioTtQxDtkH97JkBQ+/14bXEvc17PZk8kj4pqmCr33VGrCWx0l8hVMzMsoV3dobbnH
	 Ruu+/ygSfIr1DMUQd/Y8Y/MycLpbRJExcSAA5Qeceob7hA8lmhovzZa3ejJG/kd7pA
	 aEgsfJS0RvnvRrzaMkbekb39HhhQpHxef//lvrUFJPGaZIV3svcNuUflY2kNv8bDCK
	 a6Q0qeHgfFq5BJdJD5DX+f/ucK1utyr7Xo3ZgO57UV2vHtYTs7eWvcu5r+CfbJ8+ca
	 0wmyJFJjUorKg==
Date: Sun, 11 Jan 2026 11:50:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <jan.sun97@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, Janani Sunil
 <janani.sunil@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, gastmaier@gmail.com
Subject: Re: [PATCH 3/3] iio: dac: Add MAX22007 DAC driver support
Message-ID: <20260111115017.62802a56@jic23-huawei>
In-Reply-To: <013a144f-101e-49dd-9865-79dd6181f43a@gmail.com>
References: <20251219-max22007-dev-v1-0-242da2c2b868@analog.com>
	<20251219-max22007-dev-v1-3-242da2c2b868@analog.com>
	<20251219172510.00007208@huawei.com>
	<013a144f-101e-49dd-9865-79dd6181f43a@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Jan 2026 16:28:31 +0100
Janani Sunil <jan.sun97@gmail.com> wrote:

> Hi Jonathan,
> 
> Thank you for your review.
> 
> On 12/19/25 18:25, Jonathan Cameron wrote:
> > On Fri, 19 Dec 2025 16:31:17 +0100
> > Janani Sunil <janani.sunil@analog.com> wrote:
> >  
> >> Add support for the MAX22007 4 channel DAC
> >> that drives a voltage or current output on each channel.  
> > wrap to 75 chars rather than 50-60ish  
> 
> Noted. Will correct this.
> 
> >> Signed-off-by: Janani Sunil <janani.sunil@analog.com>  
> > Hi Janani
> >
> > A few minor things inline.  Also add turning on any required
> > power supplies.  See how other drivers do it with a single call
> > in in probe. If your board is using always on supplies it will just
> > work as a stub regulator will be provided by the regulator core.
> >
> >
> > Thanks,
> >
> > Jonathan  
> 
> Will take a reference from the other drivers and add the power supply configurations.

Hi Janani,

A small process thing you should take into account for future replies.
Generally kernel mailing lists are very high volume with a lot of review
feedback. As such we tend to go for a balance of efficiency over politeness.

So when you agree to a particular bit of feedback, just crop out that
bit of the message in any reply (if you agree to all of it no need to reply at
all!).  That lets us focus in quickly on the bits that need more discussion.

The politeness bit is resolve by adding a thank alongside the change log
in the next version.  I end up sending this message to someone most weeks,
so don't worry about it!  It feels unnatural to all of us initially.

Thanks

Jonathan


