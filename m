Return-Path: <linux-iio+bounces-12530-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D9E9D6986
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 16:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E87D5B21BE1
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 15:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC56D1CAA4;
	Sat, 23 Nov 2024 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5mwk7yU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6324A29;
	Sat, 23 Nov 2024 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732374069; cv=none; b=sv+FbP1W/Jf1luu7ijJX/CKMkUSwItXG0oAeyhXVK5IKDI8UOmSPOx2PXjhGlVRofeSlyU/fU/6UT8WyEL3sZo7qXnDhApH2KNpktjsDPVgEWNObnwOytn/ctPzEv1eBD6/CISXvhA1fa2vF+0NHBvWLHXpz2OQrz0ooRYJqBVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732374069; c=relaxed/simple;
	bh=FouD3aP6VTMBEwM4/qIP1Tvlz7WDkmNFex4b7huGuh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMHEGtpOYz8722qdZAgPmFcr3BAwIOIfdzKEFq1FNgiTaXaFepBa6t4WOoppjBEK0wmF4lZlZD4i/0AW4p0+V0qs+pbnvE6SO1j8wEfvBFmlNhNlnhgYlchhmWPd3yf8mnNPwWdGGtc5y8tWPxelcPL/+h5MbuetU3eCcid2hlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5mwk7yU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56DBFC4CECD;
	Sat, 23 Nov 2024 15:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732374069;
	bh=FouD3aP6VTMBEwM4/qIP1Tvlz7WDkmNFex4b7huGuh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l5mwk7yUtswNNSZuZOk94o80Aruj4yqJbHNPj2GtYCY5Fsm4UD6KQRVhXV7U8H+wf
	 /ZyVX80VgjPotIcnWRBI+B62R7ugskvFzbMYXDtO6RKsFp4zjd8BU4TNdGVvMc8bIV
	 SWrWDKnMT0uEu3vxG9Lsp+n6K3qWRukXDbSH1MvC3rimUj5XCLc3KESst9jpr7rPyY
	 M0QRzeft7jSkMvBjnDheTs30BLZXMuViSuqp+2rPpbOr3zkOoJE7vD8oDir9RTbIKc
	 S8IDSwA0Z9+DxvkfZCmgwSXWLTc9g4caGBdsQoaOyK5M+EjK/pV3Yjem+LQr0+YKF5
	 MaC5d9dVZVh2w==
Date: Sat, 23 Nov 2024 15:01:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ad7124: Don't create more channels than
 the hardware is capable of
Message-ID: <20241123150101.1c5ce5c8@jic23-huawei>
In-Reply-To: <8636a00f-81e6-4439-9778-abce6e0c931b@baylibre.com>
References: <20241108181813.272593-4-u.kleine-koenig@baylibre.com>
	<20241108181813.272593-5-u.kleine-koenig@baylibre.com>
	<c94271b1-924b-4de6-b3bb-77e16265bb0d@baylibre.com>
	<c2mdg4pn5rgjdlwet2gmgqvmym36ttlyg5ag2u62a3qtkdwqce@p45gyz5ghgel>
	<8636a00f-81e6-4439-9778-abce6e0c931b@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Nov 2024 08:21:45 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 11/11/24 6:08 AM, Uwe Kleine-K=C3=B6nig wrote:
> > [dropped Mircea Caprioru from Cc: as their address bounces.]
> >=20
> > Hello David,
> >=20
> > On Fri, Nov 08, 2024 at 12:52:35PM -0600, David Lechner wrote: =20
> >> On 11/8/24 12:18 PM, Uwe Kleine-K=C3=B6nig wrote: =20
> >>> The ad7124-4 and ad7124-8 both support 16 channel registers. Don't
> >>> accept more (logical) channels from dt than that. =20
> >>
> >> Why should the devicetree be limited by the number of channel
> >> registers? Channel registers are a resource than can be
> >> dynamically assigned, so it doesn't seem like the devicetree
> >> should be specifying that assignment. =20
> >=20
> > Note the device tree isn't limited as I didn't adapt the binding. It's
> > just that the driver doesn't bind if too many channels are specified.
> > And while your statement about the channels being a dynamic resource is
> > right, currently the driver doesn't cope and allocates resources
> > statically, and happily assumes there is a CHANNEL_16 register if the
> > device tree specifies 17 (or more) logical channels and writes to
> > CONFIG_0 then which very likely results in strange effects.
> >=20
> > So as long as the driver doesn't implement this (possible) dynamic
> > mapping to the CHANNEL registers, it's IMHO right to refuse to bind (or
> > alternatively only use the 16 first logical channels).
> >=20
> > Best regards
> > Uwe =20
>=20
> Understood. It would be nice to implement such dynamic allocation
> in the future but as a fix to backport to stable kernels, this makes
> sense.

Agreed.  We do have other drivers that have internal allocators
for constrained sequencer resources, but they are complex so not
fix material!

Jonathan



