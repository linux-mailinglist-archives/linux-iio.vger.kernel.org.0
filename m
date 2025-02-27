Return-Path: <linux-iio+bounces-16126-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB63A4818A
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 15:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D87A57A9FA7
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 14:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B1D235359;
	Thu, 27 Feb 2025 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="S8Ppehat"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D45156C62;
	Thu, 27 Feb 2025 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666622; cv=none; b=cMeXLziGcUq8w9JxKGBXam3QIvL6hJ5yhkJuzr43dMYl3KC2VdFGv2WEqCj6QHKsYESzy3rWE1qE0mRKt86eZFWeq671S0HCr58uO4OJpfWlzz5rVAVehCwahZpPFOhx0/jMXoh2DjeL4ajkTZAhDavwaZnxjka+/yJZMdvLvnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666622; c=relaxed/simple;
	bh=ieucAQ/i0HJh1IYOkkqVgRRjfm1JSIor9mC+iMLbvBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tznv1eDx4po22O9bsROVzf2+ng81OWP+qp5FcBlQdFG8kcbD59y3Yj/ijNApoPMsnMIgMiUsTmX5DKLolxCv4h0oD9Kk6jN3J4Uo04uCp4K2JMYt9HL4VyOTHYXp6r/5B/LaBmk+MCvggAhnxv0Vn6MQ8fRUQvS+AE1Y6iFZxLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=S8Ppehat; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id A5C4DA0D06;
	Thu, 27 Feb 2025 15:30:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=guEftXoNJKwkM6Mgjwbl
	Uug0shsafyPZ98TWKbr7I9Q=; b=S8PpehatVRCtCf2eASlnS5FG74i8rgudDSzZ
	nz3fu+p7mkqrT6tV8O/LT108g8j9betYkx/Vct15GKoMnyYaxv6S6z1DZneRJRXh
	rJ+6ENF1WVLRwtN/Kk+pIWAazdVDr4cnR1u7PZ3mdtsSoot81dDzLkVh+m46vFhL
	X13dQaUTqqbjLtA29XDI/0w26IsQFta8o1B3TnIUk9q7/Vbkx3bTmb8Y6enAYsGe
	ItQ3AGz4cyUsh5GUYiMufs/Ftdp6JVZYYcCaZ/tebRZzx1c9ALb5DbE6C1xA9e5c
	nehWTKefs0drnbq93Pf3fax331pKQFAP4MS14UmtwplREBKSspKA9MaVTWYglo7B
	dbbOqePnO8awc3KzrwHKSAUKUGvJNj60CG4oR0m6bjMw7Cs82aoQGDEZ1kd0erU5
	HTaibORh+a9ANaEvN57dmu2qaDT3gKAOTcUXca3YFTT6EkmqsXZsN/liX4czvAn9
	d43y7evKZiARubXamnrbn649flDFYMVmrYnfXuN0egYSrw0WUt1rHCmgTuuYA4Ap
	qXZiXF2r2MhdYy7qBIxhPV4VUcAWSGVYCQD9PjvAUOPI2xbILfxBlGdz6I5/YyMw
	ys2b/LmeDkEOCWC98zXcgg8UEAJIOlZHvr/4M3kawN7+F1Z6HlACxhPxG/v3Yvps
	G99VtWQ=
Message-ID: <d1468825-aa4f-4f0b-aade-04bf61aa7c40@prolan.hu>
Date: Thu, 27 Feb 2025 15:30:16 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] counter: microchip-tcb-capture: Add capture
 extensions for registers RA-RC
To: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Kamel Bouhara <kamel.bouhara@bootlin.com>, William Breathitt Gray
	<wbg@kernel.org>
References: <20250227142751.61496-1-csokas.bence@prolan.hu>
 <20250227142751.61496-4-csokas.bence@prolan.hu>
Content-Language: en-US, hu-HU
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20250227142751.61496-4-csokas.bence@prolan.hu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852637760

Hi,

On 2025. 02. 27. 15:27, Bence Csókás wrote:
> TCB hardware is capable of capturing the timer value to registers RA and
> RB. On top, it is capable of triggering on compare against a third
> register, RC. Add these registers as extensions.
> 
> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
> ---
> 
> Notes:
>      Changes in v2:
>      * Add IRQs
>      Changes in v3:
>      * Move IRQs to previous patch
>      Changes in v4:
>      * Return the status of the regmap_*() operations
>      * Add names for the extension numbers

Uhh, I sent the wrong version of this patch... Will re-send it shortly...

Bence


