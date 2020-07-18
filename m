Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46E7224CDB
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 18:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgGRQIa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 12:08:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgGRQIa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 12:08:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75F232073A;
        Sat, 18 Jul 2020 16:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595088510;
        bh=IgWASNzW3tr6+SzNmBPcPrb48Zc+oZWMEdPLbXn+3Uo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EmnlrX5cG/76tgUZUozfWqwBoW41VdvBffUTzF2xk7o+MSqLOnq5N5UMPKRtKEPKl
         qe0e2wsdNW8Tl8b19nsiGYoMKEzD+h61GDA/phBWq52ji+9o0V0bhMy3jfFkLOCLvY
         wuoUOHYMuiz0/KlL3DKt/HnwXD+TEAQ8P3nXNmYM=
Date:   Sat, 18 Jul 2020 17:08:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Samu Onkalo <samu.p.onkalo@nokia.com>
Subject: Re: [PATCH 27/30] iio: magnetometer: ak8974: Add description for
 ak8974's 'scan' attribute
Message-ID: <20200718170825.635137c6@archlinux>
In-Reply-To: <20200717165538.3275050-28-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-28-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:35 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/magnetometer/ak8974.c:200: warning: Function parameter or member 'scan' not described in 'ak8974'
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Samu Onkalo <samu.p.onkalo@nokia.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuidlers to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/magnetometer/ak8974.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
> index 91c39352fba26..4d6d8b699f037 100644
> --- a/drivers/iio/magnetometer/ak8974.c
> +++ b/drivers/iio/magnetometer/ak8974.c
> @@ -180,6 +180,7 @@
>   * @drdy_irq: uses the DRDY IRQ line
>   * @drdy_complete: completion for DRDY
>   * @drdy_active_low: the DRDY IRQ is active low
> + * @scan: timestamps
>   */
>  struct ak8974 {
>  	struct i2c_client *i2c;

