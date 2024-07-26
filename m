Return-Path: <linux-iio+bounces-7936-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AA493D2DC
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 14:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5D5FB21175
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 12:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA404A3D;
	Fri, 26 Jul 2024 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KPVRfmde"
X-Original-To: linux-iio@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3909317B42C
	for <linux-iio@vger.kernel.org>; Fri, 26 Jul 2024 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996093; cv=none; b=IT4FHf738sujfyaI3qSVcwTx/ZFfTJIkly9anPaRmVv0Jxy7XmxLP1260ZxbJpKTOBSGFb8pYOi7yA8yHOapFIk15V8A+BSOhQ2BbGZHsko7vaPRETB/02OHiaJIhqp6anY14soOkso3uDT+Y/xcEM+VeW++R16ry9BJRQviwFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996093; c=relaxed/simple;
	bh=Ih1skgJfXjkAaCS/GgCj8XhbygFgoQKIHW26fy0AQlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AvLuNR/PO4uSejNACtxqa1zhxebAQRTKIW+gSmGvxF2Ty1oyJBxoANlAkOm1U9B+cPDhJR3ioJx2+Pma2to0J2t45ABB+Sq+XutMHrP0yW1UmeHnr7Vf62ccM7jPQo3r9OeHyyPmvmrzc4aQOgaPaKnEtzJpTSGUKwRqxArzmQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KPVRfmde; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721996090;
	bh=Ih1skgJfXjkAaCS/GgCj8XhbygFgoQKIHW26fy0AQlU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KPVRfmdeBFA0Sgs6oFIaghiuJ7WyrueJZRGqLydFr2PZQSq9GPdhPnXlK0esvDVba
	 NP8BU46mI74/6NBuKyJP4dcqaTFdYA1WME8RLZesLDd3TnVnhf+etN7DQtpnE4k8PP
	 xjgTHUPmNdAc89r2w+bioF/NphubLYnnjFf8VApXuua9v2YjRgHIM4A4OANzFdGt61
	 F9Cbm176gFa6hn/f7qsDONN0SS8PldbyCqyBB/DOeorMPQixrYsaVOIHrXR9RU1/jf
	 Zem3cKWxywbmqV9nrvBZBR1nIydDJSePLFheUlJ3RBN39XsAZakClDxRshSLVEHTjj
	 IkEJ1Gn7Lj8BA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DF32C37804C6;
	Fri, 26 Jul 2024 12:14:48 +0000 (UTC)
Message-ID: <cc5d9bdb-445d-44f0-9ca9-76e8a5b1818c@collabora.com>
Date: Fri, 26 Jul 2024 14:14:47 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/23] iio: adc: mt6360-adc: make use of
 iio_for_each_active_channel()
To: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Ramona Gradinariu <ramona.gradinariu@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Kent Gustavsson <kent@minoris.se>, Matthias Brugger
 <matthias.bgg@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, Haibo Chen <haibo.chen@nxp.com>,
 Michal Simek <michal.simek@amd.com>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240726-dev-iio-masklength-private3-v1-0-82913fc0fb87@analog.com>
 <20240726-dev-iio-masklength-private3-v1-5-82913fc0fb87@analog.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240726-dev-iio-masklength-private3-v1-5-82913fc0fb87@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/07/24 10:22, Nuno Sa via B4 Relay ha scritto:
> From: Nuno Sa <nuno.sa@analog.com>
> 
> Use iio_for_each_active_channel() to iterate over active channels
> accessing '.masklength' so it can be annotated as __private when there are
> no more direct users of it.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



