Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AB23A197E
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 17:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhFIP3m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 11:29:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236624AbhFIP3O (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Jun 2021 11:29:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46EB5611CC;
        Wed,  9 Jun 2021 15:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623252439;
        bh=clxkHF6kkOJoZHlUu2yGVUDzOEmir1oEZ8MFRfQM54o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qQbgcQgz85VZYWH+fyLlpvldBtJsHbMPhweNRU0cK9+pwhWyuB5Dwmm3vd8O3VfW5
         bsAyPqnJGBRrhbIlYNZ+YbY1vdH61PE6Qi7sMvWlcIYHaH5prBj/nukjmYNGPtckfa
         P1DsqsPG0feGdQS4eX1J99o77cmoQQ6VoOOfrHr+UDEyiLe1RzDLb3tP6iIx9vJVLo
         zAxWjeIVV4SBWp8SRER2Dittxoc1sDIrzq3oJWsrzkgBb2yhOCJSqEomPTGvgOT6eH
         GvK8Y+jou1Bs6HTVQQuwvWxTDS6Qklg0xK5O7uu1gKp6dQ2LoPoAlMJR8HNDlKbL++
         fsfns7krZ+b/A==
Date:   Wed, 9 Jun 2021 08:27:19 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 1/4] iio: si1133: fix format string warnings
Message-ID: <YMDd16PAr16BvS7J@Ryzen-9-3900X>
References: <20210603180612.3635250-1-jic23@kernel.org>
 <20210603180612.3635250-2-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603180612.3635250-2-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 03, 2021 at 07:06:09PM +0100, Jonathan Cameron wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang complains about multiple instances of printing an integer
> using the %hhx format string:
> 
> drivers/iio/light/si1133.c:982:4: error: format specifies type 'unsigned char' but the argument has type 'unsigned int' [-Werror,-Wformat]
>                  part_id, rev_id, mfr_id);
>                  ^~~~~~~
> 
> Print them as a normal integer instead, leaving the "#02"
> length modifier.
> 
> Use the 0x02x form as the length specifier when used with # includes
> the 0x prefix and is very unlikely to be what was intended by the author.
> 
> Fixes: e01e7eaf37d8 ("iio: light: introduce si1133")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/iio/light/si1133.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
> index c280b4195003..0accea7090ee 100644
> --- a/drivers/iio/light/si1133.c
> +++ b/drivers/iio/light/si1133.c
> @@ -978,11 +978,11 @@ static int si1133_validate_ids(struct iio_dev *iio_dev)
>  		return err;
>  
>  	dev_info(&iio_dev->dev,
> -		 "Device ID part %#02hhx rev %#02hhx mfr %#02hhx\n",
> +		 "Device ID part 0x%02x rev 0x%02x mfr 0x%02x\n",
>  		 part_id, rev_id, mfr_id);
>  	if (part_id != SI1133_PART_ID) {
>  		dev_err(&iio_dev->dev,
> -			"Part ID mismatch got %#02hhx, expected %#02x\n",
> +			"Part ID mismatch got 0x%02x, expected 0x%02x\n",
>  			part_id, SI1133_PART_ID);
>  		return -ENODEV;
>  	}
> -- 
> 2.31.1
