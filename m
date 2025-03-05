Return-Path: <linux-iio+bounces-16413-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DDDA4FED6
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 13:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D453A5B65
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 12:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCED245039;
	Wed,  5 Mar 2025 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzNidMiZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606E3205AB0
	for <linux-iio@vger.kernel.org>; Wed,  5 Mar 2025 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178397; cv=none; b=lGFr5hNXYMi3vnAhN9Tf0lK8h6DmBYA24YTHnDMFzr+yCoJl9EGe7Lz074wA+LJRidiKV+DhmUkinCd7i6QLx2JvYQ5DctiwBqgb0dl5WO1t0bA69J2uQAAYv3IImNjZol4hvxdBGlK0sc96J8a4tHGKRR85rU8UhK9laZzJ+MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178397; c=relaxed/simple;
	bh=MHYtCw5bNmJ7G947M/zUez3WmHEMaNnczRMchXsTI9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=de17cuEBMTDjGX2xEpsRoE12hws8DXQwvz4ppKOvcOkObe46xYctOAK85al0GuN0x0FG0qcsaQjMF5/sY/CGrNscBkSPL85tEWG1xe9DDdVkutzN4jmOUAKys/gA0Jxkq1MwQEJzPgx4T9iKRXp4jZmw4MaW7P8/ofAdjfFbKjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzNidMiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96110C4CEE2;
	Wed,  5 Mar 2025 12:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741178396;
	bh=MHYtCw5bNmJ7G947M/zUez3WmHEMaNnczRMchXsTI9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HzNidMiZI649rgWbEfqXv19FgJcPmLi+ArLqK65csnBQUHQcSHEGos/q/Su7s+plo
	 8Wl77DHsRHwrEDgpUDTochzh5RQ9/BaEMli7nE1T0f34EkMoGYScmDFBBdTveTZ01H
	 /bC09tCHbRJsF83BZ1bxikhYOvB2zvjWp5pJHy6Zr3MRNezDQRTDcg3KOQtSmS09Cw
	 ZDKjdigAWflI2AgxYivjdzPWagqAVgVjPPWMSK8eqonPGNuWEvZHEUO6QwoysNtWiz
	 mUFZWNTltd43776kKIj4S2pFhFIwlEOW+LwM6NZ8XEzAy1cGAKXZD/k9rWMFW20IIx
	 fRpIY/q7ulVpg==
Date: Wed, 5 Mar 2025 12:39:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Guillaume Ranquet <granquet@baylibre.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>, Mircea Caprioru
 <mircea.caprioru@analog.com>, linux-iio@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>
Subject: Re: [PATCH 0/2] iio: adc: ad71{73,92}: Grab direct mode for
 calibration
Message-ID: <20250305123944.48b304a5@jic23-huawei>
In-Reply-To: <cover.1740655250.git.u.kleine-koenig@baylibre.com>
References: <cover.1740655250.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Feb 2025 12:35:26 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello,
>=20
> in a patch series I sent last week
> (https://lore.kernel.org/linux-iio/cover.1739902968.git.u.kleine-koenig@b=
aylibre.com)
> a review comment by David suggested to claim direct mode for
> calibration and he also pointed out that this is missing from a few
> other drivers.
>=20
> These drivers are fixed here.
I've applied these to the togreg branch of iio.git an pushed out as testing
but please consider if these are suitable for a backport once this
version lands upstream.  The change in handling of claiming direct
mode will require manual backport.

Thanks,

Jonathan

>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=C3=B6nig (2):
>   iio: adc: ad7173: Grab direct mode for calibration
>   iio: adc: ad7192: Grab direct mode for calibration
>=20
>  drivers/iio/adc/ad7173.c | 5 +++++
>  drivers/iio/adc/ad7192.c | 5 +++++
>  2 files changed, 10 insertions(+)
>=20
>=20
> base-commit: 66e80e2f21762bdaa56a4d63c79e5aca5f6bd93c
> prerequisite-patch-id: afd7caae7616d474e5a1a68e963828a88fa9cd3b
> prerequisite-patch-id: f5900fd31dc701cf190c7b451e0917e5b659f03b
> prerequisite-patch-id: 3c1b44d4645eee7668f543f0e9148c52337e1cd9
> prerequisite-patch-id: 9f600afd72914d22298067f86c1298d18cb335cd
> prerequisite-patch-id: 16607d29f72b649d63790b9c4c0852c089d27a1f
> prerequisite-patch-id: edc1a70e612a16ff5a72b05741beb02f874c7d1b
> prerequisite-patch-id: 4370980539a471328b354e94529da4dfe915b573
> prerequisite-patch-id: 0bdad93ca4dd031c335799abdbf6c93e36f27dcc
> prerequisite-patch-id: 4aa927f0072026df1ad9627a82f73b45250ad950
> prerequisite-patch-id: 027c26bf1a9c762ebb9828682a61537051835cc4


