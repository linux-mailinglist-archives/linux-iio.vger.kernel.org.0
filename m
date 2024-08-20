Return-Path: <linux-iio+bounces-8645-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A21958F6F
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 23:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4E6FB22E0E
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 21:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D7F1C5784;
	Tue, 20 Aug 2024 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YdPgC7DF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4A01C4602
	for <linux-iio@vger.kernel.org>; Tue, 20 Aug 2024 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724188052; cv=none; b=KdbxsXdW4fE2+mxcavU+RXRGe0mPiO6E018j2xXkiDzRDLUYe93XSH8aDcb8TdKAnrFhygMLFsUVnK4+sm+6UnRmBdqNS40KVNcOFaktoSNSKKmTW+HKi3OlCnS2QcA0P2i+olz9uoeUM6Re0Ma8ALpSbKaB9ayfBW0Uw4/pqIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724188052; c=relaxed/simple;
	bh=XNFvctVhIwp6wrUS5NtnVVcSlfcNFqnWQa6xosRIEHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJXXs3EV8ElC73RfmDG8yjOAf/7Zb+d/b4Keqv4hzGlgwgq6uB1G0P2ghiY3YSw/nlIzekTU6XWHvbiflzOi/scyRRAwQ7YwZl9ejGXwVFJjDAgbFICx5+I5hlFeGHdm68n68Ihg52kgSaNy4ZeQceRQKO73w5hwz+DYClQGJ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YdPgC7DF; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e04196b7603so6530088276.0
        for <linux-iio@vger.kernel.org>; Tue, 20 Aug 2024 14:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724188049; x=1724792849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aebfEap/ASBe5Gb+mw0cMwkvvA5FCkHO5rzJr5kiaeg=;
        b=YdPgC7DFxyCMrhIWHOsfXtiG0g8yJpxTraDA27zkaixffGq/NqDIyX/+cXNDmWhiZ+
         IwhHQs6e7rCr4zuSeQZ3YDTpo+t3WT3xNFsybWYbc6E6e3ATbdeC/iimuePxsEX11/1b
         WIaNFVNIgTC5s1TXlJpX+ROi/jTIps1cmjBMWBPNs2ta5GM5VtrR2B5YSko7mrmnkdgc
         l3+5p0DtKw4OnjFbRufN1SoQzF4UyyAjLtmFrqmW6WQx+iUbqzghwaz5NR4U9ogWl9Bn
         +vn9tPhMm4JHddNK3Yf3BgKIQfj+XqW6Qh/42cPMtxr4Ebf0kJvNjWs6hnAoQ8jfdIW6
         9tvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724188049; x=1724792849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aebfEap/ASBe5Gb+mw0cMwkvvA5FCkHO5rzJr5kiaeg=;
        b=ad9Cz/m/vgKtghd/3w87QpdT07mWXUE5s9beqvCosnvegq0Jn19ltZkt2Jcb9jX7f0
         kHEhAytVIEgJrENNqlaaTz280ayX/VwEMxwjKDWbya5eq3NbsOr7roGHzUCObJ0XvKIy
         9zsmGAMLWeC9POdCvB9rOjPS5HOeiWcbxNlPxahLVxfa9PrGZlIgu+S1ZBRm/AnCZmc1
         aT17Ur+TZB3t+b/3w48NIV1IjMuunQ49eNo1xp6sQwSlLs4cYL9eRqlnJnuPtB+Yk0H8
         Bg9Co6mceAzwmhWophDmmr2keLIldzsfYg1Kqhl9Sf1jJ8MsZTyHlhgSoxBOR9TZqp/Q
         9lLg==
X-Forwarded-Encrypted: i=1; AJvYcCWnG0o4nCtdx19K7+6bkXZQDd/A9BnQOaBP8ESzWY1M+HMCaM+VJOog3zZ3g4/o/Y1nRSYnt/1OOsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSW2E05Qdp1ldcsbb1uaLHJqvGVkIPx1XKgIcchQwQEKEMHPD6
	nh9IxDfzWrkOU4V/0IfsqpBTH+jpc+D4Aj8RzXQz+C6Ldslj6UZIfUywr6oxMF0=
X-Google-Smtp-Source: AGHT+IEbwKid8lGpSqZEjokGZLtdiVUpmCFV7bwar2w8v4lWx6MWt47SpOfAEtmAV7/wUbEyz60atQ==
X-Received: by 2002:a05:690c:2e8d:b0:6b0:2031:6414 with SMTP id 00721157ae682-6c09d4ff4fcmr6360937b3.24.1724188049085;
        Tue, 20 Aug 2024 14:07:29 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fdd8bfdsm55935356d6.19.2024.08.20.14.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 14:07:28 -0700 (PDT)
Message-ID: <7658aca4-a408-480c-98b6-4637bb86b5ad@baylibre.com>
Date: Tue, 20 Aug 2024 17:07:27 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] iio: adc: ad7625: add driver
To: kernel test robot <lkp@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Lechner <dlechner@baylibre.com>,
 Uwe Kleine-Konig <u.kleine-koenig@baylibre.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20240819-ad7625_r1-v3-2-75d5217c76b5@baylibre.com>
 <202408201520.lFtco3eF-lkp@intel.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <202408201520.lFtco3eF-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024-08-20 3:19 a.m., kernel test robot wrote:
> Hi Trevor,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on ac6a258892793f0a255fe7084ec2b612131c67fc]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Trevor-Gamblin/dt-bindings-iio-adc-add-AD762x-AD796x-ADCs/20240819-221425
> base:   ac6a258892793f0a255fe7084ec2b612131c67fc
> patch link:    https://lore.kernel.org/r/20240819-ad7625_r1-v3-2-75d5217c76b5%40baylibre.com
> patch subject: [PATCH v3 2/3] iio: adc: ad7625: add driver
> config: alpha-randconfig-r132-20240820 (https://download.01.org/0day-ci/archive/20240820/202408201520.lFtco3eF-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 13.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20240820/202408201520.lFtco3eF-lkp@intel.com/reproduce)
Seems to be a problem with missing static inline definitions in pwm.h if 
CONFIG_PWM isn't set. I've replied to the relevant series on the PWM 
mailing list and will add "select PWM" to Kconfig for this driver.
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408201520.lFtco3eF-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>     drivers/iio/adc/ad7625.c: In function 'ad7625_set_sampling_freq':
>>> drivers/iio/adc/ad7625.c:191:15: error: implicit declaration of function 'pwm_round_waveform_might_sleep' [-Werror=implicit-function-declaration]
>       191 |         ret = pwm_round_waveform_might_sleep(st->cnv_pwm, &cnv_wf);
>           |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/iio/adc/ad7625.c: In function 'ad7625_buffer_preenable':
>>> drivers/iio/adc/ad7625.c:420:15: error: implicit declaration of function 'pwm_set_waveform_might_sleep' [-Werror=implicit-function-declaration]
>       420 |         ret = pwm_set_waveform_might_sleep(st->cnv_pwm, &st->cnv_wf, false);
>           |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     cc1: some warnings being treated as errors
>
>
> vim +/pwm_round_waveform_might_sleep +191 drivers/iio/adc/ad7625.c
>
>     175	
>     176	static int ad7625_set_sampling_freq(struct ad7625_state *st, int freq)
>     177	{
>     178		u64 target;
>     179		struct pwm_waveform clk_gate_wf = { }, cnv_wf = { };
>     180		int ret;
>     181	
>     182		target = DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq);
>     183		cnv_wf.period_length_ns = clamp(target, 100, 10 * KILO);
>     184	
>     185		/*
>     186		 * Use the maximum conversion time t_CNVH from the datasheet as
>     187		 * the duty_cycle for ref_clk, cnv, and clk_gate
>     188		 */
>     189		cnv_wf.duty_length_ns = st->info->timing_spec->conv_high_ns;
>     190	
>   > 191		ret = pwm_round_waveform_might_sleep(st->cnv_pwm, &cnv_wf);
>     192		if (ret)
>     193			return ret;
>     194	
>     195		/*
>     196		 * Set up the burst signal for transferring data. period and
>     197		 * offset should mirror the CNV signal
>     198		 */
>     199		clk_gate_wf.period_length_ns = cnv_wf.period_length_ns;
>     200	
>     201		clk_gate_wf.duty_length_ns = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC *
>     202			st->info->chan_spec.scan_type.realbits,
>     203			st->ref_clk_rate_hz);
>     204	
>     205		/* max t_MSB from datasheet */
>     206		clk_gate_wf.duty_offset_ns = st->info->timing_spec->conv_msb_ns;
>     207	
>     208		ret = pwm_round_waveform_might_sleep(st->clk_gate_pwm, &clk_gate_wf);
>     209		if (ret)
>     210			return ret;
>     211	
>     212		st->cnv_wf = cnv_wf;
>     213		st->clk_gate_wf = clk_gate_wf;
>     214	
>     215		/* TODO: Add a rounding API for PWMs that can simplify this */
>     216		target = DIV_ROUND_CLOSEST_ULL(st->ref_clk_rate_hz, freq);
>     217		st->sampling_freq_hz = DIV_ROUND_CLOSEST_ULL(st->ref_clk_rate_hz,
>     218							     target);
>     219	
>     220		return 0;
>     221	}
>     222	
>

