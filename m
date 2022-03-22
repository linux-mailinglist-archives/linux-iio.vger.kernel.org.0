Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96C14E47B9
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 21:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiCVUuP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 16:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiCVUuO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 16:50:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C126E0A2
        for <linux-iio@vger.kernel.org>; Tue, 22 Mar 2022 13:48:46 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KNNpf43KNz67Gvv;
        Wed, 23 Mar 2022 04:47:38 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 22 Mar 2022 21:48:43 +0100
Received: from localhost (10.47.75.191) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Mar
 2022 20:48:43 +0000
Date:   Tue, 22 Mar 2022 20:48:41 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Marek Vasut <marex@denx.de>, linux-iio <linux-iio@vger.kernel.org>,
        "Daniel Baluta" <daniel.baluta@nxp.com>
Subject: Re: [PATCH v3 09/10] iio: adc: ti-ads1015: Replace data_rate with
 chip data struct ads1015_data
Message-ID: <20220322204841.00000590@Huawei.com>
In-Reply-To: <YjilGMLt/Z0Kiz89@smile.fi.intel.com>
References: <20220320181428.168109-1-marex@denx.de>
        <20220320181428.168109-9-marex@denx.de>
        <CAHp75VczHX=0yZLjDyLdVjLW6ZRz4-ipJN0VERVj0qhp8CEWFQ@mail.gmail.com>
        <cd805097-b670-95dd-4298-72880a0e0a6d@denx.de>
        <YjilGMLt/Z0Kiz89@smile.fi.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.75.191]
X-ClientProxiedBy: lhreml742-chm.china.huawei.com (10.201.108.192) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Mar 2022 18:17:28 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Mar 21, 2022 at 03:41:20PM +0100, Marek Vasut wrote:
> > On 3/21/22 10:26, Andy Shevchenko wrote:  
> > > On Sun, Mar 20, 2022 at 8:14 PM Marek Vasut <marex@denx.de> wrote:  
> 
> ...
> 
> > > >                          if (period <= ads1015_comp_queue[i] *
> > > > -                                       USEC_PER_SEC / data->data_rate[dr])
> > > > +                                       USEC_PER_SEC / data_rate[dr])  
> 
> 			if (period <= ads1015_comp_queue[i] * USEC_PER_SEC / data_rate[dr])
> 
> > > I would put these two to one line.  
> > 
> > That'd make the line over 80 chars long, is that OK in iio now ? 
 
Depends on readability.  Where it doesn't hurt such as line breaks in
between functional parameters I prefer we stick to sub 80 chars.

> 
> If not (Jonathan, what's your opinion?), you can do a better splitting
> 
> 			if (period <=
> 			    ads1015_comp_queue[i] * USEC_PER_SEC / data_rate[dr])
> 
> although I think it's worse than putting on one line.
> 

Agreed. This particular case is more readable on one line.


Thanks,

Jonathan


