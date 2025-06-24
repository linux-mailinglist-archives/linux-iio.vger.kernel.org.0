Return-Path: <linux-iio+bounces-20946-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D59AE6A7D
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 17:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07F8169166
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 15:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B102E9ECB;
	Tue, 24 Jun 2025 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b="FtptMFis"
X-Original-To: linux-iio@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD5B2D8796;
	Tue, 24 Jun 2025 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750777708; cv=pass; b=CJN11n6P7gBHPpOp3jLlF2CZ8TEw7HFoJWeL8o4ME5rsetxTsKk+q1XoAA1IaOXAKKS+PYFXOlCWDW3pqb5f2MvsYxavu8u4QHLj5l2ibjdRCImXTh71nlh0k+941rAjCz/gwrLniMZ1CsuMC+JXRD+fgGUsCQ5y6exTPBqhCSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750777708; c=relaxed/simple;
	bh=iFbya3akG5s+WS6JIinMfQGqethChzDGcRe3Sr4acZc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PT2Zl5qUhYC9Lv2eOUIOXL3U8spbnK1mCycxLJtcwmF+IFfZryZeVY4QNMoZMxwhv/LH5tJWiXwcJSxBxIQ31ofDoWvQHFiGWLbvaG4d4pWeULLiZiofBIe8cbSfBuXJxWNbxQvuC33HFlfcXant53LLVOdyfjb9UDVnvnmMb8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b=FtptMFis; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750777688; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j2T9YRPFmYHllAw3Uj+oprvkwNlJuGisTI3I33f9NyyOLPlWD6NhDuy8il1fatk6YzWEAT6XrwlVprtYlftjxk9KXOsWei8/WM3Jt7ueJrqur5UIHs774ZonkCokIsotBBlJA4kWHqrxlsQ/c7E/JH4JKQE0rPpWjI9PNf1xW8s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750777688; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iFbya3akG5s+WS6JIinMfQGqethChzDGcRe3Sr4acZc=; 
	b=h7IxcQ8JPbIC+RE7fTXushzJnYfvEgD8fnuk9Ek59B5Jzz1fUgofQK4SM3ff/+xMIY0rpevizoPXVMBIQJ0JKYpeDAh6oiZD0AxG6tW3hbvbPtaXshOwW54ZZl2eCFnt5w4+LpDIYsNhWD8cCV7Eh2g+WgSa+AdzNWgXGsXtnRE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nfraprado@collabora.com;
	dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750777688;
	s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=iFbya3akG5s+WS6JIinMfQGqethChzDGcRe3Sr4acZc=;
	b=FtptMFisHQLd/sJ12WNGMcjoOI8gkU4MkUTPkZnp2DNG7YTgyEFoITQdqnxu4Wre
	UYnu71dhwT3nmywqje6WNh6p5cf3qD3zmUCKG3tK3F/VyLInOFxJD9JHoFNLg2FX/Uj
	9++aNZ2IsPHD1rdDv629KMriuxFmGV+VSst6vEVY=
Received: by mx.zohomail.com with SMTPS id 1750777687203110.75444813457466;
	Tue, 24 Jun 2025 08:08:07 -0700 (PDT)
Message-ID: <639e695859d632c9527d76876df2a48287197fb9.camel@collabora.com>
Subject: Re: [PATCH v1 0/5] iio: Add support for MT6363/6373 Auxiliary ADC
From: =?ISO-8859-1?Q?N=EDcolas?= "F. R. A. Prado" <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org,  krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-mediatek@lists.infradead.org,
 kernel@collabora.com
Date: Tue, 24 Jun 2025 11:08:05 -0400
In-Reply-To: <20250623120028.108809-1-angelogioacchino.delregno@collabora.com>
References: 
	<20250623120028.108809-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

On Mon, 2025-06-23 at 14:00 +0200, AngeloGioacchino Del Regno wrote:
> This series adds support for the Auxiliary ADC IP found on the new
> MediaTek MT6363 and MT6373 PMICs, found on board designs featuring
> the MT8196 Chromebook SoC or the MT6991 Dimensity 9400 Smartphone
> SoC.
>=20
> AngeloGioacchino Del Regno (5):
> =C2=A0 dt-bindings: iio: adc: mt6359: Add bindings for MT6363 PMIC AuxADC
> =C2=A0 dt-bindings: iio: adc: mt6359: Add bindings for MT6373 PMIC AuxADC
> =C2=A0 iio: adc: mt6359: Add ready register index and mask to channel dat=
a
> =C2=A0 iio: adc: mt6359: Add support for MediaTek MT6363 PMIC AUXADC
> =C2=A0 iio: adc: mt6359: Add support for MediaTek MT6373 PMIC AUXADC

For the entire series:

Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

(as I internally reviewed this before submission)

--=20
Thanks,

N=C3=ADcolas

