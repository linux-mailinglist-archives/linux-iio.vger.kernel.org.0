Return-Path: <linux-iio+bounces-24545-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 444EEBA76CF
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 21:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04CD43B6292
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 19:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687CC1714B7;
	Sun, 28 Sep 2025 19:15:47 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456402EAE3
	for <linux-iio@vger.kernel.org>; Sun, 28 Sep 2025 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086947; cv=none; b=FV0Zkplirvy/M0C6//SWhku1dgsCQtbXpIafUd0YZLGhol8q0kZBrEnZNxw8Xfwm5Lm5kJsOk8A0ZTY/3tarppop5e9zJo4fiJVAPHi65TQiYS/dsO+uWKBsHJLYLldB1WYzWzYZMicQO72ixXjg4Ko6kj1o68myYGrLYzToIuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086947; c=relaxed/simple;
	bh=Ki0yrs6WggJ0opm7/CYQq5EOTG4NEy/epf+0ylCaj2Q=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type; b=PQGkSPniPB0RaW84KAn2ny376sdC9zXuPTK/tVFtSh6ElF6NWmvp1N6ogIfZWpgDrnyKWZhSCSY9gGpwDdCyXjZzZCwm0WPJZdNaHldBrIJeILIU/OIxamEwTfN8EIK85v0CTpDmpy/d6XaCGgl+S2cYCRwSEiGlrDoO64Fg6XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glki-linux-iio@m.gmane-mx.org>)
	id 1v2wn4-0009P9-Si
	for linux-iio@vger.kernel.org; Sun, 28 Sep 2025 21:10:34 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: linux-iio@vger.kernel.org
From: ASSI <Stromeko@nexgo.de>
Subject: Re: [RFC PATCH v3 1/1] iio: pressure: bmp280: test longer autosuspend (WIP)
Date: Sun, 28 Sep 2025 21:10:30 +0200
Organization: Linux Private Site
Message-ID: <87ldlymlzt.fsf@Gerda.invalid>
References: <20250928172637.37138-1-Achim.Gratz@Stromeko.DE>
	<20250928172637.37138-3-Achim.Gratz@Stromeko.DE>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:bmB87si8Fw85lgbn/LsMHhsOwag=


Please disregard, this should not have been sent with this subject and
is patch 9/9 in the series.

Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+



