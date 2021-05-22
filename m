Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F43B38D6C3
	for <lists+linux-iio@lfdr.de>; Sat, 22 May 2021 20:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhEVSDX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 22 May 2021 14:03:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:49334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231254AbhEVSDW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 May 2021 14:03:22 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 437D26102A;
        Sat, 22 May 2021 18:01:55 +0000 (UTC)
Date:   Sat, 22 May 2021 19:03:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 0/2] Make use of adis lock helpers
Message-ID: <20210522190318.284b54b5@jic23-huawei>
In-Reply-To: <20210520115909.466275-1-nuno.sa@analog.com>
References: <20210520115909.466275-1-nuno.sa@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 20 May 2021 13:59:07 +0200
Nuno Sá <nuno.sa@analog.com> wrote:

> In [1], some helpers were added to the adis lib to make things a bit
> more neater when users need to use the device lock. Somehow, these two
> users were left "behind". Let's make things consistent and make them use
> the helpers.
>  
> [1]: https://patchwork.kernel.org/project/linux-iio/patch/20210218114039.216091-5-nuno.sa@analog.com/
> 
> Nuno Sá (2):
>   iio: adis16260: make use of adis lock helpers
>   iio: adis16136: make use of adis lock helpers
> 
>  drivers/iio/gyro/adis16136.c | 15 ++++++---------
>  drivers/iio/gyro/adis16260.c |  4 ++--
>  2 files changed, 8 insertions(+), 11 deletions(-)
> 
Applied to the togreg branch of iio.git and pushed out as testing for
all the normal reasons.

Thanks,

Jonathan


