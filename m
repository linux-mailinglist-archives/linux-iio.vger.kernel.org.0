Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231D243102D
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 08:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhJRGKi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 02:10:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbhJRGKi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 Oct 2021 02:10:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F1EE610A6;
        Mon, 18 Oct 2021 06:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634537307;
        bh=r04T2c+9oBcdiXKL4Xe8gxRyhRIfiFS5MF915UNBWeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mbe79Fr3OfSob3grAPxj2XjntzeEBJWPotyEIQ2cyZDKhfk9QOJrWsZEX6nIwzZHL
         v7n79QVfbaxauuq51wmKpbJ/yh8CZSJmPu6AaZRzIAM+sp/Ym9u6vwvGzw7D5FeLmX
         tKpK1fgd8J62SQvEGmvpmNToitvEHdF/JB0+klVY=
Date:   Mon, 18 Oct 2021 08:08:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: drop chrdev_lock
Message-ID: <YW0PVYT/GCKAnjN9@kroah.com>
References: <20211017185521.3468640-1-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017185521.3468640-1-david@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 17, 2021 at 01:55:21PM -0500, David Lechner wrote:
> This removes the chrdev_lock from the counter subsystem. This was
> intended to prevent opening the chrdev more than once. However, this
> doesn't work in practice since userspace can duplicate file descriptors
> and pass file descriptors to other processes. Since this protection
> can't be relied on, it is best to just remove it.

Much better, thanks!

One remaining question:

> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -297,7 +297,6 @@ struct counter_ops {
>   * @events:		queue of detected Counter events
>   * @events_wait:	wait queue to allow blocking reads of Counter events
>   * @events_lock:	lock to protect Counter events queue read operations
> - * @chrdev_lock:	lock to limit chrdev to a single open at a time
>   * @ops_exist_lock:	lock to prevent use during removal

Why do you still need 2 locks for the same structure?

thanks,

greg k-h
