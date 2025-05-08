Return-Path: <linux-iio+bounces-19350-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A45AB0528
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 23:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCF44A899E
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 21:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2840221D5AF;
	Thu,  8 May 2025 21:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VZz2Pt98"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA53020E01B
	for <linux-iio@vger.kernel.org>; Thu,  8 May 2025 21:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746738199; cv=none; b=mr0Kd36MPCLNCDlJvN2WNxkjFgDlyETo8XjZ0OgteVY9ecSVAMjzMFK70xAT6HDMyoTnitQhANXDvKwWEz907o3jAfDQf03lBdc+kMJa4+dCWiGW4k1JtUyKpyq8CdP0FZMtHbA6blVrFEf85pB25ELPaozujpFppu1HSPGgu34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746738199; c=relaxed/simple;
	bh=rWxpeRAeXokicQJ9Z8YfpiwCtuYvJRRE87ezbLzZW9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8YXdui69oG7738zGZl7xaQM+FMG0d1XHRMN0HCX6L4noThfBHv3E0AuT9HKq3g8Y53vHOZ/ECRsWLeH9rC4Tc29N4hcu8fP7yM0FKRLHY9/QvvzXc0y8jSr8/xZsO0Db1FzvNEAhhfhy27gXZlisHY1oJr72xQkf/ltXMJzwhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VZz2Pt98; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-731e277a6b0so1358766a34.1
        for <linux-iio@vger.kernel.org>; Thu, 08 May 2025 14:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746738197; x=1747342997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rWxpeRAeXokicQJ9Z8YfpiwCtuYvJRRE87ezbLzZW9M=;
        b=VZz2Pt98P7hv1U5XhOx9YXs2wjORr6ArZ7pt/dm04Q4JdXPS+97tLuLSm26vGsJ7a2
         /twLG3gLnbWuby8JNcCv5CeL+QXmuhUx5d6GPsz+5eX6ujhVEnhSBgfdDp5iuWPRTlWi
         D1lHtn1zysSGtakrMjnTIGdCEz08YbvojJ2RB4z6d11gP3l5oHIdViRK0dUE8s/9PwBf
         zxN3QAylR88Ip+5tvg9SS3kaM/dNvgbBDqu6I2oRLUjL5ppyhGe4YI610HppFUF27TKf
         KWbjP2qw7FC72iOb0+gu5RYzDeSS9PM2126onSQUJI99ji8Ea9FfKr+gmoTWE4Jo0hoe
         1TOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746738197; x=1747342997;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rWxpeRAeXokicQJ9Z8YfpiwCtuYvJRRE87ezbLzZW9M=;
        b=jAto7qB4cHoW+D9xBFOTdeY+wHtezzfY7mTpCMydr+oSCGU4Z85wzKVbOEF5y7YUaG
         qOk00SxMvLt5jeuE5umLhkTGtvoGxsUtryChUuZ46yVEQlei1LoXzIBMx241qLouyMlz
         bVr3EWywrr7XovDiANDUA4HObuvjwe1YgfGKf+rEBjitkI9+H04e0XRrQ7FEzipXbeg4
         3bOw8eC8HIYgV7KAFxZMU2lDcu2dHPLhkXWobNG55PHqdFTGpA++pecPrRCetG+uoHOD
         vJKnbNMY7fT1GgQfUCowkgZ5nfJpZS6Dj5xB4qv08DMU8JLvtIEJnsf1w2UNPZLq1/o+
         tx6A==
X-Forwarded-Encrypted: i=1; AJvYcCWuwsJcxq88475p4Z3PI4SsHzrMevtGoMD9Fn9piJKTSl6/8Io+42tcl2CGZUNFmwbCPbo4fY2uA0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUnB2cq89A5IDSdrfLaBP6jYlQLMiV6FuyGwfgvuCietQb20e6
	CBMe6I6zFqpZfJmW79AzRll1c1LIBNBP2kNAeu6POqhu/YXnyv7imgHlECH6XBw=
X-Gm-Gg: ASbGncuMwEyWF72wnAlXGx9QZUquehZiI1XncB/Ud3ww+CGzKLDjEwokukGHCTQQNLd
	rB0d2hfF6siCafMXAGjNlWMl9vPFTeGiVtD2KpEs4o4l+7GHrzXE4sXXlL5aLZNoRX6TIeNo7EV
	ssRc0PggILa14gkBn2lRILJ/2zJkJ4wTryuPF+zPC8E4ITqrCV7oeovKx/jVtM/YJaoPhHIjkAB
	Fg0jubrmLYsfoikx2iIuvIDzlTbmSj08ntWYKrLQLpPIPX3ZgsztjNXZwuHrj21/whl3qc/6XJN
	i6P+cC8OmtXyYzu0sV7eP0LUhgNNXEJX5VOL4mk+7fTFitlzEzaSkLBW/8I9wCKyhLX/henj9wI
	Hv8h89e3TCJFjXYPeHQ==
X-Google-Smtp-Source: AGHT+IEr2MMqka5WLWK141klkGruo+u/j5u6j5rFw3buPNFlhVeimGmuRGD1CkkswVo8yYYli+ZYcQ==
X-Received: by 2002:a05:6830:c07:b0:72b:9f90:56c5 with SMTP id 46e09a7af769-73226abba9amr705432a34.17.1746738196962;
        Thu, 08 May 2025 14:03:16 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1120:d1cf:c64a:ac7e? ([2600:8803:e7e4:1d00:1120:d1cf:c64a:ac7e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-732265cd8e7sm245468a34.47.2025.05.08.14.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 14:03:16 -0700 (PDT)
Message-ID: <26d10040-08bb-4ec7-a438-7b4618df0a4d@baylibre.com>
Date: Thu, 8 May 2025 16:03:15 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7944: max high bits on direct read
To: Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250505-iio-adc-ad7944-max-high-bits-on-direct-read-v1-1-b173facceefe@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250505-iio-adc-ad7944-max-high-bits-on-direct-read-v1-1-b173facceefe@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Just realized the subject is supposed to say "mask", not "max".

