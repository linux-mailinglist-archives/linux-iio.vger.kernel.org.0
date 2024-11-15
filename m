Return-Path: <linux-iio+bounces-12296-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D61A39CD6FA
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 07:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42A55B22A93
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 06:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7001F187561;
	Fri, 15 Nov 2024 06:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rqw+KIDH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F5613AD39;
	Fri, 15 Nov 2024 06:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731651343; cv=none; b=EiYAf488l7LuzjIxystPhDgyCh/Y5HJDdjljcyLDOg2TaJWenGWFWxD6UFsZ1+KXFj+YrSFhlrwF9GrVORa2RPLxwwNdpFEz7xK2lWE93a2l1RdA7s9RZT0ZutU0morODrlh67Ldyq4H3E/qTCE0k/FrgGHaQVlClnWF2MO4NLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731651343; c=relaxed/simple;
	bh=5d6jZry6UDuTmcWeHJz3MavTR/E0aUEYRcBieiOzVH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+cpDU8BoeLHlvqi2Y/O7TOaeW0F779oQdFbyRK7uMfeCQO0Lbv6ISStgzhU86OQjgH1DcWlF2Oy5zZTBgJtyQ0d7Np72DtPnx6b8ZMF5zkt9uMuzx8IwEpVtU0whoVr3eF/0haGXdTN7QvQU5VxZNiv5CRxWB/9Bot0ITppLWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rqw+KIDH; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53da3b911b9so349934e87.2;
        Thu, 14 Nov 2024 22:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731651340; x=1732256140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lwl6jHaS+Rj/XSsr3HGpdPfbezQhvl6liiIsOcGm9T8=;
        b=Rqw+KIDH17e9So1D93X4FRHYnDXg6x4UieEPfQw9ikvNZXgSsqSobDAVIa6EO2oViJ
         RMqtY+oNxATKWu96e3HZkp8/F/7lRGGKsmAnlBV3Y5VEuIFw9Q2/5iudiAhA4pYSYIwl
         EcDtwOvFruXtVb6KE7LkiACeFLpfayX8DvU5tsK2ve8IPzMRQPAENkTBjzoVFQMfV6td
         ZKilJier80fsCtgC9vInSIkVVPvxzzJTlMoB806gukF8CPv6EcIA4pGiTi2rR2mEVDSS
         6+TlydQIyNFQpBWmKnqMdSXinWoTdVeI04JeuZIfm+TQ8SoAokWZF3+gRmylLccW0Sjn
         elrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731651340; x=1732256140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwl6jHaS+Rj/XSsr3HGpdPfbezQhvl6liiIsOcGm9T8=;
        b=H2gjqhV0awf62GUHlJj20whe7Wez+eSe3WPzaY5/jiST9UyTGO0M9juStw7obvuam1
         FkbzuMGTgK3sNtnNZUbWnYWZ4lpBYBv0uosea3aIJmAlWWrAlTjDLYwJ4QBPNpnp6wGe
         AB+c2pPA9rslJOjp4nrgyrwvB5EotxKvlan6ejxA8IlJZUodUUerR8bPS/tmTpUTxH5h
         G7zVsSnMjX79e0qSBgvYNs0sOaD54N3a+37bFJkPP50sSu80pAAEs4Q7R3D17DhV/wYu
         Bv85IFFDDqhHd9bRwNrKf34YSgXw7USzas/WFr4wFNYcTYxVe/YQoY+OFpg2ImfUz1vr
         M3bw==
X-Forwarded-Encrypted: i=1; AJvYcCX3t19voD8oZBmlB/fv/XQi9z9aKEP/hZKmYYDJHR+tVky98lTAv6SG2XavfpOzZmDehSaUqTw9TM3k@vger.kernel.org, AJvYcCXHIvGWSOVpIXZMvq4JFuu69YKE3hMSl7d+4cnkn3LvxBbTWVghWi3kecTqUBD5MluAoB1TjpkTk8eJNLcG@vger.kernel.org, AJvYcCXNtyLAmxg9pspnPasZx9+0Lu4u8TotC/GgR4rQL8LIIReRCfR4zrXFpGgDnhzeVN7tKcJmjlphkXbi@vger.kernel.org
X-Gm-Message-State: AOJu0YyjDpdE2GTK0G5rSVw4Wl3XysJHlTXL2hFzt4RUYTxXQjhJXAc0
	ouf6gLHjvfdcAaXXJK2zv7x6+MQo9/HBzeMeGBN5scf0ajGODldEEiXtYPut
X-Google-Smtp-Source: AGHT+IFmlvIMrWcxxFlUrWMhPi154xUtaxwPA0GS2O60umHIFrpIaQuFVbW71LcjmRHrZd/zJwJncA==
X-Received: by 2002:a05:6512:ba0:b0:539:f1ce:5fa8 with SMTP id 2adb3069b0e04-53dab3c4b42mr504127e87.49.1731651339269;
        Thu, 14 Nov 2024 22:15:39 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da653e1edsm438220e87.183.2024.11.14.22.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 22:15:37 -0800 (PST)
Message-ID: <be11e656-a8be-4603-bd8f-01e3bdc56677@gmail.com>
Date: Fri, 15 Nov 2024 08:15:34 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] dt-bindings: ROHM KX134ACR-LBZ
To: Conor Dooley <conor@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1731495937.git.mazziesaccount@gmail.com>
 <d979a0a8160118d560ba2255346d05237f73b9ce.1731495937.git.mazziesaccount@gmail.com>
 <20241114-afterlife-ride-08068767f1e4@spud>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241114-afterlife-ride-08068767f1e4@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/11/2024 22:10, Conor Dooley wrote:
> On Wed, Nov 13, 2024 at 01:20:49PM +0200, Matti Vaittinen wrote:
>> Add compatible and information for ROHM KX134ACR-LBZ accelerometer.
> 
> The commit message mention what makes this device incompatible - but
> I'll let you away with it the description below contains it.
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for pointing it out Conor. I agree the commit message should 
describe the KX134ACR-LBZ a bit better. I'll improve the commit message 
to include the g-range difference if I re-spin this series - and try to 
remember this if I get to support also some other variants :) A very 
good head's up for me as I didn't even think of describing the 
differences in commit message!

Yours,
	-- Matti


