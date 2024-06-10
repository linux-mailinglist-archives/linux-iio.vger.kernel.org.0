Return-Path: <linux-iio+bounces-6153-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C82902342
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 15:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1FD21F2785F
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 13:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F093143740;
	Mon, 10 Jun 2024 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GTtoIt3p"
X-Original-To: linux-iio@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FA685285;
	Mon, 10 Jun 2024 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718027562; cv=none; b=jgnzxGnXy0PcciMAZlfTZquaOcyZTZYzNmH8UETOinybTXcfWhwEfp0yfM8Q5//j0UlaJswFf2hObPjNaxC+ArDGPBzOQoobqOUccBC9CXv4hhzq+pXuZraRWIr9XLeAbZra0GISa6p+LckalBN1ahg0t34eJu0y5dyyvL+Cbxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718027562; c=relaxed/simple;
	bh=4y7uiLivI3G5UYck4SE3i2pYz8w7QkQyS/pLxfzeCzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=axr+V7kxwokduv740lJNN0k9SCgEmCzJxeR1cHDvW3JbHHW9SoTN+Ae2+gGjTU1S8P441E5/nRn0VwDEyWZp8UGV7SxG7awfw3ZY7o1umJcg62hpIiZPIbQQh8I0GEnj8XV+cbtGJ+ll/rRIjXVA/UTKED4VO4cVmVMc4kiXvV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GTtoIt3p; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45ADpl2t103767;
	Mon, 10 Jun 2024 08:51:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718027507;
	bh=rOemsaLMsZPUOaP2U/XQkpa3rTqKgUp8++UDOr3ZdB8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=GTtoIt3pGt1Y51eQHKR4kD8cAnCyabNNJ+wYDsoMb+sOzs6cbbjxSQ7k+I4oB9jEM
	 e1kr+PfrG2gIHfUYSmS5zbfD0E2TNtN+h77T5QYJR7nMzttfExGROOOrShIM4FMTV+
	 sjMGhuFyiWhxC59UKk0K8GzCqORAlGqJqYxz+CU8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45ADplw0078962
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 08:51:47 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 08:51:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 08:51:47 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45ADplu8129830;
	Mon, 10 Jun 2024 08:51:47 -0500
Message-ID: <303caaa0-456e-411c-99f1-f6ac69659b5a@ti.com>
Date: Mon, 10 Jun 2024 08:51:47 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Enable eQEP DT support for Sitara K3 platforms
To: David Lechner <david@lechnology.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
	<will@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Nishanth Menon
	<nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20240607162755.366144-1-jm@ti.com>
 <5a053d6d-69d2-4d09-9a69-77fe73416484@lechnology.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <5a053d6d-69d2-4d09-9a69-77fe73416484@lechnology.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On 6/8/24 8:58 AM, David Lechner wrote:
> On 6/7/24 11:27 AM, Judith Mendez wrote:
>> This patch series adds eQEP DT nodes for K3 Sitara devices:
> 
> FYI, it looks like you still have William's old not working email address
> so he might not be seeing this to pick it up.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/MAINTAINERS?id=c90663596e7c97363d8855c635f39500ed2f0030

Thanks David, will update with the respin.

~ Judith


