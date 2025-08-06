Return-Path: <linux-iio+bounces-22349-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E26C8B1CB74
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 19:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9DF162048
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 17:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18B61990A7;
	Wed,  6 Aug 2025 17:54:12 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5093FE5F
	for <linux-iio@vger.kernel.org>; Wed,  6 Aug 2025 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754502852; cv=none; b=BYviwJIP3xVw8TmfIZeXoEDfWU0wGC2Ygwjm6k0qfveX/gjpnMK1Hjz/0IxbDOJR7skSzzAdB1cDHJT/7S7vFB9FRoshZRKTnn0kr3IVnpCUq+7Y+azpx6t8ksdOfOGivvDgVW9ToeyW+i9L7BW9Y6G4lsvXPXWyA4A/0/oO0I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754502852; c=relaxed/simple;
	bh=piAFKenTgE1Y9tjKLJ1HGoDXjUCXFzaUnJRtH0jvopY=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type; b=l61dyofCNLRlVRtw37rl7pH5XzNtM3L2isAxmys1U9ENSZ+JIus+/RPpJ75YZNXHnjOJx+wwWb1IP3S2fzhoI/LFIYcKYB+8w2278Od8slL6TE+P54EvcQccDr6ltSVIJsx3IfcPp3XJXTEw5NBaxPDfHZldxO7VKL5L9eHxeDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glki-linux-iio@m.gmane-mx.org>)
	id 1ujiKw-0005eI-D5
	for linux-iio@vger.kernel.org; Wed, 06 Aug 2025 19:54:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: linux-iio@vger.kernel.org
From: ASSI <Stromeko@nexgo.de>
Subject: Re: [bmp280 v1 1/6] iio: pressure: bmp280: correct meas_time_us calculation
Date: Wed, 06 Aug 2025 19:53:55 +0200
Organization: Linux Private Site
Message-ID: <87ectomj4c.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
	<20250803140802.36888-2-Achim.Gratz@Stromeko.DE>
	<20250806164625.0000217e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:+KjggOhWHYK+8t2T5DGpD+C24UA=

Jonathan Cameron writes:
> I'm not following this. Why are we now effectively adding MP280_MEAS_OFFSET
> that we weren't before whether or not oversampling is enabled?

Because that is a constant part of the actual measurement cycle that
happens entirely independent of any later measurements (whose individual
durations depend on the oversampling settings for the respective
channel).  The graphics early in the datasheet don't show explicitly
where in the cycle it happens (my conjecture is at the end when it has
to update the IIR filters and swap the registers), however section 9.1
in Appendix B is abundantly clear that it's there.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+


