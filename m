Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73D5A152282
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2020 23:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgBDWw1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Feb 2020 17:52:27 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:50385 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgBDWw1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Feb 2020 17:52:27 -0500
Received: by mail-pj1-f68.google.com with SMTP id r67so82648pjb.0;
        Tue, 04 Feb 2020 14:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bL16aPVcHJJAbC6OpG1fw3NkrVsr1W8L9M44BnAEkuw=;
        b=J0Z+ap+vFjC9eHG71WcxR24kdm4rTYivqEAdrI1gXwVgmDa5ilDUE2ChW0mYse8dBR
         Sap/xWqL0gJVvNvn5RJymEHvXJhTodrVjSqJhkoJePeOshlxSkx6MDIX4M5ju7tOiydr
         c79EjDk8uXB4FWICytChos0oriND69gaMieGIRGsPttyqTqXrBJ/5dSsbaXADnGUuhyF
         dCkqtmrIPug7FHnr5fi2n6Pt1eUgaPQs1t/uayWd2A7Vzc7VJrmrp/kKnX8xvhgI3no3
         0LRvbLQtBljPHTn1wrpQDZBb52aVB8aCEkAHGBfYhoLh1ztj2N2xRCrCJgEH6NHOepoh
         nlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=bL16aPVcHJJAbC6OpG1fw3NkrVsr1W8L9M44BnAEkuw=;
        b=mgpWs7qU/nAzqRCdIXP2MCJnM6XokbBwlEQV1nHsRvLpiILfFIUTqC+X5F9+aX/KSv
         TQ04Mn8BmyF/fzCJ6wz4t3Skeu6PRBBi1y9ga7jkgrqxsxCWXxsM6SS30u1BpshTleyH
         +0a8n/N+IScurFI2YhytN/zu1SFgaTj3gc2HcMo/iUeBj961KIawD2n2qL0Xmg425Ksp
         MMYr9dpoAWrKjG/pa3ZkmZBcbidAfEXUQcJlNYqYedFyJ2iGLsoQ9WaDPaBVGQU/dOlT
         NKCiqnXwKQ3JGrbSZq1cxcPP86PQH/Wj9s+yAf5ChNmE1zZLJVUe63Io37QePysr4w3+
         U1vg==
X-Gm-Message-State: APjAAAVxckbZHKU4wZKTLFvf1DiKDRkwgwjJMH1GlW4bncDH597MHxIt
        Szn1oinU80xVkHXgunYO3FywOPFsE9A=
X-Google-Smtp-Source: APXvYqy46XuN+YVX43ywLX65VomhRNoV8459efeM12J5y894c511WIVrvzIyukPfnTr02wZJ82zpmQ==
X-Received: by 2002:a17:90a:3603:: with SMTP id s3mr1830948pjb.61.1580856746360;
        Tue, 04 Feb 2020 14:52:26 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l10sm4621557pjy.5.2020.02.04.14.52.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Feb 2020 14:52:25 -0800 (PST)
Date:   Tue, 4 Feb 2020 14:52:24 -0800
From:   Guenter Roeck <linux@roeck-us.net>
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
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-clk@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Fix paths in schema $id fields
Message-ID: <20200204225224.GA1914@roeck-us.net>
References: <20200204224909.26880-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200204224909.26880-1-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Feb 04, 2020 at 10:49:09PM +0000, Rob Herring wrote:
> The $id path checks were inadequately checking the path part of the $id
> value. With the check fixed, there's a number of errors that need to be
> fixed. Most of the errors are including 'bindings/' in the path which
> should not be as that is considered the root.
> 
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
> Cc: "Nuno Sá" <nuno.sa@analog.com>
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

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

>  Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml       | 2 +-
>  Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml       | 2 +-
>  .../devicetree/bindings/iio/adc/microchip,mcp3911.yaml          | 2 +-
>  .../devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml         | 2 +-
>  Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml     | 2 +-
>  Documentation/devicetree/bindings/input/gpio-vibrator.yaml      | 2 +-
>  22 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
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
>  
>  title: Freescale i.MX Platforms Device Tree Bindings
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
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
>  
>  title: QCOM device tree bindings
> diff --git a/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml b/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml
> index e63827399c1a..8559fe8f7efd 100644
> --- a/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml
> +++ b/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/bindings/clock/bitmain,bm1880-clk.yaml#
> +$id: http://devicetree.org/schemas/clock/bitmain,bm1880-clk.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Bitmain BM1880 Clock Controller
> diff --git a/Documentation/devicetree/bindings/clock/fsl,sai-clock.yaml b/Documentation/devicetree/bindings/clock/fsl,sai-clock.yaml
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
>  
>  title: Freescale SAI bitclock-as-a-clock binding
> diff --git a/Documentation/devicetree/bindings/clock/imx8mn-clock.yaml b/Documentation/devicetree/bindings/clock/imx8mn-clock.yaml
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
>  
>  title: NXP i.MX8M Nano Clock Control Module Binding
> diff --git a/Documentation/devicetree/bindings/clock/imx8mp-clock.yaml b/Documentation/devicetree/bindings/clock/imx8mp-clock.yaml
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
>  
>  title: NXP i.MX8M Plus Clock Control Module Binding
> diff --git a/Documentation/devicetree/bindings/clock/milbeaut-clock.yaml b/Documentation/devicetree/bindings/clock/milbeaut-clock.yaml
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
>  
>  title: Milbeaut SoCs Clock Controller Binding
> diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc.yaml
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
>  
>  title: Qualcomm Display Clock & Reset Controller Binding
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
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
>  
>  title: Qualcomm Global Clock & Reset Controller Binding
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
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
>  
>  title: Qualcomm Graphics Clock & Reset Controller Binding
> diff --git a/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml b/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
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
>  
>  title: Qualcomm Multimedia Clock & Reset Controller Binding
> diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
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
>  
>  title: Qualcomm Technologies, Inc. RPMh Clocks Bindings
> diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
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
>  
>  title: Qualcomm Video Clock & Reset Controller Binding
> diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
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
>  
>  title: Reset Clock Controller Binding
> diff --git a/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml b/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
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
>  
>  title: Xilinx Versal clock controller
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2947.yaml b/Documentation/devicetree/bindings/hwmon/adi,ltc2947.yaml
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
>  
>  title: Analog Devices LTC2947 high precision power and energy monitor
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
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
>  
>  title: Analog Devices AD7124 ADC device driver
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
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
>  
>  title: Analog Devices AD7192 ADC device driver
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> index 881059b80d61..0ce290473fb0 100644
> --- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> @@ -2,7 +2,7 @@
>  # Copyright 2019 Marcus Folkesson <marcus.folkesson@gmail.com>
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/bindings/iio/adc/microchip,mcp3911.yaml#"
> +$id: "http://devicetree.org/schemas/iio/adc/microchip,mcp3911.yaml#"
>  $schema: "http://devicetree.org/meta-schemas/core.yaml#"
>  
>  title: Microchip MCP3911 Dual channel analog front end (ADC)
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
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
>  
>  title: STMicroelectronics STM32 DFSDM ADC device driver
> diff --git a/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml b/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
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
>  
>  title: Linear Technology Micropower octal 8-Bit and 10-Bit DACs
> diff --git a/Documentation/devicetree/bindings/input/gpio-vibrator.yaml b/Documentation/devicetree/bindings/input/gpio-vibrator.yaml
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
>  
>  title: GPIO vibrator
> -- 
> 2.20.1
> 
