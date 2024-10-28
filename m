Return-Path: <linux-iio+bounces-11988-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C89019C083B
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 14:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9ED28527F
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 13:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B49B21262B;
	Thu,  7 Nov 2024 13:56:51 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6552F20F5AA;
	Thu,  7 Nov 2024 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987811; cv=none; b=JrC8PiAaxFINzymortJjSjk9uCVqie7c44YFo0hEiv1zUghJepPTqlxdbpZfx666Zaff/rMFHD+ozTAzQR2LIfJiyqiZ5VXOGdC214XU3dBrpWZv1Y0yUqFkV320d1xrQYxNqeJ5hFpo0MjT7rNi+l6dXXmUjmo1aFv4Z9W5TUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987811; c=relaxed/simple;
	bh=7v/jldVNPehBirnoJkZk0fUgltTH/iaWGYa4s4Cqmj0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mk4McP2LNQeX9YVta3Ttp+buwVB1UlNMuilIvD4C3UQpSrs4+UxBM16JHSTW05EmQh0yycMNqFUQUAwF6jOCkvb4gewyblesLvCJwd7NUHpeHVKbjeDSmEV+9DrGs+bNhAwsRKuSaxLeAIH0yN1kwAjhMCLLWh4nc3yB+5P6bAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xkk952JS5z6K99D;
	Thu,  7 Nov 2024 21:55:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A05BF140856;
	Thu,  7 Nov 2024 21:56:45 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 7 Nov
 2024 14:56:44 +0100
Date: Mon, 28 Oct 2024 17:05:21 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Robert Budai <robert.budai@analog.com>
CC: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, "Ramona
 Gradinariu" <ramona.gradinariu@analog.com>, Antoniu Miclaus
	<antoniu.miclaus@analog.com>, Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jagath Jog J
	<jagathjog1996@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <robi_budai@yahoo.com>
Subject: Re: [PATCH 0/5] Add support for ADIS16550 and ADIS16550W
Message-ID: <20241028170521.0000325c@Huawei.com>
In-Reply-To: <20241028123550.9128-1-robert.budai@analog.com>
References: <20241028123550.9128-1-robert.budai@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 28 Oct 2024 14:35:42 +0200
Robert Budai <robert.budai@analog.com> wrote:

> The ADIS16550 is a complete inertial system that includes a triaxis gyros=
cope
> and a triaxis accelerometer. Each inertial sensor in the ADIS16550 combin=
es
> industry leading MEMS only technology with signal conditioning that optim=
izes
> dynamic performance. The factory calibration characterizes each sensor fo=
r
> sensitivity, bias, and alignment. As a result, each sensor has its own dy=
namic
> compensation formulas that provide accurate sensor measurements.


Dropping the more marketing parts of this preferred.  Second
sentence doesn't add much that we care about.
The rest is fine.

>=20
> Nuno S=E1 (3):
>   iio: imu: adis: Add custom ops struct
>   iio: imu: adis: Add DIAG_STAT register size
>   iio: imu: adis16550: add adis16550 support
>=20
> Ramona Gradinariu (2):
>   dt-bindings: iio: Add adis16550 bindings
>   docs: iio: add documentation for adis16550 driver
>=20
>  .../bindings/iio/imu/adi,adis16550.yaml       |   95 ++
>  Documentation/iio/adis16550.rst               |  389 ++++++
>  Documentation/iio/index.rst                   |    1 +
>  MAINTAINERS                                   |   10 +
>  drivers/iio/imu/Kconfig                       |   13 +
>  drivers/iio/imu/Makefile                      |    1 +
>  drivers/iio/imu/adis.c                        |   33 +-
>  drivers/iio/imu/adis16550.c                   | 1228 +++++++++++++++++
>  include/linux/iio/imu/adis.h                  |   33 +-
>  9 files changed, 1788 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis165=
50.yaml
>  create mode 100644 Documentation/iio/adis16550.rst
>  create mode 100644 drivers/iio/imu/adis16550.c
>=20


