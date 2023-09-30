Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7A27B42C7
	for <lists+linux-iio@lfdr.de>; Sat, 30 Sep 2023 19:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbjI3Rhu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Sep 2023 13:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbjI3Rhu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Sep 2023 13:37:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7B4E1
        for <linux-iio@vger.kernel.org>; Sat, 30 Sep 2023 10:37:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE56C433C7;
        Sat, 30 Sep 2023 17:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696095468;
        bh=87Os5AjpRpreBECF6nNf1BrBVg9j3bcC07wDhUxMVzQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZxMN89+YGid1aaMTqEhlzTxRUp9bvVVblvbOW1x6JluaknORDiyifdToUyJpthP9U
         mfupgIPYpLmBH4N0mMXFWGpwrJwcKpua7dYx0efo2CWjzWyRrA3FXWnYI8FLdMssC9
         4ty3eEJhRc7400bOpoucXT+AaCa9hIJGDqh7I8lQCtEv+L1nwggPwCGNCQ1sSkKjjm
         sQnbEUvrjyUp2MMWZUvbj3QY7CvkegIIKhVz/8DNo/UNFXxVGoqIsc8KKnwLZ6SdQK
         mA27BcQ8Br1X0ICv5J3EmQU7cOzpnxKDopTz3sIJ4/xn2rzxptlNt1aNnG6DOVTinW
         7dsezNwONcM8g==
Date:   Sat, 30 Sep 2023 18:37:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexander Zangerl <az@breathe-safe.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Tomasz Duszynski <tduszyns@gmail.com>
Subject: Re: [PATCH v1] iio: pressure: ms5611: ms5611_prom_is_valid false
 negative bug
Message-ID: <20230930183748.2f20a00a@jic23-huawei>
In-Reply-To: <2535-1695168070.831792@Ze3y.dhYT.s3fx>
References: <922-1694994740.375607@iEuc.VJY0.oC_q>
        <20230918120513.00002032@Huawei.com>
        <2535-1695168070.831792@Ze3y.dhYT.s3fx>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 Sep 2023 10:01:10 +1000
Alexander Zangerl <az@breathe-safe.com> wrote:

> the ms5611 driver falsely rejects lots of MS5607-02BA03-50 chips
> with "PROM integrity check failed" because it doesn't accept a prom crc
> value of zero as legitimate.
> 
> according to the datasheet for this chip (and the manufacturer's
> application note about the prom crc), none of the possible
> values for the crc are excluded - but the current code
> in ms5611_prom_is_valid() ends with
> 
> return crc_orig != 0x0000 && crc == crc_orig
> 
> i've discussed this with the original author of the driver (tomasz
> duszynski) and he indicated that at that time (2015) he was dealing with
> some faulty chip samples which returned blank data under some
> circumstances and/or followed example code which indicated crc zero
> being bad (i can't find any traces of any such online, however).
> 
> as far as i can tell this exception should not be applied anymore; we've
> got a few hundred custom boards here with this chip where large numbers
> of the prom have a legitimate crc value 0, and do work fine, but which the
> current driver code wrongly rejects.
> 
> Signed-off-by: Alexander Zangerl <az@breathe-safe.com>
> Fixes: c0644160a8b5 ("iio: pressure: add support for MS5611 pressure and temperature sensor")

Applied with some tweaks to the patch description to shorten it
a little whilst keeping all the information.  Also marked for stable inclusion.

Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/ms5611_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
> index 5c7a734ede54..9980c6f3335e 100644
> --- a/drivers/iio/pressure/ms5611_core.c
> +++ b/drivers/iio/pressure/ms5611_core.c
> @@ -79,7 +79,7 @@ static bool ms5611_prom_is_valid(u16 *prom, size_t len)
>  
>  	crc = (crc >> 12) & 0x000F;
>  
> -	return crc_orig != 0x0000 && crc == crc_orig;
> +	return crc == crc_orig;
>  }
>  
>  static int ms5611_read_prom(struct iio_dev *indio_dev)

