Return-Path: <linux-iio+bounces-12024-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 303AF9C1AB8
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 11:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533021C26833
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 10:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0641E32CE;
	Fri,  8 Nov 2024 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWDScEZ6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F8A1E5739;
	Fri,  8 Nov 2024 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731062015; cv=none; b=RQXDYMF7oyV/fH8NyKwR+JjMV/5heeApr4U+o/S/xioQ1CfNgFL/8mIgyRwhVbvUM/0uBleb9kIww3nIpnf7f2m9k2FA8+BI39Uo7ZpNH6pote/Z7SDjnkRg3KumuW6eJIEZT7or/+d8M4ChNUfq1Q551EPXjh3erGGVcxGTJtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731062015; c=relaxed/simple;
	bh=KxMStCD8O5sR+ziGmKPiHtWoXQum/CRCg9cCdsNOX2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INSJfDp/cdontQksf/+onlkiuSqwthXqOwTCGFlcp5WGtgFfBf4dB4qCvaqHPJMhXgSGlD1XuNE/B/MB+nXMuv1UwbmhzZnEwWrGwU5hmyD463bTDtRpDN/D+vsCqErtFlFQIUi2JpNz5pvfRkjLMzVKQbxfqjL+TfgnOejdT1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWDScEZ6; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5ceb75f9631so2443256a12.0;
        Fri, 08 Nov 2024 02:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731062011; x=1731666811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=say4a8HZSCpRMrLiH7BqEglV9Ia5G13yVfGZKq/ufis=;
        b=IWDScEZ6SYYIxfBcy6tq1IYmdQWz9CSCjRC+6Y8SD+1MaEmOrCxtX2ZMHJQ/Fpwh25
         PtCNPc/XSbrdnQwlIEtkLTAqFURnZOlbf/JWkfWyRXKIu6FpUTb4Tn69LSoHryGDJ4fm
         v/ZSL0b9dEiq7YZran7em7p8s8uMec/Jj4s60VFcW3K0faStTYYfM7qnAWsZHEdXyy1O
         nIMVRvFQ5xLfIinN/aWskMcpg62AihNrn2cMEMAthS4KZKDA2+Mdd/Me0Oqc7+1c6m0p
         Wf1u+7iHWBMzdHKG2r7vDPeLsm7Pwu5nawUSLNH01Q6uUEiDSc8fmWhv/YKMpOG0f9eR
         9+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731062011; x=1731666811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=say4a8HZSCpRMrLiH7BqEglV9Ia5G13yVfGZKq/ufis=;
        b=AWO1bt0lSqNol/9aRkB+mKVUWcapYlLE1eH03nmK5kDXSsY7KdLHr9QqImqby+0H+y
         1mYJ8651JgL9CgOIr8WobYrKdLirmOemsw40aFWxb3Z4HMcNzyKEUOsSlXCcXqB8xHuc
         MFeMEQCW6du2QeCF/MZbUvS1DcC2wxBDOVEaHpNOIer3tKbxAL3S9hy0snETknOReJdJ
         GKYLRvUpuzQkQmuxmGgfFND5Un9aiJAlhdziZvCcexYMhr9oUMu13uf9gKKPXHDWCtAI
         WQF+vFCQWmaOFBQym2tToWjffviGy/O2igoy4YYMzQxos47T6yQs9gGJNasq3QgrYDuC
         GDMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmR/NV0HicH9DP6qp+l3Rmnm6xqKWMt04ym5yhnQDk9SsNdVlmfj8ry6mA4Kh7bYDnZGkOnEbJwHM=@vger.kernel.org, AJvYcCXlUNPjxca2lU8NevuLvhK1lYSo5OdtHYPnCpsAafmqc0VpXuBerVKnKJDLD4dYXu6FvwEn+pMWSaqWn70b@vger.kernel.org
X-Gm-Message-State: AOJu0YyW86l+hDgr80Kavvk9nzUw+expzsnE6oTyZEIvuZV+7MblAexc
	JQM/McXAY2QupvGUNFhH8uL+nZcTFh9SXvRmrgKAAouysmAZsFIedTCgEw==
X-Google-Smtp-Source: AGHT+IH6SbnJDhnOo+P4X7t5LTjB6WoMVghmVCUWwRJfZp0LeUW2NZpfgNYdyUiXXfnc7FGQqqThMQ==
X-Received: by 2002:a05:6402:268e:b0:5c9:76b6:d14e with SMTP id 4fb4d7f45d1cf-5cf0a31f545mr1881877a12.16.1731062010505;
        Fri, 08 Nov 2024 02:33:30 -0800 (PST)
Received: from [10.10.40.97] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03b7f2b8sm1823499a12.32.2024.11.08.02.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 02:33:28 -0800 (PST)
Message-ID: <17464711-bdc2-46c9-a216-93851112abbb@gmail.com>
Date: Fri, 8 Nov 2024 11:33:27 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: veml6030: add support for triggered buffer
To: kernel test robot <lkp@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241107-veml6030_triggered_buffer-v1-1-4810ab86cc56@gmail.com>
 <202411081703.Ft0YjqcK-lkp@intel.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <202411081703.Ft0YjqcK-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/11/2024 10:41, kernel test robot wrote:
> Hi Javier,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on c9f8285ec18c08fae0de08835eb8e5953339e664]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Javier-Carrasco/iio-light-veml6030-add-support-for-triggered-buffer/20241108-042332
> base:   c9f8285ec18c08fae0de08835eb8e5953339e664
> patch link:    https://lore.kernel.org/r/20241107-veml6030_triggered_buffer-v1-1-4810ab86cc56%40gmail.com
> patch subject: [PATCH] iio: light: veml6030: add support for triggered buffer
> config: i386-randconfig-062-20241108 (https://download.01.org/0day-ci/archive/20241108/202411081703.Ft0YjqcK-lkp@intel.com/config)
> compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241108/202411081703.Ft0YjqcK-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411081703.Ft0YjqcK-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>>> drivers/iio/light/veml6030.c:958:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 @@     got int [addressable] reg @@
>    drivers/iio/light/veml6030.c:958:39: sparse:     expected restricted __le16
>    drivers/iio/light/veml6030.c:958:39: sparse:     got int [addressable] reg
> 
> vim +958 drivers/iio/light/veml6030.c
> 
>    944	
>    945	static irqreturn_t veml6030_trigger_handler(int irq, void *p)
>    946	{
>    947		struct iio_poll_func *pf = p;
>    948		struct iio_dev *iio = pf->indio_dev;
>    949		struct veml6030_data *data = iio_priv(iio);
>    950		int i, ret, reg;
>    951		int j = 0;
>    952	
>    953		iio_for_each_active_channel(iio, i) {
>    954			ret = regmap_read(data->regmap, VEML6030_REG_DATA(i), &reg);
>    955			if (ret)
>    956				goto done;
>    957	
>  > 958			data->scan.chans[j++] = reg;

chans is currently declared as __le16 chans[2], but it should be u16
chans[2], as regmap already handles the endianness.

Then the direct assignment does not raise any warnings. When at it, I
will define reg as unsigned int.

>    959		}
>    960	
>    961		iio_push_to_buffers_with_timestamp(iio, &data->scan, pf->timestamp);
>    962	
>    963	done:
>    964		iio_trigger_notify_done(iio->trig);
>    965	
>    966		return IRQ_HANDLED;
>    967	}
>    968	
> 

Best regards,
Javier Carrasco

