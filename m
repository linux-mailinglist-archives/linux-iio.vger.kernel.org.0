Return-Path: <linux-iio+bounces-11778-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB48A9B9391
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 15:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2A428347E
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 14:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B650019DF53;
	Fri,  1 Nov 2024 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KILMwxU9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BA254648;
	Fri,  1 Nov 2024 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730472370; cv=none; b=a9feTVCxxiB4ov5NlVOAUFbhnnUL93TuZp+mF8rTpeNfrEjhipS3m0bpNLN2UzuIfbBK6/2LyoKEay8tU/tslK3frFBCn9YHyB10xKfHAoN64ujJmK1fAfBs18Hdj6i2cEpHWaggsrjYzJwvbzjIy28VTIQGwMZNSH8+tum2AEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730472370; c=relaxed/simple;
	bh=O4cAnluVKJV7pjgtAUWnqipo0yYq1kLxpIgPD1mzBUo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=RsxrzDOjM2hZVI/+kGIuxKEPkPVzvYzejXYcUByZY35+dZPl2cFxCXnthy1IYnZhjeoitwfiFSU+o+CIVpi8lH8qAcFLhlofAOiCb8R/fbMz8FAW7lkhMij0CymOjQgwGvXkbqupZQ4wVXooJ+U7IBrO3Rl5jLeuk3f+scdtAQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=KILMwxU9; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730472327; x=1731077127; i=markus.elfring@web.de;
	bh=O4cAnluVKJV7pjgtAUWnqipo0yYq1kLxpIgPD1mzBUo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KILMwxU9aGA9xvWKV920SRwOjtTrywIxfPrqg9n8aS+BJksmL30TpIlhmGTvkozR
	 fCevAsyTXuR4kPixVtYg0IFeUdCHR2rb9ALfhYDUfioX5A6R2JtO/IQvEnZaLDnck
	 4+M5PhHu4b7bw/5cPFP1nyKU2uLaJLdb5xWdSi+ucM/BSj7DbOlLDTGRxUnEGVCSw
	 VUxYHbhsfqM9+BZ6DN7+vUUb0WxO13gapngHPGq4lUQ2/f8c/GRW+z4VAoItYIyVn
	 YzRKWq0r7P1ag2jx/jw3hOpSewSe/CdErHFp/N9dUMGgC2P0DwLq+Pzy+aATkohOt
	 37RMqXdtskffM8tmIw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mvbiu-1twvmz1Lte-014zYX; Fri, 01
 Nov 2024 15:45:27 +0100
Message-ID: <6f1f1f24-fa71-4a90-b45f-f09312893e41@web.de>
Date: Fri, 1 Nov 2024 15:45:25 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
References: <20241101081203.3360421-4-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 3/4] iio: accel: kxcjk-1013: Assing ddata to NULL
 instead of NULL check
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241101081203.3360421-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5a7G9cU2ItYX3CStngezmoaAdj8+DQXGo+2hm9MN93ZGj8EL8Hv
 RAGTjMuYzorc7WDHViIUj6QG5qA9LnQ0IJ7yGEFvdTDbPhhTfEIGGXjcTwPSlVtpgB9yvEd
 lhv3t9w66t/vkOeQNOx4WhssQGt4qOFHDwGnM2E7nRQhPtvDjKrqVlcG8pfgWZ6Rn6fpD3y
 kHfktk9bYOufyD6QyJrKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bJQz3o/M8iM=;sXyge+0M83jPA9S9VYHVbg9bm9r
 tc/qShvJyCEJ0OaSmdTyiWJnRHGzJiSS6fTG9GcdqhM26hhtTjGdgJD2Xnnk1y5oLT+m2lFlB
 TRb+l9DIOcFSbQEuTZVUkc5pRsIdZzJPu28TdmFdyHEsaXAsPFPGUSKGLPQFQUJdWM+QWn6pm
 VmOsbT2CqiJJd/zTpdmiklot//73KdHgtxPr6nOQLJ1Z7XVg1J3ZsjdZq/uhRzkKgTwk/0hd0
 krjlnQUvNpeFprLFqRNv3opqYdLKR/LuS6hVeRD7bQVhnoayP6QyqgXCgEJKw8Iugd7oWDW3/
 pnX0o46TCZtqLnnUWDrtOcREBQlNPrj9DRrL9UDhsxIe36rDnoxS1f/upQnxVQ1/xPfOtb3Ea
 Xq9+vwj9K95mfBiFyzJa67SRXrqYhwvEFZUVViQuJ9edfVzMpldLyo9FsAYAO0wlK8nGR1Uf4
 NZWaRGfqhHa7qypMbt9KYCv7LaRKVH1Y2kDSmTbZvfsh8PYrODx3AYP7oREovoDjgPIduc3/h
 mddQhPKzOoOpN0bWs0OxjGB2EoDII+t1YzM+125qfBYBVQkm50Gx85SZZR2h+dAB4KUzhLZUe
 2n7DnQNR54OhrFzUFwOlGKjoqsC8Uj7fE4jgH75Z8Dk8GiJ+Ja8opDqwgM+7U6/cMsontFxcK
 rJT6/WDQivoGvD5rSzWt8dyFHoAnjUCASz05FeM/omvH3MuxCrcHPN+eVgdmVCcIMcL6to9Iq
 8eS/UaiUeTNiQWsNrFmE8Tv6G8g5+0uG3m7nmV5dicokIVjVPdvXYha9gJuoqvcq6LUL0YWpz
 zx7cArLOUylhAZIdfvcjI/bQ==

> When iio_get_acpi_device_name_and_data() fails, the ddata may be left
> uninitialised. Initialise it to NULL and drop unneeded NULL check
> in kxcjk1013_probe()

I propose to reduce the scope for this local variable.


How do you think about to use a summary phrase like =E2=80=9CReplace a poi=
nter check
by a variable initialisation in kxcjk1013_probe()=E2=80=9D instead?

Regards,
Markus

