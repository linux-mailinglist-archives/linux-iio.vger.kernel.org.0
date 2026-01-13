Return-Path: <linux-iio+bounces-27662-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C23D8D17A8A
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 10:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D110D3013983
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 09:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94754313554;
	Tue, 13 Jan 2026 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqW/5dJ+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB5D3314DE
	for <linux-iio@vger.kernel.org>; Tue, 13 Jan 2026 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296745; cv=none; b=im6e9iYlrbm/tzGkXnlUfn8Bbh6laWwDQzxIQ6wX1qW82ei2dcWONj78WNXKYjh8lDenQGB8FnSEKto8O9pnNUJHxYfu+esWK3VffLmjTFeRCvR/oK/kPCw86mRGwXT9o7ICI+naW06Yh+TiDdJHGVZAP9HGcLW99pJ2stpLtlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296745; c=relaxed/simple;
	bh=JCofhHvfd53o1WBOebwHnqNf6NcT5WNMbWTXNYZjET4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9WaLfa3KLggqM5L7IkwoOWRSBEmpGaIwRN4I+hDCg+OTxdMMx/egGNXm/fpReSUNibq0FG1uaZmNzVqK999wwvBjhUrTLNR7sJrioQpC+Wy/MEFybMQw2g90HmPRMqeart5oQHZxjZSW5NrUQo65llRGX1hYC1u01CzbXXjZq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqW/5dJ+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so80180735e9.2
        for <linux-iio@vger.kernel.org>; Tue, 13 Jan 2026 01:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768296742; x=1768901542; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ANTY9iO3ws9nlii5Ngz1Ms3uxXBQsWZtayLTatXiQoo=;
        b=EqW/5dJ+DJbL4jqELu35Q2PLnnzkuneIqWs8M1suNF8PKedeMQbGsTznUAQVE0Xtbj
         P0+DxMo4A2pwS10qJJ7C9met9k0nJQzSa9YJhSnmcQ+zRiqQyLmwSoZgyTQbNlbdbtuU
         L//JJ/2fOsr1JvP5VD/+/s30MRnJOyGgQkN5FPtoXZ7LSk25U7NIxDzqDno3+SJm1vgv
         PXjERp+9O/6TPUHuOnSeUX9ZxhVJINaa7uvEc7gNGmbaBRzUqGoaESgzscO2ENOitMyt
         JobpWWttuJiWrnlaNNa3HHybPZ4LniRMIvht0ZVqEpE0TpmYAU9FXRDGpu8lo1EGJFif
         WiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768296742; x=1768901542;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANTY9iO3ws9nlii5Ngz1Ms3uxXBQsWZtayLTatXiQoo=;
        b=xM214dlZxtY2tMBKQZvdcf3cx+q9hEoJlyHKSMsOgfUsgVtSJSgsXkfAxGZuiJff4v
         d/86DARjKTzZPJPtmJL+FGYmPbd0ih6KyXE8qCFdsEubF/f6wj7CmEu3G3A4bIZr0wat
         5LBPpLY/UZzpa8wI7VmmfE+bThNIGOA8bOtT8MV+Arll8A33PQ4FMIAgy6cyfXK+9tq+
         DSDFBIvTg8VLjkZlerwafH5l/N9GUL37LSPVS/HTWsZ1G3/NC6cZMain6/L4R7fInYR6
         KNaj7hVoE2UH80ntyzM6iqfgkPbmpTjR10Ddvjs85ALyzzUpG9qnW4EmtCYB7PgpmLnI
         e5bw==
X-Forwarded-Encrypted: i=1; AJvYcCVF1qOeyYMBDbTgwFN5K6RsE5OPF0zSoUgyE/pN5HrnM00Wb5jeK9CVbrRhxZXV/Snma/zVddUaGlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNtaE27kTLPJJOn82Txv3FNeVMuP7jCkCR9J5Aq7Jdl8GkxQY4
	eP0wXaterEWUJUXnAoXcnADEYy4MvW1a1Wj3Jwra23++hfoj35QUmseS
X-Gm-Gg: AY/fxX6X0wTNCkenvq3WNrZR6DlZCI51JMt17QmflDTjqDx7mpKyZWdzdjRIM/D/ESM
	AxV6MBGXbyHF672oUPlpWPu1FuDhctq7qMyJJOOvgRs8KhYdHWkYl1T6RJkJ2sI6ev8vHNiYmdU
	J5mKb9m9H7qbcf8QjCaARTvj4LZ2eBNOioLBKhUv1IBh6Kxea5Wsnsy+nGl2X9qqlpQGgvG9vcZ
	mzKBdqV1EWRjPWUUItzLQrKHtWfsIyXF444w/bxdDznx/Z6VK6W3CQtjTNVMfwPOX0h5qJD6XyE
	ks37oW2E1oXjn2Q1Bu5ALTwuyShjGmS/JXVZmC+09bF338hlxpIQeELR6LfNFwMgAtB/WzWlhZb
	yBznZnxJFKXaIT+zccuP2XFWOSTNsL82KeGWQngIY3V6wgVr9/dDlHO+UoozESS5wPwtb3Yhkso
	T0ve+CWh2E/NcOgnMmeNbgObqtcPP+WLH0e7VLSsoShOzWv2FwOynqnbTgss9sbXK5qQWsZ0nlF
	BWc
X-Google-Smtp-Source: AGHT+IHPWudwQOiLLEqOGkatQsiBH7DQ1193X3z7HKU4y1KwuYdZs3UMS0CdHAkgb9M2SUjSqY0S1w==
X-Received: by 2002:a05:600c:c4a8:b0:477:54cd:2030 with SMTP id 5b1f17b1804b1-47d84b32788mr235074135e9.21.1768296741510;
        Tue, 13 Jan 2026 01:32:21 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df9c5sm44254562f8f.22.2026.01.13.01.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 01:32:20 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 13 Jan 2026 09:32:16 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 2/6] iio: frequency: adf41513: driver implementation
Message-ID: <lwqhf3pm5xewtx4hhq7ei2yil4skmtkstqfifif74u4e5jmtzh@wedhpibvjepw>
References: <20260108-adf41513-iio-driver-v3-0-23d1371aef48@analog.com>
 <20260108-adf41513-iio-driver-v3-2-23d1371aef48@analog.com>
 <aWFPEa9HI4wmYLpn@smile.fi.intel.com>
 <6hcqrcy3meskddrklb3jtlpca2snrs4upwms56lhq7mkes7krm@vdiaqkfc6lgg>
 <aWTTs1n_N0dVjpbV@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWTTs1n_N0dVjpbV@smile.fi.intel.com>

On 26/01/12 12:57PM, Andy Shevchenko wrote:
> On Mon, Jan 12, 2026 at 09:56:25AM +0000, Rodrigo Alencar wrote:
> > On 26/01/09 08:55PM, Andy Shevchenko wrote:
> > > On Thu, Jan 08, 2026 at 12:14:51PM +0000, Rodrigo Alencar via B4 Relay wrote:
>
... 
> > > > +#define ADF41513_MIN_INT_4_5			20
> > > > +#define ADF41513_MAX_INT_4_5			511
> > > > +#define ADF41513_MIN_INT_8_9			64
> > > > +#define ADF41513_MAX_INT_8_9			1023
> > > 
> > > Not sure if we want (BIT(x) - 1) for the limits as we have non-0 minimums.
> 
> Any comment on this?
>

limits for INT are taken from the datasheet as is, so I think it makes to leave them
like this.

...
> > > > +#define ADF41513_MAX_PHASE_MICRORAD		6283185UL
> > > 
> > > Basically I'm replying to this just for this line. 180° is PI radians, which is
> > > something like 31415926... Can we use here (2 * 314...) where PI is provided in
> > > one of the used form? This will help to grep and replace in case we will have a
> > > common PI constant defined in the kernel (units.h).
> 
> Any comment on this?
>

will adjust as suggested.


kind regards,

Rodrigo Alencar

