Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5084332D2
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 11:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbhJSJtz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 05:49:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235157AbhJSJtw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 Oct 2021 05:49:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8737760C51;
        Tue, 19 Oct 2021 09:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634636860;
        bh=AJksU55ztX9xFG7LJm9ARBhcAEW4jpa0MpBiCE+aw0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NnWesIKU352sZh15fPRJT9zdYsRdPnhfCmHLQalXmVG5MA+dLtE0RoG4bMSbx9AgM
         ieFejPH3p4apl0FqIpBghsurnLtA1vp5EPHkiwDg/quQ4gvMi5iu8YmxMxJBUEWnTH
         gs6m46dcDaLDsY7MQfAtzV2A53iE4nEmvy6uIShU=
Date:   Tue, 19 Oct 2021 11:45:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL V4] 1st set of IIO new device support, features and
 cleanup for  the 5.16 cycle
Message-ID: <YW6TpjfNXjP7ZyfN@kroah.com>
References: <20211019083901.17a46851@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019083901.17a46851@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 19, 2021 at 08:39:19AM +0100, Jonathan Cameron wrote:
> The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
> 
>   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.16a-split-take4

4th try was the charm :)

Now pulled and pushed out and will let 0-day bot run on them now...

thanks,

greg k-h
