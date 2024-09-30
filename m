Return-Path: <linux-iio+bounces-9940-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A8998AA48
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 18:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556621F23CF2
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 16:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E9B194083;
	Mon, 30 Sep 2024 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQdmrK/H"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2988C19047A;
	Mon, 30 Sep 2024 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715022; cv=none; b=e7sz9VfCN2q2hKfIwdTLwPwbkbtypJm82TelvUM2wh2Hc2Ltx17ILZQ6lAJMsXsjHvmlKSvxMRk2UqSgc60/pvX0U0PZrGZPRzks1lzUxCm3QKmpOTw/D76T4Tg726YAMyhlPf669ldqIMuoUs6oTNNjxV5y/8Aak6RJ87EQMgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715022; c=relaxed/simple;
	bh=lVrGW6Rp8LvkaUBY8niho5Am/7CqOSbO9kzvyvHBgMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9SFrhmjCSZ6/XBswEIIWnzlogefOF3dUBywcImsHYUP85hxub4lBt2zeXSknm1uCdsWJ2QyoFMhQlIpkMvh4wK1en5yHQ9mt/HGut2lKAnJN6o6CPyfrAAob4e5zVzjLOGqol47JF68NQfEkJy0vYoGb5t4QJYZiLXYiWrcPJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQdmrK/H; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso750872066b.3;
        Mon, 30 Sep 2024 09:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727715017; x=1728319817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5oDjD7yDZTtuxDYm0I4LWXImh3EPj/g+kpca9q5n684=;
        b=lQdmrK/HPWVPxp5v0wXcmhi+6pwfjudk57SneuU+6C9JLQkfubiqB+PQO4QhWVYXD3
         iwc4wzj8ZcCjaUGAHd9T+jnjnc/KMoal+u9bXnlSWspjPUmQjmvTwX1YozZrsht3RXl7
         O6iUBi7a+bm9xYWGLACPsP5Ft+At7Cz+scpol5E6lQtuutMJzg9D1dj0/EaQp6yvmpxd
         rgmEOsZ8cgt1B8cGzyBKn5MlPruqBgvNkVyp+xTmoH6peAj6noOovZX31NohJ+ZlndhY
         c3d0ePusQEk+pFDpasXmCkZsY56HDx4CSOLreId2Wcf9txMC63yJxMhzfSrRziZ/2VLv
         uSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727715017; x=1728319817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5oDjD7yDZTtuxDYm0I4LWXImh3EPj/g+kpca9q5n684=;
        b=MXPvDXTzrwzHux4ZbIrf01+IBj5KN4Vye0Cd+guYg3mX5OBOgsVVeVa2njVLAYA9nz
         gpkhbFhnE49fWw2aDFlRwfzUkj2rx9+Uu304XhFbRWDxhLZHj5hiQtOrfY7nRlUaZiNf
         q7wxMXIxdTBFHyWTXB1MWWXmPDc1I4a5EwCwOJ5L0CyKNZZKo3DNrrPwyQpNHap+aqWl
         DkEfue1BQ6a8zghVwwSUR5dP5zq3IVZgwRI16ICgQRPG+Lvc3U4iW6lze74YnmQIKx4Z
         p1nYo01yOjoWd/oMYGJ7v3uC+oZC6vw1IlJ/IDlwYuwLSxyGhW2YfUDYS/mTmvOfaLG+
         V4VA==
X-Forwarded-Encrypted: i=1; AJvYcCUWi+rm8PNYUDNCushs2YrK3YjTiggIbiDee1vGTE3x2bmGGU36nFRQe5nJmyeBJU6iEpiKOKWm7lZuxH3R@vger.kernel.org, AJvYcCWiEh9LYgWqJW9tWQ8/OUwe1+qwTUheazQBk+Bpz8nVZWl5EMCrGTZ4hYmHTgYhO3msi1+JHU/2g3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrG8AU5955UbRB6YiQCIoSsTuWyE5Io8sKbEShqxDo/ZQ9xdpe
	5QP+6vfBSnfhXSuAmnWIt07L1GdInhob4TPvs+tVaeYn2ToKYwnpHSVooJ4j
X-Google-Smtp-Source: AGHT+IFJzhY2TF6DQZ8zQ4hKL5S0O8rirPXIARvjIVAF/3uNpQgHg8T6YNA2hYj34BeigsJIIPYtaA==
X-Received: by 2002:a17:907:ea4:b0:a90:c411:24fd with SMTP id a640c23a62f3a-a93c48e8c04mr1408073466b.10.1727715017164;
        Mon, 30 Sep 2024 09:50:17 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:91b0:e3db:523:d17? (2a02-8389-41cf-e200-91b0-e3db-0523-0d17.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:91b0:e3db:523:d17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2947ae8sm553108266b.112.2024.09.30.09.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 09:50:16 -0700 (PDT)
Message-ID: <0342111e-47f7-4981-a1f1-e694392fa741@gmail.com>
Date: Mon, 30 Sep 2024 18:50:14 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-6.12-rc1/drivers/iio/imu/bmi323/bmi323_core.c:133: Array
 contents defined but not used ?
To: Nathan Chancellor <nathan@kernel.org>
Cc: David Binderman <dcb314@hotmail.com>,
 "jagathjog1996@gmail.com" <jagathjog1996@gmail.com>,
 "jic23@kernel.org" <jic23@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <AS8PR02MB10217F8B5827B69E6438488679C762@AS8PR02MB10217.eurprd02.prod.outlook.com>
 <7e9ae281-448c-429b-9ca5-86581f777f68@gmail.com>
 <20240930151542.GA3556370@thelio-3990X>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240930151542.GA3556370@thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/09/2024 17:15, Nathan Chancellor wrote:
> On Mon, Sep 30, 2024 at 03:58:06PM +0200, Javier Carrasco wrote:
>> On 30/09/2024 15:49, David Binderman wrote:
>>> Hello there,
>>>
>>> I just tried to build linux-6.12-rc1 with clang. It said:
>>>
>>> drivers/iio/imu/bmi323/bmi323_core.c:133:27: warning: variable 'bmi323_ext_reg_savestate' is not needed and will not be emitted [-Wunneeded-internal-declaration]
>>>
>>> A grep for the identifier shows the following strange results::
>>>
>>> inux-6.12-rc1 $ grep bmi323_ext_reg_savestate drivers/iio/imu/bmi323/bmi323_core.c
>>> static const unsigned int bmi323_ext_reg_savestate[] = {
>>> 	unsigned int ext_reg_settings[ARRAY_SIZE(bmi323_ext_reg_savestate)];
>>> 	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) {
>>> 	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) {
>>> linux-6.12-rc1 $ 
>>>
>>> I see no mention of bmi323_ext_reg_savestate[ i]. Is there a possible
>>> cut'n'paste error in one of the two for loops ?
>>>
>>> Regards
>>>
>>> David Binderman
>>
>>
>> I think that is a bug in clang:
>>
>> https://bugs.llvm.org/show_bug.cgi?id=33068
>>
>> That happens because clang sees that bmi323_ext_reg_savestate is not
>> used but to gets its size, and that means for it that the variable is
>> not needed. That does not happen for example with
>> bmi323_ext_reg_savestate (right above bmi323_ext_reg_savestate) because
>> that one is used beyond ARRAY_SIZE.
>>
>> Safe to ignore?
> 
> As later comments in this thread point out, this is a bug in the code:
> 
> https://git.kernel.org/jic23/iio/c/506a1ac4c4464a61e4336e135841067dbc040aaa
> 
> That bug report is pretty misguided, as that is exactly the type of code
> that warning tries to catch: the programmer has a static variable that
> is only used in sizeof(), a compile time evaluation, so they won't get a
> -Wunused-variable since it is used in that expression, but did they
> intend to use it elsewhere? If they didn't, they can just slap
> '__maybe_unused' / '__attribute__((unused))' on it or use
> sizeof(<type>), which removes all ambiguity. Otherwise, the code should
> be fixed, like in this case.
> 
> Cheers,
> Nathan


@Nathan thanks for the clarification.

So in this case, the array should have been used not only to get its size.

But if that wasn't the case, and since you can't use sizeof(<type>),
should it be marked with __maybe_unused / __attribute__((unused)) even
though it's known in advance that it won't be used, or at least that its
use will be to get its size? Is it then just to silence the warning, or
does it have other implications? Thanks again!


