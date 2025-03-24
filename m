Return-Path: <linux-iio+bounces-17249-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7030A6DC13
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 14:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7420616B4D5
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 13:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8796A25DD14;
	Mon, 24 Mar 2025 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PT6FtSzu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2D8FC0A
	for <linux-iio@vger.kernel.org>; Mon, 24 Mar 2025 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824222; cv=none; b=ZgAe8ELsbFlWiuNbrEkjsE8iIf9JKwWTmEtKZ/ZoN33ecyNgEZRXf8Pgt4Kg+sG4HUy+mloc9AdQOkm1XQ5LTvsS1jOZrkIWhcpZwD2u+K2+tzT7E6hazmJ39wmfd/oQH6udDEMiRnY2us5KsMXOjsMUh8E2ELyw7DVqMOL0g34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824222; c=relaxed/simple;
	bh=idBIRQzC41pEK3vxHCsW3jlGzyWUmPmwM/kPI+tS88M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WAnZ3K/k9yGOkHIake+Zql+eL+UdT126PORqoETU3D4m/neqEVxwflw5sVMfLyVQxEoR4IaTeMfUvgA/D5ZW4ceegkytm7Pxbji5/wLTP/1VudRTW9L/HLxywwhvZ/Y9tGFM9GMOqQ/eYhMhXM7/57pb21T6lTnYMZB28ud9BnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PT6FtSzu; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-601a4e037a5so2223146eaf.3
        for <linux-iio@vger.kernel.org>; Mon, 24 Mar 2025 06:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742824218; x=1743429018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CdxeeM9Wzx2ULG71chhuAoOD2bPZ1lIe5eeC/XTvSI0=;
        b=PT6FtSzugs9idtT+MOVtd9b+l+JbWZoUvXNYG6mZYJkke2IfyJIgp2374Pooy2o2Ko
         cq0tJ3PkxyZAhimIbf1N+Tkp0Nz5z8ANJhr7AfHvpYMh/NjcZ9tmcUxlG1wWY1glK+vt
         CQAnf3pFLC2x1HjCPMJVDKzqFTq+6vSBl0yJpJAsEQgywzm8FqJm0F9Rpyj/WThX8fb9
         fzKQb9s8jlT4BO9xGUbD4LPphn3VpGqvCjUgPdq+jNiDvdqvB+eV+IK8DusxAu6K5e31
         cC3ZIF/t/9QCFaSn5wtQFMW0pbDEF13Sjh4BJK+QTapuFfMgDei93XBPRg/A+fhM21My
         h7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742824218; x=1743429018;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CdxeeM9Wzx2ULG71chhuAoOD2bPZ1lIe5eeC/XTvSI0=;
        b=B++69hmaGhG88FIwDDPOpPZxpFf+6gDJvPOEtArPjx9O8b1V9UytqgDIaKkLpb2liW
         Sr7c/qowvZCnF834+YArLsfU2rXvb+sXpjVEL8ga9PZgP0GHWg0ZXvawjny7+vmQi3en
         d9RtRaMxpiSmBJpotG8sD9vFx4Hjxj+Z8M+EYmEe48TOQopqYeiMaQaTQ1d+gHNORkBW
         JO5P4v3YXUeyRabKpb+xrKD77UA9ZX0a2RLn7CTna6u23haVFCsK0W/DQ9nNwRm9gbXv
         +zd5dERUbfwjVmeINb9LYM32n2pLTewIRmO1/J+7XCvig/NCMlAVVusbpVQDJq7t55AK
         fthQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEYewZZZRBV/2RKw+bqB7kJzp9Qgpzzdgo97HSC73F7d2YXhwVATVOjXtNm8cIMWJLoOinu9SkakA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW8L58oyDCboaDxRWklQcDxAyV6CIogHlBJ84LMdd1z0/UHDQQ
	D/LciP5ZOGBn13Wf23BNEkIDyYN0E0K2sMIImiDwPKXMqIHo0NjSu7KOijGNeys=
X-Gm-Gg: ASbGncsXgtLOLdn+OS02I9r0jG9Zf24+zTVNPAEkk16OG+3Tu0wl2pvVpKkxIWUH+dO
	iKDs+gvGmAk2V/GVDEYH47rQ3zbT9fT2iNxSfVZyBMh+FMJ/otjYa7v7A1EcHPF/7IWvZqUhhi/
	14DYIZkMqm9GD7tePnrrcMcko3wgkTACYWsTa6viZfVMlqF4LUZBVDCRxKOs2dm/Nb2w9lNPJkP
	WpVpJFzZBqzU0p/wJhLUBw27H7d6yXwJrrotj7Q7NrL1Cag9aZ0sqhCi1m940Y3Tm37/P+FLlQl
	V132DtWbfcXwxGyksndDRt00f1Sgkti5VY3ypHQahOGPepmoyC60xnx8VDaMObMInE8/VIV4eia
	vWkFhiw==
X-Google-Smtp-Source: AGHT+IGUKGUnBQQj8euBvc40iv5UxLc92QmBpQeJUNQcD9g9q1Gn7KRpSWRrk0DYtdOznF3qMa6O7Q==
X-Received: by 2002:a05:6871:530b:b0:29e:3de0:d400 with SMTP id 586e51a60fabf-2c77fdcc096mr8345834fac.0.1742824217751;
        Mon, 24 Mar 2025 06:50:17 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c77f0f3fbcsm2025356fac.49.2025.03.24.06.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 06:50:17 -0700 (PDT)
Message-ID: <4854b569-5032-4b75-80a6-8c5822845dc7@baylibre.com>
Date: Mon, 24 Mar 2025 08:50:15 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] iio: adc: ad7606: dynamically allocate channel
 info
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Alexandru Ardelean <aardelean@baylibre.com>,
 Beniamin Bia <beniamin.bia@analog.com>, Stefan Popa
 <stefan.popa@analog.com>, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
References: <72d776ae-4373-4a78-ba00-fa809478b453@stanley.mountain>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <72d776ae-4373-4a78-ba00-fa809478b453@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/22/25 12:25 PM, Dan Carpenter wrote:
> Hi David,
> 
> kernel test robot noticed the following build warnings:
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/iio-adc-ad7606-check-for-NULL-before-calling-sw_mode_config/20250319-065737
> base:   9f36acefb2621d980734a5bb7d74e0e24e0af166
> patch link:    https://lore.kernel.org/r/20250318-iio-adc-ad7606-improvements-v2-9-4b605427774c%40baylibre.com
> patch subject: [PATCH v2 09/10] iio: adc: ad7606: dynamically allocate channel info
> config: arm64-randconfig-r071-20250322 (https://download.01.org/0day-ci/archive/20250322/202503222246.RafigmhQ-lkp@intel.com/config)
> compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project c2692afc0a92cd5da140dfcdfff7818a5b8ce997)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202503222246.RafigmhQ-lkp@intel.com/
> 
> smatch warnings:
> drivers/iio/adc/ad7606.c:1270 ad7606_probe_channels() warn: potentially one past the end of array 'channels[i]'
> 
> vim +1270 drivers/iio/adc/ad7606.c
> 
> 87cf5705725eeb David Lechner      2025-03-18  1196  static int ad7606_probe_channels(struct iio_dev *indio_dev)
> e571c1902116a3 Alexandru Ardelean 2024-09-19  1197  {
> e571c1902116a3 Alexandru Ardelean 2024-09-19  1198  	struct ad7606_state *st = iio_priv(indio_dev);
> 87cf5705725eeb David Lechner      2025-03-18  1199  	struct device *dev = indio_dev->dev.parent;
> 87cf5705725eeb David Lechner      2025-03-18  1200  	struct iio_chan_spec *channels;
> 87cf5705725eeb David Lechner      2025-03-18  1201  	bool slow_bus;
> 87cf5705725eeb David Lechner      2025-03-18  1202  	int ret, i;
> 87cf5705725eeb David Lechner      2025-03-18  1203  
> 87cf5705725eeb David Lechner      2025-03-18  1204  	slow_bus = !st->bops->iio_backend_config;
> 87cf5705725eeb David Lechner      2025-03-18  1205  	indio_dev->num_channels = st->chip_info->num_adc_channels;
> 87cf5705725eeb David Lechner      2025-03-18  1206  
> 87cf5705725eeb David Lechner      2025-03-18  1207  	/* Slow buses also get 1 more channel for soft timestamp */
> 87cf5705725eeb David Lechner      2025-03-18  1208  	if (slow_bus)
> 87cf5705725eeb David Lechner      2025-03-18  1209  		indio_dev->num_channels++;
> 87cf5705725eeb David Lechner      2025-03-18  1210  
> 87cf5705725eeb David Lechner      2025-03-18  1211  	channels = devm_kcalloc(dev, indio_dev->num_channels, sizeof(*channels),
> 87cf5705725eeb David Lechner      2025-03-18  1212  				GFP_KERNEL);
> 87cf5705725eeb David Lechner      2025-03-18  1213  	if (!channels)
> f3838e934dfff2 Alexandru Ardelean 2024-09-19  1214  		return -ENOMEM;
> f3838e934dfff2 Alexandru Ardelean 2024-09-19  1215  
> 87cf5705725eeb David Lechner      2025-03-18  1216  	for (i = 0; i < indio_dev->num_channels; i++) {

The fix is to change this line to:

							for (i = 0; i < st->chip_info->num_adc_channels; i++) {

> 87cf5705725eeb David Lechner      2025-03-18  1217  		struct iio_chan_spec *chan = &channels[i];
> 87cf5705725eeb David Lechner      2025-03-18  1218  
> 87cf5705725eeb David Lechner      2025-03-18  1219  		chan->type = IIO_VOLTAGE;
> 87cf5705725eeb David Lechner      2025-03-18  1220  		chan->indexed = 1;
> 87cf5705725eeb David Lechner      2025-03-18  1221  		chan->channel = i;
> 87cf5705725eeb David Lechner      2025-03-18  1222  		chan->scan_index = i;
> 87cf5705725eeb David Lechner      2025-03-18  1223  		chan->scan_type.sign = 's';
> 87cf5705725eeb David Lechner      2025-03-18  1224  		chan->scan_type.realbits = st->chip_info->bits;
> 87cf5705725eeb David Lechner      2025-03-18  1225  		chan->scan_type.storagebits = st->chip_info->bits > 16 ? 32 : 16;
> 87cf5705725eeb David Lechner      2025-03-18  1226  		chan->scan_type.endianness = IIO_CPU;
> f3838e934dfff2 Alexandru Ardelean 2024-09-19  1227  
> 87cf5705725eeb David Lechner      2025-03-18  1228  		if (indio_dev->modes & INDIO_DIRECT_MODE)
> 87cf5705725eeb David Lechner      2025-03-18  1229  			chan->info_mask_separate |= BIT(IIO_CHAN_INFO_RAW);
> 87cf5705725eeb David Lechner      2025-03-18  1230  
> 87cf5705725eeb David Lechner      2025-03-18  1231  		if (st->sw_mode_en) {
> 87cf5705725eeb David Lechner      2025-03-18  1232  			chan->info_mask_separate |= BIT(IIO_CHAN_INFO_SCALE);
> 87cf5705725eeb David Lechner      2025-03-18  1233  			chan->info_mask_separate_available |=
> 87cf5705725eeb David Lechner      2025-03-18  1234  				BIT(IIO_CHAN_INFO_SCALE);
> 87cf5705725eeb David Lechner      2025-03-18  1235  
> 87cf5705725eeb David Lechner      2025-03-18  1236  			/*
> 87cf5705725eeb David Lechner      2025-03-18  1237  			 * All chips with software mode support oversampling,
> 87cf5705725eeb David Lechner      2025-03-18  1238  			 * so we skip the oversampling_available check. And the
> 87cf5705725eeb David Lechner      2025-03-18  1239  			 * shared_by_type instead of shared_by_all on slow
> 87cf5705725eeb David Lechner      2025-03-18  1240  			 * buses is for backward compatibility.
> 87cf5705725eeb David Lechner      2025-03-18  1241  			 */
> 87cf5705725eeb David Lechner      2025-03-18  1242  			if (slow_bus)
> 87cf5705725eeb David Lechner      2025-03-18  1243  				chan->info_mask_shared_by_type |=
> 87cf5705725eeb David Lechner      2025-03-18  1244  					BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
> 87cf5705725eeb David Lechner      2025-03-18  1245  			else
> 87cf5705725eeb David Lechner      2025-03-18  1246  				chan->info_mask_shared_by_all |=
> 87cf5705725eeb David Lechner      2025-03-18  1247  					BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
> 87cf5705725eeb David Lechner      2025-03-18  1248  
> 87cf5705725eeb David Lechner      2025-03-18  1249  			chan->info_mask_shared_by_all_available |=
> 87cf5705725eeb David Lechner      2025-03-18  1250  				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
> 87cf5705725eeb David Lechner      2025-03-18  1251  		} else {
> 87cf5705725eeb David Lechner      2025-03-18  1252  			chan->info_mask_shared_by_type |=
> 87cf5705725eeb David Lechner      2025-03-18  1253  				BIT(IIO_CHAN_INFO_SCALE);
> 87cf5705725eeb David Lechner      2025-03-18  1254  
> 87cf5705725eeb David Lechner      2025-03-18  1255  			if (st->chip_info->oversampling_avail)
> 87cf5705725eeb David Lechner      2025-03-18  1256  				chan->info_mask_shared_by_all |=
> 87cf5705725eeb David Lechner      2025-03-18  1257  					BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
> 87cf5705725eeb David Lechner      2025-03-18  1258  		}
> 87cf5705725eeb David Lechner      2025-03-18  1259  
> 87cf5705725eeb David Lechner      2025-03-18  1260  		if (!slow_bus)
> 87cf5705725eeb David Lechner      2025-03-18  1261  			chan->info_mask_shared_by_all |=
> 87cf5705725eeb David Lechner      2025-03-18  1262  				BIT(IIO_CHAN_INFO_SAMP_FREQ);
> 87cf5705725eeb David Lechner      2025-03-18  1263  
> 87cf5705725eeb David Lechner      2025-03-18  1264  		ret = st->chip_info->scale_setup_cb(indio_dev, chan);
> e571c1902116a3 Alexandru Ardelean 2024-09-19  1265  		if (ret)
> e571c1902116a3 Alexandru Ardelean 2024-09-19  1266  			return ret;
> e571c1902116a3 Alexandru Ardelean 2024-09-19  1267  	}
> e571c1902116a3 Alexandru Ardelean 2024-09-19  1268  
> 87cf5705725eeb David Lechner      2025-03-18  1269  	if (slow_bus)
> 87cf5705725eeb David Lechner      2025-03-18 @1270  		channels[i] = (struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(i);
>                                                                 ^^^^^^^^^^^
> i is == indio_dev->num_channels so this is out of bounds by one element.
> 
> 87cf5705725eeb David Lechner      2025-03-18  1271  
> 87cf5705725eeb David Lechner      2025-03-18  1272  	indio_dev->channels = channels;
> 87cf5705725eeb David Lechner      2025-03-18  1273  
> e571c1902116a3 Alexandru Ardelean 2024-09-19  1274  	return 0;
> e571c1902116a3 Alexandru Ardelean 2024-09-19  1275  }
> 


