Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42B8415431E
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 12:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbgBFLcE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 06:32:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:60080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbgBFLcD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Feb 2020 06:32:03 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D81620730;
        Thu,  6 Feb 2020 11:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580988721;
        bh=JNxsz1C6aHr/v+tL+tzAIo/EsrhaWWkpcO1jE44hes4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MUim/WxwriWXHS4XseSwKd4TvwAwzsMacWrDZXs+/p+rojM2X7eAM+sN5oj3OXx6s
         AU1avzjSWKKFhgcNey6zfgTqdmp0nLshIxr68mGbpZzUrq3ELEdigCAqxv+lHnj9gd
         QXyHcG9d7XCwPYxHjms1bRh4Y9rBcu9s/G2bzdZI=
Date:   Thu, 6 Feb 2020 11:31:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-clk@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Fix paths in schema $id fields
Message-ID: <20200206113154.5d2383e8@archlinux>
In-Reply-To: <20200204224909.26880-1-robh@kernel.org>
References: <20200204224909.26880-1-robh@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  4 Feb 2020 22:49:09 +0000
Rob Herring <robh@kernel.org> wrote:

> The $id path checks were inadequately checking the path part of the $id
> value. With the check fixed, there's a number of errors that need to be
> fixed. Most of the errors are including 'bindings/' in the path which
> should not be as that is considered the root.
>=20
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Stefan Popa <stefan.popa@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
> Cc: Kent Gustavsson <kent@minoris.se>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> #for iio
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml                  | 2 +-
>  Documentation/devicetree/bindings/arm/qcom.yaml                 | 2 +-
>  Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml | 2 +-
>  Documentation/devicetree/bindings/clock/fsl,sai-clock.yaml      | 2 +-
>  Documentation/devicetree/bindings/clock/imx8mn-clock.yaml       | 2 +-
>  Documentation/devicetree/bindings/clock/imx8mp-clock.yaml       | 2 +-
>  Documentation/devicetree/bindings/clock/milbeaut-clock.yaml     | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,dispcc.yaml        | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,gcc.yaml           | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,gpucc.yaml         | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,mmcc.yaml          | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml        | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,videocc.yaml       | 2 +-
>  Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml    | 2 +-
>  Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml    | 2 +-
>  Documentation/devicetree/bindings/hwmon/adi,ltc2947.yaml        | 2 +-
>  Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml       | 2 +-
>  Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml       | 2 +-
>  .../devicetree/bindings/iio/adc/microchip,mcp3911.yaml          | 2 +-
>  .../devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml         | 2 +-
>  Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml     | 2 +-
>  Documentation/devicetree/bindings/input/gpio-vibrator.yaml      | 2 +-
>  22 files changed, 22 insertions(+), 22 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentati=
on/devicetree/bindings/arm/fsl.yaml
> index f79683a628f0..b0a7454a70b8 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/bindings/arm/fsl.yaml#
> +$id: http://devicetree.org/schemas/arm/fsl.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
>  title: Freescale i.MX Platforms Device Tree Bindings
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentat=
ion/devicetree/bindings/arm/qcom.yaml
> index e39d8f02e33c..b5bef5abc281 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/bindings/arm/qcom.yaml#
> +$id: http://devicetree.org/schemas/arm/qcom.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
>  title: QCOM device tree bindings
> diff --git a/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.y=
aml b/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml
> index e63827399c1a..8559fe8f7efd 100644
> --- a/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml
> +++ b/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/bindings/clock/bitmain,bm1880-clk.yam=
l#
> +$id: http://devicetree.org/schemas/clock/bitmain,bm1880-clk.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
>  title: Bitmain BM1880 Clock Controller
> diff --git a/Documentation/devicetree/bindings/clock/fsl,sai-clock.yaml b=
/Documentation/devicetree/bindings/clock/fsl,sai-clock.yaml
> index 8fb2060ac47f..fc3bdfdc091a 100644
> --- a/Documentation/devicetree/bindings/clock/fsl,sai-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/fsl,sai-clock.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/bindings/clock/fsl,sai-clock.yaml#
> +$id: http://devicetree.org/schemas/clock/fsl,sai-clock.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
>  title: Freescale SAI bitclock-as-a-clock binding
> diff --git a/Documentation/devicetree/bindings/clock/imx8mn-clock.yaml b/=
Documentation/devicetree/bindings/clock/imx8mn-clock.yaml
> index 622f3658bd9f..cd0b8a341321 100644
> --- a/Documentation/devicetree/bindings/clock/imx8mn-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/imx8mn-clock.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/bindings/clock/imx8mn-clock.yaml#
> +$id: http://devicetree.org/schemas/clock/imx8mn-clock.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
>  title: NXP i.MX8M Nano Clock Control Module Binding
> diff --git a/Documentation/devicetree/bindings/clock/imx8mp-clock.yaml b/=
Documentation/devicetree/bindings/clock/imx8mp-clock.yaml
> index 80278882cf57..89aee63c9019 100644
> --- a/Documentation/devicetree/bindings/clock/imx8mp-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/imx8mp-clock.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/bindings/clock/imx8mp-clock.yaml#
> +$id: http://devicetree.org/schemas/clock/imx8mp-clock.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
>  title: NXP i.MX8M Plus Clock Control Module Binding
> diff --git a/Documentation/devicetree/bindings/clock/milbeaut-clock.yaml =
b/Documentation/devicetree/bindings/clock/milbeaut-clock.yaml
> index 5cf0b811821e..f0b804a7f096 100644
> --- a/Documentation/devicetree/bindings/clock/milbeaut-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/milbeaut-clock.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/bindings/clock/milbeaut-clock.yaml#
> +$id: http://devicetree.org/schemas/clock/milbeaut-clock.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
>  title: Milbeaut SoCs Clock Controller Binding
> diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc.yaml b/D=
ocumentation/devicetree/bindings/clock/qcom,dispcc.yaml
> index 9c58e02a1de1..795fe686f3ea 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,dispcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,dispcc.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/bindings/clock/qcom,dispcc.yaml#
> +$id: http://devicetree.org/schemas/clock/qcom,dispcc.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
>  title: Qualcomm Display Clock & Reset Controller Binding
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml b/Docu=
mentation/devicetree/bindings/clock/qcom,gcc.yaml
> index cac1150c9292..e814eec1bf8d 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/bindings/clock/qcom,gcc.yaml#
> +$id: http://devicetree.org/schemas/clock/qcom,gcc.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
>  title: Qualcomm Global Clock & Reset Controller Binding
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Do=
cumentation/devicetree/bindings/clock/qcom,gpucc.yaml
> index 622845aa643f..679e7fe0fa83 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/bindings/clock/qcom,gpucc.yaml#
> +$id: http://devicetree.org/schemas/clock/qcom,gpucc.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
>  title: Qualcomm Graphics Clock & Reset Controller Binding
> diff --git a/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml b/Doc=
umentation/devicetree/bindings/clock/qcom,mmcc.yaml
> index 91101c915904..85518494ce43 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/bindings/clock/qcom,mmcc.yaml#
> +$id: http://devicetree.org/schemas/clock/qcom,mmcc.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
>  title: Qualcomm Multimedia Clock & Reset Controller Binding
> diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/D=
ocumentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
> index 94e2f14eb967..2cd158f13bab 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/bindings/clock/qcom,rpmhcc.yaml#
> +$id: http://devicetree.org/schemas/clock/qcom,rpmhcc.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
>  title: Qualcomm Technologies, Inc. RPMh Clocks Bindings
> diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/=
Documentation/devicetree/bindings/clock/qcom,videocc.yaml
> index 43cfc893a8d1..2946b240e161 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/bindings/clock/qcom,videocc.yaml#
> +$id: http://devicetree.org/schemas/clock/qcom,videocc.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
>  title: Qualcomm Video Clock & Reset Controller Binding
> diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml=
 b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
> index b8f91e444d2f..4e385508f516 100644
> --- a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/bindings/clock/st,stm32mp1-rcc.yaml#
> +$id: http://devicetree.org/schemas/clock/st,stm32mp1-rcc.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
>  title: Reset Clock Controller Binding
> diff --git a/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml=
 b/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
> index f1150cad34a4..229af98b1d30 100644
> --- a/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
> +++ b/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/bindings/clock/xlnx,versal-clk.yaml#
> +$id: http://devicetree.org/schemas/clock/xlnx,versal-clk.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
>  title: Xilinx Versal clock controller
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2947.yaml b/D=
ocumentation/devicetree/bindings/hwmon/adi,ltc2947.yaml
> index ae04903f34bf..6a742a51e2f9 100644
> --- a/Documentation/devicetree/bindings/hwmon/adi,ltc2947.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adi,ltc2947.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/bindings/hwmon/adi,ltc2947.yaml#
> +$id: http://devicetree.org/schemas/hwmon/adi,ltc2947.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
>  title: Analog Devices LTC2947 high precision power and energy monitor
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> index e932d5aed02f..f0934b295edc 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> @@ -2,7 +2,7 @@
>  # Copyright 2019 Analog Devices Inc.
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/bindings/iio/adc/adi,ad7124.yaml#
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7124.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
>  title: Analog Devices AD7124 ADC device driver
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> index 567a33a83dce..84d25bd39488 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> @@ -2,7 +2,7 @@
>  # Copyright 2019 Analog Devices Inc.
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/bindings/iio/adc/adi,ad7192.yaml#
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7192.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
>  title: Analog Devices AD7192 ADC device driver
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.=
yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> index 881059b80d61..0ce290473fb0 100644
> --- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> @@ -2,7 +2,7 @@
>  # Copyright 2019 Marcus Folkesson <marcus.folkesson@gmail.com>
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/bindings/iio/adc/microchip,mcp3911.y=
aml#"
> +$id: "http://devicetree.org/schemas/iio/adc/microchip,mcp3911.yaml#"
>  $schema: "http://devicetree.org/meta-schemas/core.yaml#"
> =20
>  title: Microchip MCP3911 Dual channel analog front end (ADC)
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc=
.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
> index c91407081aa5..acf36eef728b 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/st,stm32-dfsdm-adc.yaml#
> +$id: http://devicetree.org/schemas/iio/adc/st,stm32-dfsdm-adc.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
>  title: STMicroelectronics STM32 DFSDM ADC device driver
> diff --git a/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml =
b/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
> index 13d005b68931..a285eaba7125 100644
> --- a/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
> @@ -2,7 +2,7 @@
>  # Copyright 2019 Marcus Folkesson <marcus.folkesson@gmail.com>
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/bindings/iio/dac/lltc,ltc1660.yaml#"
> +$id: "http://devicetree.org/schemas/iio/dac/lltc,ltc1660.yaml#"
>  $schema: "http://devicetree.org/meta-schemas/core.yaml#"
> =20
>  title: Linear Technology Micropower octal 8-Bit and 10-Bit DACs
> diff --git a/Documentation/devicetree/bindings/input/gpio-vibrator.yaml b=
/Documentation/devicetree/bindings/input/gpio-vibrator.yaml
> index 903475f52dbd..b98bf9363c8f 100644
> --- a/Documentation/devicetree/bindings/input/gpio-vibrator.yaml
> +++ b/Documentation/devicetree/bindings/input/gpio-vibrator.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/bindings/input/gpio-vibrator.yaml#
> +$id: http://devicetree.org/schemas/input/gpio-vibrator.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
>  title: GPIO vibrator

