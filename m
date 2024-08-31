Return-Path: <linux-iio+bounces-8916-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF65967188
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 14:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A8F1F21A51
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 12:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ED917E8E5;
	Sat, 31 Aug 2024 12:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGyMXa+A"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DD2193;
	Sat, 31 Aug 2024 12:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725106928; cv=none; b=dD3XzSGgd+2Q6yTcR1CIrcxQPAIB+Rkrlc9marz/99LWAslapeA12ckEUdqtw9jp3ABU+wGP+nULN0VNG9yqhuKhKkyCQJt2BqeY0BsGi0fzP9g43tCMuNHO+9hO1kMiDniJ/wK4RdUsapIgSE6G9fXo9zCBCxDZ9gBEFU43GIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725106928; c=relaxed/simple;
	bh=StmMqtk1qu2rJCc4Il63kXR9JrprhuPEirHNGh6jjdA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XmcMt6vynanE84jddi0oEAIfvC+lgGYRmt+j8tdBGhPK+gJ6MmmTzW7+cufmOMLmdBHi55b/+YfHK71L+fKjt8/8ZOJaQTCwLG8As6o6SwRJrULKnU5fTcQ4wX+ayAq06vzmL1RcT7yz40uPZZsaqBQ0dlsVwDul/ftoDvnvVXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGyMXa+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652CCC4CEC0;
	Sat, 31 Aug 2024 12:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725106927;
	bh=StmMqtk1qu2rJCc4Il63kXR9JrprhuPEirHNGh6jjdA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rGyMXa+AvBLE+nJZTVXG6eSqU4/vigDsYT2Zob+gujZ+2zTNzpi/uIMhPdGBC3ryn
	 iOxrP8BK+G2eJwBY7bzmt5MDkC6V77nxprOb/A7+ECKDFzmEhAH+AigJe1ZJ/NmGHC
	 mJzWZnkqsmxi4tGzsRNCHa7/mOurlheYV7g4fOIHXo2s/cFCdICSNcPT+nMX6yz2qs
	 YjfH/2xSDSsuWmYPhMwoXRkFSAfxmFCunquPU+temeyhEJIz0CeVAG6IcG0p4c1twZ
	 V9rOpcyXSiVK88I6gMfu2JMUgJbn3o/c+QuvJ9HJ7gRnCNMjwVk76kIVNI0oudBzlW
	 7MKmLbPim0Cjg==
Date: Sat, 31 Aug 2024 13:21:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: "Sperling, Tobias" <Tobias.Sperling@softing.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "jdelvare@suse.com" <jdelvare@suse.com>, "linux@roeck-us.net"
 <linux@roeck-us.net>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
Message-ID: <20240831132159.2073994f@jic23-huawei>
In-Reply-To: <20240830-chaos-unrivaled-04c5c4c6add9@spud>
References: <BE1P281MB24208CB90AF549578AA5C384EF972@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
	<20240830-chaos-unrivaled-04c5c4c6add9@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > +  ti,mode:
> > +    $ref: /schemas/types.yaml#/definitions/uint8
> > +    description: |
> > +      Operation mode
> > +      Mode 0 - Manual mode. A channel is only sampled when the according input
> > +        in the sysfs is read.
> > +      Mode 1 - Auto mode. All channels are automatically sampled sequentially.
> > +        Reading an input returns the last valid sample. In this mode further
> > +        features like statistics and interrupts are available.
> > +    default: 0  
> 
> I don't think this ti,mode property is suitable for bindings. sysfs is a
> linux implementation detail, when to do sampling is an implementation
> detail of your driver. Bindings are only supposed to describe properties
> of the hardware, not set software policy.

Agreed. With an IIO driver this will become a switch based on what usespace
interfaces are enabled.
So if events are on or buffered data capture, enable automode.
If just sysfs reads, then manual mode is fine.


> > +
> > +        ads7138@10 {  
> 
> This should just be "dac@".

adc :)

> 
> > +            compatible = "ti,ads7138";
> > +            reg = <0x10>;
> > +            avdd-supply = <&reg_stb_3v3>;
> > +            ti,mode = /bits/ 8 <1>;
> > +            ti,interval = /bits/ 16 <1000>;
> > +            interrupt-parent = <&gpio2>;
> > +            interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
> > +            status = "okay";
> > +        };
> > +    };  
> oCheers,
> Conor.


