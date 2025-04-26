Return-Path: <linux-iio+bounces-18703-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC98A9DBD4
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 17:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41069467C12
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 15:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A0A25CC54;
	Sat, 26 Apr 2025 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yi6Et77C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854A3A31;
	Sat, 26 Apr 2025 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745681227; cv=none; b=h6RSHVSReBEa9M7HyIoaaeVu9OZCuzW7xfgNV2Tc4nvtqV3R8iSjZAPbEHB+z/qJbKdWv8ab7viG5Il0dNXjm5Q3CtkekZUYURXtchcN8mUJVgCxCoSWDS7x17V1aiSAJR1rH+Jtf9z2N/UeL/1DpvIumelc4lZoxMWxJgCoNrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745681227; c=relaxed/simple;
	bh=xg7cH77o+Zu4oFh7/hJOJwiI2nIPiwrKXvo9u09DWLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ho5miU3hY9RIUfhqa/KIW4Prds4rAnIhwi+dZS6lFmsLAQfLQVFP5Fw0YY9D8zg5O6bApoGfVkIJB8SK6SHY33ueHrZVZm2ErTFZdUmaw3QT+JmMjLf/oBGIW7JC3H1uW7S91yZS6+kqJGeDmVodmndMpgBN6zP+vs8xgsDSvsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yi6Et77C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FABAC4CEE2;
	Sat, 26 Apr 2025 15:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745681227;
	bh=xg7cH77o+Zu4oFh7/hJOJwiI2nIPiwrKXvo9u09DWLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yi6Et77CVwcasf/aB0jE2MdoiXZILQq5kipc+QWh/oLt9kU7jNqqRdcxOg1wZo6p6
	 LaohpWIezPBHi/L9xkDU22ZJ+jOZZNoCf4y/jQIq+Mdj94jdYFcj8fL6LojP+3Z65o
	 K1VJzCikdIe9AjWkdIGv8qMfNGwME43W2jLvd6JJRWq1Sl3kQwiRYJRMFU4yfrokQ1
	 Xe2TVm0YSEhn+xcHLeGsYi+T+UXleC63C/YXw/bUPU5M2nyRwl8/w+0S3dM8/qIKUw
	 XHgtJaNdiv9CHBIvWlkrwtdyksrVOcsy3yIbivwpsrwHEbnst37xtvDHMHwlNspVr5
	 74t+Ro72y7gPg==
Date: Sat, 26 Apr 2025 16:27:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: bmp280: drop sensor_data array
Message-ID: <20250426162701.4dd1f282@jic23-huawei>
In-Reply-To: <CAHp75VdAw8T_3t8=2JLO07zddjy1_eYX0bSoG9R=7TFPY9pWbA@mail.gmail.com>
References: <20250422-iio-pressure-bmp280-rework-push-to-buffers-v1-1-ee722f29aeca@baylibre.com>
	<CAHp75Ve_C6BXo75xy4+xZ5b1O9-TT5TGGQDgTR_F1s3TFK3p6Q@mail.gmail.com>
	<12dac98d-3e6b-4c2b-8ac0-d526bdb5efd4@baylibre.com>
	<CAHp75VcHMTSGRrodixsLDS-xCi8KQJ0MtMSMi7tfATUgd3E5uA@mail.gmail.com>
	<22e934cd-117f-40fb-a788-edcfc0f8b0ba@baylibre.com>
	<CAHp75VdAw8T_3t8=2JLO07zddjy1_eYX0bSoG9R=7TFPY9pWbA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Apr 2025 01:38:13 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Apr 23, 2025 at 1:32=E2=80=AFAM David Lechner <dlechner@baylibre.=
com> wrote:
> > On 4/22/25 5:19 PM, Andy Shevchenko wrote: =20
> > > On Wed, Apr 23, 2025 at 12:22=E2=80=AFAM David Lechner <dlechner@bayl=
ibre.com> wrote: =20
>=20
> ...
>=20
> > > Ah, I meant the plural: of the supported sensors. Otherwise are you
> > > talking only about one sensor?
> > > =20
> > "each type of the sensors" doesn't sound right to me either.
> >
> > I am talking about more than one type, not more than one sensor. Sensor=
 just
> > describes what types I am talking about.
> >
> > So perhaps we could just avoid it with "each different sensor type". =20
>=20
> Okay, it might be my misunderstanding... Use the original one if you
> think it's better.
>=20

I stuck to original text.  Applied.

