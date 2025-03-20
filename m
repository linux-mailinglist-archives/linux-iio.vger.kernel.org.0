Return-Path: <linux-iio+bounces-17146-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64329A6A1DA
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 09:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B76816C28B
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 08:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFDE21B90B;
	Thu, 20 Mar 2025 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhhMnxM/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAB5215162;
	Thu, 20 Mar 2025 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742460756; cv=none; b=iFUERi7Ul0MXrk2JNSkFfDEf1T+3AN94vL9VY8Wow80Jp1RbFI3hSvUL1ZsWjwgvkgAA4kVrKgq6V+ONHUWIKTHKJwL34xiU8xa6n5uQb3p4CFziAWTVlltIOVkjZpObf0NYjefvdlGAgxvlxonMUYrhfdGV6Pimo1yqIMtlYq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742460756; c=relaxed/simple;
	bh=XJynSMMBI9YAA5uARKacDRxQb8hC8mgVbQeT6x+zbTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pk3queSGrTJi3jWmmXG3m629IPOck+Tt6YDlPNAArWOVJmk9c0xcnNbHCo2fa0Z1gPIeWePrMGW5TlSwFpuSbuy7fqwIH6XYKgrBx8KYVPMGN7HuoCa2UVJS92/LFl7dqi9N+0tWNq+MPUgPPpeB8fKgBlsqvVBYLdGu4tOndHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhhMnxM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23E1C4CEDD;
	Thu, 20 Mar 2025 08:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742460754;
	bh=XJynSMMBI9YAA5uARKacDRxQb8hC8mgVbQeT6x+zbTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GhhMnxM/IVyUWNf2RcWtIS4iJKWEV8FgxdXCHlhiG8hLdnjJb1BnwUWrAuEWBRmWq
	 EoXMOKEZhrw7nZXgZ+QT56hkgzrrZP11wusKwSvBD9ThRxvCVImz+JbuwI10ERTSwt
	 itaNWGz9VXvDbHdxvFFvXsctGxx/EjcvcYpH/Wt4nvbosHK0UA0OFmPq05o++0h6K9
	 34DxmGI+rTE/NhZNhuIbedrVh4I4eqWhnYlIG9S+E981TKguTzIVcVBQIgzIW9+E61
	 s/m7nXGkN2Mi4d+jA0rFciqMhmDvMhFFF4dn8xv19tgwb1X9DNginVTyFfuok3EuoV
	 mbAaP59rINaJw==
Date: Thu, 20 Mar 2025 09:52:31 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sergio =?utf-8?B?UMOpcmV6?= <sergio@pereznus.es>
Cc: Tomasz Duszynski <tduszyns@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: light: bh1750: Add reset-gpios
 property
Message-ID: <20250320-shaggy-heavy-camel-9d0eed@krzk-bin>
References: <20250319161117.1780-1-sergio@pereznus.es>
 <61d55149-1955-4d5c-84de-d8644727b87f@kernel.org>
 <96c44905-0725-4c68-91a5-1c6cea6a7f4a@pereznus.es>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <96c44905-0725-4c68-91a5-1c6cea6a7f4a@pereznus.es>

On Wed, Mar 19, 2025 at 11:38:09PM +0100, Sergio P=C3=A9rez wrote:
>=20
> El 19/03/2025 a las 20:12, Krzysztof Kozlowski escribi=C3=B3:
> > On 19/03/2025 17:11, Sergio Perez wrote:
> > > Some BH1750 sensors require a hardware reset via GPIO before they can
> > > be properly detected on the I2C bus. Add a new reset-gpios property
> > > to the binding to support this functionality.
> > >=20
> > > The reset-gpios property allows specifying a GPIO that will be toggled
> > > during driver initialization to reset the sensor.
> > >=20
> > > Signed-off-by: Sergio Perez <sergio@pereznus.es>
> > > ---
> > >   Documentation/devicetree/bindings/iio/light/bh1750.yaml | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > You just sent v3, while v4 was already on the lists, without improving
> > and without responding to review.
> >=20
> > NAK.
> >=20
> > You keep repeating the same mistakes: not reading and responding
> > feedback and it is getting tiresome.
> I apologize for the confusion with patch versions. You're right that I se=
nt
> v3
> after v4 was already on the list. I was trying to follow your exact
> instructions from:
> "git add ...
> git commit --signed-off
> git format-patch -v3 -2
> scripts/chekpatch.pl v3*
> scripts/get_maintainers.pl --no-git-fallback v3*
> git send-email *"

v3 stands for version of the patch, so my instruction shuld be here
adjusted.

>=20
> Regarding the binding I've modified for next v5 the YAML description to
> remove "active low" to avoid confusion and modified the example to:

So the signal is not active low? Are you really sure?

Looking at BH1750FVI there is no reset signal in the first place...
unless you mean this is DVI, but the description should then mention it.

If this is DVI, then it is active low.

Best regards,
Krzysztof


