Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8B637A769
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 15:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhEKNUB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 09:20:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231617AbhEKNUA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 May 2021 09:20:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80120613DE;
        Tue, 11 May 2021 13:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620739134;
        bh=W/s6eMWTvJ8lNIIAm77Jm0VhaFAEwiNRZCqBnbELlCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=grGNhtDxUfH/klKgtit/pjPM6D7Wvvbzx+XImXLLvPfQlf+UQmzPQWB+h29rI3hk3
         /8Xg1fxHWPRL6vOiVArc7TjsbQ6xgofVSb+Wcc5uml3U41LBaHT53bcQUqd97aOfBz
         SKin7+qV0tjLVVExuEiehVhG5EB4j0yZ/ioxt4Q4=
Date:   Tue, 11 May 2021 15:18:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of IIO fixes for the 5.13 cycle.
Message-ID: <YJqEK55aJT9S/tRW@kroah.com>
References: <20210511140003.7a6c6c30@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511140003.7a6c6c30@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 11, 2021 at 02:00:03PM +0100, Jonathan Cameron wrote:
> The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:
> 
>   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-5.13a

Pulled and pushed out, thanks!

greg k-h
