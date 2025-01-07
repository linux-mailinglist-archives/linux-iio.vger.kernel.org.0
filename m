Return-Path: <linux-iio+bounces-13960-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BACD9A04287
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 15:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E8A1881788
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 14:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5941EE7C2;
	Tue,  7 Jan 2025 14:29:01 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8E81DFE0C
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260141; cv=none; b=g8vN0bRoeqIQh0FuU9bDjmE8GaDymJVjTQa3mFTRR5SRo18c1Axr7JHoVqyO2Y5EynvaZkVWDL0lyqa9k+0794P7CYpfcTspHASOLW8oAp5YYWWOCaZrXy/xtwHGNoU/0+SoganMCyGPpnuTcIQZ3StDojljaMnic5yA0o97HhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260141; c=relaxed/simple;
	bh=W1eik0mfG23V4yuVqSbUhDfI7yk2EvGVFA8Kx5DRRmI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E1cr+MgJaIdP5IggML9CLfRZtIiYZr4fLpjzu5qPJwCksVdnZRm/eckeieGzxpGYoKdnP8RrXBkjhPHMRXCeiqkSiHGqT58+60xknyGPT77v6S2rPfZExgHDM/hS8mfVv6SQFCuqr8iDi7Vx39kvzX/hgeFFxJDcvC+Er0L4XV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YSD0B26cyz6GDq2;
	Tue,  7 Jan 2025 22:27:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AF083140A90;
	Tue,  7 Jan 2025 22:28:55 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 7 Jan
 2025 15:28:55 +0100
Date: Tue, 7 Jan 2025 14:28:54 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	=?UTF-8?Q?=E2=80=9CLuc?= Van =?UTF-8?Q?Oostenryck=E2=80=9D?=
	<luc.vanoostenryck@gmail.com>, David Lechner <dlechner@baylibre.com>
Subject: Re: [RFC PATCH 09/27] iio: adc: ad4000: Stop using
 iio_device_claim_direct_scoped()
Message-ID: <20250107142854.0000656a@huawei.com>
In-Reply-To: <Z30QIFr12sw7Wajd@debian-BULLSEYE-live-builder-AMD64>
References: <20250105172613.1204781-1-jic23@kernel.org>
	<20250105172613.1204781-10-jic23@kernel.org>
	<Z30QIFr12sw7Wajd@debian-BULLSEYE-live-builder-AMD64>
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

On Tue, 7 Jan 2025 08:29:36 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 01/05, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > This complex cleanup.h use case of conditional guards has proved
> > to be more trouble that it is worth in terms of false positive compiler
> > warnings and hard to read code.
> > 
> > Move directly to the new claim/release_direct() that allow sparse
> > to check for unbalanced context.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/iio/adc/ad4000.c | 61 +++++++++++++++++++++++++---------------
> >  1 file changed, 38 insertions(+), 23 deletions(-)
> >   
> Hi Jonathan, aside from the spurious blank line noted by David, the changes for
> ad4000 look good to me.
> 
> Acked-by: <marcelo.schmitt1@gmail.com>
> 
> I also tried running Sparse on IIO subsystem but didn't see any warns for the
> drivers being changed (nor prior nor after applying the patches).
> 
> make CHECK="path_to_local_sparse_v0.6.4-66-g0196afe1" C=2 drivers/iio/
> 
> Did see warns after adding incorrect type in assignments in the driver.
> 
> Mind sharing how you are running Sparse?

I just used C=1 but that doesn't really matter for this.
With this series there should be no false positive warnings (or before
it where we didn't have any markings so sparse didn't know to do anything).

Testing wise, I sprinkled in some early returns, breaks etc to add
some broken paths and those triggered context imbalance warnings.

This isn't fixing warnings, it is just about moving to code where we
will get them if we do something silly in the future.

Jonathan

> 
> Thanks,
> Marcelo


