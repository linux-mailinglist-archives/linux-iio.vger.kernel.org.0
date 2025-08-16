Return-Path: <linux-iio+bounces-22853-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C08F1B2901E
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 20:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490391B68A97
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 18:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D741FF1B5;
	Sat, 16 Aug 2025 18:42:51 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619A4317709
	for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 18:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755369771; cv=none; b=P/vU70DYwhEKiAd6H1YZZqsn49kNvXezYS/97f7SBfw666TwbquU3Tgfiz3z6KGlbkX6V/+sfzsOSie9Sog4OJnSOtdZP07OHaGAMF4BndpPjhQlj3SLPJDDE0488ryy0sDC3F4uxa/QFIX/whyaSB6/7rbUhaGwz+pMA/uTKTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755369771; c=relaxed/simple;
	bh=/hk2jMpuXcj3axf4dXiUFfumZAgs9fjEQkhPQ3QpDEY=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type; b=hl+GPvmxr6sUF/blpBLT2zMWbeEVEkNFprfyNEJETLd7lLUySbkKK2jo9gFTm8q3JRsXBkRNUDrkrmQ1hnZn25S+e4GTq7aIKZN8CVglKd0q8rk7+n2wYorzTlE0WAf4zJTMppLiL+8oygozOx/fU5GuBu3IQYcx135nKj1lxuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glki-linux-iio@m.gmane-mx.org>)
	id 1unLrS-0003eD-3I
	for linux-iio@vger.kernel.org; Sat, 16 Aug 2025 20:42:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: linux-iio@vger.kernel.org
From: ASSI <Stromeko@nexgo.de>
Subject: Re: [RFC PATCH v2 2/9] iio: pressure: bmp280: implement adaptive wait for BMx280 devices
Date: Sat, 16 Aug 2025 20:42:33 +0200
Organization: Linux Private Site
Message-ID: <87h5y7cdly.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250810185846.114355-1-Achim.Gratz@Stromeko.DE>
	<20250810185846.114355-3-Achim.Gratz@Stromeko.DE>
	<CAHp75VdYRRR8OOSSkC+x3ihcUVjvm5eDinsZhGq4bCr2FJKYrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:SsVq/NP7lK4vWNrjc4QvqxHMaR4=

Andy Shevchenko writes:
>> Suggested-by: Andy Shevchenko <andy@kernel.org>
>
> I'm not sure this tag may be used as I suggested implementation detail
> and not the idea behind the change as a whole.

OK, will remove this.

>> Tested-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
>
> This is confusing. Does it mean you haven't tested the patches without this tag?
> Note, it's a must to test by the author that's why the tag is
> _implied_, no need to make it explicit. I.o.w. author of the code is
> supposed to test that before sending (or comment that the code is
> untested in the cover letter and/or comment block of the email).

I intended it to mean that I actually tested the full range of
attributes, unlike what apparently happened with the previous version of
this function.  But I see what you mean, I'll take it out then.

> MIN() is for the constants, please change it to the proper macro.
> Also note that this is a C language and not LISP, i.e. remove unneeded
> parentheses.

Ack, the macro probably has enough argument sanitization so this is no
worry here.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+



