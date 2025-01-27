Return-Path: <linux-iio+bounces-14642-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AF8A200CA
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 23:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D412F1885C0A
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 22:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E301DCB24;
	Mon, 27 Jan 2025 22:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ig2stEPc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA2B19F121
	for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738017819; cv=none; b=CrAZDnwFRRsyC31al7vMUJY95AzrLG6xgpwEuG3qYgvY0Ri0AAPxZUkGrqdBznEil4f2ibvbd3spS9X9krrIaMJ47E8kObcuAwdDieiOwqrHS+QYf1lQE0AKPczhFDBmjkcj18yBkJuIrhy3nz4tEq+tP8yNW2rkfm7Vmi1wG5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738017819; c=relaxed/simple;
	bh=nZ2PZDxOYffw3fIxkBpzrvJAhv3ukfRuhS6Z4PMFvig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqMACSHZtHiSX421TCUzXip7hWC00WiUY8xzY4hYAotPLkR1y9CvA8KuDJdek9V+63W3azEX/Yrb2XtPLqCnaxeZUn+G1jfwOYfyJjxuHag6dRb9I1qD7edsEG58PSWD7OsVyC7Ol+3p+ITqClO7B8jdCDMbusyz+WqqgVdQrwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ig2stEPc; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-724d1724657so3108710a34.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 14:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738017814; x=1738622614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zDNkNEpdnFoXUQ60eecA3sCT3Ukoe3YW3y86FzhMNSo=;
        b=Ig2stEPc9y/b0cYNyCeJ1D0sqpPQRAj7i6f5MyzXZW13sMPKsqyIWXnPux262JI6zE
         1AGzynUI3ATgrkag5Ji/XEkZ7P8SxGK9LNfU0Jopw10ndGo1YYDGoy3LpCFjbLHfo708
         3rf8FqyK1ZQ41NIsJPSmo6jeF7CSAoYWHIs4kONzVVR7t9j3ihx0yV3E8rbhhnzheFJh
         +UTyPItc/nHOT2PxjzeFg+2nrx9iHHfWnSbBFWaSEH49T5Ra6XGCgJm287RWcPwZWoTE
         0mpHSiPqWSSPG6R8Y2twkwQjaxx8buNeKe7kwhmJaVlcOtW7yP0cT24GvwIk8g33rVCg
         NkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738017814; x=1738622614;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zDNkNEpdnFoXUQ60eecA3sCT3Ukoe3YW3y86FzhMNSo=;
        b=aJqEPX6jxJMvlNAdkxm95mwTV5YU270SXxQtc1tdvV68tb4wLbUjnrFYZ3Wx6JAf6C
         CS651Nxga2m9UpYSlrLsovsBAkG08bB4/2WIguyQFQOCmDbcGM8FyNYWJbhIUDybc76l
         iaBJjtLXWjXtOuZPFy/FjqZD25s+LWeAIyhtwy51PjlmIbvP2Ff0TSZrubKsDHnIl2bZ
         52WBnv1YVGBKAL9WGa2dWfMadYtdll6HrwR+QVRNjvYV7IaWHeJCRznHNDzP/EJ63J/u
         X/ueVRydhMa0AmuJVhfodfZpYEzf0owwkU9tjCeeMEk2betDsX+d7nNAWiL/YwCrHY5j
         YwaA==
X-Forwarded-Encrypted: i=1; AJvYcCXvU+57VktTpHvEgKWJPZvDwubyLScsxXLbGLSklbIzRYvQXwcwsPR8TCC3llh62krffyjkJsMvuys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJYHkUjlZaexrY+XHe/BE4aRxB/hjHWYrm1cDEjSbwmqlUalGu
	xyNGFd5hs9nSCvKqwdpUtS2uO1joyWzcseTaHEUCJ2IDI6IKtxMDSUdlRnzIldA=
X-Gm-Gg: ASbGncs4b1X+IEkUPim/0EGVWo8gLyPaNwP6kER3Nh+vbJ0zhSV01XQO7q2AAkXEAVz
	INmazFft1g9LLoh2smmZLZdwIUBNCvjnccxq//8KISWrmtcMNQB6521C+oCm2ZU69GSKt3MKS5S
	HvZfq/WZgBTa2kY/bzpPxoZApB1amqAx7Fp+3Yy/oGbKUIPJnnqNy3+zev4EYVa/WOv0Qdk8nTh
	g1n3eEe4SnN4tO5Se97Yi3Aum3RHdC6TPNDPMgWC3IhfX9HBQ0BEoNTlOUqOXisqpIwlJ2+eW+Y
	7i87TgxHYbyWArBdWJonGVpRjzmUFkA8vomP/HBbyw==
X-Google-Smtp-Source: AGHT+IGG0EIXQSanj4mI6ftrrsuaTgRbSOGy3aZ/Tc95s25rH1GouqvtWdjuyaKysgGDS1S+BnO9aA==
X-Received: by 2002:a05:6830:6184:b0:71d:ef3a:815c with SMTP id 46e09a7af769-72648bd192amr693896a34.4.1738017813886;
        Mon, 27 Jan 2025 14:43:33 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-724ecda4c98sm2540532a34.7.2025.01.27.14.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 14:43:32 -0800 (PST)
Message-ID: <3f3bf49e-0797-48e4-a2a9-25b9ad79c174@baylibre.com>
Date: Mon, 27 Jan 2025 16:43:31 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/16] iio: adc: ad7768-1: Add reset gpio
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 jonath4nns@gmail.com, marcelo.schmitt1@gmail.com
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
 <722340b0efff3ed22a763ce6581c96ca403316d8.1737985435.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <722340b0efff3ed22a763ce6581c96ca403316d8.1737985435.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/27/25 9:12 AM, Jonathan Santos wrote:
> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> Depending on the controller, the default state of a gpio can vary. This
> change excludes the probability that the dafult state of the ADC reset
> gpio will be HIGH if it will be passed as reference in the devicetree.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

Since you (Jonathan Santos) are the one submitting these patches, you should
add your Signed-off-by: here on the last line since you are the last one
touching the patch. And if you feel you made significant changes on top of
Sergiu's original patch, could could even add a Co-developed-by: line before
that.

More info: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

> ---
> v2 Changes:
> * Replaced usleep_range() for fsleep() and gpiod_direction_output() for 
>   gpiod_set_value_cansleep().
> * Reset via SPI register is performed if the Reset GPIO is not defined. 
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


