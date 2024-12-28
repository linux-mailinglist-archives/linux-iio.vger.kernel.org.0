Return-Path: <linux-iio+bounces-13835-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEB09FDAD9
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 15:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4359618831FD
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 14:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1258D15B13D;
	Sat, 28 Dec 2024 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neKmbm+Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA94D3596F;
	Sat, 28 Dec 2024 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735394834; cv=none; b=VI6uC/7Nh7su8MaHdBoooK6dSgrV+LBAE/74BjEjp9mSoIr2b2I2AYpY1ELIT+f5Mi+6AsRVckeofOEVF3++APRQeOXlij9P9nIxH1FSxKqteWEwAY9/nJB6BDzcmvCoDhqgS1OqDXTW0SNFquw/D/MGTokGdyfVimm8Mo+ZbQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735394834; c=relaxed/simple;
	bh=+OyRhcMCTsP0U8oc1KWDKGk6tnVWjmWBGtAfuCCoH/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEys9ISKKWgqFnXV6RwPkButq/KCkZyd18mRTxdv6j8Y6L4C8wpyCYLKcgAlsJOJ8KMVT9Kxcwtpuf5keGHuj5xSXmcvmgOY3pPdriDOmkniyizZR3NbORwYo7QNfAL61afu6E4zHCT1lkwDrf75+sVPzF00lBzxMnUwneIlj6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neKmbm+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF36C4CECD;
	Sat, 28 Dec 2024 14:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735394834;
	bh=+OyRhcMCTsP0U8oc1KWDKGk6tnVWjmWBGtAfuCCoH/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=neKmbm+QV7RQxDkJN/B+iOz9nKNJHIzYujBHhdc5cVKNipALVDgnL0PTsblhf1GZa
	 OBT1IPAuedFLsy1n6+eyooigwa1IBX/NHO0wQZSn6clEhgkgenh3qZnlc/7TpakBCM
	 M27G2aQcthIzXgZBMBD3JEXNJpF1XXr/1yvOQDUlkYRM4vUOyxn4WjmWa5Fka6UAVw
	 eZxP7ujd2F2TweA3UEF+Cro7dePI8uPD6CJL5SqurxdQjopsZffuqljhIR99InXgoL
	 QWnxIdeOhF2BdEGQsad4OYLqCB4W0BtloLppLCIjdbhsl4Mpn/SAB6k+lZtNNEFg0P
	 v474K24ZRNOFw==
Date: Sat, 28 Dec 2024 14:07:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/4] iio: adc: ad7380: enable regmap cache
Message-ID: <20241228140704.7115fb23@jic23-huawei>
In-Reply-To: <zkur45la23hyqmqusjdfyzgsofhfli3n54be55dkdrwtxf5g7e@fdpdeliljyz3>
References: <20241224-ad7380-add-alert-support-v2-0-7c89b2bf7cb3@baylibre.com>
	<20241224-ad7380-add-alert-support-v2-2-7c89b2bf7cb3@baylibre.com>
	<zkur45la23hyqmqusjdfyzgsofhfli3n54be55dkdrwtxf5g7e@fdpdeliljyz3>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Dec 2024 09:48:35 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> On Tue, Dec 24, 2024 at 10:34:31AM +0100, Julien Stephan wrote:
> > Enable regmap cache, to avoid useless access on spi bus.
> > Don't store anymore the oversampling ratio in private data structure. =
=20
>=20
> I would split that.=20

Splitting it probably makes sense, though the regcache enabling patch will =
be small
(which is fine).

> There are a few changes in this patch that I don't
> understand, e.g. why does the return type of ad7380_update_xfers()
> change?

On first call of this, the register contents may not be in the cache
so you might get an error from the bus read. Even if we known it is in the =
cache
(and from a quick glance I'm not sure we do as we haven't forced a full
fill of the regcache or accessed this register) from a local code point of =
view
it is correct to handle the potential error and pass it to higher layers.

Jonathan


>=20
> Best regards
> Uwe


