Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0083839FEA
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 15:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfFHNbQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 09:31:16 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:60898 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfFHNbQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Jun 2019 09:31:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 1F41A9E9162;
        Sat,  8 Jun 2019 14:31:13 +0100 (BST)
Date:   Sat, 8 Jun 2019 14:31:11 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Thomas Meyer <thomas@m3y3r.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: ftm-quaddec: needs HAS_IOMEM
Message-ID: <20190608143111.6c481920@archlinux>
In-Reply-To: <20190601213805.32733-1-thomas@m3y3r.de>
References: <20190601213805.32733-1-thomas@m3y3r.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  1 Jun 2019 23:38:05 +0200
Thomas Meyer <thomas@m3y3r.de> wrote:

> the driver fails for UML with:
> drivers/counter/ftm-quaddec.c:301: undefined reference to `devm_ioremap'
> 
> Fix it by depending on HAS_IOMEM
Missing Signed-off-by.

Unfortunately I came across another patch for this before yours so
already have this fixed in the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/counter/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 138ecd8a8fbd..6298344b536b 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -50,6 +50,7 @@ config STM32_LPTIMER_CNT
>  	  module will be called stm32-lptimer-cnt.
>  
>  config FTM_QUADDEC
> +	depends on HAS_IOMEM
>  	tristate "Flex Timer Module Quadrature decoder driver"
>  	help
>  	  Select this option to enable the Flex Timer Quadrature decoder

