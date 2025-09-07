Return-Path: <linux-iio+bounces-23850-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80899B47AEF
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 13:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B81D3AB87D
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 11:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E72261B60;
	Sun,  7 Sep 2025 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNI3J4+e"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4968918FDAB;
	Sun,  7 Sep 2025 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757244311; cv=none; b=n6CfAWWZqtsGaHb5QRG9C/MFD+5zzqr/U9PAJuR6Ob8lV5ed5iisBzZ5BRicQM6RaCSNx4WBnwl0pc4DqfqEFMFHtARg4RilEM+tIThDGNv28Ll+ksjtPR3i06PxEre3fQm1OkAp+ebkdbLbe9gKz2QZNVlOzxQi6nYW+G9sy9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757244311; c=relaxed/simple;
	bh=ekVDRngXVS5ba6K8MKRdMT2eQXIh+YNQ4gYcLuGteZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3daqoGQZKkNySCyjbgjw5ZoS+DMxm3cZ2CWOUdqBOIypDNN6asYueza2Dh8/DM7Rh/hNt1vnjZ4A8E2dYpO/bSzAyPawBEHXQWe8uSK4IxgcAGHh3eu0Sjba1jXrd5l2EzDPh3a4CLQAucmpqLQfDLDSnD8ZYlxr8ypQGfTYJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNI3J4+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB819C4CEF0;
	Sun,  7 Sep 2025 11:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757244310;
	bh=ekVDRngXVS5ba6K8MKRdMT2eQXIh+YNQ4gYcLuGteZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jNI3J4+e/NjKDQ5PcCUQnPjTQV693RwQto1TAaTLrSa9En0aK5m7xYnsHzrZ6y4Ft
	 MsI8WylIFbKI225J9LLmv4zaNqcY/z7QT0EtapnoyGgCHvybKhDDRAPf8gq9jmM4uJ
	 jq9BAtDQRHr0RlG/cTM3Q6JW8Z+rdyx2fpsNr0+jEY0JHdiJ4Myre/bEjJUauvdg70
	 GXRFMufP/RwXzi+hca4Nfj7KmQ1AFA1OJqb5+bDL1FNE5uSREITsRWC49EJMvOyBI7
	 vXld8GJ4s7VxFc6bg16/94EwYTsOWgJ2KvRViF7CHTdGO++EeWKg+nAhMS0SUw0lBg
	 VrWTO52DwDEJg==
Date: Sun, 7 Sep 2025 12:25:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Marius Cristea <marius.cristea@microchip.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: PAC1934: Use devm_mutex_init()
Message-ID: <20250907122503.226b622a@jic23-huawei>
In-Reply-To: <f92033415f43aa02fe862cb952e62b6ded949056.1757239464.git.christophe.jaillet@wanadoo.fr>
References: <f92033415f43aa02fe862cb952e62b6ded949056.1757239464.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  7 Sep 2025 12:04:48 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Use devm_mutex_init() instead of hand-writing it.
> 
> This saves some LoC, improves readability and saves some space in the
> generated .o file.
> 
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   50985	  23992	    192	  75169	  125a1	drivers/iio/adc/pac1934.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   50654	  23920	    192	  74766	  1240e	drivers/iio/adc/pac1934.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Applied. Thanks,

