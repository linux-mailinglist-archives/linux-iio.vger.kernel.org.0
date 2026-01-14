Return-Path: <linux-iio+bounces-27784-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E98C8D1F977
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 16:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 587D43008767
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 15:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B50530EF7F;
	Wed, 14 Jan 2026 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ukCtw33U"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2832D661C
	for <linux-iio@vger.kernel.org>; Wed, 14 Jan 2026 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402932; cv=none; b=ZuAdQhI2iZ7ayGoG4kRf/2HJ40hf2i/csmJohT9S487KxlZWbzl/xebf+zfSX3aZZPkBhYDrkdBjo0wFBFlua3gGv3lcu8FB+jdGYBp97AJhbLf/Vm8at9hSqqEYLJfXDT0COGH2M0i7Fk0KO8ooJ5C56MgDirhEp05OhuNRNYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402932; c=relaxed/simple;
	bh=V4eeaEsurJitifohBqMuGeeBX+oz/GS571dPgXI/nZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6XWXIahhlRwJNcrQ62JsQyfCny73WnI0cOplSVIsMmjzagRDa3CSM7OjR/PLnhu+qmXUk8BKvn4+mkUQ3bCOSKX3xWThgM5JAaRJVHRijNPy5jqFl7KZQfC0pGpJl1KD/ZG5Pb9k4uT1OfHGozmW3s6g+BfGH/rJVcE0v6Pseo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ukCtw33U; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 87DD74E420D7;
	Wed, 14 Jan 2026 15:02:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5D5106074A;
	Wed, 14 Jan 2026 15:02:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5CB6610B68265;
	Wed, 14 Jan 2026 16:02:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768402928; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=53MKDbM/lHZYRLYvti2TS9tQU5PkFFr5A5TelP/W6vo=;
	b=ukCtw33Ul5eqOcgcZFnYy+JZ2VO0R6wSsPoBld6e+Q4n/5nhjGNn0XIpdIrzSvK7IMBVRq
	ZtjHLKvOsILoJSlcvLe9q9ShyzznSaglwvBVGV+CB3xmWPZ9pijwbg13+vwAInzKqBEjnz
	IWTofhftjzGa1m93RQcT8xEFvZP56/zb+dV/tNBw7XIf+2E31+ZvGLaQ+Ut0fzLloMDdx/
	TLJreFcsBzEb9Es2kf0McO13znOJfrh1GKm0O5gcjTsQnnf0ME5W86phWgdypK7t7c2Laf
	nkU5N09pdvTs0eS249b+fTTJ65zCYSDmbNw4FyJHkINGavGWxgGPsn3ZG4xiIA==
Date: Wed, 14 Jan 2026 16:02:06 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: jonathan.cameron@huawei.com, Frank Li <Frank.Li@nxp.com>
Cc: andriy.shevchenko@intel.com, carlos.song@nxp.com,
	fluturel.adrian@gmail.com, linux-i3c@lists.infradead.org,
	linux-iio@vger.kernel.org, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/1] i3c: Add stub functions when I3C support is disabled
Message-ID: <176840281753.1259180.16475027635174872850.b4-ty@bootlin.com>
References: <20251230145718.4088694-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230145718.4088694-1-Frank.Li@nxp.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 30 Dec 2025 09:57:18 -0500, Frank Li wrote:
> When I3C is disabled, unused functions are removed by the linker because
> the driver relies on regmap and no I3C devices are registered, so normal
> I3C paths are never called.
> 
> However, some drivers may still call low-level I3C transfer helpers.
> Provide stub implementations to avoid adding conditional ifdefs everywhere.
> 
> [...]

Applied, thanks!

[1/1] i3c: Add stub functions when I3C support is disabled
      https://git.kernel.org/i3c/c/8564f88df202

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

