Return-Path: <linux-iio+bounces-14112-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 086E3A09D7A
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 22:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2DFE188BF1B
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 21:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECF9214A61;
	Fri, 10 Jan 2025 21:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntR3oje0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA8F20A5EE;
	Fri, 10 Jan 2025 21:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736546156; cv=none; b=YVMnhW2C9rzr8SdLqMbqScXeZfm4hANkFCxnLd09sNslsA95ayFwtCER7d3kSoa44XJwS7Gi3hU3sD1EAjNg3Lptk4cwgd6KxEz3EQprE+pTyRLUzBDJHZyX72GgowPne3S8WPQ155omcDgoeWMn6EUbvymNkF/jwrgSw1hnWgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736546156; c=relaxed/simple;
	bh=yTisI6F/vX6eUDSoQBu+qmbOD7Me7HbSN0vHgDsLcmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5Fd8kG925WNdG4KM4QVCqwVfuZBcNONfcdfLtn9Vy7ohLtk4fmsRH7Fi3ytNehtAGrzdCpTm+fcaap8LM7D3KQiZ4oN+vSoW2sIUa/l4/8hI6nSJPUYRuyv/N1T7MP+XletEGmJI+4xmyDff6DV6F2Qak5HJ65/ikEtaNGpPsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntR3oje0; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5187cd9b8e5so801718e0c.1;
        Fri, 10 Jan 2025 13:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736546154; x=1737150954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SGw1sMXpECJNyCPVzxa4sITsKuNQw9Y/+TJO6W77f9o=;
        b=ntR3oje0t6YwKyUIGSfEtD0rozHaVlQa15jYA+HPN+DDAw9imt3QFw0CmwiGW9xRZK
         KHMqBy7nqKkAG0hMEdmZlE4DW9pObENloxEzfvmU3CGVk+OvumiE1k22TTtiIVUSCsSL
         5WGD/RDZNUImIZa4EpGY4ry9i/FTR2JqXIKKSAzgs+utjInGjjvI/30oI9A8xpnYH62n
         BY/1407mUtpgSU+qhyweu0cKjGLzvhnAD7FtufapkJV7zp3373RQovkCunZgZ7CBP5b7
         hD2Q4iJDfEw+FHLYIFLFK97QDg+jEwFHvvw5AeMrAuGrO6SbwCKcLM+L3K29uUHbYehs
         b9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736546154; x=1737150954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGw1sMXpECJNyCPVzxa4sITsKuNQw9Y/+TJO6W77f9o=;
        b=Rkm58opLHJwHZsAiiIVeOuxsHbIJKm6bfwnYHe4GCE/758FQW524ER1kRRIKg15fJp
         02F365D6cLJSGy8Iw4m7hZpol5i+JL0c7FeetAPd/Y05fySKAElfFLoZuQxLRFRi/VTt
         LIGSxfIrhPPesmoUzkNpbNygJA525+JY/STmQmiXABRm39OkM2JTxKZXI/i5wUwj9sMq
         o7gSUsPdfSULt3n6qjbKt+0vDmYyJE4c+VlpGgkPkFvUIeyvgxycNcVxCg/8gyzdt+0H
         DaqAnRWBjs4KMc7mUGfyxbnTgBHW8nvSHZDvaOrWlw+L3nyCQ+0//MZrMY/KX2Y4CQRL
         lv0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFhTzxmk0vKWgkETnVZP3207qc8cEVwplItdaVSBS154IGMY2+zlPd9a9SDE1hW7jTfDylIMXT9/0G@vger.kernel.org, AJvYcCWsAhsDXdyOYI378cqO5HjgfW9W0qSAEZCW3eUhEZoFzdv71sk38AZVzM86mOUXn3TARjaUoeR9Ea/YqwFg@vger.kernel.org, AJvYcCXrklEN+0350il2v6X8bzIAkbdF5aLm8PaxZE2UKpxNwv3TLV/eQQwjuX8dsrAkTWtYanq8jCAZBQQw@vger.kernel.org
X-Gm-Message-State: AOJu0YynGRUmds5JfFYKs9YtJyLWTWptykNXeGcQoHFlQTnNSCtUrKcj
	PfhA++6E22n5uPwURvTnjUxrP3hVoNjh0qDMXKQhJfuPgRolH/bGd5LSNlTn
X-Gm-Gg: ASbGnctDKfQl2x7mNggNgJW4336k8fk/qdkkpzCv+B4gzyQJ7oL+GIXkVcwvvZgXcUB
	UOghbMSq6ux4o5kR0UIYfFE+LTvSwn/3EtztLoWHTDoemPW0BQ8H73Unq/+0SI4WvZmWuMtTkx9
	H4zHvCiNFEuwrKy5FFRw++crD5EnGVIa3hqQAb94pPbkaDPBRshJXgSeJ58PKglzPUIDGTZFrZI
	evRr12EuOKFY+GRxhChn/cbhYTMIamwzWf59bQ0c8rH1rM3pBDm2KrXrlMvDLqW1GY=
X-Google-Smtp-Source: AGHT+IHujig8zpw0ENSIQMB85VmtgPE6CuvxSldulQUsVjuSYrMm5RyjApjtNw4pm+taLIHjsbePeA==
X-Received: by 2002:a05:6122:2a04:b0:518:778b:70a1 with SMTP id 71dfb90a1353d-51c6c50f8e0mr11487469e0c.7.1736546154168;
        Fri, 10 Jan 2025 13:55:54 -0800 (PST)
Received: from localhost ([2804:30c:1f79:9d00:c6c6:ec89:7531:7838])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51c7fd03aedsm2709895e0c.33.2025.01.10.13.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 13:55:52 -0800 (PST)
Date: Fri, 10 Jan 2025 18:56:26 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v1 05/15] iio: adc: ad7768-1: set MOSI idle state to high
Message-ID: <Z4GXikxVw6mHIYHc@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <714ff48341753de0509208e3c553b19c1c43e480.1736201898.git.Jonathan.Santos@analog.com>
 <4449ec60-08cd-4074-ba0b-95603864a458@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4449ec60-08cd-4074-ba0b-95603864a458@baylibre.com>

On 01/07, David Lechner wrote:
> On 1/7/25 9:25 AM, Jonathan Santos wrote:
> > All supported parts require that the MOSI line stays high
> > while in idle.
> > 
> > Configure SPI controller to set MOSI idle state to high.
> > 
> > Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
...
> > @@ -574,6 +574,15 @@ static int ad7768_probe(struct spi_device *spi)
> >  		return -ENOMEM;
> >  
> >  	st = iio_priv(indio_dev);
> > +	/*
> > +	 * The ADC SDI line must be kept high when
> > +	 * data is not being clocked out of the controller.
> > +	 * Request the SPI controller to make MOSI idle high.
> > +	 */
> > +	spi->mode |= SPI_MOSI_IDLE_HIGH;
> > +	ret = spi_setup(spi);
> > +	if (ret < 0)
> > +		return ret;
> >  	st->spi = spi;
> >  
> >  	st->vref = devm_regulator_get(&spi->dev, "vref");
> 
> Very few SPI controllers currently have the SPI_MOSI_IDLE_HIGH capability flag
> set in Linux right now (whether they actually support it or not), so this could
> break existing users.

Good point. Maybe only dev_warn() if SPI_MOSI_IDLE_HIGH is not supported?

> 
...
> 
> If we ever do implement a data read of more than 64 bits without toggling CS,
> then we could just set the TX data to be all 0xFF and have the same effect
> without requiring the SPI controller to support SPI_MOSI_IDLE_HIGH.

One point of having SPI_MOSI_IDLE_HIGH is that the controller may bring MOSI low
between data words of a transfer. I think all transfer words are going to be
either 16 or 24 with the new patches setting bits_per_word in all transfers but
that might still not be enough if eventually the controller is unable to support
those word sizes. Plus you would have the complication of filling the tx_buf for
all transfers.

For the part that instigated the development of SPI_MOSI_IDLE_HIGH, the MOSI line
also had to be high in between transfers. The diagrams at AD7768-1 datasheet
page 51 suggest the same would be needed for this chip too.

