Return-Path: <linux-iio+bounces-18697-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CADEA9DB79
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 16:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E3FD7B4D20
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 14:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A44C1F181F;
	Sat, 26 Apr 2025 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvqm9uPY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295731519B4
	for <linux-iio@vger.kernel.org>; Sat, 26 Apr 2025 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745677994; cv=none; b=PXqzLpUxWkDDRLYIi8S5VPG3M+TxODePaaLoaYDZDNsgce355G3bspPGFC8YDzmGxE+j9pRVoPinUgiTImD5XY8ZEzlrStZrNfxQ1+l0BoekYsLO5ljH3EtYocy+wUSB0vQvRANQwzG8sNmCnELfxSOuOZ4FQ2BMhkq4HGcblaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745677994; c=relaxed/simple;
	bh=h+UQTG+RhJJoJXac2b/HjpOln7qVcIdWhLQCfgOlih8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7/LUZi0jgtk/s2Y2Rt5aDlZw/l47mhA9XOGFjPHjpFhz+QuYcPj/FjrkXnWEdqSZ2G4qeCDEbiZ+PM42yRk2Nv9PbDbeVPQcbzRzTxgqG7l/zbVTADVJntTOLfe7seLq6ZxpfGv+wIyPtGO9GdKMFgIEr8ysp+XwIa6JbDOhYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvqm9uPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF21C4CEE2;
	Sat, 26 Apr 2025 14:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745677993;
	bh=h+UQTG+RhJJoJXac2b/HjpOln7qVcIdWhLQCfgOlih8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nvqm9uPY67A7xUzNVYGyZoHZ3nqtd5MxjedODDox18gmNKhkw7H9KRFbYOLlH3ZOp
	 8vehmSIqE6zhM1J43pvrx/7hQNJisnM+ipsLT0xa62oPYXQP6EvAd9hU4H96vokMmf
	 7FYMieqG0AcEEAaCx6eb9LgB91Yx/PCnurq7vxhwD6uscwONS+CVKNl3itruuXJ1BX
	 IIXj58QuG+exf4ZgIV1KaVdpwNehH+zWgxsuM44eMfy7QeNnjFS8sptNxAk+B//g7v
	 p41EL7XqMzZ1YucYtlHOx+m/w8H/WbDPacGAij7nEGQVoOTV3fYadiWMmksZNXKILK
	 R3a3rR1+CZs4A==
Date: Sat, 26 Apr 2025 15:33:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Vaz <gustavo.vaz@usp.br>
Cc: linux-iio@vger.kernel.org, franciscolealhenriques@usp.br
Subject: Re: [PATCH v1] iio: accel: kxcjk-1013: Deduplicate setup interrupt
 functions
Message-ID: <20250426153307.59689da0@jic23-huawei>
In-Reply-To: <20250423204631.16460-1-gustavo.vaz@usp.br>
References: <20250423204631.16460-1-gustavo.vaz@usp.br>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 17:46:31 -0300
Gustavo Vaz <gustavo.vaz@usp.br> wrote:

> The contents of kxcjk1013_setup_any_motion_interrupt and
> kxcj1013_setup_new_data_interrupt are very similar. Deduplicate these
> functions by introducing a generic function named
> kxcjk1013_setup_interrupt that has an additional flag indicating if
> it's a new data interrupt.
> 
> Signed-off-by: Gustavo Vaz <gustavo.vaz@usp.br>
> Co-developed-by: Francisco Henriques <franciscolealhenriques@usp.br>
> Signed-off-by: Francisco Henriques <franciscolealhenriques@usp.br>
Seems fine to me.

Applied to the togreg branch of iio.git.

Thanks,

Jonathan

