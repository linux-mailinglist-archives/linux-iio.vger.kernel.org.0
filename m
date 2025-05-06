Return-Path: <linux-iio+bounces-19211-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C229AACDDB
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 21:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B7D3BE407
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 19:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5FD195FE8;
	Tue,  6 May 2025 19:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hiq8mh3H"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5BCA32;
	Tue,  6 May 2025 19:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746559005; cv=none; b=eBMbXcTOCYEC4QIUyHs6fJ6xrqrCDtG4SJuPkNsWtgLmJegcZeISTcaJickUqjHc2b+TPkh0iqws2v/PMCAZAW7Exa8sOATWXBsSHvc5JCeuK1foCvI2i6E7UNLB2TGE9z1M0pOxqZm+xtE0ETpuPbZdqR9MjsZzt8cgrcCiCJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746559005; c=relaxed/simple;
	bh=p4VVPvMuMmJD9uwcO8O9XNWrcNfyDjWpU+tUu+Qeu2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6XI68jZbLE1DfacSODFbLT8xtIuXFNdCe3O7CdDdR3X8hcKnbqYM3dUwRPM4i72J2P66EAGFISERJqj827sDsBxjV/IBcCKtZDkqTEryo4pi/euKa9PC61SZLqN7/ONqJtSE2CXxQqOKIWNXti8pK8IlXlz2JYx+IQbzo+/s8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hiq8mh3H; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c5c8a4a986so74184185a.3;
        Tue, 06 May 2025 12:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746559003; x=1747163803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WVxJmmYslssgL5Tj/KNiDG2Tsl8A6lQ7ZL/QRrbFUo=;
        b=Hiq8mh3HPc6aXolS8Tay7xoBz59Mb8v+TRQKD1Zz0pPmbmBpNaqXrzn1HiIkm6iPiQ
         LVbntrpkIs0y9TdIRu09CSRhcO7rW5EkO1sSMuJVTie3TkApabA33iKsF0zUNtqCdfh/
         wMTRh3ODjGEyZaFYfk7LGSniEtb0jZSkRxX6Th9n516aGOF3krpGI4CaY32bl4GELjk7
         x3mKtuZh2uKdAQpWdVKhUtZ98z4OGwz5m7tfpePsxBt1WcwDVjdRLc4GwEyXYVv/T/1w
         1w+N2HOnMnaqXCZ+yvZuf4i9lxBq3c9jo2C+9FZOU0GmfKM+RZPjqzbdtmDhRKloV2ei
         89XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746559003; x=1747163803;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WVxJmmYslssgL5Tj/KNiDG2Tsl8A6lQ7ZL/QRrbFUo=;
        b=rlJntgT0diYB+lQqyzJnylimg4y6GXkCslDM5M9cRgnpWXBDhkwW/tTstecYEBvEUz
         MZpZ5578vf9B/8fzx5+z5EIF0vGuwVU4FmfzTLr/fhtfJVPk/oCL8TEaIQVKYjaMkL96
         4CDN7jnenlpRGQZkYlZupqmSGsQO7ZknskHgonYga2rBAaCjcDZghL7BTBfjYv3xOI54
         X+c5VSmdKE3i3NFCgLKjqLzktoCbTnrFNqR7b48Ltsvm0XzOzyiCixd528JQHVCeKMML
         0+vOINbb6ytVprE4SyV943XYt1mTIGWWYmJVvWHToo7zq1IZS90Vs8/uGdNLtWXAkUUR
         UQPg==
X-Forwarded-Encrypted: i=1; AJvYcCV0lCls6U0GONzjKFANMH1vCLYKEpJz8xFxvNIDvsrK4ylbdHmF8HG1dsYutBk8KM/kHtAPtq6ikVcuRg==@vger.kernel.org, AJvYcCWKe+mJrv4vMRCgZ6LgtwCB2l6Y+v1zwkRxJN09E+HW06E3T5tZW9Hb4acy2af646ytmKvVFglVesZMiiUW@vger.kernel.org, AJvYcCXMzeW6jbVDZvBWUfp6kdhb/XRmUF/rSYn659ZxnzRvhUGw8244Nt2larGSu26qtmBoeQYj2XWfHNQq@vger.kernel.org, AJvYcCXpnA19ANSwI0ivFA2kIEfcml0Zc9gvE0/i/P9Jojzq6a3vHTZKrfYhKc6IH2ppk7BWa3AtbP2G3wt7@vger.kernel.org
X-Gm-Message-State: AOJu0YyLWSuJs64CSePc6k+q9/QkWL7f7W8YcHqP5I0tI+tOCNnfDj7G
	PKb7ty0+MkbCXCLgMCgLaLqZ0+w91O+sIK+OYL/fZrPKO1PsWXdY
X-Gm-Gg: ASbGncssF2k5hvhPnwvW2iwF3LFqn7Y3s4YB/FNiu9WyFJnbMqbXv4rtc9Z2K23fPVb
	es0LDyTc//MK8Cvxn4cOYJVdq7EQId9CL9b/SOM8Lq5Ahj/+FpdjE2jpoS/A9ElRvVrubdRcScW
	eVT0E/G/p5Js7dgrQ9FGNmivpl0hvNWvPXKW1uqekaJgC5XPutIjwPc8dayHCKFhjCuujqwNk5u
	BV4FOuz9z2+bRBvtmBPjEnHva/opA/U5Z2qW53jDiSN6NAm40DGzg6FSaHlJi9QQEU49IohdUb/
	UNiIq3S/YnhOoV5xmvpOuUV4wDSK/7I6R1CtJskP4IsVbcw1+ZujMEF1gJoAYg==
X-Google-Smtp-Source: AGHT+IHb6zORCpCsDe+H9kUbH6FM1JLyxTUSo3SGjUn1jiW3YFAKGcORBuxjIUKCNdDBUlGrRk0hkQ==
X-Received: by 2002:a05:620a:bc2:b0:7c5:9ab7:3012 with SMTP id af79cd13be357-7caf73fa534mr23968485a.11.1746559002851;
        Tue, 06 May 2025 12:16:42 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([191.255.131.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7caf75b87d5sm14986685a.83.2025.05.06.12.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 12:16:42 -0700 (PDT)
Date: Tue, 6 May 2025 16:16:37 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	marcelo.schmitt1@gmail.com, linus.walleij@linaro.org, brgl@bgdev.pl,
	lgirdwood@gmail.com, broonie@kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v6 02/11] dt-bindings: iio: adc: ad7768-1: add
 trigger-sources property
Message-ID: <aBpgFQ+/KBXdvyWx@JSANTO12-L01.ad.analog.com>
Reply-To: 20250505163919.6d805db2@jic23-huawei.smtp.subspace.kernel.org
References: <cover.1745605382.git.Jonathan.Santos@analog.com>
 <128de2793d6d5424ad152c394faf1d51f0d56e0b.1745605382.git.Jonathan.Santos@analog.com>
 <20250505163919.6d805db2@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505163919.6d805db2@jic23-huawei>

On 05/05, Jonathan Cameron wrote:
> On Sun, 27 Apr 2025 21:12:16 -0300
> Jonathan Santos <Jonathan.Santos@analog.com> wrote:
> 
...
> >  required:
> >    - compatible
> >    - reg
> > @@ -65,7 +95,6 @@ required:
> >    - vref-supply
> >    - spi-cpol
> >    - spi-cpha
> > -  - adi,sync-in-gpios
> 
> Maybe worth requiring oneOf adi,sync-in-gpios or trigger-sources? 
> 

We cannot do that because we defined that self triggering is enabled
when trigger-sources is omitted (is this case adi,sync-in-gpios is not
present as well).

> >  
> >  patternProperties:
> >    "^channel@([0-9]|1[0-5])$":
> > diff --git a/include/dt-bindings/iio/adc/adi,ad7768-1.h b/include/dt-bindings/iio/adc/adi,ad7768-1.h
> > new file mode 100644
> > index 000000000000..34d92856a50b
> > --- /dev/null
> > +++ b/include/dt-bindings/iio/adc/adi,ad7768-1.h
> > @@ -0,0 +1,10 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > +
> > +#ifndef _DT_BINDINGS_ADI_AD7768_1_H
> > +#define _DT_BINDINGS_ADI_AD7768_1_H
> > +
> > +#define AD7768_TRIGGER_SOURCE_SYNC_OUT  0
> > +#define AD7768_TRIGGER_SOURCE_GPIO3     1
> > +#define AD7768_TRIGGER_SOURCE_DRDY      2
> > +
> > +#endif /* _DT_BINDINGS_ADI_AD7768_1_H */
> 

