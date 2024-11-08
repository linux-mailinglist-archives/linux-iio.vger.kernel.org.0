Return-Path: <linux-iio+bounces-12037-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B0C9C205C
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 16:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781681C226CE
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 15:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99793206E93;
	Fri,  8 Nov 2024 15:29:04 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A77D205145;
	Fri,  8 Nov 2024 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731079744; cv=none; b=HyGVI6clEBbsFe8immM6HW+xib5hkYSoCZ/XBCDCV1btyzzeNaMdUoR01JFpWV9k6hYaKcYLONCqO9LVC70U2ePFI5MpBebZBkaum8gDI0gv5+WBzLjSzta+LXcvrtjG3CXTKcKKtK6vPoyGOz0Luotg1W3MywF0Ba6qnksHPxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731079744; c=relaxed/simple;
	bh=C8Akrgaf1ocHN+nK6Q93L1JBKd8GM74wo4hUrqK3hbs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dFqeFUOue5ub0cVMPOGaGxFC/+AQB9+wm5bEy4n0LtslUnP/aykJnJv8KXrV/lMfTNVZexKbblGiLJspa6p8qgHAMqeJ/tqHrJW1kPK7Tmzo/xnTh6N4tJtAXLNT21xTjdfpWVFyFptZYgvXefYGPjEUNwJjvUhuruRsUXEPxfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XlNBs1hWmz6J7gR;
	Fri,  8 Nov 2024 23:28:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CBC7B140133;
	Fri,  8 Nov 2024 23:28:58 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 8 Nov
 2024 16:28:57 +0100
Date: Fri, 8 Nov 2024 15:28:56 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Frank Li <Frank.Li@nxp.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, Carlos Song <carlos.song@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Jean Delvare <jdelvare@suse.com>, Guenter
 Roeck <linux@roeck-us.net>, <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH 0/3] iio: temperature: Add support for P3T1085
Message-ID: <20241108152856.000042ed@huawei.com>
In-Reply-To: <20241107-p3t1085-v1-0-9a76cb85673f@nxp.com>
References: <20241107-p3t1085-v1-0-9a76cb85673f@nxp.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 07 Nov 2024 18:02:26 -0500
Frank Li <Frank.Li@nxp.com> wrote:

> Add basic function support for P3T1085 temperature sensor.
> - Add binding doc trivial.yaml
> - Add basic read temperature driver
Hi Frank,

For a simple temperature sensor the usual question is why IIO rather
than hwmon?

Previous reasons have been:
- Very high performmance / accuracy part (i.e. expensive)
- Remote temperature so not typically hw monitoring.
- Same silicon with a more complex sensor (typically humidity or similar).

Any of those apply?  Or some other reason?

+CC hwmon maintainers and list.

Jonathan

> - Update imx93-9x9-qsb.dts
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Carlos Song (1):
>       iio: temperature: Add support for P3T1085
> 
> Frank Li (2):
>       dt-bindings: trivial-devices: Add NXP P3T1085UK I3C/I2C temperature sensor
>       arm64: dts: imx93-9x9-qsb: add temp-sensor nxp,p3t1085
> 
>  .../devicetree/bindings/trivial-devices.yaml       |  2 +
>  arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts    |  5 ++
>  drivers/iio/temperature/Kconfig                    |  1 +
>  drivers/iio/temperature/Makefile                   |  2 +
>  drivers/iio/temperature/p3t/Kconfig                | 29 ++++++++
>  drivers/iio/temperature/p3t/Makefile               |  5 ++
>  drivers/iio/temperature/p3t/p3t1085.h              | 31 +++++++++
>  drivers/iio/temperature/p3t/p3t1085_core.c         | 79 ++++++++++++++++++++++
>  drivers/iio/temperature/p3t/p3t1085_i2c.c          | 68 +++++++++++++++++++
>  drivers/iio/temperature/p3t/p3t1085_i3c.c          | 59 ++++++++++++++++
>  10 files changed, 281 insertions(+)
> ---
> base-commit: 74741a050b79d31d8d2eeee12c77736596d0a6b2
> change-id: 20241107-p3t1085-fbd8726cbc0e
> 
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
> 
> 


