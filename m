Return-Path: <linux-iio+bounces-13832-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3299FDAC8
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 14:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E331C7A1576
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 13:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88C4158A09;
	Sat, 28 Dec 2024 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMCRK7N2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDC7382;
	Sat, 28 Dec 2024 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735393906; cv=none; b=KuKZHD/XkLXWbt/DkZr7ZG2xGwqavYw6M06f2RqoQ1pi6HxogvyJmpqi+NEyxClh/rhLqxAazwv2+2/EPdS1m2Ys32WgJgwkDz7lpdfBG5Ogq5of/EYY7vNxxU4x58aOzvb5Acg/mMA/OPCFOghD1Hs+F2HGP+dMRHUe1rdEtOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735393906; c=relaxed/simple;
	bh=6OmLBLtXUjDa3PihmN/DIKqEkVwYRM14m4vHFNjYv8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkO6GZwLUNvYelZWogC9Gv//84kg5GGBc3x4BXQUkXSjczrXQ3j0EV9CKjgldQEVJ/PleHW0VI8UWdUTbSJhvDRU5ytpkO9/U5Caa5sy4/MZcteC9epI5jMlgmsUcSr+7HxuOHD6+V0FNYtt0ifz63jmrXqJSf21CPMpR2827Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMCRK7N2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627E5C4CECD;
	Sat, 28 Dec 2024 13:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735393906;
	bh=6OmLBLtXUjDa3PihmN/DIKqEkVwYRM14m4vHFNjYv8k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CMCRK7N28Se4nhog+ZIOoEcfhwCmSW/u55GqfsWm+OEcPLPdTVRxt17AGssz1SgU3
	 0zCxID/SMzT5FlFHfqTmzgFQJLYh0iu1u5h9GpV0XUvLHtra83kteS1WEUTjIvZf//
	 W9gHtRef3rMU7gbWOV/jmXKGWWm9CL0pYDmueaUHfE3yTBdeRFbtER4nv6k8c77m9X
	 558XwFEaKtV7pCA3gpckhRFLbmxO0cFLX8sSOi0yWxN/AT3Reji7YK8bd+j54db9nd
	 5VTV9iy2lugADxcaBgSJtGoui8d98//6BYdGXrUxTC7nkHRbTeZOIh5Hsnd05HxEnu
	 NCDS6bCtOSRTA==
Date: Sat, 28 Dec 2024 13:51:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/4] iio: adc: ad7380: do not use
 iio_device_claim_direct_scoped anymore
Message-ID: <20241228135136.0303ddb1@jic23-huawei>
In-Reply-To: <befxu7wle3sq5egcwqhxx3qkvnye6cru4shufngyqvp6uyurkh@6d62xfzzuqss>
References: <20241224-ad7380-add-alert-support-v2-0-7c89b2bf7cb3@baylibre.com>
	<20241224-ad7380-add-alert-support-v2-1-7c89b2bf7cb3@baylibre.com>
	<befxu7wle3sq5egcwqhxx3qkvnye6cru4shufngyqvp6uyurkh@6d62xfzzuqss>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Dec 2024 09:43:31 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello Julien,
>=20
> On Tue, Dec 24, 2024 at 10:34:30AM +0100, Julien Stephan wrote:
> > Rollback and remove the scoped version of iio_dvice_claim_direct_mode. =
=20
>=20
> Is this a preparation for one of the later patches in this series?
> Mentioning the reasoning for this change in the commit log would be
> good.
>=20
> Best regards
> Uwe

I'd guess this is in response to a comment I made recently.
The conditional scoped handlers are turning out to be a real pain so
my plan is to rip them out entirely.

There are readability problems, compiler and linker handling issues
and a mess of other reasons these are much harder to use than they
originally seemed.

I've still very keen on the rest of the cleanup.h stuff, just not this
corner!

Jonathan

