Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7C0371513
	for <lists+linux-iio@lfdr.de>; Mon,  3 May 2021 14:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbhECMKF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 May 2021 08:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233852AbhECMJg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 3 May 2021 08:09:36 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7491061185;
        Mon,  3 May 2021 12:08:40 +0000 (UTC)
Date:   Mon, 3 May 2021 13:09:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?B?R2HDq3RhbiBB?= =?UTF-8?B?bmRyw6k=?= 
        <rvlander@gaetanandre.eu>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1 7/7] dt-bindings: iio: st,st-sensors: Add LSM9DS0
 compatible string
Message-ID: <20210503130931.0940aa8b@jic23-huawei>
In-Reply-To: <20210414195454.84183-7-andriy.shevchenko@linux.intel.com>
References: <20210414195454.84183-1-andriy.shevchenko@linux.intel.com>
        <20210414195454.84183-7-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 14 Apr 2021 22:54:54 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Enumerate LSM9DS0 (accelerometer and magnetometer parts) via
> 'st,lsm9ds0-imu' compatible string.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
This one crossed with a cleanup set from Linus so I've adjusted it to match
the new style of that file.

Series applied to togreg branch of iio.git and pushed out as testing for
the autobuilders to see if we missed anything.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> index db291a9390b7..43d29a7d46f1 100644
> --- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> +++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> @@ -74,6 +74,8 @@ properties:
>        - st,lps33hw
>        - st,lps35hw
>        - st,lps22hh
> +        # IMU
> +      - st,lsm9ds0-imu
>  
>    reg:
>      maxItems: 1

