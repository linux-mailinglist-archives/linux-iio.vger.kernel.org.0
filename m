Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F8F224CCB
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 18:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGRQAi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 12:00:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRQAi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 12:00:38 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2641D2070E;
        Sat, 18 Jul 2020 16:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595088037;
        bh=QRRTW3VgCAydzJZpqZ+JaipKjgR0sd4k2PtilOz4w6s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vr9spAtTKWdT+ZRAGLTXtyMB8Ml5JO/jhsNtgRmxYTUyiUZN7jz3foqXiTfhvPhCX
         7SK2vFzAsFavHzgviFEpld7UwzJqa/Ge3N1zxw5BhPQieFUSEu/GDB7G1/o2g1CBc+
         KS9c4kkdEVwGR/PxyCWH2ShdFHo/kGZI0xI//ptM=
Date:   Sat, 18 Jul 2020 17:00:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Oskar Andero <oskar.andero@gmail.com>,
        Bendorff Jensen <abj@rosetechnology.dk>,
        Soren Andersen <san@rosetechnology.dk>
Subject: Re: [PATCH 22/30] iio: adc: mcp320x: Change ordering of compiler
 attribute macro
Message-ID: <20200718170033.751130a7@archlinux>
In-Reply-To: <20200717165538.3275050-23-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-23-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:30 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Kerneldoc gets confused if the variable does not follow th
> type/attribute definitions.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/adc/mcp320x.c:96: warning: Function parameter or member '____cacheline_aligned' not described in 'mcp320x'
> 
> Cc: Oskar Andero <oskar.andero@gmail.com>
> Cc: Bendorff Jensen <abj@rosetechnology.dk>
> Cc: Soren Andersen <san@rosetechnology.dk>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Holding this one whilst we discuss the right fix for this sort of issue.

J
> ---
>  drivers/iio/adc/mcp320x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
> index 2c0eb5de110ca..191a8f644ffe7 100644
> --- a/drivers/iio/adc/mcp320x.c
> +++ b/drivers/iio/adc/mcp320x.c
> @@ -91,7 +91,7 @@ struct mcp320x {
>  	struct mutex lock;
>  	const struct mcp320x_chip_info *chip_info;
>  
> -	u8 tx_buf ____cacheline_aligned;
> +	u8 ____cacheline_aligned tx_buf;
>  	u8 rx_buf[4];
>  };
>  

