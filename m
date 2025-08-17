Return-Path: <linux-iio+bounces-22878-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED75B2949B
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 19:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630C117FB4D
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 17:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8E73002DA;
	Sun, 17 Aug 2025 17:45:06 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5D620010A
	for <linux-iio@vger.kernel.org>; Sun, 17 Aug 2025 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755452705; cv=none; b=maQgmE01i1pCQL4H5LJTTWbhI8rHSIxqpwyfqy0woj9LT8A3gfMxnmfIYur+e6a/vFDCKugdXGgNzVKNpcb8enJXrete3MwHdSMDregdLmZ8OQS2YA3FlYbqSFQ/EvuONbnFpyy5q923gVrtxRqnG3FF/eaqDUyAW+xkyJwCItA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755452705; c=relaxed/simple;
	bh=Mq/f/m4erjki6P0RqkeTDI0FGUvsdT8T44KiqQ22r64=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type; b=U/iI33oBuF+mwbQIVUTinXeXbw3BWpJF7BRUXjqBVWPODUPc8pjl7UmZteZZhTc2pl3s/n/ZOMU37cyTa/4/93qNCUbeYJWymVH6bQHWB0d9EpIBrd/NssPqz9pKRVOwnGsNQqIfCL+bS7aCpqgoMt4IsI107qpdfD473Tj3eyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glki-linux-iio@m.gmane-mx.org>)
	id 1unhRG-0009X6-L2
	for linux-iio@vger.kernel.org; Sun, 17 Aug 2025 19:45:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: linux-iio@vger.kernel.org
From: ASSI <Stromeko@nexgo.de>
Subject: Re: [RFC PATCH v2 8/9] iio: pressure: bmp280: implement sampling_frequency calculation for BMx280
Date: Sun, 17 Aug 2025 19:40:49 +0200
Organization: Linux Private Site
Message-ID: <87ldnhonha.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250810185846.114355-1-Achim.Gratz@Stromeko.DE>
	<20250810185846.114355-9-Achim.Gratz@Stromeko.DE>
	<20250817180421.1d9edb28@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:4PzGk9ZVxcp8j2OzVXutkOtgud8=

Jonathan Cameron writes:
> This driver seems to have the infrastructure for providing available attributes
> but is it hooked up?  I can't find where info_mask_*_available is set for
> any of the channels.  Maybe I'm missing something, but if not would be
> good to fix that as part of your improvements.

I think not, there isn't any *_available sysfs files I can see.  Where
can I look up examples of how to enable these?


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+


