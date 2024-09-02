Return-Path: <linux-iio+bounces-8955-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7816B967F0F
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 08:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A7C283343
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 06:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780A1152196;
	Mon,  2 Sep 2024 06:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HjOWstQO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2025144D0A;
	Mon,  2 Sep 2024 06:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725256883; cv=none; b=igWrRpKcZ1ovl2bFObqKjETLWz/k+jG5RB8J+5VYyZuBnMnjv6cDca8lAtrwnJ1+yrHDHylt8wz9zRlP7HaHNPaYnDwMh5pKqVouLk2VgMKD28eWi4KaLZkTPbzPXWaUCA62Rr4NsclhTvNWr2AOzgb5u2KlBekh1qBnVQ+wqAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725256883; c=relaxed/simple;
	bh=r+h5DdKH7BiVvXGTx7RSRB8pHqivoswfNU02zUKuXhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+QkcKR3oXASCS5fDrjlXlahs3ciwXH/ZjP9VuHt/2Faw+FKP5xVHx7rx+/0E0GDk4nhv/wIP7O1zthexpIWGu5utpeRnhYgczWG7raqMSG65mhEfQzyMd9NWZrI6h+c9+5PzCIKCahfFumU5DnEUj8FFvqyQLhTiCOUzkJq8M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HjOWstQO; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725256855; x=1725861655; i=markus.elfring@web.de;
	bh=r+h5DdKH7BiVvXGTx7RSRB8pHqivoswfNU02zUKuXhs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HjOWstQOBP/xhi1WSSuMx+E87vC0NR8Jr8QYEYwaVuRFRNkA6UbZWP/GlN2rbZNe
	 nEV3TgKSM8fq6cEVs92qbHZmJchqI5PEl3CMKyeagTzJOvOS8eMGN+rD3+EF87CJI
	 s+Il6MArnhFKJhqe9qkngPFBXxhht3uhUZ5XvQhkfVKMrqQcA2If7Q+s4tcTDKzZr
	 +mSPGtQ0/86YA1eMasCSzeJVhTKTFqNXtph5j6JDxONa5mUGEFl/GVRgZVAm16cXU
	 c51GvryD878qWYeCavuSzkp/kPtu1BDs1oHG5/elf8V2+TFv18k4o4W7fQn03sIjE
	 i263FnWOh8p7s3ucHw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqIB7-1sGdS020BP-00ckDW; Mon, 02
 Sep 2024 08:00:55 +0200
Message-ID: <3c60e167-7815-49c8-89f1-fe1139879d6b@web.de>
Date: Mon, 2 Sep 2024 08:00:46 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iio: imu: inv_mpu6050: Remove duplicate code between labels
To: Gyeyoung Baek <gye976@gmail.com>, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240901091214.15199-1-gye976@gmail.com>
 <533802b3-3034-4b7c-b903-72608917e2f0@web.de>
 <CAKbEznv-TmCr2FAodrM2SKK5A5pbV9p5-OvXPdmuk_4xXmh=Rw@mail.gmail.com>
 <7b827ee0-9116-4e8c-96e1-1fa5f7267f33@web.de>
 <CAKbEznu=+Bkw4kmoo7qG9h2wM=2XV54j_SYzHMAH1uWhtUPCvg@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAKbEznu=+Bkw4kmoo7qG9h2wM=2XV54j_SYzHMAH1uWhtUPCvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R8zRGZ0uGHgckq3I2sYqcn2+0B9e3cQGyK5AhzcFFsGDaMnMN96
 9ZYuTV+I1hO2F4/6wCt4kPvZE7av1NIMl0O190whm6y+zBugC/0gP36s5OBeecnzmMKooGQ
 2EOcz5K7h04Zx9sBBEaqjzue70udnHPqKA26j+P/ww7bk6XupLN7SCBbuw40rqBC+rdIxf/
 M7HvOS52ks+ayNtI/Oe2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s/sGC0twEzQ=;uzdz+FV4i+M4gOEZyFA9ca/rLaR
 xggvm8fg4HUui3WNaqLAVzXQ7xqhJn44gWkkPCyccEzbOXqgrUgyRX56FnXjJmQyS9gMwadGi
 SaYnkF4g/Orf/TGmdqalxP+Cuz10vyqWSLcMOOjdtSuNbiOUptJfX5pv09phW+pf4H0nRj2LA
 2I34nH1bQDxIf1TgueWdRlp4EVTdcvNX9PZBHvWuFbW/Z25lRYztyV/J0LLR5Qtoo17pzdtpq
 Dp19/xnFmSYj0QEXHHN7p4SOXL2shHioeM0BxtgMVYZOY+miYac98q6NUiT9z448ozeNNPBTF
 ezUHwHkMNLzmR0LL4J8xQM+oUHj8PwoAFY2esqdo7F5v09da8SzlgVj4EJw0Bi+8JyNepXs/I
 4pn5FkWVhvlqxQoMriZj3y1aQKyxyDxIG4okYpGRDcEGtWHMw1fNiyloSx1TCp9JHSl8n83dh
 nuW1/LWce+PiXmPTUcjEgdNGiRjrlzIPnJ09jTEIsqUp3DVthHiDM+tcNoX2nH+C5eUpqRreS
 Ptf26IYramW3nMdeIRvjTFtU4x+1UGRoAigvcPJcUoUjJdkAboeY4CCp5VVVLsHPXBQcferSD
 P8yONH1Kv1ScqZcDat5SNsyrxDiGyAHDN47XuvfM35gvrBKZw76lBzt3YrxmUJ1DfK04MF/iA
 bkpUx2ZqyQtKB9YC+hyGpujkiM4E9aNvZg1aJnEJfI1uVK5OedSqWYdBAYzbmWeuWkhyLc7IZ
 iTtoGQV4wiHiOLLrEmYahUiz5iM25lhAuWP5IcKeSHcu/ZkQXRU6ZKV/GGo0NF7pAMA0By+wf
 KCR1G0u10NjV27Xoa9PEj3fQ==

>>> Hello, I apologize for the insufficient explanation.
>>
>> How will the commit message be improved further?
=E2=80=A6
> Since the code is short,

This implementation detail can be nice.


> I think it's fine for now.

Please reconsider such a view once more.
Are imperative wordings also more desirable for a better change descriptio=
n?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.11-rc6#n45

Regards,
Markus

