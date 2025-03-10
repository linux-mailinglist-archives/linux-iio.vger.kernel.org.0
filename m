Return-Path: <linux-iio+bounces-16691-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04E3A5A3DC
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 20:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77ED73A5561
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 19:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B47233D86;
	Mon, 10 Mar 2025 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKskT/AX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3716E1CAA60;
	Mon, 10 Mar 2025 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741635339; cv=none; b=ehvIDCafMqsBeEpnitS1iqCLiKAZgs0epvXoX11mShjJac0wujR9/1NFW8Flv2wKXJf0QXbXmcTBVLmWa5GQJsWD3v/JcDkIQmrXju3rESa5+viyQPfz9EzV/NJO4Cbmik7nFD5G81FVk62LyQOQ38tUcv3nu1Hq3EC2mmEhAYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741635339; c=relaxed/simple;
	bh=mqvIm7CQVKu0FB11g1YGAcy3O/ZG5gcTFuHUtGtOHXA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E94h+YeuhG4orq7VbGc4vT1qOwiHlsiwHRk1/EDyB3TIWXZhgKMhDnoK5WGdLvlB/mKpaC52CyvgK9Hv+JfHXvyauyLb3VteJ4wiNXkJnGGsWNG21qh8TtVaBENPvLikOapvTlFCOWALp00A2Ax3QI3RIx2HY6ahDHyLlMF0/yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKskT/AX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F14CC4CEE5;
	Mon, 10 Mar 2025 19:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741635338;
	bh=mqvIm7CQVKu0FB11g1YGAcy3O/ZG5gcTFuHUtGtOHXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cKskT/AX2L6B8zrQve0N9GOi524W0eT7Eh3oPQs7POL4LZp4yyppUCR7PDCMma7zP
	 dw3yobp4X0gZ7uo32XDZfCTfjyLwN75xK7uctKZOgr9IaELke4rA/wE3W6bYqV8twm
	 LgpOLV1OpZ5QP04ZhSWpd4pz7VSSHo6qfW1oyYRuakJzHOuqOj5Gun/HSyRFzvtF9n
	 dhtdWCjXFP39EkQ+j4vO4ynXjOaqK6cxHYg+0Eddyam/2POJHyJ/rSyFhMn4CxJ/uD
	 R4CAW3af5r7Dx/XcT00wMZpA94AxUOzMm/EU5UDDocanIo5OzqRY8tIBBBW6eVRGSh
	 gwtt3hNtpsMaw==
Date: Mon, 10 Mar 2025 19:35:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <gastmaier@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, Jorge Marques
 <jorge.marques@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, David Lechner
 <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: iio: adc: Add adi,ad4052
Message-ID: <20250310193528.35d35c2e@jic23-huawei>
In-Reply-To: <sf7hqjyzal2jmbrf72xxj4cewrkq6bsjwlkbinqv2zan57cq3s@hwhfwmabtk5q>
References: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
	<20250306-iio-driver-ad4052-v1-2-2badad30116c@analog.com>
	<20250306-promotion-tarmac-bc5172f38f31@spud>
	<sf7hqjyzal2jmbrf72xxj4cewrkq6bsjwlkbinqv2zan57cq3s@hwhfwmabtk5q>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Mar 2025 20:43:55 +0100
Jorge Marques <gastmaier@gmail.com> wrote:

> > > +  compatible:
> > > +    enum:
> > > +      - adi,ad4050
> > > +      - adi,ad4052
> > > +      - adi,ad4056
> > > +      - adi,ad4058  
> > 
> > Can you mention in your commit message what differs between these
> > devices that makes picking one as the "base"/fallback compatible
> > unsuitable please?  
> Sure, to be added:
> 
>  Each variant of the family differs in speed and resolution, resulting
>  in different scan types and spi word sizes, that are matched by the
>  compatible with the chip_info.
>  The device contains two required interrupts (gp0, gp1) and one optional
>  gpio (cnv).

Explain why the interrupts are required.  That is unusual.

Note the driver can be stricter than the binding, so it may make sense
to require them in the driver, but leave it flexible in the binding.
If someone has a board without them wired, then they can look at adding
polling or timing logic to avoid the need for the interrupt lines or
at reducing functionality of the driver.

> 
> > > +
> > > +  vdd-supply: true
> > > +  vdd_1_8-supply: true  
> > 
> > You're allowed to use . in property names, and the _s should be -s.
> > That said, vdd and vdd 1.8? Shouldn't both have the voltage in them in
> > that case?  
> I overlooked the supplies, the correct are vdd, vio as mandatory,
> and vref is optional.
> 
> Jorge


