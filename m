Return-Path: <linux-iio+bounces-12476-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3FE9D5972
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 07:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E2B1F21AC6
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 06:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BAA165EE3;
	Fri, 22 Nov 2024 06:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4bcPine"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200D815ADA6;
	Fri, 22 Nov 2024 06:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732257658; cv=none; b=DLVULA+Yd1maHn3r0vlOsKVkFH3mu7sI+9Xwe2v3J+osDikbmnbCO/kQLrimrQ20JBIIc4iQnVU4fYUOTKqDdjNa3+HHTCmqRHdexgTeyuQQwwuQK90cFg2cz0Cwxr9dy1osmpZpR2Xp+B+5jHZULoRjv5CHoAt6T30oj5Wtvoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732257658; c=relaxed/simple;
	bh=26D/Z9uFyG0YW5eH5xtK2TLnJWPe8NDCp6x+hHMsWQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJqhh3LUM+zlsim+ZMNTOMthhxXScaFdkelVN3DO5o0VEw+3NURh01NRAPVb7z2/IN4bNWuez9WF1z/ECd+UAwgnRtIn5zd1DflsBEQ3K7b8jHndugpXGqGVlBzr9uRYFwY3m1r3vXfHU63FPHQirEs6UIbQQ7nuJiXuT1y8dtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4bcPine; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43159c9f617so14115105e9.2;
        Thu, 21 Nov 2024 22:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732257655; x=1732862455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jqLBrHXK6iNPfx719nVz/WHaCRB2rjCsj/g26HhodWU=;
        b=X4bcPinesSYV5b8AzscnEPCFopf22MLXhTt9UgRQEOVJyiBd2BF3iKOMoCkEcNlX4x
         InLlybs1TObgVbPe0Orxl1Pc2Pmjuh3W4DI7NibGgnEvZNUxDtRyzEMY7WyG2WUfHS4h
         iLBJp+HyT2cH//V9A61jT49XVJqbgtnR+OU3rrzqpZZnpD2MF08IBQdDNrgOie95kMxP
         WntXL8+WM48uvkEIZv65IPVL2KdLx3zV0tOKMg/ZUqGjetB/1aZOrbsvyjE8eXmgyCaj
         scC6jLdUPviAAyrwUjHtnDnqKioVrGTy/kfHOwE65/iV8/8PoHpsOewDB1fSLt2xex+m
         8roQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732257655; x=1732862455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jqLBrHXK6iNPfx719nVz/WHaCRB2rjCsj/g26HhodWU=;
        b=f5czmso6aMJXoM0VoqmLJKXJOY2tpQ0naFrMDHMM63X8kBqhyIKtfgNrGF20sM9Q4Q
         KIA07l7cUwGElW2zUrqb1kROBfunnLvE1IOZmHRvuE/fKiMSHjDhfOeYPhrtgSO9iWsA
         0RU5gOPbr0blEv5KsRHiBK8tYipQ7d/OcNfol5Zmpl8rGkV9n9dnZ6lI6DS5buxQGexm
         gNzzG4xCWn/yl6uTcXwjg7mNYNwMtwLFH8pswgi88IBD6xOCJbMe0fDJ6CDpHt9s3Y8i
         /Wo1xtaQ3K7ohvfIvlY3X6DIeeHicdzv9vvyBziXsfHwfPdPHwACO6B7XXW0P/Hfx30i
         Mjhg==
X-Forwarded-Encrypted: i=1; AJvYcCUev7p4EqogIyU1F1vnbQdQiwBXV+Xd2lCZrMsg2Y56lS5RWs+6C72sCfh9+QGq7aKdSuxcoC7FJ8ecEJJu@vger.kernel.org, AJvYcCUnvZjYxf1JvAv+ySeAf9+96gc7BgQqtAG2IupJdGM0xKZudFIKD1UAUNmN1w7JX8Wxe1x55Auz4mo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5X4mLLcYP/snGnL8HhPG8gbGVXfawm7Z+b8irtlDc3FhDiuAM
	ouL1vxIh8pGX5SxTcqRo8LTOyUbDb6qCnVCQolxz6594KX1nlMDc
X-Gm-Gg: ASbGncupg7qYC7358b6T3HAvtmfQuSac0+kf2FrETXYyFzOD6f4Tqr0R1lGtbFTLqN/
	WRiFAZz1F2+NFbdqoqZty29kjb5PoxaCQ0PaK+kM3kZfRdSPKWBdxPqj9kReahYU1u/f+mwlb+T
	RlWfSnycMKZQWBvcxo+x4DaJkvcVwwneRc6jqQlJAKpliskHIj+zB1tci4jx9DBFqth+WwC8QOt
	mkogZc7Us+fgFTdd/2R2ABvXfhoRfn6HkyInch/9SE9iEL2P6/qPXPzQcIJWivRzWZjBQKbqfzv
	siaMAhUVFzecAN/UWOtBlTTi2Lp7K0LDEAdf3XfR367p+8wRsVyrbpN2TZja7megYJ8L3QafTtz
	2vdHMfeSDuHaddSFYS6FfjAh1VH5fRGkPTvoY8JUu/qY=
X-Google-Smtp-Source: AGHT+IEwVLgkj1d2J7iL6HHLeviVT3/e5Auq4n44oc0DgOtqP6r6pnHbYvrGp8/Yd69IaowUNkDFHw==
X-Received: by 2002:a05:6000:389:b0:382:4b40:becc with SMTP id ffacd0b85a97d-38260b4ed6cmr1539923f8f.3.1732257655275;
        Thu, 21 Nov 2024 22:40:55 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:182b:b217:1455:c275? (2a02-8389-41cf-e200-182b-b217-1455-c275.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:182b:b217:1455:c275])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde070besm16909355e9.2.2024.11.21.22.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 22:40:54 -0800 (PST)
Message-ID: <416d2029-7678-4a3b-9980-92afbbb49875@gmail.com>
Date: Fri, 22 Nov 2024 07:40:53 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: bu27034: simplify using guard(mutex)
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1732193263.git.mazziesaccount@gmail.com>
 <4e65a4725c211b166906f70fdb5ba90f2af0f570.1732193263.git.mazziesaccount@gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <4e65a4725c211b166906f70fdb5ba90f2af0f570.1732193263.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/11/2024 14:05, Matti Vaittinen wrote:
> The BU27034 uses mutex for protecting the gain / time / scale changes.
> The clean-up for a few of the functions can be slightly simplified by
> removing the goto-based error handling/unlocking and by utilizing the
> guard(mutex) scoped mutex handling instead.
> 
> Simplify driver by using the scoped mutexes.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>  drivers/iio/light/rohm-bu27034.c | 73 +++++++++++---------------------
>  1 file changed, 25 insertions(+), 48 deletions(-)
> 

Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

