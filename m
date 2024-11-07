Return-Path: <linux-iio+bounces-11989-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1BB9C08FF
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 15:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7ADC284697
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 14:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694DA212D2D;
	Thu,  7 Nov 2024 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKF4NHK9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11829212D00;
	Thu,  7 Nov 2024 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730990077; cv=none; b=Pr96kurTKoK+gA+XzSsZqRObtgUtQYrDuBXNprx/ghZA8gM1rwwVaknA77IwoXVKuVf51VXh61MXcERqO914Bwb3LOcHBtDrURmjcVLrhU9hFc/zGW13VhMxx6EYt8fQCBa1Vr/EXvc7PSf/KDFFYCXYB7jKK7sagZVZCpryHZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730990077; c=relaxed/simple;
	bh=cPfsizR0GhWQSjoMoj6ev7y0kRO6mxVltbXk9yQ6RCw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=V7pDPbqDc+BiMHh29Ct10M+TotTeMS07IdZLpWJKlMCRjWPk/aM4a5m+dZjcp7mUiPtLHkGvegmR8CK3v+WWpp1Arpag8s+aIA/0DvWFbl0JnpKKlm8eqNQqpHn9HwEHupW1A+mJtOhZP2i+ZaQDaCM8SLEAJG+ToIA5AoXVILM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKF4NHK9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C0CC4CECC;
	Thu,  7 Nov 2024 14:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730990076;
	bh=cPfsizR0GhWQSjoMoj6ev7y0kRO6mxVltbXk9yQ6RCw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=mKF4NHK9r1+8tE9VEE779JEN4YPJLcLdTe0ttAjyIwDylxoTTtqzFbRIggnKq6uO6
	 h0ALIHV3VWB3WAFXjQfzSLL0my3BWqJfXs4I7YMzmIOnpVxYEU8JG+OMCC8Aw5lx5Y
	 P4X6ee9KvpVlu/bdq1FZZJu1k1GlZFJdrz5LM13BCPXSr54i109bus6IZWoj9hSMzh
	 oSRr+qhDaLaA5MkqRK7XwxLsFRkjTbTmOfHzQzur7abh7e+N2u0P4BjreVSRnErD//
	 G8Px6e6FJtL+VivgnxwhJaqhTXu8wxx9Q4cnHk/ZFAHffhIUx5iGO1pogYTgw6Fbgi
	 a5kieyYvbkBrg==
Date: Thu, 7 Nov 2024 15:34:33 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-15?Q?Heiko_St=FCbner?= <heiko@sntech.de>
cc: lee@kernel.org, jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
    conor+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net, 
    srinivas.pandruvada@linux.intel.com, bentiss@kernel.org, 
    dmitry.torokhov@gmail.com, pavel@ucw.cz, ukleinek@debian.org, 
    devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-rockchip@lists.infradead.org, linux-input@vger.kernel.org, 
    linux-iio@vger.kernel.org, linux-leds@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH v9 1/9] HID: hid-sensor-hub: don't use stale platform-data
 on remove
In-Reply-To: <4934964.GXAFRqVoOG@diego>
Message-ID: <nycvar.YFH.7.76.2411071534110.20286@cbobk.fhfr.pm>
References: <20241107114712.538976-1-heiko@sntech.de> <20241107114712.538976-2-heiko@sntech.de> <nycvar.YFH.7.76.2411071358210.20286@cbobk.fhfr.pm> <4934964.GXAFRqVoOG@diego>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 7 Nov 2024, Heiko St=FCbner wrote:

> This change was more or less a surprise find, because I wanted to make
> the platform_data pointer in the mfd_cell struct const and this the hid
> sensor hub stood out as doing something strange ;-) .
>=20
> So patch 2 of this series actually depends on this change to not cause
> build errors.

Ah, right.

> But seeing that we're after -rc6 alredy, I would assume the brunt of the=
=20
> mcu series might need to wait after 6.13-rc1 anyway - but I guess that=20
> depends on how Lee sees things ;-) .

OK, I am keeping my hands off it for the time being.

Thanks,

--=20
Jiri Kosina
SUSE Labs


