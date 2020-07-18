Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01331224C3F
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 17:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGRPIH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 11:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbgGRPIH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:08:07 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A98412067D;
        Sat, 18 Jul 2020 15:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595084887;
        bh=EgGB+ugeIQQwLzSLmGioU4i2h2QENrkT5BGNqVLjjow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WMUuIEteR/3UF9zmCrn26mhUOitjFBpZCNZF3mfhSa6GTokRz6JAQL+DMUg2LQkdL
         qlZJpUH3GrIYePq15SQBSQEQwqUWBXLPFAerkgyjiC+BzdXu9wXBwaNvehYbIUfyfK
         9WRfTlYamjjns9gfEP8Nqb9hfxQirR7OBTPyddHE=
Date:   Sat, 18 Jul 2020 16:08:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 22/30] iio: dac: ad5755: Fix kerneldoc attribute
 formatting for 'lock'
Message-ID: <20200718160802.55ca2232@archlinux>
In-Reply-To: <20200716135928.1456727-23-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-23-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:20 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Kerneldoc expects attributes/parameters to be in '@*.: ' format.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/dac/ad5755.c:105: warning: Function parameter or member 'lock' not described in 'ad5755_state'
> 
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied. Thanks,

J

> ---
>  drivers/iio/dac/ad5755.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
> index 7723bd313fc6e..bee4ed0ce91a8 100644
> --- a/drivers/iio/dac/ad5755.c
> +++ b/drivers/iio/dac/ad5755.c
> @@ -82,7 +82,7 @@ struct ad5755_chip_info {
>   * @pwr_down:	bitmask which contains  hether a channel is powered down or not
>   * @ctrl:	software shadow of the channel ctrl registers
>   * @channels:	iio channel spec for the device
> - * @lock	lock to protect the data buffer during SPI ops
> + * @lock:	lock to protect the data buffer during SPI ops
>   * @data:	spi transfer buffers
>   */
>  struct ad5755_state {

