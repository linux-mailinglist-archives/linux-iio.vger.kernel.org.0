Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CB428A712
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 13:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgJKLGJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 07:06:09 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:17629 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725863AbgJKLGJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Oct 2020 07:06:09 -0400
X-IronPort-AV: E=Sophos;i="5.77,362,1596492000"; 
   d="scan'208";a="471985188"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 13:06:06 +0200
Date:   Sun, 11 Oct 2020 13:06:06 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Deepak R Varma <mh12gx2825@gmail.com>
cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] staging: iio: adis16240: add blank
 line before struct definition
In-Reply-To: <20201011104800.GA29412@ubuntu204>
Message-ID: <alpine.DEB.2.22.394.2010111303540.2716@hadrien>
References: <20201011104800.GA29412@ubuntu204>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On Sun, 11 Oct 2020, Deepak R Varma wrote:

> Add a blank line before starting structure definition as per coding
> style guidelines. Issue reported by checkpatch script.
>
> Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>

Acked-by: Julia Lawall <julia.lawall@inria.fr>

> ---
>  drivers/staging/iio/accel/adis16240.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
> index 5064adce5f58..8d3afc6dc755 100644
> --- a/drivers/staging/iio/accel/adis16240.c
> +++ b/drivers/staging/iio/accel/adis16240.c
> @@ -426,6 +426,7 @@ static int adis16240_probe(struct spi_device *spi)
>
>  	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
> +
>  static const struct of_device_id adis16240_of_match[] = {
>  	{ .compatible = "adi,adis16240" },
>  	{ },
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20201011104800.GA29412%40ubuntu204.
>
