Return-Path: <linux-iio+bounces-10399-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45443998EB6
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 19:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75DF51C2362A
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 17:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD2919CC10;
	Thu, 10 Oct 2024 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4LeYP+8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E4219A292;
	Thu, 10 Oct 2024 17:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582471; cv=none; b=qsjNlZdbZOxZnfgnYR/ZMVY3k8DwTlci4p4fAyVHhkP3J/q9NDNiLuzatzEMjKCmox68624kvKnvqN4qiYzvIZOBHVcdERNq5NV4cEuNv+CixHAtjzZPJlRxKrXyX/e/Yk4+rIPfIlI84BKV+R5RKjNpIi/uUeBJ5sqXvBXfC6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582471; c=relaxed/simple;
	bh=tqW3HNkzdDUFotQYvxdaqpfS1qgxIo1pj80zT2CfJ/I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NF2TiHPunXoHAIDjUGWU4AS72mt+9V6dZmYvBetkfbESOlnWI60/jRv0FSFmPoBzK91UCKDA5BBIdwvnGb3hyBdlYWGLII4hNfnS0vQHE5vlHOK3uXxVRKSIy0CqLKcrBZDZ6Mgj8OYU5oFF71hW+KwsH0TPTg7JxiXkT7OTcKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4LeYP+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC47C4CEC5;
	Thu, 10 Oct 2024 17:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728582470;
	bh=tqW3HNkzdDUFotQYvxdaqpfS1qgxIo1pj80zT2CfJ/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h4LeYP+8B9AZoEfvk4EcFNjfvo4R31ZcpbbzwvDaTACsiM/puQqADmaUw9AO6maYH
	 HHiAop4mPwcIYfQLIiM1fVPX4gE9Q5RasF5SkLradAWZAAcXmpvDRBPdxXUJFwtWqe
	 ohOhd9RyWChZfdnLgw2aXe9mfjKQX4JaJwL3K7LKW05ZaX7OZl3mO2/TLErttyNnnt
	 CaziJnAiGp4GWdoRh7ntRCdv+k26JorlRx6dO6OwzGXchRfNs3wH4mjupre6UYNlEF
	 uilGUCuYSc5T9GltZjAtzIZkdkDmX7sme7ZNGTsw19ozBuJc2+tcT++cVkhFlWqTij
	 dPv0YbjBEAksA==
Date: Thu, 10 Oct 2024 18:47:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Emil Gedenryd <Emil.Gedenryd@axis.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "dannenberg@ti.com" <dannenberg@ti.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "lars@metafoo.de"
 <lars@metafoo.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Kernel
 <Kernel@axis.com>
Subject: Re: [PATCH v4 2/2] iio: light: opt3001: add support for TI's
 opt3002 light sensor
Message-ID: <20241010184742.1747bfe2@jic23-huawei>
In-Reply-To: <b40d22b5bdf487b40207e676d35a0507c47cbb26.camel@axis.com>
References: <20241003-add_opt3002-v4-0-c550dc4591b4@axis.com>
	<20241003-add_opt3002-v4-2-c550dc4591b4@axis.com>
	<20241006141624.3fa5bf34@jic23-huawei>
	<b40d22b5bdf487b40207e676d35a0507c47cbb26.camel@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Oct 2024 07:19:06 +0000
Emil Gedenryd <Emil.Gedenryd@axis.com> wrote:

> On Sun, 2024-10-06 at 14:16 +0100, Jonathan Cameron wrote:
> > On Thu, 3 Oct 2024 14:22:17 +0200
> > Emil Gedenryd <emil.gedenryd@axis.com> wrote: =20
> > >=20
> > > +struct opt3001_chip_info {
> > > +	const struct iio_chan_spec (*channels)[2];
> > > +	enum iio_chan_type chan_type;
> > > +	int num_channels;
> > > +
> > > +	const struct opt3001_scale (*scales)[12]; =20
> > This doesn't compile for me as one of the two options only
> > has 11 entries.  You could either force them to be 12
> > entries each or use a pointer without the size and
> > add a num_scales entry in here.
> >=20
> > Jonathan =20
>=20
> Hi Jonathan,
>=20
> Are you building on top of the patch that was accepted in earlier version=
s of this
> patch set? That patch adds the twelfth missing scale value for the opt300=
1.
> See:=C2=A0https://lore.kernel.org/all/20240916-add_opt3002-v3-1-984b190cd=
68c@axis.com/
>=20
> Should I have added some tag to highlight the dependency for this version=
 of the
> patch set?
Ah.  Yes, I was half asleep.
They are going via different branches (slow and fast) so I'll have to
sit on this series until after that fix is in the upstream for the togreg
branch of iio.git.

If I seem to have lost it after that is the case feel free to give me a pok=
e.

Jonathan


>=20
> Best regards,
> Emil=20


