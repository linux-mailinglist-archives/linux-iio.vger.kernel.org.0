Return-Path: <linux-iio+bounces-25475-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABA1C0E663
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 15:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63F9A507B32
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 14:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F0B307AF2;
	Mon, 27 Oct 2025 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3sMtqj4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA711758B;
	Mon, 27 Oct 2025 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574477; cv=none; b=S7gRrAtyUqQfWZynt2r82ye+uD1h2Od6Ib42SENe8ycUCLDrsMXn0Uwsp5EWMrhf2E+r18EzmZxD/a42qFv1Z7/FnziI8M/SJBqYgsLHUciDuQNq9wQDA3VX1IPAQ05LyctQ6HgoFnl+lNQdAlqIIrqfD/jkkM8+1HxIxTyvjro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574477; c=relaxed/simple;
	bh=rjfBkw8SThgsJ83DWP6sFDDYM59yhhu1+/oaRLS9hxM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rkzgSTrr82U10LeEWzuIsnDA748ans5255QGQMBemZw3RJLXmTxpC3fW8YCbul0pcuddbO7LcS9CpsKsMDnM1x7iNF5Snso7q79GtKo/Jn1q/7q/I1ejE94Sq7irH4NnWZJgW8m7XPJz60Hl5Iz9lb+7rC4UTcV77joogk75FMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3sMtqj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E1CC4CEF1;
	Mon, 27 Oct 2025 14:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761574477;
	bh=rjfBkw8SThgsJ83DWP6sFDDYM59yhhu1+/oaRLS9hxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a3sMtqj4X6R8sguWkUrtCC50od5IWltN6tR5hDakCDuT5yutbBthyMtOfJwNW6YTi
	 NR8ILE0R25qI5L8tqX4go7V0qZXQPX+fwjtOY8dajaIGA7vUaZJiV7VERXYwjS4M9U
	 XTPo0JSXC6e8SlI1WusenR3ge2Hxib2zleqPiI88ytXbCUHQrvPU+7wNm+jNftk4KN
	 djE1C5iiemmUp/aIRP/5DJcbZufnVVMOn1gflhznySjmB4P7/+PnPc5TELv+55Jvm3
	 Lsqgki5LxYE04VMYJ3Z5MPERZlPrE0BAVF8RzmN5ZfpFKsFKC/krQVJ0gEhgBS88GZ
	 x+sQ7Xw5JLBtw==
Date: Mon, 27 Oct 2025 14:14:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, robh@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/6] iio: adc: ad4080: add support for AD4083, AD4086,
 and AD4087
Message-ID: <20251027141431.145ac864@jic23-huawei>
In-Reply-To: <20251022-humility-deplored-6b57f6a003de@spud>
References: <20251021105349.21145-1-antoniu.miclaus@analog.com>
	<20251022-humility-deplored-6b57f6a003de@spud>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 19:02:42 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Tue, Oct 21, 2025 at 10:53:42AM +0000, Antoniu Miclaus wrote:
> 
> >   dt-bindings: iio: adc: adi,ad4080: add support for AD4083
> >   dt-bindings: iio: adc: adi,ad4080: add support for AD4086
> >   dt-bindings: iio: adc: adi,ad4080: add support for AD4087  
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 

I'd have been fine with this as 1 DT patch and 1 adding the support
given they are all pretty similar. Would have been slightly less work for
everyone ;)  Anyhow, not a big things so applied to the testing branch of
iio.git to let 0-day have a look before I push out as togreg to go into
linux-next.

Thanks

Jonathan

