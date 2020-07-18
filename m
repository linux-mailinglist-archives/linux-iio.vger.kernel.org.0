Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27692224BD1
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 16:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgGROa0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 10:30:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbgGROaZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 10:30:25 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D052E2064B;
        Sat, 18 Jul 2020 14:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595082625;
        bh=hSj5ozE6nlmBDB2UvoDj+PMby8N54ruWX+quUPUBqqY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bvU9gLcHyzfQcWQlJ0h008mfH1DpUBduRBPdjsbl5AKlCNPKDgX+EW8m80mfdVpZu
         A3eycEbsJxzIUhb/gEHGMTEDkX7h36ZBAAwyRzLjCh5MVAqSD+EqhOkq6jKL4Gfpl/
         nbd0IUxK2NuyMGkubuxdZKYue+BuU/psGHhgKPl8=
Date:   Sat, 18 Jul 2020 15:30:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 04/30] iio: adc: ad7298: Demote obvious misuse of
 kerneldoc to standard comment blocks
Message-ID: <20200718153020.643f55c6@archlinux>
In-Reply-To: <20200716135928.1456727-5-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-5-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:02 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> No attempt has been made to document either of the demoted functions here.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/adc/ad7298.c:106: warning: Function parameter or member 'indio_dev' not described in 'ad7298_update_scan_mode'
>  drivers/iio/adc/ad7298.c:106: warning: Function parameter or member 'active_scan_mask' not described in 'ad7298_update_scan_mode'
>  drivers/iio/adc/ad7298.c:154: warning: Function parameter or member 'irq' not described in 'ad7298_trigger_handler'
>  drivers/iio/adc/ad7298.c:154: warning: Function parameter or member 'p' not described in 'ad7298_trigger_handler'
> 
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
As both are static, no particular reason they should have kernel-doc comments
so agreed we are better fixing this one by demoting rather than adding
the missing stuff.
Applied.

> ---
>  drivers/iio/adc/ad7298.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
> index dc8d8c5f6ad36..006b6f63cf4e8 100644
> --- a/drivers/iio/adc/ad7298.c
> +++ b/drivers/iio/adc/ad7298.c
> @@ -98,9 +98,9 @@ static const struct iio_chan_spec ad7298_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(8),
>  };
>  
> -/**
> +/*
>   * ad7298_update_scan_mode() setup the spi transfer buffer for the new scan mask
> - **/
> + */
>  static int ad7298_update_scan_mode(struct iio_dev *indio_dev,
>  	const unsigned long *active_scan_mask)
>  {
> @@ -144,12 +144,12 @@ static int ad7298_update_scan_mode(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> -/**
> +/*
>   * ad7298_trigger_handler() bh of trigger launched polling to ring buffer
>   *
>   * Currently there is no option in this driver to disable the saving of
>   * timestamps within the ring.
> - **/
> + */
>  static irqreturn_t ad7298_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;

