Return-Path: <linux-iio+bounces-22535-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC6EB1FBD8
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 21:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF423B8649
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 19:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8C5205AB6;
	Sun, 10 Aug 2025 19:12:36 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB9B3C26
	for <linux-iio@vger.kernel.org>; Sun, 10 Aug 2025 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754853155; cv=none; b=hnng8bg4IaCr2opETdW8JWEFdsGiHUpGXSFctkJSSGLJFLAn1JMEyYjVsF/AZ7Tw/CHs2lk0+xPQfeUbGGE8a2FMM3iLWk/bueV0X9ZICIZHXE1Kw8jiUw3lREI6xoEdPZby/0qneuQP1/+d94ZM9xpr7jPfNfog1TR9Mgwq80Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754853155; c=relaxed/simple;
	bh=y0l5RLak/rs2RzLebBMA6lYVkl/yy35FZsC9nOkX55k=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type; b=kJ7MthVE5gCgYTM1yehJJdMmXs6VcfILjObkwGJRMvRG8rvp/eSyahzWqHCVgZ1b9ovVjwku0oxfpNN7Vl4UxCdHojr99xzJmrrG78i0wfyRDhdHjdy1zhVqumwFkGNEAhaqKQKwZVqEw4rcrUDdOC7b22OBJ9gsywo032QA4TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glki-linux-iio@m.gmane-mx.org>)
	id 1ulBT5-0003Zy-2X
	for linux-iio@vger.kernel.org; Sun, 10 Aug 2025 21:12:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: linux-iio@vger.kernel.org
From: ASSI <Stromeko@nexgo.de>
Subject: Re: [bmp280 v1 3/6] iio: pressure: bmp280: implement sampling_frequency for BMx280
Date: Sun, 10 Aug 2025 21:12:25 +0200
Organization: Linux Private Site
Message-ID: <877bzbf0ti.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
	<20250803140802.36888-4-Achim.Gratz@Stromeko.DE>
	<CAHp75VfhzJrPU6E=potYqPDYMbimhOy7edw9U0MfKsYMYwo8Sw@mail.gmail.com>
	<874iunknar.fsf@Gerda.invalid> <20250810191117.37c26fa8@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:hezk+QHhNq4Nh8Mki/O+dgFjqsY=

Jonathan Cameron writes:
> Call it BMP280_ODR_MODE_FORCED rather than making it 0HZ related?
> Using the value 0 for the sysfs interface doesn't make much sense though.

Technically 0Hz is correct, though:  it dosn't cycle at all until we
tell it to do a single measurement.

> Even if it is a pain to work out, we should estimate what it means to
> use force mode wrt to how fast a single sample can be obtain.

MODE_FORCED just doesn't work well ffor devices that do mukltiple
measurements at once that then need to be read one by one.  At least not
by using the sysfs read request as the trigger for the measurement,
which is what the earlier patch did that went into v6.13

> It may be that is such that we don't bother with the other slow sampling
> frequency modes if they are slower as they aren't useful vs only reading
> when we want to.

The way these devices work is that you can read the result of the
last measurement as often as you want and in any order, even while
there's another measurement is in progress; and you can chose to have
free-running measurements or host triggered ones.  It's the current sysfs
implementation that enforces a rigidity that wasn't there before the
driver was changed to make the device sleep between measurements.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+


