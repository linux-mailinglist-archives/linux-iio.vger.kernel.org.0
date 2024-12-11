Return-Path: <linux-iio+bounces-13324-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 251969ECCE4
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 14:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32595167D84
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 13:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCCF23FD23;
	Wed, 11 Dec 2024 13:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADI+e0Qt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5746323FD14;
	Wed, 11 Dec 2024 13:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733922675; cv=none; b=LkI9IN8Hoq08PdedahIQHs8dIuwKNQL8EEmgjTw8mksRXX/3XoKwPdPZsN5G99uf7Rzhc7q5/yDxw85/L0O6o2NihmcZ+BTWFzfZEvtWAhUlMFmqrNMDW+NeAZwpNlR7ON/8l90Xdax4XJu7odtBHawNjGIG+GPCK3NQ5ccZsbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733922675; c=relaxed/simple;
	bh=pB6WfjwT9slsXqTxipmydzhAioPaD1EfbAGoCb329Mc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=P8BDUFGNLZCicUpsQGbbSrPHjuF731l+g9ekLUXJP7Ouf15LvHW+Ei7nXTdLPxNiWnL0yqIdI5/vx5/usRu9qiqgcWuKlZNlFHk+ZYYAG6LSjFbhpX/1PZMNOfh8zsKrQQpTpjZ0cn/F8G3HzZ4DxpYO9Rzqfu7n5fLBetbrST8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADI+e0Qt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8DBC4CED2;
	Wed, 11 Dec 2024 13:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733922674;
	bh=pB6WfjwT9slsXqTxipmydzhAioPaD1EfbAGoCb329Mc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ADI+e0QtZ1oAmgQ0QHjwIA+p/EztuGuNXG9ULPqktb3ReMUSyMvFcxtgk1Xk5pWiH
	 AcC18yzR9mFkvDAKY4YX9IR0JhomxloM4MqHD0feCwEQEhnA6dL0AqzVE5Ea5Jm9d7
	 XT2MGhWOHzzhDtGOYiI42wviTOebSg/1u5fJHYSrxzcdomd0sTuPA0zZZJqd6x7bW6
	 ZNAAiuMbuc1yqnRHzWMlejmZrHyMqmZYixCKheStx6sSuZI09f+vmcSqQF1Di/gFsk
	 vjUXa6LuU4Jm3Um5Uk9Brossj80/7Bw9BSUO+n+qXK3UGmfpQ75feVVJSWXRRoSlmR
	 rhmutss1FC7zg==
Date: Wed, 11 Dec 2024 14:11:11 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-15?Q?Heiko_St=FCbner?= <heiko@sntech.de>
cc: Lee Jones <lee@kernel.org>, jic23@kernel.org, robh@kernel.org, 
    krzk+dt@kernel.org, conor+dt@kernel.org, jdelvare@suse.com, 
    linux@roeck-us.net, srinivas.pandruvada@linux.intel.com, 
    bentiss@kernel.org, dmitry.torokhov@gmail.com, pavel@ucw.cz, 
    ukleinek@debian.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
    linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
    linux-leds@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v9 1/9] HID: hid-sensor-hub: don't use stale platform-data
 on remove
In-Reply-To: <3196449.TQGk6oTFT5@diego>
Message-ID: <4s41717n-3888-os6o-384n-7678n0361r0s@xreary.bet>
References: <20241107114712.538976-1-heiko@sntech.de> <20241211120844.GD7139@google.com> <n914pn7o-pr9n-5ss0-p744-73402nnn843p@xreary.bet> <3196449.TQGk6oTFT5@diego>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Dec 2024, Heiko St=FCbner wrote:

> > > > > > This change was more or less a surprise find, because I wanted =
to make
> > > > > > the platform_data pointer in the mfd_cell struct const and this=
 the hid
> > > > > > sensor hub stood out as doing something strange ;-) .
> > > > > >=20
> > > > > > So patch 2 of this series actually depends on this change to no=
t cause
> > > > > > build errors.
> > > > >=20
> > > > > Ah, right.
> > > > >=20
> > > > > > But seeing that we're after -rc6 alredy, I would assume the bru=
nt of the=20
> > > > > > mcu series might need to wait after 6.13-rc1 anyway - but I gue=
ss that=20
> > > > > > depends on how Lee sees things ;-) .
> > > > >=20
> > > > > OK, I am keeping my hands off it for the time being.
> > > >=20
> > > > I can take it now with an Ack.
> > >=20
> > > Looking to apply this set now.
> > >=20
> > > Ack please.
> >=20
> > I'd preferer if Srinivas could ack this as the more specific maintainer=
=2E=20
> > Srinivas, please?=20
>=20
> The patch already includes the
>    Ack from Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> from a previous version, so I guess it should be ok already?

Ah, I missed that, indeed, sorry for the noise.

With that

=09Acked-by: Jiri Kosina <jkosina@suse.com>

and Lee, please feel free to take it.

Thanks,

--=20
Jiri Kosina
SUSE Labs


