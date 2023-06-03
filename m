Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E994720FDD
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jun 2023 13:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbjFCLKK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Jun 2023 07:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjFCLKJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Jun 2023 07:10:09 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AE418C
        for <linux-iio@vger.kernel.org>; Sat,  3 Jun 2023 04:10:08 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id 319ca885-01ff-11ee-a9de-005056bdf889;
        Sat, 03 Jun 2023 14:10:05 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 14:10:05 +0300
To:     inv.git-commit@tdk.com
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org, lars@metafoo.de,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH 1/4] iio: imu: inv_icm42600: make timestamp module chip
 independant
Message-ID: <ZHsfjeRx1DiPEIPh@surfacebook>
References: <20230531142513.48507-1-inv.git-commit@tdk.com>
 <20230531142513.48507-2-inv.git-commit@tdk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531142513.48507-2-inv.git-commit@tdk.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Wed, May 31, 2023 at 02:25:10PM +0000, inv.git-commit@tdk.com kirjoitti:
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Move icm42600 dependent function inside the core module.

...

>  #include <linux/kernel.h>
> -#include <linux/regmap.h>
>  #include <linux/math64.h>
> +#include <linux/errno.h>

Can this be more ordered?


-- 
With Best Regards,
Andy Shevchenko


