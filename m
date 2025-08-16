Return-Path: <linux-iio+bounces-22836-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C2BB28EAB
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 16:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B925C5D32
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 14:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E8A2ECEBD;
	Sat, 16 Aug 2025 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqOaKMik"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6473528C873
	for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755356136; cv=none; b=Ol95hWkdp7zP1RMUCgFbCW1HANiNjCpce5nFN6Ob87Exa51xMB5cfWX2qx8sFeMqEWBlYr3Laauf3ser0Bp8jpjFUC/u3tnRGsn2DNha7+sIBaiRtAaRvZ7Um1fHNF1z3jX9qTcbMW6wss0Wq1MHgbaw6mHWN1AEa+8jek2WbTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755356136; c=relaxed/simple;
	bh=XiRI1uHKiqiIFIf4m/6h5aUhHmkFjyR1uzTC6W5zxR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhUulJrCVwUq5eCqWbFaqY3P2stsxVM1s7d9oyhioHuBaH9EY5GU5/nvFCNzlftVHwVtpEbeHH9plfMZwfwqdhxaKjXCXxOFkteU3E8VKdInSnKfp//zC8AHSNK9FUStY/sscIgnEXBa1GQ7B62cDDO0A5LtBg5aCZMjzIHclrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqOaKMik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7611C4CEEF;
	Sat, 16 Aug 2025 14:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755356134;
	bh=XiRI1uHKiqiIFIf4m/6h5aUhHmkFjyR1uzTC6W5zxR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WqOaKMikrkMiBBlpY/Ojj81aXiXkS9W7HkwpTrH5TKpjRTYhrmAHreNKF7AppHdJR
	 B2YcvK5p/s7OYZ5n/tE2DzHhBEwjLc6LUtwlIn/lLJvMk97XNUWQnQGnk01pPvZ1+M
	 WUR0G481IyTDnaoknAn47DvoHZj9asN6r1hH2+CXboMsUZzjBYceuY8vppOgt5Ovw+
	 eucaQcxsKPU0MlNp1jp1E4dV3vg2m3O4TKi9leQojkOJF9Uq3vLK5zcc2+amjnEDHf
	 Hq6pZ13SOOH7qcXPBQOfs8dOHBBP1Pa5mnvGL4v5IBCf6NwNDuqsapR+NbFQOJLOvS
	 waLsxSuxShRJg==
Date: Sat, 16 Aug 2025 15:55:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Mudit Sharma <muditsharma.info@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Abhash Jha <abhashkumarjha123@gmail.com>,
 Astrid Rost <astrid.rost@axis.com>, =?UTF-8?B?TcOlcnRlbg==?= Lindahl
 <marten.lindahl@axis.com>, Gwendal Grignou <gwendal@chromium.org>,
 Christian Eggers <ChristianEggersceggers@arri.de>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 10/16] iio: light: max44000: Use
 iio_push_to_buffers_with_ts() to allow source size runtime check
Message-ID: <20250816155523.40e2173c@jic23-huawei>
In-Reply-To: <CAHp75VeBhA=Vn2cxxZXJV+p3yg_5_4z-V2XUiFnneNvEz2+uvg@mail.gmail.com>
References: <20250802164436.515988-1-jic23@kernel.org>
	<20250802164436.515988-11-jic23@kernel.org>
	<CAHp75VeBhA=Vn2cxxZXJV+p3yg_5_4z-V2XUiFnneNvEz2+uvg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 3 Aug 2025 21:26:57 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Aug 2, 2025 at 6:46=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>=20
>=20
> The below (here and in the other patches) reads incomplete. Yes, I
> understand that the first sentence is in the Subject, but to me
> repeating it here makes things clearer.
Tweaked whilst applying.  Thanks,

>=20
> > Also move the structure used as the source to the stack as it is only 16
> > bytes and not the target of an DMA or similar. =20
>=20


