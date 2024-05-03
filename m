Return-Path: <linux-iio+bounces-4766-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 057AD8BA691
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2024 07:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00791F22473
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2024 05:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C9613958A;
	Fri,  3 May 2024 05:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hhGfRQmC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F9B2C181
	for <linux-iio@vger.kernel.org>; Fri,  3 May 2024 05:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714713365; cv=none; b=DmqF8Ffw3GNfez8GgJJyEKvN08MT8qjd31C5IfEHMH+Em4w2I8+u5OznOdscARDhyEWUAUQ10IQpTgCv9oDItkBUZiut+d+CtPkaWNR+sgv6bpBFrUVmF6c5SXK/U4L/gD5rC4jB/tTnPFeYhFPPfxVjaBMACnJzdYppaqbpdrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714713365; c=relaxed/simple;
	bh=Rk37NL7aWMA9LTKkk0YNyyjP66OxkSNCMljq27HgrVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FM+DSemJ/MlZ619sdYYFGnH/YrXsRjDMSQ9EU1txMTE/wF3+u7UrRP5s7zYWj6BhUwgpLqZtguxe84RDbcWRej1V9qMHpkPE4xVKL7JJYHhhV+mFE6W9DQwr5tC1ryGeN9bE8qGyb/x1BjZ9G6cM3AkJCIViGcZGr1SWdYd+A04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hhGfRQmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB0FC116B1;
	Fri,  3 May 2024 05:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714713364;
	bh=Rk37NL7aWMA9LTKkk0YNyyjP66OxkSNCMljq27HgrVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hhGfRQmCe9BicDEL1+jKo+rEq+A83SxGfV/levpE4sUTeWthpnSrq1SuC/EbEVDN5
	 rWw+eDW6fP5+px2U/DuO6V6f5wXsy+cqaEqJf6RCYOkq4GpQcedxQdwy0uOWUlBJ8Y
	 Ro96dOy40fT6TZSsYGAJpsS9uUUD9DTrYk2Fjps8=
Date: Fri, 3 May 2024 07:16:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 2nd set of new device support, features and cleanup
 for the 6.10 cycle
Message-ID: <2024050353-compel-daycare-f7ce@gregkh>
References: <20240502201509.14ae8880@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502201509.14ae8880@jic23-huawei>

On Thu, May 02, 2024 at 08:15:09PM +0100, Jonathan Cameron wrote:
> The following changes since commit 84e79a7f63e8caeac0c1a0817408860875a9b23e:
> 
>   Merge tag 'peci-next-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/iwi/linux into char-misc-next (2024-04-23 21:31:45 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.10b

Pulled and pushed out now, thanks.

greg k-h

