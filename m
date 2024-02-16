Return-Path: <linux-iio+bounces-2601-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCD4857AB9
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 11:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 938C6B235D3
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 10:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6D853E23;
	Fri, 16 Feb 2024 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jJM3HooL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498F7535D3
	for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708080790; cv=none; b=dVAc1wPc+7hphgGFRJSrt5VxPgt6l7HsiRC9rQoiLelVq41+s61b2suQ6VsQNTPUakil1oLmrButJyfFHZjxWXP6qFR4YLP+I7/P9gukqwT4Qf7TXgyFlYqtGQ3scOW12CjiJ/jp5vX2SWI4//6LvEXPNyCtSUIF14qbPxC/fTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708080790; c=relaxed/simple;
	bh=CKeqK7r21z+uPoTSQI7hi75/5L38DmdQ+4Di0ez1Hfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1qI9pMoXGH6jb6ImfL6DCHEqcU8bwKBCJXqbx1/rWl17x77RLO8ACvagCq3ivoswgdjYwDQtT2xwyyRgdaXMlNcIRvR2GxKV3F+m82U6w0B9qxIuLOE7mPMt+RMHPEsxnT66Hsj13ZEfpXUjb3/bbj1+wjx09MdTtGHjMjIM8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jJM3HooL; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60495209415so18910137b3.3
        for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 02:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708080787; x=1708685587; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ioR+BOs7uNOZSKUh7axRAHAnr83qTLsDoKudE97KbMw=;
        b=jJM3HooLwkn2H1mqigw6VZrmWs3Xh1/KDmQ8UtEbdjQJJOvQN++nURpmn2sSRXcPz3
         slv1EEuNtSQKkZtgHdVE/4thAaDKKRITlQVCe+FeYZXZe9q3foGLxpJFxMV/sRZMb17N
         b6Gb43Ynlu83+LOuxqEQZ41DXfc5snKR3bbKFfKsHXUSshNZeDrGAGZRLfOAVtqJWU95
         BrGVn4vSdB4URDV8CMMJl+NSmObgD87blftM5utBxKV5j96h26pp8+rTRk5cGfaxd22l
         qg0tlIMg2MIE6igc006ezEnqHD8owJkxoKH7HB/0Sm6Uo8rsHYrYMGeEf1BPeJpzoTqE
         y5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708080787; x=1708685587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ioR+BOs7uNOZSKUh7axRAHAnr83qTLsDoKudE97KbMw=;
        b=R+2yTM2+2l1lqHYoxIULpmCH4ZHuAqqy7STthsd1R6R4EwpTTXqkeqmaxbbzENSBTx
         uUllS5Xp2iGR3KtC+I8kaG60fi25Ac7ua+nO4JTseAdwgPwONIKxBRd/muHrii/YTq1x
         T2535kEU6vzb29BrwCaXs70tIQ/TEp4BfFvLUX+Xh9Y9oxYyaBH2Qj53ZAgi4COn+tgs
         Thi1sXH9TXaj+7rElTBuB8wpvZbTixTBe36AdPPGMmy9+SDsE52luJMqFVuna2KquImW
         BWFlW0vEoBCph2amELsdH5oJpK4i2LnoBxQ64WR3lwLgKRKVNCOfLp49Bl0zTrwAy9+q
         PR+w==
X-Forwarded-Encrypted: i=1; AJvYcCUIcQ4ghNHPeaq/IlBvPbsjgLB1q93MDvnr7Nh7PMfXy/QX35MqbUImJjyESQw4jOJhQs+Z6W4nbajwp4KgNRKMX/c/0s+tBa5w
X-Gm-Message-State: AOJu0YyQF/W5DQP96E0iY72J8k4oI4W89OqV8ISSGmZJH3omAISv/RSA
	HxkyCKhlDJXkBciJrWn0zxLW5BpaWJ1J7kIFTGUfRX9+K+rPuPSWq3rCAfZ30HRqbY+sqtfO02p
	6RFBz7ISe1Oh+u5dmiehaLmKraSJpf1qDF9ObCA==
X-Google-Smtp-Source: AGHT+IF6mDt5/CS2sOkoqfhoq2OHammoZd8ApmMAVQUfXDA+m1cqykxx6MqPGLglZXNugNWMysOIOFZXv4WUOEk3XEQ=
X-Received: by 2002:a0d:ccd8:0:b0:607:81e6:e320 with SMTP id
 o207-20020a0dccd8000000b0060781e6e320mr4287942ywd.16.1708080787250; Fri, 16
 Feb 2024 02:53:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231231171237.3322376-1-quic_jprakash@quicinc.com>
 <20231231171237.3322376-4-quic_jprakash@quicinc.com> <CAA8EJpr4q7pFF44oUjJSWGYKgiUCB_23zVHw6J3a3mwn7cKgyg@mail.gmail.com>
 <e5a5b32c-bc9d-42b7-b1a8-90e22b957915@quicinc.com>
In-Reply-To: <e5a5b32c-bc9d-42b7-b1a8-90e22b957915@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 16 Feb 2024 12:52:56 +0200
Message-ID: <CAA8EJppLZO4zCSDpQskygfm738y=m8BofCR8=3nQEjjggtigUg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
To: Jishnu Prakash <quic_jprakash@quicinc.com>
Cc: jic23@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, 
	lee@kernel.org, andriy.shevchenko@linux.intel.com, daniel.lezcano@linaro.org, 
	lars@metafoo.de, luca@z3ntu.xyz, marijn.suijten@somainline.org, 
	agross@kernel.org, sboyd@kernel.org, rafael@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linus.walleij@linaro.org, quic_subbaram@quicinc.com, 
	quic_collinsd@quicinc.com, quic_amelende@quicinc.com, quic_kamalw@quicinc.com, 
	kernel@quicinc.com, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, cros-qcom-dts-watchers@chromium.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Feb 2024 at 15:58, Jishnu Prakash <quic_jprakash@quicinc.com> wrote:
>
> Hi Dmitry,
>
> On 12/31/2023 11:16 PM, Dmitry Baryshkov wrote:
> > On Sun, 31 Dec 2023 at 19:13, Jishnu Prakash <quic_jprakash@quicinc.com> wrote:
> >> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
> >> with all SW communication to ADC going through PMK8550 which
> >> communicates with other PMICs through PBS.
>
> >> +static int adc_tm_register_tzd(struct adc5_chip *adc)
> >> +{
> >> +       unsigned int i, channel;
> >> +       struct thermal_zone_device *tzd;
> >> +
> >> +       for (i = 0; i < adc->nchannels; i++) {
> >> +               channel = V_CHAN(adc->chan_props[i]);
> >> +
> >> +               if (!adc->chan_props[i].adc_tm)
> >> +                       continue;
> >> +               tzd = devm_thermal_of_zone_register(adc->dev, channel,
> >> +                       &adc->chan_props[i], &adc_tm_ops);
> > It is _very_ useful to register a hwmon too by calling
> > devm_thermal_add_hwmon_sysfs(). However this becomes tricky, as this
> > function is not defined in one of the global headers.
> >
> > This actually points out an issue. You have the ADC driver fused
> > together with the thermal driver. Can I suggest using the aux device
> > to split the thermal functionality to the separate driver?
> >
> > This way it would be possible to use the ADC without any thermal
> > monitoring in place.
>
>
> There are a couple of issues which may make it harder to split the
> thermal functionality from this driver into an auxiliary driver as you
> mentioned.
>
> For one, we use the same set of registers (offsets 0x4f-0x55) for both
> VADC function(requesting an immediate channel reading) and ADC_TM
> function (setting upper/lower thermal thresholds on a channel). To avoid
> any race conditions, we would need to share a mutex between the
> top-level ADC driver and the auxiliary ADC_TM thermal driver to avoid
> concurrently accessing these or any other shared registers.

Just export an API performing this access. No need to export data (aka mutex).

>
> In addition, the device has only one interrupt with one interrupt
> handler, and it gets triggered for both VADC and ADC_TM  events (end of
> conversion and threshold violation, respectively). The handler checks
> for both types of event and handles it as required.

You can extend auxiliary drivers with the custom callbacks, see
drivers/base/auxiliary.c .
I think you can call a callback from ADC_TM driver from your ADC driver.

>
> For the shared interrupt, we may be able to keep the interrupt handler
> in the top-level driver and just notify the auxiliary TM driver if a
> threshold violation is detected. For the shared mutex, I think the
> auxiliary driver may be able to access the parent driver's mutex, but
> I'll need to check more for the implementation in both of these cases.
>
> Please let me know if you see any problems with this kind of
> implementation or if you have any additional comments.
>
> Thanks,
>
> Jishnu
>
> >> +
> >> +               if (IS_ERR(tzd)) {
> >> +                       if (PTR_ERR(tzd) == -ENODEV) {
> >> +                               dev_warn(adc->dev, "thermal sensor on channel %d is not used\n",
> >> +                                        channel);
> >> +                               continue;
> >> +                       }
> >> +
> >>
> >



-- 
With best wishes
Dmitry

