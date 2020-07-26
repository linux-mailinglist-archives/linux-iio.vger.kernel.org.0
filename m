Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A43022DF01
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jul 2020 14:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgGZMbz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jul 2020 08:31:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgGZMbz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Jul 2020 08:31:55 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C95A206D8;
        Sun, 26 Jul 2020 12:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595766714;
        bh=64jkf8HdiGlThD3TjFZUSJwmh+YG4CVPZeKKn7qGpaw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Eo9uitdOnjtC0uvISSt6MaHCKvkOl65P7XYhxs0IrKxgQrvpPDYniRlKh9YTrCzZ7
         hpVgn2jt5JwJz0lt1vFKt76yaYUIJa8tfxxlDtLt2NrCaxSMREoHxcetUIeZDiD0f+
         gtzsHfeCbrgi8EXVxjKxlpAREgHVrs9tMyLKXeeo=
Date:   Sun, 26 Jul 2020 13:31:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: Kconfig: ad8366: add entry for HMC1119 chip
Message-ID: <20200726133151.7a735fbd@archlinux>
In-Reply-To: <20200720135237.72835-1-alexandru.ardelean@analog.com>
References: <20200720135237.72835-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Jul 2020 16:52:37 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The change is mostly cosmetic. When looking into the menuconfig help of the
> ad8366 driver, the HMC1119 chip should also show up (since the driver
> supports it).
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied

> ---
>  drivers/iio/amplifiers/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
> index 9b02c9a2bc8a..5eb1357a9c78 100644
> --- a/drivers/iio/amplifiers/Kconfig
> +++ b/drivers/iio/amplifiers/Kconfig
> @@ -18,6 +18,7 @@ config AD8366
>  	    AD8366 Dual-Digital Variable Gain Amplifier (VGA)
>  	    ADA4961 BiCMOS RF Digital Gain Amplifier (DGA)
>  	    ADL5240 Digitally controlled variable gain amplifier (VGA)
> +	    HMC1119 0.25 dB LSB, 7-Bit, Silicon Digital Attenuator
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad8366.

