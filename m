Return-Path: <linux-iio+bounces-18009-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3E4A86D13
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 15:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9331754F8
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 13:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8711E5B82;
	Sat, 12 Apr 2025 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAKosJcs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5842D1C863B;
	Sat, 12 Apr 2025 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744462855; cv=none; b=FoRBTY9lX7XEdAOnk8fdFgBDBQLQBHaBA2J6SUsbZ8zsfax2PGM3g9IcGcIl6hqIrNPh3XaJJoj5oz/uS6VcsXcBAlSrJ41C6jngaMlDZbrR+Uha3v7v8UckwjfQ/4/QVhEcbF8jzjpYWzNqkJYkCCezdpMWu3uXJq04a9i1dPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744462855; c=relaxed/simple;
	bh=XaCjGjuuKGemFcDirTV9nohPdOduesquW/qdw6eHyaY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jy3yagvkILVgaU3cWguBUq0SuP+c2fQpNL50C9YX+Z6VgJRAUCZ2SsAGQQKBu857sIf48wSGLofvKzJ2RtapZj70C+UtqG6Qpqqz3QN82wtjSZwgS4WhtkIco+tlZ4HjihHXdj+K3kwI7FIamILyhleMkoJ0xwgYeNA3zvztgFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAKosJcs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A53C4CEE3;
	Sat, 12 Apr 2025 13:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744462854;
	bh=XaCjGjuuKGemFcDirTV9nohPdOduesquW/qdw6eHyaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HAKosJcspkbNU8RQvlJ0UNRkZbPj0t7PgeCWtdpIJiuTVQ6g3Wik+sMFJJ8Mhrzgy
	 i2jJabIshykW9qMHNLNVeArkVRXYRle1U2s23YWtSzSCY8/YTQTgjy9ZYnG2YAfLeV
	 labS+pjfLp/L55HUjTq+kkn8ESg+aueBNRAEuUWr9lPD1ik91E7dTERTx2HAbaztNn
	 MEeA02j/VnuOzv7fN6Vdp9uUhnqxp68ZUjHcZCbfrO8xOVNXoh7YNYZ5/QkI9nKvOH
	 PPtP7zYgaTl+GTb8QkJcOmTh4uajGCXM6iFHqOWt/soYA4JtsRIXDQtCmF9WrCGC+9
	 RWEagkT5rrlcA==
Date: Sat, 12 Apr 2025 14:00:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Nuno Sa
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 1/2] iio: dac: adi-axi-dac: fix bus read
Message-ID: <20250412140046.164bb4bc@jic23-huawei>
In-Reply-To: <Z_alFXGBhFxk-h0e@smile.fi.intel.com>
References: <20250409-ad3552r-fix-bus-read-v2-0-34d3b21e8ca0@baylibre.com>
	<20250409-ad3552r-fix-bus-read-v2-1-34d3b21e8ca0@baylibre.com>
	<Z_alFXGBhFxk-h0e@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Apr 2025 19:49:25 +0300
Andy Shevchenko <andy@kernel.org> wrote:

> On Wed, Apr 09, 2025 at 11:16:54AM +0200, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Fix bus read function.
> > 
> > Testing the driver, on a random basis, wrong reads was detected, mainly
> > by a wrong DAC chip ID read at first boot.
> > Before reading the expected value from the AXI regmap, need always to
> > wait for busy flag to be cleared.  
> 
> ...
> 
> > +	ret = regmap_read_poll_timeout(st->regmap,
> > +				AXI_DAC_UI_STATUS_REG, ival,
> > +				FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, ival) == 0,
> > +				10, 100 * KILO);  
> 
> It's timeout, we have special constants for that, I believe you wanted to have
> USEC_PER_MSEC here.

This is an odd corner case.  If we had a define for that 100 along the lines
of X_TIMEOUT_MSEC then I'd agree that using USEC_PER_MSEC makes complete sense.
All we have is a bare number which has no defined units.  I'd just go with 100000 and
not use the units.h defines at all.  They make sense when lots of zeros are involved
or for standard conversions, but to me not worth it here.

Jonathan

> 
> > +	if (ret)
> > +		return ret;  
> 


