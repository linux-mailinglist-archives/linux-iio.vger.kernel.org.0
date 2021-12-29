Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB1E48160D
	for <lists+linux-iio@lfdr.de>; Wed, 29 Dec 2021 19:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhL2SaL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Dec 2021 13:30:11 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51030 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhL2SaL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Dec 2021 13:30:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9082261500
        for <linux-iio@vger.kernel.org>; Wed, 29 Dec 2021 18:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED2CC36AE7;
        Wed, 29 Dec 2021 18:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640802610;
        bh=OWXb1DnguN/VDImR5f8uv9chXjndgnLu+aQZ9oS6TTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XSTrz2U3pe0qh2Kc3jW5Oixw9QSxXlZQ2S0QZhrqjD9eAZDVqy/URaIB6JykWc5c2
         y/4qA9TZbvXGRKAAYCHeE7Q40mMDuT5hozCMuVChMA43uPAoMaACQIKO54UMRP18yy
         NAnGHu65C5B7gC5EGSnZ5R+SG24GKWRwld8byK9Y=
Date:   Wed, 29 Dec 2021 19:29:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 2nd set of IIO new device support and cleanups for 5.17
Message-ID: <YcypIc0R7xWoZavo@kroah.com>
References: <20211229172354.605d75c9@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229172354.605d75c9@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 29, 2021 at 05:23:54PM +0000, Jonathan Cameron wrote:
> The following changes since commit 1bb866dcb8cf5054de88f592fc0ec1f275ad9d63:
> 
>   Merge tag 'iio-for-5.17a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next (2021-12-22 12:33:01 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.17b

Pulled and pushed out, thanks.

greg k-h
