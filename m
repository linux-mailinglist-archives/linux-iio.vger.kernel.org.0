Return-Path: <linux-iio+bounces-6629-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AB1910973
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 17:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ACCF1C2141F
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 15:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDA91AF694;
	Thu, 20 Jun 2024 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRHN58CI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBC41AD486;
	Thu, 20 Jun 2024 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718896419; cv=none; b=c4MtIs8/tmntNJi5lY+eaFFnbbe5jYKZANE2vEeSq1c+u3CWPCv/ffS2wKwMncrMZdMOTCQP1cbUflmqdBQICFuz9EA+NMJfm5cIu4FVIynse04F0KYQkKOKqIp/lVPONgDibLWY0eTjHt/yZX9ygKCFPhFArf9ZwrPLLBUNFj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718896419; c=relaxed/simple;
	bh=SV1MB+rMIhzvY5kkb5cSdZqkMnbh+I0UyxCJkYmMut4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4a2cztfxi0nP6TUr1k4+hOhPEUhufpbpFTtxnyrSY7Vg53j2rFTUovJoaZA+nVnu+RT/4aTwkTLfsLr1UQvO3YUEH2sWytonRBdUxbexbFKKDthUUpDpE3jVtZIlujEXSwyulhx+4LRm01XYvpN0QRzefAGTEuyILA9VOTwszg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRHN58CI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-704313fa830so866680b3a.3;
        Thu, 20 Jun 2024 08:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718896417; x=1719501217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3nq34gHN3rCWci3z+YBG2EHSMYY20+Tz9GpEK9DzMtg=;
        b=jRHN58CILt++yvgQuUrrwYg5ZOMByB5xAI/OhKmRwd05GL4m4Dvm/3PiZ5J8EcEHGp
         y3BEOnh2TU+NNd6/CQdHktdoO1eWSRdTLaz6hz2NCeE/3KHo1/QN2a9lBDPhbBd6XBMg
         Q4wkYxhSoF73FjzrD4pX/yaUR0+qeFhMyeQzrMBhEaZa8OV9onaXmeHMU0zBeQsOPAOw
         te+GWxdDMvPJtQ6CraGeTm2XP4cHizTJMUQmnRALjTvSfpP9d/FameZTklEupY79KNR7
         Ut1e/cQb/bHxz1FFlgxDdwq7ou2ahRWKbFwof2WudT5H4H6LrVHZcBJmHI1kQc3oXWMu
         nq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718896417; x=1719501217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nq34gHN3rCWci3z+YBG2EHSMYY20+Tz9GpEK9DzMtg=;
        b=AF1a7T7G4kv37tEkoE+S5ajV0BxlRQJPp1qooZgbdgNXkCXkfl3EYLVxE6Yb+CE+YP
         Jd1bzAD7byAOawgg59VrxRyeZKc4rBZ7/8C208nmE5rv2d4BTM0LI0m3Wsbmnw9JfIno
         A9mDo+qe112D+6X1SL+vPDn6RhSoyaA/gaNqfwJu1zh3EvUkB2Lv2QBbdKdLYhwI9Ngq
         CwQv7S/E5hQk9ufC7m0sIJViCqZca++O77F/WOBt1/NKtLjjM/6Bw6pFyQVRubR9KJvJ
         1tM0gSEIpdcm3WL0/ZnAXDyMYRcjIPJsLDCN7dlDlVEitd6vH8RAQa7mMM0zPoa0HLeW
         eAeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmhxvmZkp+gZssrrKmqnczB5AnVUJPXtOEiqkl8IKN0PuutXVJydJnM30vKlXEqk2bzQEDBzpkakv1YYkJ6bjHlpRcq1Dj/OdZKsGTgbw+P1mdFxJe9qLOobktt6vlXE4eFhnpgTrPi+TkzLSSw7/vnL2LZJLbxTfPLEHG1yGl5ETko6t5w1ex8aItHrxtnSPM2tPZM8AzTIGz8UYMyg==
X-Gm-Message-State: AOJu0YwrSGNKMJsfCOBsn44gh7pM1wmHIy1B6Q3aIG7bNAgtSawISQDM
	w4ttuxL7//u3KbtJvD4Cb9eboOQsFAY3aft6yBr5Y3hGvjeMkeBo
X-Google-Smtp-Source: AGHT+IEubZsaogJmmRsMBzvSimjhpFhkRr9tZqbr7CaXNFD3VGPRTDC5Jd1++FZkiV0kUOtRD4sA6w==
X-Received: by 2002:a05:6a20:4b15:b0:1b2:47f9:3814 with SMTP id adf61e73a8af0-1bcbb421fdcmr5387797637.2.1718896416389;
        Thu, 20 Jun 2024 08:13:36 -0700 (PDT)
Received: from localhost ([2804:30c:96b:f700:cc1d:c0ae:96c9:c934])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb9195asm12420995b3a.209.2024.06.20.08.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 08:13:35 -0700 (PDT)
Date: Thu, 20 Jun 2024 12:14:57 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nuno.sa@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] spi: Enable controllers to extend the SPI
 protocol with MOSI idle configuration
Message-ID: <ZnRHcXaCIVH4zDMo@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1718749981.git.marcelo.schmitt@analog.com>
 <36eefb860f660e2cadb13b00aca04b5a65498993.1718749981.git.marcelo.schmitt@analog.com>
 <63db9349-f453-4a5b-aa09-d1857ddd8b03@baylibre.com>
 <ZnMqOAPc3IXP-eHC@debian-BULLSEYE-live-builder-AMD64>
 <0cf9576d-c50e-4730-834a-3a4ceac6a4f8@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cf9576d-c50e-4730-834a-3a4ceac6a4f8@sirena.org.uk>

On 06/19, Mark Brown wrote:
> On Wed, Jun 19, 2024 at 03:58:00PM -0300, Marcelo Schmitt wrote:
> > On 06/19, David Lechner wrote:
> > > On 6/18/24 6:10 PM, Marcelo Schmitt wrote:
> 
> > > > +In this extension to the usual SPI protocol, the MOSI line state is specified to
> > > > +be kept high when CS is active but the controller is not clocking out data to
> 
> > > I think it would be less ambiguous to say "asserted" instead of "active".

ack, replaced "active" by "asserted" when describing CS state for v5.

> 
> > I'm not sure. IMHO, it looks less ambiguous to say a CS is active.
> > I think the most common for CS lines is to have a CS that is active low (i.e.
> > the line is at a low voltage level when the controller is selecting the device).
> > To me, "assert" sounds closer to the idea o setting something (like a bit to 1),
> > which is the opposite of active low CS.
> > Though, no strong opinion about it.
> > I go with what the maintainers prefer.
> 
> I think they're synonyms but asserted is the more common term for chip
> selects.
> 
> 
> > > > +#define SPI_CONTROLLER_MOSI_IDLE_LOW    BIT(8)  /* Can idle MOSI low */
> > > > +#define SPI_CONTROLLER_MOSI_IDLE_HIGH   BIT(9)  /* Can idle MOSI high */
> 
> > > I don't see where these are used anywhere else in the series. They
> > > seem redundant with SPI_MOSI_IDLE_LOW and SPI_MOSI_IDLE_HIGH.
> 
> > Good point.
> > They are currently not being used.
> > Comparing with what we have for SPI_CONTROLLER_MULTI_CS, I'm thinking it may be
> > handy to have dt properties to indicate controller MOSI idle capabilities.
> > Does that sound reasonable?
> 
> We shouldn't need DT properties, we should just know if the controller
> supports this based on knowing what controller is, and I'd not expect it
> to depend on board wiring.

Okay, though, I fail to see the need for 
#define SPI_CONTROLLER_MOSI_IDLE_LOW    BIT(8)  /* Can idle MOSI low */
#define SPI_CONTROLLER_MOSI_IDLE_HIGH   BIT(9)  /* Can idle MOSI high */

It looks like SPI_CONTROLLER bits are used to tweak controller operation in
various ways.
Right now, I'm not aware of any additional tweak needed to support the MOSI idle
feature. I have tested that on Raspberry Pi with bitbang/gpio controller and on
CoraZ7 with spi-engine and it did work fine in those setups.
Anyway, I'm prone to implement any additional changes to make this set better.

Thanks,
Marcelo

