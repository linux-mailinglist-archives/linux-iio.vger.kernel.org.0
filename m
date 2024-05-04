Return-Path: <linux-iio+bounces-4802-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2B18BBCFC
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 18:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCED11C20E25
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 16:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281B45915A;
	Sat,  4 May 2024 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="YkXYRX+S"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B4C40C03;
	Sat,  4 May 2024 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714838921; cv=none; b=V51RGXuRbjYjXEoSGoMbGnQH43cvm+9yZbVWHEn8HnFclf8vNTwnmIaSdX7EhscnyiEJGOd/M7R/qRphspVRbMbUrtRstoeCRikznY9vHWVLIJvIdrVFUAuIWdqN4Kk9sW7nHD8KZkfPxqUbzEpMjPlYAN0fVZxn6rd3KB4m3iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714838921; c=relaxed/simple;
	bh=CB5nxguzQ/abdMOLQ0vP5QKBOqXDtL8p9+UDyZXBqAo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=PAKtyWWf3KXPrgjP3gTWu0wK+5+6wJv1s4SY9R87utY1P6LKTzanNwDzDUVC8PKUoF+Wv6RCySx9JVFjHc74BMvSMR9tu3Xkbpx/tgd/il+MfkcfyOldvbhUeiyhpgzLeKAhn/2iQgwa3PJoZtJLyBmAIGZFkq+X9HhcNTOU408=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=YkXYRX+S; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714838891; x=1715443691; i=markus.elfring@web.de;
	bh=CB5nxguzQ/abdMOLQ0vP5QKBOqXDtL8p9+UDyZXBqAo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YkXYRX+SsalO/beBUJnywGogNd1ud4Uz0iYtyXevIwRfJiSfZtC7iljt629iKEM3
	 0lLWg6JOs9VAmhbpFKxLIpahRhRSE5hWRoMd5zm/SQ4syuxy8kEsd91OjCtuZNEF8
	 wgz+rdL9Cgh5FH+QjDPi1lDgdrhqLW1bd3DfJ5e7XutsiTSXduVMj5pIFSsFfOE64
	 rlNOl1IvOis+xUXxgt8PC07eBbyysI8FNDNKkpZhbvam3myhks234/8p2DfEnMwES
	 Bp/l58z1b/nplbGw0mK1dMWdVzQC6Bqhf5QGRUzNHML7oeOov95jWqUrGxbXl4LPT
	 gU9WLQFJ60O5yWFqSg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MC0LH-1rvsrm2ViP-00CQyk; Sat, 04
 May 2024 18:08:11 +0200
Message-ID: <321b2cdb-95e1-4bfb-9811-a853245beb17@web.de>
Date: Sat, 4 May 2024 18:08:08 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jorge Harrisonn <jorge.harrisonn@usp.br>, Lais Nuto <laisnuto@usp.br>,
 linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240501215724.26655-2-jorge.harrisonn@usp.br>
Subject: Re: [PATCH 1/2] iio: adc: ad7606: using claim_direct_scoped for code
 simplification
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240501215724.26655-2-jorge.harrisonn@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TMeWClk2hCaquekmmyaU5QdHKlXEicCa872NxIwUstjhWnnqzWq
 h9Op9cZuwuie+E6bNvVgFHY4TqerNX1p2YmiRVCCQtqV7ZoLcJIP2XuL/LZK4CzuS/n67la
 2gnAX6WS4OZAfz4ZWT6PKU6671zx43OIJRxqpEGt73rvwLUDpr6dL5yXtINCcHjbyPk6tIE
 BAuCPcPuaF+AIOPahhEew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tt0HV3/HUI0=;BbJtvOtM/nU3xrTiM14k0iuNubn
 ecvSBdxcAetmK438gIkp3W1fY7+EH665/EBHq/WV2Sa7hxhzpbCTKEpE9Sr8pFqg0rFOrTYGF
 1NU+rvShJz7PTE9IkMxEwaNrey3GerXj/PJQXkAblFoBJamqfwMDrKIaV13/CoKC7YkYKHwhe
 7C215dMnnlaiJXt+QM4q80oPyYfHDYCLN6RAXA9pTjS+gHmwfYDEPWp52cgP/I2CMuOAJmdeD
 K6vlmDpBWpNBOCYn+LhEtFZY0mv2Qo8J08FGN8DQK7GvPT9Dp/DufBt9Wzyr/Qw2mddHUJbFP
 PR3WKpFUi/t6ZxBxoahDpPM84tq4pC6Ad5P9Uex4RWLt8eKL2aoblm/t0i9I3GqzcruALki0o
 Z38EQ6uGypjtyCt+6G+1/vII3WQnhOxceXy5SrfdxV/ox1ore4wy7v/2VrxUWU0jvwQ/3sMTk
 EbleZSki4mncuIPOpVLomsLZ5m6h7A/gAcp77zwSeJCGrZaN8er7njaqp0uY1I5Rx+eeijx4i
 YBSxHmgvMs4YWgiG1z5x7yzzb4CIbgxIrZ6BSM8vynI+Z0w4Y2yTU7QfpDnlyi7hgAGNm8See
 JpRVCeUJ7vNnQ8oSrNB75hAUKG/WLD4xHQoXKL4BpOjXZ5OSM8Oawagc9J0m8u2otxqVfVfri
 Ain27mFfGw04wYrHqmVScgUriTFfSc9g7mm3StsNu5O/iMOlmnZOC2eouOIsP/PiaZzWLBLKy
 qy2es/nInyzi9ytgbmPEGI+hPVfRQbh2tfKoCYonB4uYhhSB1QyP8SwHVcTw4pqureO4hTCmH
 ZprI9/k31+BIPGpz8KZu4TfQPEVPzme4KLDrLWQ45qXquPsvugkiqC1wQwLvS0gSDt

=E2=80=A6
> _claim_direct_modeand later callingiio_device_release_direct_mode`
>
> This should make code cleaner and error handling easier

* Please avoid typos in such a change description.

* Can imperative wordings be also more desirable here?


Regards,
Markus

