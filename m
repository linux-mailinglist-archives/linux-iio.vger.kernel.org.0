Return-Path: <linux-iio+bounces-9938-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ABF98A833
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 17:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2F71F240AC
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 15:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242161922F5;
	Mon, 30 Sep 2024 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZNAaDYF0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B191922D5
	for <linux-iio@vger.kernel.org>; Mon, 30 Sep 2024 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727709010; cv=none; b=BNqVyD/ig+FfTEZjlJAAJ9wyB7WOUzlJI2alypC4TqxLtDMuvKGSpzXfiOWjdGN6t0CO+x8TxKtYrdIqiyV9LMihORSbeshTCJ725gQ41G086jS35LusH/fI/sKh27py1b4rHqzr+L23vqBdAl9JBzB312GzoHEkhHh/euXGmE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727709010; c=relaxed/simple;
	bh=q89+6LizALqE7+dTK4H6W6WDZ5mPTCBjapC8OoSTGwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmtOs+98UIq8GbHkLCWW1Icb2mysKt6+Mt+cb9sk5HWLdtoo2h4Mr00TWxWRC8HZXd/PCOwiZUme75uKS3w0BnGCGlZgyq8K3C+nDMsugH2MN4Im4RoiS33Hdne/UtIy6xeTxsfmmZerUPRvo+f6lglyv8wnI/Q+S8ReJpEO9as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZNAaDYF0; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37cc846fbc4so3188451f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 30 Sep 2024 08:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727709006; x=1728313806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iuNK8THGglLLztzdTYizr6QDcFkhinuV96Oc5O9ZvwU=;
        b=ZNAaDYF0HrsLjlG5TdOYu5qm+HkD8mkMo6OojgR1/efrpMdV1INOZVdo4wtTD2lpz9
         81Q1bLePMXcnZEKd/yz1jDEeOV1FlsG0TAULRCXtDa0fBJmZCLmdTvyI9+7UaOSI2mxB
         FdX4a87nCw2unKaqW+lrHqLL/Fmnml/h3YPOJzPD59BabLs6q8gSdUqwtudtJVlkQCsZ
         O1HV6rqyz00Cu7P8L58n5T7al7Q+blMmDTvFkFTqje+xNZI8+gQiYMdRZF7IOUonomMR
         W+Ql53Xl0Qre7gPNu9acCPt8pOC++YdCb7UlcnxfCxbwZ37rGM/6Z73w7hjJ3KMWizwh
         BX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727709006; x=1728313806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuNK8THGglLLztzdTYizr6QDcFkhinuV96Oc5O9ZvwU=;
        b=ZZmwBUotHwC6/RT2b+08mijlafb+OdyA9PQ8h/wow7C2ypOSOHEWVOkPH59hytuuNO
         IKxOcGduCiLZTifwgdrhKfqQs8gX4/B/OlYI0R8fabgu543leOdwMdjlLydG0gPhYzta
         L8/50MHbfC1g62d8pGRPBjkWrEWPZ0BiaYjdf6L2fbQM8KJKk49ViXP+23TIZgVY84P5
         zz3nRSe0oetmqRqLY+bUhwjva7wit2rH0h7FAFTy+DvsdwRT5tqfLOuS09qUAfMfVSfo
         8giZ6HJkX0pLbngv/MDiPtgGZrVNUV5P6HP0rc7/qQyZOlIj07+q+UhHEGC+tS2wDb/p
         kdsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbzyjRR9vfA5QRtRD8AnIW1yYuGvXQ3UnraujWd2d86p8zAF9YtNV12obWjjdgQloE98iAbVtcHtM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybdtb0yaDxJ6dFsLSYej1qJsnEuQB7WvgFgCfMaLJQCPMkSjh0
	Zum2ls9P7UbMOV1Mx6Cc39P+D1ii06uIEpowzQlW1BxZ3XCaRW7R189sS3fwHDU=
X-Google-Smtp-Source: AGHT+IEd3uHtC1UBjfQ6Kv9MfqRsxH68O8CtXMxfd27TDYQvTEdsHObwZnWKGTsmDidAOl8R8DKfkg==
X-Received: by 2002:adf:ab47:0:b0:37c:d28f:bbb0 with SMTP id ffacd0b85a97d-37cd5a9ed7bmr8447203f8f.20.1727709005523;
        Mon, 30 Sep 2024 08:10:05 -0700 (PDT)
Received: from dfj (host-79-54-25-3.retail.telecomitalia.it. [79.54.25.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e65c3sm9252434f8f.60.2024.09.30.08.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 08:10:04 -0700 (PDT)
Date: Mon, 30 Sep 2024 17:08:48 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v3 04/10] dt-bindings: iio: dac: ad3552r: add io-backend
 support
Message-ID: <ipnqs4uektoysenkr7jvf6ic2rh56n3e5fmmheay323yhavs7u@th7qmxwmkiqo>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
 <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-4-a17b9b3d05d9@baylibre.com>
 <20240929115150.6d1c22b3@jic23-huawei>
 <oh2xoym6dwvfn5lbzx3j5ckd3gfzvl2ukohrs4ukumkv6kzwi5@ume3z224gjta>
 <20240930154958.00004507@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930154958.00004507@Huawei.com>

On 30.09.2024 15:49, Jonathan Cameron wrote:
> On Mon, 30 Sep 2024 16:15:41 +0200
> Angelo Dureghello <adureghello@baylibre.com> wrote:
> 
> > On 29.09.2024 11:51, Jonathan Cameron wrote:
> > > On Thu, 19 Sep 2024 11:20:00 +0200
> > > Angelo Dureghello <adureghello@baylibre.com> wrote:
> > >   
> > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > 
> > > > There is a version AXI DAC IP block (for FPGAs) that provides
> > > > a physical bus for AD3552R and similar chips, and acts as
> > > > an SPI controller.  
> > > 
> > > Wrap is a bit short. Aim for < 75 chars for patch descriptions.
> > >   
> > > > 
> > > > For this case, the binding is modified to include some
> > > > additional properties.
> > > > 
> > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > ---
> > > >  .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   | 42 ++++++++++++++++++++++
> > > >  1 file changed, 42 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> > > > index 41fe00034742..aca4a41c2633 100644
> > > > --- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> > > > @@ -60,6 +60,18 @@ properties:
> > > >      $ref: /schemas/types.yaml#/definitions/uint32
> > > >      enum: [0, 1, 2, 3]
> > > >  
> > > > +  io-backends:
> > > > +    description: The iio backend reference.  
> > > 
> > > Give a description of what the backend does in this case.  I.e. that it is
> > > a qspi DDR backend with ...
> > >   
> > > > +      An example backend can be found at
> > > > +        https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
> > > > +    maxItems: 1
> > > > +
> > > > +  adi,synchronous-mode:
> > > > +    description: Enable waiting for external synchronization signal.
> > > > +      Some AXI IP configuration can implement a dual-IP layout, with internal
> > > > +      wirings for streaming synchronization.  
> > > 
> > > I've no idea what a dual-IP layout is.  Can you provide a little more info
> > > here?  What are the two IPs?
> > >  
> > IP is a term used in fpga design as "intellectual property", that is
> > intended as a functional block of logic or data used to make a 
> > field-programmable gate array module.
> > 
> > A dual layout is just 2 same fpga modules in place of one.
> >  
> > I can add a "fpga" regerence to be more clear.
> 
> IP I was familiar with.  I'm more interested in what each IP is doing in this
> case.  Or at least an example of what sort of split of functionality might
> make use of this.
>

I have an image of the project (that is under development or testing now),
not sure how to attach the image here, btw, something as
 
          axi_ad3552r_0  ----------->---- qspi0
              sync_ext_device --.
       .- external_sync          |
       |                         |
       |-------------<-----------                        
       |
       |   axi_ad3552r_1 ----------->---- qspi1
       `- external_sync
 
My understanding is that it's just a method to use a octal spi,
duplicating the transfer rate. I can collect more info in case.


> Jonathan

Regards,
Angelo

-- 

  o/ QW5nZWxvIER1cmVnaGVsbG8=
   www.kernel-space.org
    e: angelo at kernel-space.org
      c: +39 388 8550663
       

