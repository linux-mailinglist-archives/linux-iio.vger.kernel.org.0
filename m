Return-Path: <linux-iio+bounces-14099-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6E3A09366
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 15:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38AEF3A9DCF
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 14:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E711210F43;
	Fri, 10 Jan 2025 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0HCkPJ8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE0B205ABD;
	Fri, 10 Jan 2025 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736519185; cv=none; b=KGw4w4Ni11KaClwsRFU+f1McMvxgK9mDyKVmWXgvA9Z9dfyvSBns3eDp6odUelky3LWxSjE0LjMGTWfE49CwaAhAqxgBuV4EKCoY5C9+4W/FF0Cp4oGOpmCJldWQ8GUE59eW7vxJgNfjmXdBWTzpulEdnwLGTh2ztRqTwyH8Hos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736519185; c=relaxed/simple;
	bh=xm7hQ+q/PLV3VeHSt79Er/hBHmVeMIcQRzaOFB2g2lg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dGDI2zMPLTHDSbj6UlLGna07VrIJbU+epFoasC3cMm4G7NFQZ0Vwbl/uu/Cl3yhNc2bnn6qYN89R0OyFAeANnrB2O7lsYgQCAvjWNNOfp3Kl6+0o6n5jkzMEcCCojFnPKkLXu14mH7CDJyzd6Gi8DNj9/ajTSvpQJYeHPcn8CrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0HCkPJ8; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30229d5b21cso18696841fa.1;
        Fri, 10 Jan 2025 06:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736519182; x=1737123982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UpoBLHHJih29vFt0sUCsXiQEphlyKx2cFD3wTI/+RkU=;
        b=Q0HCkPJ8dsRJT8wPiutOwhD1fxqy+18xHOUXiXYjcXqUMeLy/bfkbFfvqeM918ayR3
         +VTEosnzKjCEypfqOLLDIQwb8bzrLOkaUnr/KIJLKx8iLorZ+2GF5UUh4iDI1wwzwVsD
         Dznco+DIaI+nJVCPWqW5xfuRcKg4ZS5ckGHoeU4Ms+qDxxkeQ0yT66+KnH/TpVNUwdXS
         7Hub8Fdsq789uXK9ngLBnYeiMpHtU2NzFCOmI//dBKk8uCg97O8aH30xdz15XYDUpfyb
         x6LD25LLutvxtCYKfnL7vsTwaqyuGLtPJAFc5hHdAl0S6lymkHObmi2G1WDBblTpVgSK
         U9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736519182; x=1737123982;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UpoBLHHJih29vFt0sUCsXiQEphlyKx2cFD3wTI/+RkU=;
        b=KPffTILcDvloFGjvpRGNCUE+3BqVS71nyRpRWh4ui4C/PnJgp5DKIPF6R0Zo7Xzf6g
         wIH1vawCTWesqDXUpvnK3+ylBnLUo0pxhI4VGA4IXb4wN9oGXuF4wYtfCbNQ+xWUDZ4d
         lwlBYhzvvm9PCMHDHZ5DPNoJAQ/k7TPsLRTUjejvmpQCm/MG7AaqrFLqyzI0IWeNCR4O
         Gngy9u5xrn2jt2gy/ID/MK1Fny4fa+MQJqwmXy4+PnvfT4qBYRnHrBG0dxhQk5XaysCf
         76yEOeLiVjh/zmCd18He4nvCqwMOwtt6BkMDPQeJ5FnPXvd9IK8XuiBVPdcSYcz54Lk8
         mslQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIJxeuzKzobktl9f76CdSQfon+oGcSt7DjiHYkmDN+Ay8cYiuB3HkfiF04mswYOsojUjNdtGiicEA=@vger.kernel.org, AJvYcCW32+3JxzWKZdhKSPVkYgexW5eKBRlB5WrY2I9yPJaMSIBwlfRUpzlflJMa4JpiC/xMFQUEsTVo4N3UPlTk@vger.kernel.org
X-Gm-Message-State: AOJu0YymbGvb2CcGHPYUFRoaYE35aiplFQHpqMsYgxmZ4gX7DQEEkQWN
	CU8I+sDFxiEC8HX41zmvuh9oX2dg/JTB4nuHcIb0l0AXZLxwnPmx
X-Gm-Gg: ASbGncu6VGAZ0dTCCq42oS14Y3xT3tvlVqIJyxSLVsbYz66W5DxlTFJweHU6JFbWJps
	d5YjaqSA4kq6tOObd1aV5I/kY7v+9BKVzOktnXbCRir3R/IA5+Zzvk2SP8gjtESkqXzs1hJDkKi
	ikzxrTGR9UVYL93NGkwQZbMMgIIhJLQ/xvo9hYQLNvx8o3bNgcTkdzvWsTLZudD3WOvpANGqmqA
	12ReIq4NkLHrGdlyQ0yryqupzlsEQH0f/4t0w1n7YQl1BF60wx5qCr6xFC2WM39N0UFLA==
X-Google-Smtp-Source: AGHT+IHv9y96ODQrBrEdvqfZDcX1zoazfI58+3y8fSpwlnax5HY+Ki6K/9LH8UCz2vVxUTL69iMHJg==
X-Received: by 2002:a2e:bb8e:0:b0:2ff:56a6:2992 with SMTP id 38308e7fff4ca-305f45fe704mr24525071fa.37.1736519181803;
        Fri, 10 Jan 2025 06:26:21 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-305ff0f655bsm5059941fa.53.2025.01.10.06.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 06:26:20 -0800 (PST)
Message-ID: <a49a57c0-e3fa-4d4a-aec7-be8f7a681f3b@gmail.com>
Date: Fri, 10 Jan 2025 16:26:19 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: gts: Simplify available scale table build
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
 Mudit Sharma <muditsharma.info@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <Z1_rRXqdhxhL6wBw@mva-rohm> <20241220192118.3e9ba7f9@jic23-huawei>
 <9c07b71a-160f-4336-8a8d-cad7003e4b68@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
In-Reply-To: <9c07b71a-160f-4336-8a8d-cad7003e4b68@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/12/2024 11:24, Matti Vaittinen wrote:
> On 20/12/2024 21:21, Jonathan Cameron wrote:
>> On Mon, 16 Dec 2024 10:56:37 +0200
>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>
>>> Make available scale building more clear. This hurts the performance
>>> quite a bit by looping throgh the scales many times instead of doing
>>> everything in one loop. It however simplifies logic by:
>>>   - decoupling the gain and scale allocations & computations
>>>   - keeping the temporary 'per_time_gains' table inside the
>>>     per_time_scales computation function.
>>>   - separating building the 'all scales' table in own function and doing
>>>     it based on the already computed per-time scales.
>>>
>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Looks good to me, but I want to leave it on list a while before applying.
>> Ideal if it gets some tested-by or other tags before I pick it up.
>> As always, this is fiddly code, so the more eyes the better!
> 
> Please, let it wait until the Christmas has passed. I got information we 
> might be getting some testing before the year changes :)

Well, the year changed and no tested-by tags emerged. I suppose my 
sources weren't right at this time.

Yours,
	-- Matti

