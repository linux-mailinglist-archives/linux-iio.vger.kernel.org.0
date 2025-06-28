Return-Path: <linux-iio+bounces-21064-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C689CAEC935
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 19:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A103F3A4E9E
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BCB274672;
	Sat, 28 Jun 2025 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QCTFRdAF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E59025B69E
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751130306; cv=none; b=PPJNCl1QlHkhKupupQZ+eoCNLa9FWurH/m3eVSn7XMWOX6iNbZaI05G+IUGN75sL+zjp7k5uBM4P0gu6tTWY1ASkoAcbaP6fAOJZPya8SEHcGJbsRzene7Kh+joj/dzWrLWkdOh89SVvYs9f4FC34MG3/xDwD0EU2L+ku7fi2f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751130306; c=relaxed/simple;
	bh=+dp6ybXMtlqHhwnP+WfByZrCcE8QMyxosUcvXcXnEX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5ggOL7uEY428OyxUXdUxx0GGGqXAkzygdLIbNRGfNSaRAzudpaCRxbRS0kdoi3dB2fzBq0nJQPpbNbM+uH7SaUBq2OeT7UxlZcG5ZQTbbzKiPhxBdQ+H7X5WFLPd/W/tpM/M7cSk4T298UlpCtC14+mKaFdG9gl8vlgVv7W/NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QCTFRdAF; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-73a44512c8aso792693a34.0
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 10:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751130304; x=1751735104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sKcbmQtYAI4f7gKXtohOTLyE8Sg7ZI8YjRzXc1wJU5c=;
        b=QCTFRdAFI/KXnSlJEpYsudzJehWk1XtwwoVFg8LAErCtIahjXq7QbvLZC1SIZx+xb8
         uRHLZMlrnZ4MQV6xBymZvvn3JfGKPMRU6CppOFotTpJ54ADT5Zr/xIcDJUDTMwvt7Gas
         0dIE05+VEC1dkXHfuwvqDy9sjrU3dlG8Qdcx0MmtUOS7xllrmRX1iOJXcQgiNlWaIAAD
         yB3pmCPAvxc80hd3Wymj+2QpRXQNejH6EYnjTgvbexlCnT6W6URuEuOpgOj3P258Ww0s
         twsnazLdyilpfzG0WzZsZOWXU8oHwid56+w/vBbEk5oCzh1VjjEGfSWxSr+EH0yDvAZb
         Gpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751130304; x=1751735104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKcbmQtYAI4f7gKXtohOTLyE8Sg7ZI8YjRzXc1wJU5c=;
        b=k2UYSop+ydw5Pi93tOI9pshc6a5Rss7hgooS/8GjeFgz+mhgypkwFKoAODon3IPk24
         E7JsIy8g0Qn2vFpyL80LD140MqHfwXx/M4lRWnzCVY0KKHr8NAoJdVOezq+l3lfkcIgu
         stXgsGvMm0tuLUi44KeNqfNAFsp/Z4gFKnFCMSkEK07hGyl/PQZM8XSCdXbZymjLt0L2
         RUXVCGjMHI71nJsQlm964AY8HnlGMXMjTkeOK+Zd/Af+Fc3smmSimfup6gIpw94w0QdN
         6SHcUaqp6aLA3kBx4iXuWKbT3qHjkPzGuFtT4bon46vRFohcny8B3aqWREdcmu8vA4hH
         VDcQ==
X-Gm-Message-State: AOJu0YxRBcoZpmVlThYHfJn8fldF9tOVkYOS+8vyizPQ8HjZO2JxzMrF
	yBm+i3Yc3YPd68k3UJMeXFHyy5nlvyS8lRk5BttBK/KJ+MXAm613Y1GttUO5T9zf/UQ=
X-Gm-Gg: ASbGnct3eppexfvJ35uEuRsMcHEJGF6+9XMFGN5ARErLhIQuFDoy8vW9QpLvJnyTLAO
	ThV+0ihw8A/tqgL1ZXTwZ+zJxryjMyUcf1Ha4P1234lzgSQq5Pmi6/CX/zdUi1kioW3gXM1mq6U
	nVXjGlGuYnEMmhIABVtASKR8/darSdLSBt6OzVVD9v9dhicpsDfGInjLNIFLPiqEi4IifVwHlz1
	lUsgfzkIeo3BMZmNYuX/ahlc/7CzTSETyosOWZvVSCY0P5aL8UG7sXAWjhd4xtj1FOFai0XJXVP
	pncjMINqx8sx2fv0KRVQ7k+grayA2o2zCZK1o0xETpOcaQAa6JxJGMomCaAALsg+2W1AnFsaY9F
	oiwhjO4c7+IFdqQ9/pQGxKGFDKmeA+glNw5p1WjaSBblhhV0NHg==
X-Google-Smtp-Source: AGHT+IFJ/JVoBiehU76W2KigtYxFPuuqBSmL+XctPUDbXP1ihOU8h3P+Qo40YRnaK40PiWs+aDA4dQ==
X-Received: by 2002:a05:6870:b488:b0:2ea:1e5d:8ad3 with SMTP id 586e51a60fabf-2efed6782cbmr4697161fac.22.1751130304231;
        Sat, 28 Jun 2025 10:05:04 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4? ([2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd50f7d89sm1612370fac.34.2025.06.28.10.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jun 2025 10:05:03 -0700 (PDT)
Message-ID: <871eafac-f643-410b-b201-681551075a2c@baylibre.com>
Date: Sat, 28 Jun 2025 12:05:03 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: amplifiers: ad8366: make ad8366_info const
To: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250628-iio-const-data-12-v1-1-88029e48a26b@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250628-iio-const-data-12-v1-1-88029e48a26b@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/25 12:01 PM, David Lechner wrote:
> Add const qualifier to struct ad8366_info ad8366_infos[]. This
> is read-only data so it can be made const.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> I looked into dropping use of the chip info array in this one, but
> removing it isn't trivial. There are several switch statements that
> are using the chip ID still. So we'll save that for another day.
> ---
>  drivers/iio/amplifiers/ad8366.c | 6 +++---

Replying with the correct subject. I missed updating the prefix
from a copied commit message.

Should be `iio: amplifiers: ad8366:`

>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

