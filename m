Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAF644722C
	for <lists+linux-iio@lfdr.de>; Sun,  7 Nov 2021 09:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbhKGIb5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Nov 2021 03:31:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:45414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229966AbhKGIb5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Nov 2021 03:31:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0538161101;
        Sun,  7 Nov 2021 08:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636273754;
        bh=Cw4mcFHOW+d1qOkd6B9pcfhOqnJaP9Qk7Xmz88ff2X4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yo7Pf9aSKbpP2pID2VOZUUzdpnMGQziZIVWi0Cf3qigJ84gMiH4x/CMxdDofzdGpO
         4d9/hbl3fiE7Fcxj8213FBNGG/lSiyZa/L3Ih81q03X5PIG2FLUotR/NaCINHAkXZ1
         Th/HiPRamY9S93cVTs7Przu4LJAAu58EjjWrdEFQ=
Date:   Sun, 7 Nov 2021 09:29:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/1] device property: Adding fwnode_irq_get_by_name()
Message-ID: <YYeOVJjiz6huHv4y@kroah.com>
References: <20211106173909.34255-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211106173909.34255-1-puranjay12@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 06, 2021 at 11:09:08PM +0530, Puranjay Mohan wrote:
> While working on an IIO driver I was told to use of_irq_get_byname() as
> the generic version is not available in property.c.
> I wish to work on this and have written a function that may work.
> I am not sure about its correctness so I am posting this patch early for
> review.

Please test your code, and also provide a user for it.  We can not take
new functions that no one uses as that usually means they do not work.

thanks,

greg k-h
