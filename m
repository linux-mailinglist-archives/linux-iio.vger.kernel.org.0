Return-Path: <linux-iio+bounces-24729-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E71BEBB906F
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 18:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91DF04E5640
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 16:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D916728136B;
	Sat,  4 Oct 2025 16:59:53 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF5B2741B6
	for <linux-iio@vger.kernel.org>; Sat,  4 Oct 2025 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759597193; cv=none; b=Fn5RJvL9i3qdmdkRjx88vVPV8hxiGb+GjrBk9xb7N7yTQNspFFpxDxFodGVX7z3TzD4VwJxYQPChHTGhuIrnbrLWpHv6vuaAXwPBHsFLfSWcetolWE4SaOv4Q1Q09okpo3UWCda7R/SHPVbi44VofHal5Vnt7/Fc3WSEy4NswyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759597193; c=relaxed/simple;
	bh=UQ09xPoj09OlXi1JeNuLZ+gvI46oZlENnfgWzdHtFD4=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type; b=bLmK6rQNrvZnFU3qERQ3bF6vXfGpdDSMCjJQ718ju7eK7PWlWDaBHMuz9xHVRSsh9Zv/2WKWzUo97iOKZVPzhzJjWyonyHgQQJIiwaDS3QwrpIu2TcStDPKiYIVv5ap+Dxrc0tCD1Pvf+0lQ24BkRpfum8ZUafOO5rKMGtOEi8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glki-linux-iio@m.gmane-mx.org>)
	id 1v55bi-00097B-J1
	for linux-iio@vger.kernel.org; Sat, 04 Oct 2025 18:59:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: linux-iio@vger.kernel.org
From: ASSI <Stromeko@nexgo.de>
Subject: Re: [RFC PATCH v3 0/9] Fixes and enhancements for the bmp280 driver
Date: Sat, 04 Oct 2025 18:59:36 +0200
Organization: Linux Private Site
Message-ID: <87frby4n7r.fsf@Gerda.invalid>
References: <20250928172637.37138-1-Achim.Gratz@Stromeko.DE>
	<20251004160721.4c6485cb@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:kpO+hrBCavw13kp7wj1z7snP4p0=

Jonathan Cameron writes:
> A small process related question.  Why is this an RFC?

I've been fixing up the driver on my end so I could update the kernel
again past v6.12 (I'm on 6.17 now, which has revealed some more issues
with the autosuspend), but it turns out that this driver has more than
one problem and I wasn't sure if they were all going to get fixed.  I
think that's still an open question based on the feedback so far.

> I'd typically expect an RFC to have a cover letter with some open questions
> or another statement of why the author wants comments rather than the
> code to be merged.

Yeah, I guess I could have broken it up into more pieces and send them
separately, but then on the other hand I think that would have obscured
some of the issues that need discussion.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

DIY Stuff:
http://Synth.Stromeko.net/DIY.html


