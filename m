Return-Path: <linux-iio+bounces-6952-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B9E918240
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 15:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC71C1F22669
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 13:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03A6181B80;
	Wed, 26 Jun 2024 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4oCauRW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1BB1E51F;
	Wed, 26 Jun 2024 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408269; cv=none; b=ZO2gDOj7RGPgvzYZPhfQzvxxY7d5bj1hB0ZNGQTkX2UiLHDx4BJTIv8BJQ5xEXxWudlZr9ejrQtwCdWrhlPKBy2IEz+Af1XVdXkJYbyApce+h5JqZxIwKvCQDurEujRuURVReayLUzF+EGlQMy7IvzVIZhB8KCm9opfytYEOB6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408269; c=relaxed/simple;
	bh=jQ2TN6oLIfbGe9ZASxWBipgw5mEcx0wqxbmo17h+xJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWM3xAZojfmUbLf4q2w4JMqQ5hEPE4Xd+s6zHWdvWMRN5EOO+SX5tPontnz1fp3nVm5f2/LXPwJ078orWsbf8TRqk500Mq8204fbLZFeiPixQVNn8MecsijcID0QYTPt+u00TeWa2sXGDLDvVRkHGZG5V4mkMcwqyv6uvgRiVDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4oCauRW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f9b52ef481so54610195ad.1;
        Wed, 26 Jun 2024 06:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719408267; x=1720013067; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bLAtvvsYw1jar8biIujMee7AuEZKGq0togFn4n6p6bg=;
        b=Y4oCauRWiLohbkfXUdUCNhp5MjcdQo95zlNej9KTs7BFF1VUpbgdAi6el3LSQYEE/Q
         KucCUSyh5pbhiQNF6B1Zj4cGon9Pj1SA0xukeST35wJIskJw1w8m9YmwzZsMS4svhvht
         pVn2a7zIkkwV3xG+SrrN9oJ0mHpTFKXmxBgIaci8DPz5gvo8tNP7cRaPAca90BlFuSyR
         NdUYM1mRTm4CCvtxwmeKW9wIjjV26W93pdkPM8vH5KhFXe2ztAsP3x5g9mmXpc+rOFXM
         4KulL/uzhjNabmhNIOIRH+5xfewYZ50pQiofspNif/N7wuVQh+UtK8mDHwYci6FV3kz7
         1T9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719408267; x=1720013067;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bLAtvvsYw1jar8biIujMee7AuEZKGq0togFn4n6p6bg=;
        b=pQuTBFsYe0xOdtBnsYLop35caLTmxkjurW5Pk1rABRgWxVF1cbfhHVezWh4JGdSUqg
         egKEivIvbv4imcKRxx0p+odV6rX4LlIYljaAzqDatptj/wtAx8CK5ARTsXcP5gH0SfIl
         w3RBuY6SruPyeaP7J/IepuodgI6DK8Rs9Q5zVR7Yo0J9rapNxzXu/I8qoa+lcFpVbyot
         SkH+xnlhOYuhvx8fw09f4taFqkgeJWjfLqduCXQzACSxzh88Pw7hnemVZCqkBExQB/60
         WJMbRW1oGFDNZoZ3sRDj/jMFHsNdNrBf8zrVCdKFyFH0vZkn2U8a6RmoK9VQZ3E4cul6
         Y+Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXkvN3zns3lj9MfG/uDvXF4EQRdRvsTFk1s7rQJMUgHPclEhi9u3adQJp3TCD/uI2gjdNv/u4P/V82uvuOAvYpJb2y5UhDxnevk/GnV6ipGIhkspuXyan93QxjKff9Yx5JFoXVBQP50HWDHvtVTuh6bsJzrVDGCoomS812p196UVhLamJvniBdwbPIxWUC+BcFVNdaM3isj4wUW6wZHa4FvFDlJGa67zCh9a0GpcNRYHD2jS+s28D+3aQ==
X-Gm-Message-State: AOJu0Yw3L3YNKXauPJlxi23MnPrAQuNsZ6fJsZqPLGn4qe32XFIdlgnK
	4haebOv8FFD3KClOykZ5n0OOLLjbalzRjga5RFN/J2eWhKNd1vj7
X-Google-Smtp-Source: AGHT+IHgyOORbCN2R5XDtWhRTSrn+ht2d38zXOnrDqPLV2TOIQjmmMg+Vm9SwTXZGIZ+iNTTrFAUAQ==
X-Received: by 2002:a17:902:d511:b0:1fa:3428:53c1 with SMTP id d9443c01a7336-1fa342859b8mr96777385ad.43.1719408267299;
        Wed, 26 Jun 2024 06:24:27 -0700 (PDT)
Received: from localhost ([2804:30c:96b:f700:cc1d:c0ae:96c9:c934])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c5cb0sm99505355ad.130.2024.06.26.06.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:24:26 -0700 (PDT)
Date: Wed, 26 Jun 2024 10:25:52 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	corbet@lwn.net, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/7] iio: adc: Add support for AD4000
Message-ID: <ZnwW4Pf1OS8KjkVp@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1719351923.git.marcelo.schmitt@analog.com>
 <eb5f7b73bdf3ac89117e28f26ee3f54ba849163e.1719351923.git.marcelo.schmitt@analog.com>
 <CA+GgBR9E2EMeqAXJ=b7jMnJgd4FXZPNm-LYEe-=aKZhJBkFNNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+GgBR9E2EMeqAXJ=b7jMnJgd4FXZPNm-LYEe-=aKZhJBkFNNw@mail.gmail.com>

On 06/26, Alexandru Ardelean wrote:
> On Wed, Jun 26, 2024 at 12:56 AM Marcelo Schmitt
> <marcelo.schmitt@analog.com> wrote:
> >
> > Add support for AD4000 series of low noise, low power, high speed,
> > successive approximation register (SAR) ADCs.
> >
> 
> Hello :)

Hey Alexandru, nice to hear from you.

> 
> Looks good overall.
> Just a few comments.
> The only one where I am not sure is about the enum-to-string mapping.
> If that's fine, we can leave this unchanged (from my side).
> 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> >  MAINTAINERS              |   1 +
> >  drivers/iio/adc/Kconfig  |  12 +
> >  drivers/iio/adc/Makefile |   1 +
> >  drivers/iio/adc/ad4000.c | 711 +++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 725 insertions(+)
> >  create mode 100644 drivers/iio/adc/ad4000.c
> >
...
> > +enum ad4000_sdi {
> > +       /* datasheet calls this "4-wire mode" (controller CS goes to ADC SDI!) */
> > +       AD4000_SDI_MOSI,
> > +       /* datasheet calls this "3-wire mode" (not related to SPI_3WIRE!) */
> > +       AD4000_SDI_VIO,
> > +       AD4000_SDI_CS,
> > +};
> > +
> > +/* maps adi,sdi-pin property value to enum */
> > +static const char * const ad4000_sdi_pin[] = {
> > +       [AD4000_SDI_MOSI] = "",
> 
> Maybe I missed a previous comment.
> And I'm also a little fuzzy on the details here, but in the DT this
> property has "high", "low", "cs".
> Is "low" the default if unspecified?
> Or should this string be "low"?

The default is to have MOSI connected to ADC SDI pin which was empty adi,sdi-pin
dt property in v5.
Will make the defalut explicit as "sdi" as suggested in dt-binding review.

> 
> > +       [AD4000_SDI_VIO] = "high",
> > +       [AD4000_SDI_CS] = "cs",
> > +};
> > +
...
> > +
> > +       st->gain_milli = 1000;
> > +       if (chip->has_hardware_gain) {
> > +               if (device_property_present(dev, "adi,gain-milli")) {
> 
> Only if there is another version, it may be neat to reduce indentation
> here (a bit).
> Something like:
>         if (chip->has_hardware_gain &&
>             device_property_present(dev, "adi,gain-milli")) {
> 
>         }
> 
looks good, will do.

Thanks

