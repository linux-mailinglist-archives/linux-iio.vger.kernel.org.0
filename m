Return-Path: <linux-iio+bounces-22100-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C54A2B13BD4
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 15:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3DDD188F90E
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 13:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1CD26E70E;
	Mon, 28 Jul 2025 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJPcX3d5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69A226A0A0;
	Mon, 28 Jul 2025 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710350; cv=none; b=acJzYJgK8t/XWJZKXkiC9g6idS4nTVOBYYiXOWzQzfx6J5ACtVi5xjHOQNkd0tCrAM8mU+wVK7qXmK7eLQdXsbacKiBROok7Jiswm9hkJt35SrHLx1sR86xh3/Aj03D1Uq5eLGw3P+ATiG/ocWEcPbknTHiL7zoSteCQq/s6cq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710350; c=relaxed/simple;
	bh=GHP+vmF6HXDjk4s6HPbXvpAvg1eS+ug4ShrxLy/cxUo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HYN6PJ4Lpi5Ak6UXClwUBjpD24yHG3iBpydiKqBU27dtmq8pDBaairvpRKoX/57ZtdE4i92isbo8RZ4xwGJ2mot6fY2tZm43XymT+G5vtuoE/sCMaTMAnEVaNzwJdbw5iuS6+85WP7+qZHtOk41B2PjGSOa0TQCzJapO1hmxQM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJPcX3d5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF72C4CEE7;
	Mon, 28 Jul 2025 13:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710349;
	bh=GHP+vmF6HXDjk4s6HPbXvpAvg1eS+ug4ShrxLy/cxUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QJPcX3d53jG+lOeOUJ37LH8tj+Pvy3v+ylWvBTNP7xCJhNmiVY7JrddiamMnWUXuN
	 P/DsV6sqXEV+DL03+QWQY6/4aV0AnV1tyiJoh+dh0gK6EmcpknqagullpZl/E+bXkX
	 gq6mWSX24thQbR8O1jkLdOWQoraC8o1YKMAB9745QGw0C+wVyyuywuuyDbk1oQWve4
	 QOP/7exU/unZWymFVCuK4z+5f+UpZjkohoL/BP069tt3f9pKtnCTPTqyJTHrcV7LWa
	 DFy7EfA58YchS4ThkqHUlgXVK9pJyzpFIPfoLbjYCEg4PyIlQAOuoGTjCeNeqPFD1E
	 HEdRozIe+8PDQ==
Date: Mon, 28 Jul 2025 14:45:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: ltr390: Add conditional data freshness
 check with sysfs control
Message-ID: <20250728144541.004f380a@jic23-huawei>
In-Reply-To: <CAE3SzaRMOFNxciCDQM5dUMTTONgAD8o7u-4hX=TDnLXs1wQ-hA@mail.gmail.com>
References: <20250721195419.526920-1-akshayaj.lkd@gmail.com>
	<20250721195419.526920-2-akshayaj.lkd@gmail.com>
	<CAE3SzaTFgLsLCw-bqSTygaanCpHKHGRj7ssGim84WjB-DxZPVA@mail.gmail.com>
	<CAE3SzaRMOFNxciCDQM5dUMTTONgAD8o7u-4hX=TDnLXs1wQ-hA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Jul 2025 01:42:19 +0530
Akshay Jindal <akshayaj.lkd@gmail.com> wrote:

> On Fri, Jul 25, 2025 at 12:24=E2=80=AFAM Akshay Jindal <akshayaj.lkd@gmai=
l.com> wrote:
> >
> > I agree that this will break the user behaviour.
> > Before dumping this off, I wanted to explore an idea.
> > What if this remains disabled by default, i.e. data->data_fresh_check_e=
n =3D 0;
> > So this way the regular sensor read_data calls will not break, and
> > based on demand,
> > the application can configure the driver to check for data freshness,
> > by toggling the sysfs attribute to 1.
> > i.e. echo 1 | sudo tee /sys/bus/iio/devices/iio\:device0/data_fresh_che=
ck_enable
> > =20
> Hi,
> Is there any feedback on this?

It's a fairly esoteric interface in general. I'm not yet convinced there
is a reason to have such an indicator at all. Key here is that custom ABI
is (more or less) unused ABI that bit rots.

So I think there are three possible paths forwards
- Harden whatever algorithm you are feeding this data to so that it doesn't
  matter if you get occasional duplicate data. i.e. make it a userspace pro=
blem.
- Handle the complexity of a buffered interface with freshness guarantee.
  Basically that means polling for new data - typically checking at double
  the expected sampling frequency and only pushing to the buffers if the
  data is fresh.
- Propose generic support for such an indicator and show that it is useful
  for a couple of devices and how we'd retrofit into existing drivers
  cleanly.

Jonathan

>=20
> Thanks,
> Akshay.


