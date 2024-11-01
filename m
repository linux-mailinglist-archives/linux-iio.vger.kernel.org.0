Return-Path: <linux-iio+bounces-11777-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5685E9B9329
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 15:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B290283468
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 14:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D35D1A2C21;
	Fri,  1 Nov 2024 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="SWzM6cN1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969E41BF24;
	Fri,  1 Nov 2024 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471320; cv=none; b=C4pvEmpvDQTq2wYIh54PhDKCsWtpwZRjWZbtpuUqyf+g8RhAjFtitMRvY9vlIIfE5gP/QJvp1DmohE1JzizrDBJ+yjsTBo92w5JB0DP5SXN46NiB3khc8Ch26yW3AHnW5SqByLC+rzx/k/Y9nVc+cpXpgrP+p0M5j4cMUnrh5io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471320; c=relaxed/simple;
	bh=wsiXH/GXskIU5EAyiJDY5cFEUdmMr04bYqDneOCgCec=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=uoUwrFakODPrLmXTcpxzC2frR9fYtOOKglhH6pvqMIIaUCRkmB1RoiAHdANDrpTSQL7664dH7UJhXhEksXhDJuAowj8X0FalW/De+tRzM7TvQgWB8Hj5FRMyLvwLlv0fslcZAaLaX48k78e4Zv4ZzWsvvPubdQAyIjlmiu/0/QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=SWzM6cN1; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730471275; x=1731076075; i=markus.elfring@web.de;
	bh=wsiXH/GXskIU5EAyiJDY5cFEUdmMr04bYqDneOCgCec=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SWzM6cN1UECyibV+rAmryXJXbxJ8ZCHpv4QRKD5cp3nc6F8X0gPHeYbRo4vRzVqO
	 /FEzdUrdCRMhBqq5TV6l40EUGylhlnl0AU1JxRGliLw/cxNiaXay1GeWKYSKqhNsd
	 nxEyWdZzGIlOEpPH54Q2GFDGWc8Gb45gsax9XDz7Cfa63ofvDhtr/ioul2G5IXhZA
	 uFqwg5f4iNWCkIqyweFlU8pLDxgPyoSbVy7ZDPw180oY2xoYt+0IvTeOXf9qiZ7/x
	 6NMRAPUx7g95uyhkHJhZVY+bTIue/otJ2HurhgVu6az0Y8GmUrkn85NCU/IPTD7wE
	 5ajiA36PNLqiYQZhqA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHEXi-1t2SmB2zDc-001T2i; Fri, 01
 Nov 2024 15:27:55 +0100
Message-ID: <12767145-97a3-445a-b632-511e3ed20474@web.de>
Date: Fri, 1 Nov 2024 15:27:54 +0100
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
References: <20241101081203.3360421-3-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/4] iio: light: isl29018: Assing ddata to NULL
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241101081203.3360421-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U1GkMtGnfHOk4j9GJEyi/LmaEDsIuWKPMjHTcgdDt1XSEeveEVq
 UohdHQr9s0Xe+s3vdp4MHrYY8NzGyfPASO1URrnPiceTU6OqFLtKFcGZ4K1glnx3yGGu4ht
 8p7uC0iEHLos0zJYsaFaA0MsKMslsmqkJ5CdSLRdor72Qc7wuFvnikt3/gl29wwkGNs4YyH
 /v7Ic3ef0aKCmVDwwlzLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kv26PEjOTEc=;PbQlDS5gZI1YiYvPtbl4NjtKauR
 OZi4hGEoMi+pZMLRN+dp43OZr86FtOosAGXNZPCgIdXzcfWhkhRisBrgXUlk2VwVcoU31v+5M
 JVtCgZlHjE9SUq3oAzSPFJwLzI5vjaL2G6qN1Vh9YfEifq1Y6QyvgXb8ivAwKfNqe19hSWupJ
 5QIryzaaInARGN+juvM3DXZNhUQtA2HgW8qyEIa+RPAas2rMrH/INZuyctxTAoAVJLnYRkL9H
 9P4tPfwByNdQw7h5XifmCIaJ++MBwPy9J3TAap/CKnvz0ZHJqQqxqWRWfxO+PKk8oC0z0wCfw
 d1GFy0SFx4r137ZrwByZkdd3ADZlYIys4Rxqup2NmkC1TxCDoyWr6hmMXxH8G24fgs1tW5ix0
 S3m4cGKuF/8wHebV3bqSxbXiCBP9pUuNH+9dcMdIhj5V8M5gzvYZ4oI9QRA2bGqJ/xjQ/4tzu
 A+1SP9UZjkE4AQARXXDpExyjte7K0d1kQl26GumV8Ltu/lsoneGmLhIXia8GVlF1lmbWb40YQ
 ay0ZFQVd7Mu8h0Wz/YxK1DR98rEHfKUQdABb3G8yOOOCOg1YwZAuj7vdyjZ7QOiPRSykzBYsq
 wiyO18A6XxBnBzjuVT0OJ28mo8FqKxvEIObSeYhDofrAhsDmemIDHxMYZBI3nvVxl+FBUDPUJ
 mV5W75JM7GWNs2qVrr818/b3dFgfEXcY35//1zyhR0lEOVy8DiDX65BahgyuJ8HzP/GnJYt4Y
 KG7daEJkpinXT9TArxlxFy7ZGWlLkJknG0V82R5KrfVTBbFXN8wwK+btKF0kGu6lTkf5ilkx9
 CCgp6Yn88RBf5cIUAE2rFljQ==

> When iio_get_acpi_device_name_and_data() fails, the ddata may be left
> uninitialised. Initialise it to NULL.

Would a summary phrase like =E2=80=9CAssign NULL to ddata in isl29018_prob=
e()=E2=80=9D be helpful?


How do you think about a null pointer check also with the local variable =
=E2=80=9Cname=E2=80=9D instead?

Regards,
Markus

