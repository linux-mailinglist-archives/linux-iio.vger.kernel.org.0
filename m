Return-Path: <linux-iio+bounces-26904-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F296FCAB74A
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 17:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E10B3301D64A
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 16:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE01C2FAC0E;
	Sun,  7 Dec 2025 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzLY0h2R"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9777423D7D2;
	Sun,  7 Dec 2025 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765123339; cv=none; b=Mj1+pTtENUj0iL/7e5LGcMiJGvgnE1rVpNFcAWy0RzhrR9akZ5YOimPjQHRNxLVLDXQLZCGpQD2G3FeOvFeuujO7HwCrZ75uXGlJ6Rbpqm+dRdAwdR18xYA9oJ040aqY8kF2gL6Tg7SpA6afuAYx07WJ6EI2Iyg9Ft3MaXiuce0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765123339; c=relaxed/simple;
	bh=u4aujdMQpcj4S3EunaQM4IZ9c2cFmOBiZFM3tT+Zib4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W4puBdm2BngFKEECPFD9ZL4TtDlU+n5NA+ArXP7x/7PQPuL80vqT7lM2Nz+jYk8YYwCEV/oxT42Q3G1ImMyne83bXZtQgFz+u2zKwVmFpFwQSP/nflbLJ4GXXXEV527DxOiWbFTrH+vxPCdcgnWBoZoerIcW0lMo8qtcbFFN09Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzLY0h2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D885CC4CEFB;
	Sun,  7 Dec 2025 16:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765123339;
	bh=u4aujdMQpcj4S3EunaQM4IZ9c2cFmOBiZFM3tT+Zib4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MzLY0h2RVUfDKM4AMVvUjgDprk5b04IzHi0g/jRjwEAVVbLBwJSeGlRA6UAd8kBlt
	 NM77gqSU8nqD91HJz3Ky707OOHHawUQMuCC8saIwxsESpCi9Crq8fSJEWl1LD3pffk
	 ajlh2VG93JmYiUmf0TtshG0B8n71DNY6TmcdtRWGes0NZatdsS4s+sxI0H2+2wiQI/
	 C2pxfV6FNbrq8Juk045Icn2obYInRG41F/vDyegKU6FXyYOASmKe9+Zoh8dOMM+fDt
	 FGWtEUPy9M4OT8Cx3SRQGjM2mbqRlWKTMv+3862hm/hVw6B+EPOm3Qvv+cl2TSFt32
	 N6XY9XFY/ADOg==
Date: Sun, 7 Dec 2025 16:02:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: andriy.shevchenko@intel.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: isl29018.c: replace sprintf with safer
 alternatives
Message-ID: <20251207160214.0de10c67@jic23-huawei>
In-Reply-To: <20251126204333.13547-1-tomasborquez13@gmail.com>
References: <aSdWZQmmvlvJr-Kn@smile.fi.intel.com>
	<20251126204333.13547-1-tomasborquez13@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 17:43:33 -0300
Tomas Borquez <tomasborquez13@gmail.com> wrote:

> Thanks for the review Andy!
> > sprintf()
> > "...sysfs_emit() and sysfs_emit_at()..."
> > 
> > alternatives
> > 
> > OR
> > 
> > "...sysfs_emit() or sysfs_emit_at()..."  
> 
> ...
> 
> > Forgot to update indentation.  
> 
> Updated both commit message and indentation in v3
Hi Tomas

I moaning a bit about this today as I have a very long
email backlog.  This comment belongs only in the changelog
of v3.  Sending a reply here just adds noise to the email
queue of reviewers. i.e. Don't reply to just say this.

Jonathan

> 
> Tomas


