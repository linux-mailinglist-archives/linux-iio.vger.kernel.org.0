Return-Path: <linux-iio+bounces-26093-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D09D1C44261
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 17:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 831FA4E35A2
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 16:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7BE303A2F;
	Sun,  9 Nov 2025 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOg0u6kk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773952FFF94;
	Sun,  9 Nov 2025 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762705939; cv=none; b=hBRKwOsDLuakOyKw8BI9X5Qd2MeVAYzZGzLmWeFhFJ4OtZ/6FxyzJlntnn1ixu5VcPuE8/BHM8/xggZ2lp5G3O32YBEz/LCTqvPKXi4HQM70DAqe/9/rclApmmcY13jRzQlmhb/KzucFWcnIcHjgm0gONcRoGZ7O5HUagMgsh7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762705939; c=relaxed/simple;
	bh=5jvgjzAEUAWot7Q0YEze1pVeAmU7K9/YzCv8ShgeigA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+8OMcMSmbs16i8Tbkl7uA/udObacMPdNzEHN9pfJgKbceVV8qnBKHcvWmMAcL4MQXclbfmbMM8CVIOUwmbmZ1p9/QT0KczxhEF6tUL06vyYojccighYjToOvavPNOkN5JNg5OONPzGafahkpHZ8FxctDJc5QfDS7XPsCtcbx+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOg0u6kk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF81C4CEF7;
	Sun,  9 Nov 2025 16:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762705939;
	bh=5jvgjzAEUAWot7Q0YEze1pVeAmU7K9/YzCv8ShgeigA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gOg0u6kk7eG0ZxtLkTmSjPW2NmDr1ZXDjFI6MjaMnLPdJAWIUPUYWsIP2MG82ETxW
	 fF/QPMKkzJVs7I024ar6VsbJmzXpcTyHzSJ9knolsA5Hpx1IKcRuPWK/c+Rf0MLJPQ
	 cW8eEjg26pkAdLax5k94o7/2nLr1fXIay5YaEoGQvSCRTRw7QncWQ1maa6bUkI6U7M
	 Z4C5GWJUcL3RTXPmOQMXqVP3vs/sdfMXH8n2zXNONWD07rD67OZyAiFPdh3Mrx9aMJ
	 bIK+VEpmOKqOmYDw4EuSHZr33gLoaQ7/9fzmgfkjVZHHGyyRPUyagf4YnEfMk0BAXM
	 enyhdZSpXDPAQ==
Date: Sun, 9 Nov 2025 16:32:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 11/12] iio: dac: ad5446: Fix coding style issues
Message-ID: <20251109163212.29a9bf19@jic23-huawei>
In-Reply-To: <aQpFSNGqf7wrUmYX@smile.fi.intel.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
	<20251104-dev-add-ad5542-v4-11-6fe35458bf8c@analog.com>
	<aQpFSNGqf7wrUmYX@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Nov 2025 20:26:16 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Nov 04, 2025 at 03:35:16PM +0000, Nuno S=C3=A1 via B4 Relay wrote:
>=20
> > Fix style issues as reported by checkpatch. =20
>=20
> Can we do this before splitting the driver?
> This sounds to me like a change towards the fix, however quite minor, but=
 still
> better to move it closer to the beginning of the series.
>=20

If it was more than whitespace tweaks I'd agree with you.  For this I'm not
caring enough to insist on it.  + too many threads flying around so I want
to merge some :)

Applied.

