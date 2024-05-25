Return-Path: <linux-iio+bounces-5289-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCDE8CF013
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 18:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EFE01C20F39
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 16:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93C68595A;
	Sat, 25 May 2024 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trIbj26K"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A9058ABC;
	Sat, 25 May 2024 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716653976; cv=none; b=oB8gH1uuRqPCF46gPVKTEhv06AwIg5biDIEGDU2RtlLJeP2U5RxlkpI8l6Wn3PZtWOehx3ECwAgGDUZ+INOnmlo1yaHL3yTsxqfDZgSc2iG4qZP61/8WRcukVdxOw7tMizDdg7TRV3u02R4SOZEnjcnnJ5k1KNgrb9n8cm8mr9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716653976; c=relaxed/simple;
	bh=DqBxfVMDTtQnFRu/56CssttbGbxLKTGzD2Ic2RIAcxY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5eDaiL/j5uKEoJlXvr8CkM7ChWkWvym8Q8Lx0J0yyhyw2jbLRP1ILyFJ9rAuL+o+JfWs2IqW7+Pxxnz0drzV40lsdUzDoa0dXYa0XhBNGygLiKHKy1KdaOnvrxOhxEc84YzAyvsSwclSxmmGu9QMfu9Sokk7uTq1sdyaFz2WpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trIbj26K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3EFAC2BD11;
	Sat, 25 May 2024 16:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716653976;
	bh=DqBxfVMDTtQnFRu/56CssttbGbxLKTGzD2Ic2RIAcxY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=trIbj26KDRTFngfSwrAoTXCdJ8vQRM+Kj9EEgvwY3YAawrHomLA5pkmqwYeyKOSPn
	 +kXPIjQ7F55odO6Pt8qUFOT2M0kQNyOOcEJkDkw0wWE/WJ19NqXsrVqfSJ7BDUgncA
	 KwkZQtRB0jqv6wiym5uOsSh2RcTEL9OTnMTAJQGF+1LNbL2aXgcUiGSTk3YMcQFFPr
	 T7QUKQxdpmjTvARY7KvRX/8cZ5akqL+OpFGdrDaCy5XfRpI0ZShoHQRx5oZQQnY7EW
	 s0tuhHWl10ROPiBwk7oKkaD/innTmlG7GBvZgWnpZgkgO7IWDLXgohWnVzM/Wc60s7
	 pbmAdTOKeG29g==
Date: Sat, 25 May 2024 17:19:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Julien Stephan <jstephan@baylibre.com>, Esteban Blanc
 <eblanc@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] iio: add support for multiple scan types
Message-ID: <20240525171922.58974617@jic23-huawei>
In-Reply-To: <e1277a004b5aef8e6b407089ac1e3df6ff6fee50.camel@gmail.com>
References: <20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com>
	<e1277a004b5aef8e6b407089ac1e3df6ff6fee50.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 21 May 2024 11:18:24 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2024-05-07 at 14:02 -0500, David Lechner wrote:
> > Following up from this thread [1]...
> >=20
> > Unless I've overlooked something important, I think adding support for
> > multiple scan types per channels should be rather trivial, at least in
> > the kernel. Userspace tools will need to learn to re-read buffer _type
> > attributes though. For example, it looks like libiio caches these value=
s.
> > I had to restart iiod to get a proper capture with the iio-oscilloscope
> > after changing the scan type at runtime. =20
>=20
> No for now but to add more future fun, we may consider in having something
> similar as hwmon [1]. Hence, userspace could do things like poll(2) on the
> specific file rather than having to read it over and over...
>=20
> [1]: https://elixir.bootlin.com/linux/latest/source/drivers/hwmon/hwmon.c=
#L649
> - Nuno S=C3=A1
>=20

It would take a well reasoned usecase to convince me sysfs notifications
are useful in cases where an explicit userspace action caused the value that
would be read from another file to change immediately.

Jonathan



