Return-Path: <linux-iio+bounces-10742-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCABF9A457F
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 20:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A1F2852CB
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 18:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DB42040B1;
	Fri, 18 Oct 2024 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIBbJnJU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD038472;
	Fri, 18 Oct 2024 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729275015; cv=none; b=QDctKL6BID3evdR/O7NvasKPIO9MiKpky24opp8wVFYBrzLDO3qzCgFD2yuSCO2q5FHFpMS6tM7/nOIledV6tM8/Dr2cSCpV5FcmWjtLHS8Kcit2S7mKua/J34M47IAKT/f80b5J50UJgkEuN8nPsVjsbdb0wZzItCfvjkCulIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729275015; c=relaxed/simple;
	bh=9yaCmxGUI0xpIbTKyt2NJCZxUQiqbruYfsGNowkzzOI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tf+wk2FE0KV8uxX9C6orWWnHuML2SQApQjVKbwRBje92XpNTLir7teZ5IBXr5M2M0XMuvt+Aii+S0Vaq3U9waaSnDn33iyx5FkTEAtXM3T/N0Vxpvy2YFHdt0+vYC0uTFZNDxSXe8smvR/0mjWlTHivAIXwroq9MNbJKiicpISs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIBbJnJU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0772AC4CEC5;
	Fri, 18 Oct 2024 18:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729275015;
	bh=9yaCmxGUI0xpIbTKyt2NJCZxUQiqbruYfsGNowkzzOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nIBbJnJUHQGzPfWkaOphdIkgsNLrJ2dJ2YKiu6tw3wT07nfGKeHhGUGH7jqS2XEUj
	 X+r7+sNYnYRyrP/cV+vHex+1ACc9Ur9iqSZF+qf7KfU7eq9tuMewetuW3D8GCZVACH
	 0RWyjbRRZw/CfGzu9yCHWobScOdiaF+Ya6TOA4UjVR1fKSXtd68E2YrLiG3KMtlst1
	 lJlqX6jic7T7FJF1d6Ps0mSfgPj/z49ISxYbzsYgE9wDvQ7AXIwRM6jcLKp1EhlnKV
	 tTbiwpGJh9l6azF/izcokiLgkCb8NM0fKrw1/Fn1bKsVFh8XWLZcjot2JIGLQNAZea
	 fOSSrgb+eZvsQ==
Date: Fri, 18 Oct 2024 19:10:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <Jianping.Shen@de.bosch.com>
Cc: <lars@metafoo.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <Christian.Lorenz3@de.bosch.com>, <Ulrike.Frauendorf@de.bosch.com>,
 <Kai.Dolde@de.bosch.com>
Subject: Re: [PATCH v9 0/2] iio: imu: smi240: add bosch smi240 driver
Message-ID: <20241018191005.4530ad0d@jic23-huawei>
In-Reply-To: <20241018135234.5446-1-Jianping.Shen@de.bosch.com>
References: <20241018135234.5446-1-Jianping.Shen@de.bosch.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Oct 2024 15:52:32 +0200
<Jianping.Shen@de.bosch.com> wrote:

> From: Shen Jianping <Jianping.Shen@de.bosch.com>
>=20
> Add the iio driver for bosch imu smi240. The smi240 is a combined
> three axis angular rate and three axis acceleration sensor module
> with a measurement range of +/-300=C2=B0/s and up to 16g. This driver
> provides raw data access for each axis through sysfs, and tiggered
> buffer for continuous sampling. A synchronous acc and gyro sampling
> can be triggered by setting the capture bit in spi read command.
>=20
Applied to the togreg branch of iio.git and pushed out as testing
for 0-day to take a first look at it.

Minor tweak needed due to the unaligned.h header moving to linux/

Thanks,

Jonathan

> dt-bindings:=20
> v1 -> v2
>     - Add more detail in description
>     - Add maintainer
>     - Add vdd and vddio power supply
>     - Use generic node name
>     - Order the properties according to DTS coding style
>=20
> v2 -> v3
>     - Improve description
>     - Improve supply definition
>     - Make supply definition as required
>     - Add supply definition in example
>=20
> v3 -> v4
>     - No changes
>=20
> v4 -> v5
>     - No changes
>=20
> v5 -> v6
>     - Fix checkpatch findings
>=20
> v6 -> v7
>     - No changes
>=20
> v7 -> v8
>     - No changes
>=20
> v8 -> v9
>     - No changes
>=20
> imu driver:
> v1 -> v2
>     - Use regmap for register access
>     - Redefine channel for each singel axis
>     - Provide triggered buffer
>     - Fix findings in Kconfig
>     - Remove unimportant functions
>=20
> v2 -> v3
>     - Use enum f=C3=BCr capture mode
>     - Using spi default init value instead manual init=20
>     - remove duplicated module declaration
>     - Fix code to avoid warning
>=20
> v3 -> v4
>     - Use DMA safe buffer
>     - Use channel info instead of custom ABI
>     - Fix other findings
>=20
> v4 -> v5
>     - Merge the implementation in one simple file
>     - Add channel info for acc/gyro data channel
>     - Fix other findings
>=20
> v5 -> v6
>     - Fix checkpatch findings
>     - Fix review findings
>=20
> v6 -> v7
>     - Fix offset and scale
>=20
> v7 -> v8
>     - Use memcpy in spi write to keep CPU endian
>     - Fix some minor findings
>=20
> v8 -> v9
>     - remove unnecessary cpu_to_le16 for reg value in spi response
>     - use REGMAP_ENDIAN_NATIVE in regmap config to avoid regmap to flip t=
he reg value when passing to spi write
>=20
> Shen Jianping (2):
>   dt-bindings: iio: imu: smi240: add Bosch smi240
>   iio: imu: smi240: add driver
>=20
>  .../bindings/iio/imu/bosch,smi240.yaml        |  51 ++
>  drivers/iio/imu/Kconfig                       |  14 +
>  drivers/iio/imu/Makefile                      |   2 +
>  drivers/iio/imu/smi240.c                      | 622 ++++++++++++++++++
>  4 files changed, 689 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi24=
0.yaml
>  create mode 100644 drivers/iio/imu/smi240.c
>=20


