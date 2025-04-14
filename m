Return-Path: <linux-iio+bounces-18088-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA66A886ED
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 17:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12E8218950ED
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 15:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB27427586E;
	Mon, 14 Apr 2025 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qKog0Iu9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484F127A923
	for <linux-iio@vger.kernel.org>; Mon, 14 Apr 2025 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642972; cv=none; b=LfUrolCve1SuKFyCGQErMd3KTQIw1GomJDLeTVyHB7VZzPUP/J2cDUSG8wOeWYlrFgQ7tp9EKxLze2YiLsfEQ8wRPY+KdBeAMUp9xVDuV/Y7Qi/iYA+MTU5Hop4ryk+cp5cUfEseYRgLiby/y8GAPzM+uOFG0YvPZFsdKfjYKs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642972; c=relaxed/simple;
	bh=4k/xof5OQp7PIVTQYNQCGur66hRPvIJqafxT6KmwVEo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hMMEPG98PZt2a4YoxjY+fdQ4gQfRo7PvEsKktNNMd57wTWeUSHabRA6Z8gdXiDo5grbMaIvWLZQjDmnz7DQmVCkJDQpigxg3zQVb0fhTRzF/Lb9m4yqQ7GnpBkENI6gQd0yE4pOq5UpOxph0KjCCrnpkfb3HrfPyG03IDJ5MVcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qKog0Iu9; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-60400013960so1026410eaf.0
        for <linux-iio@vger.kernel.org>; Mon, 14 Apr 2025 08:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744642968; x=1745247768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sS4Zjvq3sJ+eWVkmWgf8OvoOhv08fRRBCISkBnmL1FM=;
        b=qKog0Iu9jZ8XtBQZtEsf03uebxAqjGqUoaJbQ5xNFSxf4DnonxzOtUFT6q3XqHpaHm
         ZjVE+DwJ1Fx/nMCxDCWTrQmPLcaO/iuwvp6xVcT77dRG257p5EiX3Div/5WFmdRniyjn
         p7crDRDBazKkLbqiVo2/QY5StRP7ew3tRugmsUj3uKwuuI/9FO0EBW4iY5LCiY+P9Ih7
         RwOXPG/8E/K2Na1doDsjEGhtDP6kyvHluzaLRIEc4YqiY0G6UTpzD/Mlp0drH8zakuHV
         TrnQgJUbhQxIqQ+9G0jE1Iap2wqWAZ8Xd/mInSOsBDcd27/aWuwTPlDmRVoltpIe342Y
         pmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744642968; x=1745247768;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sS4Zjvq3sJ+eWVkmWgf8OvoOhv08fRRBCISkBnmL1FM=;
        b=Rxfmu2YukfbbwJ84lGaAePLBEAD8G51HkpVe4kr0J8bXqdsRfaRfVU4zLtV+C0rBWu
         mBbb7zUruNnYhxqnzE0C4+CnzuyJfd/+zBr7eUS9iitVFp23FaeHWcE2+/PDmzhIH/TW
         R9nUI1SafzhseHE9mnfQXwu4OhKhT5qUg2WUuJFTXqwHvjLhcVVuUYXqUHhCfRbEx1Xy
         UVB+txHDzPk1N7DtK1KEF//v4IZx7XxcQGrIOz92Y2U3hBbE7Sk9jR9lz9n7gRi3h1u4
         MJT8EhpiYbUP5pyIrGx1Cf2nNhWu+7dfaOqesA0MZdsucXLabN3wvukBFRzQWWPxA9K1
         4JHw==
X-Forwarded-Encrypted: i=1; AJvYcCUnUJwd+GR+hOCv2INy8v0hgIKbYyeVxstJEpO4PW/jPedYqfuBdX+649pM+Ar8BEsfc9hagX2XBHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwscFg4z0NBeA6X7ZpjJhPzOrN7IxrPk9NR2WjYZSZSRMvJh2aa
	loC0af4yu+6yq8sXB+jI0rx388EmufC7oTklCku/4/Er3k/W4WoLuTzSzotZwP4=
X-Gm-Gg: ASbGncsUWj5WbJA463PAo6H9XBzmNZRbklNICf+GU3tbK3KDH1EwHVEPPYQdCwVXxR+
	B+P79bxDgl75Eorl0SfimTG8ZlpPOE0NpD3GzKWyFHM2RW70E8FXgkeEYvBS2qIvd2awPWuN2X1
	gkLL2J+xFJvH6KfeGJOPg0/hxtpIRcf8Ni46Ukf7+1LORrzgvHSPY62HQSMKuBv0LosYBeJviZa
	dO6U/YS5yWTuaN4e52bVztGG+9H8lC2COt1nBuHfCv8mAeiHkjt0PHfXd2Cw3GBsxiRVC9fK1yY
	6QN6QdR/kf5uLrOqofKv0X4Gj2x/fpG0w9G2T3qchBHxW4PnN/59A+1j/Z7waF+kDJlBiCxmB4t
	1+dAXI3gnVrCXA0Lpqg==
X-Google-Smtp-Source: AGHT+IGge1vpcmLU7HQnnhk2Pd2GdQcITC0JwJErpepL0AlaxCPXrAcAXrwLje0ymi6nTKAEBpYLOg==
X-Received: by 2002:a05:6820:1e86:b0:600:239b:c1cd with SMTP id 006d021491bc7-6046f59b874mr7612300eaf.6.1744642967977;
        Mon, 14 Apr 2025 08:02:47 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:442c:b496:9db4:da43? ([2600:8803:e7e4:1d00:442c:b496:9db4:da43])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6045f522fffsm2020557eaf.10.2025.04.14.08.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 08:02:46 -0700 (PDT)
Message-ID: <25db1c97-001b-4b9c-bc57-879fcd0abb14@baylibre.com>
Date: Mon, 14 Apr 2025 10:02:44 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: Correct conditional logic for store mode
From: David Lechner <dlechner@baylibre.com>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: gshahrozui@gmail.com, skhan@linuxfoundation.org,
 kernelmentees@lists.linuxfoundation.org
References: <20250414140901.460719-1-gshahrouzi@gmail.com>
 <0b1b428d-9ad0-4581-a13a-88f4ffd6c4e3@baylibre.com>
Content-Language: en-US
In-Reply-To: <0b1b428d-9ad0-4581-a13a-88f4ffd6c4e3@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/25 9:59 AM, David Lechner wrote:
> On 4/14/25 9:09 AM, Gabriel Shahrouzi wrote:
>> The mode setting logic in ad7816_store_mode was reversed due to
>> incorrect handling of the strcmp return value. strcmp returns 0 on
>> match, so the `if (strcmp(buf, "full"))` block executed when the
>> input was not "full".
>>
>> This resulted in "full" setting the mode to AD7816_PD (power-down) and
>> other inputs setting it to AD7816_FULL.
>>
>> Fix this by checking it against 0 to correctly check for "full" and
>> "power-down", mapping them to AD7816_FULL and AD7816_PD respectively.
>>
> 
> Sounds like we need a Fixes: tag here that reference the commit
> that introduced the bug.
> 
>> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
>> ---

There is also a typo in your email address in the cc: gshahrozui@gmail.com 

