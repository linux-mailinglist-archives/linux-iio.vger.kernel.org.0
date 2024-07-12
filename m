Return-Path: <linux-iio+bounces-7544-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AC792FC9D
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 16:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145D91C2239A
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA5A170854;
	Fri, 12 Jul 2024 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="nks7UVPQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E171E4A9;
	Fri, 12 Jul 2024 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720794815; cv=none; b=EfbtuUT2vwj11NkBsd3S/iwPzQYWPO6G9p1056gdQ2ER7v5RgQgj1u2CUIe5Uiz99MbFYUhRWo+0z+TapQdA9g1KF+r3jWpdpf91TRShUDM5lktc/b8oidcdv+gliV6CufKEhyL5HhmIaRcjvYrKhR3h5JerG8OK/gWYDBMVFys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720794815; c=relaxed/simple;
	bh=z0ahnSbppYt7pmmF7PIuvpeQfD5WebtYXp3vsX/l3/8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=LOGDDsK7nkXYf0HnbXF1g9I0QDOLRVBmEaoqCAboRyPwNowOTxKutPQe9kJ/rm0v/KTwtBB4FNd0SH1+O5RkWA6KM2QZkeqBGjW+ZbpJXVdRQbJLO99M+FH8xtt5DjMlqx8kQlYRsJjhSSRDmug3It+rnXVDKAzuVEvyKr7PX1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=nks7UVPQ; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720794792; x=1721399592; i=markus.elfring@web.de;
	bh=hxuT+Hbd7wy8hEc4HWbbzcHkmuz5r+aDxi/+eSIYkro=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nks7UVPQQOIV8NaVs+uRUWtJlePZd8jO5RKBspn3BRQ2gxA7WN2AFgS1CxfFvPFE
	 lcfH0DSaO24AlSotJndPBEoSU3opXpx1EMYdEgvxdoNQfgY74hNtiCOUfmpD3DIt2
	 8M8ilFS0nQ2Y8JBqB4Y5F/LrxbyIBFXjGqfgbe66uZBHMSLXmq+tQHPo97hoQTrW7
	 AQkIoNlaSafOU0tzVVEToEiQzCCUD/LeySOWvHjYVBGBxLlsBC00YeaLHo2lCkx7e
	 WF94FRUGKbn/xj9yU96UBW/w61xg3T1xUqHEIK843XffSBf0BONUve+FQb91ENFlk
	 xWr+g0VHIo7kSt8NlA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MwR4D-1sBhvB15iH-00qrLJ; Fri, 12
 Jul 2024 16:33:12 +0200
Message-ID: <dc509d3a-7e25-49f3-94a2-5a6bb36f062d@web.de>
Date: Fri, 12 Jul 2024 16:33:04 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: shuaijie wang <wangshuaijie@awinic.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Waqar Hameed <waqar.hameed@axis.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kangjiajun@awinic.com,
 Nick Li <liweilei@awinic.com>
References: <20240712113200.2468249-3-wangshuaijie@awinic.com>
Subject: Re: [PATCH V3 2/2] Add support for Awinic proximity sensor
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240712113200.2468249-3-wangshuaijie@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H4eKD3Uf3BiWxrVZItGUlQHqUbqukHshvVPZ1sli3mcpJPkqjN3
 NUCi6quSvopxXguieyg8dn2k6yxTZnLppk6TKyzi1/fJpNpk4f7pe9ovOT7eFgCCfVHWNes
 C29SUNLoLjU1sVOjXordv6yPOrxtqbwdPiWNCtG5fnU9/pURpxgnfhAOqJR0DwDrrl8DGjB
 TMqP/t5z2ZK8FdSMt7ZUg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:op1lem1IDBY=;syVkAhnEwc2HUnMLJE8lKkQuPT7
 7j50q8aG7IHbM9M7bbRqVEDoJB8OXmCCtkP61ZZiyQ+4ULTSSLwH3c+mCui5Ljn8PPAy7e485
 rupH36UbuZki4UKrFpx/N9n/aNsVT3RCVLflRxaBj6wJTIdG3DpTMmSb4MK7XtzcO2WkxpH+R
 q1/zt9Wo5pf+HrEZv+Med2gfWiZMSDlJEHDMI6K3PDkxo2zNu39c1NnrgxdjG/Wuc/GTxSLTY
 wml38XcrnL6B2+0UTRYXSgUJp8sPiXMvYCo9uejqOIqfjiXdMXUGvk5331cuAiUlPz4dL/4WU
 3gHPVE4NOKlKq71PNSMfpM0HzGdsiAUtmeYAh25KuOv0CBruSHx1Ngday01RZFxnUsXQFXmfu
 H5iLD4K3F0u+fwfLkxDCM1n2kUvd5sV9P6T6tiH+6D4JEL3yBsd82rjn8Vg8aBRERBwr3p6Ig
 SgcxSjiyzbxGZx8b4z10jKEisrf8+fD3zeiru6CAcyHkTsvp+vj5awTZbVxqalreCoMCNyGqM
 G3Wk5TkIOOeG8lxc5viJ7+C3EOmeeEuFKk3tmu7vO4Sc2arAFCOXzCjknYSND4jiMl0/qLkfC
 EZsI3siLpc2kDMScYq/+rd1AzniGk0pVpenc30NrJjispKx9OY0zttpyt9nRuw3U/NRD3SXQw
 Oyh7o52iofyLIxzlFxjkRDp0owSrENQQO67w0Zgco0kG6ZXvtm+Q6ONevXcyfEUm0sDOvMO10
 1IzfvMiRTRTHNORDLgsP9tec4opqOgZC7wF7TNm6NYjq9hTlpBGqpNQK8K1odOqecnkg3K9ua
 UJVNpf1VXIxK8D/FZrtHAW8A==

Please add a subsystem specification to the message subject.


=E2=80=A6
> +++ b/drivers/iio/proximity/aw_sar.c
> @@ -0,0 +1,1850 @@
=E2=80=A6
> +static ssize_t
> +update_reg_store(struct device *dev, struct device_attribute *attr, con=
st char *buf, size_t count)
> +{
=E2=80=A6
> +	if (flag =3D=3D AW_TRUE) {
> +		mutex_lock(&aw_sar_lock);
> +		aw_sar_soft_reset(p_sar);
> +		aw_sar_update_reg_set_func(p_sar);
> +		mutex_unlock(&aw_sar_lock);
> +	}
> +
> +	return count;
> +}
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(mutex)(&aw_sar_lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.10-rc7/source/include/linux/mutex.h#L1=
96

Regards,
Markus

