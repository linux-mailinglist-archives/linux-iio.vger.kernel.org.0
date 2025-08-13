Return-Path: <linux-iio+bounces-22694-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83615B256CF
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 00:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51D545C0D76
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 22:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E242FCBE4;
	Wed, 13 Aug 2025 22:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJ0vQxBz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C87F21257E;
	Wed, 13 Aug 2025 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755124765; cv=none; b=ksHQAwSStdrtWR5IJHkOrehZj85QVnOodYmu9JyORknRPWW+p3VRLVJpuCHd/CCVqM6WsueRkxyItgfEgs6JJ68d86iaPEKwFfcBBazhwn1ED1lu++kJPqEP6I79pV8PchPE9R00QDxcfh//gjyMp3fvGj6pokHNQJEdArB7idI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755124765; c=relaxed/simple;
	bh=e3D/RVjYhFjtnEQ+KTEqSanCLTiM0h1saYQ3wtMZYgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMaoh8Hbk0gkU9BfUSRENwmG2AH43i8R7OPEuXN7hWrgkeubFtmePs5Sg/zFcjW/t08NDzQ/ncM84BsJ0Ckb1Ctsl1hjWzvsmhFlx8YG1KB+Dw5nWY/8EZgFbwZrALUV6vT6r3ncnKuXPgytHN1NgMvhpVeVT1EApx2aG7bDd4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJ0vQxBz; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b9dc52c0bfso34070f8f.0;
        Wed, 13 Aug 2025 15:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755124760; x=1755729560; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OlFov5VVAGyPXif8j4DcuOjAK/mA5lVh4XRxLzIxvJg=;
        b=MJ0vQxBzk4UjuxbyhIlFOuKHMWCvCD2QI6r9Yo2XFdAx4IQKTYLQzsxLozAhG8+J4U
         TOmFBn7yNjpyVl7iXM/PymRCRQuN5awqDO4S+1m9SXhA8PUrOFNlBpr1UcaOojuNejVB
         JSVRNWh0jEbWODqE7buNQMtMAAZtp3zpBu/0b58ntE6X80lDQ61z+EcAO9d2EE8moPj0
         V6+Omk6wOlmoKDOIpKJ4wFJKs6an/Au/qIIyd3Zk+bb3H+ls8ny/BF5KSl7fsbCTI0Yg
         rPL8BH4HvJLrOw95/3C+LSBwE+TU7utCTiD8aPNcydOdZ+4CWpMoExkHLTLLiz0lpuyP
         ZfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755124760; x=1755729560;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OlFov5VVAGyPXif8j4DcuOjAK/mA5lVh4XRxLzIxvJg=;
        b=FeZYSQWrOwkaZqDLWKsnv9JGYUlScE/UXhJnWFc2y/ml8bQu9T7YJWGDLQBPdysDJ3
         3FgcVsaIq7G/3ZraFeGAga4OnEwxWuBkep960HJ5PKCaI+zz5iuhMQmyxZ5Aaed6C9N8
         CDo4B8TH25TxGWR1lLlWxe+NfDb3sJKcwDpchEOtX/kJZmq7dS7NxLIgkdBYfx/uvabl
         TAeJ/+6aAwSV0vlV4jbH2wEXW/5QhXDAC+txYSZxGmfcASuURjIWAwR/Ol58hlsa4/Tx
         P0HU42Z4p+zJ5glC/QA+XONtZ/IKlfS33IFmiU6B1fQG8mekNzoZz1AAP/30VemzfqJl
         Iqlw==
X-Forwarded-Encrypted: i=1; AJvYcCUKATjNJy2IE9xSYC6b9QOfrFMXhSGJBZMD+qEb1PRtDf/318EG9o3wzWyYPKUJ/DuuYrvejPfQ01+h@vger.kernel.org, AJvYcCWoBKJwrPeRLTSarlyeNl/oXs+23k99+4sUzrckMioX84fy0Er58tNmPfWz9XEVT0u/+ii3Dx9wnHmY@vger.kernel.org, AJvYcCXDPiTw1AeiEz9Nal4HMCWvkLkXfp2WxVJfr4KFytklp6Dcx/O1u6lxmyOvIEyQ8JSPhRmdNMF8fV6eis3z@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2mzW9M0NMlrN829um8x+aP8Ukb5vKF7ufyuQBNbxdILeR43V5
	IAcbKS38pM1dZwTS6ArejZc+0hboeOazpMdNsQkdvgqxFkY/EPvr0x1r
X-Gm-Gg: ASbGncthEKR69UKjy7VZvgSD75VoOnloR/ghiRtwP3bcUPPRpeD3y6Zyo4xdOodzMh6
	orfEP28PL7q9eINuT5CBInE337jyhdSFxd8SKn7SK1fpzGQdWpKXdo87O8oiYBfpgXr+BRLanvN
	etj3YLSFwZk+aSFLH0PECpelH7N70T0epDHx6nbkSSDiRc/6YdNjUk2XuaBewaft/0CgDdQ1UEj
	L+NfEtE22PRuWtC9gt7C0fW7rQm/o8RsS3P8shfntqlX9rbdWMT8bjn9+tKGk6o+zUlTHInKZ8s
	fAAyGVsERJGqLmkO6ycRdM858oSw93oXBY6RleA4Mm/UbHTM895fdq68q8OnFk5Nomb23fBiSoT
	DyeM2IPYNxc6LX7HkZLcw+PlhcLirB3abyANxCaf9e7ygMNYjqVU=
X-Google-Smtp-Source: AGHT+IEy35Qbld+uNsrWNezbKbUR5c3avaJGDSwRcRjeN+RvRY5QydlzE5iVFGgqs2uD0727jErYdQ==
X-Received: by 2002:a05:6000:2289:b0:3b7:8d0b:3261 with SMTP id ffacd0b85a97d-3b917ef5d71mr1759295f8f.12.1755124760088;
        Wed, 13 Aug 2025 15:39:20 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([189.79.20.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453333sm50620455f8f.45.2025.08.13.15.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 15:39:19 -0700 (PDT)
Date: Wed, 13 Aug 2025 19:39:13 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: ad7768-1: add new supported
 parts
Message-ID: <aJ0UEUVmIH94Nuwi@JSANTO12-L01.ad.analog.com>
Reply-To: c3cf9b97-3883-4ebb-a2ed-0033adebda87@kernel.org
References: <cover.1754617360.git.Jonathan.Santos@analog.com>
 <ecb7406f54938658b51b4469034d87a57086bd1e.1754617360.git.Jonathan.Santos@analog.com>
 <c3cf9b97-3883-4ebb-a2ed-0033adebda87@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3cf9b97-3883-4ebb-a2ed-0033adebda87@kernel.org>

On 08/13, Krzysztof Kozlowski wrote:
> On 13/08/2025 04:48, Jonathan Santos wrote:
> > Add compatibles for supported parts in the ad7768-1 family:
> > 	ADAQ7767-1, ADAQ7768-1 and ADAQ7769-1
> > 
> > Add property and checks for AFF gain, supported by ADAQ7767-1
> > and ADAQ7769-1 parts:
> > 	adi,aaf-gain
> > 
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
> >  .../bindings/iio/adc/adi,ad7768-1.yaml        | 48 +++++++++++++++++--
> >  1 file changed, 44 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > index c06d0fc791d3..568a85e0d052 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > @@ -4,18 +4,26 @@
> >  $id: http://devicetree.org/schemas/iio/adc/adi,ad7768-1.yaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  
> > -title: Analog Devices AD7768-1 ADC device driver
> > +title: Analog Devices AD7768-1 ADC family device driver
> 
> If doing this, drop device driver. It should not be here in the first place.
> 

Noted.

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
> > @@ -58,6 +66,23 @@ properties:
> >      description:
> >        ADC reference voltage supply
> >  
> > +  adi,aaf-gain:
> > +    description: |
> > +      Specifies the gain of the Analog Anti-Aliasing Filter (AAF) applied to the
> > +      ADC input, measured in milli-units. The AAF provides additional signal
> 
> What is milli unit? Isn't gain in dB, so maybe you want mB? Quite
> unpopular to see mB, but we cannot use 1/100 of dB, so I could
> understand it.
>

Actually, the gain is expressed in V/V, not in dB. I may have phrased it poorly, but since
there are fractional values like 0.364 and 0.143, I chose to represent it
in milli-units.

> > +      rejection within the frequency range of fs ± f3dB, where fs is the sampling
> > +      frequency, and f3dB is the -3dB cutoff frequency. The specific values of
> > +      fs and f3dB, as well as the rejection intensity, depend on the digital
> > +      filter configuration.
> Best regards,
> Krzysztof

