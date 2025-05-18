Return-Path: <linux-iio+bounces-19637-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341C3ABB111
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 19:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C591516C031
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 17:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE22921C178;
	Sun, 18 May 2025 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfxFpS1D"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624AE21171B;
	Sun, 18 May 2025 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747588885; cv=none; b=CirQw+mJfbJ25NA8k0JJZqGPTA0uAUVirsoAMomgr285g34373qYBr7Baryx6OcG5S3eQ69SKQelwg20Z+PJhWz8Qu68xd759wEJJr4moo6I/WoodRuAQzVRceuWMGGf1FR/m5k1cQB97s1i613QyyHdhHjc2orvY56GExl8YLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747588885; c=relaxed/simple;
	bh=h/u6IGKs7rGETxZD5o+qZaIQ0JRIefm3abUdDsa7kBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YluTaP18GCIqMF8Hcj4g+ObWR3lzvFLdRN+4KY6k9OHcosCfzkhF5BmGGL8kFLR/Q2Ndqdxstiz4DRsZCxjW9E2fig43WbpvI0lT7vnS+se1mXAFfZsfsEHu3af5L8aOpbB4Jzu/zYodj7pc/iCsVlan5jMii+JYueK0nWH19as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfxFpS1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA87C4CEE7;
	Sun, 18 May 2025 17:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747588884;
	bh=h/u6IGKs7rGETxZD5o+qZaIQ0JRIefm3abUdDsa7kBk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WfxFpS1DmjpjC/9Pkrgjgl8k0lSzjkQI01OgoOXzWN3RlrGtDxh8sG6HBHqXqEpyt
	 5x6AVGNn94pJcnUXA33RyQGMFigAjYHVsVkMwYl9qix3J5uZ+adp6O6k/o2GdIDdNh
	 tnFJMosnAdF+szIVFyC7mITui8kQCqME6eODSGakV5eBzdHA0zgfWrHAtP/UnhoJac
	 QGl3iE4wfiHD71P68OA5BmVugpIwA5hnXWDOCpKa5N7+HolbJ73D7Kg9LludYJeYQy
	 nKbZdAVa5Ts9T7Wk8iHaADvZo3CyMIoZo9x5TS3iD2o2jr4G4cpvSK7L1a8uw02N05
	 BSH46d/IqIUmQ==
Date: Sun, 18 May 2025 18:21:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 10/10] Documetation: ABI: add sinc1 and sinc5+pf1
 filter
Message-ID: <20250518182118.77ab5112@jic23-huawei>
In-Reply-To: <20250516082630.8236-11-antoniu.miclaus@analog.com>
References: <20250516082630.8236-1-antoniu.miclaus@analog.com>
	<20250516082630.8236-11-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 May 2025 11:26:30 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add sinc1 and sinc5+pf1 filter types used for ad4080 device.
Typo in patch title.  I'll fix up.

