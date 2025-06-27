Return-Path: <linux-iio+bounces-21001-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9709DAEBD49
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 18:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0FE7641AF3
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 16:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A872EA48B;
	Fri, 27 Jun 2025 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="X1nlui+a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98292EA75D
	for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041646; cv=none; b=ZnJxcMwi4RFrOLzPgyQ+LhY+c2bg4jutaWb6CbfqTRMRA/btkvqPs0s8fQEwmFXkOiqlUSXqKHJ4Zf+DDLYzRtz52tgPqLUEJVZuZmHBmhjda7pbhyeA+U3uznpz9+oQ2p8P+bPNxT5eBxzFYr7bAOUmlINzry1U3dazjtZ/wjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041646; c=relaxed/simple;
	bh=7J2Wa3sPySlrGHq0Zg1mHnl8WJ1dcQzGUqhzealuGNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LSdDHnCCfMTq/wa6mJcSBZho7er+kVklCn5bVz+cX8uH6MeoBjx02bUJ0f9N5jVXXbufBs70r+iJrzStDHsWRSUkVH2nLN2vkXdJCyAyHe9iXAv6JglJWdPLm6WyGlK6KTuXnQgzrEZ9b6KXDsUM5WajcrnshRJh2EWRfL7XTq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=X1nlui+a; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-73afbe1494fso48096a34.0
        for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 09:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751041644; x=1751646444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qKlvmyFZn+CwFvf1fECS/aASkNiuv6sHWrjfdb8eanA=;
        b=X1nlui+a7hfnXbLlfBkw3/0Xeh4Sfe7WMnIF+PsXEezNP81cVRQmHcHcFhsjeC0B6R
         HVHENZvHbb1LFwwQiw8cCLMl42z44cgNTfYy4DqhoP4Xxo3kZmchHO3aEHFacHtvkLrE
         zDgX8H1NoXp4b6Qxex9DE/GfUMULdHrQHo3xvjZd73mq54TxAiJSnVVNI6I3eYYJQ41f
         AJ5LeBIrrSVDU67epftXH/gdOKKkj3lJFl+UVVEH/ilqCADwxCWQ4F1VqFw1yfxf9KDd
         66BB1OZ4aQkvYgEnQZHkNKStfWJXexUAAcyhxbCB9zQ6cxuzyPTxqKV2uix28H4/oIWP
         sN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751041644; x=1751646444;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qKlvmyFZn+CwFvf1fECS/aASkNiuv6sHWrjfdb8eanA=;
        b=gkGfzOO50kSvPBLkdi2QfzguT5wP4CofarxtE17plpGJ4gOZg0yHMSCRkMSZOrsD9b
         2Q0vQD3K84MhXiidI8UVvnp9XBcD97+V5/o4KuUjpdD23itBT4i8wCHPngTHoS13F0at
         ny4NXcR39MbNApG7ZD3ecsAhtW9Oorhwk+5NRXTvLeRlBJ1SYLLY5U6JDXPmzaeEIwiA
         QIeotX5NiLCORJ0kCnZgJyf+ftUbYc5z37gEU4UtKQaOStBFJZgvFhqFIjLGkwFS2O9V
         uGMZ/OD1TFU8dujNF4+uHedkDXr6Xgspe3TOavrxZ0npWrSAFCSe6nqivio4oqeEgfy3
         oyWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIl1i0b7TV+iPli4f3D5tQQTcxj34kmGYxkeTtRxPCKfhg3dTo7YJCBuIOpr0ewxHQKxNJ/GzTwmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJvyMW0QODb89b/CNsd5ybEE/7K9A+mR5VmiUiL4/M7cbfUZTF
	QySVlO4MsjRKPCFixKPir9XDTGUawwt8Ymq15Kxb7eGBh10s8DUkJQ4Hmn5Mw45SgdU=
X-Gm-Gg: ASbGncvqp3K2hw3mPHQiZiBjpnafJSZUTgZ9qW9QtJ0UccQkpuEJj5qo756cVpn06AY
	QQU7GaXO2QOzs0gTjpwogTQJBVmQC5pD9nuon/oUF/rs6TTd8ZB+l5OQ+QWiJn0UKyPPx8m5pXd
	LogNIHb9MSfUf6bOro6ZwO9+FtVz8zbeR5NLNc2Qgjq60/ZHb870sYw47/jzdyZTdajJpTumr6V
	bYFgQo9QezKtRuyqU7Yb7kw5fZiqp8X3UlS1na3XWuRSOmz0iBYJIoGPUpnL/5uebgOY4svWQdf
	dKpMJfpAggnf0KMzlVOUxwSriyWeLOfGN8Ug8rIIJJHx2X8bOKnAXC+ijaQVv1mR68EWXKhuyh2
	8Vlf/FBldSwaStZK56WyuLaQek4VoGIYuweR+4a4n+qKm/+g=
X-Google-Smtp-Source: AGHT+IGEpoH/3E0MWa+cvzBIlqmwlVY4mNTlSxULk1nWLfgYXMeesrrQZCCQRr90YGb8TriAyAKjbQ==
X-Received: by 2002:a05:6830:418f:b0:739:f3b2:80f0 with SMTP id 46e09a7af769-73afc647c7dmr2567896a34.12.1751041643919;
        Fri, 27 Jun 2025 09:27:23 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1715:453e:e133:7d6? ([2600:8803:e7e4:1d00:1715:453e:e133:7d6])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73afb122c68sm407770a34.65.2025.06.27.09.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 09:27:23 -0700 (PDT)
Message-ID: <4d01de83-7b85-4127-960d-0563359a0844@baylibre.com>
Date: Fri, 27 Jun 2025 11:27:22 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] iio: adc: ti-adc128s052: add support for
 adc121s021
To: Lothar Rubusch <l.rubusch@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sukrut Bellary <sbellary@baylibre.com>
References: <20250625170218.545654-1-l.rubusch@gmail.com>
 <20250625170218.545654-2-l.rubusch@gmail.com>
 <8eb80697-e76e-412d-82a9-5a95d4ca4f2a@gmail.com>
 <20250626192802.0079d579@jic23-huawei>
 <CAFXKEHZ8zDEXLT57BD5Dg1mTN-Gj0Z7uhxX5Xx=XH0wFeAhe6g@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAFXKEHZ8zDEXLT57BD5Dg1mTN-Gj0Z7uhxX5Xx=XH0wFeAhe6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/25 4:33 PM, Lothar Rubusch wrote:
> Hi guys,
> 

...

> Perhaps just one little question here to you. You used the regulator
> name "vdd" where others
> before used "vref". At the end, this seems to be pretty free,
> depending on how it is set in the
> DT or how you name it in the DT (in my case it was "5v0", but I wanted
> to keep the convention,
> if so).
> 
> So, my question is, is there a naming convention what to take for a,
> say, default
> regulator naming or fixed 5V regulator?
> 

I don't think there is a naming convention for supplies other than making
it match the pin name from the datasheet.

If we were to try to come up with some standard naming convention though,
I would not include the voltage value in the name. Rather, the properties
should be named after the function that it does, like vref-supply for an
external reference voltage, vio-supply for I/O pin voltage supply,
power-supply for a whole-chip or main supply, analog-supply and digital-supply
for chips that don't have a whole-chip supply but rather split the
analog and digital circuitry. These are the most common ones that I have
seen on ADCs.

The fact that the TI chips in this driver use "vref-supply" doesn't really
make sense in the DT bindings. V_REF is an internal signal in the ADC.
In other words, it's kind of abusing the binding to specify the reference
voltage without actually saying that the chip also has power supplies.

Chips like adc128s052 should really have va-supply for the power supply
connected to the V_A pin that also serves as the reference voltage and
vd-supply for the supply connected to the V_D pin for the digital I/O
supply. And adc121s021 would only have va-supply because there is no
separate V_D pin for a separate I/O supply.

But there are lot's of ADCs already incorrectly using vref-supply like
this, so not sure if it is worth trying to fix them or not. But if we
wanted to fix it for these TI chips, I would suggest to deprecate the
vref-supply and add the actual supplies to the DT bindings and implement
a fallback in the driver to check for vref-supply if the other supplies
are not given so that we don't break existing dtbs.

