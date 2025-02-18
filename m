Return-Path: <linux-iio+bounces-15748-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E00FA3A735
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 20:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D6618878C8
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 19:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B253D17A2E8;
	Tue, 18 Feb 2025 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mn6BW7ba"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EE921B9DF
	for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 19:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906311; cv=none; b=LJFkBWdb3c/nfCwCMOh02KiiQDlx2qMs4gbqhJZqZwEypcq/P6+RswtL5lD9VT7EKK1NzNzUQrzNv+2NcYQVouLDnin/ZO7tg7FYWK70kf7asBoJb/ztDnVCm/ASGd/MMA+2kXjWkQjEtAoFpPf36Q+TScoSlKUA6+5RyR8Gl9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906311; c=relaxed/simple;
	bh=m9eVA8vHQhWtM40EESVAE99jEnPT0Mpbdjq+/sbVixU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ErPXynKzsKB5g/+x3Nk/8ABRAnxHRzD9kwCCuZgQIWMuuaUMMYk/Oo2BbxKbpqKISHO4819OUm9Z2JpIanGkMpXngj7llhvn3XLGB8bKkUMz34Fw65vmw+0AWB51i8irHlaUdPMBWEHhZWx81JX066XrrhTgZ4fDJEYdEwuv53w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mn6BW7ba; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3f37207259bso1397762b6e.1
        for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 11:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739906308; x=1740511108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wdU7SdgP4qEfRJOOB0Fyni4aSfrw9megi++1Furp1rw=;
        b=mn6BW7baNwGnknD2fgSFKmPwFrG1Td0Tw7fnRvrUfO+FimlKd2DJeBFWrIuoX2Whtw
         j6Ln68shLg4wj1BwSX/itiGGhPKgwwBLxZlzg5HPvEel25IZybqswyJizOQ5VrD5A9/G
         uL4tzQy9oji5IijDun7Q7DrnIGYdvFcCVMC3FHnpeNV0PiEJ8wo0IyDvnuY2LaoAU/OK
         jlQe6oIY3iPBN3tclOtX0XHQV21rvApzQdu54gohotxqklKo0sDcbposqEocBN5ebBKA
         RWQC/VKZvMRy3rPXVPWfxdnebXDACQOSLNmHNtsiYg+Squ6davV61MGPMYkqoJiEer6K
         ak9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739906308; x=1740511108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wdU7SdgP4qEfRJOOB0Fyni4aSfrw9megi++1Furp1rw=;
        b=STghDIH+WdnS3pTVCnWiKwHrtI8JBZBbgARiEsFOIiYvoCsnGykZnm3cW07PaxDDRh
         9MwRHLv54LHUdHfMcyKASmpGOejrU/AuEZoJRwsTqBMeCEdwD2vDU6dTpnvCvlxP7UxS
         QlQADoI9VBOiA3c1imlN/6SmVyiyiS5zj9XMRz/LwnIzgWJebsLk0iFwtpeB95quBE0Y
         StJHse3TMvlYk0+oMV2oIb+dt/Gee2i455DFklwfkqiHNnuxHJg2Oxlw2fL69Ywfd4CE
         omg7tIOe7UcUUBFFb1y/047GCn9CIQVbcBdGr3DuhUJGCLrwbLtXObEHdNuCNmjcEA36
         5RoQ==
X-Gm-Message-State: AOJu0YwR/4Hlt57nqyewrNzh3dho3H3N4po+x3DDoiGBM9Zu71REi9wS
	UAGN53l1hDn5n+rdGBaalr3lTfMZ/zbdS1ZDgK12fFd5+dB0pPt0hXzqVVmG02TTLl8zxRDZ9V5
	2
X-Gm-Gg: ASbGncsY0MTj47rayFnXBVkB1o0R20MgHM4DYNtoRM9Iy6omyv6OEbNrB0JAnSOKQkK
	VTO9GMYiXLeFHwIgSMt/NFo8VSsd0XBS5B3n7yFOlIz1R8clyMsMgv1HbPbBtlT4HHEZW++D5FE
	mLISRA3h797WQYOQkyLxW+aGXIvUAtoVsvWTxniE8QU2D7q5C+GcAmT6Sb6LRAJcltHTXC5u9MK
	C/mA/QfU9dtYxX4YLikyI9jljvktdU61i7lCSMJXeqUeCX/XFlE0xVcnxZ9OY2c5W+cgTJ4sV98
	WVLBSpoK0S4FsY+T6CXDvwgQh0hmqLuNOTPXKujGRrAg8puGOpph
X-Google-Smtp-Source: AGHT+IFaMHlczdCRfO5laiHp4P4A5xo6o7vEjOkFo67A08+SS/VVvvOdIKCzOHTQ4Ce55T+5iSFBpg==
X-Received: by 2002:a05:6808:1314:b0:3eb:5160:f859 with SMTP id 5614622812f47-3f3eb0a836dmr9411684b6e.9.1739906307994;
        Tue, 18 Feb 2025 11:18:27 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f3da92b699sm4122696b6e.10.2025.02.18.11.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 11:18:27 -0800 (PST)
Message-ID: <09b61024-1738-4956-aff7-9f443323faf7@baylibre.com>
Date: Tue, 18 Feb 2025 13:18:25 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] iio: adc: ad4130: Fix comparison of channel setups
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-iio@vger.kernel.org
References: <cover.1739902968.git.u.kleine-koenig@baylibre.com>
 <4d1ba8c9a890393fce38083b01db6ce03df8ac5b.1739902968.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <4d1ba8c9a890393fce38083b01db6ce03df8ac5b.1739902968.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/18/25 12:31 PM, Uwe Kleine-König wrote:
> Checking the binary representation of two structs (of the same type)
> for equality doesn't have the same semantic as comparing all members for
> equality. The former might find a difference where the latter doesn't in
> the presence of padding or when ambiguous types like float or bool are
> involved. (Floats typically have different representations for single
> values, like -0.0 vs +0.0, or 0.5 * 2² vs 0.25 * 2³. The type bool has
> at least 8 bits and the raw values 1 and 2 (probably) both evaluate to
> true, but memcmp finds a difference.)
> 
> When searching for a channel that already has the configuration we need,
> the comparison by member is the one that is needed.
> 
> Convert the comparison accordingly to compare the members one after
> another. Also add a BUILD_BUG guard to (somewhat) ensure that when

Now it is static_assert instead of BUILD_BUG.

> struct ad4130_setup_info is expanded, the comparison is adapted, too.
> 
> Fixes: 62094060cf3a ("iio: adc: ad4130: add AD4130 driver")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---

