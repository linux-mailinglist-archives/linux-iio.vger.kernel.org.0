Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2260D224C2D
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 17:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgGRPC3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 11:02:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgGRPC3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:02:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 988B12065D;
        Sat, 18 Jul 2020 15:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595084549;
        bh=uPmy615wj1O+XHgWbWdN70//remefX009xQEmoQDO7c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FywgDekd004YOLH9XanyY34r4zLpYpezSZ4ajm2euqNB3jnzLRlf+b5YFdeM+1bQ/
         D0DBiTasduqKRPnrTsyE1PRMQ+Sr4OKEB4AM5pILa1MmDZ+wSvISCAUNPAG8znDFD5
         ewZtEh11VZZXUI5z0OAPPmqiTfiScro2IKCDuxD8=
Date:   Sat, 18 Jul 2020 16:02:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 18/30] iio: dummy: iio_simple_dummy_buffer: Demote file
 header and correct misspelling
Message-ID: <20200718160224.3c28bc2c@archlinux>
In-Reply-To: <20200716135928.1456727-19-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-19-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:16 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> File headers are not good candidates for kerneldoc.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/dummy/iio_simple_dummy_buffer.c:27: warning: cannot understand function prototype: 'const s16 fakedata[] = '
>  drivers/iio/dummy/iio_simple_dummy_buffer.c:185: warning: Function parameter or member 'indio_dev' not described in 'iio_simple_dummy_unconfigure_buffer'
>  drivers/iio/dummy/iio_simple_dummy_buffer.c:185: warning: Excess function parameter 'indo_dev' description in 'iio_simple_dummy_unconfigure_buffer'
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied.

Jonathan

> ---
>  drivers/iio/dummy/iio_simple_dummy_buffer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
> index 17606eca42b43..40d30c0a60ce5 100644
> --- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
> +++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * Copyright (c) 2011 Jonathan Cameron
>   *
>   * Buffer handling elements of industrial I/O reference driver.
> @@ -179,7 +179,7 @@ int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
>  
>  /**
>   * iio_simple_dummy_unconfigure_buffer() - release buffer resources
> - * @indo_dev: device instance state
> + * @indio_dev: device instance state
>   */
>  void iio_simple_dummy_unconfigure_buffer(struct iio_dev *indio_dev)
>  {

