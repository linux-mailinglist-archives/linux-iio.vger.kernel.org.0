Return-Path: <linux-iio+bounces-11718-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C20729B8339
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 20:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36DA41F23860
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 19:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B06B1CB32F;
	Thu, 31 Oct 2024 19:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpnSi1XI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA641C9EC4;
	Thu, 31 Oct 2024 19:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402400; cv=none; b=jXizNRqJXAxZeO+stk7eHj4L07fcOhiALNWoxJrHgXSyuJJ2Y5iTccCIN9IAe1pFg1TnEHWCN/jtDinprkff62ijJz6g+VDtpKKenofCHY049baEDgg9BUVjJLwzUlX38VV6+L3wcgy6JIpLlseOeMdWnMgaOexWgHWiXN+W90U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402400; c=relaxed/simple;
	bh=TXUrvY9NYQzXz3pIPouqhA1TPXabG66RSQ4mri6lwjU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KuXuF2w+0M4Mr54OnuWXo0z7Og5kwI/wOXj8ZxeyZfdjv9EvN84nYi4SNRw5Pu/CjAd8U7Vr19w1HjljuJvazxFBMJuIqIDH0V8RngwcW1wMJ/xrO4/J5dITqFK9qortVjU+adTVoVmk9j6XEL7hQ2viVRMH+bUUpaXy9xLz6vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpnSi1XI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C03C4CEC3;
	Thu, 31 Oct 2024 19:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730402399;
	bh=TXUrvY9NYQzXz3pIPouqhA1TPXabG66RSQ4mri6lwjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kpnSi1XILxwkbp+wL2sJUVmQSSA0Vtdmb00iGv81gkEUi8OEObuERwXhCRB+ZUR5T
	 X82eKlFYYZHhBrlfU4uDnekQCDD0PYO+xeS5IYrtGssI0Gk9Pc8+aMaB1hNxC7nhQS
	 sFVd6jf99sU/FKdHWyQweJCUShKDj+Lxym3iVknLCdEcEhABpEUfb5Wu+tbHmLUAq9
	 ymHSbCAcc62mLbhFo+JXvPWjmMeQF+96qg5d6TlFLLOU9ioRrBIumnPUWbSHmvgZB/
	 6UBK+VV8o5LQyPlKsRDzgV6/i95UhRdG9Gerj2jvQeD3RR2lcb7SGkN+WZ+4ijNaTo
	 DWdFIvSUYwg1Q==
Date: Thu, 31 Oct 2024 19:19:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Matteo Martelli <matteomartelli3@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v1 0/2] iio: adc: Check for error from devm_mutex_init()
Message-ID: <20241031191952.149d033b@jic23-huawei>
In-Reply-To: <20241030162013.2100253-1-andriy.shevchenko@linux.intel.com>
References: <20241030162013.2100253-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 18:19:17 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Ignoring error checking from devm calls is a bad practice in general.
> While not critical today, it may become a problem tomorrow.
> Fix this for devm_mutex_init().
> 
> Andy Shevchenko (2):
>   iio: adc: ad4000: Check for error code from devm_mutex_init() call
>   iio: adc: pac1921: Check for error code from devm_mutex_init() call
> 
Oops. Missed this in review obviously.

Applied.
>  drivers/iio/adc/ad4000.c  | 4 +++-
>  drivers/iio/adc/pac1921.c | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 


