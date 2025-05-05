Return-Path: <linux-iio+bounces-19114-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D5DAA97FE
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 17:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6B0189F534
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 15:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2522627E5;
	Mon,  5 May 2025 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3Hnfip5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C229425DD11;
	Mon,  5 May 2025 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746460346; cv=none; b=fjtpuMOo7bp2sKJ+7NiJm31Eb3r0XkTds8cTfTzBw62lwCAWFf+aBrIwDUh/vlNVL6Tno/IR8zo4VH7RqdrOFb7R/u2aC+f6c/LhQi9TaAFmSWZ0LSNuZNWvgLE/nJmXC65go4Z7mQdyWJErXWoaBnYzAol67Vf/kawP9cz+rzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746460346; c=relaxed/simple;
	bh=5IswUIf2LBjErYpwD2yUDrq5eOi5NpPLhaW5rPTk5JU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RolnHFa3YXH/r2ZY/067VVKqIj5EzW0n3lag0NAEqaDXQKh5WcRDeHZu14k2snOixcuGEioKe4FjNPolxmWqIjC7Fbg3zE1iSSRGYSEDqRWS1M98Rf8fBtL4ZqhmlpR7OJxKsgoK2VhSeLQ0DsnJS4KgS8qqaSChGlXr6kLxxgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3Hnfip5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DF7C4CEE4;
	Mon,  5 May 2025 15:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746460346;
	bh=5IswUIf2LBjErYpwD2yUDrq5eOi5NpPLhaW5rPTk5JU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I3Hnfip5QXedMCdVb1k0iQ+REupHKsuTBuBL2EXKLo1lVarIVcP9vIFwmcbg4aurn
	 IXHmN65gVh215nLZNlt5F6CsQjZpxWzyrOQpmE/l/AIlI+ezwlxtqIChdHmoAPYXsk
	 oX3jUUFwnc5CoKLYXdyb8IlVu2QAuhz4WuUeLfiEzw3IbxJ0LWPEclP567v/O37edL
	 0jd6l1bWWb/nvHFNMbEPDuUUuEB6K3G09GGMXbXfjTyl5OAxf/OSKqDh0/0Esl3kBB
	 jtiuCLnrk5q9JIePmIU57De6tAczj2uKtqIj4O8AxMSmSBa2BYId3kqG6lbT8RI2B9
	 34jhLgD0WGTbw==
Date: Mon, 5 May 2025 16:52:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
 linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
 broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com, David
 Lechner <dlechner@baylire.com>
Subject: Re: [PATCH v6 07/11] iio: adc: ad7768-1: add multiple scan types to
 support 16-bits mode
Message-ID: <20250505165215.4dc4073b@jic23-huawei>
In-Reply-To: <CAHp75VcUgwZWgaAX8XNrVLc8Rnn-xMAqFSKvh=+bQWNM50pyPA@mail.gmail.com>
References: <cover.1745605382.git.Jonathan.Santos@analog.com>
	<0a214d5dfacc3976db71af8a80f9dcf2887fe6cc.1745605382.git.Jonathan.Santos@analog.com>
	<CAHp75VcUgwZWgaAX8XNrVLc8Rnn-xMAqFSKvh=+bQWNM50pyPA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Apr 2025 09:55:44 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Apr 28, 2025 at 3:13=E2=80=AFAM Jonathan Santos
> <Jonathan.Santos@analog.com> wrote:
> >
> > When the device is configured to decimation x8, only possible in the
> > sinc5 filter, output data is reduced to 16-bits in order to support
> > 1 MHz of sampling frequency due to clock limitation.
> >
> > Use multiple scan types feature to enable the driver to switch
> > scan type in runtime, making possible to support both 24-bit and =20
>=20
> at runtime
> making it possible
>=20
> > 16-bit resolution. =20
>=20
> ...
>=20
> > +       ret =3D spi_read(st->spi, &st->data.scan.chan,
> > +                      BITS_TO_BYTES(scan_type->realbits));
> >         if (ret < 0)
> >                 goto out; =20
>=20
> Add a TODO to convert this to use a new helper from 163ddf1fea59.

Mostly because I couldn't immediately track this down in any tree
I had locally..=20

https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?id=3D163ddf1fea59


>=20


