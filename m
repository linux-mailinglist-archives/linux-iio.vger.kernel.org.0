Return-Path: <linux-iio+bounces-13381-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF469EE0DA
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 09:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A381882DBE
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 08:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D995020B7EA;
	Thu, 12 Dec 2024 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlWozK+c"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93823558BA;
	Thu, 12 Dec 2024 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990849; cv=none; b=fW2mrtHO43ghw7u6NP0lmTsG2q8CXemVl0AwFQ9sPaWrcJwd2n0C9k1Sz+4C/0BDQ2wpCc+Lw1uXp5uGz5/21iEFEu4sl/qi1dGz4z50fpROzdo8b85Kpg2YHmvyVUdvNWaszL9jFOMvoe2HS8xKgmXRftpBi3xQJSZgLwIvU8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990849; c=relaxed/simple;
	bh=bvmxcorHen4rPUu4gUVJQ57vn4Ri3EwuQEcpWR0m5RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxvDg9nOuwNR7KVlSb0cc0gmMmumXceEh/cmoMt541+MKqKNUtipALgeOeVFPTIwHrDTXbPE+skA5qJaCLekUNZz9C8n+RWvvc2GkF+dltIbSVpRSzBpCKLdzalbhRy5C4Hrm4HRbuCltAcGnDwQkrOJ0yidpI5hMcMReX7/0Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlWozK+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BF5C4CECE;
	Thu, 12 Dec 2024 08:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733990849;
	bh=bvmxcorHen4rPUu4gUVJQ57vn4Ri3EwuQEcpWR0m5RY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AlWozK+cpnXVLIbkjenkDHGPiuySwAWne3UWR000okZM/L0l5EYL2XY80rSLpzd0v
	 OQNWaLbVE+yE2FOGZZDi1le+tkPD+3X7k4dWf2lsc3fgvIC0RgHFcylfT6icxZP24q
	 tDmH92e4PJjQCSDtUgHsEDNm6B9J7KnCfe59lh4cDgUXYMxF0Bi16tMzr8kPvwfXRD
	 9fZ0BlafKUTGJeeKThbUzOBKo6gt5xduQnKVQUFXhGMrPuLUl4YyFDZmbAilesYwVL
	 wvujtvAPYW8g5AGf9C6J2UvV/uJpk+5QsU98kmz632NYuUTtCpertT5EjZ+qUR4d2B
	 A+I0e+Ol1t8pg==
Date: Thu, 12 Dec 2024 09:07:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	eraretuya@gmail.com
Subject: Re: [PATCH v6 2/7] iio: accel: adxl345: complete the list of defines
Message-ID: <ldsvh5heh6gkdljxvgovwl6ni55cudvqw2mihbrliw7dqanrnk@lwlg6irtvg4x>
References: <20241211230648.205806-1-l.rubusch@gmail.com>
 <20241211230648.205806-3-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211230648.205806-3-l.rubusch@gmail.com>

On Wed, Dec 11, 2024 at 11:06:43PM +0000, Lothar Rubusch wrote:
> Extend the list of constants. Keep them the header file for readability.
> The defines allow the implementation of events like watermark, single
> tap, double tap, freefall, etc.

We don't store constants just to store constants, so this commit does
not have reason to be separate. We store constants/defines only to
implement the driver. Merge these with the users... unless you want to
say there are no users of this at all, but then make it clear: move the
patch to the end.

Best regards,
Krzysztof


