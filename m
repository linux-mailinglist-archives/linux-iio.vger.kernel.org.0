Return-Path: <linux-iio+bounces-24016-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19670B55192
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 16:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C29C5833C0
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 14:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56223101B9;
	Fri, 12 Sep 2025 14:24:49 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1116416D4EF;
	Fri, 12 Sep 2025 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687089; cv=none; b=cFMy9z36/BBAtjtXe51jrNJIQ4UReq8IIWldK+pzicsrma56xYq8X8yr91FCqQ4Z3hfErymZpOG7aZ5pRbIvLEjw4w/u6gI64PLG0lUmp7ELXuniQ5V2lWWicmVsXxCuk2dalt0ZZaUJyrk3vuMUJWcUh6FVaomfHxkfwMQWJM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687089; c=relaxed/simple;
	bh=HWeiQ8yLi5ihkUNO1KdlMYgVvMh3tn2UJYPfYos7vwM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/tQHRr8X6I0h0kR1DHdkSq7jbOJs7oTB6g6/8U84+IJB3TmzyOt6Wev9s7E5afDMktFs1ITEZzVDPToJKgXyDwbK9XZNTIMPr167O/a6E1DUMfsil1sioAthERcLA3N05w/Mkw0dIBPWNuTRcTwDvQle3n8lTIIoqwVQtAw4ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cNc7b37Qvz6M553;
	Fri, 12 Sep 2025 22:22:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E70CB14038F;
	Fri, 12 Sep 2025 22:24:44 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Sep
 2025 16:24:44 +0200
Date: Fri, 12 Sep 2025 15:24:43 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Petre Rodan <petre.rodan@subdimension.ro>, Krzysztof Kozlowski
	<krzk@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Nuno S??
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 07/14] iio: accel: bma220: reset registers during
 init stage
Message-ID: <20250912152443.000011f3@huawei.com>
In-Reply-To: <719e510e-1032-47cf-9a75-82c36de732f4@baylibre.com>
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
	<20250910-bma220_improvements-v2-7-e23f4f2b9745@subdimension.ro>
	<a10a2f6d-6cb7-4922-b505-dc6994f0415f@kernel.org>
	<aMLCWFatVkePTxCa@sunspire>
	<719e510e-1032-47cf-9a75-82c36de732f4@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 11 Sep 2025 08:44:16 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 9/11/25 7:36 AM, Petre Rodan wrote:
> >   
> 
> ...
> 
> > Just for my curiosity, do reviewers apply the patches one by one to (a branch of)
> > the tree itself or do they provide feedback directly based on the diffs?
> >   
> 
> I think most reviewers are like me and only are looking at the diff in the
> email. It would take too much time to apply every single patch I look at. So
> I only do that in very rare cases when I have a special interest in a patch.

Likewise.

Jonathan

