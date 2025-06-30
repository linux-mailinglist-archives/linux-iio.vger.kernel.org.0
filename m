Return-Path: <linux-iio+bounces-21143-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A06AED5A0
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 09:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B4E3A4A43
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 07:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB3F222585;
	Mon, 30 Jun 2025 07:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aa0jE+HD"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B914C220F23;
	Mon, 30 Jun 2025 07:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751268611; cv=none; b=F2MkiDsPIPEzC+OGeMFUQo8Zlb/Zfbx/6iYZ1oqbqTT3wbxpSwfcTJQ4mVf/3279AmA7fg+WpOyW30v+f/4yC++rGmhsBIwN/P2KSXz8TqEQ/aDLXGx0BrJzIrgg29ROZNt9qzXwV+odQz8zKajCYo1Atlqw6YpjKTrTAzVUfuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751268611; c=relaxed/simple;
	bh=h3+BbSsRzFSbCWdeIHhuw9v25Gxev7MQWBIq8T/6F3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D8ZE+I1MA6ULzk7rLkAyWVOrmJJkC7CSVqjDyX9ppOwvojHx1EpmOEncPbikQVnRRDWOwSbNYdDJwesXV4049rFgA1OoN68qLSSdAnMWfSazDRvImulZnJgEvpbTuNeoxflkNlVGbqSi0/ky/ciBIkgoKqihz3HPS2LGGf5IGx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aa0jE+HD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751268607;
	bh=h3+BbSsRzFSbCWdeIHhuw9v25Gxev7MQWBIq8T/6F3k=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=aa0jE+HDyg7qAOkBA0l+7XGeqlGtp7ZiPTI9HCT25cmM/J6GI2hCOV0v7C3yzx2Mh
	 LktFuM+PfqaeYwQ5w5AlUmTsGn1gbfFJbW20fCLVTh0noO/PbrFR5EkTMtmvAsDv29
	 8SY3mOGCS6KysPRAmRCSRLredMiOf+A09CotRf2oZS3dVvOk9byVdoHBL5iqep81sj
	 pJAvSoXW+KrExpONnWGBf87BH1W7mkcGtnRSTniqmVZ6vxf0+kWoIXX4ZxAhcT7HCP
	 r6y03zs6ta3j10t8n2mn1SkkAvxFtjNdUOqisLPQ1Oni8flReaK41SSWGE2kOal/uJ
	 oMlQNW1iQ+gWQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D461217E0B0D;
	Mon, 30 Jun 2025 09:30:06 +0200 (CEST)
Message-ID: <ef28bb5d-8d5b-4505-8b00-56c9e5abd90d@collabora.com>
Date: Mon, 30 Jun 2025 09:30:06 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dt-bindings: iio: adc: Add support for MT7981
To: Aleksander Jan Bajkowski <olek2@wp.pl>, rafael@kernel.org,
 daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, zhiyong.tao@mediatek.com, linux-pm@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250628223837.848244-1-olek2@wp.pl>
 <20250628223837.848244-4-olek2@wp.pl>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250628223837.848244-4-olek2@wp.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/06/25 00:38, Aleksander Jan Bajkowski ha scritto:
> The temperature sensor in the MT7981 is same as in the MT7986.
> Add compatible string for mt7981.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



