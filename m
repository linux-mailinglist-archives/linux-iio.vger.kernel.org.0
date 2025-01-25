Return-Path: <linux-iio+bounces-14569-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C12BA1C325
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 13:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F6433A64E6
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 12:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E791B207E1C;
	Sat, 25 Jan 2025 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcaxKZF4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A899E207A3E
	for <linux-iio@vger.kernel.org>; Sat, 25 Jan 2025 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737808199; cv=none; b=rfku3cRUG08RMnii6TanZldz2k9fBpV1ABuaPTlhKi8XLpPGN6d1iBoAwVWxaXnj5eYnXpLuhJc1ZOmWMPAuPH64l0sVc+a4j6vrW9soOgtzJ7wLsvGshTFUAtYkg2U2WALIEw9XRflzgKUiprW8aeP3iNeqB07HMVbCGYF/Osg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737808199; c=relaxed/simple;
	bh=ZWIh+y9qxiAMxKhc1oQGAFafBFFTuZOmu69V4G/rVtE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h15se1snukcyri6cX9dskGWD9xGNaZGh74CJjIYPoJ67Cxwmb3RYV78HqKhFaAGYlvBhrQdCC0dxw0jbBLeJgehzuzR2bLbKm96i2JqyU1J6FCKiux8SNl6D7yd1uFadT+SFdvj4H3XQra6ob6AwdAhzevrjiThN/97f/wJw2jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcaxKZF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C5DC4CED6;
	Sat, 25 Jan 2025 12:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737808199;
	bh=ZWIh+y9qxiAMxKhc1oQGAFafBFFTuZOmu69V4G/rVtE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LcaxKZF4V2DFYtezLqDYbCEBwiXZ5UVoouGHGvZ6+DLLF1rBk8yK+1JoTXXjokERf
	 RKknFXOXrlmHIyY6JEllGBc1R6xatY9mQ+TGsGNgU4yk3VnSrC/LtWegoXggvRmyHr
	 58xnhSOaweDqkkPV/0j2C2BXcPZlF2HAIY9KuD/vU7jNAKjuAcJmZ4DAgEno+NXCGU
	 vc3a7oXr26zptoGGaoLBsB+m6Tia1MeMgQ27Rm3esVsxN54qk18idWIbzMtONKK5Ik
	 bx8BXHe5QOd3C7sZo1S20YsVODaTBXQyqp9F+ve2XY4fiYZrN+Loa8UWLMDp6qvgZE
	 F8NeZDb3u3ECQ==
Date: Sat, 25 Jan 2025 12:29:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Lars-Peter Clausen  <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad7124: Micro-optimize channel disabling
Message-ID: <20250125122951.1609bf02@jic23-huawei>
In-Reply-To: <dfb5c6311896c040593bafc390d72b5a0ef307d5.camel@gmail.com>
References: <20250120140708.1093655-2-u.kleine-koenig@baylibre.com>
	<dfb5c6311896c040593bafc390d72b5a0ef307d5.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Jan 2025 15:52:20 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2025-01-20 at 15:07 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > The key objective in ad7124_disable_one() is clearing the
> > AD7124_CHANNEL_EN_MSK bit in the channel register. However there is no
> > advantage to keep the other bits in that register because when the
> > channel is used next time, all fields are rewritten anyhow. So instead
> > of using ad7124_spi_write_mask() (which is a register read plus a
> > register write) use a simple register write clearing the complete
> > register.
> >=20
> > Also do the same in the .disable_all() callback by using the
> > .disable_one() callback there.
> >=20
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> > --- =20
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Applied.  Thanks,



