Return-Path: <linux-iio+bounces-25693-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CCEC2164D
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 18:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62CFE3A944D
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 17:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192103678A7;
	Thu, 30 Oct 2025 17:08:27 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01063324B0A;
	Thu, 30 Oct 2025 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844106; cv=none; b=AlHJjto5xmHCqaSlkadmztWJYT7M1xurwkw90NH8fF8KPcQFUiG7M+NOfVqZRztJ0Vi4zCtpZ4pzAcMSHHpjUXNTuyNvKzxH9D7qftUoUB7JLrpV6uKo4BptJm7CFnCBrHVQYyyMmWefUj819OIJ/jZdZLTRiUvzT2dMIWBiZeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844106; c=relaxed/simple;
	bh=wI5zQzysAt3AhcFRHjJbowZUSaaj3cys10iuJpTfGtQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sJ/I0gPagtsGpbnRd44/6zLNWG6Wqgc5KWNbcZIYOjrzD0Eo5039Pudlxsc7l5xZ+3koF2jmTeF8q/h/wtpx1mGBCB925x5BiBkKFe4QDzEpmIEgGpgrjcM9cD+yaSfJP9oNazWmZPMbak7OHVtCx9aCEpw/TUE9uV23MMlkoqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cy9T32j31z6L57R;
	Fri, 31 Oct 2025 01:04:39 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id D80131402F0;
	Fri, 31 Oct 2025 01:08:13 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 17:08:13 +0000
Date: Thu, 30 Oct 2025 17:08:11 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ajith Anandhan <ajithanandhan0406@gmail.com>
CC: Krzysztof Kozlowski <krzk@kernel.org>, <linux-iio@vger.kernel.org>,
	<jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/3] iio: adc: Add support for TI ADS1120 ADC
Message-ID: <20251030170811.0000019d@huawei.com>
In-Reply-To: <CABPXPSLKa9SasCpunrTSuoYaPcvPGTCZX+FPs9uq19m8a2XNRg@mail.gmail.com>
References: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
	<efd2690f-35ba-4104-ac88-4e068984d19f@kernel.org>
	<CABPXPSKzOhGicdPLoMFy8xvd0Xx5_D2P2pduteY3QhDRV4d2Ow@mail.gmail.com>
	<CABPXPSLKa9SasCpunrTSuoYaPcvPGTCZX+FPs9uq19m8a2XNRg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 30 Oct 2025 22:28:10 +0530
Ajith Anandhan <ajithanandhan0406@gmail.com> wrote:

> Hi Krzysztof,
>=20
> Thank you for the feedback! I=E2=80=99ll resend this as a regular PATCH s=
eries
> shortly. I appreciate you taking the time to review.
Given you've sent it out, leave it as RFC for a day or so.

>=20
> Best regards,
> Ajith
>=20
> On Thu, Oct 30, 2025 at 10:19=E2=80=AFPM Ajith Anandhan
> <ajithanandhan0406@gmail.com> wrote:
> >
> > Thank you for the feedback! I=E2=80=99ll resend this as regular PATCH s=
eries shortly. I appreciate you taking the time to review.
> >
> > Best regards,
> > Ajith
> >
> > On Thu, Oct 30, 2025 at 10:10=E2=80=AFPM Krzysztof Kozlowski <krzk@kern=
el.org> wrote: =20
> >>
> >> On 30/10/2025 17:34, Ajith Anandhan wrote: =20
> >> > This RFC patch series adds support for the Texas Instruments ADS1120,
> >> > a precision 16-bit delta-sigma ADC with SPI interface.
> >> >
> >> > The driver provides:
> >> > - 4 single-ended voltage input channels
> >> > - Programmable gain amplifier (1 to 128)
> >> > - Configurable data rates (20 to 1000 SPS)
> >> > - Single-shot conversion mode
> >> >
> >> > I'm looking for feedback on:
> >> > 1. The implementation approach for single-shot conversions
> >> > 2. Any other suggestions for improvement =20
> >>
> >>
> >> No need to call your patches RFC then. It only stops from merging and
> >> some people will not review the code (RFC means not ready for inclusio=
n).
> >>
> >> Best regards,
> >> Krzysztof =20
>=20


