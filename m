Return-Path: <linux-iio+bounces-18547-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5ECA97A91
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 00:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A2A3A76B9
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 22:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B9F2C3747;
	Tue, 22 Apr 2025 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="abEdhaKY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA262C1E06
	for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 22:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745361425; cv=none; b=Jhdx8bdX4SV+oy9y6RRnFBVZR7DWcctt60x97iR32QTF1AQDp57ghjBRHkT4D5lSTiNde9DTVyn78syPJZaFt/0NDdHu2vpHdtYVadzkb+8oVpepxUIa1r1TL6ZfPCZsJ5+YIvfdqJCVqJKyKFPuHIPaieUrxh60g9O1Xpke/KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745361425; c=relaxed/simple;
	bh=edrSoU/7ttYT1N9uHXGev19DEKDxe8wPMLxCuvyp7cI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i3vvCoRgNLL8D8D0TiMs5RKJdvRJnnOdv1plzMqhHbaZ++povz54KkORZpphQcWkhLggwi24Be9YyyqKkocfHp0vV+FTktmV5hVc2bch5os3BZXMb0UIyi5ke/2zh+Zwkk0yohdAyOPAQVaN4Mjjj5hyDtf7ucVgGWfxgwGz1BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=abEdhaKY; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-72c1425fbfcso2943591a34.3
        for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 15:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745361422; x=1745966222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GFEryJTJrYlbNEPG6EOeE5cZYQCM6sOwjcE6fp5zhZc=;
        b=abEdhaKYN1x8l05/su0heXu8/eMrKo1Q51fubhImCPcjYNYKVCFlalQdgjg+S4crHJ
         N+EoOKIw2pTkhIb1TahbQKje0Z2VAO9c+iUE2UcvgFIx0sNOgVQfVyifnWFNxL4SCWcs
         sSLNe389pAbedh5oG91N5ix8/tClR8gX+ITyeldn9g0FnwlqjdpA5dXSXx6mVJ9dyR9I
         LtkwXnsq2BGiuoWVQ8X+LLnIMHM+AT8n+ieAK6UUEUCOPMlZxvQFBvlYXluhiY6eG7Nu
         0oc7T6g9mNoRq6rz7r8yMynMpANuWG6sZPV2gtOWTVbqLiCe/wNhDdhR79Cjc/fBzm3r
         I0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745361422; x=1745966222;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFEryJTJrYlbNEPG6EOeE5cZYQCM6sOwjcE6fp5zhZc=;
        b=PDQV/pNsIn6myE+xlTpqDhCDWgumJT7isoLFYB9zUUMHgiAUABEpALUDvmNrjtpA+s
         niaV0KJTNHg7FMKRLU7MwSTbD4D7y+eg770yzkgl0WPzCkvLt053N81GrjhdbLQShtg4
         poob/ivf0WT77uu/TZ1WZnGHktEDA8vyXvIlK54gk8M103VJ74bNeydPrNpCT897oRB1
         zQkiPDw3n5JYOG1bx8dSKElPdrkljIl1zzG29MPq3MloFSoxHAqfI6bexR71wVxCHL4T
         4vG5MesBJ6oQaokrtMy5FY84BSzewIXe3AjKKv8/rsTYJweZluCyKNYiLXKgqfifTLIw
         oa9g==
X-Forwarded-Encrypted: i=1; AJvYcCWwMHZcSOM2bzar+gnIVHb0B2kgPhuAVhaoScEYjYjkvFXEYffRuQ9ySAkRA3cqbSEfx0pyEK2CESE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaYxUc5sYFwosCrr70uT/TqMqf8YOUKPet1ZVNdQ+CeTGAJvgT
	ZaDMA8L9ZKWXOHXrCOI8dnRQwB3UuyFXQdnLS3wbDzMOgJbt3O143bAeBaxsuIw=
X-Gm-Gg: ASbGncu51JI2/D+LQGFQk1cPVx7ekigMLwWzFUi/YdF1AZo6M2/EgG2ouv+PBpAvxu0
	VpSexUVuYgp8qwUhPxhPr+Op81Ujv+eqLjrXHXjmADuYh7nedk8gmqYpSPNuscm4vyIPX52PyAi
	rmnsFA3be5Q58N1st5Y5rqYU8+xEB3LLJO/Iv3NsrMnQVaVx9UMpjhjg1M7Xj7mZyKkRGrf+7pK
	sUXKiiQGudW671y3SJDcro5oe8Yyjstn8EvkLpd8v80+TRzwFGBQevIoF9ibkiHKYIZO/bk1+8p
	4cRn2ZVI5ZNc5OdW2HPn7LjXU+5xjeBjSL3MlleX3O5RvUCpU5w/mlw8UcQeQHJOb4f9S9zOgx5
	l9WoBZ1LMNzBNGGMEVw==
X-Google-Smtp-Source: AGHT+IGgff0HbnynsiGyzAMNRyImRsk0W8jB40NIbqdBsgqXBc+HF8ytnQSIYbKf3QzD5ZMhIHryIQ==
X-Received: by 2002:a05:6830:601a:b0:72b:9d8d:5881 with SMTP id 46e09a7af769-73006336191mr12246352a34.28.1745361422741;
        Tue, 22 Apr 2025 15:37:02 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:c8d1:e0ed:ce8b:96a3? ([2600:8803:e7e4:1d00:c8d1:e0ed:ce8b:96a3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-730047afc11sm2208277a34.25.2025.04.22.15.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 15:37:02 -0700 (PDT)
Message-ID: <f0948adc-8130-4417-8c59-f0b52a7a0e01@baylibre.com>
Date: Tue, 22 Apr 2025 17:37:01 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-0-3fd36475c706@baylibre.com>
 <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-1-3fd36475c706@baylibre.com>
 <CAHp75VeuNhfJrNAZZwY2tEHte=UPHLOPNUz7y_J20xv2+_Zdeg@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <CAHp75VeuNhfJrNAZZwY2tEHte=UPHLOPNUz7y_J20xv2+_Zdeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/22/25 5:30 PM, Andy Shevchenko wrote:
> On Wed, Apr 23, 2025 at 1:08 AM David Lechner <dlechner@baylibre.com> wrote:
>>

...

>> +_Static_assert(sizeof(IIO_DMA_MINALIGN) % sizeof(s64) == 0,
> 
> Why not static_assert() ? Because of the message? But static_assert()
> supports messages AFAICS.
> 
>> +       "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment");
> 

I just knew that was standard C. But I support BUILD_BUG_ON_MSG or static_assert
would work just as well here.

