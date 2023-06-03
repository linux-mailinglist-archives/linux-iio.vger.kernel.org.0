Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A69720FEB
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jun 2023 13:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjFCLYd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Jun 2023 07:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjFCLYb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Jun 2023 07:24:31 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639D8180
        for <linux-iio@vger.kernel.org>; Sat,  3 Jun 2023 04:24:30 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 33b6a7c0-0201-11ee-b3cf-005056bd6ce9;
        Sat, 03 Jun 2023 14:24:28 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 14:24:28 +0300
To:     inv.git-commit@tdk.com
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org, lars@metafoo.de,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH 0/4] Factorize timestamp module
Message-ID: <ZHsi7KstozyS8deI@surfacebook>
References: <20230531142513.48507-1-inv.git-commit@tdk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531142513.48507-1-inv.git-commit@tdk.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Wed, May 31, 2023 at 02:25:09PM +0000, inv.git-commit@tdk.com kirjoitti:
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> The purpose if this series is to make timestamping from
> inv_icm42600 driver an independent module and use it for both
> inv_icm42600 and inv_mpu6050 drivers.
> 
> Create a new inv_sensors_timestamp common module based on
> inv_icm42600 driver and use it in the 2 drivers.
> 
> WARNING: this patch requires following commit in fixes-togreg
> bbaae0c79ebd ("iio: imu: inv_icm42600: fix timestamp reset")

This is so nicely prepared series, but I have a few style nit-picks
(individually commented) and one to address, i.e. kernel.h inclusion.

With that addressed,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Thank you!

-- 
With Best Regards,
Andy Shevchenko


