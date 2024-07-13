Return-Path: <linux-iio+bounces-7598-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7AB93058A
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 14:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53AE81C2094F
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 12:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13C16EB59;
	Sat, 13 Jul 2024 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYXr8Tn+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669F915E83;
	Sat, 13 Jul 2024 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720872920; cv=none; b=YmCSccshrJtriH11ilb1enqhgH9MCzepEhW5j6MFtIcOyqq1ojzYF6Rw4zEdhxW4n2nR4nB3zNS/FDiUURcLrbo8pFH06fP2is5QpB2udc2ldk5bmzlCTr9emXI6TFmTzyF+4qB4zLukNipjIE3kZ81Sgwfe9P6ejwuSSk/RFc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720872920; c=relaxed/simple;
	bh=h+oXB3r4Af+SZeKeo48NiXkpKYXL51tItnr+ZjiINnA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YmAYW4uH/1EksujRlVKURrazMIQn99Zj5Qq+VYED3jhMqhIIdTCs+XKrD8PkqfjR2KQF42tGl1hukYOFAcoW9ewLDYDGslhEBCSIQuG6cHrom4F92NUnB7MJwbQdyNNuWW4UiWWxSi3cgCcaeY/TR//33BuLsUzOgBgC1+8PfQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYXr8Tn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B44BC32781;
	Sat, 13 Jul 2024 12:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720872919;
	bh=h+oXB3r4Af+SZeKeo48NiXkpKYXL51tItnr+ZjiINnA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PYXr8Tn+rozQ+0/2U6daBDw3JnTdnz3IZAIEW2m/kcMfs4yFAdCPNFLJlAl7lEGpW
	 atl7DoXz1317+SNKeaMpPptROA+2rEITXf9koeLUtaw86FHAnIaOgqrbS/9WVNGypp
	 SDtGqo/ybluH3WqpuXDAUA6A4614WlYwWX2BUzA9Sa7BogQcNDP+T3xPTPonkOQMTc
	 0Obw46efvlSiM9GVXWXsqUESAZlRD9WousAFpD/Hig8PZaYrsGijOxglOfDKfO5l2R
	 etenqYHXn9CYrQC/vgGiDCOEPALCCFR4dMVx3StERlK9jAUQAzREAV04snpEHm1FZB
	 d99YSYQI4KIhA==
Date: Sat, 13 Jul 2024 13:15:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: wangshuaijie@awinic.com, lars@metafoo.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, waqar.hameed@axis.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, liweilei@awinic.com, kangjiajun@awinic.com
Subject: Re: [PATCH V3 1/2] dt-bindings: iio: Add YAML to Awinic proximity
 sensor
Message-ID: <20240713131510.2c13f2bf@jic23-huawei>
In-Reply-To: <c466de06-cbc3-4ce7-90fe-4decc6e0fb89@kernel.org>
References: <20240712113200.2468249-1-wangshuaijie@awinic.com>
	<20240712113200.2468249-2-wangshuaijie@awinic.com>
	<c466de06-cbc3-4ce7-90fe-4decc6e0fb89@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> 
> > +    description:
> > +      Choose if you want to use a regulator to power the chip. Then the
> > +      vccX-supply has to be set.
> > +
> > +  vcc0-supply:
> > +    description:
> > +      Optional regulator for chip, 1.7V-3.6V.
> > +      If two awinic sar chips are used, the first regulator
> > +      should set the ID to vcc0-supply and the second regulator
> > +      should set the ID to vcc1-supply.
> > +
> > +  awinic,channel-use-mask:  
> 
> Aren't there existing IIO properties like this?
> 
I'm not sure what this is. If it's about the chip support then the compatible
is enough.  If is is about what is wired, then use child nodes per channel
to describe what is connected up.

See adc.yaml for an example - similar can be used for other device types.

> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      The mask of channels used.
> > +      Configure according to the specific chip channel used.
> > +      Bit[31:0] Each bit represents a channel.
> > +      If the customer uses ch0 and ch2, then channel_use_mask=<0x05>
> > +      For a 3-channel chip, the maximum value is 0x07;
> > +      For a 5-channel chip, the maximum value is 0x1F;
> > +      For a 8-channel chip, the maximum value is 0xFF;
> > +
> > +  awinic,monitor-esd:
> > +    type: boolean
> > +    description:
> > +      Choose if you want to monitor ESD.  



