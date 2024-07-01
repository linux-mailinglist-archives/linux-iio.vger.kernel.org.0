Return-Path: <linux-iio+bounces-7096-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E8491DAFE
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 11:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83781F22DE7
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 09:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38EE13B59F;
	Mon,  1 Jul 2024 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sNQDlCDE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB6D13C689
	for <linux-iio@vger.kernel.org>; Mon,  1 Jul 2024 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824507; cv=none; b=trwJecQ9nfxAOImQGPyWTktyBI0/hCx0DdbPUGWKuii85IlmM99swURIho6PWpc4t6Z3MYEnIWWyoxIvKgQg/6fYEdD7VmcCqtlEXpjRZt4bFSNIMv5QltU6dF4AiEvrMX8A1SSIZA8rHXVqkhQB9lXNt5KwS5v8JVvL6BV4nPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824507; c=relaxed/simple;
	bh=Uju6MWEqhf0iYZssUD7lpaROMvQMo3bzLgw89T4t81Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S4WbcROlb4KbBNvsqN205YyctdE8AFgfz9oBS34wDn53PrPV/Od/xY390o4YNCclRvU5oemr5VPqCKJ1a4QkZ9FFVyWrUU0N4/FIliEtsbCbbes730YIXyy0ShyWkRkO/Aujixe8CPsa5BzwBx3AzCoaVgk729O5oCGBjidqdwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sNQDlCDE; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52e764bb3fbso3435581e87.3
        for <linux-iio@vger.kernel.org>; Mon, 01 Jul 2024 02:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719824502; x=1720429302; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=E4V4a67sH+Sj9j9mjJSBdp3EdWT5AmAZ/sIsVO2U5Gw=;
        b=sNQDlCDEvrQzVUSTRVnfwpw+TzAnFHZ2iE9gTgvk/P4gAK660DiPoSsd7nAJch8oq8
         cQqnkWk0groQHwx+QdDkSLlm/qmA9nov0eVUPPhGDuFfYpgR3RMAlSOhNe+LynEWAGYL
         UMp6fW/LtFvh9URISmXMBHavJTRzn8GUF+2xS8Qe/UWgHLZu1is9KaSrp0pYlql1YKf2
         U/Sq7cnHRpEJhGgEfBW9uXyBdiR1oJXwkwRixwF/Ed7lP4Irc/x6auvHT+5/rKf4nQgI
         Jab68ogsHmyLHbxB8SAGG52gbumVELqmKRGklUn67RhrwKmUZULyFHnVK0B5FXTdiTzd
         Gg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719824502; x=1720429302;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E4V4a67sH+Sj9j9mjJSBdp3EdWT5AmAZ/sIsVO2U5Gw=;
        b=TJ+5ro6C334Ub+zDB1YREeNI8j7bFPv0yOHn+JUJDED9J+RpeuwA15UiG9bLGstzdU
         P93qGhyPSSYH3wY2sv+SAry5HjQ3HI/JxDJCZ1T7MrIG51APJAohgKHXcoyPo/LxdvkI
         bYBRsBGt4220biq0wzkYGOlt8gjbo2jhHiRK39Yj7khOVpJD7NiEKES+uI4ykIF/C/UA
         703fLtJEXJQZZmTgVD832diz2yrJrfJqgx059WCUvH46ddVzTMGUGiRR3hcljI8TcvB6
         uqYnTs84TCf0EkrQ1h2s1kMZuIK8AUKyT9l/bMRzc1aoLblMvDEo+qotnhxB4/1LBF1+
         ii5w==
X-Forwarded-Encrypted: i=1; AJvYcCV8RfSfYuOzZ6HJ6wJhLWtllyoFCA5FC/czfqTyLcAeqobMaYBpOMTEQpQxCbzo28QpHh5n0QxCD+StxRgIhULHdIifrl3rCd3I
X-Gm-Message-State: AOJu0Yz+9mdEmxMvy4k0No9LLYmaFnLOpBIl4Wet8wbtSAS5KvLx6k6H
	j367e4AuUkCUgOpK19c475sfb197+0o48Pl8faB4xAi1wabDXfS/L5TsXd2R3HQ=
X-Google-Smtp-Source: AGHT+IGQbQF+l6JIu2qBU2qs5wcIrc1fNbnpDVITtS7Qre3SZ8PBndtUb5N/ZdI9xkP9Dwj5YuGUlw==
X-Received: by 2002:a05:6512:3c99:b0:52c:cccf:85e1 with SMTP id 2adb3069b0e04-52e8273cfc0mr3906453e87.65.1719824502302;
        Mon, 01 Jul 2024 02:01:42 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:2d2:df21:c0a8:45a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af55cccsm144287685e9.16.2024.07.01.02.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 02:01:41 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,  Lars-Peter Clausen
 <lars@metafoo.de>,  Kevin Hilman <khilman@baylibre.com>,
  linux-kernel@vger.kernel.org,  linux-amlogic@lists.infradead.org,
  linux-iio@vger.kernel.org,  Rob Herring <robh@kernel.org>,  Krzysztof
 Kozlowski <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,
  linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 0/2] iio: frequency: add iio support for Amlogic clock
 measure
In-Reply-To: <5da26c0e-75a7-4d5a-9eca-f88ecf369996@linaro.org> (Neil
	Armstrong's message of "Mon, 1 Jul 2024 09:41:01 +0200")
References: <20240624173105.909554-1-jbrunet@baylibre.com>
	<52fab9b5-2b44-49c0-8b90-cb2a74eb6633@linaro.org>
	<1jzfr9gxh4.fsf@starbuckisacylon.baylibre.com>
	<c092ec67-e384-411d-8885-665597547523@linaro.org>
	<1jv81xgmfc.fsf@starbuckisacylon.baylibre.com>
	<5da26c0e-75a7-4d5a-9eca-f88ecf369996@linaro.org>
Date: Mon, 01 Jul 2024 11:01:41 +0200
Message-ID: <1jjzi5a3ka.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 01 Jul 2024 at 09:41, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> On 25/06/2024 15:51, Jerome Brunet wrote:
>> On Tue 25 Jun 2024 at 15:18, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>> 
>>> On 25/06/2024 11:53, Jerome Brunet wrote:
>>>> On Tue 25 Jun 2024 at 11:38, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>>>
>>>>> Hi,
>>>>>
>>>>> [+cc people from linux-msm]
>>>>>
>>>>> On 24/06/2024 19:31, Jerome Brunet wrote:
>>>>>> Add support for the HW found in most Amlogic SoC dedicated to measure
>>>>>> system clocks.
>>>>>> This drivers aims to replace the one found in
>>>>>> drivers/soc/amlogic/meson-clk-measure.c with following improvements:
>>>>>> * Access to the measurements through the IIO API:
>>>>>>      Easier re-use of the results in userspace and other drivers
>>>>>> * Controllable scale with raw measurements
>>>>>> * Higher precision with processed measurements
>>>>>> Jerome Brunet (2):
>>>>>>      dt-bindings: iio: frequency: add clock measure support
>>>>>>      iio: frequency: add amlogic clock measure support
>>>>>>     .../iio/frequency/amlogic,clk-msr-io.yaml     |  50 ++
>>>>>>     drivers/iio/frequency/Kconfig                 |  15 +
>>>>>>     drivers/iio/frequency/Makefile                |   1 +
>>>>>>     drivers/iio/frequency/amlogic-clk-msr-io.c    | 802 ++++++++++++++++++
>>>>>>     4 files changed, 868 insertions(+)
>>>>>>     create mode 100644 Documentation/devicetree/bindings/iio/frequency/amlogic,clk-msr-io.yaml
>>>>>>     create mode 100644 drivers/iio/frequency/amlogic-clk-msr-io.c
>>>>>>
>>>>>
>>>>> While I really appreciate the effort, and the code looks cool, the clkmsr is really
>>>>> a debug tool, and I'm not sure IIO is the right place for such debug tool ?
>>>> The reason why I went through the trouble of doing an IIO port is
>>>> because I need that for other purposes than debug. I need to to be able
>>>> to check a frequency from another driver. I don't see a reason to invent
>>>> another API when IIO provide a perfectly good one.
>>>> The HW does measurements. IIO seems like the best place for it.
>>>> For the record, I need this for a eARC support.
>>>> eARC has a PLL that locks on incoming stream. eARC registers show wether
>>>> the PLL is locked or not, but not at which rate. That information is
>>>> needed in ASoC. Fortunately the eARC PLL is one of measured clock, which
>>>> is a life saver in that case.
>>>
>>> This is a very interesting use-case, and quite weird nothing is provided
>>> on the eARC side.
>> Indeed.
>> 
>>>
>>> So yes it's definitely a valid use-case, but:
>>> - we should keep the debugfs interface, perhaps move it in the iio driver ?
>> I considered this initially but it would add a lot of boiler plate
>> code to provide over debugfs exactly what iio already provides over
>> sysfs. As you pointed out, the previous driver only provided debug
>> information, the debugfs interface it provided is hardly a
>> critical/stable one.
>
> I still don't see why it could add so much boilerplate, all the tables and
> calculation fonction would be shared, only the debugfs clk_msr_show() and
> clk_msr_summary_show() would be kept, all the rest would be common.
>
> I insist, please keep the debugfs interface for debug purposes. You don't
> want to mess with IIO when you bring up new platforms with bare minimum
> kernels.

I don't think that is going to change anything. It's not like IIO brings
any complexity or will be compiled out.

But since you insist, I'll add it in the next version as a separate patch.

>
>> 
>>> - we should keep a single compatible, so simply update the current bindings with iio cells
>> Using a new compatible allows to split the memory region, making the
>> interface between DT and driver a lot easier to implement seemlessly
>> between old and new SoCs. Eventually it may allow to implement the duty
>> part too.
>
> It's a problem for new platforms, you can introduce the split only for the
> new ones, the impact on code won't high enough to justify new bindings.
>

What you are requesting will introduce two drivers providing the same
compatible, unless you plan on removing the old one in a coordinated
way.

That's an unncessary churn. The old driver could stay there for a
while and platform slowly migrate. What you are requesting forcefully
migrates every consumer, assuming the old driver is compiled out.

This is an opportunity to more correctly describe the interface.
It does not break any DT rules, that is enough of a justification IMO.

> Neil
>
>> 
>>> - for s4 & c3, it's ok to either add a second reg entry in the bindings
>> Doing that for s4 and c3 only would still make a mess of offset handling
>> the region because duty prepend the region on old SoC. The goal is to
>> have an interface that seemlessly support both old and new SoCs.
>> 
>>>
>>> Neil
>>>
>>>> Everything that was available through the old driver still is, with more
>>>> precision and more control.
>>>>
>>>>>
>>>>> There's almost the same interface on qcom SoCs (https://github.com/linux-msm/debugcc) but
>>>>> they chose to keep it in userspace until we find an appropriate way to expose
>>>>> this from the kernel the right way.
>>>>>
>>>>> If it enabled us to monitor a frequency input for a product use-case, IIO would be
>>>>> the appropriate interface, but AFAIK it's only internal clocks and thus I'm worried
>>>>> it's not the best way to expose those clocks.
>>>>>
>>>>> Neil
>>>>
>> 

-- 
Jerome

