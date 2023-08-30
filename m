Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6851378DA7B
	for <lists+linux-iio@lfdr.de>; Wed, 30 Aug 2023 20:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbjH3SgY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Aug 2023 14:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343913AbjH3RNR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Aug 2023 13:13:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57223FF
        for <linux-iio@vger.kernel.org>; Wed, 30 Aug 2023 10:13:14 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RbW7D5779z6HJFg;
        Thu, 31 Aug 2023 01:12:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 30 Aug
 2023 18:13:11 +0100
Date:   Wed, 30 Aug 2023 18:13:11 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Nuno Sa <nuno.sa@analog.com>
CC:     <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [RFC PATCH 2/3] iio: adc: ad9647: add based on converter
 framework
Message-ID: <20230830181311.00006387@Huawei.com>
In-Reply-To: <20230804145342.1600136-3-nuno.sa@analog.com>
References: <20230804145342.1600136-1-nuno.sa@analog.com>
        <20230804145342.1600136-3-nuno.sa@analog.com>
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
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 4 Aug 2023 16:53:40 +0200
Nuno Sa <nuno.sa@analog.com> wrote:

> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

I'm not seeing anything particularly problematic in this specific
driver - though that need for a careful out of order call in remove
(to avoid devres ordering) is rather nasty.



