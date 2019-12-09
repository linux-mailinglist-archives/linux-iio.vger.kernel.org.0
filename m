Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDBBF116827
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2019 09:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfLIIaj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Dec 2019 03:30:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbfLIIaj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Dec 2019 03:30:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 259262075B;
        Mon,  9 Dec 2019 08:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575880238;
        bh=DxPm//0BQj11U08FEuOA9gJXju4uD83HDUX/fayqCUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZbY+VfcZm56WQJn5Li5wzIq+fxy4x2Li0kZT2kTgdS/YBo8XRD2tPKFTylhTFs4sx
         K8eKA7eI38Ip4cjd0EIu020xZt4EBNQE0CU7XhgUkg+/gRpYnrrzg6pvujeRWf8Mpq
         ZzgRpBBwmY86ir1kjdj3898vgaE5wlWvT9ecVG7c=
Date:   Mon, 9 Dec 2019 09:30:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of IIO fixes for the 5.5 cycle.
Message-ID: <20191209083020.GD706232@kroah.com>
References: <20191208191334.614889c6@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191208191334.614889c6@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Dec 08, 2019 at 07:13:34PM +0000, Jonathan Cameron wrote:
> The following changes since commit 2611045e3555cd0d75837ae69ffd70ef51e28bf7:
> 
>   staging: vchiq: Refactor indentation in vchiq_platform_conn_state_changed() (2019-11-15 14:14:55 +0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.5a

Now merged, thanks,

greg k-h
