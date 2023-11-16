Return-Path: <linux-iio+bounces-95-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150707EDB28
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 06:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA864280FC7
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 05:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B640FCA57;
	Thu, 16 Nov 2023 05:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JhIwLMaw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BBC1B2
	for <linux-iio@vger.kernel.org>; Wed, 15 Nov 2023 21:22:50 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a822f96aedso4420207b3.2
        for <linux-iio@vger.kernel.org>; Wed, 15 Nov 2023 21:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700112169; x=1700716969; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LGsBAN5f4HBD1+0b849nw4eGgZQCAWEgA8RzzOxSqRw=;
        b=JhIwLMaw0M1imVxrf1UhxrMGCD5PbCZi6hZ6sP88QYhpJCSAXkJhn1ekLlj/AWm91L
         5j78EPXcc3dmOu5DZFEqocpLkMITSwC0yPF20AgfWStkPAZcmpgNSZuveWYewufHm2jv
         YFOTbbbzvgC9GXhsUocrlX3zuFRZGrLVOS6FFKa+B/ni0HqR4koRgF9x98KECcuwBxHr
         G54yJ30FSdlTzhrusFB7OhvDvwT82mHYIEvmg83iAMS97tbQyibOlF27PG2eFoH9WN9N
         dZ4Wx3N2HkdEL+i9sqDhcK6ZrXURoOTONpITr5hM7RTptCghCAQGUf/ceTpCRiEEbnU8
         ry0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700112169; x=1700716969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LGsBAN5f4HBD1+0b849nw4eGgZQCAWEgA8RzzOxSqRw=;
        b=uLoClkOElxFNJzy/CGOpFTfIDRcyk4MDTo21hQY+Xpt4EzxTnzYsm8H/7H+yNaX9Vi
         CrdkycTiEWdb89mv84LMOHyhCbxR0IFqzw8oeINPOMpuQ6e9hyumeQu0uAD32Caf2iIg
         iS3/fm/5sEJ3oOPoXWjxx8Y0c1u4cqMdyBucQrcgD1nm13rQhU4Xqqo65FLJKmHpG1pU
         vuNjujn3nCtG8C7T3J38tw4DQpd4H13P+KP/GQD1aZBmTGZv0Pp1m74KTojggoerLWuZ
         7CJl9eG9whodK7rqqPZzUaNXu3I/XqFt6bSQoqn2/TBGun9TEGq1G5xqmgXj2k0mSe8B
         xtrw==
X-Gm-Message-State: AOJu0YyXUxtsIEPnEGGJS1/ltx+/NVDVNChf9eo/zesSE6KOKdxrfKKL
	RJGgba6/Huwlm9GKiNOMz73oqOAv/h7+9juiiNWBfg==
X-Google-Smtp-Source: AGHT+IHOEGWz3HtHd55pmB8Pv/nh+WGNRTsulQJPMzCPy94SaZI4yFMTydBgtiZ2E7PmosNQDdKzcq7XzPXgnedovC0=
X-Received: by 2002:a0d:d502:0:b0:5b3:f5f8:c5c7 with SMTP id
 x2-20020a0dd502000000b005b3f5f8c5c7mr16117676ywd.18.1700112169345; Wed, 15
 Nov 2023 21:22:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116032530.753192-1-quic_jprakash@quicinc.com>
In-Reply-To: <20231116032530.753192-1-quic_jprakash@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 16 Nov 2023 07:22:38 +0200
Message-ID: <CAA8EJprJuiFq5UXc9weNr1hy2vW_10TaQweN_ZW5XW=3LKrgtA@mail.gmail.com>
Subject: Re: [PATCH V2 0/3] iio: adc: Add support for QCOM SPMI PMIC5 Gen3 ADC
To: Jishnu Prakash <quic_jprakash@quicinc.com>
Cc: jic23@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org, 
	konrad.dybcio@linaro.org, daniel.lezcano@linaro.org, linus.walleij@linaro.org, 
	linux-arm-msm@vger.kernel.org, andriy.shevchenko@linux.intel.com, 
	quic_subbaram@quicinc.com, quic_collinsd@quicinc.com, 
	quic_amelende@quicinc.com, quic_kamalw@quicinc.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	marijn.suijten@somainline.org, lars@metafoo.de, luca@z3ntu.xyz, 
	linux-iio@vger.kernel.org, lee@kernel.org, rafael@kernel.org, 
	rui.zhang@intel.com, lukasz.luba@arm.com, cros-qcom-dts-watchers@chromium.org, 
	sboyd@kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-msm-owner@vger.kernel.org, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Nov 2023 at 05:26, Jishnu Prakash <quic_jprakash@quicinc.com> wrote:
>
> PMIC5 Gen3 has a similar ADC architecture to that on PMIC5 Gen2,
> with all SW communication to ADC going through PMK8550 which
> communicates with other PMICs through PBS. The major difference is
> that the register interface used here is that of an SDAM present on
> PMK8550, rather than a dedicated ADC peripheral. There may be more than one
> SDAM used for ADC5 Gen3. Each ADC SDAM has eight channels, each of which may
> be used for either immediate reads (same functionality as previous PMIC5 and
> PMIC5 Gen2 ADC peripherals) or recurring measurements (same as PMIC5 and PMIC5
> Gen2 ADC_TM functionality). In this case, we have VADC and ADC_TM functionality
> combined into the same driver.
>
> Patches 1 adds bindings for ADC5 Gen3 peripheral.
>
> Patches 2 adds driver support for ADC5 Gen3.

For some reason I don't see this patch in my inbox. Maybe it will
arrive later. Immediate response: please add
devm_thermal_add_hwmon_sysfs().

>
> Patch 3 is a cleanup, to move the QCOM ADC dt-bindings files from
> dt-bindings/iio to dt-bindings/iio/adc folder, as they are
> specifically for ADC devices. It also fixes all compilation errors
> with this change in driver and devicetree files and similar errors
> in documentation for dtbinding check.

NAK. The kernel is expected to build and work after each commit.
Otherwise git-bisecting the kernel becomes impossible.
So, please rework your series in a way that there are no compilation
errors after any of the patches. The easiest way would be to rearrange
your patches in 3-1-2 order.


>
> Changes since v1:
> - Dropped patches 1-5 for changing 'ADC7' peripheral name to 'ADC5 Gen2'.
> - Addressed reviewer comments for binding and driver patches for ADC5 Gen3.
> - Combined patches 8-11 into a single patch as requested by reviewers to make
>   the change clearer and made all fixes required in same patch.
>
> Jishnu Prakash (3):
>   dt-bindings: iio: adc: Add QCOM PMIC5 Gen3 ADC bindings
>   iio: adc: Add support for QCOM PMIC5 Gen3 ADC
>   dt-bindings: iio/adc: Move QCOM ADC bindings to iio/adc folder
>
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml      |  185 ++-
>  .../bindings/mfd/qcom,spmi-pmic.yaml          |    2 +-
>  .../bindings/thermal/qcom-spmi-adc-tm-hc.yaml |    2 +-
>  .../bindings/thermal/qcom-spmi-adc-tm5.yaml   |    6 +-
>  arch/arm64/boot/dts/qcom/pm2250.dtsi          |    2 +-
>  arch/arm64/boot/dts/qcom/pm6125.dtsi          |    2 +-
>  arch/arm64/boot/dts/qcom/pm6150.dtsi          |    2 +-
>  arch/arm64/boot/dts/qcom/pm6150l.dtsi         |    2 +-
>  arch/arm64/boot/dts/qcom/pm660.dtsi           |    2 +-
>  arch/arm64/boot/dts/qcom/pm660l.dtsi          |    2 +-
>  arch/arm64/boot/dts/qcom/pm7250b.dtsi         |    2 +-
>  arch/arm64/boot/dts/qcom/pm8150.dtsi          |    2 +-
>  arch/arm64/boot/dts/qcom/pm8150b.dtsi         |    2 +-
>  arch/arm64/boot/dts/qcom/pm8150l.dtsi         |    2 +-
>  arch/arm64/boot/dts/qcom/pm8916.dtsi          |    2 +-
>  arch/arm64/boot/dts/qcom/pm8950.dtsi          |    2 +-
>  arch/arm64/boot/dts/qcom/pm8953.dtsi          |    2 +-
>  arch/arm64/boot/dts/qcom/pm8994.dtsi          |    2 +-
>  arch/arm64/boot/dts/qcom/pm8998.dtsi          |    2 +-
>  arch/arm64/boot/dts/qcom/pmi632.dtsi          |    2 +-
>  arch/arm64/boot/dts/qcom/pmi8950.dtsi         |    2 +-
>  arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi     |    2 +-
>  arch/arm64/boot/dts/qcom/pmp8074.dtsi         |    2 +-
>  arch/arm64/boot/dts/qcom/pms405.dtsi          |    2 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts       |    2 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |    2 +-
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |    4 +-
>  arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi   |    2 +-
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |    6 +-
>  .../boot/dts/qcom/sm7225-fairphone-fp4.dts    |    2 +-
>  arch/arm64/boot/dts/qcom/sm8450-hdk.dts       |    8 +-
>  drivers/iio/adc/Kconfig                       |   25 +
>  drivers/iio/adc/Makefile                      |    1 +
>  drivers/iio/adc/qcom-spmi-adc5-gen3.c         | 1189 +++++++++++++++++
>  drivers/iio/adc/qcom-spmi-adc5.c              |    2 +-
>  drivers/iio/adc/qcom-spmi-vadc.c              |    2 +-
>  .../iio/adc/qcom,spmi-adc5-gen3-pm8550.h      |   50 +
>  .../iio/adc/qcom,spmi-adc5-gen3-pm8550b.h     |   89 ++
>  .../iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h    |   22 +
>  .../iio/adc/qcom,spmi-adc5-gen3-pmk8550.h     |   56 +
>  .../iio/{ => adc}/qcom,spmi-adc7-pm8350.h     |    2 +-
>  .../iio/{ => adc}/qcom,spmi-adc7-pm8350b.h    |    2 +-
>  .../iio/{ => adc}/qcom,spmi-adc7-pmk8350.h    |    2 +-
>  .../iio/{ => adc}/qcom,spmi-adc7-pmr735a.h    |    2 +-
>  .../iio/{ => adc}/qcom,spmi-adc7-pmr735b.h    |    0
>  .../iio/{ => adc}/qcom,spmi-vadc.h            |   81 ++
>  46 files changed, 1725 insertions(+), 61 deletions(-)
>  create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
>  create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h
>  create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h
>  create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h
>  create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h (98%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h (99%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h (97%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h (95%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h (100%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h (77%)
>
> --
> 2.25.1
>


--
With best wishes
Dmitry

