Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9CCD50A9
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 17:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbfJLP1t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 11:27:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727642AbfJLP1t (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 11:27:49 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 839912089C;
        Sat, 12 Oct 2019 15:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570894068;
        bh=HUFd5rh0Jng5NxtrWwFyuuzCs/LpKIrcYc5IOr5Khoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KHaGcopSyVNuwJCZw2NzeMJcJui7tNgrfn+KVsMS0Sm1m6GvStQ7yOJ+igyFcZTMr
         KvxUoGdKeG8Hq1S9Za/DiWTZDgIQtdW+wSkY0SpgJgVLKD4OjtjD3qovaTi13pIZnA
         UlH70zrvmXOQqLT1+yosnUxSqLB/KMTq1mmDzlQY=
Date:   Sat, 12 Oct 2019 17:27:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL v2] First set of iio new device support etc for the 5.5
 cycle
Message-ID: <20191012152744.GA2142233@kroah.com>
References: <20191012121946.051b646f@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191012121946.051b646f@archlinux>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 12, 2019 at 12:19:46PM +0100, Jonathan Cameron wrote:
> The following changes since commit b73b93a2af3392b9b7b8ba7e818ee767499f9655:
> 
>   iio: adc: ad7192: Add sysfs ABI documentation (2019-09-08 10:34:49 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.5a-take2

Better, but I see this now:

drivers/iio/imu/adis.c: In function ‘__adis_check_status’:
drivers/iio/imu/adis.c:295:9: warning: ‘status’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  295 |  status &= adis->data->status_error_mask;
      |         ^~


I'll take this, can you just send a follow-on patch for this?

thanks,

greg k-h
