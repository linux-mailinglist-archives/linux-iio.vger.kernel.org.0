Return-Path: <linux-iio+bounces-27443-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 211A7CEC5CA
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 18:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 214D23007227
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 17:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486FE2BCF68;
	Wed, 31 Dec 2025 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rj0Qnass"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001701A23AC;
	Wed, 31 Dec 2025 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767201620; cv=none; b=U5roV37/sdd3xSYQHz9CIPSGucwwQdkMTqoDsv/bC3xa2gOFMk/HlZo9Hh7k4wbaxX8vs4xxTjlCxKaq5UeMRUWHHWafJLwQseC/TrL0TuuMdNo1O/KuazkmqbCSQ1xTJ1Y0i2Wj1oHOUgh99op6L7wW9/lhKaSoVxsbaxBAzKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767201620; c=relaxed/simple;
	bh=aaSWe6+QwWR6r3IfNK4K4Y7tizwdyENDryJ+c1URovk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IH5SPtPKQZ8ptubPPqo7JfqIWSAHDNsAyV4oYsd21TXQttFLfUHURUIcRtx+zW61y34gaM/dwlEzvta7zUunYFkJzGj3Bz4oLdSeVBPq5z68+UkP8PhZDzLlmKiM4daS/mU1h6r/XhZ084WveLUs1I8tJwZwRFFI5L3C+mRE9l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rj0Qnass; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C494C113D0;
	Wed, 31 Dec 2025 17:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767201619;
	bh=aaSWe6+QwWR6r3IfNK4K4Y7tizwdyENDryJ+c1URovk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rj0Qnassegrt5ROxzJzEq81TOblhgfzZqAwyJJpsnk4dL7/WOTWhWQuRoV/hD9lCj
	 OjptqnI7NmL1NoMDtngQ1hz3iTm35S8EGCMD+oSeDwT2U0fy0Qz/mddGlVPT5V7hlv
	 ryahTT5nURnJDt6O4/ZEu5dOREaKUYpfzKiBwj0nTcjUDtcCFDpS/SR2kid+eT9n4A
	 2i8TwT7QvmZgaCvn5IQWq+G5P+Wz5PocMMccOo/ZPxhf/GGuZkk42IVBrAmtvC2db9
	 IrC9WR26BXn7pyKj2cf3250wSKer0yA7H+UDNvylaqUdYxA6QQJHPcJo1760PZTIVk
	 u8SwRVpmgY93w==
Date: Wed, 31 Dec 2025 17:20:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: core: Constify struct configfs_item_operations and
 configfs_group_operations
Message-ID: <20251231172011.7e0b3cd1@jic23-huawei>
In-Reply-To: <6f327beea525e2b96724b0b395f1105ff7ccc305.1767007641.git.christophe.jaillet@wanadoo.fr>
References: <6f327beea525e2b96724b0b395f1105ff7ccc305.1767007641.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Dec 2025 12:27:43 +0100
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> 'struct configfs_item_operations' and 'configfs_group_operations' are not
> modified in this driver.
> 
> Constifying these structures moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    5037	   1528	     64	   6629	   19e5	drivers/iio/industrialio-sw-device.o
>    5509	   1528	     64	   7101	   1bbd	drivers/iio/industrialio-sw-trigger.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>    5133	   1432	     64	   6629	   19e5	drivers/iio/industrialio-sw-device.o
>    5605	   1432	     64	   7101	   1bbd	drivers/iio/industrialio-sw-trigger.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Applied to the togreg branch of iio.git which I'll push out initially as testing
for 0-day to take a look at it.

Thanks,

Jonathan

