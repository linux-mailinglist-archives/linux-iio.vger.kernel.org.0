Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CC06AEA2C
	for <lists+linux-iio@lfdr.de>; Tue,  7 Mar 2023 18:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjCGRbW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Mar 2023 12:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjCGRbC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Mar 2023 12:31:02 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F3594766;
        Tue,  7 Mar 2023 09:26:22 -0800 (PST)
Received: from [192.168.1.141] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mf0FY-1qEyER18xu-00gZxI; Tue, 07 Mar 2023 18:25:25 +0100
Message-ID: <a2a39419-86e9-2dff-644a-391248b51a0e@i2se.com>
Date:   Tue, 7 Mar 2023 18:25:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 7/8] ARM: dts: imx6ull: Add chargebyte Tarragon support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-imx@nxp.com, Li Yang <leoyang.li@nxp.com>,
        Denis Ciocca <denis.ciocca@st.com>, soc@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@chargebyte.com>
References: <20230306172249.74003-1-stefan.wahren@i2se.com>
 <20230306172249.74003-8-stefan.wahren@i2se.com>
 <d77c2938-bcef-4586-77b5-1cb93b113eb5@linaro.org>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <d77c2938-bcef-4586-77b5-1cb93b113eb5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RsDQrIo2ZQR3Aq166ZFWN07AvwnhS8DDvMRDPETRCZhn/+TB7ii
 6kZVydNHo2h6howXdFkNg6ncj8kI5RJl94Ct85BJ2uei8Q074aI9mmECdz4W4boTT6vpx5h
 XeJRJyRpCblEQE7qrGC04LErqLO/0eTnw7iRRYTNy4Wb6qcKr/qGVooH+UG4Rjo84Dxh5C/
 3TvgWVRwv1VQEWhCgSgLg==
UI-OutboundReport: notjunk:1;M01:P0:ekZsYtJg+Sw=;16NcdWSP67Kqrg6684a4vhOYYdr
 l4rKFy6hs00kdbrPE1TX+V7+qgfHqpX2VMlL7GvN1C4OcjzK39BVGt6rIAaI+Frd0s1BC30Es
 pkCyWnN/F+3yAP+IPYLGHpSwpRfvLx962pon6dB3bmZhK002itpGEtgW4CUGBvYdMgv+jJ07+
 qCKKYYgVQ17w6TZE5O9BK0ecsWqFvrDUubW5i9BmG6eFWWIQXWzAxQ0AmHQ6n56Yc3eNT/KoA
 nymj5cLb/Zfjg2ndwylq5bC3VKwlI/vyUYXW9tUYqMmHYTHlHrQ4cVtL8K73z/gEVZUDTB3no
 SXT4oWV1tY94olO7i6XNiY5ZLiJEuwjsaIiURd1NAeRbcH4G7ZPQoV0lku/eR9jWhCqIxQFJS
 3kTQQUQUmzldeokjZ630Bkf/oVS/R+YzkaHUPZNALbFdamJR6+6Pr+en32croiZ2dPD+Qpd/v
 a1YTwAnSgyydKqiLzR9YybV2/KpNWx+XeWMI4REhCzBHx3lfaU5lz2M1zvJDLXiFWD0wo82a+
 Vzrhm6Jan6EoSBVwLY9c6q8VxjtP3syuwy3qbeWXez8QQh1jyR96l4zQMv3dR2kV5COQZniQw
 Bubl9k7f2VSyIQyLIHKsBNPBOQULnD7Rqjz/RnTdbJjDcTC4f+UjxrKpAlp0Oxkw8qel4nAMj
 0fixENq35Kt5TfiUrZ7r+DPLM6AiqZBiYtLhrCvCdg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Krzysztof,

Am 07.03.23 um 09:30 schrieb Krzysztof Kozlowski:
> On 06/03/2023 18:22, Stefan Wahren wrote:
>> From: Stefan Wahren <stefan.wahren@chargebyte.com>
>>
>> This adds the support for chargebyte Tarragon, which is an Electrical
>> Vehicle Supply Equipment (EVSE) for AC charging stations
>> (according to IEC 61851, ISO 15118).
>>
>> The Tarragon board is based on an i.MX6ULL SoC and is available in
>> 4 variants (Master, Slave, SlaveXT, Micro), which provide more or
>> less peripherals.
>>
>> Supported features:
>>    * 512 MB DDR RAM
>>    * eMMC
>>    * Debug UART
>>    * 100 Mbit Ethernet
>>    * USB 2.0 Host interface
>>    * Powerline communication (QCA700x)
>>    * 2x RS485
>>    * Digital in- and outputs (12 V)
>>    * One-Wire master for external temp sensors
>>    * 2x relay outputs
>>    * 2x motor interfaces
>>
>> Link: https://chargebyte.com/products/charging-station-communication/charge-control-c
>> Signed-off-by: Stefan Wahren <stefan.wahren@chargebyte.com>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> ---
>>   arch/arm/boot/dts/Makefile                    |   4 +
>>   .../arm/boot/dts/imx6ull-tarragon-common.dtsi | 858 ++++++++++++++++++
>>   arch/arm/boot/dts/imx6ull-tarragon-master.dts |  82 ++
>>   arch/arm/boot/dts/imx6ull-tarragon-micro.dts  |  10 +
>>   arch/arm/boot/dts/imx6ull-tarragon-slave.dts  |  32 +
>>   .../arm/boot/dts/imx6ull-tarragon-slavext.dts |  64 ++
>>   6 files changed, 1050 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/imx6ull-tarragon-common.dtsi
>>   create mode 100644 arch/arm/boot/dts/imx6ull-tarragon-master.dts
>>   create mode 100644 arch/arm/boot/dts/imx6ull-tarragon-micro.dts
>>   create mode 100644 arch/arm/boot/dts/imx6ull-tarragon-slave.dts
>>   create mode 100644 arch/arm/boot/dts/imx6ull-tarragon-slavext.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index efe4152e5846..aae52a6380bc 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -755,6 +755,10 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
>>   	imx6ull-phytec-segin-lc-rdk-nand.dtb \
>>   	imx6ull-phytec-tauri-emmc.dtb \
>>   	imx6ull-phytec-tauri-nand.dtb \
>> +	imx6ull-tarragon-master.dtb \
>> +	imx6ull-tarragon-micro.dtb \
>> +	imx6ull-tarragon-slave.dtb \
>> +	imx6ull-tarragon-slavext.dtb \
>>   	imx6ull-tqma6ull2-mba6ulx.dtb \
>>   	imx6ull-tqma6ull2l-mba6ulx.dtb \
>>   	imx6ulz-14x14-evk.dtb \
>> diff --git a/arch/arm/boot/dts/imx6ull-tarragon-common.dtsi b/arch/arm/boot/dts/imx6ull-tarragon-common.dtsi
>> new file mode 100644
>> index 000000000000..1099dd688e80
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/imx6ull-tarragon-common.dtsi
>> @@ -0,0 +1,858 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>> +//
>> +// Copyright (C) 2023 chargebyte GmbH
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/leds/common.h>
>> +#include <dt-bindings/pwm/pwm.h>
>> +#include "imx6ull.dtsi"
>> +
>> +/ {
>> +	aliases {
>> +		mmc0 = &usdhc2; /* eMMC */
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = &uart4;
>> +	};
>> +
>> +	memory@80000000 {
>> +		device_type = "memory";
>> +		reg = <0x80000000 0x20000000>;
>> +	};
>> +
>> +	emmc_pwrseq: emmc-pwrseq {
>> +		compatible = "mmc-pwrseq-emmc";
>> +		pinctrl-0 = <&pinctrl_emmc_rst>;
>> +		pinctrl-names = "default";
>> +		reset-gpios = <&gpio4 10 GPIO_ACTIVE_LOW>;
>> +	};
>> +
>> +	reg_dcdc_3v3: regulator-dcdc-3v3 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "dcdc-3v3";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-boot-on;
>> +		regulator-always-on;
>> +	};
>> +
>> +	reg_1v8: regulator-1v8 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "ldo-1v8";
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <1800000>;
>> +		regulator-boot-on;
>> +		regulator-always-on;
>> +	};
>> +
>> +	leds {
>> +		compatible = "gpio-leds";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_status_leds>;
>> +
>> +		led1 {
> Does not look like you tested the DTS against bindings. Please run `make
> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
> for instructions).

I ran make dtbs_check before sending this series. All of these issues in 
the included dtsi files makes it hard to spot DTS specific issues. This 
is the output of make dtbs_check:

   DTC_CHK arch/arm/boot/dts/imx6ull-tarragon-master.dtb
/home/stefanw/mainline/arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
nand-controller@1806000: #size-cells:0:0: 0 was expected
     From schema: 
/home/stefanw/mainline/Documentation/devicetree/bindings/mtd/nand-controller.yaml
/home/stefanw/mainline/arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
nand-controller@1806000: #size-cells:0:0: 0 was expected
     From schema: 
/home/stefanw/mainline/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
/soc/bus@2000000/spba-bus@2000000/spi@200c000/ethernet@0: failed to 
match any schema with compatible: ['qca,qca7000']
arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
/soc/bus@2000000/spba-bus@2000000/spi@2014000/ethernet@0: failed to 
match any schema with compatible: ['qca,qca7000']
/home/stefanw/mainline/arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
serial@2018000: Unevaluated properties are not allowed ('clock-names', 
'clocks' were unexpected)
     From schema: 
/home/stefanw/mainline/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
/home/stefanw/mainline/arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
serial@2020000: Unevaluated properties are not allowed ('clock-names', 
'clocks' were unexpected)
     From schema: 
/home/stefanw/mainline/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
/soc/bus@2000000/spba-bus@2000000/asrc@2034000: failed to match any 
schema with compatible: ['fsl,imx6ul-asrc', 'fsl,imx53-asrc']
arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
/soc/bus@2000000/spba-bus@2000000/asrc@2034000: failed to match any 
schema with compatible: ['fsl,imx6ul-asrc', 'fsl,imx53-asrc']
arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
/soc/bus@2000000/tsc@2040000: failed to match any schema with 
compatible: ['fsl,imx6ul-tsc']
arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
/soc/bus@2000000/anatop@20c8000: failed to match any schema with 
compatible: ['fsl,imx6ul-anatop', 'fsl,imx6q-anatop', 'syscon', 
'simple-mfd']
arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
/soc/bus@2000000/anatop@20c8000: failed to match any schema with 
compatible: ['fsl,imx6ul-anatop', 'fsl,imx6q-anatop', 'syscon', 
'simple-mfd']
arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
/soc/bus@2000000/usbphy@20c9000: failed to match any schema with 
compatible: ['fsl,imx6ul-usbphy', 'fsl,imx23-usbphy']
arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
/soc/bus@2000000/usbphy@20c9000: failed to match any schema with 
compatible: ['fsl,imx6ul-usbphy', 'fsl,imx23-usbphy']
arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
/soc/bus@2000000/usbphy@20ca000: failed to match any schema with 
compatible: ['fsl,imx6ul-usbphy', 'fsl,imx23-usbphy']
arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
/soc/bus@2000000/usbphy@20ca000: failed to match any schema with 
compatible: ['fsl,imx6ul-usbphy', 'fsl,imx23-usbphy']
arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
/soc/bus@2000000/snvs@20cc000: failed to match any schema with 
compatible: ['fsl,sec-v4.0-mon', 'syscon', 'simple-mfd']
arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
/soc/bus@2000000/snvs@20cc000/snvs-rtc-lp: failed to match any schema 
with compatible: ['fsl,sec-v4.0-mon-rtc-lp']
arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
/soc/bus@2000000/snvs@20cc000/snvs-powerkey: failed to match any schema 
with compatible: ['fsl,sec-v4.0-pwrkey']
arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
/soc/bus@2000000/pinctrl@20e0000: failed to match any schema with 
compatible: ['fsl,imx6ul-iomuxc']
arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
/soc/bus@2000000/iomuxc-gpr@20e4000: failed to match any schema with 
compatible: ['fsl,imx6ul-iomuxc-gpr', 'fsl,imx6q-iomuxc-gpr', 'syscon']
arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
/soc/bus@2000000/iomuxc-gpr@20e4000: failed to match any schema with 
compatible: ['fsl,imx6ul-iomuxc-gpr', 'fsl,imx6q-iomuxc-gpr', 'syscon']
arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
/soc/bus@2100000/usb@2184000: failed to match any schema with 
compatible: ['fsl,imx6ul-usb', 'fsl,imx27-usb']
arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
/soc/bus@2100000/usb@2184000: failed to match any schema with 
compatible: ['fsl,imx6ul-usb', 'fsl,imx27-usb']
arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
/soc/bus@2100000/usb@2184200: failed to match any schema with 
compatible: ['fsl,imx6ul-usb', 'fsl,imx27-usb']
arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
/soc/bus@2100000/usb@2184200: failed to match any schema with 
compatible: ['fsl,imx6ul-usb', 'fsl,imx27-usb']
arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
/soc/bus@2100000/usbmisc@2184800: failed to match any schema with 
compatible: ['fsl,imx6ul-usbmisc', 'fsl,imx6q-usbmisc']
arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
/soc/bus@2100000/usbmisc@2184800: failed to match any schema with 
compatible: ['fsl,imx6ul-usbmisc', 'fsl,imx6q-usbmisc']
arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
/soc/bus@2100000/weim@21b8000: failed to match any schema with 
compatible: ['fsl,imx6ul-weim', 'fsl,imx6q-weim']
arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
/soc/bus@2100000/weim@21b8000: failed to match any schema with 
compatible: ['fsl,imx6ul-weim', 'fsl,imx6q-weim']
/home/stefanw/mainline/arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
serial@21f0000: Unevaluated properties are not allowed ('clock-names', 
'clocks' were unexpected)
     From schema: 
/home/stefanw/mainline/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
/home/stefanw/mainline/arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
serial@21f4000: Unevaluated properties are not allowed ('clock-names', 
'clocks' were unexpected)
     From schema: 
/home/stefanw/mainline/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
/home/stefanw/mainline/arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
serial@21fc000: Unevaluated properties are not allowed ('clock-names', 
'clocks' were unexpected)
     From schema: 
/home/stefanw/mainline/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
arch/arm/boot/dts/imx6ull-tarragon-master.dtb: 
/soc/bus@2200000/iomuxc-snvs@2290000: failed to match any schema with 
compatible: ['fsl,imx6ull-iomuxc-snvs']
arch/arm/boot/dts/imx6ull-tarragon-master.dtb: /pwm-fan: failed to match 
any schema with compatible: ['pwm-fan']

Can you please point me, what is wrong or did you refer just to the 
deprecated "label" property which doesn't throw a warning in my case?

Did i missed a parameter?

Best regards

