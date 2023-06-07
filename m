Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8C672541D
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jun 2023 08:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbjFGG0h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Jun 2023 02:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbjFGG0e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Jun 2023 02:26:34 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6ED1721
        for <linux-iio@vger.kernel.org>; Tue,  6 Jun 2023 23:26:33 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id 3c2bfcbb-04fc-11ee-a9de-005056bdf889;
        Wed, 07 Jun 2023 09:26:28 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Wed, 7 Jun 2023 09:26:28 +0300
To:     inv.git-commit@tdk.com
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org, lars@metafoo.de,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH v2 0/4] Factorize timestamp module
Message-ID: <ZIAjFMhJbnndgL-G@surfacebook>
References: <20230606162147.79667-1-inv.git-commit@tdk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606162147.79667-1-inv.git-commit@tdk.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Tue, Jun 06, 2023 at 04:21:43PM +0000, inv.git-commit@tdk.com kirjoitti:
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

> Changelog
> - v2: do some headers cleanup and add some justifications in
>       the patches descriptions.

What I haven't noticed is my tag. It's your responsibility to add given tag and
it's polite to Cc to the reviewers (but this will imply by the tag anyway in
this case).

Any explanation why did you do so?

-- 
With Best Regards,
Andy Shevchenko


