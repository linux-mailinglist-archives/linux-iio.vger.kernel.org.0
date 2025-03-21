Return-Path: <linux-iio+bounces-17169-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C5AA6BAA5
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 13:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02BA0189905C
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 12:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CD122579E;
	Fri, 21 Mar 2025 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXbnxGzp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6F32253FE;
	Fri, 21 Mar 2025 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742560031; cv=none; b=UKeVevwAIph/72b2wQtzaQmdcqqWqRh/JsYaP3Pu6K1NopQPtwE6N9s1KttE7V1tOJcA7lkHX/3v5WQV3906fp4ISRCeRW+Gp0VR1gqGNEmgFTkv4ejsn3z9Ik8pHOj3aaFRub/c9KM1RRWiMJ2oyx60C/wxjs8x909dNwsIjAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742560031; c=relaxed/simple;
	bh=w8VYrX5+bW5UcgXYA9Urb+GSK2WlWR7keMIXkmj68l0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTindnGwr7s/LzFrcDwmcKhVx38B10n7W85+H5kSTT3ncCWN2U9sW3I8tgqxPe1nVUaU/9xjoqCEepD8FkBc0gDgp5H07kIMkLL9lUnF6rV0Y2/mvSyWfwpVAgUXZ6yOO2/ivdEK8JIOvgQMI6ER2l55jlQxogV/tBTGkEKyAUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXbnxGzp; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-543d8badc30so2180228e87.0;
        Fri, 21 Mar 2025 05:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742560028; x=1743164828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K1TEmYZt94hfT9Oyrc1X5ge3lXbzJL8n7mBbAQkbguA=;
        b=OXbnxGzpGX5gSrqPtl4aS4Y0v13jNzy6LN/c23fV+lphX0eQeFIpvNFCXADSGPaWza
         8cNpuhaZU3mu0cknMlS3TwH/IDxlzpgVaO9pKWk0NFy8UF8b9OL/i6sXwO/MvFyTUVo2
         Zn8WNbseZMZpdv1gNLB4e/aIeFKr1+rSWLYA8eMQIDjobJfyU8cnuw6tURYvfoMUNxbk
         mNPQQUJE/lLJ4BwCKAp8u/UUnbI1NIA4bpLqm+Agw/Lswpf4cXRxxZCJO068HQGr4Wzf
         7J0/uRP1k88Q1mwJOfd2syWqgRuk79GS85EQZ5PucDzAvATSSJiYX0SLa9aRioz6zolT
         7f4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742560028; x=1743164828;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1TEmYZt94hfT9Oyrc1X5ge3lXbzJL8n7mBbAQkbguA=;
        b=t5yyUM3aEV0Xh5XxUhEgtNu4gTGV0MTecCC1TqB3VpSn4io+2MAIGqUz+x79m2lSIC
         XDCBDlulyR1QKwAdGQna/Ulwe0TwXMGlIf4tCc3G6tSkegPZoBAzwnF9r81exAsF+ztN
         zPwfDlQiMD77geffeIJ/pwIAGFdsVKZ3qok/qJo3YDFv8KZTvzg7oD5SlPGtoeAF6SVw
         /D26qFVGPv0gJN6ViYW2lukqpxAsK+G2wz80VwOQGkDzzM+DSxbGmYMXv0aQzQ7T0sRa
         DNZwbwHr8XIHQ39ZrzSCDKyZbyCUey0/uLDHiP7bKF8xAtdnGXNHgMNdZTodUSkP5L+A
         qn4w==
X-Forwarded-Encrypted: i=1; AJvYcCUfLUkxk8eBCMIhHpcDk2Yi9mI6UDp5dPV5FKSKe2z3uqPai3eUNLuXTzwMiGbUsJH8l3ZurekavQsK+ViU@vger.kernel.org, AJvYcCVm/J+aA/R3r2MVVwX++X2cHU56TYcjxmaXSUxsu5r/oaHVVtH3lKvv+kIBD5cPNFq3Vx9SjRI7qedJsd+GlqtY1eo=@vger.kernel.org, AJvYcCVwuXMH66GsnL1Lfuyj6vnoY7v31eIhM6gz/n+V5ztNlhXcHd68iHvJESgJATtxsKvkPViLlX4wMHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw93d8j3f94sn3c3pR3yF4RTyA1VYvnR3iuLyDlwW3vXMi1nPFd
	3km6egYDHIes6pZ3u5nnqTdhvgKm8K7WIi9ItMX0xIk/pQCCO8rS
X-Gm-Gg: ASbGncuMmejQS6TUIvO3DdhQnySLEHOuNyjG44oRRmOwkJEEfD15ZmQDX5tEKmaHyyn
	ycgIpbDojQ1CmTMBLEGMmmIrFbPTwQgZiLDs/syvzsySlbeenp94EhVELaT4EXrN9eg33tD23XH
	7xJ/SMtGx7hHyIHqXTx6XpJM1/uKpAZCzneJ1cgshrdvNkgwb/7XyCKDu57TMfeis9AHGYntQ9Q
	SqHQgvuCDl1Q9Z8lu8a2TJ85vz0Ti7bfWeudVSjCohs+9oPEpqA2D5n+vBoq+RSRwm8gxQZfr+q
	hcc9eFdflGLCt5QxPIrnK6QR9Pv4LzSTfHrxmCHG5bmj43VajmqJFC7bvo03DQw/S22TNnICjjF
	eObAVm4913/I4NnHAjXCdosRoMA==
X-Google-Smtp-Source: AGHT+IH0hmj7qVUBfmZdqS91Czx0BgIpF4xU0yrexl+qcUjSBmw1w3GM09JlciPG3KRdwmkSXp6x6g==
X-Received: by 2002:a05:6512:33ce:b0:549:7354:e4d1 with SMTP id 2adb3069b0e04-54ad64f5a99mr983569e87.38.1742560027424;
        Fri, 21 Mar 2025 05:27:07 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad64fbcd0sm169784e87.153.2025.03.21.05.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 05:27:05 -0700 (PDT)
Message-ID: <5175a057-48ed-415a-9096-23879364cb5f@gmail.com>
Date: Fri, 21 Mar 2025 14:27:03 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/8] iio: adc: rzg2l_adc: Use adc-helpers
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Chen-Yu Tsai <wens@csie.org>, David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <cover.1742457420.git.mazziesaccount@gmail.com>
 <9a3a11561dbd3d5023da2da05cf2190793738242.1742457420.git.mazziesaccount@gmail.com>
 <d55ed22b-7a13-4037-9a11-1a65040f8a7c@tuxon.dev>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <d55ed22b-7a13-4037-9a11-1a65040f8a7c@tuxon.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/03/2025 15:13, Claudiu Beznea wrote:
> Tested-by: Claudiu Beznea<claudiu.beznea.uj@bp.renesas.com>
> Reviewed-by: Claudiu Beznea<claudiu.beznea.uj@bp.renesas.com>

Thanks a ton!!

:)

Yours,
	-- Matti

