Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84F9512EA1
	for <lists+linux-iio@lfdr.de>; Thu, 28 Apr 2022 10:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344291AbiD1Ijh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Apr 2022 04:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344705AbiD1IjJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Apr 2022 04:39:09 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25436AAE31
        for <linux-iio@vger.kernel.org>; Thu, 28 Apr 2022 01:31:35 -0700 (PDT)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KppgG6tfxz6864T;
        Thu, 28 Apr 2022 16:28:58 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 28 Apr 2022 10:31:32 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 09:31:32 +0100
Date:   Thu, 28 Apr 2022 09:31:30 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gwendal Grignou <gwendal@chromium.org>
CC:     <jic23@kernel.org>, <bleung@chromium.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] chrome: Remove Custom ABI |location| attribute
Message-ID: <20220428093130.000051b2@Huawei.com>
In-Reply-To: <20220427190804.961697-1-gwendal@chromium.org>
References: <20220427190804.961697-1-gwendal@chromium.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 27 Apr 2022 12:08:02 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Instead of using the custom |location| attribute, use the |label| attribute
> introduced in kernel 5.8.
> A new location is required for sensors located in a camera subassembly that
> swivels.
> 

I'm assuming this ABI change is fine because you can change the software stack
as well?

Is this likely to break anyone relying on the old location attribute?

Jonathan

> ---
>  changes in v2:
>  * Add "accel-camera" define.
>  * remove |location| attribute completely.
> 
> Gwendal Grignou (2):
>   iio: ABI: Add a new location label
>   iio: common: cros_ec_sensors: Add label attribute
> 
>  Documentation/ABI/testing/sysfs-bus-iio       |  5 ++++
>  drivers/iio/accel/cros_ec_accel_legacy.c      |  2 +-
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 30 ++++++-------------
>  drivers/iio/light/cros_ec_light_prox.c        |  2 --
>  drivers/iio/pressure/cros_ec_baro.c           |  2 --
>  .../linux/iio/common/cros_ec_sensors_core.h   |  2 --
>  6 files changed, 15 insertions(+), 28 deletions(-)
> 

