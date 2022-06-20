Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE25552272
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jun 2022 18:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239979AbiFTQml (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jun 2022 12:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238812AbiFTQmk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2022 12:42:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADFADFC2
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 09:42:40 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LRb202fbbz67MmR;
        Tue, 21 Jun 2022 00:38:48 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 20 Jun 2022 18:42:38 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 20 Jun
 2022 17:42:37 +0100
Date:   Mon, 20 Jun 2022 17:42:36 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        "Michael Hennerich" <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH v2 05/17] staging: iio: cdc: ad7746: Use local buffer
 for multi byte reads.
Message-ID: <20220620174236.00002543@Huawei.com>
In-Reply-To: <CAHp75Vfp3rzi_NPHZ76CDC43X3Mpm=vthBw6Og9Ya=OjCEeAHQ@mail.gmail.com>
References: <20220619185839.1363503-1-jic23@kernel.org>
        <20220619185839.1363503-6-jic23@kernel.org>
        <CAHp75Vfp3rzi_NPHZ76CDC43X3Mpm=vthBw6Og9Ya=OjCEeAHQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Jun 2022 01:00:23 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Jun 19, 2022 at 8:59 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > I2C does not require DMA safe buffers so there is no need to ensure
> > the buffers are in their own cacheline. Hence simplify things by
> > using a local variable instead of embedding the buffer in the chip
> > info structure.  
> 
> ...
> 
> >                                                     sizeof(chip->data),
> >                                                     chip->data);  
> 
> How will these compile? Or am I missing something?

Nope.  Something went wrong in the rebase. I should have rechecked
build patch by patch.  Later on, this code is factored out, so I guess
that fixed up the build issue.

Will check properly for v3. :(


> 
> > -
> >                 if (ret < 0)
> >                         goto out;
> >
> > -               *val = get_unaligned_be24(chip->data) - 0x800000;
> > +               *val = get_unaligned_be24(data) - 0x800000;  
> 

