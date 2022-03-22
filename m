Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25054E4799
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 21:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiCVUf6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 22 Mar 2022 16:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiCVUf6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 16:35:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66492559E;
        Tue, 22 Mar 2022 13:34:30 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KNNTV6Nh1z67NyL;
        Wed, 23 Mar 2022 04:32:46 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 22 Mar 2022 21:34:28 +0100
Received: from localhost (10.47.75.191) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Mar
 2022 20:34:27 +0000
Date:   Tue, 22 Mar 2022 20:34:26 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Michal Simek" <michal.simek@xilinx.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "Michael Hennerich" <Michael.Hennerich@analog.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Russell King <linux@armlinux.org.uk>,
        =?ISO-8859-1?Q?Andr=E9?= Gustavo Nakagomi Lopez 
        <andregnl@usp.br>, "Vladimir Zapolskiy" <vz@mleia.com>,
        Paul Cercueil <paul@crapouillou.net>,
        <linux-iio@vger.kernel.org>, Cai Huoqing <caihuoqing@baidu.com>,
        <kernel@pengutronix.de>, Nuno Sa <nuno.sa@analog.com>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 04/16] iio: Make use of devm_clk_get_enabled()
Message-ID: <20220322203426.00002532@Huawei.com>
In-Reply-To: <20220321074154.rktt7e54q774puwj@pengutronix.de>
References: <20220314141643.22184-1-u.kleine-koenig@pengutronix.de>
        <20220314141643.22184-5-u.kleine-koenig@pengutronix.de>
        <20220319182240.30456776@jic23-huawei>
        <20220321074154.rktt7e54q774puwj@pengutronix.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
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

On Mon, 21 Mar 2022 08:41:54 +0100
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> Hello,
> 
> On Sat, Mar 19, 2022 at 06:22:40PM +0000, Jonathan Cameron wrote:
> > On Mon, 14 Mar 2022 15:16:31 +0100
> > Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
> >   
> > > Several drivers manually register a devm handler to disable their clk.
> > > Convert them to devm_clk_get_enabled().
> > > 
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>  
> > 
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > If this does get picked up, can who ever does it please provide
> > an immutable branch. With some many drivers cleaned up, it's very
> > likely to cause some merge fun somewhere otherwise.  
> 
> That would be good, indeed. If only the first two patches go in via clk
> tree, it would however also be OK for me if the other patches go in only
> after the clk changes are in an -rc1. I can care about rebasing if need
> be.

That works to, but so slow!!! :)

Jonathan

> 
> Best regards
> Uwe
> 

