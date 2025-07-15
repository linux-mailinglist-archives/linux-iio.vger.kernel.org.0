Return-Path: <linux-iio+bounces-21678-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1622B05616
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 11:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47FB1750B8
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 09:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87D52D5439;
	Tue, 15 Jul 2025 09:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="r02bEfm/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-10624.protonmail.ch (mail-10624.protonmail.ch [79.135.106.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34A7263F52
	for <linux-iio@vger.kernel.org>; Tue, 15 Jul 2025 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752571110; cv=none; b=OCsPUm3ERZoSOVF3Ks7SiHjWfN5AFpKEQdH62CjBA3xockqa4z0L1JH51toOO/KQ3pGAi8c94NiVj8pGbx3fu9Ii48rPMxQJg2ZseLbZLgMUMSUFXs8JH31jKdwahyfTwrIMF0OQ4RqI+L0t7ecJgnAVako4qIwQvsJLNlPkz3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752571110; c=relaxed/simple;
	bh=yaiu3PSIIdzpxUAb4yz7KS2vPwy6a0v2mtpXwjF0JXQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PiYIepY548OoAnx2POgPThuLBCDlWKO1SuAa9VljBUSmufkY0ewSmN6s0lC+dL6IeC49VNtqVXX0XRwE+w4J8m+2lvZe2ctz3OEWh6NJOELZMsbpFKxOYQzmJMCmfKHwg6JgCZR6W2xg6RzzrfGxb1PE+p+13s2pqLQbmQa0Ph8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=r02bEfm/; arc=none smtp.client-ip=79.135.106.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1752571100; x=1752830300;
	bh=yaiu3PSIIdzpxUAb4yz7KS2vPwy6a0v2mtpXwjF0JXQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=r02bEfm/r4pSVwGYErTLzyc7NmfyqYsfG1rE08YLcutFQ1MUOFLAfvB3zTGTc8/z7
	 2apCB8+MW5MBn0AusIfY0VFfyxzl9Gv2abc6WwkP7G1Vgm7Fbq+y2athOi7Npi4kuf
	 bT/5sNhl9j0IrEBE+wa4VV4jbXV5iEDODwb7SsAy3HCKPy8oikaNuhvEFf7a2Y4Sjj
	 C23mrGGSM6gHwLM7CFRw9tdVPnf85VVXxkhHczxip0tetEpbqLcn1UiOY5W6AX80lh
	 rI6kce9nM7zOoUxiJSfnPrhcF78ptbboapsT7nN3gAvtmSiSF6zAa+dDbXRW4sVU02
	 h825yh3IT4r3g==
Date: Tue, 15 Jul 2025 09:18:13 +0000
To: Remi Buisson <Remi.Buisson@tdk.com>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 0/8] iio: imu: new inv_icm45600 driver
Message-ID: <k3pvwgafvocfqu2bntoz4heukfvpy34oycl3jdbc7hm2ewgfoo@mjyz4tszvt45>
In-Reply-To: <FR2PPF4571F02BC629C0221E1A77EE838B68C57A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com> <zkxaafrvyizbnxtuuj7jwh26jdat7tbvsnnxpnfz7fnmqjuycy@qqr6fzb46kvg> <FR2PPF4571F02BC629C0221E1A77EE838B68C57A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 91fa81946cf6a687b3a12e16d7adda0a4a1c96a5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 09:03:57AM +0100, Remi Buisson wrote:
> >>This Message Is From an External Sender
> >>This message came from outside your organization.
> >>
> >>

[...]

> >>
> >> The structure of the driver is quite similar to the inv_icm42600 drive=
r,
> >> however there are significant reasons for adding a different driver fo=
r
> >> inv_icm45600, such as:
> >> - A completely different register map.
> True, but icm45600 and icm42670 are more similar regarding indirect acces=
s
> and FIFO management.
> >At one point we asked TDK/Invense for a driver for icm42670. It also
> >have a completely different register map... Grrr :S
> >
> >Anyhow, should we combine these drivers in inv_icm42600? Like
> >st_lsm6dsx?
> I don't believe so for icm42600 and icm45600, because of the exposed reas=
ons,
> they won't share much in the end.
> However, new parts like icm56600 might share the same driver than icm4560=
0.
> (even with different memory maps :( )

Thanks for the clarification.

/Sean


