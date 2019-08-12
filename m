Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6280C8A8A1
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2019 22:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfHLUs6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Aug 2019 16:48:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbfHLUs5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Aug 2019 16:48:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69B8620684;
        Mon, 12 Aug 2019 20:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565642936;
        bh=rgBjjaX12IemedDGxBGyKLoZbffU7nlP8ahDTDRA7LM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mHxpnoGziuQAHtIfNCZvgstohyjBtXNeEjaPMUTjhiIr6XHGAUHTZ80XtxzvTjI0N
         b1ag20A7/Wu8XFShjD6O9lM1K61eh3IN02EVWTXDezaG23EAvyNWspUmyI1pE25rAD
         UxbvNbqJHhPS9TdbR5oLFUnpnNHQAPpMjdJL5PLE=
Date:   Mon, 12 Aug 2019 22:48:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] Second set of IIO fixes for the 5.3 cycle.
Message-ID: <20190812204854.GA12071@kroah.com>
References: <20190812202147.065fb84e@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812202147.065fb84e@archlinux>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 12, 2019 at 08:21:47PM +0100, Jonathan Cameron wrote:
> The following changes since commit 09f6109ff4f8003af3370dfee0f73fcf6d20087a:
> 
>   Merge tag 'iio-fixes-for-5.3a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2019-07-28 11:07:26 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.3b

Pulled and pushed out, thanks.

greg k-h
