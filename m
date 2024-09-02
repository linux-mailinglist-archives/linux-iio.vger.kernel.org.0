Return-Path: <linux-iio+bounces-8977-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ED6968556
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 12:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB471C22D05
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 10:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50BD144D21;
	Mon,  2 Sep 2024 10:54:37 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EBB7347B;
	Mon,  2 Sep 2024 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274477; cv=none; b=JO7lrfPBqp6Xak3FvQRQ9r6JZG6EuUWbLJbNZ8BFODeOTfrNp+ctAqF/q/fjpJcuOQJ2peWe2B7wCa9VzJ5db6gEb137YXQv6Go6iE/XsPDI0e0jL7RzBiaWQVvslGkuQUq468sp4nOMOgUF6TRtuJN/Q+9qC8hejlaN4DAgiUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274477; c=relaxed/simple;
	bh=tnYb5HqOcmBoAL2+APpeZ+yo1FiiK4oKRHGyNDOuco0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZ6biapg2hPB1XNq4RB9TBH40p8479V7CiEVX5gekc46wGkLGFemC4KPg5CGnGuRbiuiqvSGiJUxmKhJvIbfsprY/Aktt3V2elkp0+yxel1IrvEWmBhQbAZYKtU+qSXRb7Kcnd7QtOCmIks56UUCROUz7uQ7N+xEbkEutVSI3e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wy4pD1ZVyz6LD9w;
	Mon,  2 Sep 2024 18:32:52 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 70192140B35;
	Mon,  2 Sep 2024 18:36:15 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 2 Sep
 2024 11:36:15 +0100
Date: Mon, 2 Sep 2024 11:36:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
CC: Markus Elfring <Markus.Elfring@web.de>, Gyeyoung Baek <gye976@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron
	<jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, LKML
	<linux-kernel@vger.kernel.org>
Subject: Re: iio: imu: inv_mpu6050: Remove duplicate code between labels
Message-ID: <20240902113613.0000183e@Huawei.com>
In-Reply-To: <FR3P281MB175727DBF709CA59B1064C68CE922@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240901091214.15199-1-gye976@gmail.com>
	<533802b3-3034-4b7c-b903-72608917e2f0@web.de>
	<CAKbEznv-TmCr2FAodrM2SKK5A5pbV9p5-OvXPdmuk_4xXmh=Rw@mail.gmail.com>
	<7b827ee0-9116-4e8c-96e1-1fa5f7267f33@web.de>
	<CAKbEznu=+Bkw4kmoo7qG9h2wM=2XV54j_SYzHMAH1uWhtUPCvg@mail.gmail.com>
	<3c60e167-7815-49c8-89f1-fe1139879d6b@web.de>
	<FR3P281MB175727DBF709CA59B1064C68CE922@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 2 Sep 2024 09:54:14 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello,
> 
> beware this patch is buggy. It will break the IRQ handler function of inv_mpu6050 driver.
> 
> The normal code path is going through end_session label without goto, and expect the function return before executing inv_reset_fifo. Without it, the reset FIFO function will be called for every interrupt and is breaking normal functioning of the driver.

Doh.  Indeed.  I missed that entirely by focusing on the error paths, not the good one.


> 
> Best regards,
> JB
> 
> ________________________________________
> From: Markus Elfring <Markus.Elfring@web.de>
> Sent: Monday, September 2, 2024 08:00
> To: Gyeyoung Baek <gye976@gmail.com>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>
> Cc: LKML <linux-kernel@vger.kernel.org>
> Subject: Re: iio: imu: inv_mpu6050: Remove duplicate code between labels
>  
> This Message Is From an Untrusted Sender
> You have not previously corresponded with this sender.
>  
> >>> Hello, I apologize for the insufficient explanation.  
> >>
> >> How will the commit message be improved further?  
> …
> > Since the code is short,  
> 
> This implementation detail can be nice.
> 
> 
> > I think it's fine for now.  
> 
> Please reconsider such a view once more.
> Are imperative wordings also more desirable for a better change description?
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.11-rc6*n45__;Iw!!FtrhtPsWDhZ6tw!Hb9yipjKJXmB-DO9gWKADZfQZHI84WEFUc6Ns1iGhpAfvAAyjrnLQRJZLU2Ha0nI8Fs-HBqHFlFbq0Kl-O1CJwYLe776xbRywQ$[git[.]kernel[.]org]
> 
> Regards,
> Markus
> 
> 


