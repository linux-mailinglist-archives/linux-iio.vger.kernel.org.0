Return-Path: <linux-iio+bounces-2606-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F08E857B8A
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 12:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121EA1F25FE5
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 11:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1A7768F5;
	Fri, 16 Feb 2024 11:24:04 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D75627FF
	for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082644; cv=none; b=bwCajx1DlOKR4pf39Ll58wWX4aLmIamqAOj+GyAJnSFp9wa++A+FOckRQ+ZVnl84a3hb/sd1N1JuTdgE7e5w7gIzhYQOusz34i1C3Les2RG2ZvFcOw8+ZjfSNERBuSVoL4x/Zf57ht13OoGPqCQJErk6LXKi8deh6LoiFQZedZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082644; c=relaxed/simple;
	bh=ek/PNQvE+A15nH8yH/1EIecS2w7cXCaEUjlHmYanmoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5IJ0BQp/afGg34rCPWambFrPSZ1FmSfsuTYcl3ZJJbg8AKbfBaf/tmVbwipJqtHu/OAyUs99XmnDm63YK257GBNTs1kEdFf0Uv2gnTuax6OicVe5LLp0CLBWmYbCSnc0OHm+16AgfhXMZPmq96vTtWw3WkwHVaXuSPQji3rSkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rawJp-0002lY-AI; Fri, 16 Feb 2024 12:23:49 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1rawJo-00140Z-GV; Fri, 16 Feb 2024 12:23:48 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1rawJo-00BU8B-1L;
	Fri, 16 Feb 2024 12:23:48 +0100
Date: Fri, 16 Feb 2024 12:23:48 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: puranjay12@gmail.com, lars@metafoo.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	thomas.haemmerle@leica-geosystems.com
Subject: Re: [RESEND PATCH 1/2] dt-bindings: iio: ti,tmp117: add vcc supply
 binding
Message-ID: <20240216112348.pamc4c7yemuz3sjp@pengutronix.de>
References: <20240216102820.1395815-1-m.felsch@pengutronix.de>
 <20240216112120.76a0c0ca@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216112120.76a0c0ca@jic23-huawei>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

On 24-02-16, Jonathan Cameron wrote:
> On Fri, 16 Feb 2024 11:28:19 +0100
> Marco Felsch <m.felsch@pengutronix.de> wrote:
> 
> > From: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
> > 
> > Add the binding to specify the vcc supply. We can't make it required
> > since this would break the backward compatibility.
> 
> Given convention for supplies like this is to make them required in
> the dt-binding to reflect that providing power is not optional (unlikely
> some other supplies that might not be wired up) and not worry about the
> fact that we happily provide dummy supplies for them if they aren't in a
> particular dts, it should be fine to make it required here.

Will this fact apply to all dt-bindings? I'm asking because, there are
many bindings out there without having the -supply in place.

Regards,
  Marco

> 
> Jonathan
> 
> > 
> > Signed-off-by: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> > Resend since I forgot to add the DT maintainers
> > 
> >  .../devicetree/bindings/iio/temperature/ti,tmp117.yaml        | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> > index 8c6d7735e875..cf7799c9734f 100644
> > --- a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> > +++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> > @@ -24,6 +24,9 @@ properties:
> >    reg:
> >      maxItems: 1
> >  
> > +  vcc-supply:
> > +    description: provide VCC power to the sensor.
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -39,5 +42,6 @@ examples:
> >          tmp117@48 {
> >               compatible = "ti,tmp117";
> >               reg = <0x48>;
> > +             vcc-supply = <&pmic_reg_3v3>;
> >          };
> >      };
> 
> 

