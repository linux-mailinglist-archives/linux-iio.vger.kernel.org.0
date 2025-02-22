Return-Path: <linux-iio+bounces-15947-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 171A1A40921
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 15:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406273A37AA
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 14:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BE2165F1F;
	Sat, 22 Feb 2025 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwSFXUa/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FD9153801;
	Sat, 22 Feb 2025 14:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740234854; cv=none; b=Kb/bKGj9cK9mHGEXn1Ad0t13CbTJtyvAenAlbD6nDQArgBjf/9UM1MGfIqQGxH86keXcF+iErGgliCePQEaMJBg7rVbQe4O7ZPpnSEZHLIGDx81P0zHWh0nzWJ2f6qgXwDplDsGfKA5eYmVeVYdkPw2EYIctP6egMvOjglpCcwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740234854; c=relaxed/simple;
	bh=kWckQQyPJwAsGQ6UHNDjhJ+mCgwsxq0GmGXdSQG4qQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qPS/kOXmBCCVvT4hMPSkgOyF5Kz7lADiqFzdUvrPGlF9uvnu4pfZTXQ+slEDWaq18vzSV5WO2w8nfOlHeocCbWySxP5KeBxJwryL/Gtlxdcr8O4YSgSMHvTQF0O6wmXsBMnhJkHP7IfOCmshgNNt+rWGtGhuC5+0Z9PwZAELasQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwSFXUa/; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3092643f4aaso26755671fa.1;
        Sat, 22 Feb 2025 06:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740234851; x=1740839651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/vrdSXW1mmp3zS/IFgwJNUwNIOlU9xB5BhTKmjF/3N0=;
        b=KwSFXUa/2ly+KKxMQqZcRyaKYgOctfxOmdDR6CF8ym1N7C1lNA5HJNY0yKnyRjeMoP
         193ETvAi/TXf6heVwtYoxDbLvJ8S9vkRneugwLho//feIsa7FiHZZWGzAKOLg3Zyum0h
         HYL/tdUDhFanQttKxpVkNZdi+xPTvTDCZrml8oVEMfqb1vMpVTKP+98j8CLzvjkmsL5S
         uFUB/QXiE558j5+ZYanAQCrnvBPQwgTVZ4Ar3bUskBaS/zc6bCnlU8pKd4rO/QXZLUMJ
         KLgUgF3yZcVdmcK4QibS8JXzIeY4u07i/ByF1LiwHgw28B54qkNnO6kfx+nE7jgB+xb2
         b1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740234851; x=1740839651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vrdSXW1mmp3zS/IFgwJNUwNIOlU9xB5BhTKmjF/3N0=;
        b=KA0J42a5Dpo4b09E7Im8k81RLg/hxD7/tGd4Ja54wP308hyKm/W/A0QErvSnn5uZgX
         bPI08a7BoyeOFJSWiyzTDgf/NGVThaGkFfTaIKeaPlKePAWNtBt9mzqXUOrE9WX8aFBu
         5t5qzXtjFBYEGU7hPld+1qF1cfLvIfCL5C40VSP7JeDu/nQxf9pm9UlPlB9j6IdTx4sA
         cWDRgkkpFe2wfjMLsY2THPbiAcWIU204TCE8SnlfKvaaODDJk+f2zNNyE2qJt08p5qpA
         h1T0s4t2TsQby0UeNq5O+F8jGE9F5HAEU7eDzcXTx+7JNsvUcfujumN0tbirdXkUEPRy
         P5Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUSZd2tBhbbc7WTPuqVlxn+4Z2dT4/gI0eWZQPdT+9lCVYc7iaGziaWB0lm8ZIGSRoKXSPVqmPdsjB8@vger.kernel.org, AJvYcCV21lT1MxgOFw4V2qrA2YiPx4qoqGHVofs1+NIjTieIfLLTPVRQGLSETamRb0VIyOyFLADzAsxQ2g6YwuOxf8nDj80=@vger.kernel.org, AJvYcCVKQkjRn3E/PpagXQMAzl1DbLcgYQK8cqk2z+Pe+Oha+knqOetFWPS5qcd0JGyhZZHvpHJAM6UJCEMc@vger.kernel.org, AJvYcCWlvkUqSODt8iX+6GKLsseN/2VSQ6VSufGU3KUjWwOtw1XMXn27d2i1p/UcBBq2ZkopvNUI85SJfGB2vd5d@vger.kernel.org
X-Gm-Message-State: AOJu0YyIInlYvceH4FfjxHYiljHo8mtSLFcBD9DURMvfspuveI1fEpJP
	6x50kLSuwQXMOUPA8sUTHClI5JGXTIvjYWsEuapUYQLFVJqC+5/3
X-Gm-Gg: ASbGncvmkLPWsrEcXd5JuB2BDG1R3sF57BydEuodZtbzqAGyaPX8zwu67OhoimN7x8X
	w0aHLMIuyapJKm1JvyfOKSBRNYThQwixXKmypM0viijV11WYWq8PCrnld0GH9Mf2O8SsAzZc/wc
	3GBZxTEJRnprZmGN7SLtNlwX7xavVlAEnz7+qfZ6eZLIIYFYLdZmPQ4ikBX/ofgO9j9XHRNJ6KL
	D1+jbeLcnm7Mu/oeX4hIDJfcarlmMm9eJ/VAWHjW10vK1FjAWC0ZL9/Ys3ftwFz1Tdp8XcIJKbJ
	q+ixFxtXI8RTtF200eZNEy2gilv8IVDc0KWAS6uOuWrdAd8GTo49QWUP+SgZM33HxaVx88Ztz8B
	7QvZwih4=
X-Google-Smtp-Source: AGHT+IF11dH2rQC2NJCETGFCFh/ZYMG0LizvaxBdfngaTtH1JMigzvLXrgg3UsQOEuocptmLKqGKmQ==
X-Received: by 2002:a2e:994c:0:b0:308:f53a:ed31 with SMTP id 38308e7fff4ca-30a5985a1b0mr25889691fa.3.1740234850519;
        Sat, 22 Feb 2025 06:34:10 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309231bb973sm27149761fa.82.2025.02.22.06.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2025 06:34:08 -0800 (PST)
Message-ID: <ecfa1b0b-8224-4ae9-ba72-141dfbc12431@gmail.com>
Date: Sat, 22 Feb 2025 16:34:06 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] iio: adc: add helpers for parsing ADC nodes
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
References: <cover.1739967040.git.mazziesaccount@gmail.com>
 <6c5b678526e227488592d004c315a967b9809701.1739967040.git.mazziesaccount@gmail.com>
 <Z7ZB7RQhyI5Dohrq@smile.fi.intel.com>
 <b1c1ed68-2f4d-447c-9957-5a1bbc63ef6e@gmail.com>
 <Z7ci7tUlRQqZEZSN@smile.fi.intel.com>
 <ec76334b-bb13-4076-811d-9174170dd677@gmail.com>
 <Z7c2cBQpjoc9-Vyu@smile.fi.intel.com>
 <9018e23c-da28-41b0-b774-1598b946a2a1@gmail.com>
 <Z7dCnRzuQTaJXzmb@smile.fi.intel.com>
 <cb27d8b1-c978-4443-9ad2-96e930701976@gmail.com>
 <Z7isoU9hKXlgsu33@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z7isoU9hKXlgsu33@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/02/2025 18:41, Andy Shevchenko wrote:
> 
> Sure, but it's not only about these helpers, it's about the style in general.
> Spreading unneeded characters in the code seems to me as an attempt to put
> _your_ rules over the subsytem's ones. Whatever, let's Jonathan to judge, we
> will never agree on a keep growing list of things anyway...
> 

Hey, let's look at the bright side - there has been also a number of 
things we have agreed :) Besides, even if I don't agree with every thing 
you bring-up, I do still appreciate your reviews! I do think many of 
your comments have indeed improved the code. We may never agree on every 
point, but I am positive we can _understand_ each others stance. I do 
appreciate hearing your view on things.

Yours,
	-- Matti.

