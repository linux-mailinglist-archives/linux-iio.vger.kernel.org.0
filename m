Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E03C723F79
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jun 2023 12:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbjFFKaf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Jun 2023 06:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbjFFKaU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jun 2023 06:30:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE87B10C6
        for <linux-iio@vger.kernel.org>; Tue,  6 Jun 2023 03:30:16 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qb6B54P8mz67hvQ;
        Tue,  6 Jun 2023 18:27:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 11:30:14 +0100
Date:   Tue, 6 Jun 2023 11:30:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     David Schiller <david.schiller@jku.at>
CC:     <linux-iio@vger.kernel.org>
Subject: Re: Questions about ad5933 driver
Message-ID: <20230606113013.00000530@Huawei.com>
In-Reply-To: <3e5653d1aec953e8aba8c00d073cd033a9f7a873.camel@jku.at>
References: <3e5653d1aec953e8aba8c00d073cd033a9f7a873.camel@jku.at>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
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

On Tue, 6 Jun 2023 10:46:14 +0200
David Schiller <david.schiller@jku.at> wrote:

> Hi!
> 
> I attempted to use the ad5933 impedance analyzer driver in combination
> with libiio.
> 
> Trying to enumerate the local devices with "iio_info" leads to an error,
> which I traced down to the naming of the in_voltage_{real,imag}_* sysfs
> scan_elements nodes. The name modifiers "real" and "imag" are not valid
> sysfs symbols, it seems.
> The driver is in the staging directory, so I don't know if it has to
> conform to the general IIO sysfs ABI.

It 'should' but it doesn't which is part of the reason it's still in staging
after all these years.

> 
> I worked around this by patching libiio, but I don't know if that's the
> correct approach.

Ideally clean up the driver.  If you are willing that would be great, if not
would you be able to test changes made by someone else?  You are first person
in years that I know has one! :)  I can't remember how far this driver is
from being ready to move out of staging, but I can probably find some time
to do a thorough review of that in next few weeks.

That may require extra ABI definitions possibly including the real and imag
modifiers at which point your patch to libiio would be correct.

Jonathan

> 
> What do you think?
> 
> Best regards
> David
> 
> 

