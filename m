Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2872689EBD
	for <lists+linux-iio@lfdr.de>; Fri,  3 Feb 2023 17:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjBCQBg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Feb 2023 11:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjBCQBf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Feb 2023 11:01:35 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752973C295
        for <linux-iio@vger.kernel.org>; Fri,  3 Feb 2023 08:01:34 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P7gKN2Yhxz6J6Y6;
        Fri,  3 Feb 2023 23:57:44 +0800 (CST)
Received: from localhost (10.45.151.122) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 16:01:31 +0000
Date:   Fri, 3 Feb 2023 16:01:30 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Philippe De Muyter <phdm@macq.eu>
CC:     <linux-iio@vger.kernel.org>
Subject: Re: iio dac drivers : imposing upper limit on value.
Message-ID: <20230203160130.00002ea6@Huawei.com>
In-Reply-To: <20230203141211.GA28086@frolo.macqel>
References: <20230203141211.GA28086@frolo.macqel>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.151.122]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 3 Feb 2023 15:12:12 +0100
Philippe De Muyter <phdm@macq.eu> wrote:

> Hello,
> 
> the board I work with incorporates two DAC's, but the hardware men
> told me that I may not use the full range of the values allowed by
> the DAC component in order to save the lifetime of the chips (LEDs)
> that are feeded by the DAC.  My specific case is that the DAC has
> a 2.5V Vref, but the output accepts maximum 1.24V.
> 
> I would like to describe that limit in the DT and enforce it in the driver.
> Is there an agreed upon property for that, and a sysfs value to show it to
> the user ?

We've done this for multi range DACs in the past, and the
same binding should work.

So far it's been a vendor specific binding though.  
We could generalize that but I'm not overly keen on it because
there might be an expectation that it will port to drivers that
don't enable it...  If there is general feeling this is sensible
I might change my mind tough.

I'd moan at your board
designer about putting a protective diode or resistor network
in there to deal with an out of range value from unaware software.

Jonathan

> 
> Best regards
> 
> Philippe
> 

