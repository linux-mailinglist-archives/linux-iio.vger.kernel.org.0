Return-Path: <linux-iio+bounces-25854-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E35C2CC9F
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 16:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1EF189CFB7
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 15:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501F531D392;
	Mon,  3 Nov 2025 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZD8IbO1I"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74E9314A90
	for <linux-iio@vger.kernel.org>; Mon,  3 Nov 2025 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183255; cv=none; b=rsyQ+5ikmzWjbThfvgFTwC9hFFW/eg659k8Rudd/0Pj38uMP38qeTC/sKOb0Q7dFyCpnGQVMJkXz0/Hr0eAWn6dlTvs0TruOu8I5mku80nhcOPSK1/N+vAHz3PKtuHDvW6G8skKH0IHE9+fw9ePRsRzo97+1gmKSw+GoaCu2Ewc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183255; c=relaxed/simple;
	bh=lCHtQe/XUv0C3M6ixsewWlKvViVNAryOiofDkbNl3Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dfX/xpDwts7Y62s2XrMcewXsK/TiJDgiqsYvkhflS7E5m4aC4v1CtCK4gwpSZHzPfCvzQZ3XfNA4eVBrRViIZQXdCMTl6jzyQm4Eu6AykfErGPPZSjyEA0F4xElE8locDBcAAGvwBgbdLfXt7C5OyLa0BGhwyqGb1A4KQBObbBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZD8IbO1I; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c53a8d1e42so3681562a34.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Nov 2025 07:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762183251; x=1762788051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UU3IMwLVIuqUs9WFksfEbffdOpEdabEos7vPHn21iN0=;
        b=ZD8IbO1IUwKTJ9T1AVdGhe4mLoahqyPmUahRXcclM0ECsRAdmvb1gM7r5K66qOnmAG
         5K3Dqe1tCMT/Ky1mGTweNNPK2nmAu9ylEL7gOrM3zcXrgUSZk4oaNyhENnsyBVaWoipM
         aiDhTrY6CTcmf+jPBT8OErwj93F0vsF4ye1HEbINUw4PbHXZ0Lp5wN0wsytBlg2o/Kk5
         d5YsCokRx/7VAvJwXs2on7ZDdWjETAnIFSJus1HpseQysnq8hyUkwFs5V4fRpWFaSU9Q
         pU7WmbT+fuF/zezkNPcbS1f2ToNy5SDmPUCsb0cbGC2WnMCrUolW3NiSYguf5Gas4E1u
         78yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762183251; x=1762788051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UU3IMwLVIuqUs9WFksfEbffdOpEdabEos7vPHn21iN0=;
        b=nqhkqwJ1q2t5IergVWVYwniiH+IE0sQCh1R4ENb6IApC3qNf0FxJvmO/WqXfs2K9KC
         Zx/1GV6w1PrLt08y7Be3Hl6BMKcRLaIpZl422COp0YDgI2Iz8zhN4wsp4xW1tYse4/UO
         nLMndD3f7P7cQgLuJSAgzBdz6d9nZJlb/uhoZGnuTGBPQ0mtD+VkkSMJPlyI/d15OVJa
         lMq5KHjDCP/A6hROx4sKCo1jkUqQDklNHoyRyK3ffKXjS8IsBmfiy8utaYsx++Ogmp9I
         xC88euu20Jtizzb0t7eU/F+fPrQjJJ2LA4WBH5+p+HL4yS9ap4dQM0J4wS30bvOyB20F
         oqHw==
X-Forwarded-Encrypted: i=1; AJvYcCW0y5oB1tKFdUiSh/Mlvpl7zi2uqsc6dSCwpEn4W7slOQMJPFOj+NpwBfxwO2ZipSNp6hiMaDgcc34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7zBhXjczPpQkFv1EQ+nC0mo9DkzLVyb1K2pOQ+mf4QhnBc4fR
	EWLtTxkX6HGlFMhb8IgtTgqtH6gSKv+2z/bBS4SSv/txi8TXXdeZY0vf2xZLBICAu0wTNgFkRZ6
	M7Lzw
X-Gm-Gg: ASbGncvyyaSk82/5gQ4MzszyKX5J8Fa4Z8g2KhzrdNNUB0iXKQzFwLVCwC6HqLirPs9
	IJAk8YcZJrZZ7ZTipno+a0OnMgnm1WLekeJeTvLzyxXFr2+Mfs7Y5kDUke18SJtJDrcAEf5Pc1k
	eaLs31l0w2X3j9X8SQDarzksq+NntXFzq5iHU0juT5J4WkK7X7w+Wj6yjAN4411XqmnYa9Mu4ZK
	MBzU3nA4qnkIliyzQOW22/ufx1hMxndvkEWV7OWhWUZ578iANtaS2vqjNRgSEEZcjBzqtO5xYjM
	SPGR+ql3dWR59VXhFxwgXcnR7IRUtXzEwbaLLDAWCr/2NlFOzgdvanF+MLVcDN3RKvDwrk5ouLz
	2KeApDpgNLi7fRPiSJoqbd4+23B+Jxwmb4PE6nFQSK1JM1ccFOEWgPECO8WxnAbvp8Pb+3J3BJm
	EYT+XsDSmd1azsUhdnek7ioXjZQdRESLd4hn1eqCE4O6y1MDJ0c9yKozsDebcH
X-Google-Smtp-Source: AGHT+IEI7oaPwbMLZyrFhJm3x/2HChGggXyz1ZeRNUlqpKNsCrcEcUIruRtbDhBeLo27AIpbulOZpA==
X-Received: by 2002:a05:6830:67e3:b0:7c5:3bbb:9ba6 with SMTP id 46e09a7af769-7c68c82fecamr8720707a34.4.1762183250808;
        Mon, 03 Nov 2025 07:20:50 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:37c9:fd3e:34ae:9253? ([2600:8803:e7e4:500:37c9:fd3e:34ae:9253])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6c2448c9bsm208886a34.3.2025.11.03.07.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 07:20:49 -0800 (PST)
Message-ID: <3d2fde56-d82e-40c2-9d0b-2888160a642b@baylibre.com>
Date: Mon, 3 Nov 2025 09:20:48 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: adc: aspeed: Add AST2700 ADC support
To: Billy Tsai <billy_tsai@aspeedtech.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251103105217.1764355-1-billy_tsai@aspeedtech.com>
 <20251103105217.1764355-2-billy_tsai@aspeedtech.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251103105217.1764355-2-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/25 4:52 AM, Billy Tsai wrote:
> This patch adds support for the ADCs found on the Aspeed AST2700 SoC,
> which includes two instances: "ast2700-adc0" and "ast2700-adc1". While
> they are functionally similar to those on AST2600, the OTP trimming data
> is located at the same offset (0x820), but uses different bitfields.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


