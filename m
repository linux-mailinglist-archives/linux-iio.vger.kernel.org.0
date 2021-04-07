Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3408035662A
	for <lists+linux-iio@lfdr.de>; Wed,  7 Apr 2021 10:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244610AbhDGIMV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Apr 2021 04:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233700AbhDGIMV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Apr 2021 04:12:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 857246139C;
        Wed,  7 Apr 2021 08:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617783131;
        bh=HYE1oqPfNNheRPizMpgroq+x29svfp53rH994iy68u8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DZ7PbBbk3mmEA74jO4B/tpWGALnQ1VJEbb1EvG+X7H60EzZKgeb/oAOB8VDua+WRm
         cmjcVRMFk3bQJDx3G6Rekoxi9ke+iRoY2mPGqtWA1zmr5u1hr20oXpb1gORuTsL8lK
         9nHM4b6eznGo3RtV3ApVMvVsbzPJGvZ9OHPTM8Qw=
Date:   Wed, 7 Apr 2021 10:09:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL v2] 2nd set of IIO features and cleanup etc for 5.13
Message-ID: <YG1o0Ob7TV2n7bNP@kroah.com>
References: <20210407084656.67321e6b@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407084656.67321e6b@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 07, 2021 at 08:46:56AM +0100, Jonathan Cameron wrote:
> The following changes since commit 9c15db92a8e56bcde0f58064ac1adc28c0579b51:
> 
>   Merge tag 'iio-for-5.13a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2021-03-26 12:09:47 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.13b-take2

That worked, now pulled and pushed out, thanks.

greg k-h
