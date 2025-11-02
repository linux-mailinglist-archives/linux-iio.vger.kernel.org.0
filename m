Return-Path: <linux-iio+bounces-25802-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE897C28EDB
	for <lists+linux-iio@lfdr.de>; Sun, 02 Nov 2025 13:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859FE1891110
	for <lists+linux-iio@lfdr.de>; Sun,  2 Nov 2025 11:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13A52D9498;
	Sun,  2 Nov 2025 11:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dr6LVaKj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7332D8768;
	Sun,  2 Nov 2025 11:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762084602; cv=none; b=e4fCYls5OfMQPxUN0ZEoOVOtbm9ipXbd5VHYd/e0CR+HFoUyAggp7kKG1DDnR03BYs+pqTxAFbNqmyxfqWgFwiYwXPhCVbgXFS38Mpn07Eez1LPEhnjedeQIBQJ+RJW4Q6m5dXCeqUMn7FnQNQMoimnLr8AyIg+2/14mrZdLuPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762084602; c=relaxed/simple;
	bh=+wmiDFhFXA2YVu1X1MKHj4l8bg7wnF06/ff6trOOXvY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dPsO4tdc8WATArBkI78pUJNCZmHpVLfFRPYvtS4w1WC0rPh6bEpBieiVyPM+j5GoIVPxwex8j1s4f4VRiMO4OKeOEsdrfUO6NSXztS4bz2kdFo3HJEQ/8FLNESodD2LnRHtVpxubwHMVdz+8VaUkJ5GgWGPoq6tLGSWAsnV8bb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dr6LVaKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F46C4CEF7;
	Sun,  2 Nov 2025 11:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762084602;
	bh=+wmiDFhFXA2YVu1X1MKHj4l8bg7wnF06/ff6trOOXvY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dr6LVaKjZB/ITtxmvRF2giUHPuzbwNr2b5p5FV3DbM5he2aVFVRD6w+Cr4/lXijdW
	 xogsZ6qvaMkLiwh0MmJPBdC5i5wT7/D674Q/FYywH8tD1VXsGXf2qa/a6nd6potZAh
	 CFlnqnKGHmstwYqzHCDQ/u7kyvpQNB/kCBd6pp/cIs5ErunK0LWg0ibfEuZI24dFEf
	 RDVo0YLyzwcFVzpOhESNAETj1q9DXI7GlcHWjoucbpAXBHM56r21CrBB6hOazisApu
	 Lb64vKSHR9gbwHlD7kmvzG3k98RprlmAIXcbXQ/j3PoNO75nWsTh9QNUyo4lrGyxTx
	 ig7oIN0FA4Yzw==
Date: Sun, 2 Nov 2025 11:56:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kriish Sharma <kriish.sharma2006@gmail.com>, nuno.sa@analog.com,
 olivier.moysan@foss.st.com, dlechner@baylibre.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test robot
 <lkp@intel.com>
Subject: Re: [PATCH v3] iio: backend: fix kernel-doc to avoid warnings and
 ensure consistency
Message-ID: <20251102115636.38a25092@jic23-huawei>
In-Reply-To: <aQCW9LqtwA7WE-DI@smile.fi.intel.com>
References: <20251028093326.1087660-1-kriish.sharma2006@gmail.com>
	<aQCW9LqtwA7WE-DI@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Oct 2025 12:12:04 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Oct 28, 2025 at 09:33:26AM +0000, Kriish Sharma wrote:
> > Fix multiple kernel-doc warnings and make the documentation style
> > consistent in drivers/iio/industrialio-backend.c.
> >=20
> > Changes include:
> >  - Add missing @chan parameter description in
> >    iio_backend_oversampling_ratio_set().
> >  - Add missing RETURNS section in iio_backend_get_priv().
> >  - Replace Return: with =E2=80=9CRETURNS:=E2=80=9D across the file for =
consistency. =20
>=20
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>=20
Applied.

Thanks,

Jonathan

