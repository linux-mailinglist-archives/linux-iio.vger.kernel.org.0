Return-Path: <linux-iio+bounces-97-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D107EDBB3
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 07:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA342280F43
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 06:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FDB8F6A;
	Thu, 16 Nov 2023 06:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZjqKNQyA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9907135
	for <linux-iio@vger.kernel.org>; Wed, 15 Nov 2023 22:58:15 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a82c2eb50cso4733067b3.2
        for <linux-iio@vger.kernel.org>; Wed, 15 Nov 2023 22:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700117895; x=1700722695; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MlUMs5yfeQyYc6Y/Az4rq8fO2Clnbz+XnVMEINfcjBg=;
        b=ZjqKNQyA7ZGNBR3j9PgeXKjjIp9NWNkFanm1n5QS8qQvLfiQhTEjaf4eecVWToiR/e
         56mGrilKtR8gn4upU0ozDSwGqgyji07jFUrzM4RUk1Ntk2KN1jmvYiE5V8e4B/w1z4Sg
         jTAoO8C+F44z2oBFF5ForQkRy/mSacdMkz1XMqgwGLIvhLhOjMOTsbZF35amGlIsL9uf
         w806z+ZCx/3YKKmW3QDcJyBqF77lkl3gvJ436meBQTVexGfZE6D6cw/ErU1KkqiCiFR3
         j47HQgczBT82sUfkDUBYW1rEM/qs0SjJe0VPIqoFqzgIerQ+4yms+OlufpxjGFAzgru1
         EhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700117895; x=1700722695;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MlUMs5yfeQyYc6Y/Az4rq8fO2Clnbz+XnVMEINfcjBg=;
        b=jI+nJ81VHmbVnjOH95PTdmaTS9ACGC1vhgITDSFlvWX7cZowZc/pGgQtVvwgatnNzl
         mJGYQJsdm0DvvtS9OGKW3Xt6NdKfvzN38KxaE/vIPhptj4B5KrepOZe7XC12wcONSyUQ
         mPXWKDjnbNmAp+7wobo03Levilno04N77fwhPBIygm9BP1nufly4vj8y+aVqMgh6aY55
         cX3niZ3obsnR4aeL1BvVev5Da7SdnfWIfReXkJeUtk3S8yinoi/t1H5t635DiXWtCqF1
         3SFZJ9cn1AkKN957mv+LuAvC+KErwKJqIgYkHaktKksuUktOIyZYEXATTu2SYg3d6Q57
         kFqg==
X-Gm-Message-State: AOJu0YwO1USXiX0z+ziKZn1Y5H17+N3gMHkcTN9iTkrXBJJa685+N+31
	iKlTnJm8ejmB4uvPxXes1O6gHbOZkxGEiIday8Qw9Q==
X-Google-Smtp-Source: AGHT+IHve10MyqU2Jd1eMdvWSqrn1JhntSzmwKDJMgvOkWsqcxLkFxnFE4uOgoNAIt4GNReGlfE8m8apQkiSaQ9ingg=
X-Received: by 2002:a0d:ea85:0:b0:5a7:e4d9:f091 with SMTP id
 t127-20020a0dea85000000b005a7e4d9f091mr13004592ywe.25.1700117894941; Wed, 15
 Nov 2023 22:58:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116032530.753192-1-quic_jprakash@quicinc.com>
 <CAA8EJprJuiFq5UXc9weNr1hy2vW_10TaQweN_ZW5XW=3LKrgtA@mail.gmail.com> <5a476b51-5916-74f8-0395-60d94f210aa0@quicinc.com>
In-Reply-To: <5a476b51-5916-74f8-0395-60d94f210aa0@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 16 Nov 2023 08:58:03 +0200
Message-ID: <CAA8EJpq+2cu4pyWRGm_DVQe7_6NJAssT=HWD6UieyXkAgncwMA@mail.gmail.com>
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

On Thu, 16 Nov 2023 at 08:30, Jishnu Prakash <quic_jprakash@quicinc.com> wrote:
>
> Hi Dmitry,
>
> On 11/16/2023 10:52 AM, Dmitry Baryshkov wrote:
> > On Thu, 16 Nov 2023 at 05:26, Jishnu Prakash <quic_jprakash@quicinc.com> wrote:
> >> PMIC5 Gen3 has a similar ADC architecture to that on PMIC5 Gen2,
> >> with all SW communication to ADC going through PMK8550 which
> >> communicates with other PMICs through PBS. The major difference is
> >> that the register interface used here is that of an SDAM present on
> >> PMK8550, rather than a dedicated ADC peripheral. There may be more than one
> >> SDAM used for ADC5 Gen3. Each ADC SDAM has eight channels, each of which may
> >> be used for either immediate reads (same functionality as previous PMIC5 and
> >> PMIC5 Gen2 ADC peripherals) or recurring measurements (same as PMIC5 and PMIC5
> >> Gen2 ADC_TM functionality). In this case, we have VADC and ADC_TM functionality
> >> combined into the same driver.
> >>
> >> Patches 1 adds bindings for ADC5 Gen3 peripheral.
> >>
> >> Patches 2 adds driver support for ADC5 Gen3.
> > For some reason I don't see this patch in my inbox. Maybe it will
> > arrive later. Immediate response: please add
> > devm_thermal_add_hwmon_sysfs().
>
>
> Yes, I'll check and add this in the next patch series, I'll wait for
> some more comments on the existing patches for now.
>
> I ran into some error after sending the first two mails (cover letter
> and patch 1), so I sent patches 2 and 3 separately after it, I think you
> may have received them separately.
>
>
> >
> >> Patch 3 is a cleanup, to move the QCOM ADC dt-bindings files from
> >> dt-bindings/iio to dt-bindings/iio/adc folder, as they are
> >> specifically for ADC devices. It also fixes all compilation errors
> >> with this change in driver and devicetree files and similar errors
> >> in documentation for dtbinding check.
> > NAK. The kernel is expected to build and work after each commit.
> > Otherwise git-bisecting the kernel becomes impossible.
> > So, please rework your series in a way that there are no compilation
> > errors after any of the patches. The easiest way would be to rearrange
> > your patches in 3-1-2 order.
>
>
> I think you may have misunderstood the meaning here, I had verified
> compilation works each time after applying each of the three patches in
> this series. It's not that this last patch fixes compilation errors
> caused by the first two, this is a completely separate patch which
> affects existing QCOM ADC code (driver and devicetree) including ADC5 Gen3.
>
>
> This patch does two things mainly:
>
> Move the ADC binding files from dt-bindings/iio folder to
> dt-bindings/iio/adc folder (this would naturally cause some errors in
> driver and devicetree code due to path update)
>
> Fix all compilation and dtbinding errors generated by the move
>
>
> I added this change at the end of the series as I was not completely
> sure if it could get picked, just wanted to make it easier to drop if
> that is the final decision.

Ah, so patch 1 adds new files to <dt-bindings/iio/adc>, while
retaining old files in the old directory. I'd say, this is
counterintuitive.
Please reorder patches into 3-1-2 order. dt-binding changes anyway
should come first.

>
>
> Thanks,
>
> Jishnu
>
>
> >
> >
> >> Changes since v1:
> >> - Dropped patches 1-5 for changing 'ADC7' peripheral name to 'ADC5 Gen2'.
> >> - Addressed reviewer comments for binding and driver patches for ADC5 Gen3.
> >> - Combined patches 8-11 into a single patch as requested by reviewers to make
> >>    the change clearer and made all fixes required in same patch.
> >>
> >>   .../iio/{ => adc}/qcom,spmi-adc7-pm8350b.h    |    2 +-
> >>   .../iio/{ => adc}/qcom,spmi-adc7-pmk8350.h    |    2 +-
> >>   .../iio/{ => adc}/qcom,spmi-adc7-pmr735a.h    |    2 +-
> >>   .../iio/{ => adc}/qcom,spmi-adc7-pmr735b.h    |    0
> >>   .../iio/{ => adc}/qcom,spmi-vadc.h            |   81 ++
> >>   46 files changed, 1725 insertions(+), 61 deletions(-)
> >>   create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
> >>   create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h
> >>   create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h
> >>   create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h
> >>   create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h
> >>   rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h (98%)
> >>   rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h (99%)
> >>   rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h (97%)
> >>   rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h (95%)
> >>   rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h (100%)
> >>   rename include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h (77%)
> >>
> >> --
> >> 2.25.1
> >>
> >
> > --
> > With best wishes
> > Dmitry



-- 
With best wishes
Dmitry

