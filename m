Return-Path: <linux-iio+bounces-9134-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4F896B89F
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 12:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAAE51F24DA8
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 10:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F81E1CF29F;
	Wed,  4 Sep 2024 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyRNjBbq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680623FE55;
	Wed,  4 Sep 2024 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445949; cv=none; b=tLqOkh0NT8QeU2W14jb6syq91aidgyDudr36cN2iHL94pYVWgvId+q9docqrzmJhIiPt0+gEDolNTNiXiJ1wu2oAX+vTFSkdPPUpK/kp2ni6IqeJWOK9jTU23NRAM7pargYlL8KsKbQ4KNkY77nKu5adLdmIu2l8wNE8BlWI25s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445949; c=relaxed/simple;
	bh=anEU6m3eNOPoLa9wNfIs8urDAVWiH1cVaSflhuC/1vc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvkSbtFC7U8kkeDLp+7n8/XazcQO7HL6MIMGeJpjL5Yp5D+LD+OVOxEkeugv4TO3Ad1ubUw+dS18fu8TDE1kIv8r2D9jUtKQMNwyUBWNd4nvwpoZrKeriQax//lnhC8d6blHgNUD77wbVKsl/N1tn9VuwfCgFadOKhEwAGlzn8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyRNjBbq; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a869332c2c2so99281066b.0;
        Wed, 04 Sep 2024 03:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725445946; x=1726050746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6y43ZTOdkFyBvHj/I4cavJ3fR2i2TwCB+5yieqP5kng=;
        b=OyRNjBbqRuMnKY+oDVX9YEb9R8IGjywtSGVbqRZZb1+boPntzFrbdYMI2OqF+XAm+d
         SMRYzZPAIuPu4VIR48B9Q2PLN0E1okQ9ZvlF1wM4YsXXkULBQK8+Z/MScqU5KfgCgqXg
         OzOqCrmADlC9I0nYnhwPfrSagHg0IX+op9wgoxM5oaeF2g31B3Qq18YkKpmq5dqDsTv/
         rw8HvbW9cH+2RJxV/RfvcWgmAK8ZFY7mfJcjSt+eafp5lgOdevMDAWyrdXl+BkllRvl+
         5KspXFr5We88/ycADPdl8yKcDbjs7pLlUM0OSxbKCDR20IODbA/Faom6PnYlD7eRv8FP
         /yjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725445946; x=1726050746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6y43ZTOdkFyBvHj/I4cavJ3fR2i2TwCB+5yieqP5kng=;
        b=NV24yw7AAvWTyTg+E5fi972gWvHRp77I+rgv+c5JJzZhSWCcjrNMlexO/hcKFjsBut
         jHDf2w54x0WNve3d8nAlZvGI4Pcoww1qEE7vfGaq9pDObEqJuVnxBTzsHt7hTz29Iu1A
         MlMHYxtKpeVQb6my+mXatcAncO4G8ua8/6Wp5yqAtHhcMtfjSkJsbEkV0pWPNiuN+sgf
         e2Jzbxnqtz4i4KjJusoY+bGncomIxQz85+BLjlvOJA8kkPzwFammyjiz9kJuKwfERzTz
         twHjgklLgdnnELHJfqaNPPF8KGxToU2XEB7/xAB2BUpJOdb1x+l1FxLt8afoU4m6ZrbP
         JhOg==
X-Forwarded-Encrypted: i=1; AJvYcCUBxiST7PMTU11Kr6teExMk9UkgovyGFH4a4wXselAUUqpwrGpStoepTBV0XB5EqFnr8pRlgpY8+dLf@vger.kernel.org, AJvYcCWLo+bm1V430htRgTHZkpiTxzV1fx5AeturJ1M/LvL1/ijCSm0R3wG8plo7aKc8FeLmJ1OAdTO7zmQoVBYl@vger.kernel.org, AJvYcCXgY702yQYPvUri5l8O2TZEmIece/IJwwmXneKEkLQiM50UuWlsszB5QRmXUdb2jPAGPsRiLN+jvNPn@vger.kernel.org
X-Gm-Message-State: AOJu0YxGTFPH9F/SrlbWfW9olzwssqjHE9TN8qdtuaI7b+fXiZ2JEVgQ
	hnsxpfxY/kswLO/C23thwSIJ9XWRoXw1ufYn46XlMTqwA8t4Geus
X-Google-Smtp-Source: AGHT+IGND2WSc8Q1ZYYp+KK0T7oSnNH/z6ip36QiytEVLt8dFOqCf9JsHhgC21ooAfMjLSMpuDesyQ==
X-Received: by 2002:a17:907:72c6:b0:a77:d9b5:ad4b with SMTP id a640c23a62f3a-a8a42fdb4e3mr208798366b.9.1725445945530;
        Wed, 04 Sep 2024 03:32:25 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:2f85:317:e13:c18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d7368sm791777766b.168.2024.09.04.03.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 03:32:25 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 4 Sep 2024 12:32:23 +0200
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v5 5/7] dt-bindings: iio: pressure: bmp085: Add
 interrupts for BMP3xx and BMP5xx devices
Message-ID: <20240904103223.GE44250@vamoiridPC>
References: <20240902184222.24874-1-vassilisamir@gmail.com>
 <20240902184222.24874-6-vassilisamir@gmail.com>
 <mdxfwawym2tn3afsbq4jmygfkdokpleb7p2deomraqwjc6k5qu@laj4j3fw7k2x>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mdxfwawym2tn3afsbq4jmygfkdokpleb7p2deomraqwjc6k5qu@laj4j3fw7k2x>

On Tue, Sep 03, 2024 at 08:34:22AM +0200, Krzysztof Kozlowski wrote:
> On Mon, Sep 02, 2024 at 08:42:20PM +0200, Vasileios Amoiridis wrote:
> > Add interrupt options for BMP3xx and BMP5xx devices as well.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  .../bindings/iio/pressure/bmp085.yaml         | 22 ++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > index 6fda887ee9d4..20b75865e02f 100644
> > --- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > +++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > @@ -48,14 +48,34 @@ properties:
> >  
> >    interrupts:
> >      description:
> > -      interrupt mapping for IRQ (BMP085 only)
> > +      interrupt mapping for IRQ. Supported in BMP085, BMP3xx, BMP5xx
> >      maxItems: 1
> >  
> > +  drive-open-drain:
> > +    description:
> > +      set if the interrupt pin should be configured as open drain.
> > +      If not set, defaults to push-pull configuration.
> > +    type: boolean
> > +
> > +
> 
> Just one blank liine.
> 

Hi Krzysztof,

Thanks for the review. I can change that.

> >  required:
> >    - compatible
> >    - vddd-supply
> >    - vdda-supply
> >  
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          not:
> > +            enum:
> > +              - bosch,bmp085
> > +              - bosch,bmp380
> > +              - bosch,bmp580
> 
> Are you sure you tested this patch?
> 

Well, before I run only make dt_binding_check but with the option
make dtbs_check I now found what you meant. I think I miss a 
"contains" here. In any case, make dtbs_check showed some other
warnings as well which I will address in a follow-up series.

> Best regards,
> Krzysztof
> 

Cheers,
Vasilis

