Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D6233C014
	for <lists+linux-iio@lfdr.de>; Mon, 15 Mar 2021 16:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhCOPgb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Mar 2021 11:36:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232943AbhCOPgC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Mar 2021 11:36:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A72AA64E74;
        Mon, 15 Mar 2021 15:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615822562;
        bh=DJ39GDZtIHcc7Jyqr34tzr36X8jS7yfacr1rgPMYwjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hp0y499Rp/theKih/B+pEX+liGiLHfvuNyhginGfTbIWE3UmVTqRrBlw5bfBhrteY
         yutmIk9Vb6E8TpFHq+QY7FnpWa6iqbU2lGveJpx6tOxQfg1E8AJSLp3K/wNlLeP7RQ
         VVLr07TnTQcNjvIA2VelFSV2M5sptmPMSXEHSQUQ=
Date:   Mon, 15 Mar 2021 16:35:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO and counter fixes for 5.12, set 1
Message-ID: <YE9+xj3Rk2aJJqbz@kroah.com>
References: <20210314152120.5bc6503c@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210314152120.5bc6503c@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 14, 2021 at 03:21:20PM +0000, Jonathan Cameron wrote:
> The following changes since commit a1bfb0ccf94dc79223d0db0d50237d3b3898f0b2:
> 
>   Merge tag 'iio-fixes-for-5.11a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2021-01-15 08:16:35 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.12a

Pulled and pushed out, thanks.

greg k-h
