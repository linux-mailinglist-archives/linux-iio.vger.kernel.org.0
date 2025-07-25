Return-Path: <linux-iio+bounces-22017-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F57B1250B
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jul 2025 22:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2C216A495
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jul 2025 20:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF08B245038;
	Fri, 25 Jul 2025 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVUD40Fp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5C6244186;
	Fri, 25 Jul 2025 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753473692; cv=none; b=b4rJa9zUGdVCT6lrjAESNjauwsIxBND726WHrjio4XlsNMr6QFoxWEVFBeoTqDxJgtwrD22+lEHQktT/swVBq8oa4dGrdk+RLklvFWhjlY7QkDFcXUiyUjZh+lSa/vtQdl6JOwCLQ8yXSdum4+xCZ0cay0fQNSjcWfqk/KDl76k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753473692; c=relaxed/simple;
	bh=/NF+nMYUKIQaRz0jJqoW3mVTM6AXCI2yNKYHmjqxbeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eChTtM2Eoh8ZOiNkAxTaU4JpzJa6mZlkkwSC2wkS1rnZvj55YRcomj2bHl9k8Jnx5K8CzljRORm1k1EtjVqDnHGE+2CQBMaMHhThXmvwF2nApJ6GPtOANezs9p/CWr1nyKM60tDaMRM9maEa3tp0NT8Hj7LLNaCflP+W0JnxGc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVUD40Fp; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b31c9132688so180757a12.1;
        Fri, 25 Jul 2025 13:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753473690; x=1754078490; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+o3NPNRKzqqC1dW0GgtraC9w+7+wPtPqL2gAX3WF/r0=;
        b=MVUD40FpsRVZNRzhyOKKrkimgvRTeRnvVzk6mvK0t30azLXnUsuhW187v+oxVpDcOO
         N159/n6psV96A5BI47bUmjDVA3pc/PP1kuIrYhR+wqsCPH0FkFPajhnLF7/qkLwDls7e
         ddf96AcU2OSkUhzZhn2ZfapSwJ3eqlTaW76mEhIccaPPXEam+RPKdPD9UdXgIThQRkc8
         s8F/JaJAPIjkyqwHTbjORkLdsdIrQ9z7Cc3lcWB5d0HhSokbpBag5vN5hWE1NEC8nwos
         /LqQFypARfKICX+JiHpnHBxCcRBzGPA1HJMu/CCmybKou+vUxshxlTogVVhNdk0yCtqO
         DwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753473690; x=1754078490;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+o3NPNRKzqqC1dW0GgtraC9w+7+wPtPqL2gAX3WF/r0=;
        b=l5jE1oZ29d8gVm9mebFJSjKS7konCARgperfYrWA/wci7YoY5qBeAqot+1LQ+1DnSW
         J8iOQv5GZvwATnZpAHr3t5ncYY6MnCBxNUIfQxdboKPi+IB7KWUTY9UGjyaVK/Ar+Nqd
         CIkvIm6qxhq93Zd75+wUvOb+p2rs0xgg15YHhh/NlydJEhHommQVTd1J7kmRFciBjxDm
         EA7vo3rj6EbQeMaAH+BkIF6q0X4JY699kvry0916uxuTGN2Ez6VLolDIQimFKBN+hd+E
         XAKAJkfpkb2RW7VYKvqZ+HIePE4I3D9weGyIemtyjKyBhbt1HHTfN4Az7mg/TKyJ5AQo
         68yA==
X-Forwarded-Encrypted: i=1; AJvYcCW8B+NCeJldrLRzJz/vZqW0bH73laUlMOy8WYAkhuTeiCojQQNEDCww1wOJdltSEXFDb01nsze7mdg=@vger.kernel.org, AJvYcCWVqkk5qAECub6nuyaBp8U1tUPmxEVQ7Ta6VPNCPXIVBG4emOnua7ZdfwBofm4VZraOW+XPBDMc60YlAm3l@vger.kernel.org
X-Gm-Message-State: AOJu0YztF4lv3cvnc7rV0WiZAdr+6E6+6v0cvCo4BYMP2E3lYG8NSj6V
	fEqykIJXIpRY4gL6cFCJswR0xYxF9JSql86dPx3qnzh6eMD9e8xjEwgL
X-Gm-Gg: ASbGncvQIUgB5ap7XMo0JHaXOFdUj63tSq4wh56a0GL4kp5+nNJZThDdRCYgsS5dGOm
	LOBTSxirkU/sJ1UmFV0pkQ9ixM2KOaMsc9dkyiKsdCmgMbAzwQASPBBdDVLdg4jgc5jHDELcaVy
	8FtUGOA91ybsnJUdVpQT89O7LKxFzlVtlbwmAMUK2ff0z+Twzo05Hbo3gu9zl9qM4x3nTPZKva6
	4HTlLQVEiONDNGRrqTBoz2026T+i7jCDr+SqECm4Z57Z8sQFX6+UGPE+D4WbD3TvZ2Oe+2nPlbU
	Eq88RMRF300S2P5No2Wu/Ewre+VgtEX79JtFJ9mYCVg5Lr6zJT8Abh5RBgSW3dsDMQBMAqGMk44
	tQZcALEZeXcmwsBbdhjm3c0yVUO+taoi42PaCvd/Flno=
X-Google-Smtp-Source: AGHT+IHwh6EHny66giX733tErFGwcLvS+sNwlcHsetWsjsmlyTJzSxXuaAWUe9WEqNLGQAeBcfEduw==
X-Received: by 2002:a05:6a00:8d1:b0:737:6589:81e5 with SMTP id d2e1a72fcca58-7633227ae61mr2143758b3a.2.1753473689872;
        Fri, 25 Jul 2025 13:01:29 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([191.255.131.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640863503csm370554b3a.5.2025.07.25.13.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 13:01:29 -0700 (PDT)
Date: Fri, 25 Jul 2025 17:01:24 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH] iio: adc: ad7768-1: disable IRQ autoenable
Message-ID: <aIPilIRYMgKcSjZW@JSANTO12-L01.ad.analog.com>
Reply-To: 20250719130844.7559e322@jic23-huawei.smtp.subspace.kernel.org
References: <20250718013307.153281-1-Jonathan.Santos@analog.com>
 <5llfgo2wifyi43zj24rv7ph5gebevcszrxl3hp3yc3ibaglcr3@fqdejauv6rmo>
 <20250719130844.7559e322@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250719130844.7559e322@jic23-huawei>

On 07/19, Jonathan Cameron wrote:
> On Fri, 18 Jul 2025 10:18:56 +0100
> Nuno Sá <noname.nuno@gmail.com> wrote:
> 
> > On Thu, Jul 17, 2025 at 10:33:07PM -0300, Jonathan Santos wrote:
> > > The device continuously converts data while powered up, generating
> > > interrupts in the background. Configure the IRQ to be enabled and
> > > disabled manually as needed to avoid unnecessary CPU load.
> 
> This generates interrupts continuously even when in oneshot mode?
> 

No, but oneshot mode is only enabled for a brief moment when reading the raw data. The rest of the time it stays in continuous conversion mode because datasheet says it is necessary to make configuration changes.

> > > 
> > > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > > ---  
> > 
> > LGTM,
> > 
> > Reviewed-by: Nuno Sá <nuno.sa@analog.com>
> > 
> > >  drivers/iio/adc/ad7768-1.c | 18 +++++++++++++++++-
> > >  1 file changed, 17 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > > index a2e061f0cb08..3eea03c004c3 100644
> > > --- a/drivers/iio/adc/ad7768-1.c
> > > +++ b/drivers/iio/adc/ad7768-1.c
> > > @@ -395,8 +395,10 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
> > >  	if (ret < 0)
> > >  		return ret;
> > >  
> > > +	enable_irq(st->spi->irq);
> 
> Looks racey to me in a number of ways.
> 
> Before this patch:
> In continuous mode, reinit_completion called then interrupt before we enter
>  oneshot mode. What was captured? 
> 
> After this patch
> Oneshot mode starts - hardware interrupt happens but enable_irq() is not set
> so we miss it - or do we get another pulse later?
> 

After some debugging, i think the device gets the last interrupt before
getting into oneshot mode because I don't see any DRDY later. it should have a sync_in pulse after to
update the data value, as you said.

> I'm not sure how to solve this as a device generating a stream of garbage
> interrupts is near impossible to deal with.
> 
> I'm not following the datasheet description of this features vs the code 
> though. It refers to oneshot mode requiring a pulse on sync in which I can't
> find.
> 

If we made something like this wouldn't sufice?

...
	reinit_completion(&st->completion);

	ret = ad7768_set_mode(st, AD7768_ONE_SHOT);
	if (ret < 0)
		return ret;

	enable_irq(st->spi->irq);
	ad7768_send_sync_pulse(st);

	ret = wait_for_completion_timeout(&st->completion,
					  msecs_to_jiffies(1000));
	disable_irq(st->spi->irq);
	if (!ret)
		return -ETIMEDOUT;
...


> > >  	ret = wait_for_completion_timeout(&st->completion,
> > >  					  msecs_to_jiffies(1000));
> > > +	disable_irq(st->spi->irq);
> > >  	if (!ret)
> > >  		return -ETIMEDOUT;
> > >  
> > > @@ -1130,7 +1132,21 @@ static const struct iio_buffer_setup_ops ad7768_buffer_ops = {
> > >  	.predisable = &ad7768_buffer_predisable,
> > >  };
> > >  
> > > +static int ad7768_set_trigger_state(struct iio_trigger *trig, bool enable)
> > > +{
> > > +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> > > +	struct ad7768_state *st = iio_priv(indio_dev);
> > > +
> > > +	if (enable)
> > > +		enable_irq(st->spi->irq);
> > > +	else
> > > +		disable_irq(st->spi->irq);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static const struct iio_trigger_ops ad7768_trigger_ops = {
> > > +	.set_trigger_state = ad7768_set_trigger_state,
> > >  	.validate_device = iio_trigger_validate_own_device,
> > >  };
> > >  
> > > @@ -1417,7 +1433,7 @@ static int ad7768_probe(struct spi_device *spi)
> > >  
> > >  	ret = devm_request_irq(&spi->dev, spi->irq,
> > >  			       &ad7768_interrupt,
> > > -			       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> > > +			       IRQF_TRIGGER_RISING | IRQF_NO_AUTOEN,
> 
> Why drop oneshot?
> 
> > >  			       indio_dev->name, indio_dev);
> > >  	if (ret)
> > >  		return ret;
> > > 
> > > base-commit: 0a686b9c4f847dc21346df8e56d5b119918fefef
> > > -- 
> > > 2.34.1
> > >   
> > 
> 

