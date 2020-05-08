Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47BDB1CB258
	for <lists+linux-iio@lfdr.de>; Fri,  8 May 2020 16:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgEHO4i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 May 2020 10:56:38 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2176 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726690AbgEHO4i (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 May 2020 10:56:38 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 5C856535883A350AC80C;
        Fri,  8 May 2020 15:56:36 +0100 (IST)
Received: from localhost (10.47.95.97) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 8 May 2020
 15:56:35 +0100
Date:   Fri, 8 May 2020 15:56:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gwendal Grignou <gwendal@chromium.org>
CC:     <enric.balletbo@collabora.com>, <jic23@kernel.org>,
        <bleung@chromium.org>, <groeck@chromium.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] iio: cros_ec: Add support for RGB light sensor
Message-ID: <20200508155613.00005c95@Huawei.com>
In-Reply-To: <20200506230324.139241-1-gwendal@chromium.org>
References: <20200506230324.139241-1-gwendal@chromium.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.95.97]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 6 May 2020 16:03:21 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Add support for color light sensor presented by the Chromebook Embedded
> Controller (EC).
> Instead of just presenting lux measurement (clear channel), a color light
> sensor is able to report color temperature measurement.
> 
> The EC, using factory settings, can transform the raw measurement into
> the CIE 1931 XYZ color space (XYZ) and take adavantage of color sensor
> autocalibration to provide the most accurate measurements.

v3 of series with v2 patches?

Also my earlier comment about colour channels cannot be illuminance
still stands. It is a term that "only" applies to light measurements with
a particular frequency / sensitivity curve.

The colour channels should all be in_intensity_xxx_raw.

If you want to do the computation in driver to derive the illuminance
that would be great, otherwise we shouldn't have any illuminance channels.

Jonathan


> 
> Gwendal Grignou (3):
>   iio: Add in_illumincance vectors in different color spaces
>   iio: cros_ec: Allow enabling/disabling calibration mode
>   iio: cros_ec_light: Add support for RGB sensor
> 
>  Documentation/ABI/testing/sysfs-bus-iio       |  27 +
>  .../cros_ec_sensors/cros_ec_sensors_core.c    |   3 +-
>  drivers/iio/light/cros_ec_light_prox.c        | 469 +++++++++++++++---
>  drivers/platform/chrome/cros_ec_sensorhub.c   |   3 +
>  .../linux/iio/common/cros_ec_sensors_core.h   |   1 -
>  .../linux/platform_data/cros_ec_commands.h    |  14 +-
>  6 files changed, 441 insertions(+), 76 deletions(-)
> 


