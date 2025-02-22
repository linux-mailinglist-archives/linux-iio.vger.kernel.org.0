Return-Path: <linux-iio+bounces-15941-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD82A40896
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 14:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F253A5D26
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 13:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4360B53365;
	Sat, 22 Feb 2025 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpBRyyW0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020911EA90
	for <linux-iio@vger.kernel.org>; Sat, 22 Feb 2025 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740229583; cv=none; b=BkAoCH2398UfaKgd1xpMyCvxzGv4udp7YlJ1sEDqCYx4VTRJMGeQGCjqBIMJuhPt8rzzR7J5QFyZn7MQECgT8yYhFwEidIuY37EbOYJQQGzLqhlm1y0no2MZsEUxCWYKWvO+sATpruf0oKJloTmjhazU4zAQILB1rdYaSqF9ays=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740229583; c=relaxed/simple;
	bh=/8B9MjQPLnKfI3dAStknbwCjJkZTC5WVstjfUQNSd1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WRWouFQYqcr0aKSL7REALCBzLq8IV1gI9kO4vSVMmC4aZa/r4tE8Hs/3sj5WlFEr8IRdPt++c4xgjTYWZkY2TqzwizAFOLRTZPbDw6FWVjvZZzRivwP7sZjllubQpKjSt3AqefS6sotphOBJtmnTh4zGKFiGql2Nr57aMJf4nVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpBRyyW0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF1CC4CED1;
	Sat, 22 Feb 2025 13:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740229582;
	bh=/8B9MjQPLnKfI3dAStknbwCjJkZTC5WVstjfUQNSd1Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tpBRyyW09beaIeBgGh8fV75cBD6brB7qN5kfzQOBA+jL1fsC6Jr+OxOddXaeaMnRt
	 3lJ9CmA0lQu0s5jlVk2zFGe7b/cX39kWFh3MXDykSf54S9aUo4beMZZRj0zCFo9nav
	 DPjY+N3RBlWltqXfVydh5hNHqngHC3hBada0aUx1pX97B2oVkgyeNKbOP5lXb50Ijg
	 4dC/gs+stM1X1hdfspP8tfFr/U4AVZvSp4V1pULW1kZhH+Lq2VrTgqyDnHgic27hsj
	 ouu+p1U2JtEuWr+4//fEuMSgUomWuu3LO/KcUvszJrw2kNRa1Ntm5cKmCnBJaiKcGi
	 Q9Yr0X9FoqQ2A==
Date: Sat, 22 Feb 2025 13:06:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Mike Looijmans <mike.looijmans@topic.nl>,
 Phil Reid <preid@electromag.com.au>, Marek Vasut
 <marek.vasut+renesas@gmail.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>, Marek Vasut <marex@denx.de>,
 Frank Li <Frank.Li@nxp.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 24/29] iio: adc: max1027: Switch to sparse friendly
 iio_device_claim/release_direct()
Message-ID: <20250222130259.1ca04b2a@jic23-huawei>
In-Reply-To: <87h64stw90.fsf@bootlin.com>
References: <20250217141630.897334-1-jic23@kernel.org>
	<20250217141630.897334-25-jic23@kernel.org>
	<87h64stw90.fsf@bootlin.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Feb 2025 16:40:43 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Jonathan,
>=20
> On 17/02/2025 at 14:16:24 GMT, Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > These new functions allow sparse to find failures to release
> > direct mode reducing chances of bugs over the claim_direct_mode()
> > functions that are deprecated. =20
>=20
> Ok, I didn't know.
>=20
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Only just deprecated about 2 weeks back!
This one needed a tiny tweak to fix up the removal of the missing
semicolon in the previous patch.

Jonathan

>=20
> Thanks,
> Miqu=C3=A8l


