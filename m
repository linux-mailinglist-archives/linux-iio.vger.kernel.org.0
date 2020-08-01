Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4D22353EC
	for <lists+linux-iio@lfdr.de>; Sat,  1 Aug 2020 20:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgHASDZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Aug 2020 14:03:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgHASDZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Aug 2020 14:03:25 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21C11206E9;
        Sat,  1 Aug 2020 18:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596305005;
        bh=RpumIN1K0OiBojvxX6BEGp1Ji0SqZsnWgJjwSc1Pz/I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bAzzRgFEJjGSE6CogM9RMGXleBtQTQfNQAO/KbYwmH1ICDdQOjtwRAL7JcaRscQ6R
         rMqmTPX+e83J7ohN8bQjoXDpHFE/cuWVxNiVpZp+9OzEdL9ho78b75QNU0YMCg79SH
         FALWlhMJKhz+J3FoNFZG0BAQ2lwP32oEIMqvvvQs=
Date:   Sat, 1 Aug 2020 19:03:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] platform_data: ad7793.h: drop a duplicated word
Message-ID: <20200801190321.3a61e22b@archlinux>
In-Reply-To: <20200719003040.20848-1-rdunlap@infradead.org>
References: <20200719003040.20848-1-rdunlap@infradead.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 Jul 2020 17:30:40 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Drop the repeated word "and" in a comment.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
Applied to the togreg branch of iio.git

Thanks,

Jonathan

> ---
>  include/linux/platform_data/ad7793.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200717.orig/include/linux/platform_data/ad7793.h
> +++ linux-next-20200717/include/linux/platform_data/ad7793.h
> @@ -40,7 +40,7 @@ enum ad7793_bias_voltage {
>   * enum ad7793_refsel - AD7793 reference voltage selection
>   * @AD7793_REFSEL_REFIN1: External reference applied between REFIN1(+)
>   *	and REFIN1(-).
> - * @AD7793_REFSEL_REFIN2: External reference applied between REFIN2(+) and
> + * @AD7793_REFSEL_REFIN2: External reference applied between REFIN2(+)
>   *	and REFIN1(-). Only valid for AD7795/AD7796.
>   * @AD7793_REFSEL_INTERNAL: Internal 1.17 V reference.
>   */

