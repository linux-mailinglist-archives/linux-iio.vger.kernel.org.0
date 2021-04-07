Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F93356408
	for <lists+linux-iio@lfdr.de>; Wed,  7 Apr 2021 08:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbhDGGfx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Apr 2021 02:35:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345181AbhDGGfx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Apr 2021 02:35:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 554806124C;
        Wed,  7 Apr 2021 06:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617777343;
        bh=taLTA9otNi+lGasH8AVbRNKWnHSeABMpkBjmGfUoSb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HdWqhYItQlrwGxoBClw9Bso+4B5QxfW+x6N6p1/n9VYHetWKhu7u5lWC70++LlZY6
         04pitHjnqThu7QMlqU2KvY5h/64g5QchhQJTrHf80PFixsmRX0/BhlCPKnSS8F/66+
         nCaNNYAoE05K9Qcup0j+NEAzzfmjm5PhYrW4W+tM=
Date:   Wed, 7 Apr 2021 08:35:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 2nd set of IIO features and cleanup etc for 5.13
Message-ID: <YG1SvdUpcSSc2ZsK@kroah.com>
References: <20210406220555.0d6bc9b6@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406220555.0d6bc9b6@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 06, 2021 at 10:05:55PM +0100, Jonathan Cameron wrote:
> The following changes since commit 9c15db92a8e56bcde0f58064ac1adc28c0579b51:
> 
>   Merge tag 'iio-for-5.13a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2021-03-26 12:09:47 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.13b

It looks like I had a minor cleanup fix to one of the files you removed
from staging in my tree, but that was reasy to resolve.

However, I got the following error when trying to push these out:

Commit: b3c20190dd32 ("iio: Fix iio_read_channel_processed_scale()")
	Fixes tag: Fixes: dc98269f7c7d ("iio: Provide iio_read_channel_processed_scale() API")
	Has these problem(s):
	        - Target SHA1 does not exist

Where did that git commit id come from?

Can you fix that up please?

thanks,

greg k-h
