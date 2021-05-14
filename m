Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E98380F31
	for <lists+linux-iio@lfdr.de>; Fri, 14 May 2021 19:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbhENRqQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 May 2021 13:46:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbhENRqP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 May 2021 13:46:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B734613D6;
        Fri, 14 May 2021 17:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621014303;
        bh=OdG7QFpYNaI0q2QXmh6Rq7lI2lHh8xRpNEIu72tie+A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Y+L4WCeH9e3iYuEe03OmsdcZMWofID21dvsomCcqmfpXWSPJwTHGL60AqXFNk4IHX
         ZY0IrTm2pF5Gjt+fwNEhq2n9VKGeHvOuL1TJlRDmPMxAdkTam36WN4QBwbnXWsK+oD
         /BKSIQQ2IjZcW4eomdRLN/xivhCss3pffzQ5/X7jjiKHwJ3Uhs5GEC5ouLz0rzBfSk
         JgkQJbAfhBbxvC8IvMtGS8vTNWIgaa0yrrkepvuE7M9eTwxyl6KN3q8YEYtpCsFvL8
         HjQtj7JzC6bkV2365zLC9AVjMI+wKXTxtLL089qhPT1q7d/nqlWhvgsMSMCKzEJavw
         g7qYVKm+p/+Yw==
Subject: Re: [PATCH] iio: si1133: fix format string warnings
To:     Arnd Bergmann <arnd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        =?UTF-8?Q?Maxime_Roussin-B=c3=a9langer?= 
        <maxime.roussinbelanger@gmail.com>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20210514135927.2926482-1-arnd@kernel.org>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <7afc367b-8103-9d48-1bfe-d505d86553b9@kernel.org>
Date:   Fri, 14 May 2021 10:45:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210514135927.2926482-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/14/2021 6:59 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang complains about multiple instances of printing an integer
> using the %hhx format string:
> 
> drivers/iio/light/si1133.c:982:4: error: format specifies type 'unsigned char' but the argument has type 'unsigned int' [-Werror,-Wformat]
>                   part_id, rev_id, mfr_id);
>                   ^~~~~~~
> 
> Print them as a normal integer instead, leaving the "#02"
> length modifier.
> 
> Fixes: e01e7eaf37d8 ("iio: light: introduce si1133")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Indeed, use of %hx and %hhx have been discouraged since commit 
cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of unnecessary 
%h[xudi] and %hh[xudi]").

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>   drivers/iio/light/si1133.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
> index c280b4195003..fd302480262b 100644
> --- a/drivers/iio/light/si1133.c
> +++ b/drivers/iio/light/si1133.c
> @@ -978,11 +978,11 @@ static int si1133_validate_ids(struct iio_dev *iio_dev)
>   		return err;
>   
>   	dev_info(&iio_dev->dev,
> -		 "Device ID part %#02hhx rev %#02hhx mfr %#02hhx\n",
> +		 "Device ID part %#02x rev %#02x mfr %#02x\n",
>   		 part_id, rev_id, mfr_id);
>   	if (part_id != SI1133_PART_ID) {
>   		dev_err(&iio_dev->dev,
> -			"Part ID mismatch got %#02hhx, expected %#02x\n",
> +			"Part ID mismatch got %#02x, expected %#02x\n",
>   			part_id, SI1133_PART_ID);
>   		return -ENODEV;
>   	}
> 

