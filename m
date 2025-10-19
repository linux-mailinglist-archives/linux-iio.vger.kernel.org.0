Return-Path: <linux-iio+bounces-25274-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862ECBEEB17
	for <lists+linux-iio@lfdr.de>; Sun, 19 Oct 2025 20:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58853E00AA
	for <lists+linux-iio@lfdr.de>; Sun, 19 Oct 2025 18:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BF3223DD4;
	Sun, 19 Oct 2025 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUknOd7X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0289CA6F
	for <linux-iio@vger.kernel.org>; Sun, 19 Oct 2025 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760896979; cv=none; b=GqcLRWZGaU/3UJjfAQDYM5Rmjgn/lC0iregZvsdd9YPV/I3wi2cYnyXe1BR1lp7AtaGPA5NLa8fpFKMlm0GyO6/hs7TDedIKm4nAs0DNjquNNvI94nDIczaYdQmglYg9FsAuVUGJomcU9VM4bwEgkYFH60gjn0iFBOU12PGGQ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760896979; c=relaxed/simple;
	bh=ozSDolhQJbmAO0s86Z0yWay1zEiXGX3RFZK3utoLfb0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jFGTMOxYQhxwGt7rT0EawK+FLpNRE/hCaretjCGHxL/py66qP0eOrGAmGo0qeBMRuJ41QUXqM+rp2UORJcipEE8sWMwhoNTpp85fMvz++LSASsVksvlWJxNsXppIQ9Jo00dRUnbXk11dJaomUvM/brEgQXc7bDtFhU/HHlDdLEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUknOd7X; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-279e2554c8fso33838565ad.2
        for <linux-iio@vger.kernel.org>; Sun, 19 Oct 2025 11:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760896977; x=1761501777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1jrt0Ie8BNhXfzYDP08LLmDw/YXiUEA5EJwaGmcebmY=;
        b=BUknOd7XTxdZaeRCWEKWYNUGsP5lsprz/Zw5NWhEjR5AwOuSkPRFnn9ILeZKXypdbM
         BhW7lk/nPo/p+/xiOmq6l2ZPH2x8VV79qI8s6JdnwCZzpFRswnycX2MTi3w2cq0VhqO0
         x/QmU18cBHAwN9ksP5tcEQgJ/HBI+FIDS/tplCdAOFxM4JHcMNIHeyZzkJ2DSiylg5UD
         l+6C7bincyvBfDrCjkadt/a6BqI6+AQhXEWDFSz8NsO4SHU/UAvLzW2kP8xaOWluGSG8
         zjznJXXCF2qn2+5jy4TcHegUGbyM7ZdEqr2GBFVwz0SH+j4NiV4T25xkcmvFyqt8OcwV
         7XWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760896977; x=1761501777;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1jrt0Ie8BNhXfzYDP08LLmDw/YXiUEA5EJwaGmcebmY=;
        b=VaJGeN9e0L+5RynRxNJs4IyRWkDL02sBDWGqBMSA/5Zs3xPn/dhpc0IXJYaBXGLVsd
         ucjC0A1cz3WviEFs0i8koW7UMASuvSP47Zso1hU2fp+FjmCZ8U33BALzM8HUkjmqbKsH
         3rOsGiKOIbMesRwIEINI98EVqcYAkCsy1OD4cr7Q6dWKkqwdawH5JFY0FbdjleYZ0NTc
         uKOjcFgnblbcEhOOUHujLxrrzOB1/dTBgrnLsjnwDyIxahPoFNmQ7weWq1d/eDbQoHF1
         UlL5w50VCeuXAYEXLyKwQ8qNGuaW4/H7LJB/LEaJLukUwRuzR2ZPweNmXZvHGb/RsHxH
         yOnA==
X-Gm-Message-State: AOJu0Yy9N9RA8OFhLDlNz0JR3PEly7wK6rmuqOP+OqyplvNXif4G11aG
	e8Se9UEfFkiyg+wbYh6RU6M1SQSQMNADeXF916JgAbkTRM9oAweA0TQD
X-Gm-Gg: ASbGncuLDP1p6ii0dRKqq1bBYUKXJ1kwHKDI9XCN+lorTgtIHGYhQIQXNj4rKwSqiwg
	VXA8xqZUm1awZdEcTfTiriMQRzgtWiHfofT6zOphgGWXoSdSVL/mvpgS7Vpj8R2hPPIgZDMFX1R
	V/WUTsS8vsBNTV9X8QU+TXairIhLdysDveeAHLvoBQx9mjckxYsL3skI3juhuJREc921gTgdchN
	IesJAjAGakxTFC82ug+ReelDdbJ2/PDl4UjrF++1n9pRlY9RY7rNv1blfDKp/psddR/pb9wykwt
	CJsen3Sx2fzadaTijWvSSig9ns/yKgLeliUT0Ax9xKzHQc2RGfsYUy62TFHTR5sNdz5MA6A8eBd
	2zHKJgk2/JuMAgLmHHzAAq7J4lgH3BGKJfGmysuWSxiBg0rHV/Nnn47QLa2hJ9iEX7qgQDpVxkR
	Ils83YNZ4h+Fvl961pK0mXcRRh5Vxkv2r0iZU=
X-Google-Smtp-Source: AGHT+IFFVOrJIsToyN6vZFiYBBVpU1/9unKfzO//ZkozLWMRDFrgw63b2i56h1Yz6kWx6og3vSaNSQ==
X-Received: by 2002:a17:902:cf0b:b0:246:7a43:3f66 with SMTP id d9443c01a7336-290c9c89336mr146423865ad.7.1760896976935;
        Sun, 19 Oct 2025 11:02:56 -0700 (PDT)
Received: from [192.168.21.161] ([50.236.66.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292a8c8e231sm4099675ad.36.2025.10.19.11.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 11:02:56 -0700 (PDT)
Message-ID: <eb655eb8-4f24-409d-9560-be980637ca66@gmail.com>
Date: Sun, 19 Oct 2025 15:02:54 -0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 1/2] dt-bindings: iio: adc: add max14001
From: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Kim Seer Paller <kimseer.paller@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>
References: <830368e5bc303faf04f542268acb95e99d0d1cde.1760502331.git.marilene.agarcia@gmail.com>
 <aPGeCMiLSB9-A7t_@debian-BULLSEYE-live-builder-AMD64>
 <8c1a533a-2c39-41a9-a007-f64cefe30e35@gmail.com>
Content-Language: en-US
In-Reply-To: <8c1a533a-2c39-41a9-a007-f64cefe30e35@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>> Co-developed-by: Kim Seer Paller <kimseer.paller@analog.com>
>>> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
>>> Signed-off-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
>>> ---
>> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
>>
>> Since you've dropped the ADC node label, I think you could have picked up
>> Conor's review tag from v12.
>>
>> If nothing else comes up, you won't need to send a v14 as Jonathan 
>> will probably
>> pick the latest tags when applying the patches.
>>
>> Cheers,
>> Marcelo
> 
> I agree, I forgot to pick up Conor's review tag. Sorry about that.
> Okay, thank you.
> 
> Best regards,
> Marilene


Hello maintainers,

Just checking, is there any other action I should take on my end
regarding this patch series?
Jonathan, I forgot to add the following tag in v13, so I was wondering
if you could please include it when applying the patch.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thank you so much for all your assistance.
Best regards,
Marilene

