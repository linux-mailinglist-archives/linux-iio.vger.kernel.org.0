Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1163D483C
	for <lists+linux-iio@lfdr.de>; Sat, 24 Jul 2021 17:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhGXO0f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Jul 2021 10:26:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhGXO0f (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Jul 2021 10:26:35 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4526460C41;
        Sat, 24 Jul 2021 15:07:04 +0000 (UTC)
Date:   Sat, 24 Jul 2021 16:09:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v5 0/3] iio: vcnl3020: add periodic mode, threshold
 options
Message-ID: <20210724160934.0ffede6e@jic23-huawei>
In-Reply-To: <20210722154420.915082-1-i.mikhaylov@yadro.com>
References: <20210722154420.915082-1-i.mikhaylov@yadro.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 22 Jul 2021 18:44:17 +0300
Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:

> Add periodic mode enablement, high/low threshold options.
> 
> Changes from v1:
>  1. Remove changes for hwmon driver and changes affecting
> vcnl3020 data structure.
>  2. Add enable/disable periodic mode functions.
> 
> Changes from v2:
>  1. Minor fixes from Jonathan's comments.
> 
> Changes from v3:
>  1. add DMA safe buffer in vcnl3020_data and use it on bulk_read/write
>     calls
>  2. put vcnl3020_is_in_periodic_mode in vcnl3020_measure_proximity and
>     vcnl3020_write_proxy_samp_freq
>  3. add mutex instead of iio_claim in vcnl3020_write_proxy_samp_freq
>  4. out_mutex -> err_unlock
> 
> Changes from v4:
>  1. split into 3 patches - DMA safe buffer, periodic mode, change
>     iio_claim/release on mutex.
>  2. add dev_err for regmap_read/write

Hi Ivan,

Given I only wanted some trivial changes in patch 2, I've made those whilst applying
rather that wasting either of our time with a v6.  Please take a quick look to check
I didn't mess anything up!

Applied to the togreg branch of iio.git on kernel.org and pushed out as testing for
0-day to poke at it and see what it can find,

Thanks,

Jonathan

> 
> Ivan Mikhaylov (3):
>   iio: proximity: vcnl3020: add DMA safe buffer
>   iio: proximity: vcnl3020: add periodic mode
>   iio: proximity: vcnl3020: remove iio_claim/release_direct
> 
>  drivers/iio/proximity/vcnl3020.c | 354 +++++++++++++++++++++++++++++--
>  1 file changed, 338 insertions(+), 16 deletions(-)
> 

