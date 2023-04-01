Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BB56D3157
	for <lists+linux-iio@lfdr.de>; Sat,  1 Apr 2023 16:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjDAOdK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Apr 2023 10:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjDAOdJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2023 10:33:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B3E1EFC4;
        Sat,  1 Apr 2023 07:33:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 079B1B80B6B;
        Sat,  1 Apr 2023 14:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7E6C433EF;
        Sat,  1 Apr 2023 14:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680359584;
        bh=JIhjvzZjVgxbZ3IK6UWczaUzyLdXz5AOFgcqgubTBoE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H7Z1RaY3GsJvS8DJzhR/pyw8nG0W+9lAut1A2Uo9a3gSA6gqOqpZGEE+YkZNe/H6X
         wc/Lf96YIH2qUDECGXG/CdiDpxpCGltR4T8xzNvZJS5Kmb0vpWptmSJiv4Gjr+3FfC
         hK2z74cJKmXcujbCjTJ1gx6Dgg3CCpWsoJmx0vyYxL4jcgMz0v80p+TeTo3bS+diGY
         /dmwD5JB3YUlTHRrajTJP/L9ASf4DM6CpFQVzPuR9T04HZtyZn3/4VgwSdqtE/gdyw
         /75K6z5PglvkiPnWXWpajZRIeHOmNsK/SHsSTsE+2aXi4fF8V3S/42Zd7SvxpDCvE3
         OjjVRyERyarCw==
Date:   Sat, 1 Apr 2023 15:48:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: iio: qcom,spmi-adc7-pmk8350.h: include
 sid into defines
Message-ID: <20230401154812.62152900@jic23-huawei>
In-Reply-To: <20230329000833.2507594-2-dmitry.baryshkov@linaro.org>
References: <20230329000833.2507594-1-dmitry.baryshkov@linaro.org>
        <20230329000833.2507594-2-dmitry.baryshkov@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 29 Mar 2023 03:08:28 +0300
Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:

> pmk8350 can take different addresses on SPMI bus. Rather than having a
> default SID, follow the pm8350's example and make the sid explicit when
> specifying ADC channels.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Hi Dmitry,

How do you want this applied? I can take it through IIO if you like but
I'm not sure if that will cause trouble for other dts patches in flight.

I'm fine with it going via another tree though and don't expect
to see any clashes. If so.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml      |  2 +-
>  .../bindings/thermal/qcom-spmi-adc-tm5.yaml   |  4 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  2 +-
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  2 +-
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |  4 +-
>  .../boot/dts/qcom/sm7225-fairphone-fp4.dts    |  2 +-
>  .../dt-bindings/iio/qcom,spmi-adc7-pmk8350.h  | 52 +++++++++----------
>  7 files changed, 32 insertions(+), 36 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> index bd6e0d6f6e0c..df317901e7d0 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> @@ -293,7 +293,7 @@ examples:
>  
>              /* Other properties are omitted */
>              xo-therm@44 {
> -                reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
> +                reg = <PMK8350_ADC7_AMUX_THM1_100K_PU(0)>;
>                  qcom,ratiometric;
>                  qcom,hw-settle-time = <200>;
>              };
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> index 52ec18cf1eda..ff07d27775dc 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> @@ -218,7 +218,7 @@ examples:
>  
>              /* Other properties are omitted */
>              xo-therm@44 {
> -                reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
> +                reg = <PMK8350_ADC7_AMUX_THM1_100K_PU(0)>;
>                  qcom,ratiometric;
>                  qcom,hw-settle-time = <200>;
>              };
> @@ -240,7 +240,7 @@ examples:
>  
>              pmk8350-xo-therm@0 {
>                  reg = <0>;
> -                io-channels = <&pmk8350_vadc PMK8350_ADC7_AMUX_THM1_100K_PU>;
> +                io-channels = <&pmk8350_vadc PMK8350_ADC7_AMUX_THM1_100K_PU(0)>;
>                  qcom,decimation = <340>;
>                  qcom,ratiometric;
>                  qcom,hw-settle-time-us = <200>;
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 5dc9bee28e7f..14c9bdaa46ed 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -433,7 +433,7 @@ &pcie1_phy {
>  
>  &pmk8350_vadc {
>  	pmk8350-die-temp@3 {
> -		reg = <PMK8350_ADC7_DIE_TEMP>;
> +		reg = <PMK8350_ADC7_DIE_TEMP(0)>;
>  		label = "pmk8350_die_temp";
>  		qcom,pre-scaling = <1 1>;
>  	};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> index cb0cc2ba2fa3..e3919e074ebd 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> @@ -389,7 +389,7 @@ &pm8350c_pwm {
>  
>  &pmk8350_vadc {
>  	pmk8350-die-temp@3 {
> -		reg = <PMK8350_ADC7_DIE_TEMP>;
> +		reg = <PMK8350_ADC7_DIE_TEMP(0)>;
>  		label = "pmk8350_die_temp";
>  		qcom,pre-scaling = <1 1>;
>  	};
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index 46c7fdafb840..590400985055 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -824,13 +824,13 @@ &pmk8280_vadc {
>  	status = "okay";
>  
>  	pmic-die-temp@3 {
> -		reg = <PMK8350_ADC7_DIE_TEMP>;
> +		reg = <PMK8350_ADC7_DIE_TEMP(0)>;
>  		qcom,pre-scaling = <1 1>;
>  		label = "pmk8350_die_temp";
>  	};
>  
>  	xo-therm@44 {
> -		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
> +		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU(0)>;
>  		qcom,hw-settle-time = <200>;
>  		qcom,ratiometric;
>  		label = "pmk8350_xo_therm";
> diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> index 7ae6aba5d2ec..af6cf4fbddc7 100644
> --- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> +++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> @@ -516,7 +516,7 @@ &pmk8350_rtc {
>  
>  &pmk8350_vadc {
>  	adc-chan@644 {
> -		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
> +		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU(0)>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
>  		qcom,pre-scaling = <1 1>;
> diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h b/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
> index 6c296870e95b..ca85a2d69453 100644
> --- a/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
> +++ b/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
> @@ -6,41 +6,37 @@
>  #ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PMK8350_H
>  #define _DT_BINDINGS_QCOM_SPMI_VADC_PMK8350_H
>  
> -#ifndef PMK8350_SID
> -#define PMK8350_SID					0
> -#endif
> -
>  /* ADC channels for PMK8350_ADC for PMIC7 */
> -#define PMK8350_ADC7_REF_GND			(PMK8350_SID << 8 | 0x0)
> -#define PMK8350_ADC7_1P25VREF			(PMK8350_SID << 8 | 0x01)
> -#define PMK8350_ADC7_VREF_VADC			(PMK8350_SID << 8 | 0x02)
> -#define PMK8350_ADC7_DIE_TEMP			(PMK8350_SID << 8 | 0x03)
> +#define PMK8350_ADC7_REF_GND(sid)			((sid) << 8 | 0x0)
> +#define PMK8350_ADC7_1P25VREF(sid)			((sid) << 8 | 0x01)
> +#define PMK8350_ADC7_VREF_VADC(sid)			((sid) << 8 | 0x02)
> +#define PMK8350_ADC7_DIE_TEMP(sid)			((sid) << 8 | 0x03)
>  
> -#define PMK8350_ADC7_AMUX_THM1			(PMK8350_SID << 8 | 0x04)
> -#define PMK8350_ADC7_AMUX_THM2			(PMK8350_SID << 8 | 0x05)
> -#define PMK8350_ADC7_AMUX_THM3			(PMK8350_SID << 8 | 0x06)
> -#define PMK8350_ADC7_AMUX_THM4			(PMK8350_SID << 8 | 0x07)
> -#define PMK8350_ADC7_AMUX_THM5			(PMK8350_SID << 8 | 0x08)
> +#define PMK8350_ADC7_AMUX_THM1(sid)			((sid) << 8 | 0x04)
> +#define PMK8350_ADC7_AMUX_THM2(sid)			((sid) << 8 | 0x05)
> +#define PMK8350_ADC7_AMUX_THM3(sid)			((sid) << 8 | 0x06)
> +#define PMK8350_ADC7_AMUX_THM4(sid)			((sid) << 8 | 0x07)
> +#define PMK8350_ADC7_AMUX_THM5(sid)			((sid) << 8 | 0x08)
>  
>  /* 30k pull-up1 */
> -#define PMK8350_ADC7_AMUX_THM1_30K_PU		(PMK8350_SID << 8 | 0x24)
> -#define PMK8350_ADC7_AMUX_THM2_30K_PU		(PMK8350_SID << 8 | 0x25)
> -#define PMK8350_ADC7_AMUX_THM3_30K_PU		(PMK8350_SID << 8 | 0x26)
> -#define PMK8350_ADC7_AMUX_THM4_30K_PU		(PMK8350_SID << 8 | 0x27)
> -#define PMK8350_ADC7_AMUX_THM5_30K_PU		(PMK8350_SID << 8 | 0x28)
> +#define PMK8350_ADC7_AMUX_THM1_30K_PU(sid)		((sid) << 8 | 0x24)
> +#define PMK8350_ADC7_AMUX_THM2_30K_PU(sid)		((sid) << 8 | 0x25)
> +#define PMK8350_ADC7_AMUX_THM3_30K_PU(sid)		((sid) << 8 | 0x26)
> +#define PMK8350_ADC7_AMUX_THM4_30K_PU(sid)		((sid) << 8 | 0x27)
> +#define PMK8350_ADC7_AMUX_THM5_30K_PU(sid)		((sid) << 8 | 0x28)
>  
>  /* 100k pull-up2 */
> -#define PMK8350_ADC7_AMUX_THM1_100K_PU		(PMK8350_SID << 8 | 0x44)
> -#define PMK8350_ADC7_AMUX_THM2_100K_PU		(PMK8350_SID << 8 | 0x45)
> -#define PMK8350_ADC7_AMUX_THM3_100K_PU		(PMK8350_SID << 8 | 0x46)
> -#define PMK8350_ADC7_AMUX_THM4_100K_PU		(PMK8350_SID << 8 | 0x47)
> -#define PMK8350_ADC7_AMUX_THM5_100K_PU		(PMK8350_SID << 8 | 0x48)
> +#define PMK8350_ADC7_AMUX_THM1_100K_PU(sid)		((sid) << 8 | 0x44)
> +#define PMK8350_ADC7_AMUX_THM2_100K_PU(sid)		((sid) << 8 | 0x45)
> +#define PMK8350_ADC7_AMUX_THM3_100K_PU(sid)		((sid) << 8 | 0x46)
> +#define PMK8350_ADC7_AMUX_THM4_100K_PU(sid)		((sid) << 8 | 0x47)
> +#define PMK8350_ADC7_AMUX_THM5_100K_PU(sid)		((sid) << 8 | 0x48)
>  
>  /* 400k pull-up3 */
> -#define PMK8350_ADC7_AMUX_THM1_400K_PU		(PMK8350_SID << 8 | 0x64)
> -#define PMK8350_ADC7_AMUX_THM2_400K_PU		(PMK8350_SID << 8 | 0x65)
> -#define PMK8350_ADC7_AMUX_THM3_400K_PU		(PMK8350_SID << 8 | 0x66)
> -#define PMK8350_ADC7_AMUX_THM4_400K_PU		(PMK8350_SID << 8 | 0x67)
> -#define PMK8350_ADC7_AMUX_THM5_400K_PU		(PMK8350_SID << 8 | 0x68)
> +#define PMK8350_ADC7_AMUX_THM1_400K_PU(sid)		((sid) << 8 | 0x64)
> +#define PMK8350_ADC7_AMUX_THM2_400K_PU(sid)		((sid) << 8 | 0x65)
> +#define PMK8350_ADC7_AMUX_THM3_400K_PU(sid)		((sid) << 8 | 0x66)
> +#define PMK8350_ADC7_AMUX_THM4_400K_PU(sid)		((sid) << 8 | 0x67)
> +#define PMK8350_ADC7_AMUX_THM5_400K_PU(sid)		((sid) << 8 | 0x68)
>  
>  #endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PMK8350_H */

