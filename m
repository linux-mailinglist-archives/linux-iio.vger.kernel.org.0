Return-Path: <linux-iio+bounces-24981-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E48BD07E2
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 18:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 626F14E8FE5
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 16:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E4D2EC541;
	Sun, 12 Oct 2025 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dI1N8wLT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6702EC0B4;
	Sun, 12 Oct 2025 16:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760287500; cv=none; b=lwq/9vZdJ128rmnEOy8u8Xq/1PC043rUlDbNHi5XMcDRolwNTz8Nv9zreHHNi+lqH/53M7NNChqLJzHLk9LHSXd2oT+lKmP0USGn5Vkj4TVziKb1JKH62RSQ+4N0m3kAZilkBk1INmIvGNxVWRVUIlA9htgLnGuVCOUcoEcS2GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760287500; c=relaxed/simple;
	bh=OxRT3WKebBtTMrhNXcmJa0A6Q1I4uF8JpELlwhqm9rk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=NhWh0khJsyW9ExG8JaSYYUrXW6l1l/Pg/uWLzvmVw3zMXZOKZJeRBUuqDe21bvvjGvSVwlFK+Va5I3sjqBXtLgeqTfO+khi5NRhl1EsKKq9krxTC9UcF1dO4FQUTj74prwz15WdlPPTxoO4Q8reFjrUUaSVLPJqg/unxgywdp2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dI1N8wLT; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760287491; x=1760892291; i=markus.elfring@web.de;
	bh=OxRT3WKebBtTMrhNXcmJa0A6Q1I4uF8JpELlwhqm9rk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dI1N8wLTcIAz/+spOltjLZzWIvGWmEOfzImh1MKWW0uaodwHxDe5eSj050GW17pg
	 IV7SIGzhdHqWmm5tqmoQiMUe1ddAIW28QBDVX7An8nQAutTvGqRBTENx4vMdpAVdt
	 iN0z4aHdhxjULL48OixDrrSHQ4LWU5J2MN5LgtLIJEoXXVo/h//j+I5YFbaoy6jWa
	 Yw9VQlKIp27+c4P831EzsJ4l5BWuwM7JZ3n9rhcSbJXND7e9XzCRLTiN588a4Z6ZW
	 3WY4kspzrUZHlcKup4GkOCzKO1aTvkkXYf0hzeltFQruQ4oTJAvS6LrVQbRFFkdSD
	 tD7Uz+BExQdY21toiA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6K1b-1uA7Jr3BKD-00z1iY; Sun, 12
 Oct 2025 18:44:50 +0200
Message-ID: <984fddea-2085-4820-871b-40d69feb11c8@web.de>
Date: Sun, 12 Oct 2025 18:44:48 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dixit Parmar <dixitparmar19@gmail.com>, linux-iio@vger.kernel.org,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20251011-ret_val-v1-1-8e968b38790a@gmail.com>
Subject: Re: [PATCH] iio: adc: ti-ads131e08: return correct error code
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251011-ret_val-v1-1-8e968b38790a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wzB5nGOI2BMA83rpBI20I9mzf8F/RKXy73d/ykCLhwOQYIUzx0f
 z0JtV3um00M3GBHo3rSZiD1o3S5oX0j6gJqLCqZvcsZ0HKGA4p6Y3yeXJyMovc53T6j5E/t
 6IzWCeDYcPyAK/6okeSXRwk5HsB5OovGRWbuCK/ZiIKX5Qz15LzMWlDlC4TUoLNrEl7zLOX
 C/RevI7hdpkO804KyTfOA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TTROtXJblFA=;ldiIGHEEBB09NtnU8ohqcQNMjwi
 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
 /3MWbeivyjgkyw==

=E2=80=A6
> This change makes =E2=80=A6

Will another imperative wording approach become more helpful for an improv=
ed
change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17#n94


How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17#n145

Regards,
Markus

