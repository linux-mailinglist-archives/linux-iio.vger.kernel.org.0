Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6F26366B1
	for <lists+linux-iio@lfdr.de>; Wed, 23 Nov 2022 18:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbiKWRK4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Nov 2022 12:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239052AbiKWRKq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2022 12:10:46 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B2F1148
        for <linux-iio@vger.kernel.org>; Wed, 23 Nov 2022 09:10:45 -0800 (PST)
Received: from frapeml500006.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NHSHs0l8xz689W8;
        Thu, 24 Nov 2022 01:08:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 18:10:44 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 23 Nov
 2022 17:10:43 +0000
Date:   Wed, 23 Nov 2022 17:10:42 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Philipp Jungkamp <p.jungkamp@gmx.net>
CC:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] HID: hid-sensor-custom: Allow more custom iio
 sensors
Message-ID: <20221123171042.00003b0d@Huawei.com>
In-Reply-To: <20221117234824.6227-1-p.jungkamp@gmx.net>
References: <20221117150508.00002704@Huawei.com>
        <20221117234824.6227-1-p.jungkamp@gmx.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

On Fri, 18 Nov 2022 00:48:21 +0100
Philipp Jungkamp <p.jungkamp@gmx.net> wrote:

> The known LUID table for established/known custom HID sensors was
> limited to sensors with "INTEL" as manufacturer. But some vendors such
> as Lenovo also include fairly standard iio sensors (e.g. ambient light)
> in their custom sensors.
> 
> Expand the known custom sensors table by a tag used for the platform
> device name and match sensors based on the LUID as well as optionally
> on model and manufacturer properties.
> Introduce sensors from Lenovo's "Intelligent Sensing Solution" on the
> Lenovo Yoga 9 14IAP7 as an example.
Description needs an update.  This is the No Operational Changes
patch, not the next one (which adds those IDs).
Point being that after this patch the code should function exactly as
before.  After the next patch, more devices will be recognized due to the
new IDs.
