Return-Path: <linux-iio+bounces-18897-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DA5AA4DAA
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 15:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933CC1BC4532
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 13:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DCF25B1F9;
	Wed, 30 Apr 2025 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZL+C8uQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277CC1DA5F;
	Wed, 30 Apr 2025 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746020347; cv=none; b=B5S2bupGcZqP9aIV9IX83pomHKvYKC7JFsSPXyCvldhRtlDRD1S5KzvRnA6xBP34eoqDauo+dKP//uhgyl3coM23myVHK2kyL3LhHwNj7y7VmjH1dWjMbTECi1p9DaY0u1pp0C/iBVf/Yw5ZNeRW1Zo3IGm/CqAg9Ju4jfL98vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746020347; c=relaxed/simple;
	bh=9RgnAnK8k2kVAv95vWDTRw1vc8lDj3UdGl2dLXyGCak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+W8qZdlDQYWXwj9CzhtuWA1soaJRIMsFndq7PKkcGb9KBvQvFMyreWSa6rfYHopqpntmCpdV2w9kcFItYZCMEFmVh1vUfKu/750iD7GftqoKruOeMgmeUwXpjbZokitY1nsPx3NGcxjabnIDlgxCzHTRoVv9VelLn98yVgyOTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZL+C8uQ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-af548cb1f83so7326212a12.3;
        Wed, 30 Apr 2025 06:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746020345; x=1746625145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1DjowUV8AVrGZAK+3LQN55Odye2sBsRajCLVx/6jPqw=;
        b=bZL+C8uQP7UKIWBLK5/e6y8aOsIY0hf28gM7cKYlIpMeaz4LDf+WuA+c6cwl2ndkjd
         9iWjvgZDsLRgpjzUNj7xAIrvIQ0LUrXOcseDP377YrjN/EkjKRpzTQk9Ha4S/vjmXSBg
         Yd8Qa53d64xIukT0httakJWdCL8mAOvup18o3rGXeVEAZy1unjTekkfi6uy3FuYC8fV8
         5eHBE4wVnzuC97vg6cvMF94jVMdHSJxOTmvltqV1B951bMvUXdJ3n1ppH2S2FtpVMG/k
         HQlMn2SmHdGoZwout5dsQYoxYPnd5c7u3JO19XwtcbkKnlZv6hjTenNOgK6iWxL9ysII
         9mlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746020345; x=1746625145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DjowUV8AVrGZAK+3LQN55Odye2sBsRajCLVx/6jPqw=;
        b=XD05C/iJfjrjc5q/gN6QK9oBRxbCPDz25DbRre284Gb5gOdr9p3ErHyySg820nnJQq
         iLxgocdvGhDwluxemDw3DGlBJU6RLC92MCgN5te3U2lAIFCM8izaWPlrdGpbkCB7mo66
         ZmertdEaYN2NuadHm5Exp9y6cDO1d3g0qIzw9M2WuoT2K75kKOniDePORWuUYOrvnwE2
         VJ7/fefA4Eyn931AQmYJ1/jBzkli86NOtEOQ3m+RxxSsDMDw0lr+Haf+3QQRIGU5pIxz
         CAkojwnnGzm9e7LGRBbCkCFYACIR+KfrSGslxJgBJBNuNVtkIQA0WFIrQ6d+zayIeCqy
         1kwA==
X-Forwarded-Encrypted: i=1; AJvYcCUgnvDtzcXWq0Jg/CAStfeBh2sOVZHNWbNzPoWQdvwoP38MbvN9qAI0TnvZz1kMWJawgZTwClr/SEv/@vger.kernel.org, AJvYcCVh2CI9zErtQem2ls7PlurM+ornSV3snFcKv5S1NmYKBqqoQ1R+905PWCzyRIEfalxQPZTQgJocfqpD@vger.kernel.org, AJvYcCWtW+qcs+HP9BxpFbcFsLQGXWR3iVrXoz+j+54Qr6NFRWYSkuqct/IvEpD9QeMgZeiSGQECOzt5wnLzMu99@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhmjfd/uEUnBGKhWBUeI7rB/t/2P/sd9N1q4BZNzRgJMn0RmQd
	L2RMsXwNslfAiE1SrXOcnWVJ0R3K7JNll7bODtbEOqY4Ov+CIHAG
X-Gm-Gg: ASbGncsTF+OPRGkIpP8t1WxDMZLArmU1NzDUQTnaRdC6UH9iaNw/PBctkf+SI7wEEpF
	7nzpV/cqkoLd93i094ujVwN1/GnLEwx3uUp0BOLQ8tzmtaCIraihrUXl3qwQCeaYR6JEZL4X9pf
	V5WpCFQpc126Qk82cCxlYqJBQd/dCiShaF5GpiR3uyVYnaH0Z8ZBVQTyYIVZczYx9VUpqHiMOOA
	L3EcWutVTEWbwtrq2oHgNMMsc1Bo8pEVuNltIdNdnro6ssP2vM/e3v/PNiEsMM+oomBdxJjajv4
	YKaXy3WE6iBgTKQ5/IijgzVpHO+R/qzSwl0gaJwQRdsSJgs=
X-Google-Smtp-Source: AGHT+IHTFhP3XUBYbZB6MG275w13jDUH3z0KeXJNhgwyzETDucH3U2skL7WeKaDOmozDjElhzS8maQ==
X-Received: by 2002:a05:6a21:4006:b0:1f5:7df9:f13c with SMTP id adf61e73a8af0-20aa46861femr4081691637.41.1746020345274;
        Wed, 30 Apr 2025 06:39:05 -0700 (PDT)
Received: from localhost ([2804:30c:90e:1e00:5265:5254:2e32:7e5])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b1b82c7adedsm7095052a12.75.2025.04.30.06.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 06:39:04 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:40:21 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v2 3/7] iio: adc: ad4170: Add support for buffered data
 capture
Message-ID: <aBIoRc-gpBswohe-@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1745841276.git.marcelo.schmitt@analog.com>
 <db98c6cc188b501d914293268b67b0bdf26a4a46.1745841276.git.marcelo.schmitt@analog.com>
 <CAHp75Vc9CMqkkrEjgGEYPnmkb1R=u+RUvD3FAZ+7bFqi5aDzdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vc9CMqkkrEjgGEYPnmkb1R=u+RUvD3FAZ+7bFqi5aDzdw@mail.gmail.com>

Hi Andy, thank you for your review.

...
> > +static int ad4170_prepare_spi_message(struct ad4170_state *st)
> > +{
> > +       /*
> > +        * Continuous data register read is enabled on buffer postenable so
> > +        * no instruction phase is needed meaning we don't need to send the
> > +        * register address to read data. Transfer only needs the read buffer.
> > +        */
> > +       st->xfer.rx_buf = &st->rx_buf;
> > +       st->xfer.len = BITS_TO_BYTES(ad4170_channel_template.scan_type.realbits);
> 
> This will give, e.g., 3 for the realbits == 24. Is this expected?

Yes, in continuous read mode the ADC outputs just the conversion result bits
(24-bits) so a 3-byte length transfer is enough to get the conversion data for a
channel.

> 
...
> 
> > +               return dev_err_probe(&st->spi->dev, ret,
> > +                                    "Failed to register trigger\n");
> 
> One line?

It goes up to 89 columns if make in one line. I know there are other places in
this driver where 80 columns are exceeded, but in this case it's easier to
avoid going beyond 80 columns without drying up the error message.
Anyway, I'll make it one line if it's confirmed to be the preferable way to have
it.

Thanks,
Marcelo

