Return-Path: <linux-iio+bounces-19690-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F6DABC1FE
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 17:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CEAF4A2985
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 15:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA990284B42;
	Mon, 19 May 2025 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3N74rHI9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319DE284691
	for <linux-iio@vger.kernel.org>; Mon, 19 May 2025 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747667729; cv=none; b=p+fD3+sBG1fmk4KdOEXXfQ2DDu31GyAFimfFGRu8T5mxn8Po3fP8lu1W8vVPVQbXhY799vfczNGYtgrw6k7q/HOgzjLyE53o+Tzx34tVyKRDKoxLkntrFLaujs5YJwKwLHZypqM7Wgpgb2okGnPO12jdjqksycy1uPDMSgYzyhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747667729; c=relaxed/simple;
	bh=eqHHv6cti0ZoDTZXOD4YVGuzTI266dWkCvmxsUpKywE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F8S4doivXw3N9qzVaTtgP47EUrptkEd6OsfiNRKW9ja4x43ptYScA+YOXWp0K29FO9ygOUPmgCL47WRqKPJNDZZEWRxS6f0cx6kJh04By2Zry/sCDMqfHHfBetu4RTKaTGarqO4IevIfRXa6xNHRMPL35Ju7YXOgs4rRtnIFZ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3N74rHI9; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2d9b61e02d1so1083637fac.2
        for <linux-iio@vger.kernel.org>; Mon, 19 May 2025 08:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747667725; x=1748272525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EUxqgOyDxcOI5g2n2V0wPOdVEtNRAkky1kpuk2R3KsM=;
        b=3N74rHI9bZMFUmqk4wPg6D8KNYPsIXweGbinoJ1wCl/eJ5xK6Cax8Bx5luhpMXk8Rs
         iWtp6wNU6o0GdE3EOf8sh4JgZmfSgBJmzv9mf6ZzzZFYCUhHkt9aqNU19sdSJwM4SUKJ
         0iRw0r2LieM4WnItX1C4Wq3ZDqwEiESAY3r3orql+lcSB8SjXQl4firweNIlT0SVgppw
         D165QlxZpsBosommKPWZwKAKz/wzP5UsCuY30d5wLlC1cbdp3fj1/JxdsSPEWrekbVnK
         96lRaIm86TLvQBGv8nH4PEH3Il7PhC07F+ey1+wkSkLsz6Ag38OiMmh3RuXxcx4mEI5s
         uHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747667725; x=1748272525;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EUxqgOyDxcOI5g2n2V0wPOdVEtNRAkky1kpuk2R3KsM=;
        b=UVwgAN7xaYxdqLDzz+lXLePpSk9iOKijGi6NmsHm4nTX3zjH/Y4Nt9cJPQmIHvj+P1
         Ckimg/HJM4PA8uOUZgTBuzxM1puMOnZS7xCsEQnroPDTCD1dZAURXI73/bBTh+87VXnT
         387DHihxGaxGIWVIgbGHW9fIfH0LX5kJ1jI5AfSiVLeVu1Uykq+/r1CsccZGHUpkgVZ+
         SVRe+NqokJAIxIV0eh46n/daca2sVZilFfZAUpioQo3HBWrcstDlwzLci2wyyBdRb3+n
         CAjY4MJogw06J777mkilMG9s4IwtURCe87JFhD5lWlYq6ZzfDwabyPnbuSnWQsNTflaD
         3hLA==
X-Forwarded-Encrypted: i=1; AJvYcCUNi5OMYtFrfhUwV3hicsQeYrz9F/cv2rnt4115PvepGYWiryKr5FfJ79gVVQTCdhzF3SFAkgXblRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/oVw3J6egyuReStuRnJrCAdwUG5pq+s9nAPH6PJbQeNc6iR+m
	YkqjZ7icma4HL/6VESZQPYpeNUMCKJ3/gl2fQjVXR5WtVHLwqpkoC9YhCElEPtCS9SI=
X-Gm-Gg: ASbGnctTtoTMWectDcrEep1U3A4+lz1GTKv4WstBK5bnbHjchyGsF3yMdbRMmuFfou/
	2vzDt7qStqh28g4qBnRXLZjq4N4bJjokHNfNpbQpQAORwsGo4ncvx0dWXFb+2cCZDSgFQFcQGzG
	aCW+5ocD7ZvT0H1K9EcJzRGk5D3rfs83O1uznVGjSDbE4ZifucyANrBUaraZth0dB4CU9RGyLpF
	fC0JRhHUVBza0RC/1fUztH4I0TdDt0mQk+rEupzJzK5x0oB9C8lzsGSDj0U26YM7QLUaeCJ0mHL
	2YxHJRuRB2vppSw3kz5mdhulXyxvnyE9eqJZA/Bal3loW/Z+XldOr4urQDmm1LbG2gGv9sVmMAc
	RTU7roJEEUBVNqy6KIeGquZw87A==
X-Google-Smtp-Source: AGHT+IE1LENky16XA/1nxfLz2cNQEDM+x/IwIthIkWz/+026QRc8Sk+1CMJx3x06Nx78du+/5N0GsA==
X-Received: by 2002:a05:6871:2208:b0:2d9:3868:b324 with SMTP id 586e51a60fabf-2e3c8384405mr7303802fac.23.1747667723862;
        Mon, 19 May 2025 08:15:23 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a628:91ca:eb5:d6f5? ([2600:8803:e7e4:1d00:a628:91ca:eb5:d6f5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2e3c060e33esm1788670fac.8.2025.05.19.08.15.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 08:15:23 -0700 (PDT)
Message-ID: <9cf04a91-7763-41d1-b406-014b1b5f0535@baylibre.com>
Date: Mon, 19 May 2025 10:15:20 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] iio: adc: ad4851: ad4851_set_oversampling_ratio
 parameters update
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
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250519140220.81489-1-pop.ioan-daniel@analog.com>
 <20250519140220.81489-2-pop.ioan-daniel@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250519140220.81489-2-pop.ioan-daniel@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/19/25 9:02 AM, Pop Ioan Daniel wrote:
> Remove chan parameter from ad4851_set_oversampling_ratio parameters
> list.

Commit messages should explain _why_ we should make this change.
In this case, because the parameter is unused.

> 
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


