Return-Path: <linux-iio+bounces-9156-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 204AD96C751
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 21:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 693DCB229BE
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 19:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A715F1E6DE1;
	Wed,  4 Sep 2024 19:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fXzKZowl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08F21E6DD8
	for <linux-iio@vger.kernel.org>; Wed,  4 Sep 2024 19:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725477366; cv=none; b=XFHc9FPfgMxxYPLFyy85qBWJD0NsMykrqtvs0NYNUxt+c/rcUucyWx4p54xsS2bYlVyoBcbVOkPwhsLtMygVuFs0psaIEXECYvE/ujzb1wlqAkp8WQzrhRhQ1WJHKpVzZsnJQ8MBu70wL39mIpX+t2FtRjERdOVRXJSSrI3OdBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725477366; c=relaxed/simple;
	bh=WfiusaYUI7NNzYn1hMW8VCzKpjGkVmzh//jhn7WhvkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VpaeN1x3cRaCB9OfyTKI0Ho5eXyJJHiWNmyt2/MHb1RFvuKq5jo09HW5cfQ2vexNX+HiavXcfuPteznwwlKBV1FL4sX69+hW2h9rkxJV/EAFA+gvCUHrILjEbhrde8roTp8QfjHJq81LfOhVbygdd0tDe3ZgYJ6QzUw4AnIpqIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fXzKZowl; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a966f0a985so240411085a.3
        for <linux-iio@vger.kernel.org>; Wed, 04 Sep 2024 12:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725477363; x=1726082163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ryDbdQ2D/+rou29MCfRgv3SUSfdPjKb5CferA/8Ns4w=;
        b=fXzKZowlbkqs/NlOpWRcR6KrIniw1FRcC4AYbwahzwJ6dD3TFtWhHMLCvee1beh488
         Xrc8mslFybfN/7CEcVEutnck+e1dPHarX/chM7zlhgdfr51AoliBUG+bbdOpv5ip7nX6
         rK2JUhV57+iMK/HKMrDBdIAJKcg9YxEauPvQEy3KdIF6RU5LQ7Mii9LMXt7BXI1+pCYk
         43z7V9jhVAyvh+JRzg6dx64Plurv9llVZkl+027CI3ugJ+RRG3/qpYhHdC27bcMYir5D
         hlhgb8y2IliMquK3oom+0LaOpu9H6GGwwSezhThLHUasMvCjS+mzfawxP8p/j2IbsEtI
         q0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725477363; x=1726082163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ryDbdQ2D/+rou29MCfRgv3SUSfdPjKb5CferA/8Ns4w=;
        b=w2KRD3bNNqSt6/+gYiWYHRvSI+rI3WfAxFHUIL1Yv0wO7ULRG3rB8WSUw0yEgS99Wz
         t8B+4/rlX9cYciF1XqInY6A130VFaeutde7K/9QAYjoFgz0GzLlJM69br90ncym4uiin
         8jHe6pkdlN+jqsDouO4wiGv6u5VW0WPvQbvfRYfIg/6yHGSSiiaPK6e2V5GmGFtViRv3
         X2cT7YcZ5LF3ssEVPZ6CfgHhuvYIv87ERevFjyAng4ZGCbUCz8MA2gDZzV7hD1c5vyVD
         0czxGPRSriyKYN2OvwYjUvUw69B18BiPvTuEgCdtl92+FEtS1h4wr1+1gZqdeLPPhbzi
         +SRw==
X-Gm-Message-State: AOJu0YzZIVlN7RpCSDwbJ1ZUf+DKlFPjAtQ3QCpicP5fwWWGiiCesk5g
	r3D5dgo5hEobEp4h2Lt7xrDeT1mUA4JUxJk7htOWfmUnd/L70IVaeZZ5jrg7AnQ=
X-Google-Smtp-Source: AGHT+IFiAMwM665JnKMTu/rsJXEnquw0Kjt7PP7GRDGavSs2IapuyxpuZ6LmY1UP4XZ7M7H6uU8GAA==
X-Received: by 2002:a05:620a:2989:b0:7a2:32e:3c41 with SMTP id af79cd13be357-7a97bd2b1a5mr812257685a.60.1725477363333;
        Wed, 04 Sep 2024 12:16:03 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98ef4742fsm9940285a.58.2024.09.04.12.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 12:16:02 -0700 (PDT)
Message-ID: <123c8bff-6623-4a3b-a49e-69b3ab6f8ab5@baylibre.com>
Date: Wed, 4 Sep 2024 15:16:01 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] iio: adc: add new ad7625 driver
To: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Lechner <dlechner@baylibre.com>,
 Uwe Kleine-Konig <u.kleine-koenig@baylibre.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240904-ad7625_r1-v4-0-78bc7dfb2b35@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20240904-ad7625_r1-v4-0-78bc7dfb2b35@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024-09-04 3:14 p.m., Trevor Gamblin wrote:
> This series adds a new driver for the Analog Devices Inc. AD7625,
> AD7626, AD7960, and AD7961. These chips are part of a family of
> LVDS-based SAR ADCs. The initial driver implementation does not support
> the devices' self-clocked mode, although that can be added later.
>
> The devices make use of two offset PWM signals, one to trigger
> conversions and the other as a burst signal for transferring data to the
> host. These rely on the new PWM waveform functionality being
> reviewed in [1] and also available at [2].
>
> This work is being done by BayLibre and on behalf of Analog Devices
> Inc., hence the maintainers are @analog.com.
>
> Special thanks to David Lechner for his guidance and reviews.
>
> [1]: https://lore.kernel.org/linux-pwm/cover.1722261050.git.u.kleine-koenig@baylibre.com
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git/log/?h=pwm/chardev
>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
Realizing that I forgot to pick up Conor's Reviewed-by on the v3 binding 
before sending. Can that be picked up?
> ---
> Changes in v4:
> - Link to v3: https://lore.kernel.org/r/20240819-ad7625_r1-v3-0-75d5217c76b5@baylibre.com
> - Rebase on top of latest pwm/chardev branch at:
>    https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git/log/?h=pwm/chardev
>
>    [PATCH 1/3]
>    - No change
>
>    [PATCH 2/3]
>    - Add 'depends on PWM' under 'CONFIG AD7625' in
>      drivers/iio/adc/Kconfig, based on v3 discussions
>    - Cleanup whitespace usage in Kconfig, bandwidth logic to match
>      Jonathan's suggestions
>
>    [PATCH 3/3]
>    - No change
>
> Changes in v3:
> - Link to v2: https://lore.kernel.org/r/20240809-ad7625_r1-v2-0-f85e7ac83150@baylibre.com
>    
>    [PATCH 1/3]
>    - Add gpio bindings header, en0-gpios and en1-gpios to binding example
>    - Remove unnecessary comments
>
>    [PATCH 2/3]
>    - No change
>
>    [PATCH 3/3]
>    - No change
>
> Changes in v2:
> - Link to v1 (marked as RFC): https://lore.kernel.org/r/20240731-ad7625_r1-v1-0-a1efef5a2ab9@baylibre.com
> - Include link to required PWM patch series in cover letter (missing before)
> - Include new link to the pwm/chardev branch of Uwe's kernel tree
>    
>    [PATCH 1/3]
>    - Rework dt bindings to be compliant using make dt_binding_check
>    - Add "adi,no-dco" flag to address indication of how DCO lines are
>      configured
>    - Fix binding patch message
>    - Remove chip packaging info from binding description
>    - Move comments around to be clearer
>
>    [PATCH 2/3]
>    - Remove ad7625_pwm_disable(), call pwm_disable() directly
>    - Add ad7625_buffer_preenable() and ad7625_buffer_postdisable()
>      functions
>    - Add devm_ad7625_regulator_setup() function, move all regulator logic
>      to it, consolidate the comment blocks related to it above
>    - Add have_refin flag in ad7625_state struct
>    - Add pwm_waveform structs to ad7625_state struct for storing
>      requested waveform characteristics
>    - Refactor ad7625_set_sampling_freq() to set the pwm_waveform struct
>      values in ad7625_state, limiting PWM enable/disable to
>      preenable/postdisable functions
>    - Remove redundant dev_err_probe() after devm_ad7625_pwm_get()
>    - Use device_property_read_bool() instead of device_property_present()
>    - General alignment and line wrapping fixes
>
>    [PATCH 3/3]
>    - No change
>
> ---
> Trevor Gamblin (3):
>        dt-bindings: iio: adc: add AD762x/AD796x ADCs
>        iio: adc: ad7625: add driver
>        docs: iio: new docs for ad7625 driver
>
>   .../devicetree/bindings/iio/adc/adi,ad7625.yaml    | 176 ++++++
>   Documentation/iio/ad7625.rst                       |  91 +++
>   MAINTAINERS                                        |  11 +
>   drivers/iio/adc/Kconfig                            |  16 +
>   drivers/iio/adc/Makefile                           |   1 +
>   drivers/iio/adc/ad7625.c                           | 684 +++++++++++++++++++++
>   6 files changed, 979 insertions(+)
> ---
> base-commit: 1ebd3850421749eb44bd040b249bd4db88d35b33
> change-id: 20240730-ad7625_r1-60d17ea28958
>
> Best regards,

