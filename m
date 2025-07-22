Return-Path: <linux-iio+bounces-21892-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B92B0E6F4
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 01:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480551C838A3
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 23:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867A72877E5;
	Tue, 22 Jul 2025 23:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VBmvdgwr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE1719DF62
	for <linux-iio@vger.kernel.org>; Tue, 22 Jul 2025 23:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753225721; cv=none; b=KJPQXii5PQYXzF+rCnNWEa5F8vXiIG0+ELS1Oz2rsw3+1JIGHuD7BSVpQ5eb2yB/1e3rhi6Ts4So2nClrX5CkoOC7HLwgMpSie6pN4FdzfPWAhj+bPGf8mVhqwC9xdz5jCDQmAlfydo6TIXounqH+p+l+teImt+wmNS8mE4HzTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753225721; c=relaxed/simple;
	bh=+lnyMb/F0sLNixP6Q7zYfcdherQ3Qd9HdsP1tmvnz00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5xorGsp7sPltswiPxrgwCeLnh/3AEY+nfPueM+2kvFm49dbfrd6H9T3eiDpf/6PrXsA4tSgBytsrwVMMTIvdlQf229EKKHjOosxeA85VIses8xgJ8Tr3YEUQur9QOW9QRiZCQ88HR0pztnr6ybboTtm+WT2qLS2C0I0Kx0FuLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VBmvdgwr; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-61593d51267so2721068eaf.0
        for <linux-iio@vger.kernel.org>; Tue, 22 Jul 2025 16:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753225719; x=1753830519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rsvRf1LNCehYae3lJN6n6abCG/sl0gR3RkUOBc2r6zc=;
        b=VBmvdgwrIFnhOAOkkXc4ioIz3UTBPh+Jbe9nM4MsG5xizeBFJuzD3yWZ1FngTYpjfA
         rfCciRNddBMjy5A1ld1ccpX2QeyJ4aiztjK/PsHfsKvbP23zUWzNWtzz0uTX4irCxgZL
         SRiY7be9i6wYcTFtKt2vWLdkKFa94zAxqis3Bxw0ypioZWQ2nSGc01mSEI43JcySVb4c
         9DHHtrpDvscAbDTp9qPCxGJFvy0oSECdlKQMp48vW7dewyQCB9HaDmcbWHWRu3zYMvjk
         p//TBvsuaTs8ktMyU6gRiE8fzvXpRzjx+B0IU2ZYePpTJ7qyJICZKdR3S1pO60d5uPg8
         dAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753225719; x=1753830519;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rsvRf1LNCehYae3lJN6n6abCG/sl0gR3RkUOBc2r6zc=;
        b=F776ORfKiubbdSUcbpOTevKge2de3qyoZDJaFJJRSfrTY8GdTYCKQnhakGta1XoLtQ
         DJqlNL43+ZLmVL83MPt9IhwrhwO8sn0JiEWV0vW/3w5b/6SgaKf+Tx6yLBIaaQGz8S2t
         Uhrhq+IC/0Q3h8KHc4MBcovBHqE/Sa7HqfapDkc/8rDKeGRoGfKKkqUfMcq/hJ3cX8Qo
         K18G3o+b8GUg3HwWoBNL+e6sCzBRSLZiHoJKaNtWSAFO9FQKn+2+ckHTAGI9PQqiVTah
         ZRWpW3fg1wlBZCdt+6wctKP1lepmdTqiMDAUueJ7dE/5L7wuA18wgIPnakyU8rjD0VHp
         3etQ==
X-Gm-Message-State: AOJu0YzF9eGRXwUmbdIGeGF3vRut/E7TFXgu46EPQfgaUYytUxk3mwJd
	pLkPuR+5d3Qq1+eQRtnh3Xx3P1hQNKo6anGf5UbwA2ekWvHjTh0e2F/8YlrCjzkq4xU=
X-Gm-Gg: ASbGncua8vJ45msE9engjlT4J7KWNhOxLZQoLGRsBLO3EjX07in1Z8j0/Ga33l3j7t4
	yPaNIBkorf9GRJZHiMOJWVjx5rvt13t8dm/OdQaoJ3WVO+rUld0KZqkevMFL6uCVqdD3QyODQ8r
	cuKo3oTnWuWpCns9c+azHITCzE2HQo/UzRborJUNTeFHeocDu4IlR6UUXEM0F+QQyOmEuh5CeUX
	rRkYlm263gX5PNILC97ZEcZjM43zcG/xLzLrR93wSluetSyNT3JWlBFfLA36/0zes+1zQgHV7uR
	hAyiJi6vnfDLNOOGuK/T3+/kWAIg8sRP8jJcxCnNHFD39OGtMlrxXcQjqRgAx1CgJlx7x2+l4p/
	xHksEqtLakw+JW+o0leYtwp0GZx+DJLb8JDuQq5VcUHiP3ZxvcYVYrQGbez3ETCj4ez6Jum78io
	BkDa8i6s4=
X-Google-Smtp-Source: AGHT+IHSRs2wuK5jMgQaFfXIetgnLF8ptCHVtH0GA1PndSp8X2ODi9o3lUk4ufMYvg1hN8Cj4+IyCQ==
X-Received: by 2002:a05:6820:206:b0:615:9107:fae3 with SMTP id 006d021491bc7-6187d91376fmr509416eaf.8.1753225718898;
        Tue, 22 Jul 2025 16:08:38 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:11dd:c0f5:968d:e96? ([2600:8803:e7e4:1d00:11dd:c0f5:968d:e96])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-615bcab270csm2091386eaf.9.2025.07.22.16.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 16:08:38 -0700 (PDT)
Message-ID: <823a28d6-e612-4e32-976a-cb99945848ce@baylibre.com>
Date: Tue, 22 Jul 2025 18:08:37 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: proximity: hx9023s: fix scan_type endianness
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Yasin Lee <yasin.lee.x@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250722-iio-proximity-hx9023c-fix-scan_type-endianness-v1-1-48f5dc156895@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250722-iio-proximity-hx9023c-fix-scan_type-endianness-v1-1-48f5dc156895@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 6:07 PM, David Lechner wrote:
> Change the scan_type endianness from IIO_BE to IIO_LE. This matches
> the call to cpu_to_le16() in hx9023s_trigger_handler() that formats
> the data before pushing it to the IIO buffer.
> 
> Fixes: 60df548277b7 ("iio: proximity: Add driver support for TYHX's HX9023S capacitive proximity sensor")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/proximity/hx9023s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
> index 33781c3147286fb3e2f022201ccf7e908d0b6b12..8e5748a5f37a7b6674acc1604710394326818204 100644
> --- a/drivers/iio/proximity/hx9023s.c
> +++ b/drivers/iio/proximity/hx9023s.c
> @@ -251,7 +251,7 @@ static const struct iio_event_spec hx9023s_events[] = {
>  		.sign = 's',					\
>  		.realbits = 16,					\
>  		.storagebits = 16,				\
> -		.endianness = IIO_BE,				\
> +		.endianness = IIO_LE,				\
>  	},							\
>  }
>  
Just noticed this while reviewing scan structs.

It is odd to have data already in CPU-endian and convert it to LE
before pushing to buffers. So I'm a bit tempted to do this instead
since it probably isn't likely anyone is using this on a big-endian
system:

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 8e5748a5f37a..b8076ca4d0f4 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -145,7 +145,7 @@ struct hx9023s_data {
 	bool trigger_enabled;
 
 	struct {
-		__le16 channels[HX9023S_CH_NUM];
+		s16 channels[HX9023S_CH_NUM];
 		aligned_s64 ts;
 	} buffer;
 
@@ -251,7 +251,7 @@ static const struct iio_event_spec hx9023s_events[] = {
 		.sign = 's',					\
 		.realbits = 16,					\
 		.storagebits = 16,				\
-		.endianness = IIO_LE,				\
+		.endianness = IIO_CPU,				\
 	},							\
 }
 
@@ -950,7 +950,7 @@ static irqreturn_t hx9023s_trigger_handler(int irq, void *private)
 
 	iio_for_each_active_channel(indio_dev, bit) {
 		index = indio_dev->channels[bit].channel;
-		data->buffer.channels[i++] = cpu_to_le16(data->ch_data[index].diff);
+		data->buffer.channels[i++] = data->ch_data[index].diff;
 	}
 
 	iio_push_to_buffers_with_ts(indio_dev, &data->buffer,


