Return-Path: <linux-iio+bounces-6152-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC22902337
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 15:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19CA281994
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 13:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904CB136E30;
	Mon, 10 Jun 2024 13:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YSmgYmTB"
X-Original-To: linux-iio@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8413913665D;
	Mon, 10 Jun 2024 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718027336; cv=none; b=GBgb0ME08AXCNGlIbKsaL5W76k9FUtYbflsT4agbXp7nRVQXxSk6y5lc9iPXb/OFfShuULCZhpgGYV9N5gSmzJ7yubc+cX63b0n3crayJ9cV8CbpCQZkDMXzs1Z/AEFdnChmIO+HfmTsgZ5Y7Qoc39Ek4NCoepND7tSBBGVT6Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718027336; c=relaxed/simple;
	bh=KTQkgrXpi/1zgiku4hivPYmh8Wc6c0/1YXp/AJCp07A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iuCAb8DLTg1dG2XgIoCt76qID74jG7wZPvx+EJNN7JtLMRfByK3zoeXblqLyAirFPQfdZoIf1lGtQOW12ArHNRlFJ5jH3MT4XI843hP09QTYeQyENm8CA3R/9vd1MU6IqK/UJxdQPe7wgaDn+qjwCaEAQP3MB7AHtQdqOQZqUPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YSmgYmTB; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45ADmoQH098603;
	Mon, 10 Jun 2024 08:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718027330;
	bh=Xue21UwJd2F4D2IeLJvZH7TejT/wvd4BX+L9O9bmpz8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=YSmgYmTBX16bvq5e3PawXLWcYZcY+3otgKl+1zOkIhltLRz3vKkyXEIqQCtIp7IIG
	 6B7VCkw/wf7HVnp9/7bg81mUl4lu0CfTk1ktGl0H/B24q+HDbL5p6W+bIYLnD5T2pP
	 pocEnj/oZI1y8Sa6kxXAufyfpY+PpmwxQFU3Mebs=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45ADmoBO088478
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 08:48:50 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 08:48:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 08:48:49 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45ADmnKp025806;
	Mon, 10 Jun 2024 08:48:49 -0500
Message-ID: <3f4638ae-1b1b-470e-980b-86695978c5f2@ti.com>
Date: Mon, 10 Jun 2024 08:48:49 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] counter: ti-eqep: remove unused struct member
To: David Lechner <dlechner@baylibre.com>,
        William Breathitt Gray
	<wbg@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240609-ti-eqep-cleanup-v1-0-9d67939c763a@baylibre.com>
 <20240609-ti-eqep-cleanup-v1-1-9d67939c763a@baylibre.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20240609-ti-eqep-cleanup-v1-1-9d67939c763a@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi David,

On 6/9/24 3:06 PM, David Lechner wrote:
> Since commit 8817c2d03a85 ("counter: ti-eqep: Convert to counter_priv()
> wrapper") the counter field in struct ti_eqep_cnt is not used anymore.
> Remove it.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Judith Mendez <jm@ti.com>


