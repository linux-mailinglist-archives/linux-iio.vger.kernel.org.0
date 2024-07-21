Return-Path: <linux-iio+bounces-7775-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCE2938671
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 00:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47139280C4B
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2024 22:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7435416B39A;
	Sun, 21 Jul 2024 22:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdYLXnef"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A418816631C;
	Sun, 21 Jul 2024 22:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721599959; cv=none; b=ZIQYXH/tsM2JI5Q/KhnTzNOlyD199/et8moam3zK7PNmGXQAUW9M8Yz9qgikXoaeYMdMRy4TD2xDEkcYOvaxmQMPJCmsObVcFYrbrcBeBGB3IgMNwLSEKFJFkQCnsjP4fqQtrZf2/8R1a5BCnVZ/xABS//f2wAdJB5FhYgmBoug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721599959; c=relaxed/simple;
	bh=ssAet6NaoCRi4CGu4pJFZtNUATo7K8hRrWiV02XYERs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NY0pR28zW3xEL1EIBjBUsPYyDDgOx4elGbUxxshE3LGRw7dLDbYDEMAvIQsqWl/27W2VMkL4RUuSevo0DnmJPgzZik+N910O0L7jS1Fl/vhSvuNoKVKEvpMCdQndkCc124EnnAYkmi36Y239NpptkHeMw5VU5391S4TCMlyDyuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdYLXnef; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso340758166b.0;
        Sun, 21 Jul 2024 15:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721599956; x=1722204756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2riOrPqtFijzbUtT4zXARC/Opr4gkzsVUj5TAbyWo0=;
        b=hdYLXnefz1glQkXV6DpcfGjKsxB0dV+LhEHCcjjh3pE/nWsLHnNYPsp+8JLT9Egjb5
         mcGr8drfWIm2TZnJl+z36mWyhvK/uKUKydNR1STRE7QnAImTeGLyfY7MWYzk9K2IaRwU
         bnqMgKSEuGIpi0WNq0vw4YriLRsmtEniVAdji4L+V6TumNaFGref5swHejQ45e9W+/Qn
         oPauTod/6eS+O196/zMYrBDVesXxrdABn3/hGGjyC6GQTwsm1WSXUsW/YY+IpWr6FUtp
         AvWilI9ocVxWcK8ejDq8hN9xmxuQIM5CoQje1ceUBRQYujjDTR/j/hxf6f9gnCDfKiud
         /sgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721599956; x=1722204756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2riOrPqtFijzbUtT4zXARC/Opr4gkzsVUj5TAbyWo0=;
        b=wtkfNnkz/KXMcfdttAKHjElkvWi7evY8oQIv+XkPR8Mnr4l4rFj7SE6+hBhpJlbdcw
         0Y61GcKLwLSJEQBlt00/UREsIsxbHOrV3JCN5xiRDCTg99wypGRKKGq8EpxrReiSN6Ch
         LlqCdERo1qzO0zuuqqp2h9mw+LWBhyBJVUn5pZeJB3riOwKBfsIaCT41o9rebBeJe9gl
         U+GQ+g0qqdmDvWKuSqakjFLzyBlTyinDdU353eVg4/74dVrqutSiGlsLYpfPIVG0kEz3
         bl2/YMq2+Vzh5Ow1bkV36KReJJdzeo9MLgKHQE9GDz6Vj9amg6oh1IfAZwlCqxP+cQ4Y
         lGAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaBi/rPS7kv4xSVgn/IAXOsEbEHMLhj1kSDjlMANfWAo4DX7kFyk3DUksQGGpfO7FdphhYPnBkFBtBxqSAI63p/fCO/a2pvmjZVY/9sGW3AL3lWltId9eHX7BylKq03vO3F7tcVq3/lej1ZnYbZv5MwfFcSH3S/mdqsYxa21X+8VQwng==
X-Gm-Message-State: AOJu0Yy89kqZVfdD/uyR0wr9ZIvS7AtjLY0VMsJllwikYSPQX081C07u
	PDvk4cv6HSJPmDhvWzGCgN+EVkXKPPvuroJ9GBkoCxKUayc62qpO
X-Google-Smtp-Source: AGHT+IHwPCau+jDbxP80Haz8vP1uglMf208ox9B7dYrZvhQm9QMaTBRwIv8/UBXu2xFD3w91DO48cQ==
X-Received: by 2002:a17:907:944b:b0:a77:cc90:7734 with SMTP id a640c23a62f3a-a7a4c0f440dmr318883666b.42.1721599955669;
        Sun, 21 Jul 2024 15:12:35 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:bc21:fb27:f4e6:6867])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c7be6f8sm339079366b.76.2024.07.21.15.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 15:12:35 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Mon, 22 Jul 2024 00:12:33 +0200
To: Rob Herring <robh@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 08/10] dt-bindings: iio: pressure: bmp085: Add
 interrupts for BMP3xx and BMP5xx devices
Message-ID: <20240721221233.GE325365@vamoiridPC>
References: <20240711211558.106327-1-vassilisamir@gmail.com>
 <20240711211558.106327-9-vassilisamir@gmail.com>
 <20240712124805.GA461461-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712124805.GA461461-robh@kernel.org>

On Fri, Jul 12, 2024 at 06:48:05AM -0600, Rob Herring wrote:
> On Thu, Jul 11, 2024 at 11:15:56PM +0200, Vasileios Amoiridis wrote:
> > Add interrupt options for BMP3xx and BMP5xx devices as well.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/pressure/bmp085.yaml    | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > index 6fda887ee9d4..f06f119963bc 100644
> > --- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > +++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > @@ -48,9 +48,20 @@ properties:
> >  
> >    interrupts:
> >      description:
> > -      interrupt mapping for IRQ (BMP085 only)
> > +      interrupt mapping for IRQ. Supported in BMP085, BMP3xx, BMP5xx
> >      maxItems: 1
> >  
> > +  interrupt-names:
> > +    maxItems: 1
> > +    items:
> > +      enum:
> > +        - DRDY
> > +
> > +  int-open-drain:
> 
> Use the existing 'drive-open-drain' property.
> 

Hi Rob,

Thanks for the feedback. I will also use the tools from your automated reply.

Cheers,
Vasilis

> > +    desription:
> > +      set if the interrupt pin should be configured as open drain.
> > +      If not set, defaults to push-pull configuration.
> > +
> >  required:
> >    - compatible
> >    - vddd-supply
> > -- 
> > 2.25.1
> > 

