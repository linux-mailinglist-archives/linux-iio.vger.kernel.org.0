Return-Path: <linux-iio+bounces-3976-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D21848942E5
	for <lists+linux-iio@lfdr.de>; Mon,  1 Apr 2024 18:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE1328379D
	for <lists+linux-iio@lfdr.de>; Mon,  1 Apr 2024 16:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9A54AEF0;
	Mon,  1 Apr 2024 16:57:20 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04461BA3F;
	Mon,  1 Apr 2024 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990640; cv=none; b=SB8sz0Qe6pmo3s5TtR4NF3+b8bdWXQjET4mhxXx57V+VspajeXAzlsAjEpq91Wqes/KofycdYLJTnpoASc0N7ICF/eJlUUIGtXO00pjNZf98hWOwoejq5b/WTafxQW5iRyxqY8pgLTKIuEZyZUO/ysDIup96b6GZLmkTRQJKMwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990640; c=relaxed/simple;
	bh=83qPGSUndJgC0/LyXO45dq2E2fBQnWGd+uzgPZWvmgM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ft+0kuh2jGLrCZoaaXpTqIiAA8RYXiAjXtbR/RZN6WGTHfL8JgX23yud5MFhLzfMMIAHH8dQUmILIeAdG4rUFVqlGBaK38RFyGsc9ECpx3DFCcx9PA/twKgjpGA+zliurCTf5ukeQpdKndQ9fYSRlS0i4ZOIc7WkU3RI4H5Y5T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V7cbV1p15z67Xmk;
	Tue,  2 Apr 2024 00:56:06 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C407B1400D9;
	Tue,  2 Apr 2024 00:57:16 +0800 (CST)
Received: from localhost (10.48.156.172) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 1 Apr
 2024 17:57:16 +0100
Date: Mon, 1 Apr 2024 17:57:15 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Conor Dooley <conor@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, <inv.git-commit@tdk.com>,
	<robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Jean-Baptiste Maneyrol
	<jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: add icm42688 inside
 inv_icm42600
Message-ID: <20240401175715.000049de@Huawei.com>
In-Reply-To: <20240401-marshy-derby-e22a469dd555@spud>
References: <20240329151535.712827-1-inv.git-commit@tdk.com>
	<20240329151535.712827-3-inv.git-commit@tdk.com>
	<20240329-fifth-earpiece-78daf4d943ce@spud>
	<20240330161012.0b49846a@jic23-huawei>
	<20240401-marshy-derby-e22a469dd555@spud>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 1 Apr 2024 12:04:55 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Sat, Mar 30, 2024 at 04:10:12PM +0000, Jonathan Cameron wrote:
> > On Fri, 29 Mar 2024 15:49:26 +0000
> > Conor Dooley <conor@kernel.org> wrote:
> >   
> > > On Fri, Mar 29, 2024 at 03:15:35PM +0000, inv.git-commit@tdk.com wrote:  
> > > > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> > > > 
> > > > Add bindings for ICM-42688-P chip.
> > > > 
> > > > Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>    
> > > 
> > > My initial thought was that you're missing a sign-off, but is
> > > "inv.git-commit@tdk.com" some system you have to bypass corporate email
> > > garbage?  
> > 
> > Common enough setup, as long as the From: line matches the sign-off, git will
> > ignore the email address used to send it when the patch is applied.  
> 
> Yeah, I know how it works, I do it all the time. Even found, or rather
> caused, a b4 bug where it would use the sending email in the eventual
> commit rather than the author:
> https://lore.kernel.org/tools/20230310192652.ymac3w2lucfdf34p@meerkat.local/
> 
> I'm just double checking that there's not a missing signoff. When I've
> seen these corp-email-bypass accounts before people set a proper "from"
> in git send-email so there's a name in it: "A Dev <inv.git-commit@tdk.com>"
> 

Ah.  Got it now :)
I guess it depends on how their weird setup wires everything up!

Jonathan

