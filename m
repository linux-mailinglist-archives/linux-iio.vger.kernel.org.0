Return-Path: <linux-iio+bounces-13107-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A10C59E4B5E
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 01:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623F9282CC6
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 00:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CAB23918B;
	Thu,  5 Dec 2024 00:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CgL5lU4P"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8AF10A1E
	for <linux-iio@vger.kernel.org>; Thu,  5 Dec 2024 00:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359481; cv=none; b=WLKk2RMfl8gqGw/yHSje8Qz9PquMTGYgCbEU0ncfpuMeHhwicMglitREuu14yE3eyL++wzUQvNzENzLxN5bCquqjxqrzNO3BQpp6Irua+pvzJ8zbyxdrFvRObL6f6e7QxxSRWk/kZ9GlHrPFEo5oVuvoYssniWBN/8yUuMLHLFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359481; c=relaxed/simple;
	bh=RfWODQeCQ92PKzUdEskZeQY10PlkpbDGFWN1YWWpNow=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZLDpQaD98Ze6wiYetzLyNuuDvwDwoAiymBHllzQUwJP3MV2L0+7/iQZknzfOblHydwzQl5k867tVIHo+P/j2N/MyJDVnaNW4FhxRmZ/5YfwuGQiBid/qLOfE9TI3/hKurkQXN+7J2UThHQzoN2NIAw7ODO5NdZhabKHw6myy3pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CgL5lU4P; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71d502644e2so133551a34.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Dec 2024 16:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733359478; x=1733964278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rZU+yuC4IUNNrcZsdQdOWRd6MVYrt80tZt42Hj7Odpo=;
        b=CgL5lU4PiFH3Zh26mHpXbCWV5ZZSDsnjORx5YEo+8k2N6k9OsjCNHSvqy1c1oONKNc
         jKW7Gur/n4/TqbytgUX7dJ5PTLUtIzI0GLYJWJkpTevZsz9X+01/+yeZesMkmiyf+Uph
         JXWXpQMzOabtoRCIQabrIXeT8DGG6uTJGZpLuwkFlCPzWiZb1yozEtAGg67efINQ/cUT
         fgIokJKF9jK8SZVDw/gIffl+0TaySIYZiGHQ3gZzAhGrNOAqd5WzwdrdcY5/Gk1vlFDP
         e+4SbMkopRQxKVNEdkfDjoWktt/hKfzNYW5LwGKnhcfG4HW0I2EU/mEXEQ+lFX9mLpMV
         zriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733359478; x=1733964278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZU+yuC4IUNNrcZsdQdOWRd6MVYrt80tZt42Hj7Odpo=;
        b=fxaeYSlsG90mY1GcJgrEenAhz97vMASwFvey7HfuWqRgUV6TFujaZ8Ts6pd0uM6NHS
         haeejlVy5wsl6PdDNKyTK6iW9779pzsTEeSzzLcK1pliLWFX8eqQRZELaGqxYhNiwr6U
         BhtZLY/XWvI/TXFfct/hLdVSmoWK4hX/eI9q2UIY80KY7U6OioMY2fOstEPYzWMO5rN0
         Hi0sVyvm81wPC6huvbPYTdhes+BNcU0p8VKVryjF2zvfPJu0Yw9LobCCWz2U/Ha/CIIV
         OTySJnWtW0OYtGfaXPq7krlxA8g0cBRIwJD7AE8Nz9742hb1e3gjxYeBgqjcgUY7L6no
         cvaQ==
X-Forwarded-Encrypted: i=1; AJvYcCURCyBjKrz+ttHdQcF4RUrS77/tiW/g2mbR+Zkp2PjMNhISZP4tAKtyptHsX2z0rPF3T1crAov6u+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUetfSd2DD7jz/nErvy1BMacXOeASPYhOo/cl9Ctpldq9ZR6q9
	BwJDOs6PtZ2o5OpuyKZs5g7x9+/3GE59mqH79l1Y2vsLItE5t7pBCl9VRFHFNYg=
X-Gm-Gg: ASbGncvzeZvsKYTwzJCEj05mn43MfIpGMpCJZgq9HixVP3ilJYhC2uAE1iI7AWiX5ok
	mP/xPE+1kIpAp2jLXsW2BrnS52n4LQZbLnY0EGj8Tw9eDFLl/rigtgf0yxfbWclqIHKGC6xCSNr
	AjuYU+1sQSUxL9inDq+Cx/YnzzqwXjKgWWKfKuNEfu0GFfaLAUKgfT93/x2/Zh6D/f7+jUYkJxp
	FwB5K7IhkDHfxrMgYbglzUKAN8fetr5ZXbkiHQJKIxDpwqk8affzJq6A/jnjFeU4+5oXoL5dnrN
	7ZvcKz5NALo=
X-Google-Smtp-Source: AGHT+IHaFElNJBo9YhzTZTzxYaqVWuPDKa7rUFNx4+15yLQ0Bvjs2W04jhZERCIQ6ow85bmA48lGYg==
X-Received: by 2002:a05:6830:6516:b0:718:16c8:3c02 with SMTP id 46e09a7af769-71dad6f0756mr5814100a34.29.1733359478045;
        Wed, 04 Dec 2024 16:44:38 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29f56945d20sm104623fac.35.2024.12.04.16.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 16:44:36 -0800 (PST)
Message-ID: <4795d5b2-2d6d-4d81-a57b-dc28d217aacf@baylibre.com>
Date: Wed, 4 Dec 2024 18:44:34 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/8] iio: backend: add API for oversampling
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20241129153546.63584-1-antoniu.miclaus@analog.com>
 <20241129153546.63584-4-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241129153546.63584-4-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/24 9:35 AM, Antoniu Miclaus wrote:
> Add backend support for enabling/disabling oversampling.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v7:
>  - implement 2 callbacks
> 	iio_backend_oversampling_enable()
> 	iio_backend_oversampling_disable()

I think Jonathan's suggestion from a previous review to pass the
oversampling ratio instead of enable/disable seems like a good idea
for making this more generic.

int iio_backend_set_oversampling_ratio(struct iio_backend *back, u32 ratio);

To answer Jonathan's question [1] about why does the backend need to
know if oversampling is enabled or not... In this case, it looks
like it changes some timing (the conversion quiet time) on the LVDS/CMOS
serial data lines depending on if oversampling is enabled or not.

[1]: https://lore.kernel.org/linux-iio/20241123160559.56c57fc7@jic23-huawei/


