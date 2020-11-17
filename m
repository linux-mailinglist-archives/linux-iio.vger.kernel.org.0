Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DD22B6961
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 17:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgKQQG3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 11:06:29 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2124 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgKQQG3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 11:06:29 -0500
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cb9kG4qL9z67DmS;
        Wed, 18 Nov 2020 00:04:38 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 17 Nov 2020 17:06:27 +0100
Received: from localhost (10.47.31.177) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 17 Nov
 2020 16:06:26 +0000
Date:   Tue, 17 Nov 2020 16:06:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
CC:     <jic23@kernel.org>, <lorenzo.bianconi@redhat.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: introduce
 vdd-vddio regulators bindings
Message-ID: <20201117160618.00003807@Huawei.com>
In-Reply-To: <fd692095f2cdda5a99327f57e69c34a4ffce232f.1605625579.git.lorenzo@kernel.org>
References: <cover.1605625579.git.lorenzo@kernel.org>
        <fd692095f2cdda5a99327f57e69c34a4ffce232f.1605625579.git.lorenzo@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.31.177]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Nov 2020 16:11:38 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> index 7c6742d3e992..bc3448df9647 100644
> --- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> @@ -20,6 +20,10 @@ Required properties:
>  - reg: i2c address of the sensor / spi cs line
>  
>  Optional properties:
> +- vdd-supply: an optional regulator that needs to be on to provide VDD
> +  power to the sensor.
> +- vddio-supply: an optional regulator that needs to be on to provide the
> +  VDD IO power to the sensor.
>  - st,drdy-int-pin: the pin on the package that will be used to signal
>    "data ready" (valid values: 1 or 2).
>  - st,pullups : enable/disable internal i2c controller pullup resistors.

Hi Lorenzo,

Please could you rebase this on top of 
https://lore.kernel.org/linux-iio/20201031184854.745828-13-jic23@kernel.org/

Which does a yaml conversion of this file.

I'm working my way through backlog of those this week so will pick that up
at some point very soon.

I'll resend a v2 of some patches in those series, but only those where there
are outstanding comments that aren't trivial.

(Rob's acked most with a few requested tweaks).

Thanks,

Jonathan
