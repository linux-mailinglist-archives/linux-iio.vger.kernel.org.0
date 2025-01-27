Return-Path: <linux-iio+bounces-14631-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2E9A1D96E
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 16:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFB297A14B5
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 15:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF8225A658;
	Mon, 27 Jan 2025 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ro4Itc3a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECF5EAD0
	for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737991460; cv=none; b=hL8sYQVOlC9z8slBRfxosjwKhOIhCiGdwPUwgQ6rikXqxiyWxrTwBZlH3vGbje/0JBu28YcQNGwK4+tlElZBUraxNJCx6NgulGOLxeI1NsfJq5ZtMzEKUg1LGNXyqH6L3lka4Ip5W8yzu8LVOfyZpCfMN7tuBO6B6O0ym7Dp/8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737991460; c=relaxed/simple;
	bh=C061X/fQ2LtEQLjG1AwLDA3xFZJtYZtYQK5XJkYvQA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLVmMhf5aYVVgInwNvNoYBDFVHA9e4UphliqvXJvMv9L98D1F9Nf/GCaUCVzRapeQivW/onZu0Q2jj3F0e8uE8RMdmfcsM7XZh9Bum2oOW7AT0kEBEbT9beVpbXsYhDVDqLdfhH6hg+IEOjpLBJWV2HMeMhyJjsWP0o7hyG0KOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ro4Itc3a; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2a9ef75a20dso2653670fac.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 07:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737991456; x=1738596256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=skHpf+xWLASVnB8ELjMQj3KKy12yHsypC1y4ZyrjFnA=;
        b=ro4Itc3a7nHKI05uibRMZ4n4IlKb1occ95pqLxCJ97i/8O9mOJ7drouIiXT+nMAMDP
         IikonhvharxL6zOlqyCS+4iJ6RVf1XKh47MPc+h8JEGzMPQ3KgUfzSlYVzh+AHF7I6Y3
         TKBOJ8D9muZiRgKoBXNPY0S2JM3Xfa7XZh9pMfT9KIjGI9JDOEh+1AdsAzbZalYx2RRG
         MNRBcejMXW94xvb13n9uVl7JtBKmKPw0p0c6wy4FM2AuS+yBy+kwP7avr6o6YxbRT9ct
         E9qNvvbWuXnLh637oBcQG80tFKOwvWlk/QD04cViA8yxrWmrQlMzKor9eButW9Q+zgbm
         x7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737991456; x=1738596256;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=skHpf+xWLASVnB8ELjMQj3KKy12yHsypC1y4ZyrjFnA=;
        b=m1DDG7maTaUY6A/KA8Q2c1ZRuX8tgTztzKerB5pMVoCpp667t87v82rAswQJKywFXE
         uylGpYimdGyrwmY1wY8GXOqwLKBARjLyQcpa2Xfz0FDrlndiojFqxh4uUuk0HE7spb3I
         csN1x+MitGMtjgZ9LX7a8CY212b2BAavRuU8DsqWEjgJMiS7s1SxDaExDJ6wua31ML4n
         DwHpWR3O9IvC9tK7usxCcskjcqdJ2Czq+ozDw8hnYY3HC8uHk2ubM7UHWOME8DrVbIcK
         PZg437egmfkmha228v9WbTN3UnwRlW5OPOLJcQ52b+eCM1Hu0a7m5xSNpJEVONiDjqSa
         5eJw==
X-Gm-Message-State: AOJu0Yxzdp6Zvurd0ZRmeKpDS7YaLdvjYE48hLGnKU26efhEsjf6B2dN
	ZfWqX76icamuXUpx1GVt1YLzoaBMUNRq71I4OLcRHw8ENyB4ufDbk7XIqp3kJjI=
X-Gm-Gg: ASbGncsC2cKXDdLi4Qn9BztEAgk770xuoc8gHeRdN3SBaX1ZYvInuuCKalY0PDQLyY4
	CI56hzWJt1cG3x7fHXI1ZZDcmp+3JlzKwzxhkf9T2eJy1COkqyHTZF1w21awgaDBv6I3FvjMABQ
	kTmgtM/uuwSWSUVH2Q35rKVbI3uTZJLPulneDbrCJxX//X3U3n/eMI/aGn+MC9INDbL2CxSLmJw
	JjbMXINaybCgFzR1O2PT0XoIKKCug70UulHN+ZG5Rz9E0WTthvIcu4MBF0mINSy43aeQLGzDGxV
	KoyHLue+/HaygZ9290lmeehATgwxPQiX7ArEeuSbIQ==
X-Google-Smtp-Source: AGHT+IGXCu1KtafRew27ycU/kGJdpvIdckos+7ePCXBHMEwDHwWxC9eiYYQEGTmkiyMudHV9H3kVCg==
X-Received: by 2002:a05:6871:a4c7:b0:29e:4346:7fb9 with SMTP id 586e51a60fabf-2b1c0ac9c9dmr19706932fac.22.1737991456677;
        Mon, 27 Jan 2025 07:24:16 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b28f0fad81sm2652546fac.2.2025.01.27.07.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 07:24:15 -0800 (PST)
Message-ID: <67b87690-f663-45ce-b665-c3decd716b44@baylibre.com>
Date: Mon, 27 Jan 2025 09:24:13 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] iio: adc: ad7173: add ad4111 openwire detection
 support
To: Guillaume Ranquet <granquet@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nuno Sa <nuno.sa@analog.com>
References: <20250127-ad4111_openwire-v5-0-ef2db05c384f@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250127-ad4111_openwire-v5-0-ef2db05c384f@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/27/25 7:59 AM, Guillaume Ranquet wrote:
> Hi.
> 
> This patch adds the openwire detection support for the ad4111 chip.
> 
Reviewed-by: David Lechner <dlechner@baylibre.com>


