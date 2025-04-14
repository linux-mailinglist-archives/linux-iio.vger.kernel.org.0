Return-Path: <linux-iio+bounces-18080-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D35A88523
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 16:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4995D19023B0
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 14:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728692C0332;
	Mon, 14 Apr 2025 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCxAurar"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C309028A1EA;
	Mon, 14 Apr 2025 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639210; cv=none; b=SVtOZb8XIf5q9bzXulJfpZe4ZA3U95VKJ5KxOLjFk2JZejvxXGlEMYUuv8OZG9k6JKjoSwB15YpnavIxR4+cZ18YAn6XdeEyx5RODPPbxkqsPlik+DvoZjdMWr65mO+9R6NCByGuaXao4mtW45Q6zesH1tD1kH+RTJ8IshP7vK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639210; c=relaxed/simple;
	bh=uO+eV4aZVfBwQEB4CC07gNteKYe4Wixr9odzUwRols4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2u3MTKuUJxBul+PmbIsAfJTX6ZQ4Da0pHsRdJhSK0mmTso12Rk+45flJerYee3VjV/7nqOGVwwrq+VCbVHreXawJ4wU4Pg+U5JJb3Czm6q7ZQ5m3xorjivxw1dUoGaBJ++7VUaByOjZMDiQXJfwtjRaR9G6RLy6Jb1+fjA1FtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCxAurar; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso5836103b3a.2;
        Mon, 14 Apr 2025 07:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744639208; x=1745244008; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VC1oKsvn3gXo/XMH+Dp5lmVzBwV+v49dkge2W+EDw4w=;
        b=mCxAurarGo5GDqBZPmr0TLqXy4PPLg/ex5MfOAincp+g1U361ytb/sm4/kcHHeYLZO
         7tXmnhsmE1gqilbCKPf4p5N71j60H3bI/50yfWcF2LyIh5PIhhg2xHmApl8mdI4jn9H6
         W23vLp7O6aPEadCxd54JEEh6SAdf7UN49GyOhkFwESU768Wk3cYrPFDk9mOrgXvG/xjZ
         nUghyKkSynku1ObVlEOYPDMjbSS8Zv/Vo4DfwtRNfYcHZpQVCy+LpU/pyTw1Jw38na9r
         Cl1kFt6oBU5BFexw+fh3n68WePjTiHUR7wjq3fhwNI/sq1jXfPomwWUKd7hafyCGSk8U
         +TCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744639208; x=1745244008;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VC1oKsvn3gXo/XMH+Dp5lmVzBwV+v49dkge2W+EDw4w=;
        b=ocSzbnSa7jmiL3OSdDQ1qS4BaIhV1YXMHuMF4HeIANXR/+srXBPhmLT7Nsvke047Gw
         eC0ztRj9hRppd6L5sZjNJSxiAUm+XcyNaJuzCl3S9/uBBp+tfb1h523AjwgIV/qYrsqb
         Tu82rO9L8Ecal+qfMBFA4SrigUokiQFXqnLovd+kCvg+6eJZpMtU1dSWEZBsT5tAfq9m
         z/PYUUdgCi7px9f1fsiaSTuGs6tFInd84kEPja4S1iYz97TsYy1wpXUGDIAxkIeCGpLa
         iBcOPKHFVNjO8z8AR/wvH9QkeAOdWVunE1NHZ/8vTGetrUonseOmGxmsYzi/TUWJryPl
         m/vg==
X-Forwarded-Encrypted: i=1; AJvYcCV6a1JB5b8LTTK5wFk8rejtBsAoueA9I8V1W0RhSSehq4BohBA5lZy0EnsHnRm7AioO9EhJ5EiijpTu@vger.kernel.org, AJvYcCVGzTR8SdavgAoF7T+2qEGSN/MEHaFp68xGWIe7xrN1Hs0txz56FoEKX6AZio87y+8UBDIyaqJlj1Xz0bOC@vger.kernel.org, AJvYcCXBJEMWLj42VqKodjFd7cES3lxZSmKUwc0dCmWeTP/PGgo88ysTeP1aTgUlSkBaBkZxPtV+HxAuZJAC@vger.kernel.org
X-Gm-Message-State: AOJu0YwvaHBdz5M2969OETqby//R6zlFRDSjHaO0zlY895c4AFtMK3CD
	Rt2m2U9vAIcUpcTNRiOQBRWYmkFOxqA7t1YE7Jk8c6X0Qk/Za1Y0
X-Gm-Gg: ASbGncuUDoaz/VNw5iQf1JG39OenAwN6F3pfiAtE7RcthZ+3q1QozGOeqeZ6kTOvzsT
	28E6MHnKGiyHNJAj0AhbHg6hHeiAvWeIQFwIcHCmFGhaXD4YZRCmLk+q7vJd5bza6dIjd46Ec0e
	tl1S7PI+DtlkBIuoHy+6DnREJIdAd7kJLwayOnRep3yJdQ7083NK7ePb83ENmsv08aIf2TI6Zc+
	TgAXPdFZXuS7asazql+tdDMxo+gEPH08eu2rXUT/VSb8diO1nsDE+Y5sVYvNMNUAfcmOt/tngVV
	+E1baf+3gp1XtgpNyWe5XILahR7s7Q6jnHGdDCRXXAcBn4fT
X-Google-Smtp-Source: AGHT+IEkvLlbcPEcypR/Qtt7sHwVK3dG3MFbG7DrjmG7RajsJrDFKOd6e/1/23IkcgiQxLcY6pjA2A==
X-Received: by 2002:a05:6a00:3a25:b0:739:b1df:2410 with SMTP id d2e1a72fcca58-73bd12a1eacmr16940619b3a.20.1744639207554;
        Mon, 14 Apr 2025 07:00:07 -0700 (PDT)
Received: from localhost ([2804:30c:92d:f600:d5e4:543:c403:4767])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73bd22f0fddsm6603043b3a.112.2025.04.14.07.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 07:00:06 -0700 (PDT)
Date: Mon, 14 Apr 2025 11:01:16 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ana-Maria Cusco <ana-maria.cusco@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v1 2/7] iio: adc: Add basic support for AD4170
Message-ID: <Z_0VLLmnefbzOj2y@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1744200264.git.marcelo.schmitt@analog.com>
 <5f79007f0b9f9f67360d04fb904b6a59111a4ebe.1744200264.git.marcelo.schmitt@analog.com>
 <9c115086bd574b6c778a093143ebf54e14d7202b.camel@gmail.com>
 <Z_k3e1DfxmcJgQeu@debian-BULLSEYE-live-builder-AMD64>
 <20250412171920.531993c1@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250412171920.531993c1@jic23-huawei>

> > > > +	ret = devm_regulator_get_enable_read_voltage(dev, "refin1n");
> > > > +	if (ret < 0 && ret != -ENODEV)
> > > > +		return dev_err_probe(dev, ret, "Failed to get REFIN- voltage.\n");
> > > > +
> > > > +	/* Negative supplies are assumed to provide negative voltage */
> > > > +	st->vrefs_uv[AD4170_REFIN1N_SUP] = ret == -ENODEV ? -ENODEV : -ret;  
> > > 
> > > Maybe to early for me but the comment does not make it clear to me why the negation?
> > > Won't the regulator return a negative voltage?  
> > 
> > devm_regulator_get_enable_read_voltage(), regulator_get_voltage(), and anything
> > about reading the regulator voltage returns either a positive voltage value or
> > a negative error code. I couldn't find out how to read a negative voltage with
> > regulator API. So, for now, this is making the simplifying assumption that
> > the negative end of external reference supplies is always below GND level (even
> > though they could be positive).
> 
> Hmm. We went around this a long time back but I can't remember what the outcome was...
> https://lore.kernel.org/linux-iio/544AC56F16B56944AEC3BD4E3D59177137546EF3FC@LIMKCMBX1.ad.analog.com/ 
> looks like the thread.
> 
> Take a look at dac/ad5791.c for example of a negative reference

AD5791 references are always either only negative (V_REFNF, V_REFNS) or only
positive (V_REFPS, V_REFPF) so the driver is fine with only adding a negative
sign to the voltage obtained from the negative supply.

AD4170 external references can be set to a negative voltage in some setups, or
to positive voltages on other setups. They're also constrained on the resulting
nominal reference voltage (REFIN+ − REFIN−) which is typically 2.5V but can
range from 1V minmum AVDD maximum. From that perspective, maybe this could be
abstracted as a differential voltage supply? Though, the multiplexer in the
chip can bet set to connect individual REFIN+, REFIN−, ..., REFIN2- supplies
ends to ADC analog inputs so an API like get_voltage(reg, &voltage)) would make
it easier to handle those configurations.

From the mentioned thread, I see no hard objection to extending the regulator
framework in that sense so I'll start working on something to provide better
support for these cases where we have negative voltage.

Thanks,
Marcelo

