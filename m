Return-Path: <linux-iio+bounces-12758-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C402C9DAF54
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 23:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F25E8B21B12
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 22:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32D4202F71;
	Wed, 27 Nov 2024 22:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="vUI6BF/e"
X-Original-To: linux-iio@vger.kernel.org
Received: from vern.gendns.com (vern.gendns.com [98.142.107.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3C813BC35;
	Wed, 27 Nov 2024 22:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.142.107.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732747797; cv=none; b=CzQt0twu6dYkkYsOXL1MD3gmxFgb2jZpHea+m1U/DSJ951MZe8Sn1c+fYkE+33ARCO/gfjvf3XEXbZZUCHSHY385Zk9sZe+dti/fKXn4ErLrAL14xEsv2izLhS2dUApwwxE9CAa+KvibbJSp7+67Hcsc/hgTtjetmbE/LCEcuSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732747797; c=relaxed/simple;
	bh=yHbkOdGZ/gV2M9ZFCqKzSzTd7trIWrm0ZksrHnoNTCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHwhmgQIc+RfZyRZiKRF0nqxu6bxekEZycOADeQ2Cw1owGOSFC1gT9wYANgmCBzpx5+O0ALabp+aYHjeVY5HBTAbGNHr7KRrfvsgj1w/YtrPUcNfymr9wThPS26ZiPHyri9V9AZhqlo1efmiAG1jnMtR0Ri9nBLqeim4jngwvBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com; spf=pass smtp.mailfrom=lechnology.com; dkim=pass (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b=vUI6BF/e; arc=none smtp.client-ip=98.142.107.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lechnology.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hMUtGkwU6OybnPoy+PNJ2R+Zfic/wvSyqAgr9APpV0M=; b=vUI6BF/e9AJPSf++3b/7UQ9iZN
	YzejioM14d/K1H73DXnrh8A+0aY0g+4z3Uy/oeY0J6ZhDMEK/FqQczIBGMAwOnFxVHK8UIz2/ophO
	eanHbgLltkjQ6j7S8w36DxmkhRekv0NUrb1pwcJnPnDwrcmNLs5ePkDA5t2NzVpEZkmSFRlx5QIyv
	hp50OSz7WO/Lo9qhZUcnWBZOD7XXYEs7EAVtIXJViCBMv/eQypTT53seBbkdkwgLhEdlOYyvvSA5n
	suF6MPl+28Wx2ml2xumwndO6bJlQwYmJOJW/Q2Eh1lYn+mas2HKt8o0j1JqrdXkUq5NcdsbkSnQtC
	/FquCUjg==;
Received: from ip98-183-112-25.ok.ok.cox.net ([98.183.112.25]:58976 helo=[192.168.0.142])
	by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <david@lechnology.com>)
	id 1tGQtO-0005gm-1K;
	Wed, 27 Nov 2024 17:49:53 -0500
Message-ID: <538f5d83-1a16-4df5-8dbe-4c6d556e1058@lechnology.com>
Date: Wed, 27 Nov 2024 16:49:52 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add COUNTER_FUNCTION_DISABLE to the counter API
To: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, wbg@kernel.org
References: <c67e095c-3fba-44df-950f-b014ce27eb0f@lechnology.com>
 <20241127215404.915-1-rafael.v.volkmer@gmail.com>
Content-Language: en-US
From: David Lechner <david@lechnology.com>
Autocrypt: addr=david@lechnology.com; keydata=
 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
In-Reply-To: <20241127215404.915-1-rafael.v.volkmer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 11/27/24 3:54 PM, Rafael V. Volkmer wrote:
> On 11/25/24 11:36 AM, David Lechner wrote:
>> How does this work without an additional patch to modify the TI eQEP
>> counter driver to handle this new enum value? For example, I would
>> expect that this enum value would be added to ti_eqep_position_functions
>> and case statements added in ti_eqep_function_read(),
>> ti_eqep_function_write() and ti_eqep_action_read() to handle the new
>> option.
> 
> Hi, David!
> 
> Yes, the intention is to have a second path where the eQEP driver handles 
> this within these file operations functions.
> 
> Best regards

OK, so please send those patches too so that we can see the whole picture.

Based on your discussion with William, it sounds like there are 2 things
that need to be resolved.

1. Should a power saving mode actually be a counter function or should it
   be controlled by the counter enable attribute or something else, like
   more general Linux power management stuff?
2. If there are going to be in-kernel users calling these functions, then
   we will likely want to introduce some new APIs in the kernel for this.
   Using platform_get_drvdata() from one driver to another is a bit
   fragile. Likely we will want some devicetree bindings for counter
   consumers and providers and some kernel APIs like a counter_get() that
   takes an index or string ID to get the counter provider assigned to a
   counter consumer. Then we will probably want some wrappers around the
   counter ops pointers so that consumer drivers don't have to depend on
   the internal implementation of the counter subsystem.


