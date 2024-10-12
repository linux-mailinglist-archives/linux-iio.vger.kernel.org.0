Return-Path: <linux-iio+bounces-10496-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5401699B490
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 13:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E480CB24F86
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 11:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BF81993A3;
	Sat, 12 Oct 2024 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACj8EbRT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DE31553A1;
	Sat, 12 Oct 2024 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728733518; cv=none; b=hUx/n0zxSDyuAaw4AFbQcsOpBHgQHDbjJX7OqYSihC1SEGn3f4qaFVZ2YPR5gO+OmTMyifQPvR6qCm8R7QmyqwZVm23VWyeaTWpXyy8qx5bZO4QfSg3eKh/QYyOJ+GWauhen+pGj6MOMFIBh6+mCeq5K5Qctzrx9TfBYQ1D05Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728733518; c=relaxed/simple;
	bh=4sTbR4SNGRQfLqVmxhXQpoB3J4JK7YfxtmMAdtTidOw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YEr8g4hqAk0uDLjEPadp3moJSH5nqGMKJ2ASO83WD01QznrUbSUqaQroy95q94y8ltQ25mV6Lbj99Pek65GN4UDzh0StW2fOB22PlrWhe2irsCxsVZHkLeQtTq3aSoAw9nmSi7GaF8dui6bcLfXbb57IbK2hpSZaEqC2SFqCzJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACj8EbRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41595C4CEC6;
	Sat, 12 Oct 2024 11:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728733517;
	bh=4sTbR4SNGRQfLqVmxhXQpoB3J4JK7YfxtmMAdtTidOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ACj8EbRTaVsrTc+v/XYkw1NxmAVvA1ef2HzgeWwfOhfJUmGp7kIZ++j8/zUkSnPjA
	 tqYXpxUB/tVfnKES9c6Z7G8ovKRI/Ok6x3Podpu6EAQI27ehAdE77991O2Q81KO5Mp
	 auB/giJutCYR+zC1+z49kYIvotZNFQzjV8TyQJLbhsoja9e+WbRKUpCI5QC2VlxnNN
	 sXib+KVFfCEmqOPoUzMUjcKccbjSwxpfa1AC5Bn9fwBQqqXYPmcN3J+8MGeUnudxHD
	 F1qrMUPV4OE0MwCqD9ks5hoyTHtN5LRiwJwvJNlRSyO17/EF6ROPxOXdEInO1p4JqD
	 SsD6s0SzBFsOg==
Date: Sat, 12 Oct 2024 12:45:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Aoiridis <vassilisamir@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 anshulusr@gmail.com, gustavograzs@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 03/13] iio: chemical: bme680: fix startup time
Message-ID: <20241012124507.3f91cff7@jic23-huawei>
In-Reply-To: <ZwlzvboBPppQMEB_@vamoirid-laptop>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
	<20241010210030.33309-4-vassilisamir@gmail.com>
	<Zwj3V1oaTO6je-w9@smile.fi.intel.com>
	<ZwlzvboBPppQMEB_@vamoirid-laptop>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 20:51:41 +0200
Vasileios Aoiridis <vassilisamir@gmail.com> wrote:

> On Fri, Oct 11, 2024 at 01:00:55PM +0300, Andy Shevchenko wrote:
> > On Thu, Oct 10, 2024 at 11:00:20PM +0200, vamoirid wrote:  
> > > From: Vasileios Amoiridis <vassilisamir@gmail.com>
> > > 
> > > According to datasheet's Section 1.1, Table 1, the startup time for the
> > > device is 2ms and not 5ms.  
> > 
> > Fixes tag?
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> >  
> 
> Hi Andy,
> 
> It is not affecting at all the operation of the driver so I was not sure
> if it was worth it to be backported to the previous versions. This is
> why I didn't put a fixes tag. You think for such a fix is necessary?
> 
Not for a reduction in sleep and not a huge one at that.
It's an optimization, not a fix to my eyes!

> Cheers,
> Vasilis


