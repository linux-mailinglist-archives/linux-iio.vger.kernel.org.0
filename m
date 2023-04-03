Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A1C6D3D5C
	for <lists+linux-iio@lfdr.de>; Mon,  3 Apr 2023 08:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjDCGbs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Apr 2023 02:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjDCGbr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2023 02:31:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EF1D52B;
        Sun,  2 Apr 2023 23:31:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5058614F5;
        Mon,  3 Apr 2023 06:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243EAC433EF;
        Mon,  3 Apr 2023 06:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680503503;
        bh=i8cq8H4Yhw1CAAarD0GVgGxvxr3tNkVZXqgsXfxngYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u4cYoVxSOhOfhTpWPKpbOBVRgTIJqWOhnbnVJl9YmnirdokLMeggLXfs9zcBoPeC/
         NU0V4hF+sufLI1eU9Az7+F+EiH5PEbuC/ZXg9YinnX2Hng2VyAc0R98yq3KYnvjmKt
         o6839xRuPf13GmSk2W+YLAfKzOXywqtuxVRLvwlk5JESfop0foME+5G/4TKdcujnJ0
         UxNDt1zAYokIkrAVT3zO1CF7sAV2IT8VozWY8TSgurBZ8ltCgVsxC90I23OwbFYxdP
         2/39ptU+iuKnpBjjzkNXSLV6juY9f+vfAkfCb+1rtEbPkk5DM5jyN95lcc/Mohqc9C
         WZ6IQGWIFKUwg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pjDjZ-0004o9-NJ; Mon, 03 Apr 2023 08:32:06 +0200
Date:   Mon, 3 Apr 2023 08:32:05 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 03/22] arm64: dts: qcom: sc8280xp-pmics: use pmk8350
 specifics for pon device
Message-ID: <ZCpy5TUWacjtVo05@hovoldconsulting.com>
References: <20230401220810.3563708-1-dmitry.baryshkov@linaro.org>
 <20230401220810.3563708-4-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401220810.3563708-4-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 02, 2023 at 01:07:51AM +0300, Dmitry Baryshkov wrote:
> Following the commit c0ee8e0ba5cc ("arm64: dts: qcom: pmk8350: Use the
> correct PON compatible") and commit f46ef374e0dc ("arm64: dts: qcom:
> pmk8350: Specify PBS register for PON") use "qcom,pmk8350-pon" compat
> string and add RBS region to the PON device.
> 
> Fixes: ccd3517faf18 ("arm64: dts: qcom: sc8280xp: Add reference device")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

I already sent a fix for this last Monday:

	https://lore.kernel.org/all/20230327122948.4323-1-johan+linaro@kernel.org/

> ---
>  arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> index c35e7f6bd657..a3c7369f9594 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> @@ -59,8 +59,8 @@ pmk8280: pmic@0 {
>  		#size-cells = <0>;
>  
>  		pmk8280_pon: pon@1300 {
> -			compatible = "qcom,pm8998-pon";
> -			reg = <0x1300>;
> +			compatible = "qcom,pmk8350-pon";
> +			reg = <0x1300>, <0x800>;

This is missing 'reg-names'.

>  
>  			pmk8280_pon_pwrkey: pwrkey {
>  				compatible = "qcom,pmk8350-pwrkey";

Johan
