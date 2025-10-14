Return-Path: <linux-iio+bounces-25044-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCC7BD799A
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 08:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B5818A2754
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 06:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7002E2D1308;
	Tue, 14 Oct 2025 06:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bd6zNQ1Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF9723F412
	for <linux-iio@vger.kernel.org>; Tue, 14 Oct 2025 06:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424240; cv=none; b=aLV1tLJwO/Fth477QwLwpYYMEDX2TRrY0KA41Lb4mPMRfD3CN0uTxkr6vt0XjWmZs2F5gDyx5j7G59oZRwTxZrexFJ40pK+SHCIhZf21YhNDzp/K6gO9JAd5tGuaXzadhkbThAYzcz9ykyh0ylOMLuqEl0ocpiC8A0/zAPu58tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424240; c=relaxed/simple;
	bh=7LfosSalQoOmNEmHhY/QY51LrQAsAokzEFeQI2Z9S9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g51xbR2H8AL1ZA1VoogFziPlIXM6T+eOp/LuFLs9YiRNmiM5v/nX7uJzGMo2cdQVFHR1C62zIad3RX2FMcrT+kLGHCYgyEOTbpaReIOieBpgLbPJ+zRVPGeHS627lHfADvjh4Nreb15F3A0ofsiMWBgvFs18xJ6iyxMD5POQa9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bd6zNQ1Y; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59093250aabso3596585e87.2
        for <linux-iio@vger.kernel.org>; Mon, 13 Oct 2025 23:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760424236; x=1761029036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vAmeCsewF8ka7XEXAqTPy+UE/LwfMy39WDFqbqYowUU=;
        b=Bd6zNQ1YEXLqm59sOqqR0JaW5mxkUnRx2LTTyqGnI8ql5R0dFLowd3juR2fdWotT/j
         W8Ys105TJb/4FLgcVEmZ283WnrYzg6qNrVn1FhBUnt/4zpf49+lKhnlA78PsZBxdNLtG
         4eTSNwAmynOxx/mT8kyuCASrJMWQoLPMXN31v0OwSl6JOOOVv+hQlEjxSipTgyRHlWBC
         ZX2ndD48akTU3J41TPGuCWMiiHnBDuTBP5idTzffAmDQXQKqgi1TI+ei1G9PgNlMOF3M
         Wk8Cp9lMBeo7i6WzuoH5f/PZDRBBaL009n9db1p1wsFTwu6wELK9c40AnEkYEuoKsL+k
         dF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760424236; x=1761029036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vAmeCsewF8ka7XEXAqTPy+UE/LwfMy39WDFqbqYowUU=;
        b=Slq/oRs6280E6hL+b1oELmpdOramFdnFIYiOP/BWiDCQK3D2xQ0L88u3QiU4jR+P0g
         hK+AfjU5OQCmOqHYHKPJifkVENtRagzGLWNYsYDj9xPV+3Fb2x4e/2I0VoG6Z4+7woie
         n3gLs/bVHeWtGsBINv7fK6Znuh2Ehf8s/Hzkq64i9DzHBFF4HLNriEifhchJhnxGL/pC
         mzaygrHg1xEsBZeepsvRdLWnJOac0dKtMf5vrkNjqCMNi6lVuJxbiLzR57EzFER+gXtm
         eeu7cs+d0HBSF0VEDn3jSdfkSHWHzC7K4cVGfVbx4uu5zGItKvzLt9d9q6UZJo9wtsKD
         Nc9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqvQjcsDAh2nK5VC4mfXJp+A7rJgencvFNOazfidIels8kWaPzxeU3bJKu0uQHFw5IkubuvqhUWqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY2nT+nj7CKdWNeRGAC2D2TbGqyNG7JdQqynUi28SUdQ/HO91B
	DNorwLt8uCer+Pig48QpH0Y3KEJvOB3rtg2Aq3rxtH0BbrZ/D1avTUcPI58Zhu7P
X-Gm-Gg: ASbGncvH7VnpDJC5nvlZMK9XP8vepvg2EKpYZx00SJDd0hFy5T/fOis/Fh6hX7v0jqP
	n7AXraoOIS9URJw52WQd3CitpU6NxbPz35hGrGa6g6j/xKac9FVJyFybGR5G9DL9FzDBqFWJND7
	+lVgfbHAfSekU0yxk/cvcBOIDh3tS9b3Avh/0HiexVy4hdRbrAM32FU0pbveTugSG9rDHwg/hRw
	87w05qXEVh8XHLLAl3Wl2nhzlhAv3Sud0SUgv4g86dVt2nvcZOvewFupmqao1necgeSYILgo+Ca
	2mt7g5YNe7CXckX5/ZVYakzzacziD2Y9YyKNbjyTN20ECKHt4IrIkv0dBxfW+JclZiQU+h0hr1U
	nwwDNwgZbUDLhoSb7btH4r/k3ecfETlYfQowCKhcEnhGPe9kxXN5EkadfBytKed5Ttvz6YW7N9h
	qwnS5cataDDchvPSGN3MhObCg=
X-Google-Smtp-Source: AGHT+IFoCqVj273i0jedPUwrCZButXSFTXIIKBwZn09cc1FlZOPzt6T0zJDoMFhmO1rUxdyxTC3OAg==
X-Received: by 2002:a05:6512:114c:b0:55f:4f1f:93fa with SMTP id 2adb3069b0e04-5906dae5c63mr7116100e87.42.1760424236229;
        Mon, 13 Oct 2025 23:43:56 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e4f8asm4948776e87.18.2025.10.13.23.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 23:43:55 -0700 (PDT)
Message-ID: <166d0753-413f-4f83-892c-2e799c0c9f15@gmail.com>
Date: Tue, 14 Oct 2025 09:43:54 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: test: fixed-point: new kunit test
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20251013-iio-tests-fixed-point-new-kunit-v1-1-7b52021925e6@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20251013-iio-tests-fixed-point-new-kunit-v1-1-7b52021925e6@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/10/2025 00:33, David Lechner wrote:
> Add a kunit test for iio_str_to_fixpoint(). This function has an
> unintuitive API so this is helpful to see how to use it and shows the
> various edge cases.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> When reviewing [1], I noticed that iio_str_to_fixpoint() has an odd API
> which lead me to find the bug in [2]. To make sure I was understanding
> the API correctly, I wrote a KUnit test for it. So here it is.
> 
> [1]: https://lore.kernel.org/linux-iio/20251009173609.992452-3-flavra@baylibre.com/
> [2]: https://lore.kernel.org/linux-iio/20251010-iio-adc-ad7280a-fix-ad7280_store_balance_timer-v1-1-e11746735192@baylibre.com/
> ---
> Discussion unrelated to the patch:
> 
> I'm also a little tempted to introduce a new function that is a bit
> easier to use. Many callers of iio_str_to_fixpoint_s64() are doing
> something like int_part * 1000 + fract_part and ignoring the possibility
> of negative values which require special handling.
> 
> static int iio_str_to_fixpoint_s64(const char *str, u32 decimal_places, s64 *value)
> {
> 	int int_part, fract_part;
> 	int ret;
> 
> 	ret = iio_str_to_fixpoint(str, int_pow(10, decimal_places - 1),
> 				  &int_part, &fract_part);
> 	if (ret)
> 		return ret;
> 
> 	*value = (s64)int_part * int_pow(10, decimal_places) +
> 		 (int_part < 0 ? -1 : 1) * fract_part;
> 
> 	return 0;
> }

FWIW: I like this.

> ---
>   drivers/iio/test/Kconfig                | 13 ++++++++
>   drivers/iio/test/Makefile               |  1 +
>   drivers/iio/test/iio-test-fixed-point.c | 58 +++++++++++++++++++++++++++++++++
>   3 files changed, 72 insertions(+)
> 
> diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
> index 6e65e929791ca247df9ac993fddbb4da557d5dfa..d210067ea59199d342b15bf373e724d0aa2c55a0 100644
> --- a/drivers/iio/test/Kconfig
> +++ b/drivers/iio/test/Kconfig
> @@ -4,6 +4,19 @@

// snip

> +static void iio_test_iio_str_to_fixed_point(struct kunit *test)
> +{
> +	int int_part, fract_part;
> +	int ret;
> +
> +	/* Positive value > 1 */
> +	ret = iio_str_to_fixpoint("1.234", 100, &int_part, &fract_part);
> +	KUNIT_EXPECT_EQ(test, 0, ret);
> +	KUNIT_EXPECT_EQ(test, int_part * 1000 + fract_part, 1234);

Do you think doing two checks:
	KUNIT_EXPECT_EQ(test, int_part, 1);
	KUNIT_EXPECT_EQ(test, fract_part, 234);

instead of the:
	KUNIT_EXPECT_EQ(test, int_part * 1000 + fract_part, 1234);

would work? For me seeing it all ass
	ret = iio_str_to_fixpoint("1.234", 100, &int_part, &fract_part);
	KUNIT_EXPECT_EQ(test, 0, ret);
	KUNIT_EXPECT_EQ(test, int_part, 1);
	KUNIT_EXPECT_EQ(test, fract_part, 234);

would be super clear - albeit also a line longer :)
(Same applies to the rest of the cases).

Well, it's not critical, so with or without that change:

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Thanks!

Yours,
	-- Matti


