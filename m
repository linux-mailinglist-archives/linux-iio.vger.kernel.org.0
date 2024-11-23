Return-Path: <linux-iio+bounces-12523-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 789249D693A
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 14:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A89616168A
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 13:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63D2194A6C;
	Sat, 23 Nov 2024 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALLx14eK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADBB23098E;
	Sat, 23 Nov 2024 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732368080; cv=none; b=kbJ/rQHufj82f4cbCsEVUHVh6oisLPdhPxha9hy5qdVywCQCd1EoXJDTha10CmvYL/zHFwGGbC4L4Urdq8vsDcgTMs5rWDsGFKchNJY77z/o4ir41Iwj460b6xjP7o3xHc/Ok7t8vw/M3p4c5zSHt6OnmpuqONmysRQrSX8K9JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732368080; c=relaxed/simple;
	bh=FAmEvsYjY2eUZI2qbLtFctsmsTQ9p22GNJnHD1cqov0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aW+sW2033HrRrw5D0sER/rVrfppL3xzR329sXlwwifGMYMjkBGcqOmwYcN/6k+SeEs2NTz2VgrSIoPN1uZlcX6alrXCSQBDIGXaCUeYUbzC+ZLnSiIHBYb/VPsLOEhzKoVeQ9u+fFNEb39ebyG1n7J8Gv0AtNUgeIQxmwOd9ts0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALLx14eK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F13BC4CECD;
	Sat, 23 Nov 2024 13:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732368079;
	bh=FAmEvsYjY2eUZI2qbLtFctsmsTQ9p22GNJnHD1cqov0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ALLx14eKgm45LnSfqpDx44FXdbOm3W7BmgO8z2BZDaSUSFtk2yn1XDogDkh8NZKmB
	 ZDrMhw0K9Hva32AsPJheAHyrlN5D4D+A9Lt24dn5hAR1jQS9HnJu9y7PpkN+LlWaeb
	 fV2cUZ+cg9kktaXZjClG3VackhDLLVWbKMUvatrgPhd/+9GfKa8cFmdzxdy31ouAFa
	 qDfAYSnYU4YWwETPM5vkpID5ui+WnjhBBmAQSpVTUstkfheQOFpGRRTYD90Ddh+K9h
	 5KXioAMQH73hvwUbU2LBky9hOoEMo7yMibv+t+lGHsIp4w/zXcBksi0pWUdNbg2sYF
	 tcKY4I65whMYA==
Date: Sat, 23 Nov 2024 13:21:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Yasin Lee <yasin.lee.x@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, yasin.lee.x@outlook.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: tyhx,hx9023s: Add performance
 tuning configuration
Message-ID: <20241123132110.15570171@jic23-huawei>
In-Reply-To: <b59f6933-e1f1-49e9-be61-3e3b4323da87@gmail.com>
References: <20241017-add-performance-tuning-configuration-v3-0-e7289791f523@gmail.com>
	<20241017-add-performance-tuning-configuration-v3-1-e7289791f523@gmail.com>
	<20241020140638.127a9dbf@jic23-huawei>
	<b59f6933-e1f1-49e9-be61-3e3b4323da87@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 23:16:51 +0800
Yasin Lee <yasin.lee.x@gmail.com> wrote:

> On 10/20/24 21:06, Jonathan Cameron wrote:
> > On Thu, 17 Oct 2024 18:36:44 +0800
> > Yasin Lee <yasin.lee.x@gmail.com> wrote:
> >  
> >> When hardware design introduces significant sensor data noise,
> >> performance can be improved by adjusting register settings.  
> > Questions inline. Mostly around why these controls belong in DT.
> > What do they have to do with hardware / wiring etc rather than being
> > appropriate for userspace controls.
> >
> > So almost all are definite no to being suitable for device tree bindings.
> >
> > Jonathan
> >  
> Hi Jonathan,
> 
> Thank you for the suggestions in your recent email. Following your 
> advice, I discussed these configurations in detail with engineers from 
> the HX9023S supplier. Based on their feedback, these settings are not 
> intended to be exposed to end-users. Typically, these configurations are 
> adjusted during the DVT phase of the end product by the supplier to 
> optimize performance, after which they are finalized and not meant to be 
> modified dynamically at the user level.
> 
> Given this approach, it seems more appropriate to provide these settings 
> as part of a firmware file, allowing the configuration to be kept 
> internal and managed without user-level access. If this approach aligns 
> with your thoughts, I can prepare and submit a new patch focused on 
> firmware parsing and handling for these configurations.

Whilst I agree that a typical user may well not modify these settings
that doesn't necessarily make them suitable for control from the
Device Tree. Some may be but settings like ODR are about use case
not physical hardware. Average and OSR are normally a question of
trading off noise against data rate - that's policy not a fundamental
characteristic of the hardware. Filter controls are similar.

For other such as Dither, there may hardware configurations where it
doesn't need to be turned, only but does it do any harm? I'd be
somewhat surprised if the right thing to do there isn't to just hard
code it to turned on.

The enabling of dataready interrupt is entirely down to how the
device is being used, not the platform.

If these devices are being used in embedded platforms for a specific
purpose, then a simple udev rule or similar can configure the
defaults whilst still allowing them to be easily tweaked.
If you are dealing with standardized software it will already understand
many of the userspace ABI calls and have appropriate configuration files.

That is the appropriate level for such control, not device
tree.

If you have a strong case why a setting is never a policy decision
but rather a hard characteristic of the system, then that one may
be appropriate for DT.  Examples of this in the past have been things
like output voltage ranges for DACs because the hardware beyond
this device may only cope with some settings.

Jonathan



> 
> Thank you again for your valuable guidance, and I look forward to your 
> feedback.
> 
> Best regards,
> Yasin Lee
> 
> 


