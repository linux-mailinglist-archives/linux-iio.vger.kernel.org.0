Return-Path: <linux-iio+bounces-8794-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A961995EEA8
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 12:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49DE71F230D2
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 10:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40B014A617;
	Mon, 26 Aug 2024 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQzQIBT5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C02149E1A;
	Mon, 26 Aug 2024 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724668902; cv=none; b=e0PSZUhlR8+4u5lPJIIeOFlXJuMQbN5r66OBGA1dl63UaC4jokuHyAsQaqdkTqYtUHQhu2r4Pz31svWNaG2hg2xHC7Xx7NUc9Gr63xkHQaD0gdrhRjLzLBvtq3vfdLe4YZ4nEB4KflIPTesCw0KtXjgZWUv1l0tw9zk5c+nJZi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724668902; c=relaxed/simple;
	bh=44zkW5zwlfqzGKD7S2cu9bQhEyzP8wo+fv2Aka1pa6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNH+I7CjE1gC6mkPuzcbc8Tx4xODaQNXKO4Jlx6t8hMdXd/lUBDeo6mh8opjOP3c84okuo9OZB6jH8EkkvpLv1zKxceHeoNVGh1ZhYJfObi2ZisOuqFMlyoq7tHd+BmpPHxTA/udYkN/89uIhzTtb1G6GGKE0bppI6FpB//+pEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQzQIBT5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C727EC51407;
	Mon, 26 Aug 2024 10:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724668902;
	bh=44zkW5zwlfqzGKD7S2cu9bQhEyzP8wo+fv2Aka1pa6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iQzQIBT5/I/FCpCNjo433nhIf7g0e8Lb3uq66XHrFT64ZIeizo7BujWATP/PhZlak
	 PZIxfr79lgY8JiKVpLuItgHLwqbaTUgoxEFZBISbqmC8+F00u9r7B3SmTDo/939mX8
	 aRWDfK3g/86TW2r9K30FiOLLqIbXD0lKIQQE6WO844wHAavwJQFZP7xUgThnCwW384
	 GoAfStPefVEqJ/v8HRl+B/iZnRchCQckN+BiEJKhOOX9B6yPNFUm0LBfuFppdcYwLq
	 FmZVrKsqxF2Nc6vr0wQO1/7YyTTTgSiUcPPUHu01QLXHQcm4e1hfafL2wpQq/MTIPO
	 QZ2ftMkd7D53A==
Date: Mon, 26 Aug 2024 11:41:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Jagath Jog J <jagathjog1996@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Luke D . Jones" <luke@ljones.dev>, Jonathan LoBue <jlobue10@gmail.com>
Subject: Re: [PATCH v3 0/1] iio: bmi323: have the peripheral consume less
 power
Message-ID: <20240826114129.71f417c5@jic23-huawei>
In-Reply-To: <20240824141122.334620-1-benato.denis96@gmail.com>
References: <20240823192921.7df291f8@jic23-huawei>
	<20240824141122.334620-1-benato.denis96@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Aug 2024 16:11:21 +0200
Denis Benato <benato.denis96@gmail.com> wrote:

> The bmi323 chip is part of handhelds PCs that are run on battery.
> 
> One of said PC is well-known for its short battery life, even in s2idle:
> help mitigate that by putting the device in its lowest-consumption
> state while the peripheral is unused.
> 
> Have runtime-pm suspend callback save used configuration registers
> and runtime-pm resume callback restore saved registers to restore
> the previous state.
> 
For future reference, don't send new versions of a patch series
in reply to previous version. It's a good way to ensure your
code does not get reviewed as busy maintainers and reviewers
tend to start with latest threads and this style means
your patch ends up way off the top of the screen!

I don't know if other subsystems specifically ask for this style
of reply, but the ones that I interact with all specifically ask
people to not do what you have here.

Jonathan

> Changelog:
> - V2: patch 1:
> 	+ change patch commit message
> 	+ drop removal callbacks and use devm_add_action_or_reset
> 	+ split bmi323_init in two functions
> 	+ separate regs to save and relative value
> 	+ drop unhelpful consts ptr modifiers
> 	+ add a comment to explain why BMI323_FIFO_CTRL_REG is
> 	  being used in runtime resume
> - V3: patch 1:
>   + drop a struct array and replace with an array of
>     unsigned int: u8 was too small and it would have resulted
>     in overflow of register addresses
>   + use single-line comments where possible
>   + drop useless comments
>   + remove intermediate variables
>   + remove blank lines
> 
> Previous patches obsoleted:
> https://lore.kernel.org/all/20240811161202.19818-1-benato.denis96@gmail.com
> https://lore.kernel.org/all/20240818150923.20387-1-benato.denis96@gmail.com
> 
> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> 
> Denis Benato (1):
>   iio: bmi323: peripheral in lowest power state on suspend
> 
>  drivers/iio/imu/bmi323/bmi323_core.c | 155 ++++++++++++++++++++++++++-
>  1 file changed, 153 insertions(+), 2 deletions(-)
> 


