Return-Path: <linux-iio+bounces-10409-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7486998F87
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 20:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DBC1F25E07
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 18:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7081CB33E;
	Thu, 10 Oct 2024 18:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1CkxC8H"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1D41C9EA4
	for <linux-iio@vger.kernel.org>; Thu, 10 Oct 2024 18:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583985; cv=none; b=P4IUYIIrvdLHJPdcrW/wERIxJYDzL5XFqToMZ5GwmDJ8KZFrg1ZyCan7iXp+jNcKrjjzFf2Y8HaiP2YWadnXxUnjIm+MugdahMiTaKy1OB3hgqGLbNNWjziBlSw3sKAZKamzdAkjuQJg92iLMpIbKv7YrkQUL+BI6DTBZfZtOF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583985; c=relaxed/simple;
	bh=kK7ORtn7CCFgTPYFfGDMNziOx7VnEuNtFva4gEqB5lE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iL5igG4GxYhoY4hCbC9oZJ81OChdEcn9iw9dR/CWDXw7S6SBj+cSkXPqmthM4X848vmJkw4OjmSFl/pKNxWw6ZxageJgTo/YwrePyLThV+V34BucpIZvMiKj0hibTmDfCCsFpCujdn7dLNvJTPYldmF91WYsdMavTWV8V48HODw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1CkxC8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAADC4CEC5;
	Thu, 10 Oct 2024 18:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728583985;
	bh=kK7ORtn7CCFgTPYFfGDMNziOx7VnEuNtFva4gEqB5lE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X1CkxC8Hl8r3q7aHQSnal65OQWhi1Q1594A6FTeZZ/eBu0QeCPuuxdk8r49aQTwqp
	 jXyIch0aZEQ4LSeGuuIbHiFfgRazJXidFvSgN+eD6IUW68V1NjqbPOL+Fb+JbhyF4A
	 yLMrOQBY7PnkDv+aolBXemaDeQTtd1T2cEq7Ce3ba47YvmLn68nWOSsjirnpwj50Vi
	 fxM6dryvkJ6klObfeM0bQSVu3J6I1w7TwDEVH7dYEMuSeVJuboBzxRlptOzbBHdNGV
	 367+gseVXPBnxCFDWg7bRPu/In6eEnKsYKr+d/qbKqJjAKYjdxxPF7El9k1+ZjlG3d
	 dBvTwj0MTlMzg==
Date: Thu, 10 Oct 2024 19:12:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 0/4] iio: frequecy: adf4371: minor improvements
Message-ID: <20241010191256.106a5cd4@jic23-huawei>
In-Reply-To: <20241009-dev-adf4371-minor-improv-v1-0-97f4f22ed941@analog.com>
References: <20241009-dev-adf4371-minor-improv-v1-0-97f4f22ed941@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 09 Oct 2024 16:16:42 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> Just some simple and minor cleanups.
All look good to me.

Applied.

>=20
> ---
> Nuno Sa (4):
>       iio: frequency: adf4371: make use of spi_get_device_match_data()
>       iio: frequency: adf4371: drop spi_set_drvdata()
>       iio: frequency: adf4371: drop clkin from struct adf4371_state
>       iio: frequency: adf4371: make use of dev_err_probe()
>=20
>  drivers/iio/frequency/adf4371.c | 63 +++++++++++++++++++++--------------=
------
>  1 file changed, 32 insertions(+), 31 deletions(-)
> ---
> base-commit: 96be67caa0f0420d4128cb67f07bbd7a6f49e03a
> change-id: 20241009-dev-adf4371-minor-improv-e7ee6aea3e6e
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20
>=20


