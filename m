Return-Path: <linux-iio+bounces-18708-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09006A9DBE3
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 17:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D53B07B1DF2
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 15:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC59125D1E0;
	Sat, 26 Apr 2025 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fk4Og1Ex"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B2C25C702;
	Sat, 26 Apr 2025 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745681863; cv=none; b=ZDWg6NjjcUqVBCFFKCwsNdkkfHi3x5ffQm4dtrPrcwEjyOGf8YENrClsUqGcOl2hIbP8KWvDn0p1bvradRgQTDe6SHw2wBxhWFhoxFhKNkV3FZylhhu+qlsG1MJgHEtGKIC1nHIZcLCpEPJA8kZO7ZGx2sjLHGfdpwGthAcSmn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745681863; c=relaxed/simple;
	bh=i5JIoZs/PHo2aOQlsHzQcTiC9tv9QIFC8RJhMOWLwFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GEOmr5P9OcnACnbs3n6Lkj/Oz4JJz+nK7/Z2WWgd9LT9e8aXe86LdUkFtKGzN32H3vlZahZuA/7SbBPwPc0ArvoyAjlCDzbVp6ujXIcjqBPb9dpG5A+Z7cLrdy5azYA0b0G0g71uG3+gMGMbiItGNYfd9PPUwKTymaL/4VA/XqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fk4Og1Ex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D57C4CEE2;
	Sat, 26 Apr 2025 15:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745681863;
	bh=i5JIoZs/PHo2aOQlsHzQcTiC9tv9QIFC8RJhMOWLwFE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fk4Og1ExREylVcuIN3I6Xhma/cAa1scCcu6wKxaLDBhy5DnFentkr6BYfuIFcepAW
	 q4vuepKaE974VhtT5dhpgktGC7saYB9wwrwtgxWLMFCjw9migoqrNnXrSYK3xwqycM
	 Etd327hodCqrBSibBqPBzDbe1vj673LNRofD3Dn7g4CyFO38z689MgR6Aia5IHJIUP
	 EiUP+u8k/UCmubYpeASnGwGNmdVz6Y9YPpkHt/tnm1rmhjSy268neRN+GMx23t9Dyp
	 IcVTgLrb46P/fOMIeietDd3dPQuZS4Ovms58NSGGUheen1Y1WHjD7FyPXFkn+F9N87
	 dU3II37m3cU4A==
Date: Sat, 26 Apr 2025 16:37:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, robh@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: dac: ad7293: add adc reference configuration
Message-ID: <20250426163735.21d0154b@jic23-huawei>
In-Reply-To: <d7e6660e0263f167e881bcb32d8d241450a21a66.camel@gmail.com>
References: <20250422085529.4407-1-antoniu.miclaus@analog.com>
	<20250422085529.4407-2-antoniu.miclaus@analog.com>
	<d7e6660e0263f167e881bcb32d8d241450a21a66.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Apr 2025 12:41:44 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2025-04-22 at 11:55 +0300, Antoniu Miclaus wrote:
> > Add support for configurating the ADC reference (internal/external).
> >=20
> > According to the datasheet, the external reference is enabled by
> > default.
> >=20
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > --- =20
>=20
> LGTM:
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Series applied.

