Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB6E58CA3B
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 16:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243257AbiHHOOi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 10:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiHHOO3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 10:14:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A64FD0A
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 07:14:28 -0700 (PDT)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M1dVn2Wkbz682vm;
        Mon,  8 Aug 2022 22:14:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 8 Aug 2022 16:14:26 +0200
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 8 Aug
 2022 15:14:25 +0100
Date:   Mon, 8 Aug 2022 15:14:24 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH 1/4] staging: iio: frequency: ad9832: Fix alignment for
 DMA safety
Message-ID: <20220808151424.000070dc@huawei.com>
In-Reply-To: <CAHp75Vd34hOAMpeCwcYjnuVWUSN7WuGGwc1qiKqNp+xpmsEXkg@mail.gmail.com>
References: <20220807151218.656881-1-jic23@kernel.org>
        <20220807151218.656881-2-jic23@kernel.org>
        <CAHp75Vd34hOAMpeCwcYjnuVWUSN7WuGGwc1qiKqNp+xpmsEXkg@mail.gmail.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 8 Aug 2022 11:18:34 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Aug 7, 2022 at 5:26 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > ____cacheline_aligned is an insufficient guarantee for non-coherent DMA
> > on platforms with 128 byte cachelines above L1.  Switch to the updated
> > IIO_DMA_MINALIGN definition.  
> 
> ...
> 
> >         union {
> > -               __be16                  freq_data[4]____cacheline_aligned;
> > +               __be16                  freq_data[4] __aligned(IIO_DMA_MINALIGN);
> >                 __be16                  phase_data[2];
> >                 __be16                  data;
> >         };  
> 
> Hmm... Can we rather mark the entire union with it?
> 

ah. I'd not even registered it was a union ;)  Anyhow, yes, that would make
sense.
