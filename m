Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D0A3D3D97
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 18:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhGWPs4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 11:48:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3478 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhGWPsz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 11:48:55 -0400
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GWZCH1g52z6D8Yq;
        Sat, 24 Jul 2021 00:14:35 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 23 Jul 2021 18:29:27 +0200
Received: from localhost (10.210.170.238) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Fri, 23 Jul
 2021 17:29:26 +0100
Date:   Fri, 23 Jul 2021 17:29:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Puranjay Mohan <puranjay12@gmail.com>
CC:     <Michael.Hennerich@analog.com>, <alexandru.ardelean@analog.com>,
        <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <Dragos.Bogdan@analog.com>,
        <Darius.Berghe@analog.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: accel: Add ADXL355 in
 trivial-devices
Message-ID: <20210723172902.00004151@Huawei.com>
In-Reply-To: <20210722062155.32998-2-puranjay12@gmail.com>
References: <20210722062155.32998-1-puranjay12@gmail.com>
        <20210722062155.32998-2-puranjay12@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.170.238]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 22 Jul 2021 11:51:53 +0530
Puranjay Mohan <puranjay12@gmail.com> wrote:

> Add ADXL355, a 3-Axis MEMS Accelerometer into trivial-devices.yaml.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

Hi Puranjay,

So, a binding should include (as well as we can) all hardware elements,
not just those currently supported by the driver.

This particular device has two interrupts + a dataready signal which is
effectively another interrupt. It also has dual power supplies.

That makes it a rather non-trivial device from the point of view of
bindings. Hence, please give it a file of it's own and also document
the interrupt and supply elements.

Jonathan
 
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 8341e9d23..0097d6e81 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -41,6 +41,8 @@ properties:
>            - adi,adp5589
>              # +/-1C TDM Extended Temp Range I.C
>            - adi,adt7461
> +            # ADXL355:- 3-Axis Low noise MEMS Accelerometer.
> +          - adi,adxl355
>              # +/-1C TDM Extended Temp Range I.C
>            - adt7461
>              # AMS iAQ-Core VOC Sensor

