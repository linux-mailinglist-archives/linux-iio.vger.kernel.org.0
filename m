Return-Path: <linux-iio+bounces-18152-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B0CA8AFE9
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 07:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60B94414D5
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 05:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AA222B8AD;
	Wed, 16 Apr 2025 05:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFdWzR/d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02322DFA2D;
	Wed, 16 Apr 2025 05:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744783100; cv=none; b=QOrWLz1of5w7jcAa2zzeAnjmV35j436wumTBhbBAmiXBMm+Ca8U4HxeiDoRObh0NLRSjZSsveHGTj8xAv0kT1Ac4k+xsNpT1PsZmZG92I9rwN9L+AEns9MeSJSVOKG/08MWPOUecqZjHsi80O61Lr3VZ1I8wVadNiZVeAGEMzhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744783100; c=relaxed/simple;
	bh=HxdTTSYdcKTmZuva99KFhsmVW9uUnPfSDOH6UrLMP2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2Dl1MjzDK0dwCcc12Oa/Wio0xXSBPpt9nmyXjnljzPF50Y2lp5BD7QbrOG5mhGxGudogWi8k0HlQXJsiiiHwe/rJPMZLfAqRAmXrkIbdvSL+mgDxXPIBWfFcOLfss67xaAwTspv/hA5NltFFr0EHOh8TdLtVRAPLSF1FFSnw3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFdWzR/d; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54b09cb06b0so6614767e87.1;
        Tue, 15 Apr 2025 22:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744783096; x=1745387896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U0K6PKDXF90sHSVqTWnaPvjEgYs/LRDDmGtwLelc3Gg=;
        b=BFdWzR/dxW9YAv8jcA5wPadJCmbnkmeJZtXkLQpbg5A2gEXQ18AgARPzUVtR6wo++C
         o9E6HXPlY0/xNzcRvvtj36ts/IpF6TsqXcQw9juRtmLjCm6cVVpblVZ8vW86myeV7znG
         34j97pFVMZFXi+OQGJfhxizeltuF2+Pp6oVRb7PpgYyEMWyt5MmofPEEUkthJOlROwHC
         ZDkdm95CvvDSCXKhRONnVsMDKT/6G8pleQtWD0Ys1dcT5ENTp6/yLLKpTJQFmkbdEmh9
         ONWs738cV1kBtl8GGUVJ6dPn0pZWq107CDcvdhntbXSrNjHlIOAzeFww9iyqjZlFIxTg
         XY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744783096; x=1745387896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U0K6PKDXF90sHSVqTWnaPvjEgYs/LRDDmGtwLelc3Gg=;
        b=ofo3LmDQqjWo5GxbRxUk4ftB4DqELWpWmtuUlbSnpjM1cEkL09qJEVQG66wMtCiRbD
         +qF0jG26CohNBXNDIRLefhY0ugt8ZZLk6XrOSmdlGU8XG0ZDqasb14OYSTUnw3SBuRY3
         htUCYJPBhfgpC/x7mC0uL54X4n3M+U6VOq+4hRcBBzIjHX182PgPtR10d3yGmK272RWS
         xnB3gJPPIjsjP4w5azPqFjm4uS9egoDA6VbJTM0E4ynyqH8ep/8Ubj4dv1dcO4UgCHs4
         ZyEtvtWYiUO52fJ0woGV0IDsXL6QYwKc7XDoZ6+P14KhczTDXX/OI0zO/kLVUhnb04Q0
         dr1A==
X-Forwarded-Encrypted: i=1; AJvYcCVF02njqAv8W41vf5aSvjMPu72rxzdPlWwEzEQ0WlJghapsxwbJ6ckIbNcr+rR6Tcevc0/BNjaAXNfq@vger.kernel.org, AJvYcCWAYMlBvY3Ll+Ar0ofc+PPi+uer22CCppb+8BjCeUX6rew0UiCanGSrZHBOlYKv+qO/w/SFtRgJWPUI@vger.kernel.org, AJvYcCXLhLxtom7pB8hae6aLWJbFA1JWRjqHHs1p3S9WBrqllbNjKzmd20I5t20YiiNMC7E4YuuoiHUACgZa0bRk@vger.kernel.org
X-Gm-Message-State: AOJu0YwsAwemnlHT558GVqiyRbM/EPVrwSAyalaCC5SzlqTC4Rt4qduI
	XVG23v/Zsh6+iCPgO3c4H8S+FthuU7RMwCMc+fYL8VHp0IZHJHJl2Kz9iQ==
X-Gm-Gg: ASbGncvaUSKeGbAhbbchI7RBlYZGCfx1uh5W6MgZoSSX0BOM2jgi8TuVM3FP58qqNft
	U5sYioc/v4ub38b3e4g/hjZ9Gygak8dam9vkyLKmOFKzl5sMibvxJcNmJpb/lLGnITttRewevLL
	MSdGuoo7qkN+IeEzkDUfBawM6uipi5N8QUR/sTt/mIS9GjeyBeRTCd2yC3/U60gnCflYXnPztdf
	4Odd7zBsQvhx3MXkq5esLjcfHoqIBeEgU71ECjZZmrHvcI1tNgkzB2CRMVPjpMesNMv1LKZ8aw9
	+ThetNTDXMmlih6vR6jrzlYsupTdFnHFA/640oiXhXoo1nEVvfRkUtDOyhcrzJQYTC4PtERPeM6
	BBDMS94KTJl670MYORYsblw==
X-Google-Smtp-Source: AGHT+IGVpodMsei7D8Ugi3wyH26NExd1z9hFpsh50IjGEY/jDppoCTMZF3oy+VqUXdplF6hwReupsA==
X-Received: by 2002:a05:6512:1088:b0:545:fad:a747 with SMTP id 2adb3069b0e04-54d64a7b7camr148915e87.5.1744783095591;
        Tue, 15 Apr 2025 22:58:15 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d50f647sm1595634e87.163.2025.04.15.22.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 22:58:13 -0700 (PDT)
Message-ID: <76cae799-0612-41e1-aee9-66358b9f5046@gmail.com>
Date: Wed, 16 Apr 2025 08:58:11 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: ti-adc128s052: Add lower resolution devices
 support
To: Sukrut Bellary <sbellary@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Angelo Compagnucci <angelo.compagnucci@gmail.com>,
 Nishanth Menon <nm@ti.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250408132120.836461-1-sbellary@baylibre.com>
 <20250408132120.836461-3-sbellary@baylibre.com>
 <20250412141253.6d57032e@jic23-huawei> <Z/7btoHi03NftNQJ@dev-linux>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z/7btoHi03NftNQJ@dev-linux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/04/2025 01:20, Sukrut Bellary wrote:
> On Sat, Apr 12, 2025 at 02:12:53PM +0100, Jonathan Cameron wrote:
>> On Tue,  8 Apr 2025 06:21:20 -0700
>> Sukrut Bellary <sbellary@baylibre.com> wrote:
>>
>> Matti took on maintaining that driver because he wanted to see any changes
>> that might affect the Rohm part it now supports.  If anyone wants to volunteer
>> from the TI side of things that would be ideal - just send a patch adding to
>> the new MAINTAINERS entry.
> 
> Thanks for the review.
> Sure, I can work on the TI side of things.

Thanks Sukrut! That's great as I have no TI devices to run tests with. :)

Yours,
	-- Matti

