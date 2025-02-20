Return-Path: <linux-iio+bounces-15899-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF82A3E688
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 22:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87268421801
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 21:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0F4264618;
	Thu, 20 Feb 2025 21:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="njYD2RKo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AE71E9B07
	for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2025 21:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086896; cv=none; b=c3Qu4nhkAKjEtuWIrzmOMDdG1hm20df0OeKlVcQlb16rjlwpunJlwUi7+ovQvNCGPOmn5zo8agKnZVke//SR9UGm/pgP/EhqytsUijY0aADxTPUASzAiTeLA22iy45siZqYk+2vy6vJd9/GuqWKUeJwXJ8Hb1ZUc4cP5x80CJq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086896; c=relaxed/simple;
	bh=69TZTw72i0WbMFKkXJ+zviVWNEe2WbKT6MwDrizfopk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7O0x4mXG9ZOgq2z+wxqlub99mf9MIvVYmQPqJjFr31LmoyYF8wfUB3eVdkppH2bkeLbKk8gbWsR2FX7R1Oxlpijy08BKEVHLIMxfOULUSyh+83a5eT/bPMJRyVZGatRtlX5mdZU8dk13mJDW5I2xzBEh2Yzkoha6r0+pqw0GHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=njYD2RKo; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-724d1724657so1286823a34.0
        for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2025 13:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740086892; x=1740691692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8teI2aiwjM2Kr13WVKdYP+m3dqKKJCEMI2qtWnMC/Ws=;
        b=njYD2RKoZMEqZSxfNlR9wePX+bJH9hRXaL+IhXX7dTVB21WY55+a4gLTgb9azPIzJL
         clyCQVgyHULHkwZ6TlgKnaRqVVyeHcA2ek85+zi8+MDVqgbHIH0ZzQXSgiwLzvIodwH5
         S6Mg49dFtcwSMOxU6L8UDCbIT71guJmbIRkKyF1sANcHIdcX2hKfAaokD0UmxrPDSItM
         CpEqbTuy5fNySoYvbppWNGiFz6HpBd9TRfhjB7oRgTmNsAn/4B0QZPUaIl7EDZoNXUqa
         1J/Um7t+dQwWVZTUJ9+8JicFud1HDtB++rNkT/ax3tpu37hznsF3M0EmzJ8GXCg6TH84
         m+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740086892; x=1740691692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8teI2aiwjM2Kr13WVKdYP+m3dqKKJCEMI2qtWnMC/Ws=;
        b=flAbrVlfPv84SSK268KshAwOqeySC4leW2/pC7tPWibKtLXmyYanbGvpM0zGxNbb9V
         5XzOCCGRDdE9lyPu6IACYPTdksXYGbcfyjz6Nu9BAOpWns5liZcrRLAhtyQn5Pvik0i/
         jGdYGYsVFIx7nInFrUQ8Pmqtv8ndSDKL+g02v5iPNtFgN2tS1Ia162IxVmhgubv9mJUH
         5ca8121wXubXr2wLE2AlaUZWDbYy6IzIOIrtuf6Pdx9ihNt/LwvY2koRJ9k2Uhuj1hzS
         GD444eLokRYAciXLt3+S4E350grdvsxNHBj76wv5+H/4rPcwTtVGVEv1sr2Zagy/2lTN
         B6XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGvH8BJB2uZriJD9orf2cqGIfjov8M4B4+wLmhxz1Rt8lmjczWB0sgZsiQTk3WAodVY2kQ4WhQkgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy66BziROq4aPV4xu1IyQsLge3QfVclvLFZMeSZtuxsoheQ9HHU
	6cKIT+U6Ie3dhocR8bB072YnmhJiIIdWU0duAuoV0mqNNE/R98XvD0HYCnZbNJ0=
X-Gm-Gg: ASbGncu0V4UpeINQ5/OmAq5eVkwI9P9KdPGXzbHVjLyrqXac1yxkzBSKAbxfR8PIqHx
	1aM6OcHTD9zUy9nTmoafoFsAVGIrUTrGF5M3TIAIJFA81xrLj7o6fXcyqwWDkAF80/YBkMmleCG
	vbjr5aBIz8o3hVqAUQ68u7JqwoP5MDl4Ii13mfruqxvd3Fxb9tQh0n+dttvQ4kqU8yrrWAaMVr7
	1ITpNg4bL9s3eZ6W/wgQVh3obxqKEz/m4W4iu3AQSf3ofJYsQW9jGTxfNk5q6Ls2C9RPzwuuKXv
	s17hz8HhOdzdmbrtkoXhFbSdaeIeGHPfnNuhvuhtzT+W7tHCOKZg
X-Google-Smtp-Source: AGHT+IHda5wVskrjkmAKgdPIEC/DmfpBOlo13Gpd3qfbwGemyjoGs3i/euhKGLWCrnuYugHibNPpIQ==
X-Received: by 2002:a05:6808:13:b0:3f3:b97d:769e with SMTP id 5614622812f47-3f419ef610dmr2889041b6e.7.1740086892179;
        Thu, 20 Feb 2025 13:28:12 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f40c3ad34asm1471933b6e.50.2025.02.20.13.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 13:28:10 -0800 (PST)
Message-ID: <42296bf2-2818-4224-9e52-d1fef59d8a76@baylibre.com>
Date: Thu, 20 Feb 2025 15:28:09 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 06/17] Documentation: ABI: add wideband filter
 type to sysfs-bus-iio
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, jonath4nns@gmail.com,
 marcelo.schmitt1@gmail.com
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
 <aea512746712f8f6d07d29ec6977609c127fabe0.1739368121.git.Jonathan.Santos@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aea512746712f8f6d07d29ec6977609c127fabe0.1739368121.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 12:16 PM, Jonathan Santos wrote:
> The Wideband Low Ripple filter is used for AD7768-1 Driver.
> Document wideband filter option into filter_type_available
> attribute.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v3 Changes:
> * None, since we still did not agree on a better name for this filter type.
> 

I'm convinced at this point that "wideband" is fine.

> v2 Changes:
> * Removed FIR mentions.
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index f83bd6829285..9b879e7732cd 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2291,6 +2291,8 @@ Description:
>  		* "sinc3+pf2" - Sinc3 + device specific Post Filter 2.
>  		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
>  		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
> +		* "wideband" - filter with wideband low ripple passband
> +		  and sharp transition band.

The description could perhaps be made a bit more generic though
instead of using specifics from the AD7768-1 datasheet. Something
along the lines of Jonathan's 'flattish to a wide range of frequencies'
description.

>  
>  What:		/sys/.../events/in_proximity_thresh_either_runningperiod
>  KernelVersion:	6.6


