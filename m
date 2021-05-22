Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3114038D452
	for <lists+linux-iio@lfdr.de>; Sat, 22 May 2021 09:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhEVHwH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 May 2021 03:52:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhEVHwH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 May 2021 03:52:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E42C36120D;
        Sat, 22 May 2021 07:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621669843;
        bh=hcTsMQ4PmDera5oo4qSqIsYVTvKxxgfz2hD9rm0UC2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZX5sOYJWTzYi+sjPxsacvd7u4W+a5fGZi8PYYHMmVgXJ9sCBCAxgneILhPcDAqUxt
         zu9STnXA72yUGuuFc4DrYj7IcKPOMJtjW0dYMq945kZQRFsXICzN6mbfXmWeDnPAKc
         cVSIWViARcqAaF817GYh1h+V1AQm/X8wvuB07wX4=
Date:   Sat, 22 May 2021 09:50:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL v2]  2nd set of IIO fixes for the 5.13 cycle.
Message-ID: <YKi3yzg3DLMTaWFF@kroah.com>
References: <20210522084156.5780ef5f@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210522084156.5780ef5f@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 22, 2021 at 08:41:56AM +0100, Jonathan Cameron wrote:
> The following changes since commit ba9c25d94dea1a57492a606a1f5dde70d2432583:
> 
>   Merge tag 'iio-fixes-5.13a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2021-05-11 15:17:55 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-5.13b-take2

Much better, that worked.  Pulled and pushed out, thanks.

greg k-h
