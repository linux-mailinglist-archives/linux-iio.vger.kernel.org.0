Return-Path: <linux-iio+bounces-5099-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219208C949B
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 14:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8CB1C20970
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 12:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491953D56D;
	Sun, 19 May 2024 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPjvDc5V"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019F0C125;
	Sun, 19 May 2024 12:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716121555; cv=none; b=A71eWwcpCtGOw4hC6v+5/lAP8PpUfJ7eabnG6lo/aCwnkO0mXgbMOWrH2Npylu/C/YoNNRj4PjIyqM9pN68Srwt1TgX40v3RIwsYxLcsnxNngLmzrmas+oaV5t7Z6pTJ9jZbU8eIfJbbEkgV/O1wWFxLud3KfiCdMaGrcq80EUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716121555; c=relaxed/simple;
	bh=4rXfa9LQ719P8V1ZJ6DSwRQlJQnG2PbqVqu6ALcV/6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FuiDZDzu+XcAptgqnUek/+Ij0TZsxl55S7leg9w1JjjXK7iL71vHKXdCiax4m2muaSlGzgtOaI5X15H/T376JflCuOsos/PS/Hz1RnHBxjNXzeHE0bFwMK583FAR8O+NQIsAyNRjP7RG+WdH5aQjGQr+CgLIH7OB8H/aofhUEj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPjvDc5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39C1C32781;
	Sun, 19 May 2024 12:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716121554;
	bh=4rXfa9LQ719P8V1ZJ6DSwRQlJQnG2PbqVqu6ALcV/6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oPjvDc5VcWoHLUf102edSzPwH3bYEpdZ5tCtAc1OWA7px2fptUDlIAcyeUEck172u
	 JDI1aFXdWGPF67dOZD1KQ8Y7q/QtZbW8eV93LLW0Y49NPLDOaGHzbxqjr/Y31Turyd
	 cFKDXCWOHd3BEJatv6OuRKoYWUGnrtj+NVDUAf67dOXTNCZzTw5VjQzXZ7JPTuKpLq
	 2V4GwJ42hLWdIgpzbYIf0b5VssiRhAC1E5DiIxwbD6VFncKz8ykMuwIzD7yKORYNSv
	 V9l87wgVatwN5hlgOg18XBGTQJ7w6xH/jpqee1A7HEBA69hwqcPtFmQ6wwDBJ791M1
	 iIw4ilNSZYbPg==
Date: Sun, 19 May 2024 13:25:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Arthur Becker <arthur.becker@sentec.com>, "robh@kernel.org"
 <robh@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: light: add veml6040 RGBW-LS bindings
Message-ID: <20240519132543.4ed2de74@jic23-huawei>
In-Reply-To: <20240513-repulsive-fiftieth-884b3805472f@spud>
References: <ZR1P278MB1117B205886E023F9F72A2E881E22@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
	<20240513-repulsive-fiftieth-884b3805472f@spud>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 17:26:12 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Mon, May 13, 2024 at 02:35:44PM +0000, Arthur Becker wrote:
> > This commit adds device tree bindings for the veml6040 RGBW Light Sensor
> > 
> > signed-off-by: Arthur Becker <arthur.becker@sentec.com>  
> 
> If you're writing a standalone binding for this and not putting it into
> trivial-devices.yaml you should document the supply for this device.
> 

Plus turn it on in the driver! In many cases supplies are hardwired
to on, but it the regulator framework will happily deal with that
by supplying a fake regulator.  The binding should however reflect that
the sensor needs power and list it as required.  Ideal is dts
files that do list fixed supplies but the fallback to a fake one will
work if not.

Jonathan
> > ---
> > 
> >  .../bindings/iio/light/veml6040.yaml          | 43 +++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/light/veml6040.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/light/veml6040.yaml b/Documentation/devicetree/bindings/iio/light/veml6040.yaml
> > new file mode 100644
> > index 000000000000..796c22f75575
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/light/veml6040.yaml  
> 
> Filename matching the compatible please.
> 
> > @@ -0,0 +1,43 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/light/veml6040.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: VEML6040 RGBW Light Sensor
> > +
> > +maintainers:
> > +  - Arthur Becker <arthur.becker@sentec.com>
> > +
> > +description: |  
> 
> This | isn;t needed, you've got no formatting to preserve.
> 
> 
> Cheers,
> Conor.


