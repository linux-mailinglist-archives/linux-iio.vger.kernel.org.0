Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE73506979
	for <lists+linux-iio@lfdr.de>; Tue, 19 Apr 2022 13:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbiDSLPb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Apr 2022 07:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiDSLPa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Apr 2022 07:15:30 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448952B1B2
        for <linux-iio@vger.kernel.org>; Tue, 19 Apr 2022 04:12:48 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KjLgf1kKdz67msV;
        Tue, 19 Apr 2022 19:10:22 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 13:12:45 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Apr
 2022 12:12:45 +0100
Date:   Tue, 19 Apr 2022 12:12:41 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <catalin.marinas@arm.com>
Subject: IIO: Ensuring DMA safe buffers.
Message-ID: <20220419121241.00002e42@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

For a long time IIO has been making assumption that ____cacheline_aligned
was sufficient to ensure buffers were in their own cacheline and hence
DMA safe.  We generally needed this for all SPI device drivers as many
SPI ABI calls can pass the buffer directly through to be used for DMA.
Not that regmap doesn't currently do this but it might in future (and did
in the past).  I can't remember the history of this well enough to know
why we did it that way. I don't remember the pain of debugging random
corruption caused by getting it wrong however...

However it turns out via
https://lore.kernel.org/all/20220405135758.774016-1-catalin.marinas@arm.com/ 
"[PATCH 00/10] mm, arm64: Reduce ARCH_KMALLOC_MINALIGN below the cache line size"
discussion that there are platforms where this isn't true and need
128 byte alignment despite a ____cacheline_size aligning to 64 bytes on
all ARM64 platforms.

(I should probably have known that as the platform I support in my day
job has 128 byte cachelines in L3 - however it's DMA coherent so
that's not a problem).

The above series also highlights that we can do much better anyway on some platforms
using the new ARCH_DMA_MINALIGN (currently it's only defined for some archs but
after that patch everyone gets it).  We should be safe to use that everywhere
we currently force ___cachline_aligned and waste a little less space on padding
which is always nice ;)

Given we have no reports of a problem with 128 byte non DMA coherent platforms
I don't propose to 'fix' this until we can make use of the new define
in the above patch set.  That is going to make a mess of backporting the
fix however.  I'm wishing we did what crypto has done and had a subsystem
specific define for this but such is life.  We will also want to be careful
that we cover the rather odd sounding case of ARCH_DMA_MINALIGN < 8 given
there are a few drivers that rely on >= 8 to ensure we can do aligned puts
of 64 bit timestamps.

I'm definitely open to opinions on how we handle this and wanted people to
have this on their radar.

+CC Catalin for info.  If you can sneak the first patch in your series
in for next cycle that would be great even if the rest takes a while longer.

Thanks,

Jonathan

