Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC082FFFD7
	for <lists+linux-iio@lfdr.de>; Fri, 22 Jan 2021 11:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbhAVKL5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Jan 2021 05:11:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:42742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbhAVKKH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 22 Jan 2021 05:10:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A03BA238EE;
        Fri, 22 Jan 2021 10:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611310147;
        bh=nNnml7DN93HIS64+w3vF1JaFyWcdyNdSc/QxeRarj8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R5BnIpxUp1l5YvefgMee+eK1b6/ud3YQfPvZOM/3X7PloxktLf3AZJuI4NiqftSJv
         HfWBXnsdIl7i5ddm39FDHi7DH5LrzEKHtL4GspNxu44H2Gpumo1M22PYBCJeIm0sQG
         f5tLBkZIFASJ1vkIo3Dl9FQpk/RvFPvBQqxqA13Y=
Date:   Fri, 22 Jan 2021 11:08:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 1st set of new IIO device support, features and cleanups
 for the 5.12 cycle
Message-ID: <YAqkH0YPCc7DC4Sl@kroah.com>
References: <20210122090927.2fd2e3c1@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122090927.2fd2e3c1@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jan 22, 2021 at 09:09:27AM +0000, Jonathan Cameron wrote:
> The following changes since commit d61adf609c48b9e91a84e9a943f0b3bcd84c3cad:
> 
>   staging: unisys: visorhba: enhance visorhba to use channel_interrupt (2021-01-07 16:57:50 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.12a

Pulled and pushed out, thanks.

greg k-h
