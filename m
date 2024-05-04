Return-Path: <linux-iio+bounces-4787-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 157FB8BB9DF
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 09:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93B91F22099
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 07:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA5779C4;
	Sat,  4 May 2024 07:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QzbvEBN9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3B44C9A
	for <linux-iio@vger.kernel.org>; Sat,  4 May 2024 07:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714809054; cv=none; b=Mk1EKS65MzCxi/egB+mino44lF7aU5nkvjP5O7QLVFKC2w3UyXWSqwRudoGnSq6Ne9LZP3kAoSSBEWlJsoGzr4AdLtrrQPXo9aDlJ5YQ4b25bTtdt2NdNyVYjI0W3cx7He6XgUQnL0TSf7HQGtoxbBCt102xcFG+3/urTpu8Wug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714809054; c=relaxed/simple;
	bh=xD4rSaZuiUmIInRF6/WrYFT12ma5tjygJ8hr/W2Yx1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J331o49X7awL4vfAVIuYAzUs6cR0sZm0X1kwZ7lymn0QfEsXPdjrnWtDZXVCrw/RTarVuUj3RJx89lwwXOvyepZPAeu+z3n+TxXGR37xFjnU/26UJf61tuO2cxTIF43+NR5FuFimxGixAE2VM3oxkgUF93WxwNOh2RC+JiLetjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QzbvEBN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BA6C072AA;
	Sat,  4 May 2024 07:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714809054;
	bh=xD4rSaZuiUmIInRF6/WrYFT12ma5tjygJ8hr/W2Yx1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QzbvEBN92Vs7qnC7lnu5wdfsOwCORJE5hzHgLwCeVAPa5lEVsry7IHypp4rLpp38c
	 fiVL9XpJRE7hRszRbNsbdvQqPCu0WnpwdtaCXvLY+Qo25PIftowU3mxoL3qhB1l5Wb
	 yWA40Jyg3NrtG/Nu2QeHdtsAU76hWjwVHGYADjUk=
Date: Sat, 4 May 2024 09:50:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL V2] IIO: 2nd set of new device support, features and
 cleanup for the 6.10 cycle
Message-ID: <2024050450-ribbon-appear-c4ef@gregkh>
References: <20240503193551.369c018b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503193551.369c018b@jic23-huawei>

On Fri, May 03, 2024 at 07:35:51PM +0100, Jonathan Cameron wrote:
> The following changes since commit 84e79a7f63e8caeac0c1a0817408860875a9b23e:
> 
>   Merge tag 'peci-next-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/iwi/linux into char-misc-next (2024-04-23 21:31:45 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.10b-take2

That worked much better, thanks!  Pulled and pushed out.

greg k-h

