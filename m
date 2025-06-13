Return-Path: <linux-iio+bounces-20604-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 215FAAD90B1
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 17:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA8E3B7C7A
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 15:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BDD1ADC90;
	Fri, 13 Jun 2025 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2TDEHV0s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDBE15573F
	for <linux-iio@vger.kernel.org>; Fri, 13 Jun 2025 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749827021; cv=none; b=ph1qA+f8Ovsxow1c+pI42fUcZyiRJ/hF/c4/MrUqKVyAGXKRTIfswC+decH4vrqTkLIQ0InScoQmE9c2Uh/Ou7xarnw/iqQBdr9MsspV4rNCTv1ckcC+ontXKNg06aaoMRkzbHzhT6a7P6SkzkfxkVGk9Z5RnxzlvYzqGSHl3vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749827021; c=relaxed/simple;
	bh=pfi0cAVHQN4FKBTbdkOEyZL1+dTywvqOTwhrmU5xJ6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/mQk4e6do9r4XlMjjL2z37W2MrebYCW1Jv3XIAcmHQqfppUQH0S4rVzMCSi9oc4LWOhvvkF+Q3+zID4vjkRR4Za+z+Sfb9iC9JFFXxAAWuF2rbX2Hd5shEWQunEnX50QK0WpyDDGSnodRMf78OD69Gk7DFc074VH6UYq2qheIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2TDEHV0s; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7306482f958so1473675a34.0
        for <linux-iio@vger.kernel.org>; Fri, 13 Jun 2025 08:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749827018; x=1750431818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5PIfoLs86QX7qYXR8hEvBNfkC/r2PihnWpdbTtofWd8=;
        b=2TDEHV0sMJ2lhYeM7RXYUtWcJ2v8+K7zyDOrD6mDTz4VNqBQ39u82GFu0vROxh2U7Q
         ZWF3oMQMmVC6qqyzMC+402DWipKUtzP7f47O5Fk3SB8RQk6qvERH3xQxDEy044LW7mDy
         WwDCvKC8elQWqr26G6uMAZg53g54sekgMNPYIdN+vRKg/qcXZJPgGtaYCUCoGBIlyOcx
         HFjEnapPC6A4nRFviCS5C3fuwHiR5/J7FD1Lx7O9WlXGaOJ+j0s5MrBU+5uKAMQOWar0
         aE+jKNM7n0E5iZSRw/KwQEntkZ4c0hN9zYTvRxjFfoumiFPwh94RmTBBfcZXkj60VGrF
         TvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749827018; x=1750431818;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5PIfoLs86QX7qYXR8hEvBNfkC/r2PihnWpdbTtofWd8=;
        b=HMXfWQeE0bInobCMTNJ5YtRqVu+cJbe6J5S7SAvJceh1pj4VB4ptpj5ZJ5ivm90LGS
         YkU3UdTn/q/zezuHHRl3SI2zMTm1wmUHqxGN7Up52Eipvh0wxdKpAFtmGrbf6HkXuZZT
         R5UvGeOfJWXwTv6GykIRzyZ7mXLU69FqNr+yABNbfVV1/baVzMJcRBUhzjp3fpQIAPZw
         26eAGOyH1ne6d0xPitkwml+jNT7JxsaGAyHNMAwRPOXb/UxGlHQOKlEPjqI/3nPmJJAB
         6pOvs1UCOb+UAK8K2QGQmCGFZiyo2VuuqPZIN04NcTxd98/nDL3jttUtmXGesUiBzwTB
         7KDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO43Vtutl+tgRWtRHC0z2eG+kBxMgIef7ZmJor4E1Y9wWIafWYJpHhqELyD1JEBUEL9smqa52deOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw2Cz6uQ0xdECimLfjSWxoSa1vCOEXZ6sbyHrGR2lrktQ+t++o
	PO8J1bpK4KlDdTPxBrxC03i5gkmRQ3mpm9S3H0HVgz9CjHrGFwSddmOq5uS2B5Goy10=
X-Gm-Gg: ASbGnctdVY5OqEt7z3Z6l/aa4GIiCdiqL+ulThXan9dHiAcfTpXOiomKfzR1/kgpOMz
	vJ1lHQbbH5kaJUMJY708M3B3QUdBlJFaQZnaWB98bMfQArwey/X+EB1m652LYZ1Kxd2ciYJgdC+
	Nhai/EY8h6ywvUAUDTff3szNqMujkDJzr9FjSRpp9kgusZAJzwrTiNBEjTU89yanoy44+4kvvIJ
	WsU9O+elcHbOzY02xiDc+Lm5QeSwfgN4kzCPQ3VZCRbhtq4AJrmX8P5eGc7cTb1kg1vjmdQMxfc
	1bAojJQ8KA8Yg70q51D3KsvOn81g8xkN6PFm8WeeLdsT81pEW4NEix7k3r0V6s5bXqShlxWDOwU
	6TuMzVvTGRsSfb3nSDOBeMlQnJIgJr+SECSL2WoDgEs50AgM=
X-Google-Smtp-Source: AGHT+IEAL0ZDPMzjcA/VBiibBkDYEcstjdnXKAWJLVzjTIQf+FnUi+iN07J5DUfE0uU08QRa3dplKA==
X-Received: by 2002:a05:6830:258b:b0:72b:81df:caf9 with SMTP id 46e09a7af769-73a362cf271mr42624a34.8.1749827018337;
        Fri, 13 Jun 2025 08:03:38 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4647:c57:a73c:39d8? ([2600:8803:e7e4:1d00:4647:c57:a73c:39d8])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a283dc101sm230838a34.4.2025.06.13.08.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 08:03:36 -0700 (PDT)
Message-ID: <8f7656ed-0a28-4ba0-accc-b19817bbb38b@baylibre.com>
Date: Fri, 13 Jun 2025 10:03:34 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: accel: bmc150: Do not configure IRQ registers if no
 IRQ connected
To: Marek Vasut <marek.vasut+bmc150@mailbox.org>, linux-iio@vger.kernel.org
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Julien Stephan <jstephan@baylibre.com>, Peter Zijlstra
 <peterz@infradead.org>, Salvatore Bonaccorso <carnil@debian.org>,
 linux-kernel@vger.kernel.org
References: <20250613124648.14141-1-marek.vasut+bmc150@mailbox.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250613124648.14141-1-marek.vasut+bmc150@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/25 7:45 AM, Marek Vasut wrote:
> The BMC150 on Onemix 2S does not have IRQ line described in ACPI tables,
> which leads to bmc150_accel_core_probe() being called with irq=0, which
> leads to bmc150_accel_interrupts_setup() never being called, which leads
> to struct bmc150_accel_data *data ->interrupts[i].info being left unset
> to NULL. Later, userspace can indirectly trigger bmc150_accel_set_interrupt()
> which depends on struct bmc150_accel_data *data ->interrupts[i].info being
> non-NULL, and which triggers NULL pointer dereference. This is triggered
> e.g. from iio-sensor-proxy.

Is the interrupt not wired up or is it just missing from the table?

> 
> Fix this by skipping the IRQ register configuration in case there is no
> IRQ connected in hardware, in a manner similar to what the driver did in
> the very first commit which added the driver.
> 

...

> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 744a034bb8b5..1c3583ade2b4 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -550,6 +550,9 @@ static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data, int i,
>  	if (ret < 0)
>  		return ret;
>  

A comment here explaining why this is needed and what the consequences
are would be helpful.

The obvious one to me is that we won't get events even when events are enabled.
It isn't so clear to me though what happens if the watermark interrupt isn't
enabled during buffered reads.

> +	if (!info)
> +		return 0;
> +
>  	/* map the interrupt to the appropriate pins */
>  	ret = regmap_update_bits(data->regmap, info->map_reg, info->map_bitmask,
>  				 (state ? info->map_bitmask : 0));


