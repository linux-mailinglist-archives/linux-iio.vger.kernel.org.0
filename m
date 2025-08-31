Return-Path: <linux-iio+bounces-23508-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E758DB3D0D8
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 05:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B7E1A80A1A
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 03:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C48212575;
	Sun, 31 Aug 2025 03:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYSNMuMi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB243BBF0;
	Sun, 31 Aug 2025 03:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756611817; cv=none; b=OLYkixRn3Nva9BquqQdYDXPzCsZ69jZVkikVjOCrsXR5fcr5mupGyRVtC07DiDuSTAjubQpOLE6PNIp7VfALipeaqld95zhFA3QNDN4qpe++veG8ZyXYWoDgYp8bO0BXCISqfMgs4hAu4WelT/z/t5g0JqMES0P8fjtOyIR618Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756611817; c=relaxed/simple;
	bh=CCgAIXlr6vNsPLTZ0WDt5QpS03SDJgg31v/BcBUXsPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n87k5mDOIV4yl69BTvfanRCwEur7f0NM6CjiIMH36HIAj7Or36r1MAvaDIo55BLT4+7Vaf/Y+sPYfloaQkBAaDrWLRUL63jVGHzu2uvZCyfOy7tEv3mW1vcReIO0ETb5b6u3FfcNLfL1Gi+54QWsJjyn4LmoMRyc+p2cIwnQ3PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYSNMuMi; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77247e25a69so14641b3a.2;
        Sat, 30 Aug 2025 20:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756611815; x=1757216615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o28MJXIxWOQ5k5vgBDUjnzOPn+n4LfMbzijeAHLWGj0=;
        b=hYSNMuMiNfwrtbeAcXFqBZl4FZhmDOcoJjzM4Cw8wP6mxY3Vbw1mO8AQnDM3BFIKmM
         iWC8PE/53Zm7HNM35Vh5SXOBwGmqUxNi9N5VcXB+gm3EtNTBz+EMRX+jrYFHqOoB52Qv
         +eK+8U0iOXAtccJwe5UOnhCKhR3LvH84QJ4Zo4IzYa81Jrn/VfUm9e2gb7WVISu/A/nD
         nDVwl+EQkJu6GQzaeMeLL15hSoL1ujCrmQOQCe3QqoQQwdCNKzO7wy/iVWv28d1wSQ5b
         tmmSmcNgZfSVfkZJpjuu+qxAOH1dY7dnUxX4uer7PBqXCWO90OosrsLq3gvGmrNZGNL7
         KNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756611815; x=1757216615;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o28MJXIxWOQ5k5vgBDUjnzOPn+n4LfMbzijeAHLWGj0=;
        b=c9acorXC+bTbVNMf3sBeq4rUPNv9BK5SWrhEPZGPnYPSLUcCFsn3i+0ux1glBiAOV0
         GeYO+Oy/y/cBCkDAtBpdWpZK6R7MWitXKdP3UgKIdWoTlZNQQnIuVObAkMriEZ0ISyya
         FQbYYxEdm5XmHv38lSj7hqcIcmSVH3jX9otmpWfwj1lO87gvb6/tRHeihh0AlmuW8/mi
         YeHLf4pKanGURh0cfPDZ29uzzkqYt75TnwzERHiWksIStBk26DhpuZjr0BKSTbJDqyyo
         tbqru+z/Ptm3XHSgzys9TDHVzNuXEWIl0ex2btppT3a1xSH7KPOLM6XrRcy13IwjwZ4v
         /oSg==
X-Forwarded-Encrypted: i=1; AJvYcCU9IZl3F90hxNeDyayzE3o5JeOWm571BKUQZB2rHYeRyfNsC67ElijohLjxOA5nJ51kkkjgLU+I+qfd@vger.kernel.org, AJvYcCWYTdoj/4XGqhgwn/q6JSDJ5SMQyMhP/VeHXuKGpOVEueUTo6lHntxKNI8HiWdbg39Q6GAq899l6P2B@vger.kernel.org, AJvYcCXWL9IDve6HqgxK15m15z9q0dIFFw3r292Bkgsw9u/FhdJGNO3aH7RJKIpxGJ+gLWPIgRbOH/WuYrEEwQwK@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3QJ0Uxw0pPGJuNljT1nus5AAXsIzGecAbULXTJSmRFWIdAGLR
	B1vN8pt6EMtZniB436iwqsictG2McozHfYfXmllu2BoHAOlp09XuN0oKW+mooIHreZI=
X-Gm-Gg: ASbGncsjpqTishfe97ovIyhSkf1bYi+1Ml1x0FnlJCaAG0QS9TDStsRK05fra3uX3qF
	d5ay/6/thOXVQf1kD2xVxa939lPXg+N72WZk9PzwxcAZDLwrSH7sOOWqmixdlX+HU5AXr93JSRs
	33VweqCR1lqsuFrqehY/ujFyXNDyhqaGgXoK1qbBRdT4UtQysp8KKfvlfe3Gy0l3ifi38o+vN1B
	kqyro/d72IfwT3iwfsBgSX7bBlqydqeRDrrkXf2DWZP4tuAEE3NK+kwtbVDAbWPOWceWVQOkv25
	vUNQwK/S/VywjdIokGerIsvCjX8SFnjxwEZT+i1YMdwz5p2dzH6WhM2IMekn5pjTCn9/czRwWJh
	BoMdG9ShhT6t+qIYJK6Tu191MVRWgaR24xvDotA79stsw0O61eY/wz14mC+Dqai3/a7j2fRVGkt
	YocruAcA==
X-Google-Smtp-Source: AGHT+IEGnL7/6l4UZJDjwdfZyfX1leGyM7yvxQ95h54ZDu29KNmGjx9+VWdU4UoG7F3VLufYG2NlTQ==
X-Received: by 2002:a05:6a00:807:b0:737:6589:81e5 with SMTP id d2e1a72fcca58-77232745936mr4672613b3a.2.1756611814646;
        Sat, 30 Aug 2025 20:43:34 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com (201-43-64-35.dsl.telesp.net.br. [201.43.64.35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e3fa1sm6380907b3a.83.2025.08.30.20.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 20:43:34 -0700 (PDT)
Date: Sun, 31 Aug 2025 00:43:27 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Michael.Hennerich@analog.com,
	lars@metafoo.de, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: adc: ad7768-1: add new
 supported parts
Message-ID: <aLPE3yiSTReS7B2J@JSANTO12-L01.ad.analog.com>
Reply-To: 510f6efb-ada3-4848-ac8e-16fa5d1b5284@kernel.org
References: <20250824040943.9385-1-Jonathan.Santos@analog.com>
 <510f6efb-ada3-4848-ac8e-16fa5d1b5284@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <510f6efb-ada3-4848-ac8e-16fa5d1b5284@kernel.org>

On 08/24, Krzysztof Kozlowski wrote:
> On 24/08/2025 06:09, Jonathan Santos wrote:
> > Add compatibles for supported parts in the ad7768-1 family:
> > 	ADAQ7767-1, ADAQ7768-1 and ADAQ7769-1
> > 
> > Add property and checks for AAF gain, supported by ADAQ7767-1
> > and ADAQ7769-1 parts:
> > 	adi,gain-milli
> > 
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> 
> git send-email v2*
> 
> Not patch by patch. You made it very difficult for us to review and to
> apply.
> 

Sorry, i will pay more attention

> > ---
> > v2 Changes:
> > * adi,aaf-gain property renamed to adi,gain-milli. Description was 
> >   simplified.
> > * default value add to adi,gain-milli.
> > ---
> >  .../bindings/iio/adc/adi,ad7768-1.yaml        | 43 +++++++++++++++++--
> >  1 file changed, 39 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > index c06d0fc791d3..0c39491f6179 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > @@ -4,18 +4,26 @@
> >  $id: http://devicetree.org/schemas/iio/adc/adi,ad7768-1.yaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  
> > -title: Analog Devices AD7768-1 ADC device driver
> > +title: Analog Devices AD7768-1 ADC family
> >  
> >  maintainers:
> >    - Michael Hennerich <michael.hennerich@analog.com>
> >  
> >  description: |
> > -  Datasheet at:
> > -    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7768-1.pdf
> > +  Analog Devices AD7768-1 24-Bit Single Channel Low Power sigma-delta ADC family
> > +
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7768-1.pdf
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/adaq7767-1.pdf
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/adaq7768-1.pdf
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/adaq7769-1.pdf
> >  
> >  properties:
> >    compatible:
> > -    const: adi,ad7768-1
> > +    enum:
> > +      - adi,ad7768-1
> > +      - adi,adaq7767-1
> > +      - adi,adaq7768-1
> > +      - adi,adaq7769-1
> >  
> >    reg:
> >      maxItems: 1
> > @@ -58,6 +66,18 @@ properties:
> >      description:
> >        ADC reference voltage supply
> >  
> > +  adi,gain-milli:
> > +    description: |
> > +       Specifies the gain applied by the Analog Anti-Aliasing Filter (AAF) to the
> > +       ADC input (in milli units). The hardware gain is determined by which input
> 
> 
> I don't think there is no such thing as "milli units". milli is SI
> prefix, not unit. So "units" is the unit? Or how exactly?
> 
> Basis points were before since 2022 so I don't get why these other
> bindings introduced in 2024 could not use it?
> 
> Anyway, if you ever do not apply reviewers comment, then your commit msg
> should explain this. Otherwise you get the same discussion here.
> 

Yes, you are right. We shouldn't use milli as suffix. However, may I
suggest another option?

I believe -permille is more appropriate because it represents a 1/1000
proportion, which gives the precision we need to cover all values.

so it would be something like: adi,aaf-gain-permille

Is that ok for you?

Thanks for the feedback,
Jonathan S.

> Best regards,
> Krzysztof

