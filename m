Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6169A2C8F07
	for <lists+linux-iio@lfdr.de>; Mon, 30 Nov 2020 21:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388381AbgK3UV5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Nov 2020 15:21:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:58068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387449AbgK3UV4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Nov 2020 15:21:56 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6197B2073C;
        Mon, 30 Nov 2020 20:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606767676;
        bh=3vBda+pxIcoAiOM7rrSvH/AB34KT1Bwlkb2BskN4kv0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hqFZh5fJSGpKMENMR3RzKM3trL2jgcZyPhOo7LsmmYPuN98YT28DK+3UOnaR6LB+w
         /gmeei9bASpcrllTWe4fElIm22Uz0Oi7p0dLfCYDt9Jgdrtph6mU7PTZW1LazbDKkS
         0ebg14kd2//yhhitOhFMn3cYNcTDsYP+tavBOM/g=
Date:   Mon, 30 Nov 2020 20:21:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Anand Ashok Dumbre <ANANDASH@xilinx.com>
Subject: Re: [PATH v3 0/3] iio: adc: xilinx: use even more devres
Message-ID: <20201130202110.62e7f989@archlinux>
In-Reply-To: <20201130142759.28216-1-brgl@bgdev.pl>
References: <20201130142759.28216-1-brgl@bgdev.pl>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Nov 2020 15:27:56 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This is a follow-up to commit 750628c79bb1 ("iio: adc: xilinx-xadc: use
> devm_krealloc()"). I noticed we can use even more devres helpers and entirely
> drop the remove() callback.
> 
> v1 -> v2:
> - squash three patches adding more devres calls into one for easier review
> - don't insist on the 80 characters limit
> - add a new helper: devm_krealloc_array() and use it
> 
> v2 -> v3:
> - drop the devm_krealloc_array() helper
> 
> Bartosz Golaszewski (3):
>   iio: adc: xilinx: use helper variable for &pdev->dev
>   iio: adc: xilinx: use devm_krealloc() instead of kfree() + kcalloc()
>   iio: adc: xilinx: use more devres helpers and remove remove()
> 
>  drivers/iio/adc/xilinx-xadc-core.c | 157 ++++++++++++++---------------
>  1 file changed, 74 insertions(+), 83 deletions(-)
> 

Series looks good to me but would like to leave it a little longer to let
others take a look at it. That will probably mean it falls into next cycle
now.

+CC Anand who is looking at another series touching this driver and might
give this one a spin as well.

Thanks,

Jonathan

