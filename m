Return-Path: <linux-iio+bounces-11780-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 714B69B93D0
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 15:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F1D282594
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 14:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1894D1AA787;
	Fri,  1 Nov 2024 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALjHXjuP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C631A4F1F;
	Fri,  1 Nov 2024 14:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473025; cv=none; b=Tz1ftwXRmNVR+0sFtLKalb2YwZwrcNUtxK+oW6Pmt2vrpPpc5E4wslaIjey1I+nTfdFSmwdiTGbjJDDTBYn5sxP3NQ6QF8oF1Uyb0BRqVRArVTY04uyJwmg3qtrHEdyEINJD2XrjYvbV0NrdzcSsdJV5mYMdVgCVDG62DI1r9lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473025; c=relaxed/simple;
	bh=2yaXaWSjgWn2RGNAFWPGoZ5VjS8vUknU+zhuA9ZUsVM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTwt5RlvIZFVcd8P6DIXZWdncbbn8/YFwVBIZ1Ug/3OKbzxBKRWS1+57GNmblr5PoJLSLMSvgNeWVeQgJqgH0xHnijw5tPFUCXJymPXcfTmMfunUYXH1q1XU4JFwnijjGWTr4lv2xE8ZtXp5AQPBq6pR46/52k8736NRhmuQQMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALjHXjuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F01C4CECD;
	Fri,  1 Nov 2024 14:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730473025;
	bh=2yaXaWSjgWn2RGNAFWPGoZ5VjS8vUknU+zhuA9ZUsVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ALjHXjuP3C7Vnd+NueczS4Tz6Azn5vOZCQ06aEjyHkb7ki2o6lXaavdsuTZlV83Eg
	 6EAjPPZ50Q17ORCudwmpgF6OUun8YGi+WVfeyc046idw+CAidyyWZrvdCmJmm/rEX8
	 k69WLY+FHCzxz7P8J4pVcT1u0Os1eO9VCOyGSjZtzoXMmnrbalf6yHah8y96TWi/kl
	 YuMlvvxMrEb5QVubH4P1MhKj8AGuUT5shOYahJIhurazTsT0lXQ8+nQFe0QvEbnivg
	 xJKW2/2dDje5cM1leDSB8oMosS9YPXXbWQjKGpHjXhNBnZscgY+TJHotsu87PCrzq9
	 HGbMSaLQi3+4Q==
Date: Fri, 1 Nov 2024 14:56:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>
Subject: Re: [PATCH v2 0/4] iio: initialise ddata for
 iio_get_acpi_device_name_and_data()
Message-ID: <20241101145658.25c0bd11@jic23-huawei>
In-Reply-To: <20241101081203.3360421-1-andriy.shevchenko@linux.intel.com>
References: <20241101081203.3360421-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Nov 2024 10:08:25 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Dan reported that ddata might be used uninitialised in some cases.
> Let's initialise it to NULL (patches 1 - 3). With that, update one driver
> to drop an unneeded anymore check (included in patch 3).
> 
> While at it, one more cleanup to kxcjk-1013 (patch 4) is added.
> 
> Jonathan, dunno if you want to rebase at this stage (probably not),
> but if you do, feel free to fold the patches 1-3 to the initial code.
I had to rebase anyway for another reason so given that squashed those 3 in.

4 is on top of the tree.

Thanks,

Jonathan


> 
> In v2:
> - rewritten patches 1-3 to do the job on the caller side (Jonathan)
> 
> Andy Shevchenko (4):
>   iio: light: ltr501: Assing ddata to NULL
>   iio: light: isl29018: Assing ddata to NULL
>   iio: accel: kxcjk-1013: Assing ddata to NULL instead of NULL check
>   iio: accel: kxcjk-1013: Deduplicate ODR startup time array
> 
>  drivers/iio/accel/kxcjk-1013.c | 30 ++++++------------------------
>  drivers/iio/light/isl29018.c   |  2 +-
>  drivers/iio/light/ltr501.c     |  2 +-
>  3 files changed, 8 insertions(+), 26 deletions(-)
> 


