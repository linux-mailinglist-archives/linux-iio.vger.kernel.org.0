Return-Path: <linux-iio+bounces-19071-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 511E1AA892B
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 21:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A759A3B6CB2
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 19:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF1D1E7C11;
	Sun,  4 May 2025 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Fh8sSb0L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5387D17C21E
	for <linux-iio@vger.kernel.org>; Sun,  4 May 2025 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746388117; cv=none; b=azNw/rCMT5qooW5yNZxLX6D6yvDtFgqGYVtbhIAn1mEgVEjI/PtYbHNU4/pNYOmEWF/Nl0Z5+iUKaKi4++rjS2TePlMFfZwe7uJYdTQGrX2P6eh4GmDitwIzTm/hZ6XKhBnc4abc3jy/pOPN8c6vNpqDtWIN3LWyz3inBsTb5EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746388117; c=relaxed/simple;
	bh=pfrGjy9sFH027sd2QmcRJbL9tHEZjXpENoMYvP42MH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7MuqIDWyd65dWQ9vXX9v9XalrnvatsUA+Sm6claF/BxvPBQqN3BBUe2f9zXmErIcYCvQ4OhltTMCRIGhIC3JGU0yKN3yiQhxN5kYMlS5yX7i1Wuto7Fkm+GU2q3a/H49ryGBP+3yGHVWfasaaFEQvJqkkcUfLJ2S6vNpQF3GNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Fh8sSb0L; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7302a769534so2473802a34.1
        for <linux-iio@vger.kernel.org>; Sun, 04 May 2025 12:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746388114; x=1746992914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HnwuzSuusn2LX2ZHjCLJbOjOO8seDbLw7ar5XqNTwiA=;
        b=Fh8sSb0LJbJ39shwZB3C0yk0F0+GpaaY9/z8mdPSt8KuiR2SxC/lCssB3Xbzod5AQz
         6h40Vw3UCQmlftK7WNDxjIqZi9Ppq5QCIPf3TJR+E4B9QPpq8JEBxQJaWDXnGwRzSfdk
         s1bhievPG80NBqmt61U7xh4z+azhNf38eAvryC5WeA5D2QdVW+9zc0uXoGVMg2Ug2bZD
         jNU4gawnTV1vPVKuSYwpuXMY1ddzpyAuxxfwbIjrjfKCYcy8+hEVDZwYlQ4iIzTCi9VN
         mP78/4BenX45/2s09P6HmG9ZfXxvrYepNAtTGJ7XwqFd7+rJb5K+uT/bQ0Ne+rXztz2Z
         oriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746388114; x=1746992914;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HnwuzSuusn2LX2ZHjCLJbOjOO8seDbLw7ar5XqNTwiA=;
        b=TvlJ4HELy2ByM2muASypFHVmL//PIdPJgBdNiA0WSH33E15DRbc8jw22GNEDLrTVOV
         HGWgTZ8lv6MthLayjBky/i6Zqmy61w140XKag39gYHZp5vo7ILdspp1YtL1+WWEZg+dt
         fzy+/o/bJL5R6wuvX1Klwnn63CiUC9NpzlKYoMTyQR0OwKETELS0jM6a3JOFqBD7oHHO
         TptcI2+6i57anJLBi+uA9mbK22WFjGq97wNhwblqKmiyXXIYssOoKGSt7ogq2MXRSVqh
         1chUU7PDfGoHSQgTOxcT/nQR8Z2sRYZSoqQ8cQt7zELvRI3UaaCmIWhos0/nlb5rY89+
         JM+A==
X-Forwarded-Encrypted: i=1; AJvYcCWVw3atqD19H9JN6p02PWaI1cjeiSphDEHDKQEe7ESHxuKCLkf58Rnf1LNYZe/y8vEp/gKvYO4iwPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzACvVeHJMvScZ5JZVxQAm+Lmji2/HivOM8zuLycoI3sJIP1xvu
	bFt+o6Ww4c/mNjQDLki5RkeJ1laFWMLc166zPjcxeI029Fq41sMx8c6jjU7xj7Ty3MSvEcpQ4xj
	6
X-Gm-Gg: ASbGncuB7STI7tDxNW/43wFbDHi8P4qKoDWPF+bkeNlt8Z6o/s84h2HIe+DB0KemRji
	Iz0UuH8UvNlKch01/9SzvL40ri7P4RWTfoeLaNtwEglpy5YVOl94tBdIYry4vx1Y7jXxZmymHHx
	dIlkyxv3BICpv3v6jpkY+ETjeWqGdSWJIpZ4fVaumXZ5BVo0ckE/6EWjSab25qT5F4vBAF8QlCy
	PKB+1EAHwb75Sr+ftDfjrlwabrah3/n0RDMJU85d+NTSOGH6Fn2RTvqlwCswk7HdMwAfhamVg3B
	tq8qvkuw6ShfL1cvqAFm4V2nGaUzvMCPDxOBGMeFtxJeufH5UImMF7lOLnK0VrTy46Di6LCE5xn
	mmHaF6rnQdOs0/OiCiEvkDIudI82P
X-Google-Smtp-Source: AGHT+IEeWwZDLnV2kLTz5RTYpnyvvvl/iHho8ndVq67XvjTpGS5bVf4ZbtzTB68KrAEY12RnhPnaRA==
X-Received: by 2002:a05:6830:6c10:b0:72a:d54:a780 with SMTP id 46e09a7af769-731e564611bmr4217238a34.17.1746388114338;
        Sun, 04 May 2025 12:48:34 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:2ddf:83b1:4b93:16c8? ([2600:8803:e7e4:1d00:2ddf:83b1:4b93:16c8])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-731d350943bsm1249459a34.61.2025.05.04.12.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 May 2025 12:48:32 -0700 (PDT)
Message-ID: <357c418f-7f00-416c-937e-f6fea1c0af96@baylibre.com>
Date: Sun, 4 May 2025 14:48:32 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] Documentation: ABI: IIO: add calibconv_delay
 documentation
To: Jonathan Cameron <jic23@kernel.org>,
 Angelo Dureghello <adureghello@baylibre.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250502-wip-bl-ad7606-calibration-v2-0-174bd0af081b@baylibre.com>
 <20250502-wip-bl-ad7606-calibration-v2-1-174bd0af081b@baylibre.com>
 <20250504161603.7d1027af@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250504161603.7d1027af@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/4/25 10:16 AM, Jonathan Cameron wrote:
> On Fri, 02 May 2025 15:26:58 +0200
> Angelo Dureghello <adureghello@baylibre.com> wrote:
> 
>> From: Angelo Dureghello <adureghello@baylibre.com>
>>
>> Add new IIO calibconv_delay documentation.
>>
>> The ad7606 implements a phase calibation feature, in nanoseconds.
>> Being this a time delay, using the conv_delay suffix.
> I made a late reply to v1...
> 
> Key point being that, in the general sense this is only a calibration
> thing if it is both writeable and we are using it for filter phase correction.
> In more general terms it's just a conversion sampling time offset (and as you have
> it here in seconds).  I'm keen we define this to incorporate more general
> cases including extra read only info on sequencer timing - that can be useful
> if we have something like 
>                  _____________
> Input 0 --------|             |
> Input 1 --------| 4 in, 2 out |-----  ADC0
> Input 2 --------|  MUX        |
> Input 3 --------|_____________|-----  ADC1
> 
> That is the ability to schedule more channels across a small number of
> simultaneous sampling ADCs.  In these cases we've never had a way to
> express what was done together.  Mostly there have been obvious
> combinations (i.e. voltage and current at same time on a given wire for
> power measurement), but it would still be nice to use your new interface
> to allow us to describe what is running here (though probably not control
> it as that would be hard to do!)
> 
I'm totally on board with making this more general than just calibration, but
having worked on a couple of multiplexed simultaneous sampling ADCs like this,
I'm scratching my head a bit trying to figure out how we would be able to know
what the delay was between the conversions, at least in cases where we don't
have a hardware conversion trigger based on a clock/pwm. Generally, it is as
fast as the SPI bus can bang it out, but that isn't a fixed or predictable
amount of time.

