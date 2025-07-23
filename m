Return-Path: <linux-iio+bounces-21913-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1A0B0F6B1
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 17:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6CEC171AA2
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 15:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FC12F2C60;
	Wed, 23 Jul 2025 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IAt3x+zs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A2F2F5085
	for <linux-iio@vger.kernel.org>; Wed, 23 Jul 2025 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283281; cv=none; b=IQ9cnxunHyqFmMvNYoLpBgV2J4gaMEqxZ+77Z7sacUGFUwXDW/vV5Mgi1aisldbdPzs0WY8H9eJHRXtqSYqS9/58fRSsQwH0O7UWX/q4nftLzBvz9+ME1OGwg8lRRL+h697V4b7XpU1TWHm9gdWzb8pjG9MSiDXohW9efz+aiME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283281; c=relaxed/simple;
	bh=cJwHuDTTCzAQgnGkdfA7YOzuTVv2xd12iLSHq8VAjVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvH4lvKUz08uNeLVWldCLWDcFzUIbPfuXnUnhK88xM6hi/H7/3eFht21028UzBu5klEKgTtTCqFsUMmGhHMHu1nyl8vCI3TJ+REYVG2RUs/zCPgo57aMdvnvpjhW7fLPVxsZLC3nHdDd4ha0nbnFy3FfiMkQ90KCYk6fVMzJmKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IAt3x+zs; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-41b7d1240d8so22153b6e.1
        for <linux-iio@vger.kernel.org>; Wed, 23 Jul 2025 08:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753283278; x=1753888078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U79N67VMcpNHZisXl45BR0VTpPIGtcLgjPOjmiuU2Ag=;
        b=IAt3x+zsrYu/vqxRYSLrcS09eHG4wAu8Tj0iY0XTGm5ek60IjrJ/gIGHCQzx0nG+N4
         lNjSR5bcsWvau2rLinbWHLbyqBeAno/0s+BvUj4sqyz8j67i6pruXxjv0gjALFeQvst+
         Hlh/5J9A43i/j460WccAb3H8z8KGwJ+rxhrAs6OqVw5GoAqzbPw/Roz9BELF5KoAvPxZ
         mU7TOXD+daY/99lcQbfw58nYnJmHMoBPhULUarIxd1gzfOUt7fNV405CCKVFby71XYPv
         dTrVbB7l4hSXinr26b95xvduC2dMCUCxf455ErJ9aEtWH6srh16rB1fIQsyBcdQqWEks
         jqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753283278; x=1753888078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U79N67VMcpNHZisXl45BR0VTpPIGtcLgjPOjmiuU2Ag=;
        b=iua4vdMjOMbSabyfajINWZFwbqhRAxmuYl7Pphc74WisQW4/FJ1hRLOPdmHbxjDJh6
         PZrK8LSVGPCKOFAN9H1R+rUgSghp8HY2GPbrNJWn0elrL4kAJ8BbRnOofLICiyGF2lLJ
         ONIsk5R0j8CQ1hME68QEKOSFyqCPehVEpl2hFaBkldEykXEHsyh8igUfEeoECtXc8dyK
         Wr8QRwK2rrJoD19ddXxYCnAzTjPExZRat3Tj2VAv481UkXT92vwvVFbrMi4P0MUDehDc
         hta9uoIOyMJqq5vUk1AIe7x8AVeR+GtKFIul/J5dzBUnsbYoxHpT/o0Fl2N+jZjb8LUF
         uFHw==
X-Gm-Message-State: AOJu0YynuzAYU/LxfMvT8a+Qpn2Gh34YazzmT6FDo5Il1NzVXkrITqqL
	tAk6zIO9oAZA/vIaVWN/E82bq4q+cGsgBzuPKZUy/OiLUlNzyitfgfsEuXvrsVE0mk0=
X-Gm-Gg: ASbGncuCUD7siJlA3LtqHcvI/58jrPQOM1phjKbHszbc8ytojo5pyIPENdcgvjOu6eU
	o3WTueZ6cZ9iu97UPTWWR+AmXUVTBPp4+nd6FNvxKysBJ1Sjt4Mx423p5geHig6n1bDdeIjVAtb
	0RUPOGZTo5aLsQOSmHZWbINTHRt6nb+/s6aU+hz7LToR3604lrjFe4/1BX3pW4yonmgEdXjapAM
	BWUSh4iKU5OANKto596wDAvgnL+mts43VSegihbAJRheJOObSNUTd7E/mGYQboMOQLzHEDc5n9H
	M6h7pOgJNb42Byp4CKvpZ7hqBEYuEEQFKI9SfGMIpftH1tcaod8l851zJa7L/lMKkvCjK2M7WiN
	kcfxjY/nXJ5weSQ+SP/LBsFw5O7LT3Vl6YR5RN4ICv9FwTHYfDjUvhi+8sqQ5S+cH417HTaCz
X-Google-Smtp-Source: AGHT+IFXi7MK91x9eyasXM8kNa5sIqhFwhEC0U46aSD837WPjl2LPJciZeEEI4nVXofP070Rj/214g==
X-Received: by 2002:a05:6808:199f:b0:41f:dced:3c01 with SMTP id 5614622812f47-426ce78369fmr2533669b6e.39.1753283278515;
        Wed, 23 Jul 2025 08:07:58 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:11dd:c0f5:968d:e96? ([2600:8803:e7e4:1d00:11dd:c0f5:968d:e96])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41fd565cb1dsm3621858b6e.39.2025.07.23.08.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 08:07:57 -0700 (PDT)
Message-ID: <57e16589-3d9c-49c1-ba91-abae23143803@baylibre.com>
Date: Wed, 23 Jul 2025 10:07:55 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: proximity: hx9023s: use IIO_DECLARE_BUFFER_WITH_TS()
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250722-iio-use-more-iio_declare_buffer_with_ts-8-v1-1-36188a3f214f@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250722-iio-use-more-iio_declare_buffer_with_ts-8-v1-1-36188a3f214f@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 5:54 PM, David Lechner wrote:
> Use stack-allocated IIO_DECLARE_BUFFER_WITH_TS() to declare the buffer
> that gets used with iio_push_to_buffers_with_ts().
> 
> We change from a struct to IIO_DECLARE_BUFFER_WITH_TS() since
> HX9023S_CH_NUM is 5 making channels[] larger than 8 bytes and therefore
> the timestamp is not always as the same position depending on the number
> of channels enabled in the scan.
> 
> And since the data structure is not used outside of the scope of the
> interrupt handler, the array does not need to be in the driver state
> struct and can just be stack-allocated.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/proximity/hx9023s.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
> index 33781c3147286fb3e2f022201ccf7e908d0b6b12..1203fa4bc7512ea85b55d537e2459104b52407b9 100644
> --- a/drivers/iio/proximity/hx9023s.c
> +++ b/drivers/iio/proximity/hx9023s.c
> @@ -143,12 +143,6 @@ struct hx9023s_data {
>  	unsigned long chan_in_use;
>  	unsigned int prox_state_reg;
>  	bool trigger_enabled;
> -
> -	struct {
> -		__le16 channels[HX9023S_CH_NUM];
> -		aligned_s64 ts;
> -	} buffer;
> -
>  	/*
>  	 * Serialize access to registers below:
>  	 * HX9023S_PROX_INT_LOW_CFG,
> @@ -928,6 +922,7 @@ static const struct iio_trigger_ops hx9023s_trigger_ops = {
>  
>  static irqreturn_t hx9023s_trigger_handler(int irq, void *private)
>  {
> +	IIO_DECLARE_BUFFER_WITH_TS(__le16, channels, HX9023S_CH_NUM);

Ooof. I remembered to zero-initialize all of the scan structs in the other
similar patches, but forgot we need to do the same with the array to avoid
leaking uninitialized stack to usespace.

	IIO_DECLARE_BUFFER_WITH_TS(__le16, channels, HX9023S_CH_NUM) = { };

>  	struct iio_poll_func *pf = private;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct hx9023s_data *data = iio_priv(indio_dev);
> @@ -950,11 +945,11 @@ static irqreturn_t hx9023s_trigger_handler(int irq, void *private)
>  
>  	iio_for_each_active_channel(indio_dev, bit) {
>  		index = indio_dev->channels[bit].channel;
> -		data->buffer.channels[i++] = cpu_to_le16(data->ch_data[index].diff);
> +		channels[i++] = cpu_to_le16(data->ch_data[index].diff);
>  	}
>  
> -	iio_push_to_buffers_with_ts(indio_dev, &data->buffer,
> -				    sizeof(data->buffer), pf->timestamp);
> +	iio_push_to_buffers_with_ts(indio_dev, channels, sizeof(channels),
> +				    pf->timestamp);
>  
>  out:
>  	iio_trigger_notify_done(indio_dev->trig);
> 

