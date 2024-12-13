Return-Path: <linux-iio+bounces-13442-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8244F9F1A40
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 00:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D12188E35A
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 23:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46A11C07C1;
	Fri, 13 Dec 2024 23:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Uvyt9x9+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6171B6D1A
	for <linux-iio@vger.kernel.org>; Fri, 13 Dec 2024 23:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734133392; cv=none; b=Zijitg0qtHgP0QgC4+uVRAYntBO6hBo8K0zfTfN1q+BnQ345AyT7keWrJkIAC/qm9GKpcrMEvEeihAUZtc6GnvCBIRSXLMJ+Gj3ZllmoQvyRQupm/VFCwP8Ak9Bd5sGIaggO2cnkFOn1IBwZaeNvqJkzh5uqYRdYYGF6RQa+BU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734133392; c=relaxed/simple;
	bh=g6LzPVDAC/w05vA9m81+JnaAYi9R2afMBfHb5xaaD9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ehy1m0LDjhZ3ui2ZPqvOHgFmynOU5BWyDqOeV0yI7hFhiBM/kDviKLK1mLfQLJiGXPw0E4Cy4So4TkLwkJNfFq51w6lQHVhHe5SHB46DfA1d4VYyWiFm6sUnqLc1YkYgbQszdDw7APhlMgH8cKKslpZQI1Vk7VZaGC+2KsKrmK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Uvyt9x9+; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71e157a79c8so597160a34.2
        for <linux-iio@vger.kernel.org>; Fri, 13 Dec 2024 15:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734133389; x=1734738189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kAixFUvh++BurSMkwv5vN8338veAVkTLhHRp3R2yZxQ=;
        b=Uvyt9x9+ZvL+2YVCKqyu5LtcrpE8s+mfqibir6TlhtoTq7vnZKuj+Q0iMSQ21YkDgS
         tFlAg5JQZ+JDEOiV7EFJ//q6+79EapXttLygpGGzdVPbqsApmyP9VfrH/efK51o317IW
         I4hEOLUbs4UC1ZTL9DpGdXU4ZIjSt8SQTKOkv9fnXTvyHVdnLXhuOSnW5thqtKFkcSTq
         zHTBnz8qVOCOCsbngPeDR4pJFozwfOM9ldkSY38S56a67AK8OIGbAWRhAvg+cGKnK73w
         56gOEOKyY6QZXqfaVD9xqy+zqzfGBclhegOAdiIKrjMS2/x5zLYsN77onzQ6v3QcnTYY
         8Prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734133389; x=1734738189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kAixFUvh++BurSMkwv5vN8338veAVkTLhHRp3R2yZxQ=;
        b=MrcNpoP9B9thTQDnMtFHMpOhPV3p2KzjfcLbmzSmwwI0/O/svsSUJCwheh7+J+tWlx
         2MTc6p4H6opiAPdddCk6YlE9SAuMpNUR7BH5paxg1bZ4/dB8+eTn4AbayFT0m3+C9ViK
         xeAWuuni6uKFRLJiiUU+3RIn7yi1PfZTIAfKnQAvcaehzD07DMrTzh/Mci4hCiWjTwN0
         3CN+otBUKCXBsywQaJh7hL6wiRMkc/DpYONc0atthzHh8G8tsEoSEIl/6w1iFLxeJaLO
         n15pAwN87jEmusGMK8cMTs9Wvn2ruDMjzIFGEB574sZ1d50ZqFn0el1j5isbDIm4jo2k
         G+nA==
X-Forwarded-Encrypted: i=1; AJvYcCWU98tH+iyHsijZYLVRAH2tjv/ayE4B+ZgjKLpcLUn7ifeUnOgFOlSN5Ab+gVOgQzSPdbp0g5M0A+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtNbqbakTKGd/UnC4TQYvkR6G0WsyvJOpez2aFsmEb3e/GXXu8
	5GfLH1vc3/j0iGHMg5dFPTIROCeg0sQQLC6EpWrL7GRt1w5IKCgRcwfMshld/Ai4xORpYmt64jH
	M
X-Gm-Gg: ASbGnctBxnHCKVfUtP3nzJotg+pl6/x+qgLOpSPlWZfMUGD5THO7IWwKmZQyJXLryg4
	pmUIb09Pr2sgKQjHhKFLHbxJCU6d2YFx7nVkC971TNZeQ4cSrDYvIqanC1GdbISp79/c6qGNtCu
	jXG5sp52NC5vWkTGd+XoUAFRGZrfy7NuYHEXsACK0c3ducGxHZGkuOAKxEMkiLPcX5QH/MavxR+
	0CQJWg1yir5DJoGq+n4GleleGRJqYVzwnwelYbz51SDk34xYviAH/NAX3UfFPx4nhHT+vH47MqZ
	XmS8+icYYH7wBNFO5A==
X-Google-Smtp-Source: AGHT+IHNZOV5c740YHYR+v0obhIdti/m3jkuM6vF+0vNZPknqgd1GPEaToKR/m8TrGe5zgpMrsnlwQ==
X-Received: by 2002:a05:6830:258c:b0:710:fef4:3c92 with SMTP id 46e09a7af769-71e3ba26862mr3269055a34.21.1734133388498;
        Fri, 13 Dec 2024 15:43:08 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71e48370f23sm157126a34.37.2024.12.13.15.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 15:43:07 -0800 (PST)
Message-ID: <2f7c5893-695c-4633-9142-10e70c1b3220@baylibre.com>
Date: Fri, 13 Dec 2024 17:43:06 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/8] iio: adc: ad4851: add ad485x driver
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20241213164445.23195-1-antoniu.miclaus@analog.com>
 <20241213164445.23195-8-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241213164445.23195-8-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/24 10:44 AM, Antoniu Miclaus wrote:
> Add support for the AD485X a fully buffered, 8-channel simultaneous
> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
> differential, wide common-mode range inputs.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v8:
>  - fix kernel bot warnings.
>  - drop optional members from chip info struct
>  - drop final line continuation
>  - drop ext_scan_type and num_ext_scan_type duplicate set.
>  - create common function for parsing channels to avoid code duplication.
>  - add comment for fields not set in the parts chip info struct.
>  - add safety margin for pwm duty cycle.
>  - use FIELD_PREP where indicated.
>  - use chip resolution instead of chan->scan_type.realbits where indicated.
>  - move the reset procedure before setting refbuf/refsel registers.
>  - use iio_get_current_scan_type where indicated.
>  - refull and compute scales if osr is changed.
>  - take into account the osr for the sampling frequency.
>  - drop num_channels division by 2 which remained from v6.
>  - drop ad4851_scan_type_16 since it is not used.
>  - change sign based on diff in iio channel definition.
>  - shrink same register writes into a single operation.
I'm a bit confused on what the intention is now. In v7, diff-channels
was added to the DT bindings but in v8 it was removed again.

Did you change your mind internally again? Or is the intention still
to specify single-ended/differential in the devicetree?

It really helps reviewers if you include a cover letter and explain
the reasoning behind big changes like this. Otherwise we are left
guessing.

