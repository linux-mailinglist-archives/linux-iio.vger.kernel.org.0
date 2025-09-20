Return-Path: <linux-iio+bounces-24313-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E9DB8C658
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 13:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5FA3B3456
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 11:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A095F2FB084;
	Sat, 20 Sep 2025 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHz7Y/AX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8CC25DD1E;
	Sat, 20 Sep 2025 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758366022; cv=none; b=o7w3fZLzhZHWgd4L9B4T76FW9h5Q0CtftowBzdXZ2fTXaQ8Ysa5oZ7LO3NaAs7AhGi3xXA3B5sw7zxtcaI3znZmcxhaPs5YrmtXxMkCox7ASRZodmtf+y6ggo8n7xA+CJAVQI3uJldLyCXbfnuWVBDQN1ELkADN5hlkO0xBwf2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758366022; c=relaxed/simple;
	bh=Ly2LPCvsrrspBvDaxxZmI2slrHIwUSmHQUo56fNRVA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFWTAMl8S26rofEFRv/QB5QN5CgopxxQpFpwMhidy21Vodco2eXErEb1bxx/IKVkugGrqVLD/+EAvqWs7wTlomAn/DuZAyk1RrPqNKf9CKrMaRpK+89wk6MPcaeo6YC29pQ/UnxUynXZ7rYVtbkhYGYXoJSP62Rdxmxe4el8VYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHz7Y/AX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8116DC4CEEB;
	Sat, 20 Sep 2025 11:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758366022;
	bh=Ly2LPCvsrrspBvDaxxZmI2slrHIwUSmHQUo56fNRVA0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tHz7Y/AXouD7tW65vnh7G8MV41sr5yMRJuGFIbwC04q06rld75yAt/MIAgD7B59cA
	 OdiEXgCYsEaxxQ8Kszxm2KbWFAzz+8rY2b4zy1sd33QUijv4S5GnuOfC2fkCeG9TeT
	 zNDHosIWV1y60P6roMrQu3xKbpmccnkYzK7S6KczEwxjmghoxfpJSAGUVNF9kkpvOJ
	 qeFDAqr4NfI7J4LpbuuK8GOOJwJWsAXYT9pn/8pGx1W/lupvHcsLztRHkqUQzsaAmP
	 1VcjtyN0AzO1eZOGhzbCap7fKjjslJQBfDEh+bATBpCCf3HQL+BEOSliVHeWxOBQ58
	 vIJc5rl0ViAyw==
Date: Sat, 20 Sep 2025 12:00:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Michael Hennerich 
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= 
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7124: add debugfs to disable single cycle
 mode
Message-ID: <20250920120014.2c4b6701@jic23-huawei>
In-Reply-To: <d20225be2339e7b08f65edf18f9fa71ae5840f0c.camel@gmail.com>
References: <20250917-iio-adc-ad7124-add-debugfs-to-disable-single_cycle-v1-1-c83ab725faca@baylibre.com>
	<d20225be2339e7b08f65edf18f9fa71ae5840f0c.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Sep 2025 11:34:48 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2025-09-17 at 18:03 -0500, David Lechner wrote:
> > Add a boolean debugfs attribute to allow disabling the SINGLE_CYCLE
> > bit in the FILTER registers.
> >=20
> > This causes data to be read on every conversion instead of doing the
> > usual 3 or 4 conversions per sample (depending on the filter). This is
> > only needed for very specific use cases, such as validating the
> > performance of the ADC. So we just expose this feature through debugfs
> > for the rare cases where it is needed by people who really know what
> > they are doing.
> >=20
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> > In a recent discussion with an engineer who has used these chips a lot,
> > we confirmed that we made the right choice in [1] about always enabling
> > the SINGLE_CYCLE bit. That is what is needed in normal operation and is
> > the expected behavior.
> >=20
> > But there are some occasions where we might want to turn it off for
> > hardware debugging (e.g. to peer into what the filter on the ADC is
> > doing). Hence, this patch to add a debugfs entry to allow it.
> >=20
> > FYI, there will be some trivial fuzz between this patch and the "iio:
> > adc: ad7124: change setup reg allocation strategy" patch, but I expect
> > changes to be requested on that one, so will likely work itself out
> > by the time it actually gets picked up.
> >=20
> > [1]:
> > https://lore.kernel.org/linux-iio/20250910-iio-adc-ad7124-fix-samp-freq=
-for-multi-channel-v4-1-8ca624c6114c@baylibre.com/
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
Applied to the testing branch of iio.git.  Unless the merge window is delay=
ed,
this will be material for next cycle now.

Thanks,

Jonathan

