Return-Path: <linux-iio+bounces-9067-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2B896973D
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 10:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABA13B22017
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 08:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C2D2139B5;
	Tue,  3 Sep 2024 08:36:19 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E05200116;
	Tue,  3 Sep 2024 08:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352579; cv=none; b=OaYb9oFZILIFaX9OfRoewoDZITwvbTlrIfKMh+5aUUu0kpT5HHrilmthR09ig+ShtZdFqRK3+qLeNazutVdSBs6TJTQmR/smnuI/TRYrE+BhzQiUOTUwcQzlbLh2I+nqriGBKSlUyCNMsNmEZEfM4QMHpd+6T6E49w+9GXk/+to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352579; c=relaxed/simple;
	bh=2+C1JwNOInUIAA1rNB1sOdcsewGTgxK0O8vupNv4API=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+gWthCnyozknq8j7c0DDCEwidio5bqQvck2uMSUCuzmOmk5orJsXcmYMmgxgiq56wUmoDeJlWjXGymM7JR9/qzADDJ1975Ljdabl22jh+AdCaZreZ+CxeS4NsHJ76X/NeaJ3DSSZmCITrSBRVAmrBYupjBZFMSktbLjjo2H7l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wyf491JC8z6K603;
	Tue,  3 Sep 2024 16:31:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B6E84140B55;
	Tue,  3 Sep 2024 16:36:13 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 3 Sep
 2024 09:36:13 +0100
Date: Tue, 3 Sep 2024 09:36:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <wangshuaijie@awinic.com>
CC: <jic23@kernel.org>, <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<gustavoars@kernel.org>, <kangjiajun@awinic.com>, <kees@kernel.org>,
	<krzk+dt@kernel.org>, <lars@metafoo.de>, <linux-hardening@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liweilei@awinic.com>, <robh@kernel.org>
Subject: Re: [PATCH V9 0/2] Add support for aw96103/aw96105 proximity sensor
Message-ID: <20240903093611.0000637f@Huawei.com>
In-Reply-To: <20240903060304.910863-1-wangshuaijie@awinic.com>
References: <20240831150724.201e7d73@jic23-huawei>
	<20240903060304.910863-1-wangshuaijie@awinic.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 3 Sep 2024 06:03:04 +0000
<wangshuaijie@awinic.com> wrote:

> On Sat, 31 Aug 2024 15:07:24 +0100, jic23@kernel.org wrote:
> >On Tue, 27 Aug 2024 08:02:27 +0000
> >wangshuaijie@awinic.com wrote:
> >   
> >> From: shuaijie wang <wangshuaijie@awinic.com>
> >> 
> >> Add drivers that support Awinic aw96103/aw96105 proximity sensors.
> >> 
> >> The aw9610x series are high-sensitivity capacitive proximity detection
> >> sensors. This device detects human proximity and assists electronic devices
> >> in reducing specific absorption rate (SAR) to pass SAR related certifications.
> >> The device reduces RF power and reduces harm when detecting human proximity. 
> >> Increase power and improve signal quality when the human body is far away.
> >> 
> >> The specific absorption rate (SAR) is a metric that measures the degree of
> >> absorption of electromagnetic radiation emitted by wireless devices,
> >> such as mobile phones and tablets, by human tissue.
> >> 
> >> This patch implements device initialization, registration,
> >> I/O operation handling and interrupt handling, and passed basic testing.   
> >I made one trivial tweak to add static to the iio_info declaration and
> >applied to the togreg branch of iio.git, initially pushed out as testing
> >for 0-day to see if it can find any issues we missed.
> >
> >Thanks,
> >
> >Jonathan   
> 
> Hi Jonathan,
> 
> Thank you very much for your help and suggestions, which have been very
> beneficial to me. May I ask if I need to continue modifying my patch?
> If not, please inform me of the approximate time for review and merging.

It's already merged.
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=a369e1d1a10790f63b4b858dc74b53730146754f

That will be tested by the autobuilders + I need to rebase the whole
tree on char-misc once Greg (hopefully) takes a pull request that is outstanding.

That isn't relevant for your patch, but there is some other work queued
up that has dependencies on fixes that went upstream quicker.

This 'should' make the coming merge window so should be in v6.12 in
about 3 months time.  You can develop additional features on top of it
now but they are unlikely to make the 6.12 cycle as there is only about
a week left.

Jonathan

> 
> I look forward to your reply so that I can better plan my subsequent work.
> 
> Kind regards,
> Wang Shuaijie


