Return-Path: <linux-iio+bounces-4604-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C178B4D95
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 21:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C3A281584
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 19:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4217442E;
	Sun, 28 Apr 2024 19:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ahepp.dev header.i=@ahepp.dev header.b="CmtSsxO9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-108-mta165.mxroute.com (mail-108-mta165.mxroute.com [136.175.108.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5D064CC0
	for <linux-iio@vger.kernel.org>; Sun, 28 Apr 2024 19:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714331169; cv=none; b=ghgevOGOLvCJ+OQjwKsmC0BMBh6RwPuKxdPkvrX94gbrbDIuO5G+cNN9U/MavMr/c9vfHbMV27QG3KVZ7JBL2cNHC53Lj5qeZj+7uLHlaHOMQXSZbCsUQMmZQ0oBKcEMrl+SLOMDu8KguKoOuf+C7SAuZi/Mvtsx9iB31bdjGiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714331169; c=relaxed/simple;
	bh=FiUb2ZRKXaowaIWwgAaTVex3jsYUrKBONETujOYeFmY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JWsDqTrM0QMqeFzvt8ioorzy28rumCAw1yibyCPHSIf4M3kfVjB0LsGVoKHqK6gPaCiOxaCsw6ra6cgXoZXBWfSu4RxE1HMjXEZ44mWUjTMWPZ4hf/6L+J037CUIwzQII+i8SRL+rMpdo81LputV30UVwhebdEhyTCa8sxnjyeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ahepp.dev; spf=pass smtp.mailfrom=ahepp.dev; dkim=fail (0-bit key) header.d=ahepp.dev header.i=@ahepp.dev header.b=CmtSsxO9 reason="key not found in DNS"; arc=none smtp.client-ip=136.175.108.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ahepp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ahepp.dev
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta165.mxroute.com (ZoneMTA) with ESMTPSA id 18f2614e28d0008ca2.005
 for <linux-iio@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 28 Apr 2024 19:00:54 +0000
X-Zone-Loop: e955efd1765faaf4ba4327ed6c699d398ebe86b30a77
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ahepp.dev;
	s=x; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:In-Reply-To
	:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=968QCX5bxl8071/40EvUd0nag7Yb3N5amaxl7Wlh/00=; b=CmtSsxO9ueK0WBEuJPWL01y9yR
	4PCbZ3IQNnYBTgQ7I4zpY/Ee7XDeoPziaN3fV2aoYVqoZZAfeKKtRIAcni0JwMgyLhAcNOnGQfCoL
	RRPyeff5anHVrHkRlZSpsDJAUmIvyQ/xd/hZyNUVlds3gxBR2SQ1Qvh9WElREgfNJsJwBQWv5EkwI
	xjQDB1WXE61xPvjOCjn2II5PAUarGIvIRVHXuZtTzLjgIdzZxNAEh51Sp6DREw/Rp+FkibTNkIxEL
	8VDKxs1AINQZlQz2v/MzyiuBBKtxeiwayxo6zHnX/R9fyuMC6JHOHluFjPRKfru4TMA/W8TG5u8FY
	XF/T5+CQ==;
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] iio: temperature: mcp9600: Fix temperature reading for
 negative values
From: Andrew Hepp <andrew.hepp@ahepp.dev>
In-Reply-To: <20240428144606.5b3d9a7e@jic23-huawei>
Date: Sun, 28 Apr 2024 14:46:39 -0400
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C96CEE0A-920C-4BDD-9689-058B2E6D4B29@ahepp.dev>
References: <20240424185913.1177127-1-dima.fedrau@gmail.com>
 <Ziy8DsMCeAGK79E7@debian-BULLSEYE-live-builder-AMD64>
 <20240427195758.GA3350@debian> <20240428144606.5b3d9a7e@jic23-huawei>
To: Jonathan Cameron <jic23@kernel.org>
X-Authenticated-Id: andrew.hepp@ahepp.dev

Hi all,

On Apr 28, 2024, at 9:46=E2=80=AFAM, Jonathan Cameron <jic23@kernel.org> =
wrote:

> Agreed - by my reading the original patch is correct. Maybe it would =
act
> as cleaner 'documentation' to have the sign_extend32() for the cold =
junction be
> from bit 12 rather than 15, but I'm not sure it's worth the effort.
>=20
> Andrew, would be great if you can review this fix in case we are all =
missing
> something!

I also agree that Dimitri=E2=80=99s original patch appears correct per =
the data sheet.

I think of the cold junction register as a 16 bit 2s complement signed =
integer,=20
despite the limited range. I like sign extending it from bit 15 rather =
than from 12.

I applied Dimitri=E2=80=99s patch and stuck a dev board in my icebox.

Before patch:
    # cat /sys/bus/iio/devices/iio:device0/in_temp_raw=20
    65222
    # cat /sys/bus/iio/devices/iio:device0/in_temp_ambient_raw
    65256

After patch:
    # cat /sys/bus/iio/devices/iio:device0/in_temp_raw
    -260
    # cat /sys/bus/iio/devices/iio:device0/in_temp_ambient_raw
    -212

Looks good to me! Thanks for the patch Dimitri, and thanks to all for =
the review!

Andrew=

