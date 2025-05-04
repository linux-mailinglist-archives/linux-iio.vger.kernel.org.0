Return-Path: <linux-iio+bounces-19036-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D2BAA86C4
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 16:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8A7517328B
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 14:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDF71A3174;
	Sun,  4 May 2025 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gI4Y9Ekt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7040155342;
	Sun,  4 May 2025 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746369810; cv=none; b=SevXJSUvqA+DbP85QrTM6a01YcvJkwI7lhHOLCfV8kE3cFsfBhIojtuRSzhJPFjRAsmM8xP/K2lfa2Z7oIMRcja+NJ3uOZCy3t+y2dsyyAuadP5oP3VMNm2UqodexgeqwglO620xKf5Mgw/PKn1I2ftBW4fUaakQEja2JzZLHQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746369810; c=relaxed/simple;
	bh=RN/N7QLqE7nIoEfmTma30SBBBgXE2a4+uj/QwSw9gAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y7H5IHesxT+91EhaWb6dKUk2n8VMbfts4h6TtdGN6X4HQVnLN/PSngZF8u2x1ADV8xbVLjA3dSZW38qT6RbDY2jmI1sg0lmSUvhS8CebEnZqlO8LE7y8PsIui2cWx2BS2eaKLYpVPTmwjfWkjbugTAeWlZOsW7VbxGP7UxRaK9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gI4Y9Ekt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6F9C4CEE7;
	Sun,  4 May 2025 14:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746369810;
	bh=RN/N7QLqE7nIoEfmTma30SBBBgXE2a4+uj/QwSw9gAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gI4Y9EktEviQTw1alwt71Wbk4xUkqAmlLpNI83hd2+MJmw2GJ/d32R6XZsuK2CNYE
	 gmfs9sBZjXI2ODA/nWSVdVK/dbuGAu16dRvDyhMDI9QrWII8ElWslh4ASMCDuAXUS6
	 ZH0bAMnuvvG0weOc4d31Zhz1lBfgGVbphIiWBbC/p9dUL47AtCjJVkO311VfQ4G5fr
	 ohodgysPN6HRP8ABrRzTZshKXZB0Wt5sSmd5IxUNshpGyc9iGv3WjprfCNbFRJqURe
	 V3X4RQ4NyNEK8wdt/Gmexa4AuJnPw14g4qTJNpMiXH9Tq4gXNwhqqDpJBvD9oFh9Og
	 9pApsn1LsP9NA==
Date: Sun, 4 May 2025 15:43:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add maintainers for ad4851 driver
Message-ID: <20250504154323.4794bffa@jic23-huawei>
In-Reply-To: <00988dab7a90671d637466e4261d7b2248f172b6.camel@gmail.com>
References: <20250502100016.26279-1-antoniu.miclaus@analog.com>
	<00988dab7a90671d637466e4261d7b2248f172b6.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 02 May 2025 16:00:28 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2025-05-02 at 13:00 +0300, Antoniu Miclaus wrote:
> > Add the ad4851 entry in the MAINTAINERS file.
> >=20
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied.

Thanks!

Jonathan

>=20
> > =C2=A0MAINTAINERS | 10 ++++++++++
> > =C2=A01 file changed, 10 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 4a0089db6670..d5a985ae62bb 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1350,6 +1350,16 @@ F:	Documentation/iio/ad4695.rst
> > =C2=A0F:	drivers/iio/adc/ad4695.c
> > =C2=A0F:	include/dt-bindings/iio/adc/adi,ad4695.h
> > =C2=A0
> > +ANALOG DEVICES INC AD4851 DRIVER
> > +M:	Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > +M:	Dragos Bogdan <dragos.bogdan@analog.com>
> > +R:	Antoniu Miclaus <antoniu.miclaus@analog.com>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Supported
> > +W:	https://ez.analog.com/linux-software-drivers
> > +F:	Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
> > +F:	drivers/iio/adc/ad4851.c
> > +
> > =C2=A0ANALOG DEVICES INC AD7091R DRIVER
> > =C2=A0M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> > =C2=A0L:	linux-iio@vger.kernel.org =20


