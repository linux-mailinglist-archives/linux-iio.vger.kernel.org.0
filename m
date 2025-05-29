Return-Path: <linux-iio+bounces-20008-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3858DAC8042
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 17:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98323A6A59
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 15:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EEC22CBEC;
	Thu, 29 May 2025 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jRXGYYtk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FE422B8A2
	for <linux-iio@vger.kernel.org>; Thu, 29 May 2025 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748532410; cv=none; b=VAkmwHsYwa1z8tlCjAdTO+4i5Q/MVwZM5AjQr0x/Y8vrlzDmQ2XueP6FgwxGKA+qNc5aKeqK7qCWwNWAAOGm9Dx82x5KZLTOnMM2J3IMxRE4nvXH5L/Cy/78PHHE4iax6zl90oR0V1jypVQWyGwj0KAnN54t7mL0r9V3jll9zBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748532410; c=relaxed/simple;
	bh=XEg1T5QfcPcZ/HVp8dE3KjQ2QZb3eLEg8fe6ilAvAvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FTJykGM+akvZTGjy8H+8lJhY+fQ4ooarQfO2gNIGrKYCYvVwB2oeUAnJivL6/w2VO83zbc4JNS13M+uXYyQS8zGkrGWtfTB7lmHOu2Qs7bdldrnJ41orcyDfdrDDJxbznqR9G05Wa+YTmMfrbz7MPJzi28FChZQxHnlhyjK3Rtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jRXGYYtk; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-606477d77easo633125eaf.1
        for <linux-iio@vger.kernel.org>; Thu, 29 May 2025 08:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748532407; x=1749137207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VwNV9XkLQhzGy3LnwouyowzyNAVfOZn4v9Uo2M+zdnA=;
        b=jRXGYYtk94DlPui8hRvVIkt2HwcEeSKt+e3k4iwPxhcrSFCbHYEykYrUUB3YH5vIdU
         kAzEJM8C/gr55LoYl55VH6hfwN6hds1/fzfdPf/4roec+yIrBGRnAaICJ+I5jq/VDZM4
         bitwNW8svI+CTkqjTNzXetiKdC/gDtZh4eExIjCwzZrbZ5CRVKltu51VIEQVNi3gfKCc
         3KrBjJDKLCJnpSYSoj8zUzTEibPi0r9a/1gS5pgNAhm0IQBlOk1M5kvt1naFrUC1+SMq
         weXEeaE/bCVNctfQOKfWw//w+0/NeerSLh36Uq78Jg7M8kFdxvyh0s/eIplVs0Qj2Y9N
         4jbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748532407; x=1749137207;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwNV9XkLQhzGy3LnwouyowzyNAVfOZn4v9Uo2M+zdnA=;
        b=tfTMy5cXu29T6/W1V/+er3W/35wl68dwLZEAymixRbOYA5cvdICBryKPmiopWIjQRU
         QGECP1pW/69HFXhceJjui28ZQeIwnhYh+k6KA7Fagli4dSJOWY9pczTQzfGa1gYT4yoF
         TYZiEnc/6V4YLTezTS1s+Upp8ziB9DzhQfk7iak06xlDcpI8qgnQ6pCbAg1tMKDj8sn2
         Uv58kuPMcEiDFyhLv/tC0PUHIvJRsis9OQTkZUfnJgkjqDaMZV0xa2NHoGuKwHvwR11c
         NIgU2CtjAx/DP/5V3olqJnlUlChbkfbp3dLIAzQIqLTjehDmFzeUzCypfTY4G8wvQdoK
         MKFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvNSnV1tRWAwVTHE6+XuT7jHiKVUp8Ac41ddJZSQ8UgzSu8p4oUKSh6a9LuNjMWKTqgFYOxe0t4Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu9fPFX2ttVLNcvVtnfyb7yC5qIngWtMH0V1SjGtKqBIRp/ahD
	Yi+0ijOBmHapNqS4gGa4WXi8HlSmuWS5dmJVDGmPfbpnE0JUXLPukPmI3W9ugzXbkqM=
X-Gm-Gg: ASbGncu8KC25M3nYPYqeAxUk0R+9wms0e58WZX0h/o67TfF3FjgaQLMjpnkmu2588y8
	7LHmpTQ3ScLgC2Hoq8+CeZvIwJQ2H7uDOoZOXh17odpRtMmmd9YFsYIcHdIGuDhsB/6l6tEcRnF
	qup8iA/QinNAcBtvGCdPyz10BMEh++73+8tZCjcI/yu59EbtXLxAmfxuf83i1c1BzhZCl8rkGoc
	w9LyTBOZIEPQSjmAflqt/T5QUvggl25d9z6C5pSgT7mUEtPBizn7KcStnzs+qjnIKk1hXq48xe6
	gcgv1LmA3ZfbADa+vjnJytqT2Stc/AZDfHvOi+HaUTOVy8NV6Pz9IGCBtVhuWbmfo0YNSW/TfNi
	vg9+lWWmg8Rd3ziv36btllM7xvg==
X-Google-Smtp-Source: AGHT+IGPjvnGC1YvRZH9st24obs6F5iZRk8vdE60S7IXw1MFMfmFFESs0FdIBrXXqrBC8I/S4dstZQ==
X-Received: by 2002:a05:6820:d11:b0:60b:cd42:7a0c with SMTP id 006d021491bc7-60be4de19eamr1424084eaf.3.1748532407038;
        Thu, 29 May 2025 08:26:47 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:928b:5d5c:6cd9:1a4? ([2600:8803:e7e4:1d00:928b:5d5c:6cd9:1a4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-60c14c42c16sm30504eaf.7.2025.05.29.08.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 08:26:45 -0700 (PDT)
Message-ID: <b9b9aea9-e02d-4d5f-9f07-ef1c54e46b89@baylibre.com>
Date: Thu, 29 May 2025 10:26:44 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] TCB: Add DMA support to read the capture register AB
To: Dharma Balasubiramani <dharma.b@microchip.com>,
 Kamel Bouhara <kamel.bouhara@bootlin.com>,
 William Breathitt Gray <wbg@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250528-mchp-tcb-dma-v1-0-083a41fb7b51@microchip.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250528-mchp-tcb-dma-v1-0-083a41fb7b51@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Please include the counter: prefix in the subject of the cover letter
as well. It makes it easier to see at a glance what this series might
be about.

On 5/28/25 1:13 AM, Dharma Balasubiramani wrote:
> This patch series adds support to enable the DMA support for TCB.
> 
> When DMA is used, the Register AB (TC_RAB) address must be configured as
> source address of the transfer. TC_RAB provides the next unread value from
> TC_RA and TC_RB. It may be read by the DMA after a request has been
> triggered upon loading TC_RA or TC_RB.

Can you please explain what problem this series is solving and why we
need this change?


