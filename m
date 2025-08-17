Return-Path: <linux-iio+bounces-22867-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 431C9B2942C
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 18:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4191B2351A
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 16:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03202EB5DA;
	Sun, 17 Aug 2025 16:36:53 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148801F03EF
	for <linux-iio@vger.kernel.org>; Sun, 17 Aug 2025 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755448613; cv=none; b=tl/0PIV3acWp5mECIJpiwllKWCyCWrt/soovdj14Ags47S0cmY4bTXqHiclY1tGKbkQwdg2l+TEUSYGZbSIGnvFxNZMkKU+vK/zZqWfmA3wZ6uiz8VSw5Gm0hxWtXL5u8dDRAZGQoHRk6hbOxt21ttiJEvFUHIuPuj0EHVtGcqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755448613; c=relaxed/simple;
	bh=kKTeVOA30ebbMfH9jWj02AqS7/6J+KGrNNzWFTGk58I=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type; b=LmiZhK3LhbruMzRT3YZWnTh/EKOAyve2+OgEtPf4qnKQ9pZgSWuUYdW+EIpp5bgoDnzL93EDvImYREMSMtdvt7E+lgM07MYs7VMweXphPkWqoAsWo+dL2/8iy21A0cX1zUBgFicoWWSvsTg/aN1l+g3/qE7Wgx3knRQIriZlXRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glki-linux-iio@m.gmane-mx.org>)
	id 1ungNF-0006o4-1V
	for linux-iio@vger.kernel.org; Sun, 17 Aug 2025 18:36:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: linux-iio@vger.kernel.org
From: ASSI <Stromeko@nexgo.de>
Subject: Re: [bmp280 v1 3/6] iio: pressure: bmp280: implement sampling_frequency for BMx280
Date: Sun, 17 Aug 2025 18:36:43 +0200
Organization: Linux Private Site
Message-ID: <87tt25oqg4.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
	<20250803140802.36888-4-Achim.Gratz@Stromeko.DE>
	<CAHp75VfhzJrPU6E=potYqPDYMbimhOy7edw9U0MfKsYMYwo8Sw@mail.gmail.com>
	<874iunknar.fsf@Gerda.invalid> <20250810191117.37c26fa8@jic23-huawei>
	<877bzbf0ti.fsf@Gerda.invalid> <20250811204840.74b2be91@jic23-huawei>
	<87ldnonwpv.fsf@Gerda.invalid> <20250817161023.6b887db2@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:HUCXudlSQn7ZvTNFckhL/E337gw=

Jonathan Cameron writes:
> Sometimes these corner cases take a bit of arguing out. Thanks for
> your patience!

Just so you're not wondering why there isn't a v3, I could not work at
the code this weekend and will not be for the next two or three weeks
most likely as well.  I'll get back to it when I can shore up enough
time to work a few hours without interruption.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+


