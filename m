Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79FA4E47C3
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 21:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiCVUwG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 16:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbiCVUwG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 16:52:06 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC212DE1
        for <linux-iio@vger.kernel.org>; Tue, 22 Mar 2022 13:50:38 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KNNr63jzgz67x0l;
        Wed, 23 Mar 2022 04:48:54 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 22 Mar 2022 21:50:36 +0100
Received: from localhost (10.47.75.191) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Mar
 2022 20:50:35 +0000
Date:   Tue, 22 Mar 2022 20:50:33 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Marek Vasut <marex@denx.de>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v3 10/10] iio: adc: ti-ads1015: Switch to read_avail
Message-ID: <20220322205033.00000c38@Huawei.com>
In-Reply-To: <b7dc075f-8e5c-6659-a7d3-d5cc563ad027@denx.de>
References: <20220320181428.168109-1-marex@denx.de>
        <20220320181428.168109-10-marex@denx.de>
        <CAHp75Vekt0aOcKMfXDhZJaC80DoqTZH30pMj6qFDhgG-guSdcg@mail.gmail.com>
        <8c5772a7-6939-ac33-7b10-acded2b7b9ac@denx.de>
        <YjildQUsDyehNHqs@smile.fi.intel.com>
        <b7dc075f-8e5c-6659-a7d3-d5cc563ad027@denx.de>
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

On Mon, 21 Mar 2022 20:46:04 +0100
Marek Vasut <marex@denx.de> wrote:

> On 3/21/22 17:19, Andy Shevchenko wrote:
> > On Mon, Mar 21, 2022 at 03:44:24PM +0100, Marek Vasut wrote:  
> >> On 3/21/22 10:27, Andy Shevchenko wrote:  
> >>> On Sun, Mar 20, 2022 at 8:14 PM Marek Vasut <marex@denx.de> wrote:  
> > 
> > ...
> >   
> >>>> +static const int ads1015_fullscale_range[] = {
> >>>>           6144, 4096, 2048, 1024, 512, 256, 256, 256  
> >>>
> >>> Keep a comma at the end.
> >>> Also applies to the rest of the modified data structures below.  
> >>
> >> Why ? We don't expect these arrays to grow new values, if there is ever some
> >> new ADC, it will likely have its own array.  
> > 
> > Just for the sake of a common style. But it's not critical,
> > so I leave it to the maintainers.  
> 
> The common style of the other arrays in that driver is without a 
> trailing comma, hence the way it is right now is the common style.
> 
> I do however understand the rationale why a trailing comma in structures 
> makes sense (you don't have to add it in some subsequent patch, which 
> does only cause churn and unrelated line changes), but I don't think 
> that applies in this particular case.

Agreed. I tend to let this go with local style in a driver for
these cases and generally let either go in new drivers as long
as they are consistent.

Jonathan
