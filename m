Return-Path: <linux-iio+bounces-20009-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A24AAC8056
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 17:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502801BC3C7D
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 15:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB3222CBEE;
	Thu, 29 May 2025 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Cpn/C4VD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EACA21D3E3
	for <linux-iio@vger.kernel.org>; Thu, 29 May 2025 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748532805; cv=none; b=sicN7OOSr+CP2IEICOmZqitIV1YyYFpwHw17oWQA3f+t913GgeFOMTigvJduJlSKsctTINEgcfuIlCCWzbo+ZXW1PUU97TYCU/9qQk3jbKgK7G15rN391joHwKcD7E1p/vwwh020gzjZwyCqxsFSOc8jYZdsaiNpfuvCaFcFClk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748532805; c=relaxed/simple;
	bh=QGw3SeVFXYVYOzL+kW264JyMISWAAxmyJ1DyNg+uanw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eO/RRCP8LQR8LB0sEcww0PinyKBtk9Xul+IVNUbMMCooTmEsyhRb0SjAkRKgEC/4BOBGfYDI/DDYDLUSOONmHUd/uleUyiAUBvu8A8lmHUfZPCzTl6YTnpqZ8RkpE8oIbamp0+y4D8YbVK9KYX4Ab+cTNUpP/+uHSkfuHk0++x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Cpn/C4VD; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3f9a7cbc8f1so367475b6e.0
        for <linux-iio@vger.kernel.org>; Thu, 29 May 2025 08:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748532802; x=1749137602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QGw3SeVFXYVYOzL+kW264JyMISWAAxmyJ1DyNg+uanw=;
        b=Cpn/C4VDp2ry6zUF40Q8KRuYqNXzfKsBCIDZecGYi/KCS/ymLiHwMWf7fybCS5q3eF
         i8vsuVIxe1MVNb72xjZr4/t8mRsZ3FTvO8G2T0Iwfq6Q9eHDhC6tyfRaKggORellayD9
         sh08d72MAorDQZezq6YyEi80qtBnbJjwn6lGtn235eXbqbx2xFSfyancDpGPvIV5XUZE
         yTHztTmMYnLwK6vnB2g+ODvjP1jns4UzX6uezwpqUnZKR0fhtyFk/1QCay8sRMmH/GrS
         TRLx3mgoQkbp+KnOzuUAwAhW++rTl+co99t9jdXA07FIclvZ9F5ubDDlkM1igddsNfw+
         2pIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748532802; x=1749137602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QGw3SeVFXYVYOzL+kW264JyMISWAAxmyJ1DyNg+uanw=;
        b=ZnqRToC9Xkv3fQGuud4SN3JayCsM7vKjSqkibt+Izs6Tu2xFP0mAATNEe4g6q1N+db
         MEJjnTTyChdjLKmMwN7VncFZzWY6cmslKmhBF7d1vO1J8OZkCl1SXrNXnI12EmOHhzDh
         xW7IVf2e2HhevKrOw1NhgwYi6TumAxg0tiw4HFla2TVZ8WyFePt0JrP9U27p+CLgddI0
         bStXqjdUcPfxBT2Q/lpPemgv7UBoTkFsUNX1D6wrcqg1U3rejZ1RM9ttd4GJ274C5r6v
         H1hvgQf/MPq7FISsPKKAq6AaPNvGWUHn5pOO4DlJDSGAAdrpmd6SQWToe+NrKhAnBfzL
         5U0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4JDBanP4E/IzOCJN4b4z7gFXNCwEQBfAlTOSm+L/8TckWjLUiSwXKnsWQSRcnhztfpA7GPtd3AZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo8nzXn4S4M3Ixo1AN0zeT5GtCW0eCH/kMT5EAIolwsoXf1isZ
	txrniMtUj3hjhfNAEUxy5BPP4ObbZkaX63fzBnoix18OaD41bPtgvoyWjkCiQRMM6U4=
X-Gm-Gg: ASbGncvabh4tb5d+ZyDMTOeo9vkDbjGje75huiW281Ot1zPx0cUTVK7D2KfNHquyP6L
	SiySazTfS9yYey3SrtntYTaI1JlLQYF1wSDx1HlXfvsl+5cY77ZFdzO+ntyoa7epheRm7UQYDTe
	nLumBMkyNfY0z5J7DH6WbJd3TM7ow0fdNVMHBJNEYKL4T5nz9KUAX8iJweBcsP/Y/zgAT/kMIOk
	XzV6plZsSYcIvI8reMwN3Dtgz5pND/WtncvHcFthnjndjSf1/RQZqLpKG1xx2siWlvEm20D4SE+
	rfaFWf5f2Otv14Pv4LdJ9Ylm+QpD3U3mT5u0oVYR2jJVPP9JT7L8yXLC+XTs2OKGBQxFw8WgmUn
	e8ePEWdVP2Jat5tchroI5IFDaIw==
X-Google-Smtp-Source: AGHT+IEHqt2TXipMpOtCWZM03ipD2V1JcC4i1LJeU/pC1caBAXKNxDTmzAlqmEjoL3VZqIFse+G3uA==
X-Received: by 2002:a54:4116:0:b0:3f6:6d8f:1365 with SMTP id 5614622812f47-4067073568fmr1203951b6e.3.1748532802067;
        Thu, 29 May 2025 08:33:22 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:928b:5d5c:6cd9:1a4? ([2600:8803:e7e4:1d00:928b:5d5c:6cd9:1a4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-735af9bc74csm277033a34.52.2025.05.29.08.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 08:33:21 -0700 (PDT)
Message-ID: <b45ea46b-3e17-4cb9-8e69-9eea0a3f8241@baylibre.com>
Date: Thu, 29 May 2025 10:33:20 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] counter: microchip-tcb-capture: Add DMA support for
 TC_RAB register reads
To: Dharma Balasubiramani <dharma.b@microchip.com>,
 Kamel Bouhara <kamel.bouhara@bootlin.com>,
 William Breathitt Gray <wbg@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250528-mchp-tcb-dma-v1-0-083a41fb7b51@microchip.com>
 <20250528-mchp-tcb-dma-v1-2-083a41fb7b51@microchip.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250528-mchp-tcb-dma-v1-2-083a41fb7b51@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/28/25 1:13 AM, Dharma Balasubiramani wrote:
> Add optional DMA-based data transfer support to read the TC_RAB register,
> which provides the next unread captured value from either RA or RB. This
> improves performance and offloads CPU when mchp,use-dma-cap is enabled in
> the device tree.

It looks like this is using DMA to read a single register in the implementation
of a sysfs read. Do you have measurements to show the performance difference?
I find it hard to believe that this would actually make a significant difference
compared to the overhead of the read syscall to read the sysfs attribute.


