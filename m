Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 814084F569
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 12:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfFVKxD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 06:53:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbfFVKxC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 06:53:02 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE8552070B;
        Sat, 22 Jun 2019 10:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561200781;
        bh=XsbuTsWAoPCkGtHDg3vcdixFu29Z85KfcwCZsLv7mjk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EPAoZkeC+6QAR2EdwogfOoGFFEZE+gmxui1DPjGHrEGbnyTkDXCNB4JV4jkWgM7RU
         4ZRclW5kES0zbpu/D1sqdT/fWDk5RHUnknTH/1sQO9YErbxx61w6Vof8f60uNhjh3i
         sV3+9PRA+EAyyxE/3X1tQMsfJUVFX5BsGKVDkzeo=
Date:   Sat, 22 Jun 2019 11:52:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: ABI: Add missing newline at end of file
Message-ID: <20190622115257.7198f8d4@archlinux>
In-Reply-To: <20190617143057.4096-1-geert+renesas@glider.be>
References: <20190617143057.4096-1-geert+renesas@glider.be>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Jun 2019 16:30:57 +0200
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> "git diff" says:
> 
>     \ No newline at end of file
> 
> after modifying the files.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32 | 2 +-
>  Documentation/ABI/testing/sysfs-power                   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
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
> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
> index 18b7dc929234f625..3c51303550118474 100644
> --- a/Documentation/ABI/testing/sysfs-power
> +++ b/Documentation/ABI/testing/sysfs-power
> @@ -300,4 +300,4 @@ Description:
>  		attempt.
>  
>  		Using this sysfs file will override any values that were
> -		set using the kernel command line for disk offset.
> \ No newline at end of file
> +		set using the kernel command line for disk offset.

