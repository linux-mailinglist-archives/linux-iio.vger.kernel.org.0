Return-Path: <linux-iio+bounces-14588-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FB0A1D265
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 09:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355E83A3B1C
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 08:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384CC1FC7DF;
	Mon, 27 Jan 2025 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="e0uwDPoj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E74213D8A3
	for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737966786; cv=none; b=pO7ejhDDUbUr0xJE9wEAg7xF8GYeXu+3VIJsrYDOlKjcj4YRtkLJqQl0Ydzz5Jzurig5TU5BjCGY9jEIdqDNLkRq1rNLLSL8/H5GQny9K8B1v89qJJWNDICO1jaaCtO0TdwuR/lr/EAibPAffJOV340qQkAb3SGADAu2x/TRmqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737966786; c=relaxed/simple;
	bh=Kg3ShiX3X+9p/kE2BPKyqJFla4aCm2pLOyyJ75gY4Es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AwOWW9zM8YYJereaybjz0qwnoaViG6meJqudrwGJvQMwpAFrQYmifP4pwQoceZ6uvXlYTTPHJNMCI8hclwwrM0OOYRpAbv7s+KdMC+t0XTlNLYKbudi7MtGXwleYfNEoBEsSFFvbUaUDDM6/TjTYKrVDBHMdBs/Eu6lG4nS7mMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=e0uwDPoj; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3862d161947so2102978f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 00:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737966782; x=1738571582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a2Ji82GDu0qEHZkiYbmz0Eb1XpkbUWFD9sNNEsdWqqg=;
        b=e0uwDPojzRdVbGxQdkqshbkiInloS78/mC1Nf+SBeEphF2iv+W7D+D/L/EOKIUUMHI
         io6Rzqem6/0W9Y9Sq+SQqmkUbjM7fZnbuzwedPEcRAmgx4mc8eLn7SdKCwkyG1VdC3Wg
         Yezf0aGLUQ3KYOX9aCNBqNGwVKoP2ZJ1W9AoSwdAmqrxEP/PGDFdM8EJWyPTxyli1kf4
         Q2TtjqNGe2ecjjTLoo9hSmbToHyIAQfgAnGTkAT/hNcfDeJMpH70MgjWg+8I+k+tzzOj
         BVxWvM0EZ1N5/CClVd9c5Uqhav8zhdkgSZ7sXEsJq/FgmGWEyD7xrXVT1lxTcOjm2LTg
         b9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737966782; x=1738571582;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a2Ji82GDu0qEHZkiYbmz0Eb1XpkbUWFD9sNNEsdWqqg=;
        b=nGVg+mPEKpT3lj6XgDB5yJJooGstMzz0evkQ0JiJLIQTcMhswhf+i9MDZ5L2TQOXrs
         NdWRFdcSWPuwQ2iliwGEaHvuLTxqzoNECm5Rubx47EHMgTrgKE0B4SzC/uLo4l1s9mAw
         nWQNQ6avVZEz9iqBPftTWqDsJ8NCzlTPpvZq4EomBbR6FtUCJK/1UnkZ4Dkqh2LgBltr
         U1CR9vO6WglWVEIE2uTCZ+Di4Ng96zc8Fd3PzDQWEvrjkKg7/k5HNbMe/Dn/GZxDBgcI
         B9RWor+Z10mVKpSBrkHHr39Fu1W+Ip+uA2QUB1HFOdoWO2pBj7P6KyprR+dqn3F5z3Wk
         dW8w==
X-Forwarded-Encrypted: i=1; AJvYcCU4L31Gaotsbrw5GBuhyuZ4mZJ18cv7rg+Q22Eedvx8mOGzCAtEDyrdXeAglDvzuv3BCpMQqlE3YFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZz2/vJ0c6//aMYRzy79t3XbzNtbOk+RB3+kwkOvv/ioQ7HuI3
	P2LRMjfT6RO+lmCr0CfR+ptjE/N/9LoScKzRjk0bUWR2FGJflV6Q0tOsa/fT3y4=
X-Gm-Gg: ASbGncuWeuNEEKHemmlbeC02yYsQXhUWqeMgr3zoV5VlXY3U51Nafg3jSsHLOBMNQLA
	vZPMu/66SAxJTGsW6Sx3teDfyH2BF6why9vgS2/Qy1E0k13StWKKKatzArbc4422oV61xy/NV9m
	iUOmpshhvxHcHLuQjtdUA2HF98uAGTmMJgaHxQENB/yZVp08CKs+cf29jWd3Tj6v2ZiSFWV5iiO
	xgGnVwcGCyLePo7YCdfFa57fDjqEw1LgND1YseGbP7H6zILFiitXalBC0h8UZlmwC8f4XlE4Vgw
	vBcokGkXe7v4
X-Google-Smtp-Source: AGHT+IHpMIbXH/ROA6dm+Hnrzv+rG9utZdsejuvQ4p2UjcOm0impQgdG4YV+X768DL8GecEbw47bEA==
X-Received: by 2002:a5d:588e:0:b0:385:faec:d94d with SMTP id ffacd0b85a97d-38bf57bd65bmr42270165f8f.51.1737966782251;
        Mon, 27 Jan 2025 00:33:02 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1bb062sm10322276f8f.71.2025.01.27.00.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 00:33:01 -0800 (PST)
Message-ID: <3c7f5a92-254c-4ce1-9813-80c98c1f549e@tuxon.dev>
Date: Mon, 27 Jan 2025 10:32:59 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] thermal: renesas: rzg3s: Add thermal driver for the
 Renesas RZ/G3S SoC
To: Jonathan Cameron <jic23@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de, ulf.hansson@linaro.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
References: <20250103163805.1775705-1-claudiu.beznea.uj@bp.renesas.com>
 <20250103163805.1775705-5-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdUDKFRsZWsZG9DY4PHdxQEDoPqzfeRx8MNTreOpxdLvpw@mail.gmail.com>
 <20250125121826.6abbe7de@jic23-huawei>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250125121826.6abbe7de@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 25.01.2025 14:18, Jonathan Cameron wrote:
> On Wed, 22 Jan 2025 11:29:19 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
>> Hi Claudiu,
>>
>> CC iio
>>
>> On Fri, Jan 3, 2025 at 5:38 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> The Renesas RZ/G3S SoC features a Thermal Sensor Unit (TSU) that reports
>>> the junction temperature. The temperature is reported through a dedicated
>>> ADC channel. Add a driver for the Renesas RZ/G3S TSU.
>>>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>  
>>
>> Thanks for your patch!
>>
>>> --- /dev/null
>>> +++ b/drivers/thermal/renesas/rzg3s_thermal.c  
>>
>>> +static int rzg3s_thermal_probe(struct platform_device *pdev)
>>> +{
>>> +       struct rzg3s_thermal_priv *priv;
>>> +       struct device *dev = &pdev->dev;
>>> +       int ret;
>>> +
>>> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>> +       if (!priv)
>>> +               return -ENOMEM;
>>> +
>>> +       priv->base = devm_platform_ioremap_resource(pdev, 0);
>>> +       if (IS_ERR(priv->base))
>>> +               return PTR_ERR(priv->base);
>>> +
>>> +       priv->channel = devm_iio_channel_get(dev, "tsu");  
>>
>> Given there's only a single IIO channel, you could pass NULL instead
>> of the name, and drop "io-channel-names" from the DT bindings.
>> I don't know what's the IIO policy w.r.t. unnamed channels, though.
> 
> It's supported, so fine as long as no future additional names show up.
> Will just fallback to index 0 I think.

If everyone agrees, I would keep the name, too, to avoid complications in
case this IP variant will be extended on future SoCs.

Thank you,
Claudiu

> 
> Jonathan
> 
>>
>>> +       if (IS_ERR(priv->channel))
>>> +               return dev_err_probe(dev, PTR_ERR(priv->channel), "Failed to get IIO channel!\n");
>>> +
>>> +       priv->rstc = devm_reset_control_get_exclusive_deasserted(dev, NULL);
>>> +       if (IS_ERR(priv->rstc))
>>> +               return dev_err_probe(dev, PTR_ERR(priv->rstc), "Failed to get reset!\n");
>>> +
>>> +       priv->dev = dev;
>>> +       priv->mode = THERMAL_DEVICE_DISABLED;
>>> +       platform_set_drvdata(pdev, priv);
>>> +
>>> +       pm_runtime_set_autosuspend_delay(dev, 300);
>>> +       pm_runtime_use_autosuspend(dev);
>>> +       pm_runtime_enable(dev);
>>> +
>>> +       ret = rzg3s_thermal_read_calib(priv);
>>> +       if (ret) {
>>> +               dev_err_probe(dev, ret, "Failed to read calibration data!\n");
>>> +               goto rpm_disable;
>>> +       }
>>> +
>>> +       priv->tz = thermal_of_zone_register(dev->of_node, 0, priv, &rzg3s_tz_of_ops);
>>> +       if (IS_ERR(priv->tz)) {
>>> +               dev_err_probe(dev, PTR_ERR(priv->tz), "Failed to register thermal zone!\n");
>>> +               goto rpm_disable;
>>> +       }
>>> +
>>> +       ret = thermal_add_hwmon_sysfs(priv->tz);
>>> +       if (ret) {
>>> +               dev_err_probe(dev, ret, "Failed to add hwmon sysfs!\n");
>>> +               goto tz_unregister;
>>> +       }
>>> +
>>> +       return 0;
>>> +
>>> +tz_unregister:
>>> +       thermal_of_zone_unregister(priv->tz);
>>> +rpm_disable:
>>> +       pm_runtime_disable(dev);
>>> +       pm_runtime_dont_use_autosuspend(dev);
>>> +       return ret;
>>> +}  
>>
>> Gr{oetje,eeting}s,
>>
>>                         Geert
>>
>> --
>> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>>
>> In personal conversations with technical people, I call myself a hacker. But
>> when I'm talking to journalists I just say "programmer" or something like that.
>>                                 -- Linus Torvalds
>>
> 


