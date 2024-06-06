Return-Path: <linux-iio+bounces-5943-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4108FF5B3
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 22:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36E2EB22AD6
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 20:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D493D7345B;
	Thu,  6 Jun 2024 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4FvyCSO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838986A33A;
	Thu,  6 Jun 2024 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717704755; cv=none; b=pBaDMXcNthLG06oysY249Z0zJprGN+NcMkwMju/EZerhuHJHaoXlJjyQ3lTzyTIW+/ZENqUBdRrjGryfpvluxx6yAOiMcL9GbDkrdCAPKTlP05usfUaZPMUQI68pRoCnf1btJNS2aQKB15UCzBYRLQnnqqUgs8aAolTXbpw+gfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717704755; c=relaxed/simple;
	bh=wHvxL/Gw5jJJxgJG8DBVyc7WxHfQ4axP9NbOc0wfTV0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MlGTvdPYMG+px9QTpg1LInqaARPblKH0ePbil5O/f9fJdBtc6CfkD9IBfScIlnCzfd1I2cojwvZpIQEFKjA978NXQPw7p2Jb0OXNOdqvy9UDPX3P6i7aX88EMcKFW9J5mi9p156IOceeh5iYXv3W6vXgpfaXv//HKDM9GHs6w5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4FvyCSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBA9C2BD10;
	Thu,  6 Jun 2024 20:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717704755;
	bh=wHvxL/Gw5jJJxgJG8DBVyc7WxHfQ4axP9NbOc0wfTV0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e4FvyCSOU4Kz4MHxKWKeSfGySXFTCuyG2wXI1Q8NIMuxj8QSiuQZQmUumKXBarmkN
	 g5mfG5zMPI5P0UeCKWX2C5a+ETNGYrkienm9lTWJmCZR6gLk8YOfBoIb/WbVojyCQm
	 NIfExJIDIhmqBn1Qbnoag+/mSGZ08YQi9M/g2nAb+Z2LB1KChxwzL6FSGcGlrHHKVN
	 SxAv32KCYYs1ykZmDdhXe7HZPQdiJrW/Kzyqqe6Aa1D7xVpuxXsdELbfUxLbeRWYV5
	 pwOOefAgsB68/m0GgTnrhpXv+GLjhHvVMcb4Kwhieox2WPSyljbLT9xnFr+cHetA9D
	 azflw1EXWcqfQ==
Date: Thu, 6 Jun 2024 21:12:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Josua Mayer <josua@solid-run.com>, Andrew Lunn <andrew@lunn.ch>, Gregory
 Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Daniel Baluta
 <daniel.baluta@nxp.com>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay
 Abraham I <kishon@kernel.org>, Konstantin Porotchkin <kostap@marvell.com>,
 Richard Cochran <richardcochran@gmail.com>, Yazan Shhady
 <yazan.shhady@solid-run.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-phy@lists.infradead.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v6 3/7] dt-bindings: iio: adc: ti,ads1015: add
 compatible for tla2021
Message-ID: <20240606211222.3b0f7a01@jic23-huawei>
In-Reply-To: <20240604-suspend-schnapps-191d2c1ad53e@spud>
References: <20240602-cn9130-som-v6-0-89393e86d4c7@solid-run.com>
	<20240602-cn9130-som-v6-3-89393e86d4c7@solid-run.com>
	<20240604-suspend-schnapps-191d2c1ad53e@spud>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Jun 2024 18:42:46 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Sun, Jun 02, 2024 at 05:49:38PM +0200, Josua Mayer wrote:
> > TI tla2021 is a limited single-channel variant of tla2024 which is
> > similar enough to be easily supportable through the same driver.
> > 
> > Add compatible string for tla2021 so boards may describe it in
> > device-tree.
> > 
> > Signed-off-by: Josua Mayer <josua@solid-run.com>  
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

This binding has per channel descriptions. Perhaps for this device
it should be updated to include a restriction on number of
such sub nodes (probably via the reg value in them) ?

Mind you it's currently 8 and the ti,tla2024 only has 4.
So a possible job for another day, hopefully alongside the
driver support and the tla2022 which seems to be the 2 channel
version.

Applied.

Thanks,

Jonathan

> 
> Thanks,
> Conor.
> 
> > ---
> >  Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> > index d605999ffe28..718f633c6e04 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> > @@ -18,6 +18,7 @@ properties:
> >      enum:
> >        - ti,ads1015
> >        - ti,ads1115
> > +      - ti,tla2021
> >        - ti,tla2024
> >  
> >    reg:
> > 
> > -- 
> > 2.35.3
> >   


