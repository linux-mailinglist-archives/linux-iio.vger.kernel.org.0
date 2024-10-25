Return-Path: <linux-iio+bounces-11259-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E527D9AFDAA
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 11:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C0D28256B
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 09:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5101D3586;
	Fri, 25 Oct 2024 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j10cRNnb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5C718F2F9;
	Fri, 25 Oct 2024 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847227; cv=none; b=I3zZAsMnn/1YbE5ZVY37wCfr/3pDikfeniTZbxpFX02cukeAU+iMslPUgrjLMJiN3FJVrfPoulKRuSF1UiXWyt/I+3bLiqBbOgBVeoTGhxZq2sBVOxaS86cNMGZ9s7PzJzuLt1CbyHdfIjKZHGsab3BNo/AmEGgjVmrjfkH6Nn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847227; c=relaxed/simple;
	bh=Rzp9K4Fkjf5MO1eixTWPhfMpvqZgxSqJdynFSyg8cAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCcvnldcEuSKgqbqyKsnDXel1nI6pKBcFND/PeFDVkP+Ydc0IWbBYe18hREKlBXscnRTTIFcUmk86PpBwH9nIdy0518ETBBooDXuunSQiWZ2b4dvH/GSQzFRuV1aW0tYWXclV1tnM8rvRnO2Tl+w8EPI/2jrlDxetWEoXmfJG0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j10cRNnb; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f7606199so2272895e87.0;
        Fri, 25 Oct 2024 02:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729847223; x=1730452023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4mECQD/YfbuBuIUcbQm0LGC8NByfVNCBXlQA6CHA+Jk=;
        b=j10cRNnbDzgFL/r7aIeB7FX+vez7yiYw/0qmuqrHH+ktP0C48m+keWxS8e96osT5X/
         jish4iBHbG/X+DbQLj/Eef8Uos9RdnHIq+04r4iqQQfQFaZ7fnmquOfuJTcRHws3cOgK
         TK00QRTosZKV2CJ1zTWN/2Vbu+XqOg51l92Do8eDC9i2FrWR6xZbLezH4PKqHXRskBTJ
         IJs8tExw9GRRVjwJIug0/bqgbTh0Ey6q1y1TMgQBF6QGZOBDok7kTKMTB/vUyAZSMbKv
         co+PgZTZs4vyJiI5jQh+FbxSDDTdlSmseh1QO1kkpzI4TZz2lQTlu7egmtf1F0fhM5vm
         Xsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729847223; x=1730452023;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4mECQD/YfbuBuIUcbQm0LGC8NByfVNCBXlQA6CHA+Jk=;
        b=DUNGbKdnstslkVVEQ8KO0BlT7qpkxdXuuA1GDm1/9qbndMFexLl0hR6LW+9ce+oFr0
         /GBz+n9W0Io6SIcg+orKXzkdhYDB8hlOOCIK3b+/40hpMyOv8P6agDVUDO8sb0cHtYrD
         Vudf/3p//vrTFF5/6pNZ/5m/2DZ0nK+26x2TIQTpZmIdcWf49piPAH8NstGjMiuIuyDg
         eWt9ktasNHQgiN0a1lt2sMlDtBfCaYAHVARcLUgIZS2XZ21iLFU4ECl0QrJGQ5Ky/weJ
         YjHISnxdoceBQg9jUrbhV7yUPFUp+A0GR+s15epMa7ZkeibylgdQwflLd019kaWZy8HN
         SiPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+mEbYF+U4d02c3tuymh6iou83bReg6Tur3Zgs0fb5lme2LjmeJKJZ2Teoh8aUOoA5bfMl3jos3rUk/7Wx@vger.kernel.org, AJvYcCXE7q0NQjjlhqIpdiNCaip6sAhVMkzXOuuTDndTpEwjNLlsjNNp6hrnd3Ts9LmJh+dAC0mZdoMpw8qt@vger.kernel.org, AJvYcCXPmQczSDCPhzS7A/OrOL8vN3NLAGuB+4KVT55ER+HCHxU4yqpj3GIIiDCjoW1H9FcalMLzKph+N9uc@vger.kernel.org
X-Gm-Message-State: AOJu0YwX9+quS3pfZTe6mDIbor/2a3W7Yo+UCpAojxcLHvtpueJoV3Fy
	rgjRVd4uPKwtGOgjj05p/ML+8lP66m2CLRk9edWzQUpdp4YQXcBI
X-Google-Smtp-Source: AGHT+IFqjwEh8TjngAt8TQtp90yZAebVutuszx4Mo6HG7vicBzcpfkrqPYsu816QM+kueZu1ZqVuig==
X-Received: by 2002:a05:6512:3a85:b0:539:f807:ada5 with SMTP id 2adb3069b0e04-53b1a2fe384mr5517625e87.3.1729847223256;
        Fri, 25 Oct 2024 02:07:03 -0700 (PDT)
Received: from [10.10.40.97] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1e75ff3bsm46207966b.1.2024.10.25.02.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 02:07:02 -0700 (PDT)
Message-ID: <19c8e07f-4b9b-4d4b-aa18-f6766b65b33e@gmail.com>
Date: Fri, 25 Oct 2024 11:07:01 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: light: add support for veml3235
To: kernel test robot <lkp@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Rishi Gupta <gupt21@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241023-veml3235-v3-2-8490f2622f9a@gmail.com>
 <202410251610.kB7u6xMJ-lkp@intel.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <202410251610.kB7u6xMJ-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/10/2024 11:01, kernel test robot wrote:
> Hi Javier,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on ceab669fdf7b7510b4e4997b33d6f66e433a96db]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Javier-Carrasco/dt-bindings-iio-light-veml6030-add-veml3235/20241024-030144
> base:   ceab669fdf7b7510b4e4997b33d6f66e433a96db
> patch link:    https://lore.kernel.org/r/20241023-veml3235-v3-2-8490f2622f9a%40gmail.com
> patch subject: [PATCH v3 2/2] iio: light: add support for veml3235
> config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20241025/202410251610.kB7u6xMJ-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410251610.kB7u6xMJ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410251610.kB7u6xMJ-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/iio/light/veml3235.c: In function 'veml3235_set_it':
>>> drivers/iio/light/veml3235.c:148:26: warning: variable 'it_idx' set but not used [-Wunused-but-set-variable]
>      148 |         int ret, new_it, it_idx;
>          |                          ^~~~~~
>    drivers/iio/light/veml3235.c: In function 'veml3235_set_gain':
>>> drivers/iio/light/veml3235.c:191:28: warning: variable 'gain_idx' set but not used [-Wunused-but-set-variable]
>      191 |         int ret, new_gain, gain_idx;
>          |                            ^~~~~~~~
> 
> 
> vim +/it_idx +148 drivers/iio/light/veml3235.c
> 
>    144	
>    145	static int veml3235_set_it(struct iio_dev *indio_dev, int val, int val2)
>    146	{
>    147		struct veml3235_data *data = iio_priv(indio_dev);
>  > 148		int ret, new_it, it_idx;
>    149	
>    150		if (val)
>    151			return -EINVAL;
>    152	
>    153		switch (val2) {
>    154		case 50000:
>    155			new_it = 0x00;
>    156			it_idx = 4;
>    157			break;
>    158		case 100000:
>    159			new_it = 0x01;
>    160			it_idx = 3;
>    161			break;
>    162		case 200000:
>    163			new_it = 0x02;
>    164			it_idx = 2;
>    165			break;
>    166		case 400000:
>    167			new_it = 0x03;
>    168			it_idx = 1;
>    169			break;
>    170		case 800000:
>    171			new_it = 0x04;
>    172			it_idx = 0;
>    173			break;
>    174		default:
>    175			return -EINVAL;
>    176		}
>    177	
>    178		ret = regmap_field_write(data->rf.it, new_it);
>    179		if (ret) {
>    180			dev_err(data->dev,
>    181				"failed to update integration time: %d\n", ret);
>    182			return ret;
>    183		}
>    184	
>    185		return 0;
>    186	}
>    187	
>    188	static int veml3235_set_gain(struct iio_dev *indio_dev, int val, int val2)
>    189	{
>    190		struct veml3235_data *data = iio_priv(indio_dev);
>  > 191		int ret, new_gain, gain_idx;
>    192	
>    193		if (val2 != 0)
>    194			return -EINVAL;
>    195	
>    196		switch (val) {
>    197		case 1:
>    198			new_gain = 0x00;
>    199			gain_idx = 3;
>    200			break;
>    201		case 2:
>    202			new_gain = 0x01;
>    203			gain_idx = 2;
>    204			break;
>    205		case 4:
>    206			new_gain = 0x03;
>    207			gain_idx = 1;
>    208			break;
>    209		case 8:
>    210			new_gain = 0x07;
>    211			gain_idx = 0;
>    212			break;
>    213		default:
>    214			return -EINVAL;
>    215		}
>    216	
>    217		ret = regmap_field_write(data->rf.gain, new_gain);
>    218		if (ret) {
>    219			dev_err(data->dev, "failed to set gain: %d\n", ret);
>    220			return ret;
>    221		}
>    222	
>    223		return 0;
>    224	}
>    225	
> 


Unused as there is no processed values anymore. I will drop them for v4.

