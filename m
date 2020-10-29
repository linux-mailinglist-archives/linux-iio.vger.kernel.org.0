Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B063329EF1C
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 16:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgJ2PEu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 11:04:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727026AbgJ2PEu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 29 Oct 2020 11:04:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67A232076E;
        Thu, 29 Oct 2020 15:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603983889;
        bh=44rahyWgFkOpHTCIM7TfgJXqLv1L+vKl1N/fvZo6xT4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fWaSJQXYstjMGZcif5mZVCLZKegbV6Saf+8JvukJJego9uEVeU5SxV/UTlPP11887
         Z/06Z7YpN3aOLj114LdGjvrxamZq3wHG8Fca0rFZ/12xDU1J/v5DjQlyfm7T9O1e7V
         KSh/PJEfsEjL1y4Oe1jfiYJCPnXcNCYM6EHryir8=
Date:   Thu, 29 Oct 2020 15:04:44 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1] iio: gyro: mpu3050: Use get_unaligned_leXX()
Message-ID: <20201029150444.28f4e18d@archlinux>
In-Reply-To: <20201026175340.19570-1-andriy.shevchenko@linux.intel.com>
References: <20201026175340.19570-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 26 Oct 2020 19:53:40 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> This makes the driver code slightly easier to read.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

What you have is good, but could we do better?

Why not use an __le64 to grab the whole thing, convert it to a local
cpu endian u64 then use FIELD_GET or similar to pull out the right bits.
Would be fairly self documenting as well which is always nice.

Or am I missing something?

Jonathan


> ---
>  drivers/iio/gyro/mpu3050-core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index 00e58060968c..42b6ccb13568 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -827,15 +827,15 @@ static int mpu3050_hw_init(struct mpu3050 *mpu3050)
>  		 "die ID: %04X, wafer ID: %02X, A lot ID: %04X, "
>  		 "W lot ID: %03X, WP ID: %01X, rev ID: %02X\n",
>  		 /* Die ID, bits 0-12 */
> -		 (otp[1] << 8 | otp[0]) & 0x1fff,
> +		 get_unaligned_le16(&otp[0]) & GENMASK(12, 0),
>  		 /* Wafer ID, bits 13-17 */
> -		 ((otp[2] << 8 | otp[1]) & 0x03e0) >> 5,
> +		 (get_unaligned_le16(&otp[1]) & GENMASK(9, 5)) >> 5,
>  		 /* A lot ID, bits 18-33 */
> -		 ((otp[4] << 16 | otp[3] << 8 | otp[2]) & 0x3fffc) >> 2,
> +		 (get_unaligned_le24(&otp[2]) & GENMASK(17, 2)) >> 2,
>  		 /* W lot ID, bits 34-45 */
> -		 ((otp[5] << 8 | otp[4]) & 0x3ffc) >> 2,
> +		 (get_unaligned_le16(&otp[4]) & GENMASK(13, 2)) >> 2,
>  		 /* WP ID, bits 47-49 */
> -		 ((otp[6] << 8 | otp[5]) & 0x0380) >> 7,
> +		 (get_unaligned_le16(&otp[5]) & GENMASK(9, 7)) >> 7,
>  		 /* rev ID, bits 50-55 */
>  		 otp[6] >> 2);
>  

