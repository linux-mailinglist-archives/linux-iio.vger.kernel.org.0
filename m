Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8B538CD13
	for <lists+linux-iio@lfdr.de>; Fri, 21 May 2021 20:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbhEUSTN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 May 2021 14:19:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236518AbhEUSTM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 May 2021 14:19:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B94A361019;
        Fri, 21 May 2021 18:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621621069;
        bh=+smosVm/TN2FjUX5kxxCb38aKidx99de1jZtXpEYp08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cAkCbyZg6GbAfdLbIpf6Ie1EURyGRJfWM0K/+cEWQQLb+BW8JVWuY2SlbSa/UjR/1
         kI67pdGV4+oQvBebwB1x4JcN9nld/uFkmFreMJWuGrfhSZSX9MpPDQbi4OFoDpksqv
         GvuFuG1T6kzzQpGx3saH5GF6TAS7wByjhldaX1gE=
Date:   Fri, 21 May 2021 20:17:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 2nd set of IIO fixes for the 5.13 cycle.
Message-ID: <YKf5S+avRha12kAW@kroah.com>
References: <20210521181509.419b9db0@jic23-huawei>
 <YKf4IOiTV5cyd++3@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKf4IOiTV5cyd++3@kroah.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 21, 2021 at 08:12:48PM +0200, Greg KH wrote:
> On Fri, May 21, 2021 at 06:15:09PM +0100, Jonathan Cameron wrote:
> > The following changes since commit ba9c25d94dea1a57492a606a1f5dde70d2432583:
> > 
> >   Merge tag 'iio-fixes-5.13a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2021-05-11 15:17:55 +0200)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-5.13b
> 
> Pulled and pushed out, thanks.

Oops, nope, didn't work:

 Commit 488abb0f5c83 ("iio: gyro: fxas21002c: balance runtime power in error path")
	committer Signed-off-by missing
	author email:    rui.silva@linaro.org
	committer email: Jonathan.Cameron@huawei.com
	Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>


I've rolled it back in my local tree and never pushed it out to the
public.

Can you fix this up?  linux-next didn't catch this already?

thanks,

greg k-h
