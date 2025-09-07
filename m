Return-Path: <linux-iio+bounces-23868-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEB2B47B9E
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 15:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D11166659
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 13:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F9F1C28E;
	Sun,  7 Sep 2025 13:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOUqygOo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5662147C9B;
	Sun,  7 Sep 2025 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757251888; cv=none; b=Y78PTX1Xe98grWTFsltfppLH6i0K3857TfwXAMe4tFefctXfmaw+uM1cxyUaGQCpsORY8UBf1SWEvwYtE38LGwBuVfayLZZWJHfINr9rF3LnkZk/sorYHA/YYidxX8jIy7N8pcurFy7L52iLrcIDL1Wjut/LB61+56OHrR8yimk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757251888; c=relaxed/simple;
	bh=pwO9wuGJs0EMkf7G9HGeMZB63Pi28XD1ZOIvmKiHt8w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bba71UJaz+T4rsQSH/c0ktbMHK7wZDmxDO7M6yShX6aLwAFGuz7CgKupI0CM3Fa/y7lM8dmHty+sUKSolDWLaIrOm9K7kSj5h+qo+k2pf8KEMvy/UbLE4voKwWsf//JlvObMRPJcU8ReIeKqTBovD4vMAakz/AI4fV2dz1ZxAY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOUqygOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2D5C4CEF0;
	Sun,  7 Sep 2025 13:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757251888;
	bh=pwO9wuGJs0EMkf7G9HGeMZB63Pi28XD1ZOIvmKiHt8w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qOUqygOoGfkVJVGnzrPxXMYYgcqjQFYLNI57jD/8sU6Busze1F2bAxXOm5ceB0Wym
	 NmP0VINbvGo+o5qQilG3MRSiXotP+DiNMLZJJoVSJI2HWEd/V+4CEjkqzIxH+sk62m
	 owIlIVHJucGokpdtQzthcRuXYvLjqG2nXFRw8HO3qt2byC71Qsir8SOb5XONg02aQv
	 DP0Y+j+ucXn7FiDpNUWeamUfvWViw1bY66kgsLBtZSctFLzzwUe+B+lIlx65YoqHIZ
	 IN0JyFo39lyaG5R6aKpXOwhctI+jMxdb8JP/fws4DQ1gmy4Vuh1d9d0mzvnMgcKUWa
	 x/yDI5inrze2A==
Date: Sun, 7 Sep 2025 14:31:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson <Remi.Buisson@tdk.com>
Cc: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 2/9] iio: imu: inv_icm45600: add new inv_icm45600
 driver
Message-ID: <20250907143118.42612bd3@jic23-huawei>
In-Reply-To: <FR2PPF4571F02BCED3AAC4DB4C6AB0D6FAD8C00A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250820-add_newport_driver-v5-0-2fc9f13dddee@tdk.com>
	<20250820-add_newport_driver-v5-2-2fc9f13dddee@tdk.com>
	<20250825113445.005f815b@jic23-huawei>
	<FR2PPF4571F02BCED3AAC4DB4C6AB0D6FAD8C00A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Sep 2025 13:04:37 +0000
Remi Buisson <Remi.Buisson@tdk.com> wrote:

> >
> >
> >From: Jonathan Cameron <jic23@kernel.org>=20
> >Sent: Monday, August 25, 2025 12:35 PM
> >To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
> >Cc: Remi Buisson <Remi.Buisson@tdk.com>; David Lechner <dlechner@baylibr=
e.com>; Nuno S=C3=A1 <nuno.sa@analog.com>; Andy Shevchenko <andy@kernel.org=
>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;=
 Conor Dooley <conor+dt@kernel.org>; linux-kernel@vger.kernel.org; linux-ii=
o@vger.kernel.org; devicetree@vger.kernel.org
> >Subject: Re: [PATCH v5 2/9] iio: imu: inv_icm45600: add new inv_icm45600=
 driver
> >
> >On Wed, 20 Aug 2025 14:24:20 +0000
> >Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org> wrot=
e:
> > =20
> >> From: Remi Buisson <remi.buisson@tdk.com>
> >>=20
> >> Core component of a new driver for InvenSense ICM-45600 devices.
> >> It includes registers definition, main probe/setup, and device
> >> utility functions.
> >>=20
> >> ICM-456xx devices are latest generation of 6-axis IMU,
> >> gyroscope+accelerometer and temperature sensor. This device
> >> includes a 8K FIFO, supports I2C/I3C/SPI, and provides
> >> intelligent motion features like pedometer, tilt detection,
> >> and tap detection.
> >>=20
> >> Signed-off-by: Remi Buisson <remi.buisson@tdk.com> =20
> >Hi Remi,
> >
> >A few additional comments from me.  I tried to avoid duplicating
> >anything Andy pointed out, but might have done so a few times.
> >
> >Main comment in here is to take a look at the inline comments
> >and perhaps simplify or remove them if the code that follows
> >is basically self documenting.  Sometimes the comment can be
> >more confusing than the code!
> >
> >Jonathan
> > =20
> Warm thanks for the time you spent reviewing comments.
> I tried to clean them following your advices.
> I hope it will improve.

One process comment.  If you agree with a review comment and there
is nothing else to add, just crop it out of your reply.

Focus on the places where more discussion is needed.
If there is none of that don't reply to the review - just add the
changes made to the changelog for the next version of the series.

Jonathan



