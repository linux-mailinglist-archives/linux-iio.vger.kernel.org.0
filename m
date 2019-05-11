Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9B21A7AF
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2019 13:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfEKLoW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 May 2019 07:44:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfEKLoW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 May 2019 07:44:22 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E70812146F;
        Sat, 11 May 2019 11:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557575061;
        bh=MJR5ahSpUxEmKVrMcSMljJNXfuNHudskMOfEayiyHp8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oewwX8k9+PjdwOn12jMpcDGSb5520QQQk3AZ4D0ZAeN2prvzQ2BczCk8CDgryy6RA
         7+x+4xcdwcDZiIt5diHd4KRWCtQcCVHbI4BhxhVQ7RO7WQnEJJ6VwIBEz6O9qSlQCh
         Ir/BZ2c04iaGkuBn/stZN1lTUq+1o7NMpJCD0fXU=
Date:   Sat, 11 May 2019 12:44:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ti-ads8688: save values correct in buffer
Message-ID: <20190511124417.1b5bbf23@archlinux>
In-Reply-To: <20190507082304.11692-1-sean@geanix.com>
References: <20190507082304.11692-1-sean@geanix.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  7 May 2019 10:23:03 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> Fill the read values in the buffer so we comply
> with the given index values.
Why?

They are not supposed to always remain in the same place. If some channels
are turned off then they will shift 'down'.  That has to happen in general
to allow us to do more efficient packing when they happen to fit into a
smaller power of 2 size.
So if channels 0-3 (8 bits each) are enabled and timestamp, it should be

0 1 2 3 X X X X Timestamp, 0 1 2 3 X X X X Timestamp..

If no timestamp it should fall back to the packing
0 1 2 3, 0 1 2 3

If only channels 0, 1 and 3 we should get

0 1 3 X, 0 1 3 X (padding to 32 bits)

For only 0 and 3
0 3, 0 3, 0 3

For only 0
0, 0, 0, 0, 0, 0 

Jonathan

> 
> Fixes: 2a86487786b5c ("iio: adc: ti-ads8688: add trigger and buffer support")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/iio/adc/ti-ads8688.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
> index f9461070a74a..d9c354dbd7e4 100644
> --- a/drivers/iio/adc/ti-ads8688.c
> +++ b/drivers/iio/adc/ti-ads8688.c
> @@ -387,13 +387,12 @@ static irqreturn_t ads8688_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	u16 buffer[ADS8688_MAX_CHANNELS + sizeof(s64)/sizeof(u16)];
> -	int i, j = 0;
> +	int bit;
>  
> -	for (i = 0; i < indio_dev->masklength; i++) {
> -		if (!test_bit(i, indio_dev->active_scan_mask))
> -			continue;
> -		buffer[j] = ads8688_read(indio_dev, i);
> -		j++;
> +	memset(buffer, 0, sizeof(buffer));
> +
> +	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength) {
> +		buffer[bit] = ads8688_read(indio_dev, bit);
>  	}
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, buffer,

