Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723A14E47FD
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 22:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbiCVVCN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 17:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbiCVVCL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 17:02:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE4C4B1EA
        for <linux-iio@vger.kernel.org>; Tue, 22 Mar 2022 14:00:33 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KNP3Y4Jrbz67NyL;
        Wed, 23 Mar 2022 04:58:49 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 22 Mar 2022 22:00:31 +0100
Received: from localhost (10.47.75.191) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Mar
 2022 21:00:30 +0000
Date:   Tue, 22 Mar 2022 21:00:29 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Marek Vasut <marex@denx.de>, linux-iio <linux-iio@vger.kernel.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v3 08/10] iio: adc: ti-ads1015: Convert to OF match data
Message-ID: <20220322210029.00000a4c@Huawei.com>
In-Reply-To: <CAHp75VerZC8CdT9uzEierPMtkaoMSE7KWAXfoOwFuEj5Ks=c-w@mail.gmail.com>
References: <20220320181428.168109-1-marex@denx.de>
        <20220320181428.168109-8-marex@denx.de>
        <CAHp75VerZC8CdT9uzEierPMtkaoMSE7KWAXfoOwFuEj5Ks=c-w@mail.gmail.com>
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

On Mon, 21 Mar 2022 11:24:12 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Mar 20, 2022 at 8:14 PM Marek Vasut <marex@denx.de> wrote:
> >
> > Replace chip type enumeration in match data with pointer to static constant
> > structure which contain all the different chip properties in one place, and  
> 
> contains
> 
> > then replace handling of chip type in probe() with simple copy of fields in
> > the new match data structure into struct iio_dev.
> >
> > This reduces code and increases static data.  
> 
> I like this change! My comments below.
Nice work indeed. Nothing else from me on this one.

I like the fact you also got rid of some odd casting away of const
whilst you were doing this.

Jonathan

> 
> ...
> 
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>  
> 
> If you use mine @kernel.org address it will be enough and reduces a
> lot of noise in the commit messages.
> 
> > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> ...
> 
> > +       chip = (const struct ads1015_chip_data *)
> > +               device_get_match_data(&client->dev);  
> 
> Redundant casting. After dropping it it will become one line.
> 
> > +       if (!chip)
> > +               chip = (const struct ads1015_chip_data *)id->driver_data;  
> 
> > +       if (!chip) {
> > +               dev_err(&client->dev, "Unknown chip\n");
> > +               return -EINVAL;  
> 
> return dev_err_probe(...);
> 
> > +       }  
> 

