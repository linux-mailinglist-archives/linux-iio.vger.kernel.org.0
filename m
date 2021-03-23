Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2403455EA
	for <lists+linux-iio@lfdr.de>; Tue, 23 Mar 2021 04:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhCWDDo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 23:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhCWDDN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Mar 2021 23:03:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641DEC061574;
        Mon, 22 Mar 2021 20:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=D46a6Gu22Mzwxew4OtdaKhUgC9+HWAPdUHQy1AlshxM=; b=JLAT7/GTevLzhmvJ1FxgRc9NVX
        wZ/YZesEcYPf82EIzpOnlxsZW8D67lMGlpRKEOQc822MMss0Qvqv4uMig2iTuLIduQqbVNG4R5EAU
        gxBEa/A68iFtTf9dig3FS4NSCEvJtWN0I0lSvEEMDiMvQLsPFzf6cjNvSOJuHs6U2ImoiO9Lawonv
        fqIxKoBXr3i29FqSI5YRKIf6NQm8Ggc+J0QPjMD6C433QQ/edZRNW3LVcgGfJi08t2M92xv9ibo2s
        4AAFK6SPoLFx/PiQbojEk12bK27S2LtNC70UR/u8YieQW4i3fENlCVPGQDKuZTCUwY7tJY9BO6dGa
        Csp1bDcA==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOXJJ-009RYN-IB; Tue, 23 Mar 2021 03:02:39 +0000
Subject: Re: [PATCH] iio: dac: Rudimentary typo fix
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210323012215.451075-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cec8e5bf-b7be-041e-e0ea-50a41f55d79f@infradead.org>
Date:   Mon, 22 Mar 2021 20:02:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210323012215.451075-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/22/21 6:22 PM, Bhaskar Chowdhury wrote:
> 
> s/concurent/concurrent/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/iio/dac/ad5766.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5766.c b/drivers/iio/dac/ad5766.c
> index ef1618ea6a20..79837a4b3a41 100644
> --- a/drivers/iio/dac/ad5766.c
> +++ b/drivers/iio/dac/ad5766.c
> @@ -89,7 +89,7 @@ static const char * const ad5766_dither_scales[] = {
>  /**
>   * struct ad5766_state - driver instance specific data
>   * @spi:		SPI device
> - * @lock:		Lock used to restrict concurent access to SPI device
> + * @lock:		Lock used to restrict concurrent access to SPI device
>   * @chip_info:		Chip model specific constants
>   * @gpio_reset:		Reset GPIO, used to reset the device
>   * @crt_range:		Current selected output range
> --


-- 
~Randy

