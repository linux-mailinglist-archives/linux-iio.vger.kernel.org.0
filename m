Return-Path: <linux-iio+bounces-7751-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0FF9381F7
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 18:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D137DB20A4B
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 16:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0251512E1DD;
	Sat, 20 Jul 2024 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNwlGzhx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B540A1E489
	for <linux-iio@vger.kernel.org>; Sat, 20 Jul 2024 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721491375; cv=none; b=i9PzNLY/Uz0OWmfii78BEDpehIe3mXyIE/nI2WnkHikxJLPmViwX8Mdmli4jJinPu/98vwSAjdSfu3zGmLw1118dJURFpfF081l1p1SdkaFX77K23GVhUFts57E0nPZdWyFHCk0TSStO+ow7z5xFxCcAI+GBNxzcURy8QCMYFJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721491375; c=relaxed/simple;
	bh=L80JlVP/SXea/gYgCn5pZ2mzwD5RV72knMpIBYUH9Go=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rAuXBypoNDWxXH5IGI98uBSm2/HMZVa2z1RaKiRB0zosVSltCO4HOYrBHAIhThvw77Y4NnMoYubVTbJL97U8miRqqQ79cJnkRC/2Tg/Xea2gXf40r2R0clUK71ORPH+LwknZ+ZTSYmZAwTJambLQwku+DcDjCs3+Af6tQNiLDwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNwlGzhx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83CFC2BD10;
	Sat, 20 Jul 2024 16:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721491375;
	bh=L80JlVP/SXea/gYgCn5pZ2mzwD5RV72knMpIBYUH9Go=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mNwlGzhx8ysvirRgQlZWxkYrqG3jqBmJjFrpia4kBq7WmO3hgenqmF0CQ7ck7sHs+
	 PCFBKvSc3T3w56oTsf8+LJ3GZNY5qQswPMPB1bzpV8zb2msSN74eUEZ9LBNpOe3+n4
	 oSn1loiU43Vh8B5UTVUK1pHUP2KCaSAqJPyPf3SWKC1OOHvMVS16G1rP6UpI1hHppT
	 svCXfWzKfcnu38qoGgUS8XUo6GLQwQNenVyHxuuZ5tQktZEPyGGMACEA7tLluhDGS0
	 Bn6pijQmnuTFNofXDH5263+uqRVMNB+lLQHe0ZVGJnaD8TSSRipDp800rcPKLd4wwK
	 E9sSWwGfdpsLg==
Date: Sat, 20 Jul 2024 17:02:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, Song Qiang
 <songqiang1304521@gmail.com>
Subject: Re: [PATCH 04/22] iio: dummy: iio_simple_dummy_buffer: use
 iio_for_each_active_channel()
Message-ID: <20240720170247.72d84463@jic23-huawei>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-4-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
	<20240718-dev-iio-masklength-private2-v1-4-8e12cd042906@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 15:37:50 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> Use iio_for_each_active_channel() to iterate over active channels
> accessing '.masklength' so it can be annotated as __private when there are
> no more direct users of it.
Even without the __private bit the new code is nicer!
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Applied.

