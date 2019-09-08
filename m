Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D961ACBC8
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2019 11:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfIHJ3R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Sep 2019 05:29:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbfIHJ3R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Sep 2019 05:29:17 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EBFE20863;
        Sun,  8 Sep 2019 09:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567934956;
        bh=g3MzwCNbs4e/QTBt4lYQwYk1fLLibbwie2HBzi2uKSA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ixfILe8lZ19CywYVxuO2JOuSLRqrUR8pMi3EHFJiPb4E1IPioKe2bQOk4+jRO7jMf
         rSV6in/ryJZMLXdqQoJDwgTsgoG1oACM8LVZrfJxB/7yuwGw3v9DAW4rMLJ2UEGc+d
         7OFtJPVwrtodmH7qLN0xt+ghp+IN6IfAUbVLrVDA=
Date:   Sun, 8 Sep 2019 10:29:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: accel: adxl372: Fix push to buffers lost
 samples
Message-ID: <20190908102911.17981f71@archlinux>
In-Reply-To: <1567502313-10314-1-git-send-email-stefan.popa@analog.com>
References: <1567502313-10314-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 3 Sep 2019 12:18:33 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> One in two sample sets was lost by multiplying fifo_set_size with
> sizeof(u16). Also, the double number of available samples were pushed to
> the iio buffers.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Looks right to me.   Will pick up once we've resolved the questions
on patch 1.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/adxl372.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index adec37b..72d3f45 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -548,8 +548,7 @@ static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
>  			goto err;
>  
>  		/* Each sample is 2 bytes */
> -		for (i = 0; i < fifo_entries * sizeof(u16);
> -		     i += st->fifo_set_size * sizeof(u16))
> +		for (i = 0; i < fifo_entries; i += st->fifo_set_size)
>  			iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
>  	}
>  err:

