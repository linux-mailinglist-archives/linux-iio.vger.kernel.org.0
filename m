Return-Path: <linux-iio+bounces-5090-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2A38C895B
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 17:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECBCE1C21CC7
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 15:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AD812D219;
	Fri, 17 May 2024 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WJjLJWEo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A4412D201;
	Fri, 17 May 2024 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715959892; cv=none; b=SccCWLKoHj2DyQRkaFndJ9Q6slOOjFPU826+bgvH7cSrxnlRLglbYakwE8dnQVjAEuckHyQJ5FSQzHhgKHfNO+ktqKE+pMvOhf2j+jtLf64d2ZY64A2pVjypmONAFb/nA2zdXJNU10xiijt50A4zTrcEGgRZU6El6zm2d+VqfOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715959892; c=relaxed/simple;
	bh=my1yI7WyUJlHky5ciUBO3WQJ1JZ37Sarb+33aKXJfSs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=rqk4MMPOLD/JouX3pTRJt4h3rjuoRYDuvGd8lSFO/cd4/pZFxYEcUa6g93d71XsVyjYLdLYnGDmhhY+x+VikDI1l9vmsTAKq7nxwfovDr/6+jdWPW0d0p27PlANa0losaFgQPRiZiD9KU2S/nUlwbRGYLaIk1nnxqU0dbryiMBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=WJjLJWEo; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715959862; x=1716564662; i=markus.elfring@web.de;
	bh=my1yI7WyUJlHky5ciUBO3WQJ1JZ37Sarb+33aKXJfSs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WJjLJWEoutNXwVtnRjLJOLjtT2ZTn2LrmHMHqvAe5DWaXx2RiZe+Zpae/6Xo0Qip
	 jvgUR1HgMSiFUVjqBD84+JC4U9bVgmjzHpFRy/Ep2TJT/cDLBNKVFHZxxX0Wwwfbn
	 xoglMS0ELpDSgu88LHjmJC84k19TGodU57/pT7A6hWB8qqM1BnCBm3FWE0gqJ8yT8
	 5rT0KO/NKp8carPVqKg/9pW8X76RyKQhMhS3GaVL6T4rhw5Q6exuocEWZLV/IF650
	 TixdPVtqUZLYZZ5O3D3FeVQlarL0oNHaUw1BNO1fOj7TF5HaiqAPu3gIocwoYIHM/
	 dGzDHL80GUAnev6lWQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9qhD-1sB0LY1tDR-0096Pm; Fri, 17
 May 2024 17:31:01 +0200
Message-ID: <d313e351-6697-4d4f-8950-2b784a2de9f0@web.de>
Date: Fri, 17 May 2024 17:30:57 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dimitri Fedrau <dima.fedrau@gmail.com>, linux-iio@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Hepp <andrew.hepp@ahepp.dev>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>
References: <20240517081050.168698-2-dima.fedrau@gmail.com>
Subject: Re: [PATCH v2 1/2] iio: temperature: mcp9600: Provide index for both
 channels
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240517081050.168698-2-dima.fedrau@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ElMMYmA2XlfZzpyqH5Dw55ie/6kAanw3hh9beo+i9gPpusngUxM
 uC+0CWnSGidmtUXIeGz6B6Khq/IyB+0QGFYiEIMHKX0KbziFUyrn++Sf483bsgVu1ILwdIu
 MEE7hsHyXjviSR3MfGNZMEXCOu/Bg0wlkC1Zx8n5eWdnkmGIovLzbMOhmo8jau2YMgXurrs
 I4dEVpmqSu3VVx2A6dVPg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fdmUXQ6Y9qE=;vVvbMdsKruheBqTfrwIDY27MbI3
 KZKWTVWnqZMrFqWmJNIV6Xow8XnPgzJWsNizHWBJ9xUFwTmb3QJe2ypGUOQNfB2n5Rga67BID
 NkKnMl1iuZhiIDNzq4S1dxnafRPri1wXkpqnlGisW+ztiBZScB+Qs4YLRqKAD1RGwB4efYvt3
 tYAWqbAmb9YN638R1n2GDwGhvWWfs91wdgAjPywSmDSrQ/36b2pX33uweGwOh4BY8it6cZ8Po
 h0+cAGdq1goQdyar8o6NUIG5qDah4A3OhkTCppH05PEKog2E9i585Ow693FxeOzt3ybg8aRIh
 UcfzbVtjN7B/Xx45sf6jE+eZbvjSa9f1Hphld9EUZ6CjiX3+7RYSeFqfF2OS2ykyiu2iJllh4
 mYDO8yisTTgjxP5tMSLIP2x1zWLRcztbm1rrjQ0rclUuvkRBcqfdGNTGlJadDPxAKy2vD7M6R
 LnwRiKZ4A3hu0nZPLLSWnN0twIKItwSXGbNBhqAL2xh29OijoUvU/e0BTurjjKpOTkUXOUiUk
 rXsp9tg5cxuHKZCg59Ii3ib4q1e65WMgsdLUObNie94Q+3ZlSHSx5BBq5pT+Fh9404u+PkpEo
 MoCs1jxRWkHyL09HrSoK0+uFu+JD3bTQixH/zvQPxWn7VdKSKv6dBQzb2fNeZY3oDr5LtVPxv
 dR684XoDFhone2wr+6+tkOyNPEJH0Y8PslhIzcjh9NLjZwIKLzhmZwEKx+2UHi4/loYyI+6u+
 ePhMgia/hlB+3PxqFO7vRpC18I79UoAptLxfJoUidXNSmJ/YRyS3OjxhP9bJq9LD2l/zGoi1G
 9QAXpxuA6MRjTcw18RzwKafmbPtIkts/3wDZAvzYp6WZk=

I suggest to reconsider the distribution of email addresses over recipient=
 lists
once more.


=E2=80=A6
> We provide an index for =E2=80=A6

Please improve the change description with an imperative wording.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9#n94

Regards,
Markus

