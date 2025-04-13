Return-Path: <linux-iio+bounces-18038-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01245A87161
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 11:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC9D3AA150
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 09:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A3819D081;
	Sun, 13 Apr 2025 09:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQqu4d4T"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48DA3D984;
	Sun, 13 Apr 2025 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744537198; cv=none; b=WMOTiOmtbpWF2iIpo9mRYT3ZLttrQ+IkImvJpTmym1puFVP7WGwRZT+GVX2mZjg0i4LbGYS1hHZ2QGy1bJdMchRuN/cLLTUBUyTnHSeQCgPbSq+Vl10np8KsNbr5yNrI3wsLUoQ9n57qyeSIcACx2zOZFmHO9sMyLCul4QKAILI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744537198; c=relaxed/simple;
	bh=Qh/O5y6g29/fRs1ez9w4wvfRPf5k+MuGmf2/rohGy2o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3K7mVoqo687fjJ5YnViK+TJmkV5h0xBF27di13qPHOfkuAu1E6+DtOOt4U0rqhiIK6/o09fAvTZ2OT9FiPinYw726Woo4HT9wWA08fEXxUtODO26cInDskISpvKeLNUBdBMUptoSFLHcgQnTXNA25gTSTAEvtMWwdIr7rZpcF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQqu4d4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6960CC4CEE7;
	Sun, 13 Apr 2025 09:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744537198;
	bh=Qh/O5y6g29/fRs1ez9w4wvfRPf5k+MuGmf2/rohGy2o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bQqu4d4TJO1j9/2y6ESz6zelgODFa03jqhQucHM1Lw0TKUKq5VYe6M98LNvzopOX4
	 8lbR2BNA32zt31YORtlq3cJ1oy/4FQgb5z7nDp5qVwGaKJkXjLqxEGnO/tMaSq0Y8F
	 Vto7gmFiq+MSMu0lw0/F0TDX5OlbcNt1BZRNoowiG3szCtDFlHlMy4GI78cHYF6oin
	 S3+lfb2Rr29XS0xnuutY3YJFuGTULTNqKEZNMHvCm0cf/kjEV00NjGUXbtmXk6A9B+
	 axfig8+N6NBahmGJSqOfo/FlL1HIvBjRvYa51c1KeSVSaqJrUApilbyfl3vBtn0BOa
	 IO4D1K0Ydn9RQ==
Date: Sun, 13 Apr 2025 10:39:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev
Subject: Re: [PATCH] iio: normalize array sentinel style
Message-ID: <20250413103950.23c20bd3@jic23-huawei>
In-Reply-To: <CAHp75VcdpPC2faWNMupXL-RaEM3QsSYEyfSC+A7KEsmD24U=+Q@mail.gmail.com>
References: <20250411-iio-sentinel-normalization-v1-1-d293de3e3d93@baylibre.com>
	<CAHp75VcdpPC2faWNMupXL-RaEM3QsSYEyfSC+A7KEsmD24U=+Q@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 12 Apr 2025 15:55:35 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Apr 11, 2025 at 11:50=E2=80=AFPM David Lechner <dlechner@baylibre=
.com> wrote:
> >
> > Use `\t(\{ ?\},|\{\}|\{\s*/\*.*\*/\s*\},?)$` regex to find and replace
> > the array sentinel in all IIO drivers to the same style.
> >
> > For some time, we've been trying to consistently use `{ }` (no trailing
> > comma, no comment, one space between braces) for array sentinels in the
> > IIO subsystem. Still nearly 50% of existing code uses a different style.
> > To save reviewers from having to request this trivial change as
> > frequently, let's normalize the style in all existing IIO drivers.
> > At least when code is copy/pasted to new drivers, the style will be
> > consistent. =20
>=20
> With or without iiner space, but same style. What is important is that
> you removed the trailing commas.
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>=20
Agreed. The space thing was a random choice, but consistency is good
and comma part matters more. =20

Applied.  One case had already gone away in my tree and there was a little
fuzz but should all be fine.

Thanks,

Jonathan



