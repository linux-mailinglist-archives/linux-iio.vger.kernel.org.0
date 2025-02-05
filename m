Return-Path: <linux-iio+bounces-15027-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5F7A28604
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 09:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7FA188742A
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 08:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CAF219A6E;
	Wed,  5 Feb 2025 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="THZbnIV/"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3822131E2D;
	Wed,  5 Feb 2025 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738745849; cv=none; b=QdNJECYgM9GJzH91SpUGVzCniMoFIHSH5rS9v7AB6yVP1Ql2beKmupiX3UpOujy6xo8ED8sRGyOEeIVXYBslK0k5KwKv5iEfBPZLuOSHodG2pZr2oTbibNRKrL/qhet4OomWjGK7kX6tIKQkFoSlMBrzlYsuq9zGLjxu3Aj0uh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738745849; c=relaxed/simple;
	bh=tbAHO1ksqiKdFkCyBmXKxrwc88uErxSVVEVwNGTKJ4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=izNkURCjoLHSnBPSCe3CbrGyQq1cQacYZoU37QLjXNzUzo7lx/sSEnwEobrOAIW6WhfYpBothc86L2plvW5o60VIluuw5KVO89lsitCS3vKsgO+XwWxfnuDq6qJuGL721jW61WoXEjxVptjhpE91dy1GoNjqXn9TBz7d5290294=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=THZbnIV/; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 433F5A0031;
	Wed,  5 Feb 2025 09:57:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=Q6Wy/9vN9ADDZZX+mcOi
	wXk9RSq7RXtiVJ2ibQ0mqWg=; b=THZbnIV/ocLEg79CbULPv7eUwBqcR78AHGpK
	vP+KbnpXW60Ouaj6hZBYYK9/uDmlwOBMt7FnsbA7U+/+jCzyuDAFH/UjMAzWvJj0
	2DOd9MndfiOZU8MBpTY65qgvSAECEfN53GpUWF5Mx57ljwPA+XtHxAyCbWZFsTpy
	tR7irtAxI13xYYipAuHYuEfWlaIhzpVtq9AitZJ0W38tlPbbupQoclHMU2ogInfl
	D6T4x9MjOyq7xOQd58rGKBrdojt52OExX/DK6i2t1NUVGc9189hKZ1hCPiJsbVPE
	HRXGvZRAJao06F4d9W40YTb8fsRo5KfcO6p2S+Y6oLuNd6HaFvrqOgcNv4E334vG
	k7sz/drIHYFsSbJRlqXt2/p7TxxxoscQ4N9EjZloedwhqVVuPeAViHQmtbL/9agN
	zYBBmMKCVS1yjRFWcQMytK5MxCjYY+vm5DN9ZwkWP5U21drz3UB9KxUAbIc3new9
	SmLaPKjpecLFHXcaKS5g8edY7d7agRIbur/Q+F5S4lbYXNpKjOqz1Jrlq3W5YriG
	7uJWnFptv3NAoIPAC/umt4OGOFSuVAbh3WtOi6P+Jnv5bV/6VioJA78DGemd+i5I
	NgMGSRpN2uXLPLCVBiSz5Unmc0h/3itlit4nAxaCUmaGJ0X4dkMomEMo4JRMvWF+
	drW7/Kw=
Message-ID: <7b581014-a351-4077-8832-d3d347b4fdb5@prolan.hu>
Date: Wed, 5 Feb 2025 09:57:15 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] counter: microchip-tcb-capture: Add capture
 extensions for registers RA-RC
To: William Breathitt Gray <wbg@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Kamel Bouhara <kamel.bouhara@bootlin.com>
References: <20250203162955.102559-1-csokas.bence@prolan.hu>
 <20250203162955.102559-2-csokas.bence@prolan.hu> <Z6KsrhUYoYF8n10J@ishi>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <Z6KsrhUYoYF8n10J@ishi>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852667264

Hi,

On 2025. 02. 05. 1:11, William Breathitt Gray wrote:
> On Mon, Feb 03, 2025 at 05:29:53PM +0100, Bence Csókás wrote:
>> TCB hardware is capable of capturing the timer value to registers RA and
>> RB. On top, it is capable of triggering on compare against a third
>> register, RC. Add these registers as extensions.
>>
>> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
> 
> What is the difference between RA and RB (your code looks like they
> represent two distinct event channels, so I want to confirm)? Is RC a
> threshold value set by the user, or is it another captured timer value?
> The capture extension represents Count value specifically, so I want to
> make sure we're using the right extension for these components.

RA, RB and RC are three R/W-able "general purpose" hardware registers. 
The HW additionally has the following capabilities:
* in PWM mode (not used by this driver), send an interrupt on compare to 
RA/B/C, and/or change output signals
* in Counter Capture mode (used here):
   * trigger interrupt on RC compare only
   * on external trigger rising/falling edge, sample Counter Value 
Register (CV) to RA/RB, optionally send an interrupt of this change
   * stop counting after sampling to RB
All of this is enable-able of course.

So yes, RA and RB can be thought of two near-identical, separate 
channels. Since they both sample CV, it made sense to use 
COUNTER_EVENT_CAPTURE. RC is indeed set by the user.

Bence


