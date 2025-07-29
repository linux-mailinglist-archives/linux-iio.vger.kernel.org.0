Return-Path: <linux-iio+bounces-22129-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9C7B150ED
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 18:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC753A4AA7
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 16:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163DA299944;
	Tue, 29 Jul 2025 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MNFZOA4c"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862AA296163
	for <linux-iio@vger.kernel.org>; Tue, 29 Jul 2025 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805314; cv=none; b=eAAcP4bcW3tEfmy0UDos2NmGvhAjg3W63TXEt6tLKJWLtX0Ec+Vu2R36bRIgjtzGXxQXV8ygAeyuuugzlr9+v62SP9J+c56kti7AwAgojl4tPcv8bE49FBRM2ca9/FRezBKSMyyO7F5GmDhfUXkGsxn00aOm0R1BL0InYeudP0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805314; c=relaxed/simple;
	bh=Y9zplbesg+n+uaqGf/jqos/my3gJKcrm77xTP40xPCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhJHuJlAji7oxLeuaVckaK1lbf6gUuAaovvj/j1sN/4BVCMhsDr1TgfSpIY82BK7uv0L94wn+vTIpN6TjTGTBxhjMdCp+kViWnBVQ/olhR1R9oawTUMkdB1B+Hqp9jPcNUkysNXrmvRpeG7IJbHM8QCemJ3qjSL6aCKSat4GCFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MNFZOA4c; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-73e5792cb9dso1964194a34.2
        for <linux-iio@vger.kernel.org>; Tue, 29 Jul 2025 09:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753805311; x=1754410111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iisZZW4Cr/AQvtrcy4WRz8ws+tzToFhKZHiBGfmsH9Y=;
        b=MNFZOA4cBh3Z4tnXgHSr8ZmPVZs+VILKkMJQHgDriuNUJnkUOhxop6HK6Z5PcMtpZH
         A7SlM+/ULh3b0W4yUpqMiDg6uIt+tW5uazk/hktbFiXogGM7l66a8woXVTdnc1ZNt847
         FLicGF0T5i+KxOQ8nzS+jDK79lBwLqcQJW10cYJ0yaDOLkqdY2QOgXrIr1Lrzt00amS8
         xV1ZelKLz8XoL7gnJGb0oksgYtHB9mIZBJOohE9w5E7n+nkPuK8nzA3ktC4SyAV05sA8
         AZMBqxXz0yOhkquTVNjkG59ZQ1eqP3d2fDsuJPH50dtl8YcY/dIxZuEueGN12AV7TRff
         BlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753805311; x=1754410111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iisZZW4Cr/AQvtrcy4WRz8ws+tzToFhKZHiBGfmsH9Y=;
        b=RbFEciYccit5YjqEb617bH4/n3jBLIBp1uuefjkY0GXUk90HxH5AyvweWhWhBQz/5q
         B3y5GaTvgjZwb0WkItv+O5Yu7C2M1FJPit7AZyR7N9dNTo/XzhHZXPOEUG+Nx+Cn3ZVd
         I9Ui6BDQjvoU3whe1tJYrRdxTV0e24i10v19l1szCtH2Dodc+eJ4E0Zmfc6TwqgHOZmx
         pZ/iQXopXXv6KnMFUQlN8SW/QKq95OjMqYgVkFls4y51on03urFHcjhxciynJ/MAuoGh
         nOY/vOkTJF2NH4pbvPp574HB7dcNLY1x95xqRpRMir+45O7/nMaNvUlJQ5TsV45c+kNi
         JAxg==
X-Forwarded-Encrypted: i=1; AJvYcCWrDdRitFS9bM0YJfgJ2HN9dckSxaQR8VdvoAcUgOk02reON1v56tTAOl3U8Hu3eg+JB0881e4dAl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YySj7iKl9Z+avmZzIi5L0VUfOOgrr/MyEVWZDL/DT+8pSo1VRSm
	PKgl5NHDx4oWNtAsGlspl5y+uMtaknN6BTy3sTVsPJ4K+Fa80O5AoqxukkM7LE2/RW8=
X-Gm-Gg: ASbGncvX6s8nIgzfxxjGTJHl+JAL4eCtZQjV1B0FDGRTjKrA/sVB0vGmFe6VZwboPat
	8yjGTUsNdmDaeBkuJvzqwGNX+EZ5GGtGM8n97ORfr6GccwqvhZAcrP/npKIrhwsVjg/PT8sQ/KO
	d0PLVkkfJsPlqtq0iBOZiX10ejXncAHQLP9L5xVWftI/I8ss9j9H63iMtyaCRyF4SUdUo2XDfyx
	MDSezr2cwMCw3Vyrlqe0pE4NQIzCZieOn7qbIVc0lEqDLNVRxWwWMKOvdrrSmtFtW+C1oDl6seC
	P+mVjCPJhuBMQfbLcSAK9o81k4/WuvSJxBB1C0CCroKGvtV01KbFSOkQUrlcq3EMOz3pCDHNaER
	2hcKxAYXNF1xG0ughgXKQ34qZLiqDWb9WOIdP/fcziRAY6uiO5n3ilZNHVP9ZwhWukPjYDY6bSp
	0=
X-Google-Smtp-Source: AGHT+IFDGl5SETxkBjW/H31hwu1U5JxJwMyDzgnv3ruh05bOarPZvWxXwwo3/ACHAvk332S0oYi2Fg==
X-Received: by 2002:a05:6830:4d8b:10b0:727:3111:1416 with SMTP id 46e09a7af769-74177ca43d4mr203693a34.24.1753805311343;
        Tue, 29 Jul 2025 09:08:31 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:c7d5:61e1:68d6:dd54? ([2600:8803:e7e4:1d00:c7d5:61e1:68d6:dd54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74147f9460csm1597928a34.17.2025.07.29.09.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 09:08:30 -0700 (PDT)
Message-ID: <1c897cf7-dc31-4e39-84c1-f8ab4b3e0aa8@baylibre.com>
Date: Tue, 29 Jul 2025 11:08:29 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] iio: adc: ad7124: do not require mclk
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250724-iio-adc-ad7124-proper-clock-support-v1-0-88f35db2fcaf@baylibre.com>
 <20250724-iio-adc-ad7124-proper-clock-support-v1-2-88f35db2fcaf@baylibre.com>
 <20250727132143.35a44547@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250727132143.35a44547@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/27/25 7:21 AM, Jonathan Cameron wrote:
> On Thu, 24 Jul 2025 18:25:23 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 

...

>> @@ -1111,21 +1112,49 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
>>  static int ad7124_setup(struct ad7124_state *st)
>>  {
>>  	struct device *dev = &st->sd.spi->dev;
>> -	unsigned int fclk, power_mode;
>> +	unsigned int power_mode;
>> +	struct clk *mclk;
>>  	int i, ret;
>>  
>> -	fclk = clk_get_rate(st->mclk);
>> -	if (!fclk)
>> -		return dev_err_probe(dev, -EINVAL, "Failed to get mclk rate\n");
>> +	/*
>> +	 * Always use full power mode for max performance. If needed, the driver
>> +	 * could be adapted to use a dynamic power mode based on the requested
>> +	 * output data rate.
>> +	 */
>> +	power_mode = AD7124_ADC_CONTROL_POWER_MODE_FULL;
>>  
>> -	/* The power mode changes the master clock frequency */
>> -	power_mode = ad7124_find_closest_match(ad7124_master_clk_freq_hz,
>> -					ARRAY_SIZE(ad7124_master_clk_freq_hz),
>> -					fclk);
>> -	if (fclk != ad7124_master_clk_freq_hz[power_mode]) {
>> -		ret = clk_set_rate(st->mclk, fclk);
>> -		if (ret)
>> -			return dev_err_probe(dev, ret, "Failed to set mclk rate\n");
>> +	/*
>> +	 * HACK: This "mclk" business is needed for backwards compatibility with
> 
> I'd drop the HACK bit of this. Whilst I understand the spirit of the comment
> that term tends to make people try to 'fix' things ;)
> 
>> +	 * old devicetrees that specified a fake clock named "mclk" to select
>> +	 * the power mode.
>> +	 */
>> +	mclk = devm_clk_get_optional_enabled(dev, "mclk");
>> +	if (IS_ERR(mclk))
>> +		return dev_err_probe(dev, PTR_ERR(mclk), "Failed to get mclk\n");
>> +
>> +	if (mclk) {
>> +		unsigned long mclk_hz;
>> +
>> +		mclk_hz = clk_get_rate(mclk);
>> +		if (!mclk_hz)
>> +			return dev_err_probe(dev, -EINVAL, "Failed to get mclk rate\n");
>> +
>> +		/*
>> +		 * This logic is a bit backwards, which is why it is considered
>> +		 * a hack and is only here for backwards compatibility. The
>> +		 * driver should be able to set the power mode as it sees fit
>> +		 * and the f_clk/mclk rate should be dynamic accordingly. But
>> +		 * here, we are selecting a fixed power mode based on the given
>> +		 * "mclk" rate.
> 
> My assumption is that someone had a board with a fixed rate clock on this pin.
> So it might not be possible to have the driver do that adjustment.
> If anyone ever adds that support, we'll have to be careful about handling fixed
> clocks.

In order to use an external clock, you have to program a register field to
allow that. Since the driver isn't doing that, we can be sure that even if
someone had an external clock, the driver was still using the internal clock.

> 
> This looks fine though.
> 
>> +		 */
>> +		power_mode = ad7124_find_closest_match(ad7124_master_clk_freq_hz,
>> +			ARRAY_SIZE(ad7124_master_clk_freq_hz), mclk_hz);
>> +
>> +		if (mclk_hz != ad7124_master_clk_freq_hz[power_mode]) {
>> +			ret = clk_set_rate(mclk, mclk_hz);
>> +			if (ret)
>> +				return dev_err_probe(dev, ret, "Failed to set mclk rate\n");
>> +		}
>>  	}

