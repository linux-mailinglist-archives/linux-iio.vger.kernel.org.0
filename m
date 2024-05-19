Return-Path: <linux-iio+bounces-5120-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC85C8C957A
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 19:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B9B1C20F11
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 17:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5494D59B;
	Sun, 19 May 2024 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzZAx86x"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EA74D9E7;
	Sun, 19 May 2024 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716138593; cv=none; b=L69vkEOxXRJ54fgq9GoXQz21Bko3hNXMnaEAR310dJUzRtElAmQcHDOyJtC1d6ZZEyfsGWNaVZGTe85H5wu3tSFcruo+F0XAqC8C/tIRJNqsHln5NYdxqIAI1iq+av9JKFN+rj33hnG7WTmq/8EDiYkzALaIxbp1GuifniaMMA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716138593; c=relaxed/simple;
	bh=r6ctGqV2Of4FDB4I7mZgJ0LjjU6DfSPAcxAg/39Qbtk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDRtNAozJI7FnlX9rs22Y1ACJztoKxGTOuqxlwQDgBD7i3+6wCf5iJJqJiLTbr5+TP/ra4hcQYai0JzL2xXWQCWa3U+jP2zdkvwpiBJ3LT4mnWnzW42By/OclE97AzHDH7Cn6n5TSSWN5M/B1m+tqs4Ae04XAqmkpvtgr7NsWic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzZAx86x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281EEC32781;
	Sun, 19 May 2024 17:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716138592;
	bh=r6ctGqV2Of4FDB4I7mZgJ0LjjU6DfSPAcxAg/39Qbtk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uzZAx86xHm2I5voFjjXtCgnsjcFi0IzLHI3PSiJRAqRM7SOI+ju0hV7sNllwmI6oS
	 8AIU1tVa1zjMBGjnR05OtX8IyQZ5ZJxQ2DEe1yjgc4QpugYqCmrWtmz+iYmOHqQqtV
	 4BWUFfP+67WfZlaIEu7qyv3bnf7vNg8oobnrbvAN9YGicVF9QbyVC0E+PzR2oVblka
	 gD4pxYtRL0iLMICE9pUgPphjkDssiD1KkEBme49pw7hwPbDP0idokUAKaBKJ169vHG
	 SEufWJKWgkTFyfCCFJ7/XAcry+bKALPhHQ7J/tysXpihVfKN4VTqdvFzCL0nE4F2xg
	 CQZzMYlJZsJxg==
Date: Sun, 19 May 2024 18:09:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>, dumitru.ceclan@analog.com,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] iio: adc: ad7173: Add ad7173_device_info names
Message-ID: <20240519180942.6fa2bfe6@jic23-huawei>
In-Reply-To: <CAMknhBGGYztOsP74YEExG0OhAhMFtjh9Q=x3yAvSK=NQeL5e0w@mail.gmail.com>
References: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
	<20240514-ad4111-v2-6-29be6a55efb5@analog.com>
	<CAMknhBGrn+dSF=QJngUWaQ04tAwQf-9wmq0V2OgYS7sFKHroUA@mail.gmail.com>
	<167516cf-303b-48a5-ab84-173cea8e82f2@gmail.com>
	<CAMknhBGGYztOsP74YEExG0OhAhMFtjh9Q=x3yAvSK=NQeL5e0w@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 16 May 2024 11:43:17 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Thu, May 16, 2024 at 11:09=E2=80=AFAM Ceclan, Dumitru
> <mitrutzceclan@gmail.com> wrote:
> >
> > On 16/05/2024 02:32, David Lechner wrote: =20
> > > On Tue, May 14, 2024 at 2:23=E2=80=AFAM Dumitru Ceclan via B4 Relay
> > > <devnull+dumitru.ceclan.analog.com@kernel.org> wrote: =20
> > >>
> > >> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > >>
> > >> Add missing names from the device info struct for 3 models to ensure
> > >> consistency with the rest of the models.
> > >> =20
> > >
> > > This affects userspace, right? So probably needs a Fixes: to make sure
> > > this gets into the 6.10 release?
> > > =20
> > I don't think that it breaks userspace, just creates an additional file.
> >
> > This creates the file "name" in the iio:deviceX directory that reads the
> > string. I do not consider the Fixes: tag a necessity. I consider that it
> > resolves inconsistencies in the _device_info struct. =20
>=20
> Ah, OK. For some reason, I was thinking that it would default to the
> driver name if this was left out.

Hmm. I'd be tempted to take this a fix as some userspace code relies
on that name being present and it is unusual to not see it.

Jonathan

