Return-Path: <linux-iio+bounces-12775-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298E19DB639
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 12:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7CEDB24D5C
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 11:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25B41946C8;
	Thu, 28 Nov 2024 11:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmObTLCw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A84F1925B3;
	Thu, 28 Nov 2024 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732791996; cv=none; b=IL3kkDrD49HnF3EC4tWDbBiSpJtKc78b8eScQbeMxva9AhynefrqDNRvwx+aC9q1GfWmy4yL3QdDkB9UwYs+HPRk99+Nk9HoJl/sZmLzYYEam05TwCPE46VyB04TV9+u49be8eBxtUa5t9wO9wi57o/uBzyHc5wg0aG7lZsLmw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732791996; c=relaxed/simple;
	bh=6V422H3dv9Du3URUJSLpBRw4S2JgulSIk6Z4elejc8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MEz/PuD8HQVQxJB5KmM07PiPTf7xnR3L+scyHTCRXTmKkpizmp0ntQGyPFDbm5GBVRWTeDqcWz3zkTkZ+41NAS8kpJ4xlV2mr4KgFOOTXaz7DJELkJyIc+XtplxmvtZOeAZXAxXRynrSqDh6q+xsuLRcfYeJS063eRVVE5fcJ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmObTLCw; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cfe5da1251so827343a12.1;
        Thu, 28 Nov 2024 03:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732791992; x=1733396792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9kV/k8UgkB5xu8Vp6e9vyAiETa22BHIqam0AP21cVfk=;
        b=BmObTLCwgUCBKjsgevZpZCO+dq4aE+8t/quClI+fI+JAdR6LW0x5QWbO9Rn4kXoBz0
         UQvWDFVN4viOxaBNduu7oyz1LsOqMSMz8Nt3cpINUJnrhAScEg/8+TF5JCD4WcdYDcm7
         BYF0+26goR2Nt/RHeaks4FXYszGSLJZaN5p7Tow1d4yUk6uzrX16PEphphLZz/ic2XwU
         OjCV5NCpFAOox1402sz7YniwAORrsYSP1LwhMzVRQL1Hfta7q71pjK3WyYLWWCHIC9Py
         FmrTfg1CId24vgRDQVr13BC++N18iJZxDQDLUUVD7yAjbbAFf6g+ktXTSKZfi+54IkOH
         +hFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732791992; x=1733396792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9kV/k8UgkB5xu8Vp6e9vyAiETa22BHIqam0AP21cVfk=;
        b=V0Omrz47qTZoxVHe6iUycHBPID8aJX/hq/OjtgFHNKWW3GciX+9Z8PfnMBuPyFbeqp
         IkVHpXJEnVUC02IGsw6hdrUBcuXocgyBnT5CMrzXzAR9NL0fEN4O++Ru3OYzBGyZE/FF
         vULws5dea/IZsvwCzueojNNdY9OLr6LkC9RvQ1GOn0ltApQFuu3mlkvKre0IPA0qhAr2
         KkEmW9L8KH38nqr41EyUVcRMnNUOTU02DSPwOZiJZAMXnmeHK93xFM27RVieEcrc1kY/
         OBNTM5dLyHIg4BadtMpH94QP0xMaXDROeg6nki18pMZvRFbZxRbLxtzxtRqleK75a45J
         LXEg==
X-Forwarded-Encrypted: i=1; AJvYcCUdDEwSByIOEkTsSLId9qdnXXkyARrj+RWgbZK23hbSnRUSeADDCPFcuZXVWvrhW6hHD4oiFeNMY8HZ@vger.kernel.org, AJvYcCUprJexEf8kikfPhrHNawYEOjqJVeOrcWT237q+mssDfVgf0yleO3SyEaNRC76c/0S1yJLgidkPAzr+@vger.kernel.org, AJvYcCWUpf/bye3VdvFOoDQ5IiOm6zSRzSs7bRYuk9iSUJ8E8J3MPQxgyRgzKoMXUJSgIiJTBvbrcZ2zTY3DTMtY@vger.kernel.org
X-Gm-Message-State: AOJu0YziNJVr+NuiQ1omIHoEn0GDjNVFX8lywjf4QUCwg7EsIjOYkcGz
	A9yD6rZlCvi91kuPFNPoBS43LXF0mJdIzOIla87nbrrWY/c85Hc1
X-Gm-Gg: ASbGncsE7lsVds/wbqDRwzsgwAWW5sO+k6qGCORYq1v6ZgH0a4n2OOkKOIO7zdnZe0I
	IBzBHu2IY6c0dkODFamPa9wM72p4EqQOOqpBmW2I7Gjuq2fQ8H7MgytzIhcsnA3zjJuB5RFxOhd
	sV1jdgyrvw3rx8O6z7f00fYTG/wX325kDPWt09WvDn8PZgunNNkWHgFvK5egeeLvvB7RAgURkIC
	cKN8Q6qV3B8dSIr5++rvuMeQU4jtVRU1r0CFSHtfRd5B1hSg1wgT5P3ezXx+bdHp28ZFuRiiLXU
	DuCO9XRgowtfrMlhgWYmsBv6Y+ZN
X-Google-Smtp-Source: AGHT+IEt+yji9PcxnQ+E0O8I0V88q//kI+oMuOkt2imlBetGr6zJPVZjJVQM8OabiGmvpeJjBAnoLQ==
X-Received: by 2002:a05:6402:2353:b0:5cf:f1fd:c687 with SMTP id 4fb4d7f45d1cf-5d080c97f34mr5911678a12.24.1732791991802;
        Thu, 28 Nov 2024 03:06:31 -0800 (PST)
Received: from [10.10.40.97] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d098330dd2sm604660a12.14.2024.11.28.03.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 03:06:30 -0800 (PST)
Message-ID: <c07b7375-327e-44bd-907a-73771e9f938e@gmail.com>
Date: Thu, 28 Nov 2024 12:06:28 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: light: add support for veml6031x00 ALS series
To: kernel test robot <lkp@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Rishi Gupta <gupt21@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241126-veml6031x00-v1-2-4affa62bfefd@gmail.com>
 <202411281741.xz7mD4E2-lkp@intel.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <202411281741.xz7mD4E2-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/11/2024 10:55, kernel test robot wrote:
> Hi Javier,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on a61ff7eac77e86de828fe28c4e42b8ae9ec2b195]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Javier-Carrasco/dt-bindings-iio-light-veml6030-add-veml6031x00-ALS-series/20241128-104104
> base:   a61ff7eac77e86de828fe28c4e42b8ae9ec2b195
> patch link:    https://lore.kernel.org/r/20241126-veml6031x00-v1-2-4affa62bfefd%40gmail.com
> patch subject: [PATCH 2/2] iio: light: add support for veml6031x00 ALS series
> config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20241128/202411281741.xz7mD4E2-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241128/202411281741.xz7mD4E2-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411281741.xz7mD4E2-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/iio/light/veml6031x00.c: In function 'veml6031x00_set_scale':
>>> drivers/iio/light/veml6031x00.c:422:24: warning: variable 'gain_idx' set but not used [-Wunused-but-set-variable]
>      422 |         int new_scale, gain_idx;
>          |                        ^~~~~~~~
> 
> 
> vim +/gain_idx +422 drivers/iio/light/veml6031x00.c
> 
>    418	
>    419	static int veml6031x00_set_scale(struct iio_dev *iio, int val, int val2)
>    420	{
>    421		struct veml6031x00_data *data = iio_priv(iio);
>  > 422		int new_scale, gain_idx;
>    423	
>    424		if (val == 0 && val2 == 125000) {
>    425			new_scale = FIELD_PREP(VEML6031X00_CONF1_GAIN, 0x03) |
>    426				VEML6031X00_CONF1_PD_D4;
>    427			gain_idx = 0;
>    428		} else if (val == 0 && val2 == 165000) {
>    429			new_scale = FIELD_PREP(VEML6031X00_CONF1_GAIN, 0x02) |
>    430				VEML6031X00_CONF1_PD_D4;
>    431			gain_idx = 1;
>    432		} else if (val == 0 && val2 == 250000) {
>    433			new_scale = FIELD_PREP(VEML6031X00_CONF1_GAIN, 0x00) |
>    434				VEML6031X00_CONF1_PD_D4;
>    435			gain_idx = 2;
>    436		} else if (val == 0 && val2 == 500000) {
>    437			new_scale = FIELD_PREP(VEML6031X00_CONF1_GAIN, 0x03);
>    438			gain_idx = 3;
>    439		} else if (val == 0 && val2 == 660000) {
>    440			new_scale = FIELD_PREP(VEML6031X00_CONF1_GAIN, 0x02);
>    441			gain_idx = 4;
>    442		} else if (val == 1 && val2 == 0) {
>    443			new_scale = FIELD_PREP(VEML6031X00_CONF1_GAIN, 0x00);
>    444			gain_idx = 5;
>    445		} else if (val == 2 && val2 == 0) {
>    446			new_scale = FIELD_PREP(VEML6031X00_CONF1_GAIN, 0x01);
>    447			gain_idx = 6;
>    448		} else {
>    449			return -EINVAL;
>    450		}
>    451	
>    452		return regmap_update_bits(data->regmap, VEML6031X00_REG_CONF1,
>    453					 VEML6031X00_CONF1_GAIN |
>    454					 VEML6031X00_CONF1_PD_D4,
>    455					 new_scale);
>    456	}
>    457	
> 

The gain_idx variable is a leftover of a previous approach where
processed values were also provided. But given that the conversion is
linear (raw * scale), processed values were dropped. I will also drop
this variable for v2 with the rest of the feedback I could get from this v1.

Best regards,
Javier Carrasco


