Return-Path: <linux-iio+bounces-12260-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187619C8D39
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 15:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC925B27B5F
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 14:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE4944C81;
	Thu, 14 Nov 2024 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rllvoBDo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E1D17578
	for <linux-iio@vger.kernel.org>; Thu, 14 Nov 2024 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731595661; cv=none; b=jE3/drX0727cCRFE4Ig5u8uE9Ii56kLdtKvoQdr56v8yhtjedVJae0lxkcnD5Bx90F55f09b8HYC3rtNP9kQAT4QnYAQHw9l4cNKPf1yDJC0dmLXpan9yfdB2ozZaUFbSLS3DwsC1/OQdryJzGactF+KtjXYk3cQvUZCtb/pD5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731595661; c=relaxed/simple;
	bh=D87S/2iSrjHxhqbhQk/BOfUi6afFT8Obf1Ai+4fFrJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SPdvi/TB3LcAR+p6RnBZxT9jwXUyLFXJA0FTjNWXQalEwYYqPmD6SMWiq6vU+/GZRkBm9BO90gbfWKrdvcNh2wnR9dsQS4IRYkJusMXl7zlOqs8OKOunY+Oi6DW7qWfPIzaQf2Alo+kXweq5TkOWx99hDVnG6veVJBuxTYGZcIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rllvoBDo; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-294ec8e1d8aso419079fac.1
        for <linux-iio@vger.kernel.org>; Thu, 14 Nov 2024 06:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731595658; x=1732200458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cLiPIwku9aoV6FsuTm9hcLzf19Zpgfkgh5a8Q3+4iME=;
        b=rllvoBDowtvMqUajVenWBtI6Kk8TXpIzLTMwdi5NrHAcJN7a0uZEbfEi0va+PA/ppW
         uB2PkItf9GOp4KKSb4rfcA22I0m7fb+s6I9QMV2ELkJeOGvb70VHdwoF0umMtNBb4u1L
         eqrpHE1/ooKJyFYDvDQpS8filBbTD4IeX8KCKQVjvHehdKq8UgjLNK/ceGQdPfsphtDy
         lzaukoeYQmaPvx/ctYaSjc2YEsiBm5BXlPa6AgC8lzBYr7EyKSYdAfzUR6b6eIPMoJLf
         t9z6B4uhzzezr2uURl3lSvWWz3KzGWMzYCtzLjxSOfINfEOk7I4FgY4lAcGyJQvEnTbr
         KhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731595658; x=1732200458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLiPIwku9aoV6FsuTm9hcLzf19Zpgfkgh5a8Q3+4iME=;
        b=mjSkhnIHjNOejDU7r6AFm/rdfOeOmyR6zDC2GxUZ84XsIv6gYxnV8wLjCd7Zd9OBVl
         tPUR3INKkd4rDNFD/wcaX812BdgdEeKeo+sBTq/rCEM0qiIyz9k6DFVOhxujhUAgDpJx
         6JSrsuqZ/afyMA7Iy6kiloWhC0U2voxSD825f/Mtd6LrYbFxoQXttHXArhDHtGMCdcE+
         fRIlUTEGSKEl3xsE+hH7H+Dfo6tdaEushco1khCv61yeESqSmfvhG3tSYtwWRAg9rk+J
         sFDxfEykjN2zdzX37umSHD2hDc5mXiGzSvegB4GPz1EHJcfIVoCoiMBS0jTcOWIYIrB+
         fOuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRnXvvM1pecayphCVR7e/+sth3ekoFYimKUFlzUSR1TD8FchXrje5jkp91tfjuGs2ngCAnb9a2+m4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpt8hIEwflnycqVuff7PkiHCLTjLmMtBqqXhdaXsmZfF/G4lRG
	b9uuJpOfGLG/iKtiabjAz68HtcYbrg255TPooHmL2uEypFEy7uFIcZswizPY5Uo=
X-Google-Smtp-Source: AGHT+IHBm+MOajtqOgOa+JMdH4SOD2OUJSIzHMmwYlCDI8AZFsAhsMFjNqy7TNSKark8sXQo5dShXg==
X-Received: by 2002:a05:6870:bac8:b0:288:64a4:fbea with SMTP id 586e51a60fabf-295e9042896mr8021848fac.42.1731595658412;
        Thu, 14 Nov 2024 06:47:38 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eea0230e35sm347718eaf.33.2024.11.14.06.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 06:47:37 -0800 (PST)
Message-ID: <6c034f2c-1f07-4dfb-8e65-dbf41e803f01@baylibre.com>
Date: Thu, 14 Nov 2024 08:47:36 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/8] iio: adc: ad4851: add ad485x driver
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
 "jic23@kernel.org" <jic23@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
References: <20241111121203.3699-1-antoniu.miclaus@analog.com>
 <20241111121203.3699-9-antoniu.miclaus@analog.com>
 <4b48ae8e-4eba-4d86-af8b-2b749c53639f@baylibre.com>
 <CY4PR03MB3399FA960416CEC64E1FFF929B5B2@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CY4PR03MB3399FA960416CEC64E1FFF929B5B2@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/24 4:39 AM, Miclaus, Antoniu wrote:
>> On 11/11/24 6:12 AM, Antoniu Miclaus wrote:
>>> Add support for the AD485X a fully buffered, 8-channel simultaneous
>>> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
>>> differential, wide common-mode range inputs.
>>>
>>> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
>>> ---
>>> changes in v6 (implemented most of the review comments in v5):
>> What is the plan for addressing the rest of the comments?
> For the rest of the comments I think I replied inline in the previous series.
> 
I didn't look very close yet, but at a quick glance, I saw that all
scan_type are still only signed, there is no unsigned for when the
channels are used as single-ended. And the scan_index ordering is
still wrong. This makes me doubt that buffered reads are working
correctly for all configurations.


