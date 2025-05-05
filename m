Return-Path: <linux-iio+bounces-19096-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3D5AA93AF
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 14:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35F2188B038
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 12:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD632250C07;
	Mon,  5 May 2025 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOLNm7qx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90983146D53;
	Mon,  5 May 2025 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746449824; cv=none; b=SBfnJPIJRoeRYokivcSsmfZnD4uVY3pZcHS289tQ2lNzvC6+7Zxv/42VDrJfyzBs4EJlhqRpolaESmZYF33YWiL7xxnFn4f5UdKi53NJIinQjQQipW8fuE5fhIdQS9eE7Swaim+BRiVgwlJqtjiaYwVEADT/5W3kdFCItoXIMD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746449824; c=relaxed/simple;
	bh=pNbHQvdYwAZMqp5SynYoCgRlzY1KZgHFzjGiyUnP3U0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gVvkJYnXPIUiw9ATPRV5M1k3PnJN2QFSv4xXMgAjctNv/M2bOUYmGeTQhO1rSQkQdFrqm8adfBBcGykBlQokSe9LTQLXAKl4DovkT7I/KceCZRV8Sh4uDdqQijak/gvCsuRn95ztmCYkQADiobE+Loeyf9lk9KEYrgpFWhV3jYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOLNm7qx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB04EC4CEED;
	Mon,  5 May 2025 12:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746449823;
	bh=pNbHQvdYwAZMqp5SynYoCgRlzY1KZgHFzjGiyUnP3U0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OOLNm7qxZAHd8KXE6e/mhIhqoBp5+Qq+6mAqaM4JVvSz3bL5h9ae3BV2dM0K/hSsQ
	 a91LcPT+D2asSHRNKpvKG9gGSRnn/b/q6mhKqla/pEm8QYGMQlVW2iOX17/cu4NvWA
	 ZmufbYKjK0fCmIUeo+LaXXEQnKHbdCIhwyu4QTFxRltYNu4UTnIwSzswJbLBqhCV0D
	 1uYQqvCmCHuuuE9c/OYAyDHfAG3AshvqzG+I/qITIEwro78LEvq9BIjStL4PylwjEe
	 OVETmvWs5hS642VVMb7WRSyeZ5a3TMbgjPBBVYDkVuhtvvu1lMcjen644D5wL6tnXe
	 DbGz/ahXLfIiQ==
Date: Mon, 5 May 2025 13:56:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>, Kent Gustavsson
 <kent@minoris.se>, Lars-Peter Clausen <lars@metafoo.de>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Kent Gustavsson
 <nedo80@gmail.com>, devicetree@vger.kernel.org, Lukas Rauber
 <lukas.rauber@janitza.de>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: adc: mcp3911: add reset-gpios
Message-ID: <20250505135654.3ba06fdd@jic23-huawei>
In-Reply-To: <20250428-alfalfa-caring-ee2eb658b8da@spud>
References: <20250428-mcp3911-fixes-v2-0-406e39330c3d@gmail.com>
	<20250428-mcp3911-fixes-v2-2-406e39330c3d@gmail.com>
	<20250428-alfalfa-caring-ee2eb658b8da@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 17:40:38 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Mon, Apr 28, 2025 at 08:54:12AM +0200, Marcus Folkesson wrote:
> > The MCP391X family provides an active low reset signal that is still not
> > described in the bindings.
> > 
> > Add reset-gpios to the bindings and the example.
> > 
> > Co-developed-by: Lukas Rauber <lukas.rauber@janitza.de>
> > Signed-off-by: Lukas Rauber <lukas.rauber@janitza.de>
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>  
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Just for reference this also had an ack from Krzysztof on v1 which
raced with this version being posted.

b4 found both and confused me :)

Jonathan

> 
> > ---
> >  Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> > index 06951ec5f5da381a9bb942d0ac7416128eebd3bc..3a69ec60edb915ae16312b94fddd32f5c87f37a7 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> > @@ -32,6 +32,9 @@ properties:
> >    spi-max-frequency:
> >      maximum: 20000000
> >  
> > +  reset-gpios:
> > +    maxItems: 1
> > +
> >    clocks:
> >      description: |
> >        Phandle and clock identifier for external sampling clock.
> > @@ -71,6 +74,7 @@ unevaluatedProperties: false
> >  
> >  examples:
> >    - |
> > +    #include <dt-bindings/gpio/gpio.h>
> >      spi {
> >        #address-cells = <1>;
> >        #size-cells = <0>;
> > @@ -80,6 +84,7 @@ examples:
> >          reg = <0>;
> >          interrupt-parent = <&gpio5>;
> >          interrupts = <15 2>;
> > +        reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
> >          spi-max-frequency = <20000000>;
> >          microchip,device-addr = <0>;
> >          vref-supply = <&vref_reg>;
> > 
> > -- 
> > 2.49.0
> >   


