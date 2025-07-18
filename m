Return-Path: <linux-iio+bounces-21764-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EFAB09F11
	for <lists+linux-iio@lfdr.de>; Fri, 18 Jul 2025 11:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E905A85782
	for <lists+linux-iio@lfdr.de>; Fri, 18 Jul 2025 09:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C655296163;
	Fri, 18 Jul 2025 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxJw3+50"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62C3292B2A;
	Fri, 18 Jul 2025 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830328; cv=none; b=UUz5IN6bx1pwan8zF9ySnVeGgS4AEQrbo1SbGaKHUpA0HwLmF19xhTr9wHjccIAEw1IBNF9EV1wMpawnlof+3zGByeCHpwc4HN0teaQnBJiRS8daI9Ll/zd7APH70b6DgvP27+lbYlEY5Wj5w/DeCarowir3v6zT6p0dVbwm2TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830328; c=relaxed/simple;
	bh=5IIQlhSaDwcM9aIUYlCa5hvLfThu03yoQGKmdTdrlPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDffEl9BV2NWoLh2CieYEq6uItCtAnJRo5TaEKp1eSIE5u4fBLHgMJxuIeiGBHu0klMtGXsU2TjihbCA93WDVLtYqdseiVbR3KAPAiKxLxQ4Ln0I//I5R5+1BGFLysiX48NLU4fJPtGwer1cJ70IU1x7eAjeSsalsiGVWl59vbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxJw3+50; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e3142e58cfso114782785a.0;
        Fri, 18 Jul 2025 02:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752830325; x=1753435125; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2R2Qj7lClXBDivuzyVGIVlMGwvZsFjShl3bXiqZmo9w=;
        b=NxJw3+50rFA2dJEYQTb/bWgQcrHZvT9//SufsgkgN4uxPApOdcZ2IHF8yBL72nDxHZ
         HJuIuELbxfDpxGXQGREWMWD5ELwZLUdfrwZHmIOLijJT72THOPQ0gybxRowUnv3Cz6m1
         h5MkyMrJlUNNQP0gH5YkcxRdsHa6A1KpMNK493Weyes4597kCEpMBg8lZ16hvKHg2kRN
         dPbvLtX3d0eshPe6bLjPcLZ0UJWHAYbD2jeUgr+fF1InHFenKzNtigJoGsEj5jqv811N
         Qomaz6/swtXek6//W/zf9rTQJOG90Yi1nAg5+rHwCslbQ1Tcisc+G65YfAqwSA1JX37S
         gmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752830325; x=1753435125;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2R2Qj7lClXBDivuzyVGIVlMGwvZsFjShl3bXiqZmo9w=;
        b=XqYdhPmFo1repgvEtRbufZoYKOasYPk/N78ITjudQZTn1FwvFFgTZ7Ia5OjTH6D7ax
         fu7avapyvHnONl6WbUmnQGWsOcC0YYqsJ64yE39UKbdiAsvwtC+HqFbV+74H088AF8rM
         NtTDlUE+m0blVFBtkX0XP1AJFZrYzLOmlCZeXTZw4HXa0Kse09nKEkq9HV3i3SwFd5o/
         eEEJCiC8Q7n9IK73hIhvfrakuSG3TJzzqq2Zt+o7PakleGIPiJHKPlk6CNwo3ARGG6U3
         Y3nxFGxv8Yec3n3Vqyr2Li+FzIQADTqtlakckUe8P75Gw1KZTzfDPqnkW7lAdimRivQL
         WpEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLIZArSlU5fsmNdzHE/kiehSkTGIOCaO5/dcG9IHWoGvZQqA61C98/b8hpEV3if38jSISvBiEjlU0/Kcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5dRkskfJFZ7/Zvf3flLxGDFBMoins94GCxBp1Ngs8B5aVjw1x
	pAJVHROlj+Y3q/Cbu80Lr+S1e/6hRFggKqW8UP83aa1GntmJln+l4ynR5bB6DKD7zvJd9w==
X-Gm-Gg: ASbGncvJNLoCmGqFzWbri/VxDq9ix4148Udvp78VVtZ/q2pBjKfdxSUCe8J7nUqqL9I
	z52qFaGlGojnsvHzitnivt6xRfP0rGln2sUYUPVOeFdTL5qyxnPqU9LXuvPU76U2nrU9ljRVqbb
	qyk64D8npjdYlvvdp977lAj98QPHoju8yq9M1V3Xj4mnMVz6daU33KWtEiLf/oNxxmqzldP2IrD
	yaYhi3eEoZSEe9XZReJAGx1N0shHjZW2aaMviYGhlQsapJifqWRaJ1J9VCRYlK6XxWlagpzQ6Gd
	C92WHBVUe6k24uoov+DJkElV9Tq/mMIdueiSI95UPoL3Pya3VnrGdsN8BYRnkGDaY5eE5y7ISlI
	Q2YhHTRKueA1/
X-Google-Smtp-Source: AGHT+IG1E5Nuzq9HW2jysz/q+IFoyBEHy+O9n2un23FehdBlKlqe4qProNMQTj9aMBHBtI6rYNgduQ==
X-Received: by 2002:a05:620a:6181:b0:7e1:ad94:af71 with SMTP id af79cd13be357-7e3435fa891mr1365981285a.35.1752830325474;
        Fri, 18 Jul 2025 02:18:45 -0700 (PDT)
Received: from nsa ([45.144.113.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c3ed05sm62742785a.65.2025.07.18.02.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 02:18:45 -0700 (PDT)
Date: Fri, 18 Jul 2025 10:18:56 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, jonath4nns@gmail.com
Subject: Re: [PATCH] iio: adc: ad7768-1: disable IRQ autoenable
Message-ID: <5llfgo2wifyi43zj24rv7ph5gebevcszrxl3hp3yc3ibaglcr3@fqdejauv6rmo>
References: <20250718013307.153281-1-Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250718013307.153281-1-Jonathan.Santos@analog.com>

On Thu, Jul 17, 2025 at 10:33:07PM -0300, Jonathan Santos wrote:
> The device continuously converts data while powered up, generating
> interrupts in the background. Configure the IRQ to be enabled and
> disabled manually as needed to avoid unnecessary CPU load.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---

LGTM,

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/adc/ad7768-1.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index a2e061f0cb08..3eea03c004c3 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -395,8 +395,10 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
>  	if (ret < 0)
>  		return ret;
>  
> +	enable_irq(st->spi->irq);
>  	ret = wait_for_completion_timeout(&st->completion,
>  					  msecs_to_jiffies(1000));
> +	disable_irq(st->spi->irq);
>  	if (!ret)
>  		return -ETIMEDOUT;
>  
> @@ -1130,7 +1132,21 @@ static const struct iio_buffer_setup_ops ad7768_buffer_ops = {
>  	.predisable = &ad7768_buffer_predisable,
>  };
>  
> +static int ad7768_set_trigger_state(struct iio_trigger *trig, bool enable)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +
> +	if (enable)
> +		enable_irq(st->spi->irq);
> +	else
> +		disable_irq(st->spi->irq);
> +
> +	return 0;
> +}
> +
>  static const struct iio_trigger_ops ad7768_trigger_ops = {
> +	.set_trigger_state = ad7768_set_trigger_state,
>  	.validate_device = iio_trigger_validate_own_device,
>  };
>  
> @@ -1417,7 +1433,7 @@ static int ad7768_probe(struct spi_device *spi)
>  
>  	ret = devm_request_irq(&spi->dev, spi->irq,
>  			       &ad7768_interrupt,
> -			       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +			       IRQF_TRIGGER_RISING | IRQF_NO_AUTOEN,
>  			       indio_dev->name, indio_dev);
>  	if (ret)
>  		return ret;
> 
> base-commit: 0a686b9c4f847dc21346df8e56d5b119918fefef
> -- 
> 2.34.1
> 

