Return-Path: <linux-iio+bounces-10485-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9676899B2F0
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 12:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7A61C21536
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 10:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C2315443F;
	Sat, 12 Oct 2024 10:27:03 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 2A898153BF0;
	Sat, 12 Oct 2024 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728728823; cv=none; b=URkaMvcQXkSesnaJ7y46NdsLht8WPrjjD05ptYZ/ZPoEwcoInG8wjfFuRVtidXOQQdpUzXFFDP12tiaAV5U17NfB5Wde3qzPMRIUhnkbSDmrE4VkVQykbLTk0BcTvt2HwfICx+QHZAq3oiEZP5cLcowYCUWfjbUfwPMJnFHBXaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728728823; c=relaxed/simple;
	bh=fvWAAvtLtXnWYyocEqzco45h8BNHi1j6ke6Jt6W8mck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=Xv5p/kOLEcLVoh4m3JnjUglHHOB4ZK8dfKebdoiVfmKxEdB+jkh5mPnb4wrT9Ahh97S2aM5Q0Bm1g3kTR9OIjCdNEDeZ1wiAaDUAScDgUHTIilxyPdGlCHCwLFUo9Fr/aQKx/VGuesSBR2Q4td6q+NXtIvFZNFqp+PjxxvDShAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.101] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 5F43460B23F6E;
	Sat, 12 Oct 2024 18:26:55 +0800 (CST)
Message-ID: <cc5d419f-0326-e683-6e84-ce55b8b1331f@nfschina.com>
Date: Sat, 12 Oct 2024 18:26:54 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] iio: bmi323: mark bmi323_ext_reg_savestate as maybe
 unused
Content-Language: en-US
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Julia Lawall <julia.lawall@inria.fr>
Cc: jagathjog1996@gmail.com, jic23@kernel.org, lars@metafoo.de,
 nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, benato.denis96@gmail.com,
 Jonathan.Cameron@huawei.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <e210f9c6-9070-4b6d-b938-9a35b7a16380@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> This issue has already been found and discussed here:
>
> https://lore.kernel.org/linux-iio/AS8PR02MB10217F8B5827B69E6438488679C762@AS8PR02MB10217.eurprd02.prod.outlook.com/
>
> where I got lectured by Nathan Chancellor about such warnings.
>
> The fix was not marking the array as unused, because it should have been
> used. The proper fix can be found in iio/fixes-togreg.

Oh , I just saw this email. Thanks!

Su Hui


