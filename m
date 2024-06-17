Return-Path: <linux-iio+bounces-6410-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2552190BA0F
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 20:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206891C21BA6
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 18:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4249198A33;
	Mon, 17 Jun 2024 18:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/BthJua"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0683D441F;
	Mon, 17 Jun 2024 18:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718650064; cv=none; b=VLpmwbOWYcc0XRT7Mkf9QMV7wMrt5gjnK6r+IgV7VEEe1Ybh1ZFYIn0zonoCama0CUIRQdwIdphi0O4rt4Vib+7fqzC4m6FiFCmoDMZYfv+ju2KsTzmevxCrpNPx+y9ohjB3Zc+r3qF2yfOSyjRS7fLmNtVWxHi6tQlpxKf6UFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718650064; c=relaxed/simple;
	bh=/ozGT6MoG1jdmExljQPrsfdMg0BohHXcdRltadm6CZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mk4FOTNjRvt6VRLJH42XgE23pWEfhfpV71jH7ruX666YZ8XhYS/I8JPcEGxYPN0HkO6Yyx4f1ba2wLKtIdF6Gihn8JjKcyc7C4vkU2g3C+LXKXol49EVtwhAqeYvz4D1PWAB3CaZF44rZuSmXSmcXlVeycTPc9VEIp2alHtbCcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/BthJua; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-35f1bc63981so3462595f8f.1;
        Mon, 17 Jun 2024 11:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718650061; x=1719254861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0c7fTMC+b14XixWsQaZe1FUuYpGLUd+MlK7JbAqKTdw=;
        b=b/BthJuaJX4iIgQ7y9B/ejJm7SXfhkG2vBPjjDv/saa6GuXxDgzkUhJb+BeSxMBozU
         lzEXPWzs5dv2Yd/WioU06cbwbNDZVQodcZn/sNGpuFGWUcpOOTQfpGqxf2OaKqrG8pdx
         H+41CmYmS7LhjVA8a/Am6xjt0auY3kn/9rc2Xb5Xbq1jYPCb1DGPnaz2m8qUGVeneAGp
         +moYFJym5VabiNwJGYUou8+CsQ/6oAwU59Mn1hcF5SC9G3jpp2VnxSMIQ1P0wz4b/CEC
         50GUzZNph0nU4ckphI1hxUGkrC2oE7Ldrt6bi0XljkJofzsAAR4PdW5ALYlFaLyG0zzz
         Pj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718650061; x=1719254861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0c7fTMC+b14XixWsQaZe1FUuYpGLUd+MlK7JbAqKTdw=;
        b=rAPwcPnbxGWPxx6yvn0UwVYf+cyG6M1bX9ePFCdGpsdUq3Sm40v0aGRyt+XyjUgWEq
         cOc45lDQhzZ1x7A1cN7ktAM1icliFc57dCDREUpcg2wkIP6pkD2kz3/3j16ych82Q1hU
         T//lYFN1F7grt8V/GRNwzvU6vXGGtHR4uBFZbO77XiiXedv3ij54iwSzRNEstlngQl5X
         bAamRH/JsuFhZo+s1lBrNBTvAjiMfmRxYV7t4CFBQIxc9870k9iyRfoCs3larrHr7hNM
         Wt1+mYPnf2/zKB2s5JM1BQszOhHi+b4WwwFh2nzE/xrK/oxqpuHI/JYILEgN5GkMX7zP
         h23w==
X-Forwarded-Encrypted: i=1; AJvYcCVd5xAVhKLIAFZDJVyJSbNHRrht6yzRiD5Xpumb36rSoNEzmwxfuq05ojQf/2hNfUbD6gk76lLEoS81eLcbs2HBjez5RGjneG3VxtizCC1S5cUIwvZ7eeBj0m5cnBBh1XdeA3GMwg5xI95r4aKQ/fAeuYJXCS91v66b5zcHumYAoEgWzw==
X-Gm-Message-State: AOJu0Yz6LQRB8ZUFWkMdCmNXFs6c0TdeySWlwesOwOTrHUhDfeZ0nQJG
	zgC5vYZsb/BqiHuyVYaLC0BvKbrXARk71wRGxgtgxKJdc7yJ3EGm
X-Google-Smtp-Source: AGHT+IF+i2YR5PA4D0SHL0kjeJAcOnJbRmvghNvRJKOXyIEowN1D1mDkrG125uijJQGD18S+oNT4kQ==
X-Received: by 2002:adf:f684:0:b0:34c:77bd:2508 with SMTP id ffacd0b85a97d-3609ea67765mr382435f8f.11.1718650061218;
        Mon, 17 Jun 2024 11:47:41 -0700 (PDT)
Received: from ?IPV6:2a10:d582:37c5:0:ed15:7e1f:11e6:9a9a? ([2a10:d582:37c5:0:ed15:7e1f:11e6:9a9a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075104a8fsm12371707f8f.110.2024.06.17.11.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 11:47:40 -0700 (PDT)
Message-ID: <7f60db41-8935-4997-b65d-c69785f872e7@gmail.com>
Date: Mon, 17 Jun 2024 19:47:39 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio: light: ROHM BH1745 colour sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org,
 robh@kernel.org, ivan.orlov0322@gmail.com, javier.carrasco.cruz@gmail.com,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240606162948.83903-1-muditsharma.info@gmail.com>
 <20240606162948.83903-2-muditsharma.info@gmail.com>
 <20240608172227.17996c75@jic23-huawei>
Content-Language: en-US
From: Mudit Sharma <muditsharma.info@gmail.com>
In-Reply-To: <20240608172227.17996c75@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/06/2024 17:22, Jonathan Cameron wrote:
> On Thu,  6 Jun 2024 17:29:42 +0100
> 
> Hi Mudit,
> 
> Welcome to IIO.
> 
> Some comments inline.  Some apply more widely than where I've
> called them out, so please look for similar cases and tidy them all
> up for v5.
> 
> Thanks,
> 
> Jonathan
> 

Hi Jonathan,

Thank you for the review and suggestions on this.

I'll address the comments and include related fixes in v5.

Best regards,
Mudit Sharma


