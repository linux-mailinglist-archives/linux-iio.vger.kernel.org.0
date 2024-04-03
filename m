Return-Path: <linux-iio+bounces-4023-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE67896E27
	for <lists+linux-iio@lfdr.de>; Wed,  3 Apr 2024 13:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5861F22035
	for <lists+linux-iio@lfdr.de>; Wed,  3 Apr 2024 11:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2565E143891;
	Wed,  3 Apr 2024 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewnkyJC8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D59143874;
	Wed,  3 Apr 2024 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712143434; cv=none; b=rg4TjAQ/Jy7oGYIu2l3vDbaqzrN/Dude3t3J4z0GbpStORzuY+6J6OfWy/UgAnWllGzdidkmAd5yTl1Qw+LBpIEVwSPu89zLy+upiV9MiMR9K584FmjtrfLZfeNksRmTR8u2TwiWIiLhtvMUD8L5tTVVlH/hFbV26JaLO9SkW1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712143434; c=relaxed/simple;
	bh=Yt+RnJL5y2H1KaDSc7YxFYnA7Ph19WWyILBFYqaUHNc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jI21Zy2woAJ9BtXLk6filVKCOyZOmsQ4CkRba0KEeJlB6um2kAoN80vQmcBhkCUHiXHcf99dePu1O1YKf7oNSV2BbaTLYWJTcOW89GvBjqPceeDqt0LdNkR6t9PpT3wmdY97dAIdDk1tRovl0DrhRL1HdLLBLvWcHgj3H38wbFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewnkyJC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AAFC433C7;
	Wed,  3 Apr 2024 11:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712143434;
	bh=Yt+RnJL5y2H1KaDSc7YxFYnA7Ph19WWyILBFYqaUHNc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ewnkyJC8bgU9TxBx9xgqRlGoOnpOgddAFGG/voiONHNz7l0/Xm4S34qm4x4CQsps7
	 LBIwwUaWdgI3OJmVio8mvhSirQK9dGb+a3BjyK2VtFbf0MIFH/UYqaDbsCy/A9BRZ7
	 0cLSaiH9F+AqOrS4eTz7bT4oMXnCJABOwjzJ+E04diD7WELFJ30vEQjcAh0a8CVTWs
	 Air3JwHHcILxoVt9opHdrdnE+8PLUN1MfteHAw52KEW52epgsBeqrVKfPUdrnyJ2mk
	 CCgq4huu8/t31NvMy7ud9Sg3U3blUPLM261SwpRtejBMZumJIgs7bE0Z6DYi8e8Q2W
	 Ua6nwu38X9Iiw==
Date: Wed, 3 Apr 2024 13:23:51 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
    linux-input@vger.kernel.org, kernel@pengutronix.de, 
    Jonathan Cameron <jic23@kernel.org>, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    linux-iio@vger.kernel.org, Maximilian Luz <luzmaximilian@gmail.com>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 0/3] HID: Convert to platform remove callback returning
 void
In-Reply-To: <cover.1709747164.git.u.kleine-koenig@pengutronix.de>
Message-ID: <nycvar.YFH.7.76.2404031323430.20263@cbobk.fhfr.pm>
References: <cover.1709747164.git.u.kleine-koenig@pengutronix.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 6 Mar 2024, Uwe Kleine-K=C3=B6nig wrote:

> Hello,
>=20
> this series converts all platform drivers below drivers/hid to use
> struct platform_driver::remove_new(). See commit 5c5a7680e67b
> ("platform: Provide a remove callback that returns no value") for an
> extended explanation and the eventual goal.
>=20
> All conversations are trivial, because their .remove() callbacks
> returned zero unconditionally.
>=20
> There are no interdependencies between these patches, so they could be
> picked up individually. But I'd hope that they get picked up all
> together.

Applied, thanks.

--=20
Jiri Kosina
SUSE Labs


