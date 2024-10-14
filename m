Return-Path: <linux-iio+bounces-10592-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED0999D9A8
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 00:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63111282BB1
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 22:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07FE156230;
	Mon, 14 Oct 2024 22:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lT+tEeVN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832C21D1E79
	for <linux-iio@vger.kernel.org>; Mon, 14 Oct 2024 22:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728943731; cv=none; b=jmNM8Md8vdF1M2u/24TeecyfKLFeh9FhjEB9T/wBT9Awack0cQRt9FThw0UP3YBP/CyWxr+lBcmdqLQNiE/Rs+9VCjbys1dUrKbB5OdorB0/BhpSxKGNMiQDeR2oolcY5X7JCFMbx/J7K4NmkpfyMVFLStz/GODX9k+CdIzGuIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728943731; c=relaxed/simple;
	bh=RwiWGV2rzLk4cT6vGo2hf7iXveFtHH9FPuvO1qveBSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a95UZmad7tIC9TBhLHM5/M6ocz4U7Huhix5IQbeG9/olU/8L8DH3/n6cQKm/EG+r/JZtz+E48m9+i3O34SnTqFOUvptfbVu2r+sndlvuALgZJTAZ09sEL5HzF+kT2daCJ2ZOgf/zWAASmQsqo3HdeLTpQ/DyWEOEFPwq6Zty/kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lT+tEeVN; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-715884fcf32so1830761a34.0
        for <linux-iio@vger.kernel.org>; Mon, 14 Oct 2024 15:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728943728; x=1729548528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CE71Pg+9qQgmK3mJbmPthhcZO1J5ofFDM3FllRmUogo=;
        b=lT+tEeVN0xGWgs+x4V9vNAiPWxKgu1AV3NjGgTIrMBGIXOf9+MhPnUKn1w9Q5QnPgU
         LQ/Z6dcbU1eYPKyXskY/O37o6ts3TRvVT9MXhf0TNXCvaPhA+jnUe/ta2i47mxVN+F/o
         wdSRHBLIYBx6837VAgQkbrwhCgl+J+0ASnprk/URj03MpbYCpRxwS+KNw+OH3sP4bi2N
         9plioMKvVNGuPbEh9ovOa0OoNUFPMrrulp0lVt7kuUPg3/TrCBKXT49FGLTyOlnVxxNL
         p3+AH3FV+Otvi/Hqhn1bVRKSIID056yOlCNUasyj+lmK/aR/pCcjKRB/m2Kc9e805QDp
         +3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728943728; x=1729548528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CE71Pg+9qQgmK3mJbmPthhcZO1J5ofFDM3FllRmUogo=;
        b=Ync3XWe8PG67k0GP2ayPDpbJpD6ZNvVVpQj9Zmj8sEKOQcI0tU9dzIaL+7PHWhpNS6
         YP4AY8fFAW2ARYPcyPUVyk/VgPXM+RwIaXA4ywYQjGOVKZqGGOXEBMXKI2Vt88+QR0bs
         +YJeUP26IQ9YwPuCC1jYlQ8Z3txJoH3MZyw51zsNgdNZxMdwWcnrrrDPXE0Dt5sFKeN0
         u4Up+cOVu3Ky1T7VSIoz64NfyoMgQ6711cxttE9LVex7ScwposS8ZM0ScElEJ6DSm7z+
         tbjjn8WGzV98oukyXNXTuJ8wG7AO8CobXKc55DGmwg4i1hsVu3F7YPTKMtdlTTiAXJuJ
         jJ3w==
X-Forwarded-Encrypted: i=1; AJvYcCUZXD8k+ALUYG+Br+xj/w0rZp+P6hIf4FswUXOR6I/MnYLlvdRMm8P0VoZpkoFT+mpz0XXEpM7faEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr28fnouVKP0j1onBvfyg5YAA43Ze37VfrLZM8tMWvVytQBGkT
	PLYyAcp5f1YYULKeLWYfSDPjyWfbqy49oZ8pMthlqsOzggr5laEzAz/8iEJGj4o=
X-Google-Smtp-Source: AGHT+IHJnl83Mw1D/U95VcdXHn7KiobS+KbDMYq68e+4vVzo3kcSL5k6sBEGoQjwDIdvMPPL4KFOQw==
X-Received: by 2002:a05:6830:65c4:b0:703:6434:aba8 with SMTP id 46e09a7af769-717df1e1178mr7335220a34.0.1728943728669;
        Mon, 14 Oct 2024 15:08:48 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-717fb9f022asm13921a34.27.2024.10.14.15.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 15:08:48 -0700 (PDT)
Message-ID: <c70139f8-c0ba-4e28-9477-964db3fbfbba@baylibre.com>
Date: Mon, 14 Oct 2024 17:08:47 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] iio: adc: ad4851: add ad485x driver
To: Andy Shevchenko <andy@kernel.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>,
 Marius Cristea <marius.cristea@microchip.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20241014094154.9439-1-antoniu.miclaus@analog.com>
 <20241014094154.9439-6-antoniu.miclaus@analog.com>
 <Zw0ZM0vQXJep3dFJ@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <Zw0ZM0vQXJep3dFJ@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/24 8:14 AM, Andy Shevchenko wrote:
> On Mon, Oct 14, 2024 at 12:40:40PM +0300, Antoniu Miclaus wrote:
>> Add support for the AD485X a fully buffered, 8-channel simultaneous
>> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
>> differential, wide common-mode range inputs.
> 

...

>> +	return regmap_update_bits(st->regmap, AD4851_REG_PACKET,
>> +				  AD4851_PACKET_FORMAT_MASK, (osr == 1) ? 0 : 1);
> 
> I would do it with a conditional
> 
> 	if (osr ...)
> 		return regmap_update_bits(st->regmap, AD4851_REG_PACKET,
> 					  AD4851_PACKET_FORMAT_MASK, 0);
> 
> 	return regmap_update_bits(st->regmap, AD4851_REG_PACKET,
> 				  AD4851_PACKET_FORMAT_MASK, 1);
> 
If we do this, regmap_set_bits() and regmap_clear_bits() would
be even better.



