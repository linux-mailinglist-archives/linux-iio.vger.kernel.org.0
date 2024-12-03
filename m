Return-Path: <linux-iio+bounces-13025-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 261DC9E213B
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 16:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F01C1B26000
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 13:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B691EB9EB;
	Tue,  3 Dec 2024 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="GZJ3PeU8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C96A1E3DCF
	for <linux-iio@vger.kernel.org>; Tue,  3 Dec 2024 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233221; cv=none; b=aJSFFN4Jfe4MEaEoG43ghOXg+pTzhBelbV0P1yZ8SjSKSDhVOyLzE72f8A1owWhxAVsFyNVxXrnV04HHqvYh79eDZyTpr9w45b4XYmTv10UdIq4y/vgSGV2QSv9qC/JHj07v5ZwSRWm8Cgje3CXYP/8kOmeZ32zREnQMmQLfY64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233221; c=relaxed/simple;
	bh=gVds39EeL4HS6vcGaHXuEyB+vHQeohJ5fv2/hLPIul4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+UasfJyWVBeBgidDK02H5VrJd+DajO6Vq+UOQDpaxkJUU0MpOV46NhNcYzPZuHXxYvTKQkd10vmtdhy05HKAvw+d8aUNmO88xzAbrcJSByEsKMYXKIumhfn/12s+H07WuprhSZ1Eay/z9LaTqa/3zyTiEMjaUeN9Bc+79kB0jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=GZJ3PeU8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4349fb56260so48439275e9.3
        for <linux-iio@vger.kernel.org>; Tue, 03 Dec 2024 05:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733233218; x=1733838018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xEoCnIl9TBM7hPMoS20hxmppTJP/LxiF7FoXkx67aU4=;
        b=GZJ3PeU8VnU9pLKWvDKVZm5sEMXDYkETuYBchqHHHYenHH0al5S2YjBNJ8fRLZw75t
         g5Trmf9qympemvmVGa8Pr7ND49RFgGRrYdrzcOviULkOoKHrUs2VCisdtUMgidXXHIot
         KLHjmY9X6wEwr6BMvNTQcjutS5Yy+ILThetfGnwIVBya/EqEH1fXpBn+Wtcm359Zeq9d
         H9ZmPNkfH3DK0tXvSymCymynzQAdUg1B7VdGAZecVCeZSWBLESukvu9M/UqYggnoTwjV
         WO79jfWQUB9Vl5RVZHR5Ay98us9dcB5Bi2lIa0dwmB8JChjBOFreN460cj/+w8aWVyoU
         PM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733233218; x=1733838018;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xEoCnIl9TBM7hPMoS20hxmppTJP/LxiF7FoXkx67aU4=;
        b=Mkxny9N8PqNtsLVFKbmBBjvjg6hVDRRK0np+y8sboklV8mNXyC6a1rO9QMlhIzZdbQ
         H2o6i+SV4Nkyoo5W9T6/h1cSbQxunPAMw6Y7KxPure0wtIKk3J79eNoluqITmU2r4EbK
         8JtSPtXeFj3/bc1FyoFomGaZmXs7roE9v7VK1cA3yMLfwm4S2AqsBtH9iE2410l7/cOr
         QCRDUvqvJrUVPBpnFjqOtoFNVpMb/3AZXN1mBh4xH9ywnXPTjIrrALdoxCM8oR2hsapn
         jvD/qteRj+LUUoC3bH9TSwX/94inM/GZN3dfvnc8dgxkUNd3O7/JL9INYsYnNqK/EeII
         J+9A==
X-Gm-Message-State: AOJu0YzXn8JcO3o1YA9tsUHKgE2bT3FtmVRY9eZ/3gmpziHM1eXnIIh+
	WBrcyJ2DwERBd4GHx0T9KbO/afEsNvrFmM/9meV4qi+U9HoEHcBYJmQ0fETsd8Q=
X-Gm-Gg: ASbGnctFNsc6XaUNBbRlpp8E+/Jf/TZb9RPNrWUiS7tPrSffmgDXJ7fvpMBeXqN7B40
	u4JTdU7JGeh5m93e29R8SnYDYNx0R7Gt/HSeDDOg55Y+EDQec8xjdW7yqOaTgvuC1qNUjODT2M+
	b8tg6SCR5wCBOYPJzvttPmaw97D5Xgb9GRN5Ltv2e35TrB2KpiH8Pk3iOQJj6YSXUMrQpvJkgdV
	4ZfdZHlPbG6V/gV70/oUdB+XxnL1xMBOE8q38pxORQifFe88f5I4g+Aqfc=
X-Google-Smtp-Source: AGHT+IEkPw+a3028ZQyrhsgmHH+SzklBTFms6yyL7p+03ifSENO+S3RHSgC/4IQpypF76SJjGitgmA==
X-Received: by 2002:a05:600c:4ed2:b0:434:a7b6:10e0 with SMTP id 5b1f17b1804b1-434d09d00c5mr22741135e9.18.1733233217778;
        Tue, 03 Dec 2024 05:40:17 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434c132b4c8sm122292095e9.36.2024.12.03.05.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 05:40:17 -0800 (PST)
Message-ID: <3f2dc65c-61e9-4d4b-9610-4b106bb691cc@tuxon.dev>
Date: Tue, 3 Dec 2024 15:40:15 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] iio: adc: rzg2l_adc: Simplify the runtime PM code
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 prabhakar.mahadev-lad.rj@bp.renesas.com, jic23@kernel.org, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
 <20241203111314.2420473-4-claudiu.beznea.uj@bp.renesas.com>
 <9fbf057c-164b-4451-85a8-cf4d5807b4c1@bp.renesas.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <9fbf057c-164b-4451-85a8-cf4d5807b4c1@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Paul,

On 03.12.2024 14:53, Paul Barker wrote:
> Hi Claudiu,
> 
> On 03/12/2024 11:13, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> All Renesas SoCs using the rzg2l_adc driver manage ADC clocks through PM
>> domains. Calling pm_runtime_{resume_and_get, put_sync}() implicitly sets
>> the state of the clocks. As a result, the code in the rzg2l_adc driver that
>> explicitly manages ADC clocks can be removed, leading to simpler and
>> cleaner implementation.
>>
>> Additionally, replace the use of rzg2l_adc_set_power() with direct PM
>> runtime API calls to further simplify and clean up the code.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>  drivers/iio/adc/rzg2l_adc.c | 100 ++++++++----------------------------
>>  1 file changed, 20 insertions(+), 80 deletions(-)
>>
>> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
>> index 7039949a7554..a17690ecbdc3 100644
>> --- a/drivers/iio/adc/rzg2l_adc.c
>> +++ b/drivers/iio/adc/rzg2l_adc.c
>> @@ -8,7 +8,6 @@
>>   */
>>  
>>  #include <linux/bitfield.h>
>> -#include <linux/clk.h>
>>  #include <linux/completion.h>
>>  #include <linux/delay.h>
>>  #include <linux/iio/iio.h>
>> @@ -69,8 +68,6 @@ struct rzg2l_adc_data {
>>  
>>  struct rzg2l_adc {
>>  	void __iomem *base;
>> -	struct clk *pclk;
>> -	struct clk *adclk;
>>  	struct reset_control *presetn;
>>  	struct reset_control *adrstn;
>>  	struct completion completion;
>> @@ -188,29 +185,18 @@ static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
>>  	return 0;
>>  }
>>  
>> -static int rzg2l_adc_set_power(struct iio_dev *indio_dev, bool on)
>> -{
>> -	struct device *dev = indio_dev->dev.parent;
>> -
>> -	if (on)
>> -		return pm_runtime_resume_and_get(dev);
>> -
>> -	return pm_runtime_put_sync(dev);
>> -}
>> -
>>  static int rzg2l_adc_conversion(struct iio_dev *indio_dev, struct rzg2l_adc *adc, u8 ch)
>>  {
>> +	struct device *dev = indio_dev->dev.parent;
>>  	int ret;
>>  
>> -	ret = rzg2l_adc_set_power(indio_dev, true);
>> +	ret = pm_runtime_resume_and_get(dev);
>>  	if (ret)
>>  		return ret;
> 
> Should we check (ret < 0) here instead of just (ret)? According to the
> docs [1], pm_runtime_resume_and_get() can return 1 if the device is
> already active.

The v6.13-rc1 implementation of pm_runtime_resume_and_get() is:

static inline int pm_runtime_resume_and_get(struct device *dev)
{
	int ret;

	ret = __pm_runtime_resume(dev, RPM_GET_PUT);
	if (ret < 0) {
		pm_runtime_put_noidle(dev);
		return ret;
	}

	return 0;
}

It can return zero or negative error number.

Thank you,
Claudiu


> 
> [1]: https://docs.kernel.org/power/runtime_pm.html#runtime-pm-device-helper-functions
> 
> Thanks,
> 

