Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F2D7A47CC
	for <lists+linux-iio@lfdr.de>; Mon, 18 Sep 2023 13:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjIRLFv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Sep 2023 07:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjIRLFY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Sep 2023 07:05:24 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B818F94
        for <linux-iio@vger.kernel.org>; Mon, 18 Sep 2023 04:05:16 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rq22s72fHz6HJnF;
        Mon, 18 Sep 2023 19:03:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 18 Sep
 2023 12:05:14 +0100
Date:   Mon, 18 Sep 2023 12:05:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexander Zangerl <az@breathe-safe.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, Tomasz Duszynski <tduszyns@gmail.com>
Subject: Re: iio: pressure: ms5611: ms5611_prom_is_valid false negative bug
 [PATCH]
Message-ID: <20230918120513.00002032@Huawei.com>
In-Reply-To: <922-1694994740.375607@iEuc.VJY0.oC_q>
References: <922-1694994740.375607@iEuc.VJY0.oC_q>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 Sep 2023 09:52:20 +1000
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
> datasheet: https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=MS5607-02BA03&DocType=Data+Sheet&DocLang=English
> application note: https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=AN520_C-code_example_for_MS56xx&DocType=SS&DocLang=EN
> 
> i've discussed this whith the original author of the driver (tomasz
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
> (i can provide some example prom dumps if required.)
> 
> the attached tiny patch is against 4.19. but that
> section of the code is unchanged up to and including 6.6. 
> 
> 

> From 653b5cf063e07d126e67386b152e4e76d4f8c1dc Mon Sep 17 00:00:00 2001
> From: Alexander Zangerl <az@breathe-safe.com>
> Date: Mon, 18 Sep 2023 09:44:00 +1000
> Subject: [PATCH] ms5611: crc zero is valid and should not be rejected

Please resend with this formatting as a patch, so the above should be in a cover
letter with this sent in reply to that.  git format-patch --cover-letter 
will set it it up right.

Needs a
Signed-off-by and Fixes tag as well before I can take this.

Otherwise, description all makes sense so good to get this fix in place.

Jonathan

> 
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
> -- 
> 2.30.2
> 
> 
> 
> Best Regards,
> Alexander Zangerl
> IT Engineer
> 
> -- 
> P +61 7 3276 7833 | M +61 415 482 341
> E az@breathe-safe.com | W breathe-safe.com.au
> A 62 Mica Street, Carole Park, 4300, QLD
