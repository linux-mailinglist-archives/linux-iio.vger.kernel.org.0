Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AB9224C49
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 17:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgGRPKJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 11:10:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgGRPKJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:10:09 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C63972067D;
        Sat, 18 Jul 2020 15:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595085008;
        bh=lgIWion9D/0OTEIPDUtQys/BnOHW3hcw0kz4qL2VHgA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nd23bh3pd9ijTL9SdNUX38ajizHpH/XusgcniEzCTiAuDxlqXz1lVIkx1OMbMHtXc
         ChATbDYWGZsBGWUTw5UXUEtNRI4lmbWf6uZwcBNT42WQIynnqkVCK4jo9dddRjKtUS
         DpLS9RW7oCeYAbbLzPDRM4iH0NOtKRRo0GN4JNg0=
Date:   Sat, 18 Jul 2020 16:10:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Ricardo Ribalda <ribalda@kernel.org>
Subject: Re: [PATCH 24/30] iio: dac: ad5761: Fix kerneldoc attribute
 formatting for 'lock'
Message-ID: <20200718161004.4e73c08a@archlinux>
In-Reply-To: <20200716135928.1456727-25-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-25-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:22 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Kerneldoc expects attributes/parameters to be in '@*.: ' format.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/dac/ad5761.c:80: warning: Function parameter or member 'lock' not described in 'ad5761_state'
> 
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Ricardo Ribalda <ribalda@kernel.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5761.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5761.c b/drivers/iio/dac/ad5761.c
> index 67c4fa75c6f13..1d9d0e22d6f44 100644
> --- a/drivers/iio/dac/ad5761.c
> +++ b/drivers/iio/dac/ad5761.c
> @@ -57,7 +57,7 @@ enum ad5761_supported_device_ids {
>   * @use_intref:		true when the internal voltage reference is used
>   * @vref:		actual voltage reference in mVolts
>   * @range:		output range mode used
> - * @lock		lock to protect the data buffer during SPI ops
> + * @lock:		lock to protect the data buffer during SPI ops
>   * @data:		cache aligned spi buffer
>   */
>  struct ad5761_state {

