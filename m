Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5FE1CB2A6
	for <lists+linux-iio@lfdr.de>; Fri,  8 May 2020 17:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgEHPRA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 May 2020 11:17:00 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2177 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726627AbgEHPQ7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 May 2020 11:16:59 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 16153BD9B3A15415493E;
        Fri,  8 May 2020 16:16:58 +0100 (IST)
Received: from localhost (10.47.95.97) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 8 May 2020
 16:16:57 +0100
Date:   Fri, 8 May 2020 16:16:35 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gwendal Grignou <gwendal@chromium.org>
CC:     <enric.balletbo@collabora.com>, <jic23@kernel.org>,
        <bleung@chromium.org>, <groeck@chromium.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] iio: Add in_illumincance vectors in different
 color spaces
Message-ID: <20200508161635.00006cd2@Huawei.com>
In-Reply-To: <20200506230324.139241-2-gwendal@chromium.org>
References: <20200506230324.139241-1-gwendal@chromium.org>
        <20200506230324.139241-2-gwendal@chromium.org>
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

On Wed, 6 May 2020 16:03:22 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

Illuminance in the title.  Plus I'm still arguing these
aren't illuminance values.  

The Y value is illuminance but X and Z definitely aren't.
RGB needs to stick to intensity - like the other existing
RGB sensors.

Gah.  XYZ and IIO is a mess. 

I suppose we could introduce a new type and have
in_illumiance_raw
in_chromacity_x_raw
in_chromacity_z_raw but chances of anyone understanding what we
are on about without reading wikipedia is low...

Sigh.  Unless someone else chips in, I'm inclined to be lazy and rely
on documentation to let in_illuminance_x,y,z be defined as being
cie xyz color space measurements.

It seems slighlty preferable to defining another type for these,
though I suspect I'll regret this comment when some adds
cie lab which was always my favourite colour space :)



> Define 2 spaces for defining color coming from color sensors:
> RGB and XYZ: Both are in lux.
> RGB is the raw output from sensors (Red, Green and Blue channels), in
> addition to the existing clear channel (C).

> The RGBC vector goes through a matrix transformation to produce the XYZ
> vector. Y is illumincance, and XY caries the chromaticity information.
> The matrix is model specific, as the color sensor can be behing a glass
> that can filter some wavelengths.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> New in v2.
> 
>  Documentation/ABI/testing/sysfs-bus-iio | 27 +++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index d3e53a6d8331b..256db6e63a25e 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1309,6 +1309,33 @@ Description:
>  		Illuminance measurement, units after application of scale
>  		and offset are lux.
>  
> +What:		/sys/.../iio:deviceX/in_illuminance_red_raw
> +What:		/sys/.../iio:deviceX/in_illuminance_green_raw
> +What:		/sys/.../iio:deviceX/in_illuminance_blue_raw
> +KernelVersion:	5.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Illuminance measuremed in red, green or blue channels, units
> +		after application of scale and offset are lux.

No they aren't.  Units are some magic intensity at some magic wavelength.

> +
> +What:		/sys/.../iio:deviceX/in_illuminance_x_raw
> +What:		/sys/.../iio:deviceX/in_illuminance_y_raw
> +What:		/sys/.../iio:deviceX/in_illuminance_z_raw
> +KernelVersion:	5.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		lluminance measured in the CIE 1931 color space (XYZ).
> +		in_illuminance_y_raw is a measure of the brightness, and is
> +		identical in_illuminance_raw.

That is fair enough.

> +		in_illuminance_x_raw and in_illuminance_z_raw carry chromacity
> +		information.
> +		in_illuminance_x,y,z_raw are be obtained from the sensor color
> +		channels using color matching functions that may be device
> +		specific.
> +		Units after application of scale and offset are lux.

True for Y, not for X and Z which don't have 'units' as such.

> +		The measurments can be used to represent colors in the CIE
> +		xyY color space

XYZ

> +
>  What:		/sys/.../iio:deviceX/in_intensityY_raw
>  What:		/sys/.../iio:deviceX/in_intensityY_ir_raw
>  What:		/sys/.../iio:deviceX/in_intensityY_both_raw


