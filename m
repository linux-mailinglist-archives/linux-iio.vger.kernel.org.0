Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9BD72A0DC
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jun 2023 19:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjFIRIK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jun 2023 13:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFIRIJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Jun 2023 13:08:09 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8471FFE
        for <linux-iio@vger.kernel.org>; Fri,  9 Jun 2023 10:08:08 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qd6sh0Sd7z67LMV
        for <linux-iio@vger.kernel.org>; Sat, 10 Jun 2023 01:05:44 +0800 (CST)
Received: from localhost (10.126.170.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 9 Jun
 2023 18:08:05 +0100
Date:   Fri, 9 Jun 2023 18:08:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <linux-iio@vger.kernel.org>
Subject: IIO related heads up - on ARM64 you are likely to see DMA buffers
 being bounced soon...
Message-ID: <20230609180802.0000254b@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.170.42]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

Catalin's work to reduce the size of minimum allocation sizes
from kmalloc on ARM64 relies on a heuristic where small
buffers are always bounced to ensure DMA safety.

https://lore.kernel.org/all/20230531154836.1366225-1-catalin.marinas@arm.com/

Now this shouldn't break any IIO drivers but it might (at least in theory)
have a performance impact.

I'm curious on whether anyone cares enough about this?

Long term, if this approach ends up adopted on all architectures that
currently have ARCH_KMALLOC_MINALIGN set above 8 bytes we can get rid
of the explicit handling of DMA buffers in IIO as they will mostly be
bounced anyway - with the exception of a few that are bigger than the
relevant cacheline size.

Jonathan
