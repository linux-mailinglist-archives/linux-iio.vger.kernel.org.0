Return-Path: <linux-iio+bounces-9832-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB64F989023
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 17:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3981F2176A
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 15:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C772837D;
	Sat, 28 Sep 2024 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeM37gAO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE3A524B4;
	Sat, 28 Sep 2024 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727538499; cv=none; b=g1sCax4VQIh2T0csyVsatmQupiILquuZGCno7evq64VvnGiJAn4xPyqk1HzOb4u33Xe9T7p4yJsaKNS5RQQ29xgf31/7ED4NthrVnSZnuYDG2H6TarJELZgfbEx8EEVgMYqW3TYS71udqrHR6APwl4RCOLxf+U7zmAMR5ApuVZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727538499; c=relaxed/simple;
	bh=4Bjt2j/XaJmmwJ70H5U/Bm0L+rWX1uHACIUJUN3Gv5s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdupReUtWr6S4MTNnBYJur7wUOZAiZbegRwbZLrN8fY/vZRTQkgESRou6Mjof0+xTmXWh0aIOVILVPQqbeongDy8oCRYGINHhsWltejMyBV55K2DaZkVXWlwct8ok8ESJH0Tjp2qDA0zzQGhMvUlt3YJPK2rWvO3xT4IwxcoYdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeM37gAO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E34C4CEC3;
	Sat, 28 Sep 2024 15:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727538498;
	bh=4Bjt2j/XaJmmwJ70H5U/Bm0L+rWX1uHACIUJUN3Gv5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CeM37gAOE5eBRKEAEqLyOSBlH3PlTF0v8hVmMmKT9Kwqkt37KK53tXEtVQepZ3hUt
	 exer0zieHzCjPARWfVuQUFNIn5SFqZ4CFpvad7zu6M/Xu/+vx2yWfcX5VyetzNIeAr
	 3ScIiHVx1kaswiPTX/hLi7e5afveG7eQqqdt7tlt+Dluie9Dt1D+5Us4BEXT7b6ct5
	 0B0YMjKALHR2qmJATageR5Hy2hwoyG0W02FJe+N9o1nnRT/VUs/Sct8q37YjA2RFBE
	 47eqbTDeBpfZlt5k2+T7CcnjQFlAAS+Go3M1DhDyalaaEpqroesyLFZhTo8JONaNHm
	 j/WKSfkVrCfiQ==
Date: Sat, 28 Sep 2024 16:48:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: ltr390: Replaced mask values with GENMASK()
Message-ID: <20240928164812.65e64f1c@jic23-huawei>
In-Reply-To: <20240914182239.507953-1-abhashkumarjha123@gmail.com>
References: <20240914182239.507953-1-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Sep 2024 23:52:39 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> Changed the hardcoded mask values for GAIN_MASK and INT_TIME_MASK to use
> GENMASK() instead.
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
Applied.
Thanks,
J

