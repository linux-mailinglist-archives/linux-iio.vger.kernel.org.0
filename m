Return-Path: <linux-iio+bounces-21588-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8C4B02462
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 21:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84321CA74A3
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 19:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABEB1D618E;
	Fri, 11 Jul 2025 19:17:53 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F951C3306
	for <linux-iio@vger.kernel.org>; Fri, 11 Jul 2025 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261473; cv=none; b=ALYRSdznBlrkEy4kgoG3ZkDIhCm3NNiUsUrO0UV+vy1j39ZKvhaOOllZPHJC7I3zxzUc+Ib7lfK7666ge2UeSm6wfQjRAGDhE8EYn18ygncEmWzQmiRqv9zRHLUJPYA8Gg+UfMEUes1WAxjnmEw02yz+7fA1Yhz+ltwwZ281tx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261473; c=relaxed/simple;
	bh=7Ybhs2IkY7N5Js947GHylESOZ+qfmemG168A3+JpvVg=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type; b=GpiFAgZl8M30CCNE6sQk9433KW5TAmFAahe7E+Pwq755dlXYRipDsW1T72nJ8roIOQVVVSaSJxLehCzN//Ii/TeikhfrlB2nsuEtOEW+GXRoAdFHshRIvV6fyKCNQFhCczrymHV9plAHolu2xQ/D5IB4d0fV4B5cWCUwWAK02dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glki-linux-iio@m.gmane-mx.org>)
	id 1uaJFd-0003qe-5N
	for linux-iio@vger.kernel.org; Fri, 11 Jul 2025 21:17:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: linux-iio@vger.kernel.org
From: ASSI <Stromeko@nexgo.de>
Subject: Re: [PATCH v9 1/4] iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
Date: Fri, 11 Jul 2025 21:17:36 +0200
Organization: Linux Private Site
Message-ID: <87a55azgdr.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20241017233022.238250-2-vassilisamir@gmail.com>
	<875xgfg0wz.fsf@Gerda.invalid>
	<c894cfda-a775-4598-ac3b-b3d35c6a84b3@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:gKG1zup6D3sVEff2ryCfesF6eBw=

David Lechner writes:
> Hopefully you can compile your own kernel and test this. If that fixes it
> we can turn it into a proper patch.

I've out-of-tree re-compiled the module with the patch applied, booted
into the kernel with secure boot / validation switched off, removed the
compiled-in module and did an insmod for the patched one.  It works and
I can read all values again most of the time at oversampling=1 and
consistently at oversampling=2 for all channels.

I'll try my suggestion of a tapered wait later, perhaps over the
weekend, now that I don't need to reboot to play around with the module
code.

Setting oversampling=1 on all three channels gets me a fuil acquisition
at ~33ms now (was ~28ms with the too short wait time), oversampling=2 is
at ~64ms.  I'll need to figure out how to enable and use the triggered
buffer to get that back to more reasonable times.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+


