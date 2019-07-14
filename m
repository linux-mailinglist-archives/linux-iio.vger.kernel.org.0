Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0BE6801D
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2019 18:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfGNQSC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jul 2019 12:18:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728065AbfGNQSC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jul 2019 12:18:02 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 103EA20C01;
        Sun, 14 Jul 2019 16:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563121082;
        bh=MzZGp8Dsp9YgFNLTyARp8emOjlUoC7mcI1R+6q1W/n8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xO6JbMLybBpq9GijuBupSiMJ2G6iRgLIrFmKozrqb7anpr4u5sdUtUjJGfrim2CpA
         c2K1iHAe84zMMw2sTIg1eI1GkXe/0dbIWMmcpm1hKZHQYxdOnJbJzdwyIwjqq8kQF8
         hTSi175I7WXA/XEXiyh13hh9Hl+ZhgcD3QJFOylU=
Date:   Sun, 14 Jul 2019 17:17:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: ABI: iio: Add missing newline at end
 of file
Message-ID: <20190714171758.066a3d78@archlinux>
In-Reply-To: <20190701135631.23376-1-geert+renesas@glider.be>
References: <20190701135631.23376-1-geert+renesas@glider.be>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  1 Jul 2019 15:56:31 +0200
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> "git diff" says:
> 
>     \ No newline at end of file
> 
> after modifying the files.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Applied.

Thanks,

Jonathan

> ---
> v2:
>   - Split patches per maintainer.
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32
> index da9822309f0757bd..0e66ae9b0071e80b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32
> @@ -13,4 +13,4 @@ Description:
>  			error on writing
>  		If DFSDM input is SPI Slave:
>  			Reading returns value previously set.
> -			Writing value before starting conversions.
> \ No newline at end of file
> +			Writing value before starting conversions.

