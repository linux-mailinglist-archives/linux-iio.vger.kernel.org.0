Return-Path: <linux-iio+bounces-22292-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBC6B1A8A2
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 19:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85EF623F66
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 17:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9A628B514;
	Mon,  4 Aug 2025 17:29:57 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C621C5489
	for <linux-iio@vger.kernel.org>; Mon,  4 Aug 2025 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754328597; cv=none; b=SJ10R/HYaNBa5JeJNaIDLZmdPAtu6cTLTof+2QdoRMRbIBotev0KbW+4QHqWDjahUjb/p89CA+kdyYjf7O0oZhh37KBg9vtYV20OuqRU70nwpOXFjxznyJhbVtwa3je1XSUpCxKKEp+UV+FiQa2vkq+EJFn06B6q0/mrtfHXSlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754328597; c=relaxed/simple;
	bh=pdngAH5l5+wsEBqu9+3wb8tE774yiL0MfQJQzcNEveQ=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type; b=ovCS29OVvGfZeWIIrCwCXHoFQfycpQsyp1TixPdQTaTqFXEr458jnKMOvSzzPajHmzKcUcVwxYB4iN3SBF0WtM9g+Hqx/lHuM3XW2sfhxWDHrsKgx7Jr0BS8ezv0F81vxeiGm5MIrPUfCsUHyJYPhrRDdsRu4BcWugvwkXsRWek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glki-linux-iio@m.gmane-mx.org>)
	id 1uiz0S-0008G9-OD
	for linux-iio@vger.kernel.org; Mon, 04 Aug 2025 19:29:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: linux-iio@vger.kernel.org
From: ASSI <Stromeko@nexgo.de>
Subject: Re: [bmp280 v1 3/6] iio: pressure: bmp280: implement sampling_frequency for BMx280
Date: Mon, 04 Aug 2025 19:29:48 +0200
Organization: Linux Private Site
Message-ID: <874iunknar.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
	<20250803140802.36888-4-Achim.Gratz@Stromeko.DE>
	<CAHp75VfhzJrPU6E=potYqPDYMbimhOy7edw9U0MfKsYMYwo8Sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:uUKr1oD68H2O1ZwqfQi3XW02+lo=

Andy Shevchenko writes:
>> +       .sampling_freq_default = BMP280_ODR_0HZ, /* MODE_FORCED */
>
> Why is this comment repeated all over the code? Any justification why
> it's so important, please?

It's just a reminder that this value isn't actually used by the driver
to do what it says in the datasheet, but instead for effecting the
switching between MODE_FORCED and MODE_NORMAL.  If you'd really want to
run the sensor with no standby between measurements there'd need to be
an extra invalid value (like -1), that then would need to be guarded
everywhere against getting used as an array index.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

SD adaptation for Waldorf rackAttack V1.04R1:
http://Synth.Stromeko.net/Downloads.html#WaldorfSDada


