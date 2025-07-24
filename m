Return-Path: <linux-iio+bounces-21949-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5D7B108B8
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 13:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D223BC2ED
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 11:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41773BBF0;
	Thu, 24 Jul 2025 11:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UV1fN0XX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7D726C397;
	Thu, 24 Jul 2025 11:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753355526; cv=none; b=E1ikWcUDk+dfJhlN+JfgL75BBSbkyQ2PXVbJc4mrDgWvlnSF7IAUp4RGJEHct3gdQarrqeiq7AQEU9kRKKA7DvK10m9OElz291uZB777nsdSy1PiU6dmsWP6Lx83R785NocrCQBpsoRJprbyBaJkQCjXD3aS1Bo8axnyo2rSr6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753355526; c=relaxed/simple;
	bh=HNHkkKC0N4jIHXpNvr7bCdEn66WfCk+E8NxYfBuqcA4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lo3+wTAn3ocrU9aKCg08/3DszH8V3CCI8ECR1w64yqaRDNvnuPPIJRKmGHWxIz+UotgPZURZs2lZHkXaBFv+uh7PzVOPu19CWeaS6Il78A5uX/DsfiZNFponx5aRkB6xZGgHNrw1CCu3adyYYRqF7Krnz0oPKGqi228/37LQgkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UV1fN0XX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8ADC4CEED;
	Thu, 24 Jul 2025 11:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753355526;
	bh=HNHkkKC0N4jIHXpNvr7bCdEn66WfCk+E8NxYfBuqcA4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UV1fN0XXaBxI2D1pkJ82aMeHuGE49OlflDhaM8xIeVxBySrE/KqBb1+sOOzKgpP+5
	 dgc45IcjlxyUH/mb4HXaEEbf2Y3HZiz/eB2PRAuygK925we9XjDa6lNXXp05dQEDxe
	 qjdg42Z1f2aroKU/2tBqAe/AjEWkG3Op7kLXJMA5DiyP7tEeqpv1/Y55yb1VPGqCwc
	 ShtsziosVPz4vE2NEx4lGqEPRWD+UiN0B/USg0AnXP2tSZI8tW+dC+rhWOxik40b0O
	 jHaeLEY+g+Axu2bHEU0Qkou3uYq/KDSMxVwr0VjyO/d1WEbT6W4vC/6RdM4cL/2Ti0
	 G+1ubdqfBjoZg==
Date: Thu, 24 Jul 2025 12:11:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Andreas Klinger
 <ak@it-klinger.de>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: proximity: srf08: use stack allocated scan
 buffer
Message-ID: <20250724121158.05fb8458@jic23-huawei>
In-Reply-To: <xnacdjv6bmp2ghh2wcloetec5okl7vbwbihpzsf2b3u4vqyc3z@dobmhdkiruib>
References: <20250721-iio-use-more-iio_declare_buffer_with_ts-6-v2-1-8b66e5b4e75a@baylibre.com>
	<xnacdjv6bmp2ghh2wcloetec5okl7vbwbihpzsf2b3u4vqyc3z@dobmhdkiruib>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Jul 2025 10:10:38 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, Jul 21, 2025 at 05:21:08PM -0500, David Lechner wrote:
> > Use a stack allocated scan struct in srf08_trigger_handler(). Since the
> > scan buffer isn't used outside of this function and doesn't need to be
> > DMA-safe, it doesn't need to be in struct srf08_data. We can also
> > eliminate an extra local variable for the return value of
> > srf08_read_ranging() by using scan.chan directly.
> >=20
> > Reviewed-by: Andreas Klinger <ak@it-klinger.de>
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> > Changes in v2:
> > - Zero-init the scan struct to avoid leaking uninitialized stack to use=
rspace.
> > - Link to v1: https://lore.kernel.org/r/20250711-iio-use-more-iio_decla=
re_buffer_with_ts-6-v1-1-25c70b990d6c@baylibre.com
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the testing branch of iio.git.

Thanks,

Jonathan

