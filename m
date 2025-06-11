Return-Path: <linux-iio+bounces-20441-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 582ABAD5992
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 17:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11FFD7A58FD
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 15:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6B619D8B2;
	Wed, 11 Jun 2025 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1SkR+qE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6404618EFD1;
	Wed, 11 Jun 2025 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654341; cv=none; b=J6g5iuRLHs2m7AL3sg+ZckNqfkmQD1EAV1IJ+3U8edNxCDcVfGkYNLQShdRc2ay2bXZVPcLgz8ngKgd6ixl7NUtT7JqPx0YVz8xgOd0QnjgF8hMQVo/loDKjz0PmueYn/ImUPoaMba9I8y5ckUoPMfUpzbQgvqDeHZBiD8HFyms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654341; c=relaxed/simple;
	bh=fkdrgBvUzYBN8NXklzqS1En4WcCAySs+QMoczg7cBQo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ni3vmUUvdvwZakDd+Gj5pZKGbXefXEJfFiUR5ir7sntdaHSram95NrF+AXYCgWd4elVvuoU+1EJZ3pYz4xhFR1kw30Ej7CDRbJXVymRXEF1IAw8WldLN7CQ8I7MLpF4s0e+uHt7JTZNp5+v4fupVWkAhSaKdXooPDcCgQy3oTfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1SkR+qE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B0DC4CEE3;
	Wed, 11 Jun 2025 15:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749654341;
	bh=fkdrgBvUzYBN8NXklzqS1En4WcCAySs+QMoczg7cBQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a1SkR+qEbRnH6SuUAj0O+BXl+ypH9lEQ6qwlPKvwlsgV3PyPkp+06rQWT2MAlmdaf
	 Kogp7Xh8KMFRjbTIWtC3UH4vRvt6qSodSthF5ASqZUYxiOFj0oHzUBqxR/05Af1t19
	 iVeKqkz9JMvOTnOHdVZpdskk/swy/PUk6muClZ3zCL4UoKEhfk8gie5nTq89uIoXe9
	 0ZdhpwvcrCoqUUhtyr164KCSsfaBqGIjloEHpTtaoGUmHymkrFsKOpxHXUFzegiRjk
	 bmZoaAcGFhPYbdB342+FufIXjKbS3pFRF8Eg3G+k3fijMi4lcdXsA+tMfAo7EtMvw7
	 igYb6vAaac0IQ==
Date: Wed, 11 Jun 2025 16:05:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, bagasdotme@gmail.com,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/11] iio: accel: adxl313: add function to enable
 measurement
Message-ID: <20250611160532.5a5c6a76@jic23-huawei>
In-Reply-To: <CAFXKEHZgvoHVigGcDOchkAsYcs_cpYzfXstRBa_OzS_LEkvNXg@mail.gmail.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
	<20250601172139.59156-5-l.rubusch@gmail.com>
	<20250608162738.407c7d20@jic23-huawei>
	<CAFXKEHZgvoHVigGcDOchkAsYcs_cpYzfXstRBa_OzS_LEkvNXg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Jun 2025 10:55:26 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Sun, Jun 8, 2025 at 5:27=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Sun,  1 Jun 2025 17:21:32 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Rework controlling measurement and standby of the sensor. Therefore,
> > > replace writing the register directly by encapsulating this and deali=
ng
> > > with the return value in a separte function to enable and disable
> > > measurement. This will help to avoid redundant code in all locations
> > > where the sensor configuration needs to be adjusted, thus measurement=
 will
> > > be set to standby, in follow up patches.
> > >
> > > Further, reduce the control mask to only the measurement bit. The sle=
ep bit
> > > actually controls a different behavior (not just putting the sensor to
> > > standby for configuration, but turning it into sleep mode) and it is =
not
> > > used so far. In consequence, there is no need to cover sleep bit and
> > > measurement with the same mask.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com> =20
> > This is a good bit to have as a precursor patch (as you have done)
> > because it is refactoring the existing code.  It doesn't stand on it's
> > own though given for now there is only one caller, so I won't pick it up
> > until the patch that uses it is ready to go.
> > =20
>=20
> So, I'll leave this patch (in case I might refrase the commit message,
> and I hope this is ok). I'm going to merge [v4 02/11] [v4 05/11] and
> [v4 06/11] for a v5. Let me know if I got this wrong.
>=20
Sounds good to me.

J

