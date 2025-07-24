Return-Path: <linux-iio+bounces-21976-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7F8B10B62
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 15:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44605AE76B5
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 13:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B812D8393;
	Thu, 24 Jul 2025 13:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QCuVB2Td"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC012D77F1;
	Thu, 24 Jul 2025 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363768; cv=none; b=TA9fYMD7bVRMI1/2nxLge4BnrIE1iA1JKftCQJYAUXfCEj0ZNO3AQVoFx/dPx7Em7qfJKY6EnXKt7C3pVOn2FwZ93FtybSllyB0tSUtX7q8oK9q2HOqDdXvviZTY9aAAjKHX8h232FnmGu2kdKJiZuiArXkEOgBAW4DD13bPv+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363768; c=relaxed/simple;
	bh=/sm4amhRNnEpCnCNnU6yS+1uSrJndpfCw36r0SiwMuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YgGalWw4uf/uGqIh1iwFMuPO2cqoTU156nAL2Fq9JJbyceJfbO0yeZyiPHTa1woSMKX7j8keCexynjR3yWVI4yYOcATR/uRy1KhN3F/V7Zu/qf6ydmdjsfErUOi+qkielSsxrYGr0PP0UjhS+komDoKb555WK5cyZgkkvFKbUxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=QCuVB2Td; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753363758; x=1753968558; i=markus.elfring@web.de;
	bh=I2PErscHQFZT+F0RZ0/8qmBqfnAkCt9N7lZmntXqAXs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QCuVB2TdGlhANKcoKe2ONymZ2xWzkMKEamvQlxnxIyTqS04mjHZ5U85C0CyQoAug
	 rpnUVJEaZuiwERs813Os2LCTwPtKbT3LcL3nBPjiBYzPMedVdGbNz3UFpRfKJOFxt
	 gOo5mYSVyjtolKXN4ztCD5k/mu5miyJEV84b3OIPsWj6K3ucnm4dlKJvSx+9fOkBK
	 UXWRGtsgy/eBf00yyZpmd/gqSMUBhTnPdTmjzSpxjx83Q2sSa1+NK3XPU/II1/zZS
	 97c+WNFjNWk+dt6WVDGSz9y42wmUSjD1VoFqN1l9bq8L64T69Rbu3wCZ+JFlvnGuB
	 raZ/1lNhy3CW6WUhCg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.250]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQgl2-1v1X6R2xd8-00WhIv; Thu, 24
 Jul 2025 15:29:17 +0200
Message-ID: <fb69f55e-de06-4513-8126-e73cc51c086f@web.de>
Date: Thu, 24 Jul 2025 15:29:15 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: ad4170-4: Correctly update filter_fs after
 filter type change
To: Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
References: <1c354ff9f41ff964a66ece44b0d356e0bda3d210.1753024756.git.marcelo.schmitt@analog.com>
 <aH4n6kMQAN1zZP_V@smile.fi.intel.com> <20250724135125.5dabddb1@jic23-huawei>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250724135125.5dabddb1@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8LDc5b4kcoR/9rnhoJoDnkRake1WGekL6OsQ/KL8A6GYriNUwRA
 RMyMK28bZy6Etks7VTcogSX8cVeCofm1p7t1kR6QndvLTisZDSbyi0OmxuB2Cf3k04Yl3IS
 9WIA78nH6wUDUYKqT3Cgkoi4RkQ2s4o/c29P1HwSIgJCf8RH5V68V9hjsTj/oiaVE9bmnGj
 g5xQZ/RzZ+zMYFWyMVxOw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KwriVkfJpy8=;96TqMnxf1WZiU29rJY91QFPetEU
 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
 SQTD84SEGOgyZ9XGGnkpY+3BTnhUe6uLTD3

>>> Previously, the driver was directly using the filter type value to upd=
ate
>>> the filter frequency (filter_fs) configuration. That caused the driver=
 to
>>> switch to the lowest filter_fs configuration (highest sampling frequen=
cy)
>>> on every update to the filter type. Correct the filter_fs collateral u=
pdate
>>> by clamping it to the range of supported values instead of mistakenly
>>> using the filter type to update the filter_fs.
=E2=80=A6> I picked up v1 and made that a closes tag.  Links to email thre=
ads are fine
> (there was a question in v1 on this).
>=20
> Applied to the fixes-togreg-for-6.17 branch.

Would you like to avoid typos anyhow for the final commit message?
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=3D=
fixes-togreg-for-6.17&id=3De4d9886ad25adae72f38f2b12f41649b101581ae

Regards,
Markus

