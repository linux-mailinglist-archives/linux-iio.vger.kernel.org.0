Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634D02AAC8D
	for <lists+linux-iio@lfdr.de>; Sun,  8 Nov 2020 18:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgKHRIx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Nov 2020 12:08:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:44754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727844AbgKHRIx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Nov 2020 12:08:53 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A67E20731;
        Sun,  8 Nov 2020 17:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604855333;
        bh=XGNxpA2FyNjdWXq+9xcFrh6PaAG1cJlxPgvu5XIJb24=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oa20N8mkNs7f9Xm45y7H9Vixmx2C/ABTScFL3wsr663k51arnokgdZH/r/5OwlWqe
         PTvSV+EFk8DiqypoYFj8RV/ou4AjnyzSGbsY5Y5lEipdFEe5NNq/PDCU1lES3eGny1
         TUkkQcZSBrw0jeKmdAOPEl1xNmmpI7laCgxrA0iE=
Date:   Sun, 8 Nov 2020 17:08:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 0/4] iio: adc: xilinx: use even more devres
Message-ID: <20201108170848.131f7746@archlinux>
In-Reply-To: <20201102142228.14949-1-brgl@bgdev.pl>
References: <20201102142228.14949-1-brgl@bgdev.pl>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  2 Nov 2020 15:22:24 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This is a follow-up to commit 750628c79bb1 ("iio: adc: xilinx-xadc: use
> devm_krealloc()"). I noticed we can use even more devres helpers and entirely
> drop the remove() callback.
Given the generic nature of the additions to device.h I'm going to
let this one sit a little longer for review.

Remind me in a few weeks time if I seem to have lost it.
Also, do a quick sanity check on whether I am fine to drop
the platform_set_drvdata in the final patch.

Thanks,

Jonathan

> 
> v1 -> v2:
> - squash three patches adding more devres calls into one for easier review
> - don't insist on the 80 characters limit
> - add a new helper: devm_krealloc_array() and use it
> 
> Bartosz Golaszewski (4):
>   device: provide devm_krealloc_array()
>   iio: adc: xilinx: use helper variable for &pdev->dev
>   iio: adc: xilinx: use devm_krealloc_array() instead of kfree() +
>     kcalloc()
>   iio: adc: xilinx: use more devres helpers and remove remove()
> 
>  drivers/iio/adc/xilinx-xadc-core.c | 151 +++++++++++++----------------
>  include/linux/device.h             |  11 +++
>  2 files changed, 80 insertions(+), 82 deletions(-)
> 

