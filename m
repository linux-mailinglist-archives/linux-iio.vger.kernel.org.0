Return-Path: <linux-iio+bounces-16091-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34917A4616E
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 14:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379DD17B40F
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 13:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E5321D5B6;
	Wed, 26 Feb 2025 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="OqMQfTBr"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1FF21B1B5;
	Wed, 26 Feb 2025 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578221; cv=none; b=TCrqrzgV8cZPR3THx7FHRhK3GrZII8nx5DtRKPSYDGaJ0vVEaTAPFDx+dAB1u92XNPpbM6fO2lE2sppcdcWAvPvNSkguKq+oP1ZjUMjJzF6redQgFr+b7VHeeUrHzQuhtjfIOBBSOMM6K8KcXNNKGN9xL/lcYrLI1DgrvppNMYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578221; c=relaxed/simple;
	bh=Oc/HDmWMAo2bbV2UznjuhzE5BcBZLd3vSZPCWOgkamE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NtG4zhzVu8r4B8QPlNCPqmxaIKVrSk3N+/IrNvtsF1jbYGuMxqJXZbqbvjM5elnegRs94a/fBlNwJQWEO0km2mt+FGRqAydSP6icOfcJ44ExRLRniWaHx/mAaueXKradV++ifIvy0PQmKgzFuy3rtrGvC61PvCYvVmShtUzzLXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=OqMQfTBr; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 7EF7CA0929;
	Wed, 26 Feb 2025 14:56:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=UKO+pmLQatUCt7yegvUS
	1k29o1fQVlfCOBaelBDtfAU=; b=OqMQfTBrW+wDeQ5v1RIKWkX4gi6XvJt5qIzp
	/W5fRINaBZoudm3hspOOtxNO7rGtCth14AilNf9ArKtaiIYCyXNuSnq75Ka46Rv9
	f/kARS1XihmTkDfZD7cgx2xIWF7Fn/C1Q87e6vt59OySvCGse8dGN70V5X4RxvQp
	DM86nU1UEo7HOfPfNlmNOMfWV0gyCzNNCOqE/lo6IbS5FAZlyS/cz28xTlLpJYtM
	4Gp1BTalEzQcypRMt72OYUPKSbRSuECENu5toki9PM7AdPCVl/UZyRiPTZOPMPnh
	GIBhCoPqQNhJavWMpEMf2aWMeoso6iF4t0FKDN5EiclTM7Ikvum05R5T8n33zq2f
	Wh3k95d6MBPa3kKH7PRaDrs6dCxxQWLliQ6EJ6F0wlSqViz5LYtogQ/Fguryr/El
	yphkFXlSvE0gHYnQsnUpOfhHmxLxEUIb5XiKoCbvVrzHnzfyKSB1TL+LzYyaTm2o
	S+kMyK3yPx+ZWGMOocX4n6P1LT7VExPOJfT1vOLEAb1Yqt0kIFkvzX13Hx6LkaG9
	M3gSQHxO2Rqc5W+3/+co7lZUVrjc4rXnY4/+s0YpLUGsf8JHPebORGBQqBkRfbBJ
	Rktty2nIIGfHMS1gXaffJ1hoA2ysgLYPjOspXmwCrtpcbXnA7x3i2ZrBOtOMAQxc
	kq9+XLc=
Message-ID: <3758bdc7-2eb3-4e42-845a-8ecb1103d4f1@prolan.hu>
Date: Wed, 26 Feb 2025 14:56:56 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Q] Frequency & duty cycle measurement?
To: Dipen Patel <dipenp@nvidia.com>, <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <timestamp@lists.linux.dev>
CC: William Breathitt Gray <wbg@kernel.org>, Jonathan Cameron
	<jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
References: <f2ec8a55-42ad-498a-b793-072444dcb92e@prolan.hu>
 <7b6505ca-6082-4644-be4d-6e1372c183b7@nvidia.com>
Content-Language: en-US, hu-HU
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <7b6505ca-6082-4644-be4d-6e1372c183b7@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D9485263756A

Hi,

On 2025. 02. 19. 23:32, Dipen Patel wrote:
> On 1/21/25 7:19 AM, Csókás Bence wrote:
>> he hardware is capable of taking a snapshot of the timer value into another
>> dedicated register pair (RA, RB) on the rising/falling edges, and a small
>> `devmem`-based userspace utility was created as a working PoC
> I am late to the party :) Seems above statement looks lot like what HTE
> subsystem is doing. Right now, only userspace path is through the gpiolib
> due to usage that time was limited to GPIOs. However, we can extend HTE to meet
> this scenario.

Yes, I had the same impression. But since there was already a driver for 
this block in the counter subsystem, it was easier to extend that to our 
use case.

> Thanks,
> Best Regards,
> Dipen Patel
> 

Bence


