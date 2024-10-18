Return-Path: <linux-iio+bounces-10743-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ED39A458D
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 20:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2381C22DDB
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 18:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEE7204950;
	Fri, 18 Oct 2024 18:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYZaA4zI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600BC2040BE;
	Fri, 18 Oct 2024 18:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729275098; cv=none; b=ULCCWo6NsgD50KXVSRiGnJaNQ3S3YyCSFNiafdlXnM8P8TP8uBQiUZmc6XkXfTtgo+SEIrI030ZnXHA4N4gxobeK4o7Gu+g90cja7NBzhj9iIOvq6SwN60BO+BV2sDooibUyYVo+pTXY2n/94ML5T4FTXPzoFyDxiRho29+W2m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729275098; c=relaxed/simple;
	bh=2TPOvfABd0T2cKUYUm3jMCFxZQlzTTeFqVbwQk1vh8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FODlW/jysXCfVxyuSTZUDoBstpXOx9sK6UEC08NHUWJFfs0wBvZZ70DmxwZVwI8LStwxCJtTP56egrBFAwL0Tsv93DrOo0oN8GP33RvWh4VQ1NU8kGc0oaxMToO/BpTh+ezokNClOUaG5v0D3T4ks3d5i8pNl2U7EMelsR0o924=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYZaA4zI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB36C4CEC3;
	Fri, 18 Oct 2024 18:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729275097;
	bh=2TPOvfABd0T2cKUYUm3jMCFxZQlzTTeFqVbwQk1vh8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XYZaA4zI+pGUYL+aM+4dYjQvMkUG60DwL7B3vZb8yKUcDoEbh27D1EEnc9Wi8rNVF
	 kjEoOYIYGsD+UDS23BWKSLYveKMB58SoqW+2kgrJ1P884hiZYEYxKsa6H3hovCXAVX
	 rfZpLnsidgiJA4IxuQVo3bO4hPh2J+ALn5QttQbqI7GL3NE2pav+oPNbn/KDUQ4G0B
	 dYMfF7hZcEny516kTBpojxQbAuLKxINncjLJGzfvFquQN3n6s04yHhDGoK64V+r+6s
	 K7cPFTrvS7NYezW+ffJGfgXrQPg84pxLDukqQnCySuPxZKXnwR/1m3pZzJ0VwMM7tX
	 VBIE3vaKUsFDg==
Date: Fri, 18 Oct 2024 19:11:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Conor Dooley <conor@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] ad7380: add adaq4370-4 and adaq4380-4 support
Message-ID: <20241018191128.50502c4e@jic23-huawei>
In-Reply-To: <CAEHHSvZ+j2DyikVQ1XYzk-Zg14FVKP1YHOm-rOimjHydxaGPaA@mail.gmail.com>
References: <20241015-ad7380-add-adaq4380-4-support-v1-0-d2e1a95fb248@baylibre.com>
	<20241015-scoreless-carwash-9ac6047092fe@spud>
	<CAEHHSvZ+j2DyikVQ1XYzk-Zg14FVKP1YHOm-rOimjHydxaGPaA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Oct 2024 09:25:53 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> Le mar. 15 oct. 2024 =C3=A0 18:43, Conor Dooley <conor@kernel.org> a =C3=
=A9crit :
> >
> > On Tue, Oct 15, 2024 at 11:09:05AM +0200, Julien Stephan wrote: =20
> > > Hello,
> > >
> > > This series add support for adaq4370-4 (2MSPS) and adaq4380-4 (4MSPS)
> > > which are quad-channel precision data acquisition signal chain =CE=BC=
Module
> > > solutions compatible with the ad738x family, with the following diffe=
rences:
> > >
> > > - configurable gain in front of each 4 adc
> > > - internal reference is 3V derived from refin-supply (5V)
> > > - additional supplies
> > >
> > > This series depends on [1] which fix several supplies issues
> > >
> > > [1]: https://lore.kernel.org/all/20241007-ad7380-fix-supplies-v1-0-ba=
dcf813c9b9@baylibre.com/ =20
> >
> > What exactly makes this series RFC rather than v1? =20
>=20
> Hi Conor,
> I am sorry I forgot to add some context here... There is an ongoing
> discussion on the dependent series about power supplies and Jonathan
> asked me to send this series to see how to properly handle the supply
> fix...
> See  https://lore.kernel.org/all/20241014193701.40e3785a@jic23-huawei/

Thanks,

It did the job for that.  Given it's on list, do you want a review
of the rest of the patch set, or is it still enough of a work in progress
that we should hold off?

Thanks,

Jonathan

>=20
> Cheers,
> Julien
>=20


