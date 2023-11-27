Return-Path: <linux-iio+bounces-421-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8267F9B74
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 09:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847441F20C77
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 08:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82158111B4;
	Mon, 27 Nov 2023 08:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjLj4Es8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358AB10785;
	Mon, 27 Nov 2023 08:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9366C433C7;
	Mon, 27 Nov 2023 08:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701072881;
	bh=3qTRy2F6nIzhohgL6U9JKBvv0/WyY8i9YB8Pa1jwqoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HjLj4Es8Qcz0nTYQn5qvj64G45BJZTp09Oq/G8YT0WFtwaBlK4/9G/6sty4THEUQq
	 17ABHg2kuSgGEqBkuDdykyrPL23ayOp112E8QAwGZQRu8ATu9Tni6Cmd9KjibhskGe
	 EBYVsoX6S9VO1XziXK8idk+GeAx+L5ykVZ+qUNJDHLdWuq4LFQLwqgwuBpVk4xJZCS
	 v83tYF5wpwBflqyROjIihArZG4RSYVa1zDJDbTWZ6rx1fU2LbDwEN0x3l5Kl9l7mv9
	 SsWErUG8r0uDCzLug+efrQDwo944+KIqHfzgoPvX9aMt45ava8pradQ9oKKCHkSiT9
	 Dsp9hjAdD3rKA==
Date: Mon, 27 Nov 2023 08:14:32 +0000
From: Lee Jones <lee@kernel.org>
To: Jishnu Prakash <quic_jprakash@quicinc.com>
Cc: jic23@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
	konrad.dybcio@linaro.org, daniel.lezcano@linaro.org,
	dmitry.baryshkov@linaro.org, linus.walleij@linaro.org,
	linux-arm-msm@vger.kernel.org, andriy.shevchenko@linux.intel.com,
	quic_subbaram@quicinc.com, quic_collinsd@quicinc.com,
	quic_amelende@quicinc.com, quic_kamalw@quicinc.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	marijn.suijten@somainline.org, lars@metafoo.de, luca@z3ntu.xyz,
	linux-iio@vger.kernel.org, rafael@kernel.org, rui.zhang@intel.com,
	lukasz.luba@arm.com, cros-qcom-dts-watchers@chromium.org,
	sboyd@kernel.org, linux-pm@vger.kernel.org,
	linux-arm-msm-owner@vger.kernel.org, kernel@quicinc.com
Subject: Re: [PATCH V2 3/3] dt-bindings: iio/adc: Move QCOM ADC bindings to
 iio/adc folder
Message-ID: <20231127081432.GC1470173@google.com>
References: <20231116032644.753370-1-quic_jprakash@quicinc.com>
 <20231116032644.753370-2-quic_jprakash@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231116032644.753370-2-quic_jprakash@quicinc.com>

On Thu, 16 Nov 2023, Jishnu Prakash wrote:

> There are several files containing QCOM ADC macros for channel names
> right now in the include/dt-bindings/iio folder. Since all of these
> are specifically for adc, move the files to the
> include/dt-bindings/iio/adc folder.
> 
> Also update all affected devicetree and driver files to fix compilation
> errors seen with this move and update documentation files to fix
> dtbinding check errors for the same.
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> ---
>  .../devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml       | 4 ++--
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 2 +-

Acked-by: Lee Jones <lee@kernel.org>

>  .../devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml  | 2 +-
>  .../devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml    | 6 +++---
>  arch/arm64/boot/dts/qcom/pm2250.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pm6125.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pm6150.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pm6150l.dtsi                     | 2 +-
>  arch/arm64/boot/dts/qcom/pm660.dtsi                       | 2 +-
>  arch/arm64/boot/dts/qcom/pm660l.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pm7250b.dtsi                     | 2 +-
>  arch/arm64/boot/dts/qcom/pm8150.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pm8150b.dtsi                     | 2 +-
>  arch/arm64/boot/dts/qcom/pm8150l.dtsi                     | 2 +-
>  arch/arm64/boot/dts/qcom/pm8916.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pm8950.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pm8953.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pm8994.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pm8998.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pmi632.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pmi8950.dtsi                     | 2 +-
>  arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi                 | 2 +-
>  arch/arm64/boot/dts/qcom/pmp8074.dtsi                     | 2 +-
>  arch/arm64/boot/dts/qcom/pms405.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts                   | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi                  | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi                | 4 ++--
>  arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi               | 2 +-
>  .../arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 6 +++---
>  arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts         | 2 +-
>  arch/arm64/boot/dts/qcom/sm8450-hdk.dts                   | 8 ++++----
>  drivers/iio/adc/qcom-spmi-adc5-gen3.c                     | 2 +-
>  drivers/iio/adc/qcom-spmi-adc5.c                          | 2 +-
>  drivers/iio/adc/qcom-spmi-vadc.c                          | 2 +-
>  include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h  | 2 +-
>  include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h | 2 +-
>  .../dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h    | 2 +-
>  include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h | 2 +-
>  include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h | 2 +-
>  .../dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h    | 2 +-
>  .../dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h    | 2 +-
>  .../dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h    | 2 +-
>  .../dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h    | 0
>  include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h        | 0
>  44 files changed, 51 insertions(+), 51 deletions(-)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h (98%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h (99%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h (97%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h (95%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h (100%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h (100%)

-- 
Lee Jones [李琼斯]

