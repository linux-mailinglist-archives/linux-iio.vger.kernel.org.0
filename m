Return-Path: <linux-iio+bounces-27931-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAD4D399A6
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 21:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF1863005ABE
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 20:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5C02737F8;
	Sun, 18 Jan 2026 20:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="frVbBmHu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95561ACEDF
	for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 20:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768767037; cv=none; b=ZnLlPRbKrLzP9I25ghPdTMvafxaDKUt5L//GM5fNGodkqsgFGzQqwWAylcglY5k2FxbFOYYIfHM4XU3W2NHmgqzxUKBr8Xe+t8llgnSs1NtRIuyOSd0FNEGRR4uDqTXPiE2yMns9PCWoqnCpla8o3V/o1nL9nZcjemwDzxNxbqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768767037; c=relaxed/simple;
	bh=Idr/9lC0h+Y/MDT98JBhmBK5C5uie9ywPiZzL0QSgfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTTwI926wsHCx+vDLG7GmfeC2PVtV9qri635xdfzD0QkkCz+m9+/bxgd4D8bygluVJ+TDtE7wpr46ShDM5shtG2ykyBM82rf3JEhJBF5vReYr689Tgk04aPlPmnp+Qt+aUirPLHSXkY1UrqxPMI3HozJtpsZ6AM3fhYqSdJJRAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=frVbBmHu; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-65e94e128beso2385603eaf.0
        for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 12:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768767034; x=1769371834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=trA58ecVKWrbKL/kcv6gytfma/FjnpD4gUB9nlw8H64=;
        b=frVbBmHuYEiiT0itRGUty9yv4YigztA0aCQj6l5cdhaXJl9ak5AOykHoPpmkvTAPil
         AtnFF7cWH0QZOCsAq0RFUIFrKnqmp6yPw6t95xvjRjsLOyVb0kKj49daLyMWs4Fqk/st
         nqoqo4wi2qFw7KwhrGWmFnE399xQSZYoDCFCGFCOEXyB5QDIS82aLI0/etOxW4EfzwFj
         UfxP9Lzu0B0Gjopp4ars4d4ya57qceTZ6U/ppXy6xi6YTrv3CfbHYMUpTSFNaESumOA0
         /BJnLvYCeYY4J2eqxz0sW68RQfBL4dy+/Sj/Rz+097zEoEKh8zj0Ur/gVMyDZ86qsdn5
         5EUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768767034; x=1769371834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trA58ecVKWrbKL/kcv6gytfma/FjnpD4gUB9nlw8H64=;
        b=r6hDFOT/5teZwjzIW206JRXyYUBasDfaAn7A9nsAuiO9TkjL1nWCmBt1juGCKYzEUU
         o1jc5/hLglP5AbY6sY9PgB8hOu0yl5uV8uMSz6Q44UodclcQEIQCK7dwu+yXlpbJXqbg
         VTmnkDy5xgA9hKtYVZ6CWNmFET3xRZ4oss95rhtUB2QRui51JKHNxZdEg2KqSQ/jAuoK
         xKCxqqTtT9FJNfLnWiFgKWag80gVNntI2aF/2iuE52ef5cXnG8oB3fa9x/Hnw6i07sKN
         rKNoi18NbwyFFWKheeH6cRQvTCSykKJnDZpNt8LSfDdTFUDHJpL8ql+hvY2asbrTGQVW
         640A==
X-Forwarded-Encrypted: i=1; AJvYcCWqCkEP66GwoUOlyBoFFJescwG09SQ7Z8IdPg1w6ytNrWdBdkHY0JPb0x0Z1bkcPPGJUdnil36oCXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyceq/QAuitizU17nYSstXCdhecYDtiAdzOOF/4Hx40cpqdFwg9
	MsHH18PtLcLd7yqjk83QPMq2qFOwGj185kRZ64Mpqz/6zFLdYf0Oy44bX+ZOa3vLB/g=
X-Gm-Gg: AY/fxX61/D3hXENYx5S5d0oEBx8yyi3FeX0RKzNGEmgKw+TAuNMsrqGgVgRIDi/2Vmf
	oSIUfR3U6ajBGk5ROtAmqrpYbDSx6P4o2t18ihx1NDyp/DAnWW5gJk34MWADYpLTXXj0qB/2VCt
	ZS3sJaT4QMbzV9XFoCIQJ2z9gF6kse/OXwNJCUbi4Gzb94T0kfHuHaGjl1yo8K1KGMZQ8P/yYqr
	TaGAoWjbAuq2I+HPpjPnP6G/Fx4qQBYM8m2mbY1y7J2qPz01R+5pMM9Nv7k5y3psR4XhgzofiIe
	q287/wS5h8ziR2I3hUjldW1wiAGOx0X3lxqWP09+sv2cyHXXstWs12vJpt0ITX0vDv3SdIDctCR
	A2+VKxTf4jOrEqZJOYhoidmJD7fwPZLI899ifC/6ain/grXPUu5yBdwn5G0tpELLM7ts/5V9wnC
	SMjKRKLugxhR/CBYfMWek3gR9olsphVCpDttQG81XWdI3gBCryjk70WK/rLHfP
X-Received: by 2002:a05:6820:612:b0:65b:865e:36f2 with SMTP id 006d021491bc7-66117fca883mr3557535eaf.4.1768767033769;
        Sun, 18 Jan 2026 12:10:33 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d542:af69:64b6:f7df? ([2600:8803:e7e4:500:d542:af69:64b6:f7df])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-661186ca7aasm4022210eaf.2.2026.01.18.12.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 12:10:32 -0800 (PST)
Message-ID: <5835e21b-0b27-41f5-8c92-762cac327b40@baylibre.com>
Date: Sun, 18 Jan 2026 14:10:30 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 7/9] iio: Expand IIO event interface for real-world
 unit handling
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, Jonathan.Cameron@huawei.com, nuno.sa@analog.com,
 andy@kernel.org
References: <cover.1768759292.git.marcelo.schmitt1@gmail.com>
 <6d9baa8d553d03a41fbd97bca0377a7a4779a93e.1768759292.git.marcelo.schmitt1@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <6d9baa8d553d03a41fbd97bca0377a7a4779a93e.1768759292.git.marcelo.schmitt1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/18/26 12:21 PM, Marcelo Schmitt wrote:
> The IIO event ABI documentation distinguishes between interfaces that
> handle values in device-specific units (_raw) and event interfaces that
> handle values in real-world units (e.g. meters, Joules, lux, etc).
> However, the IIO event code infrastructure had never really implemented the
> bits to distinguish between those two types of interfaces and had always
> presumed events to handle raw device values.
> 
> For most current use cases, assuming events to handle values in device raw
> units is reasonable because it often matches the type of the associated IIO
> channel. There are a few cases where drivers provide events along side
> channels with both _raw and _input interfaces, though. Also, when
> real-world values can be mapped back to device configurations, it enables
> drivers to provide event interfaces that are arguably easier to use.
> 
> Expand the IIO events support, enabling IIO drivers to provide event
> interfaces that handle values in real-world units.
> 

...

> @@ -399,15 +410,23 @@ static int iio_device_add_event(struct iio_dev *indio_dev,
>  	for_each_set_bit(i, mask, sizeof(*mask)*8) {
>  		if (i >= ARRAY_SIZE(iio_ev_info_text))
>  			return -EINVAL;
> -		if (dir != IIO_EV_DIR_NONE)
> -			postfix = kasprintf(GFP_KERNEL, "%s_%s_%s",
> -					iio_ev_type_text[type],
> -					iio_ev_dir_text[dir],
> -					iio_ev_info_text[i]);
> -		else
> +		if (dir != IIO_EV_DIR_NONE) {
> +			if (i == IIO_EV_INFO_ENABLE)
> +				postfix = kasprintf(GFP_KERNEL, "%s_%s_%s",
> +						iio_ev_type_text[type],
> +						iio_ev_dir_text[dir],
> +						iio_ev_info_text[i]);
> +			else
> +				postfix = kasprintf(GFP_KERNEL, "%s_%s_%s_%s",
> +						iio_ev_unit_text[unit],
> +						iio_ev_type_text[type],
> +						iio_ev_dir_text[dir],
> +						iio_ev_info_text[i]);
> +		} else {

I think that the units only make sense on IIO_EV_INFO_VALUE and
IIO_EV_INFO_HYSTERESIS. Everything else has it's own unit, not just
IIO_EV_INFO_ENABLE.

>  			postfix = kasprintf(GFP_KERNEL, "%s_%s",
>  					iio_ev_type_text[type],
>  					iio_ev_info_text[i]);
> +		}
>  		if (postfix == NULL)
>  			return -ENOMEM;
>  

