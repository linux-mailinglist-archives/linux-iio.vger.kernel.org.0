Return-Path: <linux-iio+bounces-18656-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A30A9CD66
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 17:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E439C5D7B
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 15:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06ABF289367;
	Fri, 25 Apr 2025 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U5vAHlb8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C981267B6B
	for <linux-iio@vger.kernel.org>; Fri, 25 Apr 2025 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745595805; cv=none; b=LsL8srJxTyz0jcSf2OPXkuhs50NKb+Mg1kImbEiF/MDdj8IdnKK92vv2FXvfLjiCvvSogvipnwy89CN8292GtbmhuXziyuVfi19eGp9xRm7IX01/UN4C1OvXSwp49glvv0R4xXgOzKT8yM/l9vfHzBQ4Jk0ZXk8X0Wyh2/nI4To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745595805; c=relaxed/simple;
	bh=QE61Ro96QLMT2qJnDn34ofb5m722rFs5Cd7Vq0A5ElU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DtiiOshkBNmjxCpPc9AgcOIK1Mq0xmBFZdWMwB/7H25s6BLhubcCeqQS+rxV9vJuLdxIv3/JgMRoV3wGUcAYSPm1gB3GTMLKXam57i/qGs7NdrjeEC1YHsWKZGXUvUh+l+HMeaofrSmySXaApEhoGVbSLH1f+vtuLrFLEk3WiTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=U5vAHlb8; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-606330df903so672201eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 25 Apr 2025 08:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745595802; x=1746200602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u9pUe4E3ZeR1aU2CkECeBsvEMz+lXgJJoqB01YM8ajs=;
        b=U5vAHlb84BgCSpvy98UeQlFZtN9QgGg1xFTFYC0u4sY9hi9qwE45pGVrpgjl+f3vQW
         xPoJiRQNM6T/s3zwanahtIIXQal0mKPH3QsDVx4J/3RWbOkz8CLGMNX3/zUjnUteVYTu
         Rk6b9gxepK/kjH5zPfjLJoDMFDYLb8fQ7WKDgIoBAmd654lJKWGDw1+vJ2bruWgKI1lX
         yK03i9q5W+YFGbel/kZ4+dUNZoWiW7rBUp6ZBJ/dDx31nLNgrq/kF0iBWXco561CZOD9
         55zTL316NyEXaIwPnPX4Isj0v1MAjKSrH0hXELgGTVxZnbrgIWHNxKT/lfnrdT+s292c
         UVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745595802; x=1746200602;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u9pUe4E3ZeR1aU2CkECeBsvEMz+lXgJJoqB01YM8ajs=;
        b=Zf2/cr6sGLP1ZTljFpWOYjV7pJ/7yfKJmT9T+9gLIMcVWk4WU/02H7qmvNMnGV2cap
         nzHzN249b6dMudf6Lq7kvQhg1wuKzr655zzcsTUwZtXbyddy5Kw4O/GBPH76bsKUJvQ5
         7vsFOFXG+5Um1VMc4DNZBfd4p3MPqTBh+ZwnfU3deuXant37YU+rxNZCR/CvG15GuymU
         xhOn4Z3KiHoJFiKFBwtAUd/+OQsfU+RV2p+EjACLcR7Tsvyd743cWVlaKHPu/TKswHaO
         ViFsy8wKegSAdtVMTl8QAX0mrsfSnpeuJkEaxRFHsDpxMBVwVL+7I+kPEaeMWdyQRjkH
         tzxg==
X-Forwarded-Encrypted: i=1; AJvYcCUOJEm7DJrG6zb32DVm263jtHXImqirmOjcp3mb8+dP3plvWjioHFBOk0V/mktDjvvBnVszu24VBX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzigsU1PVw3zBIbAxqwF8aPjgo8cGQ3s7gbYGkeYk3/IJEYk/Se
	8sMg4irvWiI3xQja8Bw4dfgEqqLlRAt4XdcVpnfEeUMe3Z9wmeQX0Mg/dQ98ZIY=
X-Gm-Gg: ASbGncutj7a9DpsR1v/YqlPHILNXCsfsHQSTjGAq8Hg+Anm9gWDlwTYId8wGf25xs0B
	YNT5Qng7HL+TmHODZpAPzVjpG5coAYHhLTtheLNWmDhjDUZbZa/RAw7WVOo0rWnyGMRYunDIJsr
	Loi/7DBKO57zpCXUthCPp/jGKJQ26kNahV1C4w8ivSLr8qKf7Kd6LsImu5Hh25HhGAxBWCZYQHg
	kEU5vHtmqtEGdiPe0f3yLla/lol21ALtj1QKnpk/BSzE0hz9oknzxZHtQWb6HPsc4nYnHDJuFm+
	Q/K4MPwHbo8n7W1huwkQYeB4LrThzGNGiVGlAH95C96plseJRqdzJMVLZrgtP1DyCp19haLirA+
	+3OVw8f/mpYi0LJt+g529fEk=
X-Google-Smtp-Source: AGHT+IG/OtumwHC5swR6H2CFdXfQSy0Vcju9xSNeHVTBb4FxeQPAdHgsFE9XEjfhMfsokIExnHiTUw==
X-Received: by 2002:a05:6820:2007:b0:603:fada:ac53 with SMTP id 006d021491bc7-60652bb3eb1mr1259572eaf.2.1745595802424;
        Fri, 25 Apr 2025 08:43:22 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:96a3:e28:3f6:dbac? ([2600:8803:e7e4:1d00:96a3:e28:3f6:dbac])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-60646882771sm776192eaf.14.2025.04.25.08.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 08:43:21 -0700 (PDT)
Message-ID: <1ca81b41-f3a2-49a0-ae91-72fb068bb0d5@baylibre.com>
Date: Fri, 25 Apr 2025 10:43:19 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/1] iio: adc: ad7192: Refactor filter config
To: Alisa-Dariana Roman <alisadariana@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
References: <20250425132051.6154-1-alisa.roman@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250425132051.6154-1-alisa.roman@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/25 8:20 AM, Alisa-Dariana Roman wrote:
> Dear maintainers,
> 
> Here is a pretty voluminous patch improving the filter setup for AD7192
> and similar chips.
> 
> I removed the write options for two attributes and I know that is
> questionable. I am sending this version just in case it is still viable
> since I think the driver is a lot cleaner like this.

If you can make the case that no one is using them, e.g. because the function
didn't work correctly, then it could be OK. But best not to break userspace if
we can help it.

For IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY, it seems easy enough to keep
ad7192_set_3db_filter_freq() and just modify it a bit to call the new
ad7192_set_filter_mode() with the 4 previously supported filter types.

And IIO_CHAN_INFO_OVERSAMPLING_RATIO seems like it could be preserved too, but
will take a bit more work. I'll comment more in the patch.

> 
> I also modified the size of the 3db filter low pass available attribute
> since AD7193/AD7194 have 16 filter modes, unlike the other chips that
> have 4.
> 
> Note that I moved a few of the functions around to be able to use them
> where needed.
> 
> Have a great weekend!
> 
> Kind regards,
> Alisa-Dariana Roman.
> 


