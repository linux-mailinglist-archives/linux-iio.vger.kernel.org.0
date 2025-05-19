Return-Path: <linux-iio+bounces-19693-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47692ABC219
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 17:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291F31B64975
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 15:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761322868A7;
	Mon, 19 May 2025 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PZhlAbj9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E68286884
	for <linux-iio@vger.kernel.org>; Mon, 19 May 2025 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747667816; cv=none; b=gaX+yHBs8ncCPxUEe9AsXVzo2ibVeBi60IUXsA3nCBtPR5n6MXFKmin/B7QUEIdr3dffmMSfvU1yx+cWvvkz5wllpGb2ElMbWp0UctKlSGfnXyFzj7cQpPua7SA285galXoSrjMDMQXltKCHH4QnoePpqD4dIdL1kgPMPKlcGy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747667816; c=relaxed/simple;
	bh=PDzZ1P1yWg+XkiFO2hZgTshq3CQ2YwSCHmY/IiLp4cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k5waapiRs1WVKtHML+KdtLEL6LWbFQyPajH2d1tq/EKEoiNpeAuov5Zz5/1LnjMlbU6eKmZ2M1l9KODWb+2ndMnz1Y/ckPUl42QGlSNOAHppJ6RQGMcD2hTXzJjucvAvYa6ai7624d9HMoBuLEbn7ArDFeAvSISNnRYjlsbOXQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PZhlAbj9; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2d09d495c6cso810473fac.3
        for <linux-iio@vger.kernel.org>; Mon, 19 May 2025 08:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747667813; x=1748272613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ls1NLWaG7mKMxoaQ03EnBMu7MOLjXKiH9mRh6OqI8xk=;
        b=PZhlAbj9XdlQ+ZWfNtuqw2nx4/z0pi3327NzV3X7SeU4/ZcA5volZ+kj6ZY4ih3igS
         yPYgaguqZZ5q3yab6o+43O/AmKgmWc7IJRKe2vEemShmqpwxEwBqQJ2vBINeov+wQK9P
         GO+sJuDZ9XykmnNxivADUAyLK/78myRvA1/xYbYI2/sPI22su1engcEKQ/uZegf9G4YK
         hE9+mfDewgKfWSPo17vS1UYhR/wd9ihS+qMAUR5qMUK+b1+0vIVCUFXaLa7peXz4Jw36
         q2JPiVVEXwfWlil3EMnd7kg0JU5IhCVh7Ftj64g/9xVapNsdZrAoF2knlIiWkLebsP8d
         swLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747667813; x=1748272613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ls1NLWaG7mKMxoaQ03EnBMu7MOLjXKiH9mRh6OqI8xk=;
        b=dvlpQVuwF/DK2RwFWp0te+SX37jInoSKlvpewMBtGFCdgnONks2c6fMUsJ8FN7YK32
         Vjsc2Nt3Z/lBSiyUP9CGBOZG7OvkC6t+OD8NuChz4WJtgcc59AXMHb7uW3NqiV5CZr4t
         kMKAkVGOLPmYS4Khr5FzayRFLBplQ+OgKVuVvqjCKqt6gfJRagrvY3PN8QmRfOFMlaSu
         ptkMPnWV7dQETF0xoEgnB5B5MmYSah365tYsUCglh+YgprBl3j5Ucv616tCbyzlduQJn
         mA3u6y8mA4BLhaIlg7VFo0OMPwPtnJZk2ugOMHGcev2NetHJePRoyGIL9LVAQ8cZ+/fl
         ogZA==
X-Forwarded-Encrypted: i=1; AJvYcCVlZQqQLVBGuYDLIc2bmSbttMriqkhU2lraUodHENyEM5ST7m7F6uVW52wYPySRYH1e5sDBJTRx/bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNdo58WKe9HE5U2onseEznwoGacvKOGmelsUEirKTA3Feb703x
	UULf7gKeeTuvO+Y9A22sgN65XYjn2u3KV+o4Qu+XUzGIqZ53XUl/WPe/W/Rk0s9B5ik=
X-Gm-Gg: ASbGncvAbJo8Ecy8fZ5tLWQ4yEOsKgn31wyGoJSpjdSO5vNmTPMqnooyDJbOGZobWg2
	w+9Ej++m5xe+MT/ziUjuzZX7Z3TG+KYROXgexwrdKTmE6Dq9z582gr1oNUmTQugMH7d5EkFSuP1
	V/AzoynXYzQL8LJXvDzDUzEiVkpeVng2IHQZnEYhEqf6YGPTtpv3gYYG2bXPIouE1N/OvvDqM8P
	EjdpjYcaGMTMNdIpZigdGrgX/CryeG+DfwFLfn0Tkp97wJfPIz1P3W5eq6QnXcNK0o1phPIQtfT
	BW5pgyK1KL5WEQInVeEBOwrMZmPtEI2vTncK3KVbFWEnL1wOFgFlBmNqo7FkqgOWyQwX389EPel
	o2/UYiEuu4k2V6bwzATKn+ulqkfvE06wtjdqO
X-Google-Smtp-Source: AGHT+IGrr7JqsWk7yzixXETOAT3kkODRr/vioemwEunpOKJE8L7wTEMGjjVZ4Ec2n8rsdrQ80Lfp9A==
X-Received: by 2002:a05:6871:d08a:b0:2d8:957a:5176 with SMTP id 586e51a60fabf-2e3c8186ff6mr7690014fac.5.1747667812956;
        Mon, 19 May 2025 08:16:52 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a628:91ca:eb5:d6f5? ([2600:8803:e7e4:1d00:a628:91ca:eb5:d6f5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2e3c075bdfdsm1792167fac.25.2025.05.19.08.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 08:16:52 -0700 (PDT)
Message-ID: <bd9dd280-0baa-4b03-b286-f16ae848a772@baylibre.com>
Date: Mon, 19 May 2025 10:16:50 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] dt-bindings: iio: adc: add ad7405
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250519140220.81489-1-pop.ioan-daniel@analog.com>
 <20250519140220.81489-5-pop.ioan-daniel@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250519140220.81489-5-pop.ioan-daniel@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/19/25 9:02 AM, Pop Ioan Daniel wrote:
> Add devicetree bindings for ad7405/adum770x family.
> 
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---

This patch got a Reviewed-by tag in v3, so that should have been picked
up (or give an explanation why it wasn't if there was a reason for this).

Also, Jonathan had some questions about the clock that didn't get answered.

> It's definitely wired to the ADC as a clock but it's also (I think) either
> wired up to the IP we map to the backend (from software point of view)
> or generated by that.

Yes, the clock is a standalone IP block that is connected to both the backend
and the ADC. There are some diagrams in the link below.

https://analogdevicesinc.github.io/hdl/projects/ad7405_fmc/index.html

