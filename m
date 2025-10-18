Return-Path: <linux-iio+bounces-25258-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA08BEDA1D
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 21:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B171419C2C57
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 19:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FEF28D8DF;
	Sat, 18 Oct 2025 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxbAsI5k"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E827A28B7EA;
	Sat, 18 Oct 2025 19:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760815387; cv=none; b=JFOjydrRZW4qrMS9217ryxSgsAe/jOslgaMsDwbcCXbVKS+GoLLNrt2A1taUtiro0zcCjaDQK3npe+BmNojkjmSv/awMjetmsj1XQohghx51GhnAfpLN21jFgjqtJlYXgtRw6UZfkvRsOibH+2vZqkdCFnVR8fxzH37L1U/6xJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760815387; c=relaxed/simple;
	bh=G527dw1m66MJz6fBeaP4BUpuixzJbfu3vAmnIWlkGpw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JOs+YGvVCmtRO1qAU/kF8GK0dSi1lYFpHZ45Q5795+ZCl4lGmC4hd8h18vvjXaNNpjW7MiFpsDtKo8bibdUKRm/v4dp6Qm9zR21NdJSQI5VFet/dEOvI960u84mnRIVRGNhs52wMNWgB2AnAcyYtRwCLcnwMWExDh2lbEGZIT3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxbAsI5k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC423C116B1;
	Sat, 18 Oct 2025 19:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760815386;
	bh=G527dw1m66MJz6fBeaP4BUpuixzJbfu3vAmnIWlkGpw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jxbAsI5kstGoKKLkKoSDIk+ax5Vt54jAJWR3A6wp1itxmOXsmOInPs8TMYZCNhZDS
	 YukThIrJoViSS3IFD3PT2pi+k1oI9Jmwd7R666OgEOOx2sxk3+fHhNy7KwOWm2Nyav
	 tF0gizEqClIw3WX0Gx3u+mrpimHfoyKQ0DcFbvlFdgl7NIxRN9K1Z/OV89l/7NSLiY
	 xEXvJoVekGKVXdvgvJmcl1BVjKGLwS5gFUnOgOcVOhG0kIlNnx4oatmpxeLQWsQddB
	 hvdgVSJuEKu50zgbIe3Fc6ETMAS4ivDPZWX+H2ZAabRa0blRyJyiJ2bsAdbxnNlGnN
	 5iyA1n8mxOgtg==
Date: Sat, 18 Oct 2025 20:23:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Mario Tesi <martepisa@gmail.com>, linux-iio@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: st_lsm6dsx: Fixed calibrated timestamp calculation
Message-ID: <20251018202301.2680cc79@jic23-huawei>
In-Reply-To: <aO_e2DEGsO-kJQFx@lore-desk>
References: <20251015161619.GA87736@ctocxl9700.cto.st.com>
	<aO_e2DEGsO-kJQFx@lore-desk>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Oct 2025 19:50:16 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > The calibrated timestamp is calculated from the nominal value using the
> > formula:
> >   ts_gain[ns] =E2=89=88 ts_sensitivity - (ts_trim_coeff * val) / 1000.
> >=20
> > The values of ts_sensitivity and ts_trim_coeff are not the same for all
> > devices, so it is necessary to differentiate them based on the part nam=
e.
> > For the correct values please consult the relevant AN.
> >=20
> > Signed-off-by: Mario Tesi <mario.tesi@st.com> =20
>=20
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

Fixes tag?  Just reply to this thread with one and I'll pick it up from her=
e.
No need for a new version.

Otherwise seems fine to me.

Thanks,

Jonathan


