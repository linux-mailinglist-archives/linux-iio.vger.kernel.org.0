Return-Path: <linux-iio+bounces-9933-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F0998A79C
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 16:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA1E283F39
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 14:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC846192B6E;
	Mon, 30 Sep 2024 14:47:26 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5761922FD;
	Mon, 30 Sep 2024 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707646; cv=none; b=eM0lOLYVumeXZ4oIzryQAr8eDAkWtFZNyGPpIKJya7nzkjTurBl2ARmhioHZIqYtLGdaLWB6NAsgMcB/HRI7fXusjTVsiPkrRidq+xthVD+UMuXcQSnEN5NF4umGc0pWdw390u816Wg/z+YLpGCM14WU9O47Dch2GaBqPSQVSDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707646; c=relaxed/simple;
	bh=5LEXMHLy/zPciloPx8E+0Qf7vHYG4+hAB8nDlfvvYCI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PSKEfRC6w03/sKksWHQcPqsJmUXzVm1SupeLKjL3lp/+bePtyqJqwmMKdkuMm/iHpvPfoR7b6hLj0Jd40cs3YoSzC1wzm/xGvyoycKz7jyGvSAPRcZdsTmUahBZCdMJ/DxwoYKn3Y548cMSxXjtT+a0N3iCUq8mvBwvqDGWu5jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XHP2670yDz6D9cl;
	Mon, 30 Sep 2024 22:43:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1766A1401DC;
	Mon, 30 Sep 2024 22:47:17 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 30 Sep
 2024 16:47:16 +0200
Date: Mon, 30 Sep 2024 15:47:14 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Lars-Peter Clausen <lars@metafoo.de>
CC: David Binderman <dcb314@hotmail.com>, "jagathjog1996@gmail.com"
	<jagathjog1996@gmail.com>, "jic23@kernel.org" <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "Linux Kernel
 Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: linux-6.12-rc1/drivers/iio/imu/bmi323/bmi323_core.c:133: Array
 contents defined but not used ?
Message-ID: <20240930154714.00000f5c@Huawei.com>
In-Reply-To: <14a21c87-22f9-4637-b663-bb0a28fe8e46@metafoo.de>
References: <AS8PR02MB10217F8B5827B69E6438488679C762@AS8PR02MB10217.eurprd02.prod.outlook.com>
	<14a21c87-22f9-4637-b663-bb0a28fe8e46@metafoo.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 30 Sep 2024 07:19:14 -0700
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 9/30/24 06:49, David Binderman wrote:
> > Hello there,
> >
> > I just tried to build linux-6.12-rc1 with clang. It said:
> >
> > drivers/iio/imu/bmi323/bmi323_core.c:133:27: warning: variable 'bmi323_ext_reg_savestate' is not needed and will not be emitted [-Wunneeded-internal-declaration]
> >
> > A grep for the identifier shows the following strange results::
> >
> > inux-6.12-rc1 $ grep bmi323_ext_reg_savestate drivers/iio/imu/bmi323/bmi323_core.c
> > static const unsigned int bmi323_ext_reg_savestate[] = {
> > 	unsigned int ext_reg_settings[ARRAY_SIZE(bmi323_ext_reg_savestate)];
> > 	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) {
> > 	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) {
> > linux-6.12-rc1 $
> >
> > I see no mention of bmi323_ext_reg_savestate[ i]. Is there a possible
> > cut'n'paste error in one of the two for loops ?  
> Yes. Do you want to send a fix?
> 

Have a couple of fixes queued for this driver (including I Think this one).

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=fixes-togreg&id=506a1ac4c4464a61e4336e135841067dbc040aaa

I'm just letting the fixes sit in next for a day or two to make sure nothing
else shows up then I'll do a pull request.

Jonathan

