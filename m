Return-Path: <linux-iio+bounces-11781-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7D59B93D7
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 15:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10CFF283123
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 14:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CBD1AA790;
	Fri,  1 Nov 2024 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/JiVMTR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAD819DF53;
	Fri,  1 Nov 2024 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473185; cv=none; b=TvhvTeFtuL9gS3qGvlFL0voUxglU1EPZJaP/DuOJ16ebifRrfPGwDsihYAmdxo42xSEugmwGNkPdFwjPuHqsw5VybpbZQha5Xq5ysdiGUDfdFdsI01OnXeXwfTZUp5mJJyX1FOn5JPBe5UxDMnjKSN5I5dFaSg3BG2XByftRYXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473185; c=relaxed/simple;
	bh=2X03TQNnAW9HkcVyX2wIkFgipuGM2Vgw+NEcYA8LBn8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtylhHIYgqYoK0AC0pkxkvUUcQiAaCLfTeITPe0CerszarFVifTNehMfSxgjP7giha212sUJmBBSYcxTNe1BFywntnCZkVnwXLfYkAEw6Cb2SD+f2WSX+cmZJ4+QBXyYK7IhMQitRvRG6kEG+5dBAfJpF5UCrfQI1HEMaj9p684=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/JiVMTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB640C4CECD;
	Fri,  1 Nov 2024 14:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730473185;
	bh=2X03TQNnAW9HkcVyX2wIkFgipuGM2Vgw+NEcYA8LBn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o/JiVMTRVN8axcRP/bazaFytzufdptpKkyuYOIy33rdBymDbJ04+Reu2sRpnwMynt
	 tKXmLkivLx8N/qeNLJxeIVZtlclGNfn/r1X1RqgWbNmmU9DYNRAtEgOWPpxXznVLBu
	 ZX7PFjLys4bONG+5mI58wH77nC4lRZlBnl78xCWL8urxbiRuKS6TvKXQbdcmgdFSIJ
	 Z4upf/ZLzfexrZ1OLN0PTtwKfCBIpiqny91P9olk1+ZlGefwUYly/vEwSD5yBD1jwM
	 Km32ZF1wXQSmw5gfplZXadH7GRBRCTWM4KFX9udqOVnWCCDtS9QkrUtTdjh/gmm+Mx
	 dvlkAi0SSRPJw==
Date: Fri, 1 Nov 2024 14:59:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>
Subject: Re: [PATCH v3 0/4] iio: initialise ddata for
 iio_get_acpi_device_name_and_data()
Message-ID: <20241101145938.304fd98b@jic23-huawei>
In-Reply-To: <20241101131705.3697913-1-andriy.shevchenko@linux.intel.com>
References: <20241101131705.3697913-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Nov 2024 15:16:00 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Dan reported that ddata might be used uninitialised in some cases.
> Let's initialise it to NULL (patches 1 - 3). With that, update one driver
> to drop an unneeded anymore check (included in patch 3).
> 
> While at it, one more cleanup to kxcjk-1013 (patch 4) is added.
> 
> Jonathan, dunno if you want to rebase at this stage (probably not),
> but if you do, feel free to fold the patches 1-3 to the initial code.
Ah. I've just picked v2, but given I squashed anyway the commit message
changes don't matter.  I was curious what Assing meant but not need to
ask given I wasn't going to keep it.


Jonathan

> 
> In v3:
> - made Subject more specific for patches 1-3 (Markus)
> 
> In v2:
> - rewritten patches 1-3 to do the job on the caller side (Jonathan)
> 
> Andy Shevchenko (4):
>   iio: light: isl29018: Assign NULL to ddata in isl29018_probe()
>   iio: light: ltr501: Assign NULL to ddata in ltr501_probe()
>   iio: accel: kxcjk-1013: Assign NULL to ddata in kxcjk1013_probe()
>   iio: accel: kxcjk-1013: Deduplicate ODR startup time array
> 
>  drivers/iio/accel/kxcjk-1013.c | 30 ++++++------------------------
>  drivers/iio/light/isl29018.c   |  2 +-
>  drivers/iio/light/ltr501.c     |  2 +-
>  3 files changed, 8 insertions(+), 26 deletions(-)
> 


