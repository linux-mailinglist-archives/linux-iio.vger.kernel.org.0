Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC295438873
	for <lists+linux-iio@lfdr.de>; Sun, 24 Oct 2021 13:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhJXLMB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Oct 2021 07:12:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230520AbhJXLMB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Oct 2021 07:12:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FC2760EDF;
        Sun, 24 Oct 2021 11:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635073780;
        bh=AdLDIxlKe3DGSF2jmdUvKHf9AX3jB/v2E2iZk+k9GsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ljgk1zcANHtwJSYnpwmTpYPP2k93edZ1Uom0UE3FTHYsSxUjJcAdjjXIOC1nTKQUL
         loAI7AoZ1FFuPQPYCzvaj0nmfp7I9TWw8ZQq2eQekFNn0BpQD5pP+Fkt9wMz7OACfm
         peCnU7CmD/4GBRCULSQBxeOQWjt//Hz17yx4oL+4=
Date:   Sun, 24 Oct 2021 13:09:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 1st set of IIO fixes for the 5.16 cycle (suggest queuing
 for merge window as nothing urgent)
Message-ID: <YXU+3FqY15Qje1+0@kroah.com>
References: <20211022162345.0000350c@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022162345.0000350c@Huawei.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Oct 22, 2021 at 04:23:45PM +0100, Jonathan Cameron wrote:
> The following changes since commit 37f12202c5d28291ba5f83ce229771447ce9148f:
> 
>   staging: r8188eu: prevent array underflow in rtw_hal_update_ra_mask() (2021-10-05 12:35:30 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.16a

Pulled and pushed out, thanks.

greg k-h
