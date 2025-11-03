Return-Path: <linux-iio+bounces-25835-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3E1C2B155
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 11:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7836B3A2536
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 10:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136CD23AE87;
	Mon,  3 Nov 2025 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiL8NLGB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1A52F2905
	for <linux-iio@vger.kernel.org>; Mon,  3 Nov 2025 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166075; cv=none; b=Z3YDuh3ISZuJVWrPRnWOt36CbtInaVxyzAVweJ4vWl/ckdVhKwmmy6o4jZL7y1u7BcmsYqNjNgUokugI8+ZWL8IkkMVEXjl+TQ6vp18ZHFpP9TY4Ez5dtY/dTn6Gle/blZRzubAxlEgSwOB/CKGiqrwCpVdcJgvuKBPAP1k2ABQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166075; c=relaxed/simple;
	bh=ocooX7RLcRFnHVNC7Jgc/isH9jbGeI1QOPjZY9R3jEo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d2Yn+k4C1DZrCHX0NgCTWAFEN8/X7CbY21xyAoHJU/KhQMclwRAYIyEduf3IxWuUe7i/HNx92+AAfOvuje6Zh60wr4yCYOqp1HzxU/HT6LGC7o5zfwTizLd7Xqh0B0mWqWB4vojlTvtrD/U8ULT8tcKDpyu1/hkI7Ol/mP3KzS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiL8NLGB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so22403285e9.3
        for <linux-iio@vger.kernel.org>; Mon, 03 Nov 2025 02:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762166071; x=1762770871; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ocooX7RLcRFnHVNC7Jgc/isH9jbGeI1QOPjZY9R3jEo=;
        b=OiL8NLGBFvsBf0FnSQZs4cL4bSE6DXCzX8G1czG6H3JNMpWucPArj935TcC6gb5N7q
         zgsU3enax3Y0bXsbltC5Zm/rgZAMs0dnFfYa2Pd+YF7JMDgIV71n8fGd1PjDDbm/5TVG
         ywsOW3DytkmqzQ/GJ8wPfHxbtlF+BllaQ8KMlsWXxcX1Mjj5I/B/4BcXFYZcZCC2nVY+
         L1yPljfm6AQ/f6JqcrxY/YJprWvyx+xlO6xKFuQ6efRoNZckWXAfYxJzto89VF/feNyp
         HcR1e+AiDkk+EXEw4jaj+k+75GeRjPSFe9azyR94GNnRc3814b1UDZknyUIBZwpMDK1y
         R4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762166071; x=1762770871;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ocooX7RLcRFnHVNC7Jgc/isH9jbGeI1QOPjZY9R3jEo=;
        b=xOqt3Dl3bH+Gm+vbQOyD+JB1vjcr4Ur/tLchH1EXp+EAaNwLKDp6+tLYFy0WQpytN1
         A5F0GURWEAAw/o6MUCMDpBOlkrRmWslzS3zSNxR6N5Z+vo0hu+zaT9CvCkxOENGHRs/Z
         dxoVg9+bCTi3INx+MUvVr6k7ixnK7cjlejFR6RpwunJ3IWp3WzxnmDfPib78DJVwsdqZ
         b0zvAZFEBoEHYx125p+wneY9V5Gss/BkQ5rHVsQ3l9yIcQbjpNijm1jp5HKOpNTa7aT6
         fR0Sfr5O0osL9HVHkidRPpJVWS5bUMkHfZEOJZyY6US2A/2/SuAMzdxewKpH8hGeUaIp
         4FQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXqpUldSWUXU508q6wF6Ja4JnMYEcM/CSE17xaDJPFKfG7qaY4TG2vALCmIsFAwXG+KvWzdSOAvHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEEHP1uCAlksotkiWiWhpknWncad8sLopwoysxiermPgzvntWX
	IOpMsGBMqH1oOKKSLlKOMrdfSpTRVRegjfdkPfnibBZeZQ7sF78tqryQfzYbkw==
X-Gm-Gg: ASbGnctwkB5UvLHo6/LdxoFEfq51QqJxLMyCIv6lQxDk8teDYiM8t+JG1t+VzOtVp/3
	+W9MEaIz0pJ9lqrkeI9g9Y1tbdUHEQ/j7Q7NFL8jVa7fL27wI/oGEkRyAAONXk3tVWfLYSYEE9+
	xbhBkjTJutJkVUUZLhs/OChuW7vRMeEtTxWvZyMlIMQH4QLH32QwqlB5vWIfsz7OJSF7ai1jLk0
	GrPd0lPH5BL8d83UwDkxH4xQ+fU45Sdp/2NzWJlrnGp0+yoYJsHqPdzKHuZc+ERpsd2wwYd31T7
	SweaJ1Swt8rPjvSl2PWK2ZnKMdf6acGxAJAT0YQGpw1ffCw6/OQoPau6i4SmJQ6VLUUc8yms5aE
	BTJ9owtaJdBcPyLkm4il2PkNgilvFgxZ3dCV+RAJbCzmWYRFNClL+A0xZtE7Zn4xwWYBn3yNQ8O
	YQwJVPulNVs/ASzL31g1s=
X-Google-Smtp-Source: AGHT+IGx8T5omXtXMdUKgxgi5DTGVT4hpN4abP0g5rQeJFFkbLX0TQbiBASXSdkoHnYjdB6+OzIC0w==
X-Received: by 2002:a05:600d:4390:b0:477:333a:f71f with SMTP id 5b1f17b1804b1-477333af9f8mr58570445e9.17.1762166071160;
        Mon, 03 Nov 2025 02:34:31 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c48daa0sm150446885e9.3.2025.11.03.02.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:34:30 -0800 (PST)
Message-ID: <f81185fbf04034c3275cf9710388ce4c79ea99d2.camel@gmail.com>
Subject: Re: [PATCH v3 01/10] dt-bindings: iio: dac: Document AD5446 and
 similar devices
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, nuno.sa@analog.com, 
	linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
	 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko
	 <andy@kernel.org>
Date: Mon, 03 Nov 2025 10:35:06 +0000
In-Reply-To: <3e98c5e5-8411-4b69-81a8-9ea52a50f9ea@kernel.org>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
	 <20251031-dev-add-ad5542-v3-1-d3541036c0e6@analog.com>
	 <3e98c5e5-8411-4b69-81a8-9ea52a50f9ea@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-11-02 at 10:18 +0100, Krzysztof Kozlowski wrote:
> On 31/10/2025 13:31, Nuno S=C3=A1 via B4 Relay wrote:
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > Add device tree binding documentation for the Analog Devices AD5446
> > family of Digital-to-Analog Converters and derivative devices from
> > Texas Instruments. There's both SPI and I2C interfaces and feature
> > resolutions ranging from 8-bit to 16-bit.
> >=20
> > The binding covers 29 derivatives devices including the AD5446 series,
> > AD5600 series, AD5620/5640/5660 variants with different voltage ranges,
> > and TI DAC081s101/DAC101s101/DAC121s101 devices.
>=20
>=20
> <form letter>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
>=20
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.
>=20
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time.
>=20
> Please kindly resend and include all necessary To/Cc entries.
> </form letter>
>=20
>=20
> Best regards,
> Krzysztof

Bah, no idea where did I messed up. v2 did included devicetree
Anyways, sorry about that!

- Nuno S=C3=A1

