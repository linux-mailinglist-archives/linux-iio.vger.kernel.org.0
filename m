Return-Path: <linux-iio+bounces-1467-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B18826601
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jan 2024 22:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2738281A2B
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jan 2024 21:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EAC1171C;
	Sun,  7 Jan 2024 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="dL1qdgrE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7A411703
	for <linux-iio@vger.kernel.org>; Sun,  7 Jan 2024 21:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-557a615887cso436559a12.1
        for <linux-iio@vger.kernel.org>; Sun, 07 Jan 2024 13:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1704661535; x=1705266335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k+ZVVcANjcAGMgQl/7I9HIpGBWAjEsO4AcNMvo6L5oU=;
        b=dL1qdgrEK5euJjGRM8m3sCxOEWxISAp5I4xR9jPQ+S6CaRZ3/mLgJ3YQffdnwJjJZx
         Oz8d8PvL0olpdxkxvpKWozttUnNZ7XH/4lQaXoLjz2Ebo9ki3qHbF+176yZovj1GAZpU
         BWxWaB34lP8t6rjwL07ZokuVwh+q7iQDeTpmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704661535; x=1705266335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+ZVVcANjcAGMgQl/7I9HIpGBWAjEsO4AcNMvo6L5oU=;
        b=UiOFlJRlogs7zT5qQ2n2KdcT2nRk+PgO0t+I+NveQsOiBGBXtOCngEUAW6/BFBdKpu
         3hyrpWUA9F2mF0XT/SThu6w6f1gIKevgGlMyMR0jEqOahg2JaOJINa9FkL00a3FUV5Cu
         o9rsdna9BIXmQESOa5WHkRlWTVzrNVCP51cjT9B02E7ftsFwwYnuAMejCdTGiheHmUXs
         /s+cm7jaWqRu634D1TbKREPJoD99NXJEXmlx6sruwE8Pvsp7UgE+yd78/+BhcfXP6R60
         gqFCeZzLH/CYvrTcUMLwDwuFEsUupG6mvNE/OiY3slcsRmTSE7zjUo6fPHfivDDZxCv6
         +QUg==
X-Gm-Message-State: AOJu0Yx+2773Suk6T54jXBqDm8DNKVnvaWmdLSg4Ry33rnqo7l/SaINb
	Ok/gU9e10Tr1KJAMi8fdKlYRPUi9h6WZIg==
X-Google-Smtp-Source: AGHT+IEi0FM91KAwrQs/JVBQdTw5nI1ZI3dxXbk+HuUef9f5gXuSFa++IYxAchveJoy3p7lBQxsXvg==
X-Received: by 2002:a50:d543:0:b0:557:b309:9266 with SMTP id f3-20020a50d543000000b00557b3099266mr237782edj.39.1704661535577;
        Sun, 07 Jan 2024 13:05:35 -0800 (PST)
Received: from [192.168.1.28] (77.33.185.10.dhcp.fibianet.dk. [77.33.185.10])
        by smtp.gmail.com with ESMTPSA id s12-20020a056402164c00b005532a337d51sm3554021edx.44.2024.01.07.13.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jan 2024 13:05:35 -0800 (PST)
Message-ID: <4b6f283d-48b9-4702-81dc-003a2dcfc3f1@rasmusvillemoes.dk>
Date: Sun, 7 Jan 2024 22:05:35 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/13] device property: Add cleanup.h based
 fwnode_handle_put() scope based cleanup.
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
References: <20240101172611.694830-1-jic23@kernel.org>
 <20240101172611.694830-2-jic23@kernel.org>
 <ZZlu5fTW27Tx3drB@smile.fi.intel.com>
 <305F62D9-8410-4F2F-9411-5A7395192789@jic23.retrosnub.co.uk>
Content-Language: en-US, da
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <305F62D9-8410-4F2F-9411-5A7395192789@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/01/2024 18.53, Jonathan Cameron wrote:
> 
> ething similar and PeterZ explained there why if (_T) is
>> important, hence this should be
> 
> I can't find the reference unfortunately. 
> 
>>
>> DEFINE_FREE(fwnode_handle, struct fwnode_handle *, if (_T) fwnode_handle_put(_T))
>>
>> or even
>>
>> DEFINE_FREE(fwnode_handle, struct fwnode_handle *, if (!IS_ERR_OR_NULL(_T)) fwnode_handle_put(_T))
>>
>> as we accept in many calls an error pointer as unset / undefined firmware node
>> handle.
> 
> The function called has a protection for null
>  and error inputs so I'm not sure why extra protection
> is needed?

IIRC, it's for code generation, avoiding emitting the call to the
cleanup function on the code paths where the compiler knows the argument
is NULL. And on the other return paths, the compiler most likely knows
the value is non-NULL, so the conditional is elided (but of course not
the put call). Read ERR_OR_NULL as appropriate.

Rasmus


