Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03EC7917DA
	for <lists+linux-iio@lfdr.de>; Mon,  4 Sep 2023 15:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352354AbjIDNM6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Sep 2023 09:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239603AbjIDNM5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Sep 2023 09:12:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB69B6
        for <linux-iio@vger.kernel.org>; Mon,  4 Sep 2023 06:12:54 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RfTTk1YSwz6J80k;
        Mon,  4 Sep 2023 21:08:26 +0800 (CST)
Received: from localhost (10.48.153.57) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 4 Sep
 2023 14:12:52 +0100
Date:   Mon, 4 Sep 2023 14:12:51 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Tomas Melin <tomas.melin@vaisala.com>, <linux-iio@vger.kernel.org>,
        <jic23@kernel.org>, <lars@metafoo.de>,
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] iio: adc: ti-ads1015: support deferred probe
Message-ID: <20230904141251.00002b7d@Huawei.com>
In-Reply-To: <ZPW+MXuBSYEE1GfF@smile.fi.intel.com>
References: <20230904101533.455896-1-tomas.melin@vaisala.com>
        <ZPW+MXuBSYEE1GfF@smile.fi.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.153.57]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 4 Sep 2023 14:23:29 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Sep 04, 2023 at 01:15:22PM +0300, Tomas Melin wrote:
> > Support deferred probe for cases where communication on
> > i2c bus fails. These failures could happen for a variety of
> > reasons including bus arbitration error or power failure.  
> 
> > +out:
> > +	if ((ret == -EAGAIN) || (ret == -ENXIO))
> > +		return -EPROBE_DEFER;
> > +	return ret;  
> 
> Oh my... This looks so-o hackish.

Agreed.  This is a non starter.

> If anything, it has to be fixed on the level of regmap I2C APIs or so.
> 
> Maybe something like regmap_i2c_try_write()/try_read() new APIs that
> will provide the above. Otherwise you want to fix _every single driver_
> in the Linux kernel

Any probe ordering dependencies should be described by the
firmware and the driver should 'get' the relevant resource.
If there is anything not describable today then that is what we need
to fix, not paper over the holes.

So can we have specifics of what is happening here?

If it's arbitration with some other entity then fix the arbitration
locking / hand over. If it's power, then make sure the relevant
regulator get gotten and turned on + has the right delays etc.

Jonathan

> 
> ...
> 
> $ git grep -lw builtin_i2c_driver | wc
>       5       5     123
> $ git grep -lw module_i2c_driver | wc
>       1164    1164   35240
> 
> (and more that don't use either of the above macros).
> 

