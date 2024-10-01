Return-Path: <linux-iio+bounces-9971-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D8C98C581
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 20:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AC50B21CFA
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 18:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB59E1CCB37;
	Tue,  1 Oct 2024 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjCeevqH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8149F18E02D;
	Tue,  1 Oct 2024 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727808084; cv=none; b=jAfXzIqQOy/lyurHjAns6wZZqrwPS9xIVBijR+AR33sOzAsCJoNFlSUIhH864/bX3ImL2Sr0VTdT6tocKBW7kLhjFLv/2ZCyWO15/Sv/m1XLWh/q+Nip/WlkDxYPfziUKAgALUKcGWqH0YXMIr/YzHY/o1DEs4FrzMMy/GH1xS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727808084; c=relaxed/simple;
	bh=t6jXVhJbieUAZp5bjb0m1RV3hJR3Oc0FImaAeY3GO9I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxMOt+oIJdaKsJOjJdm23x/qzeq/pAQ+C9XFM1I1oW+O2ccFpSRGJ/ktnwvt3S8SOJfZqBW3Ejs6DtIJR0LE9VmNNz4mfINKOPOLFu9Kg8zIuuibMuEFpLZUd0jl7OV+tILs6z4OJXL+AdYKOVaeS1PB5lElV2zRpj6EBvf7vNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjCeevqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D14C4CEC6;
	Tue,  1 Oct 2024 18:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727808084;
	bh=t6jXVhJbieUAZp5bjb0m1RV3hJR3Oc0FImaAeY3GO9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kjCeevqHgLa7Gc+PNYKsac8MDYG3zgzP77/KEJDo1FC6BQu4Lqub3l0lO8InIFpXu
	 HXyDI6VNPD1VIUFvzMQU2Vh7+8HNrafUJnwGSo4r0TY+APZyeekjnhx4a6GzCvK1p+
	 YHFXTsUuLhjG1kgsFtVxvfzR4e1eft3vLHZie4t475HGLyit9e7ADdjri9Xa+wQzsG
	 3BAJjnu11qdanuQcMUDgUCk9WnKqSsqWEwSVYrLpZ3krl3JZbodUwpMhWtgyokOkZW
	 b8tddfioAKvt/rXj9FdO4LyVtjVGJtzVD3EYZ8i54X18qgWg9Z1IzrBE7V6zl349qQ
	 tFccziCFgXjhQ==
Date: Tue, 1 Oct 2024 19:41:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Alexandru Ardelean <aardelean@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de,
 michael.hennerich@analog.com, gstols@baylibre.com
Subject: Re: [PATCH v7 8/8] iio: adc: ad7606: add support for
 AD7606C-{16,18} parts
Message-ID: <20241001194114.16e0ffa5@jic23-huawei>
In-Reply-To: <047034ae-135b-4ce9-a407-9b2a00841324@baylibre.com>
References: <20240919130444.2100447-1-aardelean@baylibre.com>
	<20240919130444.2100447-9-aardelean@baylibre.com>
	<CA+GgBR_kKYOgPUHM5-LUAZboy6nab1tLvC4TFtzpqkjP+5A8wg@mail.gmail.com>
	<047034ae-135b-4ce9-a407-9b2a00841324@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Oct 2024 08:42:23 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 10/1/24 3:26 AM, Alexandru Ardelean wrote:
> > On Thu, Sep 19, 2024 at 4:05=E2=80=AFPM Alexandru Ardelean
> > <aardelean@baylibre.com> wrote: =20
> >> =20
>=20
> ...
>=20
> >> @@ -153,7 +349,19 @@ static int ad7606_scan_direct(struct iio_dev *ind=
io_dev, unsigned int ch,
> >>         if (ret)
> >>                 goto error_ret;
> >>
> >> -       *val =3D sign_extend32(st->data[ch], 15);
> >> +       chan =3D &indio_dev->channels[ch + 1];
> >> +       if (chan->scan_type.sign =3D=3D 'u') {
> >> +               if (storagebits > 16)
> >> +                       *val =3D st->data.buf32[ch];
> >> +               else
> >> +                       *val =3D st->data.buf16[ch];
> >> +               return 0; =20
> >=20
> > Arrggh...
> > I messed up here.
> > Guillaume found a bug here, where this should be "goto error_ret" or
> > do an "if ()  {} else {}"
> > How should we do it here?
if / else. Goto an error label when it's not an error would be horrible!
> >=20
> > Do we send a fix-patch or send a new series?
> >  =20
>=20
> Since this patch is already applied, just follow up with another
> patch with a Fixes: tag.

I sometimes tweak these sort of things if I haven't pushed out
as togreg yet (or they are really bad!) but in this case I'm not
100% sure what the comment is, so I'll just apply a fix on top.

So David is entirely correct in general but by luck of timing
this time I'll tweak it.

Please check the result in iio.git/testing
I'll hold off pushing that out as togreg until at least end of
tomorrow.  One more day o

Jonathan


>=20
>=20
>=20


