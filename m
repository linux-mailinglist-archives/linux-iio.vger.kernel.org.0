Return-Path: <linux-iio+bounces-9089-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8AB96A71D
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 21:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F1E1F251FE
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 19:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1931D5CCA;
	Tue,  3 Sep 2024 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLEAc295"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EFF1D5CC3;
	Tue,  3 Sep 2024 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390571; cv=none; b=DwY0DmKTO9DDla62iIh/J0LtDLOQJ4DY0JGdeOeSl/m5V5mvCgJhWEC2/gdkQ8cabic4NmSWKdFU9vtgt/i6y3fVo3BNHfzRk4SLA7PyrT/+og/TYZRllf8e6P7V02ZVDzu9wJpjDW7mIDj5OfITfA+8HEvLvaTlGZVj8BwhjSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390571; c=relaxed/simple;
	bh=55DLeXNN0iTVTD0pOuIULREXJfECbY2ZoIrfjB0moBU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LIfFd9YL1oWY32HRKaAuPZ7Bz9YKr4DxDTmitborAc6eEy2pK6R79htr2BBO2vwvkLMYxJ2Foo/hrrHle87jr38lLoC7FI0jRiBdt1zcUoohdwKICnKxY5pGSgCuM9VjY57/EP92GpMdHl2Wq2xmO8Jb3LfLEaHJp6qH/09R1o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLEAc295; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F92C4CEC4;
	Tue,  3 Sep 2024 19:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725390570;
	bh=55DLeXNN0iTVTD0pOuIULREXJfECbY2ZoIrfjB0moBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kLEAc295kRpoFgbsDZK/8gxqqEppv2pF4kiO0TVKxfgMKgmZk0Xulb4+Cz2lGGWAd
	 V4ZhQwds1FHxQTCVUoHsyDgqNsQtWq5q49mQ6nRgg5DXznLCJNn5f4juySlKYOXfwE
	 XUeyW3WjQXITsE4d/BeTLD7n6NsX+whFkQ5Q0eBwHe/jBoUZCDRhrQ5rZuZseymfE2
	 sktIvoRGotwG9RBeo5zGnRAgkf5v+hr4dAdNuqtlwH6d8rCowG8mUCR9J5cuYq4oXF
	 QjrHd0M2Qu0rAYZm+mri0yOg8D8buLUiHCxGvi2mVo3mDaR+jIw8cTotEGIcgVPv5w
	 Tc3UB60l7RHJg==
Date: Tue, 3 Sep 2024 20:09:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: iio: rm .*.cmd when make clean
Message-ID: <20240903200923.21c4c1ff@jic23-huawei>
In-Reply-To: <20240902035412.4835-1-zhangjiao2@cmss.chinamobile.com>
References: <20240831115931.596e35fb@jic23-huawei>
	<20240902035412.4835-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Sep 2024 11:54:12 +0800
zhangjiao2 <zhangjiao2@cmss.chinamobile.com> wrote:

> From: zhangjiao <zhangjiao2@cmss.chinamobile.com>
> 
> Hi
> 
> On Sat, 31 Aug 2024 11:59:31, Jonathan Cameron wrote:
> >> On Thu, 29 Aug 2024 13:33:09 +0800
> >> zhangjiao2 <zhangjiao2@cmss.chinamobile.com> wrote:
> >> From: zhangjiao <zhangjiao2@cmss.chinamobile.com>
> >> 
> >> rm .*.cmd when make clean  
> > Where do those come from?  
> 	Those come from tools/build/Build.include.
> These .*.cmd files ware created when make.
> So clean them when make clean.
Hmm. I'm still a little curious about the path to those getting created as
I don't see them. when testing.

Ah well, I don't feel strongly about it and I'm sure there is
something to make them appear

Applied.

Thanks,

Jonathan

> >> Signed-off-by: zhangjiao <zhangjiao2@cmss.chinamobile.com>
> >> ---
> >>  tools/iio/Makefile | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/tools/iio/Makefile b/tools/iio/Makefile
> >> index fa720f062229..3bcce0b7d10f 100644
> >> --- a/tools/iio/Makefile
> >> +++ b/tools/iio/Makefile
> >> @@ -58,7 +58,7 @@ $(OUTPUT)iio_generic_buffer: $(IIO_GENERIC_BUFFER_IN)
> >>  clean:
> >>  	rm -f $(ALL_PROGRAMS)
> >>  	rm -rf $(OUTPUT)include/linux/iio
> >> -	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
> >> +	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete -o -name '\.*.cmd' -delete
> >>  
> >>  install: $(ALL_PROGRAMS)
> >>  	install -d -m 755 $(DESTDIR)$(bindir);		\  


