Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5500C3545BB
	for <lists+linux-iio@lfdr.de>; Mon,  5 Apr 2021 19:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhDERAB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Apr 2021 13:00:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232147AbhDERAA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Apr 2021 13:00:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21082613A0;
        Mon,  5 Apr 2021 16:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617641994;
        bh=vHqWmNeHTudHyD8+yzW1Vvwm84Lt1okGW0ozEYzm03o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gQ6g+NFmr8TMKHlN3owjZNROLithXODZNwtMj1dau6/KqKL/U8+OTllsdw3Kw5euV
         J+PwrHbso5BA65fiR9JQv7c0vOcqYfg8Ec+CLZwWp35hzsuq7DLId1v2DVChHp/uj6
         dpg8jlADCoTebUXrKZjFSMME6O8msObSiEVHxPpA=
Date:   Mon, 5 Apr 2021 18:59:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 2nd set of IIO fixes for the 5.12 cycle
Message-ID: <YGtCCHz7wIbTE/UN@kroah.com>
References: <20210405152057.3157af41@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405152057.3157af41@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 05, 2021 at 03:20:57PM +0100, Jonathan Cameron wrote:
> The following changes since commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b:
> 
>   Linux 5.12-rc4 (2021-03-21 14:56:43 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.12b

It's late, it's -rc6, are these really needed for 5.12-final or can they
wait for 5.13-rc1?

thanks,

greg k-h
