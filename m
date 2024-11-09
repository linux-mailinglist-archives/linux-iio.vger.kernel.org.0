Return-Path: <linux-iio+bounces-12098-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9A39C2EB0
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 18:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0562815A4
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 17:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EEB19D8A4;
	Sat,  9 Nov 2024 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="AyMhxls+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9550ECF;
	Sat,  9 Nov 2024 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731172633; cv=none; b=Wyyd8iU2wc0ZyjYlUaixoygEbsnMLUzKj5g3xFh8o7SNAwTCItkJtSsAzUNIuOxRf4yvLvJQSEc061NoZxTGz5GmEjXTpiTmxyxM3kNr0Gq5eDx4GTKYp+MVnrOBE1acmyNC1AOi4pkeVS4AxDf+tQPqSE1Q7s38lCrH36aj2dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731172633; c=relaxed/simple;
	bh=SyRsz+IN+JIyKtRilD+KAlzF5tOeIVUgi83ngtRw7Ls=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hjFr8NM7rqDoCWOTlDVh2uwXpLdKrJh8q8EER377dQfufHbbm+oQkh+fhVbh909x+Epe+vrPe9yzhsQ+gNgov2RHxef/YYJIEct6FQUHaw/oM4X17NRXQEojzmgMqjspbubEgeEjAwn7IolVMONm7zQhBLX2IZ+iG1/ETN1Wc1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=AyMhxls+; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1731172569; x=1731777369; i=markus.elfring@web.de;
	bh=8VOJJCUgIPJZr0/8bZKF4nwTPa8HNuLOG+oBkdz8Vig=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AyMhxls+40ez0BuBcBmL2KVRfy+09CssNDjxPTwhmMWbkScKOKrRH5oa4roMTK2o
	 Y0qoHcHPFzF4bmT2e8P5yCIGMxSuIFsh1RXun9KQQStAm5DhAPcpDJJxBybb91TV7
	 iEVSdZXEdx6B2jCjtSQ7NOY9IhR0SN1R3JBzxQ4zyWpoDfs0wrKQi51dZUfyG3Kod
	 hcJKL9w20/XFzUZj6ZWy/CMuMutKU78TykayNb9ZjBdgwGCj3mT7VV+Q8cYofGNJt
	 bR9lVdqOcPKRwKbyOX6uETWc+4PodxA0r4mSlcD3+HHAQ8eOPqbVKb7JQE2MobTy/
	 POFlpke035NsVjkgTQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRk0W-1tFy7v3U8Q-00Hyra; Sat, 09
 Nov 2024 18:16:09 +0100
Message-ID: <5d8ac86b-4c80-4fbc-808f-7581403d061a@web.de>
Date: Sat, 9 Nov 2024 18:15:57 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] iio: magnetometer: fix if () scoped_guard() formatting
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Ond=C5=99ej_Jirman?=
 <megi@xff.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, lkp@intel.com,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20241108154258.21411-1-przemyslaw.kitszel@intel.com>
Content-Language: en-GB
In-Reply-To: <20241108154258.21411-1-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7N88y06+RI7gnn708r06bGYbGOOA0SW9Hx3lK6de6QP8iQZKj3T
 7lMsbJH6HkEVH33WND9BQdj0NiCg6IDVS86PUkytzqZzC92KzzLOrVzPJVRgVbgurPA0r/9
 IH/JSQshDI5flhhOvqZm7geehcAJrJSEQXRpnypssDrVSjPyam6zdASXAIq0cGpR7Rq/s2q
 758O13vqCQzAdrNeaQBrg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3E7DhJOrLGc=;xPGSzyNh9qiHR0Ss9a+jhZQ6PyG
 wvM8n/gv5Jayjh+gzScEITAEydbSimOEYown7piD1kQBeHMWZJkp7sJ/8vKNT3RilVu4nnCOL
 zTdVHDTTQUzcDNwit4TE4GaE1NpEshnjd9T5x9xRvTZJ760GqrDoytBB9rsOSy0rTG+6ye8RU
 RN8m3OVNHDe7iBPVVDBJFxbWU0lHl5GBiDoPMAovrMqZ3JQ9y/zgcrN5oKZFFpKv0cOQ1R4Wd
 8Y31HwgMhyeygtfGVZU+V2tS1+Fz45AtrIf8LoWeN0VwT2Y3ha6K9LjwSucSHdf3GA/8rLLJi
 30fn3wc8x/7EzFvS9Iz6SKaXs+Ild+GDJ4UJhDUGxYnrQpmNs1gEGg3cxjEXu7SNLLdiLDhEW
 0BvjT+h0GVERhzNkRWFCMPpUjuxvQhlL+emwz4PgCmjLoRiweUNuSLfP6+nb6AFm1bwAOEjWI
 hJjsg4kDFTJzZGj1QLTCN6FEjcLRolvLswmnMCHvhk8P6Ag4+sgN11bwwSSVINDm1xlLxtj4j
 btKZzkhtGvttyiQGlCoCI1STy8/Z8+QMlnIm8vC9nHKhs+NpdU2uB26Pn5C2hZnh8AczVJ7nH
 5WLqce+HniumMtnZZtS9KlUNtjkn6CNEFyzKKl5lvGxUmNi+v30arpVd7wM8tpzSXx5GnBcrV
 CybOCAGRGe344yFtxRhCmV5bpIhdPoGU+ICx8U9elUVuckdl6ciXlQJq1gfFhFLYGL04U+e2J
 k1cuTHJnUJn+65gQUqjW+dcVdE7nESmZixw3Mb6MmYX8B80OR/y6ef1dIinJotHfqqx19nvu5
 cKpdLphqViRMLVkg3ktn/Z0khc4O3F5xiCVvKwBvkKVRucHNa2zpIoVNBZcjIvT+dL5I0JSbe
 cxFwgZ75zGfcXDdyRgwOTGEhVA0rCZKDH5xjPjefiXXTRNVZTIf1kc5Cw

> Add mising braces after an if condition that contains scoped_guard().
=E2=80=A6

      missing?


Regards,
Markus

