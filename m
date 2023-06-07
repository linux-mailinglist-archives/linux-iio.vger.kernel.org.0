Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353BD72638A
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jun 2023 16:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbjFGO7D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 7 Jun 2023 10:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237503AbjFGO7B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Jun 2023 10:59:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71601702
        for <linux-iio@vger.kernel.org>; Wed,  7 Jun 2023 07:58:59 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qbr7x2wSHz6J84V;
        Wed,  7 Jun 2023 22:58:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 7 Jun
 2023 15:58:57 +0100
Date:   Wed, 7 Jun 2023 15:58:56 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
CC:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        INV Git Commit <INV.git-commit@tdk.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v2 0/4] Factorize timestamp module
Message-ID: <20230607155856.00006db3@Huawei.com>
In-Reply-To: <FR3P281MB17572FE25C24840A4030315ACE53A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20230606162147.79667-1-inv.git-commit@tdk.com>
        <ZIAjFMhJbnndgL-G@surfacebook>
        <FR3P281MB17572FE25C24840A4030315ACE53A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 7 Jun 2023 09:28:12 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello Andy,
> 
> really sorry, I forgot to do that. I'm still not very familiar with all the details of the process, sorry.
> 
> I will send a new v3 with the Reviewed-by tag. Is it OK like this?

Go for it.   Other option is to reply with a whoops: forgot this tag and
include the tag.  That way b4 will pick it up for me when I apply.

Jonathan

> 
> Thanks a lot, and sorry again.
> JB
> 
> 
> From: andy.shevchenko@gmail.com <andy.shevchenko@gmail.com>
> Sent: Wednesday, June 7, 2023 08:26
> To: INV Git Commit <INV.git-commit@tdk.com>
> Cc: jic23@kernel.org <jic23@kernel.org>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; lars@metafoo.de <lars@metafoo.de>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> Subject: Re: [PATCH v2 0/4] Factorize timestamp module 
>  
> [CAUTION] This is an EXTERNAL email. Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> ======================================================================
> Tue, Jun 06, 2023 at 04:21:43PM +0000, inv.git-commit@tdk.com kirjoitti:
> > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> > 
> > The purpose if this series is to make timestamping from
> > inv_icm42600 driver an independent module and use it for both
> > inv_icm42600 and inv_mpu6050 drivers.
> > 
> > Create a new inv_sensors_timestamp common module based on
> > inv_icm42600 driver and use it in the 2 drivers.
> > 
> > WARNING: this patch requires following commit in fixes-togreg
> > bbaae0c79ebd ("iio: imu: inv_icm42600: fix timestamp reset")  
> 
> > Changelog
> > - v2: do some headers cleanup and add some justifications in
> >       the patches descriptions.  
> 
> What I haven't noticed is my tag. It's your responsibility to add given tag and
> it's polite to Cc to the reviewers (but this will imply by the tag anyway in
> this case).
> 
> Any explanation why did you do so?
> 

