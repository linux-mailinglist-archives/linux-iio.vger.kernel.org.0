Return-Path: <linux-iio+bounces-2596-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5618578EB
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 10:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21390B23B14
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 09:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C577E1BC26;
	Fri, 16 Feb 2024 09:35:22 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632AB1BC20
	for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708076122; cv=none; b=JTMPJ/4QgWv9qoF6/Kf0HWULnfiXytGY0MbB1bMwponk96L6lLukGkBCUFY5qpkatJ92Y51Gj6rVFIqOPE6iNLC+Uz+HpZ6c+E1o+0fYDepjOTrbxZNdlbc94gARA3NbnUztdktLuKD/KlHhIJwjo/5SuCQHVjBBUVR3wEW69e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708076122; c=relaxed/simple;
	bh=w7WrghoYSSf2WWhb3MSB6tSfDdwk65OtTc918M3qS+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3fldNGj9Dc3O/SwPS71TvBSiS0zjX/8AcmFhOkRYzbcNgyJmlcTWq9B99UW2uirrd1JHArODMdqRcxu8eeAI2ab+GTIzIsUAd9nkcoUZF8XfHQ2PTy/3LP9YTTrdwXsDybM7FX672SPGgOHz6a3WoxKzcAujqECKmcnA5gP9L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1raucj-00025s-6d; Fri, 16 Feb 2024 10:35:13 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1rauci-00135m-Bb; Fri, 16 Feb 2024 10:35:12 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1rauci-00BSgs-0r;
	Fri, 16 Feb 2024 10:35:12 +0100
Date: Fri, 16 Feb 2024 10:35:12 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: puranjay12@gmail.com, jic23@kernel.org, lars@metafoo.de,
	thomas.haemmerle@leica-geosystems.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] dt-bindings: iio: ti,tmp117: add vcc supply binding
Message-ID: <20240216093512.bgbxavzw5cxai2nr@pengutronix.de>
References: <20240215204746.1197619-1-m.felsch@pengutronix.de>
 <f42ebeb2-9ece-4e0d-b91d-4a0076fe7c8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f42ebeb2-9ece-4e0d-b91d-4a0076fe7c8f@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

On 24-02-16, Krzysztof Kozlowski wrote:
> On 15/02/2024 21:47, Marco Felsch wrote:
> > From: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
> > 
> > Add the binding to specify the vcc supply. We can't make it required
> > since this would break the backward compatibility.
> > 
> > Signed-off-by: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.

Sure, sorry I forgot you guys. I was runing the script but only on the
driver not on the dt-bindings, since I was sending this series directly
from my git-branch without running git-format-patch nor..

> Tools like b4 or scripts/get_maintainer.pl provide you proper list of

using b4 either.

> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline), work on fork of kernel
> (don't, instead use mainline) or you ignore some maintainers (really
> don't). Just use b4 and everything should be fine, although remember
> about `b4 prep --auto-to-cc` if you added new patches to the patchset.
> 
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time, thus I will skip this patch entirely till you follow
> the process allowing the patch to be tested.
> 
> Please kindly resend and include all necessary To/Cc entries.

Sure, I will do. Thank you for the response anyway.

Regards,
  Marco

> 
> 
> Best regards,
> Krzysztof
> 
> 

