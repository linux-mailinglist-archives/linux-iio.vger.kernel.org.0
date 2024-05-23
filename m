Return-Path: <linux-iio+bounces-5229-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6688CD8B4
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 18:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971121C21518
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 16:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB0236B17;
	Thu, 23 May 2024 16:52:40 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1912C1A2;
	Thu, 23 May 2024 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716483160; cv=none; b=dX7iXHbN/U28WzQH13iQiSKGBQAWsCB+rPnZWf9A1jGGEeT17cHYJN9fahCkzgVd7B/XGWWWvhhLosYg2sUoDhHOVt93CmAUZs1Y4OLFbPX+Aunt5dyrf7cxNFRqS4uIYAhgL9P3T7C7G7RErb5O9+EFuuyBDuBzkwgQ4/lX1kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716483160; c=relaxed/simple;
	bh=Jw3ekEjuKFoUIPIkpKYN7WVXSRJdpf5zIWvM7wH9bGc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJootb7nBbjK2Tv2dWChqvR+YQIk3sEvekEiADSUY3XvqfDdl8kdivuwQtw+O8hicFmzQChbsjifthtqjRGoXFINs7ccm2w6P09xj9vZEezxx+znIEL8ih3obIHmrGvQQzP9GZcgFP5dwGCVXjBz6JUXajvioWgdAmgUTmVU7Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VlZ2R0BRjz6K9Nl;
	Fri, 24 May 2024 00:51:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A1E301400DB;
	Fri, 24 May 2024 00:52:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 May
 2024 17:52:34 +0100
Date: Thu, 23 May 2024 17:52:33 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Kim Seer Paller <kimseer.paller@analog.com>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, "Liam
 Girdwood" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Dimitri
 Fedrau" <dima.fedrau@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Michael
 Hennerich" <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<noname.nuno@gmail.com>
Subject: Re: [PATCH v2 1/5] iio: ABI: Generalize ABI documentation for DAC
Message-ID: <20240523175233.00006e8b@Huawei.com>
In-Reply-To: <20240523031909.19427-2-kimseer.paller@analog.com>
References: <20240523031909.19427-1-kimseer.paller@analog.com>
	<20240523031909.19427-2-kimseer.paller@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 23 May 2024 11:19:05 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> Introduces a more generalized ABI documentation for DAC. Instead of
> having separate ABI files for each DAC, we now have a single ABI file
> that covers the common sysfs interface for all DAC.
>=20
> Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-dac   | 61 +++++++++++++++++++
>  .../ABI/testing/sysfs-bus-iio-dac-ltc2688     | 31 ----------
>  MAINTAINERS                                   |  8 +++
>  3 files changed, 69 insertions(+), 31 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac b/Documentation/=
ABI/testing/sysfs-bus-iio-dac
> new file mode 100644
> index 000000000000..53d5213520c6
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-dac
> @@ -0,0 +1,61 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_toggle_en
> +KernelVersion:	5.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Toggle enable. Write 1 to enable toggle or 0 to disable it. This is
> +		useful when one wants to change the DAC output codes. The way it should
> +		be done is:
> +
> +		- disable toggle operation;
> +		- change out_currentY_raw0 and out_currentY_raw1;

Generalize to [0...N] or something like that to allow more symbols.

> +		- enable toggle operation.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_raw0
> +What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_raw1
> +KernelVersion:	5.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		It has the same meaning as out_currentY_raw. This attribute is
> +		specific to toggle enabled channels and refers to the DAC output
> +		code in INPUT_A (_raw0) and INPUT_B (_raw1). The same scale and offset
> +		as in out_currentY_raw applies.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_symbol
> +KernelVersion:	5.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Performs a SW toggle. This attribute is specific to toggle
> +		enabled channels and allows to toggle between out_currentY_raw0
> +		and out_currentY_raw1 through software. Writing 0 will select
> +		out_currentY_raw0 while 1 selects out_currentY_raw1.
Perhaps write this more generally.  The ABI handles more than 2 symbol valu=
es.

                Performs a SW switch to a predefined output symbol, allowing
		switching between current symbol A with output
		out_currentY_rawA and new symbol B with output
		out_currentY_rawB by writing integer value B.
=20
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_toggle_en
> +KernelVersion:	5.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Toggle enable. Write 1 to enable toggle or 0 to disable it. This is
> +		useful when one wants to change the DAC output codes. The way it should
> +		be done is:
> +
> +		- disable toggle operation;
> +		- change out_voltageY_raw0 and out_voltageY_raw1;
> +		- enable toggle operation.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_raw0
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_raw1
> +KernelVersion:	5.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		It has the same meaning as out_voltageY_raw. This attribute is
> +		specific to toggle enabled channels and refers to the DAC output
> +		code in INPUT_A (_raw0) and INPUT_B (_raw1). The same scale and offset
> +		as in out_voltageY_raw applies.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_symbol
> +KernelVersion:	5.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Performs a SW toggle. This attribute is specific to toggle
> +		enabled channels and allows to toggle between out_voltageY_raw0
> +		and out_voltageY_raw1 through software. Writing 0 will select
> +		out_voltageY_raw0 while 1 selects out_voltageY_raw1.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 758c202ec712..b3be54c09159 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12850,6 +12850,14 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
>  F:	drivers/iio/dac/ltc1660.c
> =20
> +LTC2664 IIO DAC DRIVER
> +M:	Michael Hennerich <michael.hennerich@analog.com>
> +M:	Kim Seer Paller <kimseer.paller@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/ABI/testing/sysfs-bus-iio-dac

As it's a general doc, doesn't really belong in a driver specific entry.
So far we haven't listed these generic docs as having specific maintainers
and people have to rely on history to figure out who to cc.

> +
>  LTC2688 IIO DAC DRIVER
>  M:	Nuno S=E1 <nuno.sa@analog.com>
>  L:	linux-iio@vger.kernel.org


