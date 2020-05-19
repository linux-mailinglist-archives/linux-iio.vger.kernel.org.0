Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6D21D9E3C
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 19:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgESRw2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 13:52:28 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729001AbgESRw2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 May 2020 13:52:28 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 5D9B76180D7930E2DFAC;
        Tue, 19 May 2020 18:52:27 +0100 (IST)
Received: from localhost (10.47.86.149) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Tue, 19 May
 2020 18:52:26 +0100
Date:   Tue, 19 May 2020 18:51:59 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: imu: bmi160: add regulators
 and mount-matrix
Message-ID: <20200519185159.00001bd1@Huawei.com>
In-Reply-To: <20200519075111.6356-3-jonathan.albrieux@gmail.com>
References: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
        <20200519075111.6356-3-jonathan.albrieux@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.86.149]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 May 2020 09:50:58 +0200
Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:

> Add vdd-supply and vddio-supply support.
> Add mount-matrix support.
> 
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>

A few minor comments inline.

> ---
>  .../devicetree/bindings/iio/imu/bmi160.yaml   | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.yaml b/Documentation/devicetree/bindings/iio/imu/bmi160.yaml
> index 6b464ce5ed0b..5b13af7a209f 100644
> --- a/Documentation/devicetree/bindings/iio/imu/bmi160.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/bmi160.yaml
> @@ -46,6 +46,21 @@ properties:
>        set if the specified interrupt pin should be configured as
>        open drain. If not set, defaults to push-pull.
>  
> +  vdd-supply:
> +    maxItems: 1
> +    description: |
> +      an optional regulator that needs to be on to provide VDD power to
> +      the sensor.

They aren't optional.  Whether we specify them or rely on stub regulators
being provided because they aren't controllable is the optional bit.
That's clearly defined by them not being in the required list below.
So say something li.e

   description: |
      provide VDD power to the sensor.

> +
> +  vddio-supply:
> +    maxItems: 1
> +    description: |
> +      an optional regulator that needs to be on to provide the VDD IO power to
> +      the sensor.
> +
> +  mount-matrix:
> +    description: an optional 3x3 mounting rotation matrix
> +
>  required:
>    - compatible
>    - reg
> @@ -61,9 +76,15 @@ examples:
>          bmi160@68 {
>                  compatible = "bosch,bmi160";
>                  reg = <0x68>;
> +                vdd-supply = <&pm8916_l17>;
> +                vddio-supply = <&pm8916_l6>;
>                  interrupt-parent = <&gpio4>;
>                  interrupts = <12 1>;
>                  interrupt-names = "INT1";
> +                mount-matrix = "0", "1", "0",
> +                               "-1", "0", "0",
> +                               "0", "0", "1";
> +                };
>          };
>    - |
>      // Example for SPI


