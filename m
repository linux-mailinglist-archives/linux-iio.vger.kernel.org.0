Return-Path: <linux-iio+bounces-22879-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF9EB2949E
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 19:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C0965E39F2
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 17:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D3E28750D;
	Sun, 17 Aug 2025 17:50:07 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005982AD02
	for <linux-iio@vger.kernel.org>; Sun, 17 Aug 2025 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755453007; cv=none; b=eS0NThlSAxS2JKVZiISxprBGfUTUEGdFayBzEpa017FUKPut/ZwLF0yhW1h86QZbbcIuy7JdUTDnYkS1eKZKucdBLdJ1nee+feP8LUE3cXV+YEXMTj/PrcVNkO+2kRPap47GZVXW+u2AM3gtHSZl0ZhHTK3QS3xS8VPLGPgf5pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755453007; c=relaxed/simple;
	bh=aASwmL9PKAVFCrgbi1HcIjhA7XAwS+zE6iWuVqNXhU8=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type; b=scR2OdLUwO4vVFmjUX4PBWNZFPZAsSu396MHWeFtCZzFWtqupe/SvcK+NoMKtqKURZ/tZ19I1YB87EsOPnTVdlAc5pynKBHWiBJTC9KHLE3PmEfHZKQjGmhiio0kU5fk1sHohr1mNguTqXHtC/WBGqqTaYrWdOTpuSOCb3G+u7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glki-linux-iio@m.gmane-mx.org>)
	id 1unhW6-0004ez-Eg
	for linux-iio@vger.kernel.org; Sun, 17 Aug 2025 19:50:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: linux-iio@vger.kernel.org
From: ASSI <Stromeko@nexgo.de>
Subject: Re: [RFC PATCH v2 9/9] iio: pressure: bmp280: test longer autosuspend (WIP)
Date: Sun, 17 Aug 2025 19:44:59 +0200
Organization: Linux Private Site
Message-ID: <87h5y5onac.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250810185846.114355-1-Achim.Gratz@Stromeko.DE>
	<20250810185846.114355-10-Achim.Gratz@Stromeko.DE>
	<20250817180545.11a2bbee@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:f3yu5NeGZxTnYkQHuI0mhh2zANQ=

Jonathan Cameron writes:
> On Sun, 10 Aug 2025 20:58:46 +0200
> Achim Gratz <Achim.Gratz@Stromeko.DE> wrote:
>
>> Autosuspend delay should be configurable from sysfs via the power
>> attributes, but that is apparently not working for me.  Since the
>> standard value for autosuspend_delay is shorter than my typical
>> measurement period and a suspend/resume incurs both additional latency
>> and stronger tailing on the acquisition time, monkey-patch a 2s value
>> in until I can figure out how to do this properly.
>> 
>> Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
>
> Currently delay seems very short anyway, so I wouldn't mind increasing
> it like you have here.

Yes, I think something like that would be a better default value, but
I'd still like to figure out why I cannot actually control this with the
sysfs power/ attributes that are present.  Somehow it seems that this
support is only halfway enabled and while that triggeres the presence of
the control files, the actual handling is not functional yet.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+


