Return-Path: <linux-iio+bounces-12646-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC699D8895
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 15:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113E516ACB4
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 14:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6061B219D;
	Mon, 25 Nov 2024 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ojhY8dTN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806531B2192
	for <linux-iio@vger.kernel.org>; Mon, 25 Nov 2024 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732546674; cv=none; b=oT755gd0WN5hM/l3M1CsmAyPVFWfVkqsOIkwqqYjSEwbJovqzKfuX5MEzluA31lrLEZxxkF4IdNrppGlS7h1CLTUG1D5UD9b86wTdjw94urOLFJt5qMYq4M555YN86IxHXFUFgYqqC20xml9+DSn8LvjXf+NEE7G3uIq5gMhcrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732546674; c=relaxed/simple;
	bh=bk8Rp0zqwW65bPI33dLEaYlJnQGdgrX+zL0p6r4e4QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nb9gtbtzQW0csu2DwLPrhDqddNQcN36buRnq2WOvTowAsx3wNYD+BuwwdFLHvn2fcauvDfi7kCxQAevedg1CvxGBkhuyM8BrR+ZT/BoAe6l0PgzfdYn7V0RNjyD55NcQwNgpQ5eQtngXIVEYUu7yhgdzUQTZtq/xm03BGUghugc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ojhY8dTN; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-29666708da7so2780508fac.0
        for <linux-iio@vger.kernel.org>; Mon, 25 Nov 2024 06:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732546671; x=1733151471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Sk5I+z2BGvx3HaF6SgZiv/hQ40aE794oKF5/2uvgbE=;
        b=ojhY8dTNUe4rUbU40n1vxi7funIlcPEMVV35tEIJIV6o9CiEiglZQMQ3eWCZ1/Vdzd
         nUXKUrc76Xx7/t9pNVFP/rnXfdyb3Nql5cVbhU0PjrqCpoCzZhwfd6Typb7w/hbmjN1Z
         CjDTuv1EgXgRYDhPmzA08yW15quWxWi/wEBCSCXnw7cQEFjXMC+dBZTUAkwvEYtmJCPx
         uobaecr7nSjXJv4pc/acgyhe79U8w06rUXuEiv4xHrKs5Gw5Wfhoppf70+dNAzoQQ5JI
         yWyuvKEf7dsyPOPqhGMgyT+81/O1JqJcOn9a++dMbP5kd7q+0kmrnZ4zqCSqj3dJWj+C
         bK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732546671; x=1733151471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Sk5I+z2BGvx3HaF6SgZiv/hQ40aE794oKF5/2uvgbE=;
        b=SyyzdNpsBgwYfjVegZ53zFAkZlh1M+MiNCcnVlQ7969d+TRUQYFW1Zpg006r89ck+T
         Noz7ASGmKXwu+tSjUTnADj9zXthcRX5EruGJZfMdQ7RKlmornbJ6m5dl414zmIi3T5VL
         S4pDYglVwLiEtWqpZRXLunHtkZtKfU1z3/P3XeTjmOdMAK83utCPCZjoGMndYXfZOWqQ
         oCDxmjluBpBkGYEvzuBCF1+kdqD06PwItgiqxgZyG+GZ1bvbINwhzAx1X2k9nYCNThB0
         O5TJFgbfxay10xw4kM03/9g1YncDrX9sFzr3HNVOkokww8GVOy7ku2nquFFSLYPJeP4X
         +F4g==
X-Forwarded-Encrypted: i=1; AJvYcCXBsw4R5LIhhCFCgAKJUevbBDwTJ8oXG7RlI0idb55JcnNx0/UH7Bweulm9fPvXaNaIPJJRg+D2w9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTCjX+PUu9Moc/dwzLJPyXwVRTSaoE6It4gAUNnRViNa+STUlA
	HRxG4hPeGahG70E48VeHF1XMzTHP/6Zd4//M67+ND9cHuid5QcMFZr91aWOGN9A=
X-Gm-Gg: ASbGncshg6hUdb1rHuYmVnsqLnopXiveNQcXiKrzZmwjssrcz9qq+9N528ij0lbZY9g
	LF99w8hDapCHeh1egByp/TgCFz9hGSe9QTxya6o3kqJQKpBKe4X9805Tq4KhXlwD4Dc4Pb0yvtP
	e4jwA3BYj3D5q3hoBp+ZRdWIyRNjL1zTNNDl5tb73Xy29OKuWEGi8Zui1hjwcXPMeFXYTiEywVP
	LN+JmqtC5Qc0iy1zPkYbt0kZGidcjxjVLmrS9oz7X66OUGuQVNvdcTPhjZvsxwfxnBGen7+GNlP
	BOV2eSirC5E=
X-Google-Smtp-Source: AGHT+IEL8MmRzDS+0oJEMVoCro9m1ScKl1IojEg1ji4nNvqP24qjZ+AuwiOGiiY/AQSrRBr9cSTd2Q==
X-Received: by 2002:a05:6870:8189:b0:296:e365:d169 with SMTP id 586e51a60fabf-29720ae0117mr9301425fac.8.1732546671690;
        Mon, 25 Nov 2024 06:57:51 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2971d5e29ebsm3052686fac.14.2024.11.25.06.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 06:57:50 -0800 (PST)
Message-ID: <213f4510-0af3-4e17-8473-3929227bcfcf@baylibre.com>
Date: Mon, 25 Nov 2024 08:57:48 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adc: ad7313: fix irq number stored in static
 info struct
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Michael Walle <michael@walle.cc>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Guillaume Ranquet <granquet@baylibre.com>
References: <20241122-iio-adc-ad7313-fix-non-const-info-struct-v1-0-d05c02324b73@baylibre.com>
 <20241122-iio-adc-ad7313-fix-non-const-info-struct-v1-1-d05c02324b73@baylibre.com>
 <76myaxinjuupszvwof355gxwqqs75yxupsy623nwrcms2g7ttu@q3vqdwmsp2ua>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <76myaxinjuupszvwof355gxwqqs75yxupsy623nwrcms2g7ttu@q3vqdwmsp2ua>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/25/24 2:59 AM, Uwe Kleine-König wrote:
> Hello,
> 
> first of all thanks for picking up my report.
> 
> $Subject ~= s/ad7313/ad7173/
> 
> I wonder if it would make sense to update the ad7173 binding to also
> allow specifying the irq as the other ADCs do it and just
> unconditionally fall back to rdy-interrupt (or the other way round)?
> There is no good reason for ad7173 being special, is there?
> 
> Best regards
> Uwe

That is a a good point. We actually don't have to change the DT
bindings, the "rdy" interrupt is already specified to be the first
interrupt, so spi->irq should already be the "rdy" interrupt
because is is always getting the interrupt at index 0. So we should
be able to just drop the special handling altogether.



