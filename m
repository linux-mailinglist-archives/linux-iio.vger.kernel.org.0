Return-Path: <linux-iio+bounces-10047-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F72798F147
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 16:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6B61F22741
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 14:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA72C19E976;
	Thu,  3 Oct 2024 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="156L6qv4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DE019E967
	for <linux-iio@vger.kernel.org>; Thu,  3 Oct 2024 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727965217; cv=none; b=My6jcYcr2AuM3dtok8Ih50B7ZpbrPLo2kgIvoPPke2NLDpnq8lLOQ1kw5hIUWxylYPTIZGGoY3yHgvoseEUHtVsFkJbOZezTGuiU3S41/zk7zbB+bE36d/oOmsndXDTBSFM4HQzo2GTu6AkiSCeRAakSyTvioX8PYjSFfdghebM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727965217; c=relaxed/simple;
	bh=MTBMAJpXm1pHcmzbDM+XtEXr3jCyoJ1nEuQscnYO1H8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IB5WaN8n7XWfXK/iyGM72OHnL35IQY6SbN2q8t+bctqMtVGDRmGd+vP9fj2AB06DDZut5EoyuhdQaDXcvAqOZr+HOaezI3D/hHg0eNtHeHII741IGAUnQv5n09Ru6ocmS4/4peiECcazmi/xCwOG7SIsD1WzEtLfZFoMq7sna14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=156L6qv4; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-710de2712eeso359619a34.3
        for <linux-iio@vger.kernel.org>; Thu, 03 Oct 2024 07:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727965213; x=1728570013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W0xXnRccwICf3nQQCN6F6qfdjv2N+ArvTxSpI1D+3TY=;
        b=156L6qv4P4lP2eLtL5C9cfGDjXqLU64DgzWpTh9BZb7xEeKUd4XxQEkeFDXFXCrd+s
         ajUkATVmwgKK+B4Nk2v9/y7n1dXGtAQENvtsYaz1BhgTTLsZ3S70xgQ0MuTlx2PgPZu5
         OUZdkPp6reOU2ctv+hJS/IPeAn3jN2OpJkLBwgRn4bIY8KUvVdhy/Cs3z1L4vM9pu339
         6vsYKeaoSEx+YRZ+HLhUvH2ja3zyuoyI/MKsAQZPZI7rEtGhe5eTPOVmbKu9QxMop0o9
         NvsqRb08BUfOut3dNbshXrYj29k5rnRd/JGxWTCyON6niCthIxOzPKXjRuXtA0sj9js1
         t5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727965213; x=1728570013;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0xXnRccwICf3nQQCN6F6qfdjv2N+ArvTxSpI1D+3TY=;
        b=R4hm2gy4tCEU8M1sE+fI2ir0zIYrxJ0IE10lg3gSa9HhR1h9t3ySpoeamvRP6io/1E
         6D/8QeZB/mXEJSmzh0idxqVchWc5mS8Myrmgd9M3UfANSL0BgYWnBb+zJgG1cJwnJLP/
         j/QuSJA2Zd7k3ojFR7hf/PK23Jwiz3pyLcWwJtc3JCxLqHIGLnZZTA3b0vX9Q792/QWk
         KHb92E7Kmjenzt6avDakFUNOIjPt4qrE+G8faZhmppZD5gNDMP1ZOONIdTXChiXHolt5
         GpfJne88P4D12KpAyQFEfk1DnfRNZJfy/+v2QqVLkXXFBVnZ2om4cfoQ2o9hhOiyqCKy
         bJig==
X-Forwarded-Encrypted: i=1; AJvYcCVtLpSzzGR9eOswMBOdVNq8FueArzUGYRn3qkwcGCEUhw1TZgwFgW8IWuequNRRDAng8aXXuub8fqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS2E91LKNjMNu0/DQMmxBYOU6xVQaU/QQw6Jxq12Ty/yO4uGdK
	vWr0T+FgDzhnqqmJ8Nv9h63OyfUfp/EGUkAjChVYrGXE0rNiOXRBuhbtBHySLic=
X-Google-Smtp-Source: AGHT+IEWwNUWz4nQ2IndJUC/CzrU5KetlvJmNaXTu3CLm7H2k6yOjFPj8tQXSEF6utrDP8q+MGltcQ==
X-Received: by 2002:a05:6830:438b:b0:713:76ea:6be9 with SMTP id 46e09a7af769-7153cd796b0mr6532950a34.11.1727965213475;
        Thu, 03 Oct 2024 07:20:13 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71547f893a9sm337467a34.77.2024.10.03.07.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 07:20:11 -0700 (PDT)
Message-ID: <193a517c-dd4e-4ed1-ba4e-a0aa6028beec@baylibre.com>
Date: Thu, 3 Oct 2024 09:20:09 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: adc: ad7380: use if_not_cond_guard for claim
 direct
To: kernel test robot <lkp@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jonathan Cameron <jic23@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20241001-cleanup-if_not_cond_guard-v1-2-7753810b0f7a@baylibre.com>
 <202410031253.vjAMDYuX-lkp@intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <202410031253.vjAMDYuX-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/3/24 12:35 AM, kernel test robot wrote:
> Hi David,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on 431c39f6d3edbab14f48dbf37a58ccdc0ac3be1e]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/cleanup-add-conditional-guard-helper/20241002-063209
> base:   431c39f6d3edbab14f48dbf37a58ccdc0ac3be1e
> patch link:    https://lore.kernel.org/r/20241001-cleanup-if_not_cond_guard-v1-2-7753810b0f7a%40baylibre.com
> patch subject: [PATCH 2/3] iio: adc: ad7380: use if_not_cond_guard for claim direct
> config: arm64-randconfig-001-20241003 (https://download.01.org/0day-ci/archive/20241003/202410031253.vjAMDYuX-lkp@intel.com/config)
> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241003/202410031253.vjAMDYuX-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410031253.vjAMDYuX-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/iio/adc/ad7380.c:823:3: error: expected expression
>      823 |                 if_not_cond_guard(iio_claim_direct_try, indio_dev)
>          |                 ^
>    include/linux/cleanup.h:316:2: note: expanded from macro 'if_not_cond_guard'
>      316 |         __if_not_cond_guard(_name, __UNIQUE_ID(guard), args)
>          |         ^
>    include/linux/cleanup.h:312:2: note: expanded from macro '__if_not_cond_guard'
>      312 |         CLASS(_name, _id)(args);                        \
>          |         ^
>    include/linux/cleanup.h:258:2: note: expanded from macro 'CLASS'
>      258 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
>          |         ^
>    <scratch space>:81:1: note: expanded from here
>       81 | class_iio_claim_direct_try_t
>          | ^
>    drivers/iio/adc/ad7380.c:823:3: error: use of undeclared identifier '__UNIQUE_ID_guard799'
>    include/linux/cleanup.h:316:29: note: expanded from macro 'if_not_cond_guard'
>      316 |         __if_not_cond_guard(_name, __UNIQUE_ID(guard), args)
>          |                                    ^
>    include/linux/compiler.h:189:29: note: expanded from macro '__UNIQUE_ID'
>      189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                             ^
>    include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
>       84 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^
>    include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
>       83 | #define ___PASTE(a,b) a##b
>          |                       ^
>    <scratch space>:79:1: note: expanded from here
>       79 | __UNIQUE_ID_guard799
>          | ^
>>> drivers/iio/adc/ad7380.c:935:2: error: cannot jump from switch statement to this case label
>      935 |         default:
>          |         ^
>    drivers/iio/adc/ad7380.c:911:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
>      911 |                 if_not_cond_guard(iio_claim_direct_try, indio_dev)
>          |                 ^
>    include/linux/cleanup.h:316:29: note: expanded from macro 'if_not_cond_guard'
>      316 |         __if_not_cond_guard(_name, __UNIQUE_ID(guard), args)
>          |                                    ^
>    include/linux/compiler.h:189:29: note: expanded from macro '__UNIQUE_ID'
>      189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                             ^
>    include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
>       84 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^
>    include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
>       83 | #define ___PASTE(a,b) a##b
>          |                       ^
>    <scratch space>:90:1: note: expanded from here
>       90 | __UNIQUE_ID_guard800
>          | ^
>    3 errors generated.
> 
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for MODVERSIONS
>    Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
>    Selected by [y]:
>    - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=y] || GCC_PLUGINS [=n]) && MODULES [=y]
> 
> 
> vim +823 drivers/iio/adc/ad7380.c
> 
>    808	
>    809	static int ad7380_read_raw(struct iio_dev *indio_dev,
>    810				   struct iio_chan_spec const *chan,
>    811				   int *val, int *val2, long info)
>    812	{
>    813		struct ad7380_state *st = iio_priv(indio_dev);
>    814		const struct iio_scan_type *scan_type;
>    815	
>    816		scan_type = iio_get_current_scan_type(indio_dev, chan);
>    817	
>    818		if (IS_ERR(scan_type))
>    819			return PTR_ERR(scan_type);
>    820	
>    821		switch (info) {
>    822		case IIO_CHAN_INFO_RAW:
>  > 823			if_not_cond_guard(iio_claim_direct_try, indio_dev)
>    824				return -EBUSY;
>    825	
>    826			return ad7380_read_direct(st, chan->scan_index, scan_type, val);
>    827		case IIO_CHAN_INFO_SCALE:
>    828			/*
>    829			 * According to the datasheet, the LSB size is:
>    830			 *    * (2 × VREF) / 2^N, for differential chips
>    831			 *    * VREF / 2^N, for pseudo-differential chips
>    832			 * where N is the ADC resolution (i.e realbits)
>    833			 */
>    834			*val = st->vref_mv;
>    835			*val2 = scan_type->realbits - chan->differential;
>    836	
>    837			return IIO_VAL_FRACTIONAL_LOG2;
>    838		case IIO_CHAN_INFO_OFFSET:
>    839			/*
>    840			 * According to IIO ABI, offset is applied before scale,
>    841			 * so offset is: vcm_mv / scale
>    842			 */
>    843			*val = st->vcm_mv[chan->channel] * (1 << scan_type->realbits)
>    844				/ st->vref_mv;
>    845	
>    846			return IIO_VAL_INT;
>    847		case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>    848			*val = st->oversampling_ratio;
>    849	
>    850			return IIO_VAL_INT;
>    851		default:
>    852			return -EINVAL;
>    853		}
>    854	}
>    855	
>    856	static int ad7380_read_avail(struct iio_dev *indio_dev,
>    857				     struct iio_chan_spec const *chan,
>    858				     const int **vals, int *type, int *length,
>    859				     long mask)
>    860	{
>    861		switch (mask) {
>    862		case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>    863			*vals = ad7380_oversampling_ratios;
>    864			*length = ARRAY_SIZE(ad7380_oversampling_ratios);
>    865			*type = IIO_VAL_INT;
>    866	
>    867			return IIO_AVAIL_LIST;
>    868		default:
>    869			return -EINVAL;
>    870		}
>    871	}
>    872	
>    873	/**
>    874	 * ad7380_osr_to_regval - convert ratio to OSR register value
>    875	 * @ratio: ratio to check
>    876	 *
>    877	 * Check if ratio is present in the list of available ratios and return the
>    878	 * corresponding value that needs to be written to the register to select that
>    879	 * ratio.
>    880	 *
>    881	 * Returns: register value (0 to 7) or -EINVAL if there is not an exact match
>    882	 */
>    883	static int ad7380_osr_to_regval(int ratio)
>    884	{
>    885		int i;
>    886	
>    887		for (i = 0; i < ARRAY_SIZE(ad7380_oversampling_ratios); i++) {
>    888			if (ratio == ad7380_oversampling_ratios[i])
>    889				return i;
>    890		}
>    891	
>    892		return -EINVAL;
>    893	}
>    894	
>    895	static int ad7380_write_raw(struct iio_dev *indio_dev,
>    896				    struct iio_chan_spec const *chan, int val,
>    897				    int val2, long mask)
>    898	{
>    899		struct ad7380_state *st = iio_priv(indio_dev);
>    900		int ret, osr, boost;
>    901	
>    902		switch (mask) {
>    903		case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>    904			osr = ad7380_osr_to_regval(val);
>    905			if (osr < 0)
>    906				return osr;
>    907	
>    908			/* always enable resolution boost when oversampling is enabled */
>    909			boost = osr > 0 ? 1 : 0;
>    910	
>    911			if_not_cond_guard(iio_claim_direct_try, indio_dev)
>    912				return -EBUSY;
>    913	
>    914			ret = regmap_update_bits(st->regmap,
>    915						 AD7380_REG_ADDR_CONFIG1,
>    916						 AD7380_CONFIG1_OSR | AD7380_CONFIG1_RES,
>    917						 FIELD_PREP(AD7380_CONFIG1_OSR, osr) |
>    918						 FIELD_PREP(AD7380_CONFIG1_RES, boost));
>    919	
>    920			if (ret)
>    921				return ret;
>    922	
>    923			st->oversampling_ratio = val;
>    924			st->resolution_boost_enabled = boost;
>    925	
>    926			/*
>    927			 * Perform a soft reset. This will flush the oversampling block
>    928			 * and FIFO but will maintain the content of the configurable
>    929			 * registers.
>    930			 */
>    931			return regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
>    932						  AD7380_CONFIG2_RESET,
>    933						  FIELD_PREP(AD7380_CONFIG2_RESET,
>    934							     AD7380_CONFIG2_RESET_SOFT));
>  > 935		default:
>    936			return -EINVAL;
>    937		}
>    938	}
>    939	
> 

This warning and the "warning: label followed by a declaration
is a C23 extension" from the other bot message are both fixed
with the following modification:


diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 19a942035e93..34adc5aeb6f3 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -819,11 +819,12 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
 		return PTR_ERR(scan_type);
 
 	switch (info) {
-	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_RAW: {
 		if_not_cond_guard(iio_claim_direct_try, indio_dev)
 			return -EBUSY;
 
 		return ad7380_read_direct(st, chan->scan_index, scan_type, val);
+	}
 	case IIO_CHAN_INFO_SCALE:
 		/*
 		 * According to the datasheet, the LSB size is:
@@ -900,7 +901,7 @@ static int ad7380_write_raw(struct iio_dev *indio_dev,
 	int ret, osr, boost;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO: {
 		osr = ad7380_osr_to_regval(val);
 		if (osr < 0)
 			return osr;
@@ -932,6 +933,7 @@ static int ad7380_write_raw(struct iio_dev *indio_dev,
 					  AD7380_CONFIG2_RESET,
 					  FIELD_PREP(AD7380_CONFIG2_RESET,
 						     AD7380_CONFIG2_RESET_SOFT));
+	}
 	default:
 		return -EINVAL;
 	}


