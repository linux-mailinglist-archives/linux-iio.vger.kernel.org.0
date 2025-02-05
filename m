Return-Path: <linux-iio+bounces-15057-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B6DA29D87
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 00:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF403A70DA
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 23:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72D721CA11;
	Wed,  5 Feb 2025 23:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aKPVi75/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592CE215778
	for <linux-iio@vger.kernel.org>; Wed,  5 Feb 2025 23:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738798130; cv=none; b=g6MCwd77rkHZZW64GFMvLeaKIEnY0xXwftH3i5UzT287eCs7nuhzsTrLrPMZivJ1Of6u6vgUPXiulAH8s+LI4mJIHzRdUugBMd1U5gDQrTdZM4F0fnrEe1e0XJchG8kNO4O7/82ikkndKg7EBteGErrTLNRzSLzAj2SaSE6wwD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738798130; c=relaxed/simple;
	bh=0EzAPAbElsLsVGFInVwzdFJhP9tAB61CEcoVn2BONPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ju2NM+5mHALRw2LFSdqVxuG+wGz8ACiT7orDV5XL944B+Q+tfCuGnvsMUkdKKOXLP4Ihinh//a+r4yvgVwN8zyRq1ojJCC7um38+u9XCklLT0A8S4Wrq26jXNP/XSL4nyTAyG1L2sWOEhvM2Oc5BgPd/2P6WyLbTXG3xf4Vpkrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aKPVi75/; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3ebadbb14dcso152804b6e.3
        for <linux-iio@vger.kernel.org>; Wed, 05 Feb 2025 15:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738798126; x=1739402926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3TqTxkp+S9AKdmaVffatqfNq4mqc2luDLtoiQq2r9VI=;
        b=aKPVi75/71Itw000j1UNdhTRgQr0p2Zwa162V8/FjSqdVy0Poer/oAjl03qHiq44/i
         qc4EAnfEQvNMl5HGZO+NopQLROkg1BY592yv3l1txoBQGVyr1mHTA6Ne2HTzYWURDfeV
         EZgYxZSsaEyrWv+aBPjNWBOs2IXdinlCIS8WaaZCj1OqKaMFy5PkSijmGR3pC4h/dA5h
         e4b4WeWujdo7/Gi1ap0JNwdIy0tWi/kcecbFVmr7yINsBd6lNqVQWy3528wrggbZTM9O
         uelvSGG6ttp2R+ey5L/4bmoIqlbrJLmM2Hee3emJ4+YG5G/+jrNbmfCHSUDp2sf4DDv0
         EGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738798126; x=1739402926;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3TqTxkp+S9AKdmaVffatqfNq4mqc2luDLtoiQq2r9VI=;
        b=PhnA2o+KVvf/Zt2he32KWvSFQ8DB/WFJg1iTYYFnQxSIBT5ld23X+V+X/YcecGeA2q
         lDdAbim4n5ZQSYrCnfsc4adj+5h2oTvopmYb7dYZaPomfEiFZIqmCMcf+EQl2o+Hu1ro
         9TdGGqIL0TlwtjJoUv+UinsyYaRLmCzcNkxsrz3AGVXLSdUOhlYsPz3Atp9WxszF/uCR
         v0I7t59DEVzVk7Y1VQxni0TPgeROk4ZRw8RjbKlP6FsMClRtWvEt780MzGTNvHVBpev2
         q01rBPglVUbNlWnmaqBvPboonWcJvO1BKdSrMa40p/X6jtik4/rdPC0Uoq1rBASv0sqc
         l8qw==
X-Forwarded-Encrypted: i=1; AJvYcCUWtOj1CQW1HbYQxj/5Cx7rG+rF4lqQa9MvIdFvrZS33442Vjxm/91LGrSPWr7bBRp+Vn80QgJhEWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtjCSMbizvhVMN+gzdZFwdFZ1wRVpuIVOzRWhZUBGo+0xxp+YT
	RUxfLz6i53pTcx2RqcAekQYlH1WH6IBhw8QbXbDUSlXhoGC8Ysbs3vJmfjG48Js=
X-Gm-Gg: ASbGncsfcYdRQH2xeO0YjALalFCnIFERFjcLTvFH2PKQrVsxZFXzemM5Nt4ylEGmwe1
	uD82Qxt1toId4LHIkPCXUXvAqC/8dnM7xDwAle0rmfbwDld4zmXsbGlvpXhhHt43hrCxMAxMuuy
	weloFmBJzAh5u8aZ35vEEl6IJkhUd/igcDQEmSoWmqj+k1huHML6NrmaQm2WvQzzi4OH3dwx4aF
	OYNdqMh/lUXUkAMPw4KYYkzYQi0oua1K/6kDlEHHYhMdEG7hkmPS+89KlJM3AB7RJCBiT0zCHqN
	BpEZShxBGxBbhA0V8WQRf4u1hC8yD1hmpKcXR9eR9Bu6lJ3tPy98
X-Google-Smtp-Source: AGHT+IHueH4Fqz21RYHypIIor041CsVTsWiHnTfaBtoozr/+H4z09+QY1xbWPTKxUKY3zI5U44sHbA==
X-Received: by 2002:a05:6808:201c:b0:3f1:cd30:d691 with SMTP id 5614622812f47-3f37c1d82a0mr3144489b6e.37.1738798126357;
        Wed, 05 Feb 2025 15:28:46 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f333660e78sm3802679b6e.35.2025.02.05.15.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 15:28:44 -0800 (PST)
Message-ID: <896ab8aa-3cd6-4e78-9374-8883bacd1fff@baylibre.com>
Date: Wed, 5 Feb 2025 17:28:42 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/27] iio: adc: ad4695: Stop using
 iio_device_claim_direct_scoped()
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Mariel Tinaco <Mariel.Tinaco@analog.com>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Gustavo Silva <gustavograzs@gmail.com>, Nuno Sa <nuno.sa@analog.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 ChiYuan Huang <cy_huang@richtek.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Guillaume Stols
 <gstols@baylibre.com>, Cosmin Tanislav <demonsingur@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>,
 Antoni Pokusinski <apokusinski01@gmail.com>,
 Tomasz Duszynski <tomasz.duszynski@octakon.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250204200250.636721-1-jic23@kernel.org>
 <20250204200250.636721-12-jic23@kernel.org>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250204200250.636721-12-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 2:02 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This complex cleanup.h use case of conditional guards has proved
> to be more trouble that it is worth in terms of false positive compiler
> warnings and hard to read code.
> 
> Move directly to the new claim/release_direct() that allow sparse
> to check for unbalanced context.  In some cases code is factored
> out to utility functions that can do a direect return with the

s/direect/direct/

> claim and release around the call.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/ad4695.c | 240 ++++++++++++++++++++++-----------------

FYI, we still have a patch [1] hanging out in patchwork waiting for dependencies
that will have a merge conflict with this. Should be able to pick up that patch
since -rc1 and then rebase this one on it. Or we can do it the other way around.

[1]: https://patchwork.kernel.org/project/linux-iio/patch/20250109-ad4695-oversampling-v2-1-a46ac487082c@baylibre.com/


