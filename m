Return-Path: <linux-iio+bounces-11577-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B789B5488
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 21:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD331F224E7
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 20:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1232076C8;
	Tue, 29 Oct 2024 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="rsJ4RBVm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD40B202F8D;
	Tue, 29 Oct 2024 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730235392; cv=none; b=O0O7QmgkiohEXx2D3Sp7y+nTXoZXO2FQP6QkWmDjhdWMXUV6GEUQH4FNCKjhri1NSFT9UpbZDnwQeH80D+zRt4NxN+hfbErDd8xCVHoIzXhCz3vthDlplEjiQGseDthUn2nRgfahVCNBJcOWXpSRrpfbJDVDW21FwVand9ou7oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730235392; c=relaxed/simple;
	bh=ayaV4ilIACLvRXzpiR8J1sKRcOBqTSFSb769GGqR5ac=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=hOR8JDyxFO+jcc21tVHJ8rmMps4CTz8Pc4Qe5oHnmjw782D/OF1dYkoNvRcm7sIMAYI5dLGhYu8eAuv6CrkeGw9ozoxShKKmhIwyq//MaYzf7MtwTkxzy1j2i7QeoaXO7bnRlN87rOX4/9YJObHAPn332i/i1tYCyRhIbn9gBao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=rsJ4RBVm; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730235358; x=1730840158; i=markus.elfring@web.de;
	bh=w0/VxD8WqbWQChbPpgvUhvmdajmlQh8F81mL8BR2I1M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rsJ4RBVm6mGykJ0A2AmbX0irdxV3MdHFLEJFmffFzA3l3IiQrgJnKcgKuh0VxEoN
	 uOteWkViVU1Z2HN0bUegkUd52YNNhVA/Sd3IK8ruGS2tB03F+Egd2EXaR2Hb1UbIe
	 XKgkuEaZgF0DnGM36XmcwMmy+Ymy7qboUXTNLIjwvJndnVveOBJR0cZBm2H26wryt
	 IrW7xJNGQea4n23dDJY1SuFxhZPuvZQoeWt7bxKeHODPAhqOQgU9n6WDeFQqHCGkn
	 QwlWgFk48AZP0vb0vCRHcMrDKS87Y2FZQzVlSNLJQo80tN+h7hgGvLvP8QuM4SZSD
	 8YD8ayi+iewpoVdIog==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1McIga-1tiWKA0fSW-00oTku; Tue, 29
 Oct 2024 21:55:58 +0100
Message-ID: <7d4ee76d-ec47-484d-bcd2-2984d1d136f0@web.de>
Date: Tue, 29 Oct 2024 21:55:56 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Pei Xiao <xiaopei01@kylinos.cn>, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-kernel@vger.kernel.org, xiaopeitux@foxmail.com, xiongxin@kylinos.cn
References: <cceb503f429ae829069709ac476acef77a0e8612.1730191256.git.xiaopei01@kylinos.cn>
Subject: Re: [PATCH] iio: test: rescale: check null return of kunit_kmalloc
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <cceb503f429ae829069709ac476acef77a0e8612.1730191256.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AtbuhhH6WQFqSJFkV8wHbW2xx+Q+n0Pz6p2w8OAC5iK6xD8zo1t
 ij9cboyW+p74lIIKDoF3seXLbiKC5rLhSPCh3bTYTlbL65GnwGQytjvP/VrCLlOb/FFfr4N
 fXN1bVitQI60j4cyXuehc0dh5N7EO0AgNx9x/KyfGE2jPCi0xIZEveuF0Gclizah1q9AkeO
 1IVptqU/7KBFE8XQDkDxg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i1fK6m3jiJI=;fUNSJaILtTivKMJ/Qaixz74OwyZ
 AapbN3Ck+3fZBL/YaL0jon+IwznBRtx9+Y3f8SmHQt5BcYSF43paVO5gNxlaXA1zQH8PQaKtt
 NTkHt8KlNSc1wypXqAzCLJl3l5g678EG6OSZPl/LthaIEcnSKoP4Q9ikAZH1YGYT8bwxhWIbl
 u6lDZwVaz2Sg39Kp7c5CeSfubQLTjc85LAOCi9fS0xEl4yNrLc0DGvY6nwP59KYln3/PCeA+9
 oAesnkw6X9bvbzLcYPJMBFKbwc/qvgpyCOFFQp31f8a8pksjMaqqbDnWEZIJDWvBusQIAjCUj
 jVFx0h+vtlq855Ny8Q0yZVy5erBEtXnqIohKYUHnm2SMmXD1g/fQ5a4BzbFQm8tBHEId5q3Ey
 v/zgye8WWZNm2zXXanqzZtrI1CCVOCqM8D0V2bXZ4e15b5PKSyE/NEZorEnUf9o25zSfHhr/a
 g6G1d1DKVd2QphYEE6eIidh+inKbC+pzpR4iHgTXqovF6GFPO+vUMkjE10EuuUMtPBPFVMAgZ
 5/iG+dMpjUxHl1XAsBKSA/Wffr9siRjIqrHa6JYhD3bICLZ8h0ZCjxPErmQonukM4zCDe20zG
 eyPA4MCuWIkd5yYapIyoCfU6vwaSwU6UmjeetbW9hGRNUMtbfGtSdthGxO99YXXb0oMiBzUKk
 jNq0UJyjj2uZlMwt7xolyXLcz/h7f3LgejC/0lzCz81pTy703h5iTpW0M4ypgJ1TRUhRAlnZq
 CeMsLToG895GFmzvicBwTwITrhBYAC2ihGBD0m0n/H9yDrCKqqpX/3+etVN6KsP5KvlHZjp7m
 +tt2FTxeT4tKcHUs1bR52BgA==

> kunit_kmalloc may fail, return might be NULL and will cause
> NULL pointer dereference later.

* Please choose an imperative wording for an improved change description.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.12-rc5#n94

* How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and=
 =E2=80=9CCc=E2=80=9D) accordingly?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.12-rc5#n145


Regards,
Markus

