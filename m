Return-Path: <linux-iio+bounces-12407-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7F29D2834
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 15:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89C11F21A94
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 14:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C931CCB4E;
	Tue, 19 Nov 2024 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6XOFGi5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFDAE57D;
	Tue, 19 Nov 2024 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026761; cv=none; b=UQLHzPNgSIXBK4464vtSN3dKO4b0PRl9gKlbBHw45ERA+CzG4iVQ7RZmiRCLfG7GlbwNyq7KLhyLqBhcKZ4shNXTII1fmqtBCPAsxIeArVM8O7a9Gz8fWQoO9USqiufVj+spk90JdiuDMUBjHLHEeT47WurI3c1/ceUlWJaAxXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026761; c=relaxed/simple;
	bh=Vy/xSgb5FedxmmMMg77kWeYZmEJ5Y6T3eOsGvrKqLlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZfDg77ESPDGSTvA1nzVtom8nXTEO0YDbPKtPx0UeGgA0P1Z025Em9HrvswLMmeYWLS8N5N2i3esQNm6amxU8G87WY/2Z7/QVDU6sdVOP/F3XfTd2VEI81JWJAN34poqoScTduNACHHv42okTHHdZGWw4MFlzx6yQSz5W3OGnQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6XOFGi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C643BC4CED0;
	Tue, 19 Nov 2024 14:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732026761;
	bh=Vy/xSgb5FedxmmMMg77kWeYZmEJ5Y6T3eOsGvrKqLlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h6XOFGi5qeg5oj2k+kdbwF+ixh5kgEgjwm8MbIs688ZKhKvHVW3ETGfgFjLrCxyH6
	 VxnrfjfDTBzNFSVpN7WShHO6a+K6sMAA2Bpps9fNHg0BOdVt7MGtvoGLxzipuX8LVd
	 keQEoUpoGobxE1RnCmGQTu8pKCCyySbVlrbM88gdEu5pN5fnO7WHvh2qXYmbxSFpOG
	 tWC1VYB6gvRjSrVFSoGrQ4Ubkv59AebfUn9eyudM19VE4Jmr3NdhH8/Z2B2RXcErkj
	 ZlVq03BZyfqRGK2C6hOkrzFuj5exaU4dAuJr3fZ3du9UtpQg+gtry64fquF4//KgnA
	 ppWqcfICOUAeQ==
Date: Tue, 19 Nov 2024 08:32:39 -0600
From: Rob Herring <robh@kernel.org>
To: "Sperling, Tobias" <Tobias.Sperling@softing.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Introduce ADS7138
Message-ID: <20241119143239.GA1201205-robh@kernel.org>
References: <BE1P281MB24207662EAC941780807F88BEF5A2@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
 <20241115173657.GA3440948-robh@kernel.org>
 <BE1P281MB24200EE5C1D08DB1C330A51EEF272@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BE1P281MB24200EE5C1D08DB1C330A51EEF272@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>

On Mon, Nov 18, 2024 at 01:43:02PM +0000, Sperling, Tobias wrote:
> > On Wed, Nov 13, 2024 at 02:41:08PM +0000, Sperling, Tobias wrote:
> > > >From 6a06973e1023ca6a128c8d426b4c87887117c084 Mon Sep 17 00:00:00
> > 2001
> > > From: Tobias Sperling <tobias.sperling@softing.com>
> > > Date: Wed, 13 Nov 2024 14:52:49 +0100
> > > Subject: [PATCH 1/2] dt-bindings: iio: adc: Introduce ADS7138
> >
> > Your patch is corrupted.
> 
> Yeah, might look a little different from what you are usually used to see, as
> I had to copy the patch manually to the mails body. SMTP doesn't work
> for us unfortunately. Anyway, the patch applies just fine with "git apply",
> doesn't it for you?

git-apply doesn't apply the commit message. git-am is what you want. It 
tripped up my scripts, but that seems to because it has line-feed char 
in Message-ID. It did apply manually running b4.

There's a b4 relay you can use to send if you can't get SMTP to work. 
Messing with things manually is asking for trouble.

> > > Add documentation for the driver of ADS7128 and ADS7138 12-bit, 8-channel
> > > analog-to-digital converters. These ADCs have a wide operating range and
> > > a wide feature set. Communication is based on the I2C interface.
> > >
> > > Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>
> > > ---
> > >  .../bindings/iio/adc/ti,ads7138.yaml          | 60 +++++++++++++++++++
> > >  1 file changed, 60 insertions(+)
> > >  create mode 100644
> > Documentation/devicetree/bindings/iio/adc/ti,ads7138.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7138.yaml
> > b/Documentation/devicetree/bindings/iio/adc/ti,ads7138.yaml
> > > new file mode 100644
> > > index 000000000000..c70ad5747828
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7138.yaml
> > > @@ -0,0 +1,60 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id:
> > http://devicetree/.
> > org%2Fschemas%2Fiio%2Fadc%2Fti%2Cads7138.yaml%23&data=05%7C02%7C%
> > 7Cf943e3cd23dd4c28422608dd059c1cd9%7Cfe3606fad3974238999768dcd7851f
> > 64%7C1%7C0%7C638672890241515102%7CUnknown%7CTWFpbGZsb3d8eyJFb
> > XB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpb
> > CIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=KFK6uoMuDUTlwSRv5jUd%2FQ
> > mBqKRHIDCq%2Bb1nWhOkZTk%3D&reserved=0
> > > +$schema:
> > http://devicetree/.
> > org%2Fmeta-
> > schemas%2Fcore.yaml%23&data=05%7C02%7C%7Cf943e3cd23dd4c28422608d
> > d059c1cd9%7Cfe3606fad3974238999768dcd7851f64%7C1%7C0%7C638672890
> > 241534499%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOi
> > IwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%
> > 7C%7C%7C&sdata=2Dj6PlC%2BzKkjcxWosWYMd9Wnh71dKJZfXx5af85vQf8%3D
> > &reserved=0
> > > +
> > > +title: Texas Instruments ADS7128/ADS7138 Analog to Digital Converter (ADC)
> > > +
> > > +maintainers:
> > > +  - Tobias Sperling <tobias.sperling@softing.com>
> > > +
> > > +description: |
> > > +  The ADS7128 is 12-Bit, 8-Channel Sampling Analog to Digital Converter (ADC)
> > > +  with an I2C interface.
> > > +
> > > +  Datasheets:
> > > +
> > https://www.ti.co/
> > m%2Fproduct%2FADS7128&data=05%7C02%7C%7Cf943e3cd23dd4c28422608d
> > d059c1cd9%7Cfe3606fad3974238999768dcd7851f64%7C1%7C0%7C638672890
> > 241551566%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOi
> > IwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%
> > 7C%7C%7C&sdata=MtZjBaLGanD7%2BwQJZDc54CWVVkDbUV1jAv9PixBdOxk%3
> > D&reserved=0
> > > +
> > https://www.ti.co/
> > m%2Fproduct%2FADS7138&data=05%7C02%7C%7Cf943e3cd23dd4c28422608d
> > d059c1cd9%7Cfe3606fad3974238999768dcd7851f64%7C1%7C0%7C638672890
> > 241564942%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOi
> > IwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%
> > 7C%7C%7C&sdata=DlLY9HTzdOyvooQA%2FCI%2BQJu0REGlwP2mpR%2Bp6M8C
> > 5yk%3D&reserved=0
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - ti,ads7128
> > > +      - ti,ads7138
> >
> > What's the difference between the 2?
> 
> The 7128 has some more hardware features like a root-mean-square
> module and a zero-crossing-detect module. Base functionality and
> therefore, what's implemented in the driver yet, is the same, however.

Please put that in the description.

Rob

