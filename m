Return-Path: <linux-iio+bounces-6954-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99600918280
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 15:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56DF5281D02
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 13:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00194184123;
	Wed, 26 Jun 2024 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G75Rmuus"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9DA181BBF;
	Wed, 26 Jun 2024 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408782; cv=none; b=CfSXvsH9ol2EXxAEN2SQTCYUJ2haQLqIEoYZvfnJ44euzUd67+nX/JTXtAIUED2Rs+NuQmWS8dKPE345dHWLN+1xVd6UMrhegIp+uQu3YVUfVNRCFCkm62MtbLNqka+bYKracY/26bf7BMWIfOwV+FqzkMfqIl/vRIiZaMwuYx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408782; c=relaxed/simple;
	bh=BtIEJ29GmbJjobMmhUF/L75Shxh4CvTEph4ds53y3CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEOxo2KdYN1vK8iWuI9K5kG7AIsNcATQ8Y6Ua4L4AFt0vy4FwMWJuJNa5LtzFIFcHUXmFcZPjYgiSTGvssf0wh67OKTlMcdeG45e2/YZMU5n0mGwLbIOfQkLVE+l5hRt6vcttiwzcLFQ0MuQ3+eHWuYlND3Cen00h1xeshSrzn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G75Rmuus; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7066f68e22cso3082388b3a.2;
        Wed, 26 Jun 2024 06:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719408780; x=1720013580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U4SpG465Zq0wFUQJD4T6CGPlHVUtjrzjJUeqwICCVB0=;
        b=G75Rmuus+EXmc2Kii4VxerNR72vBNVLbomkr+hGZ1yn7wlbFSfOH8RWlVVCCNCJF8N
         Prp66LhTMOlloXzJChjnZVsX6lCQMH2jMoIdLiAl0l1n7q7wbmJ82q+tpaQgS+IZuREY
         BSJynVaWdpUF0lEfFe3+9uxfnXcI6A0hLBrwya48nPOu4zhOHYWMFCEklhKPC7UaIEsG
         5aMh95Pd12pjKTylQgVqcP6p8fCr6uqrFk7LoAnIPUiUkATpC6VbEYxJdSxw/3zbSWDi
         1P5ZNZW81Qe+eVVF1rJNvhczoMJfvk6kw9oWEfeKiwBu9/aoWpMG4FQy1Z7Y33cS/vU2
         gdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719408780; x=1720013580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4SpG465Zq0wFUQJD4T6CGPlHVUtjrzjJUeqwICCVB0=;
        b=hsVJ/cE82dxFywRH4aNbAwebJukcgKy7WCwquA1YXffEUEnh2dFLgRpLFphGvOcS8s
         ZPzUNstyLx7qBVdLmLzgDgwCfs9SZpvxAU6m8ZX0ZK59tLond4OQjE7CyM6HB+/ylyox
         77cT6vymU2UcaFn8zb+iGA/FL20piIGD0UB5LSp8LvWyE/Hl+LCjUt2JwKj0Td+LP/dL
         d0SUwSFXaqHmzPn2PEdLSbpJr10f9X6QserPgUyzy7DuATMR0UHioLzHuO2+ZMfbJCvn
         w4MqFchbNWecUhJVJNVFyuT78AQ3lp6LZEQZO5oz1PbfWUZI2tN1mhdp6snunWBd0bGK
         jC0g==
X-Forwarded-Encrypted: i=1; AJvYcCVybCFrE22G1FwUKJXGfsYRIboJjB0STRTw3/Xb83szYHcBT/o9dbbKCRhA1pXhJxMhrzjg/KkrenpP6ZL0BuH0GUN8Vs/XA4rPwAoRJMXbDYrQIyUjt6cPf4cfW78omM5iguA/fiIcQmCgh2UpZ25tlwzyQOIgpOyPBO/7V7uwtYWqsNPq4PZXfRoB3QuzGJqVU1L5TEUaf+OfIqNDlrSRNCtM46ZMBZFqo2JjMxcOsbWsp8wYkGf/0g==
X-Gm-Message-State: AOJu0YyN+Wp9qr0VcLBUHmvbtEkJGKUorjSaR/9cYTHYSP8msncvxipf
	j3FdQAkomWQe1RxpBGiBfUySrzHyFuBVEHiJ4Y9uZYEuUTDA5dy6
X-Google-Smtp-Source: AGHT+IER57KcsE5A6v0eX5mNYLuzZpa08lQwfGmIk/QpxqLOfeNqNB0VfK27wnjYzWXj4yOGmexT+g==
X-Received: by 2002:aa7:9a1d:0:b0:706:6ad6:1866 with SMTP id d2e1a72fcca58-70671012a58mr10321399b3a.30.1719408780319;
        Wed, 26 Jun 2024 06:33:00 -0700 (PDT)
Received: from localhost ([2804:30c:96b:f700:cc1d:c0ae:96c9:c934])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716bb22dffesm8796040a12.83.2024.06.26.06.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:32:59 -0700 (PDT)
Date: Wed, 26 Jun 2024 10:34:24 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	corbet@lwn.net, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/7] dt-bindings: iio: adc: Add AD4000
Message-ID: <ZnwY4MqCYFKUNtL3@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1719351923.git.marcelo.schmitt@analog.com>
 <10678612efbbd97bb47a31f4a062607cf35b03f9.1719351923.git.marcelo.schmitt@analog.com>
 <20240626-handbrake-mustang-38c2aab3f04b@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626-handbrake-mustang-38c2aab3f04b@spud>

On 06/26, Conor Dooley wrote:
> On Tue, Jun 25, 2024 at 06:55:03PM -0300, Marcelo Schmitt wrote:
> > Add device tree documentation for AD4000 series of ADC devices.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> >  .../bindings/iio/adc/adi,ad4000.yaml          | 190 ++++++++++++++++++
> >  MAINTAINERS                                   |   7 +
...
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - const: adi,ad4000
> > +      - items:
> > +          - enum:
> > +              - adi,ad4004
> > +              - adi,ad4008
> > +          - const: adi,ad4000
> 
> > +      - const: adi,ad4001
> > +      - items:
> > +          - enum:
> > +              - adi,ad4005
> > +          - const: adi,ad4001
> 
> > +      - const: adi,ad4002
> > +      - items:
> > +          - enum:
> > +              - adi,ad4006
> > +              - adi,ad4010
> > +          - const: adi,ad4002
> 
> > +      - const: adi,ad4003
> > +      - items:
> > +          - enum:
> > +              - adi,ad4007
> > +              - adi,ad4011
> > +          - const: adi,ad4003
> 
> > +      - const: adi,ad4020
> > +      - items:
> > +          - enum:
> > +              - adi,ad4021
> > +              - adi,ad4022
> > +          - const: adi,ad4020
> 
> > +      - const: adi,adaq4001
> 
> > +      - const: adi,adaq4003
> 
> I think some blank lines, maybe like the above, would go a long way with
> this list of compatibles.
> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 102040816 # for VIO > 2.7 V, 81300813 for VIO > 1.7 V
> > +
> > +  adi,sdi-pin:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum: [ high, low, cs ]
> 
>     enum: [ high, low, cs, sdi ]
>     default: sdi
> 
> I'd do this, so that the default is documented in the binding, not in
> the description text.
> 
> Otherwise, this looks good to me.

Ack, will do.
Thanks

