Return-Path: <linux-iio+bounces-11501-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6179B373C
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 18:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD74B21ACC
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 17:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624E71DF246;
	Mon, 28 Oct 2024 17:00:22 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EBE13AD11;
	Mon, 28 Oct 2024 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730134822; cv=none; b=MsGt7lSrSSaeOHZwBcRETCQZ+TnsoTAVkLLpDwwQrpBhGVii3Re/uqxSZXmaJfOGfC0M8p6qMH3YDBU7H8hLfbH9ni18yQKwMI0tyXfP8TBIgMnC1ALyN4kQRZW0db/w1e1TPJVIqgWY7tqtzUhSgDaVfHjElQN42scR+VsjYsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730134822; c=relaxed/simple;
	bh=V+vyyVR1VusYzJMJHdDT8A/71KMxAsSMzWuN2tgq0D8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rft77d9H8oNjUEn2+2UMFvX5WeMNhhPAjvmdq21o6w+JB7Y8h1wCxxwk2fQrQqP7bq2M6B3HMM6+ZWWy0kEd5dzqYkKMU+Vxb6uVy2I0zm7ZDy1Pjd0wJFW26F603BoFiKZfjFKTcmKyJFsCl7+/azj7k0jPBYpU0b7EKe/A1nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xcfhk60xZz6K7D2;
	Tue, 29 Oct 2024 00:57:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C362140429;
	Tue, 29 Oct 2024 01:00:18 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 28 Oct
 2024 18:00:17 +0100
Date: Mon, 28 Oct 2024 17:00:15 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Robert Budai <robert.budai@analog.com>
CC: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, "Ramona
 Gradinariu" <ramona.gradinariu@analog.com>, Antoniu Miclaus
	<antoniu.miclaus@analog.com>, Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jagath Jog J
	<jagathjog1996@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <robi_budai@yahoo.com>
Subject: Re: [PATCH 1/5] iio: imu: adis: Add custom ops struct
Message-ID: <20241028170015.00000b92@Huawei.com>
In-Reply-To: <20241028122543.8078-2-robert.budai@analog.com>
References: <20241028122543.8078-1-robert.budai@analog.com>
	<20241028122543.8078-2-robert.budai@analog.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 28 Oct 2024 14:25:33 +0200
Robert Budai <robert.budai@analog.com> wrote:

> From: Nuno S=E1 <nuno.sa@analog.com>
>=20
> This patch introduces a custom ops struct letting users define
> custom read and write functions. Some adis devices might define
> a completely different spi protocol from the one used in the
> default implementation.
>=20
> Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Nuno S=E1 <nuno.sa@analog.com>

Robert, you need to sign off on these if you are the person sending them
to the list - this says you 'handled' them and can verify the
rest of the tags are what you received etc.
(welcome to IIO btw!)

Jonathan

