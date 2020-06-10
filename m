Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F0B1F57D2
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jun 2020 17:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgFJP3T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Jun 2020 11:29:19 -0400
Received: from smtpout1.mo803.mail-out.ovh.net ([79.137.123.219]:59307 "EHLO
        smtpout1.mo803.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726979AbgFJP3T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jun 2020 11:29:19 -0400
Received: from pro2.mail.ovh.net (unknown [10.109.138.102])
        by mo803.mail-out.ovh.net (Postfix) with ESMTPS id D1527566F4AD;
        Wed, 10 Jun 2020 17:29:16 +0200 (CEST)
Received: from localhost (34.103.240.102) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 10 Jun
 2020 17:29:16 +0200
Date:   Wed, 10 Jun 2020 17:26:50 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     Hendrik Hoeth <hendrik.hoeth@air-avionics.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: BME-280 humidity over-/underflow
Message-ID: <20200610152650.GA8925@arch>
References: <20200610134507.GT2681@linta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200610134507.GT2681@linta.de>
X-Originating-IP: [34.103.240.102]
X-ClientProxiedBy: DAG3EX1.emp2.local (172.16.2.21) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 18179905796321860797
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudehiedgledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjihesthdtredttddtjeenucfhrhhomhepvfhomhgrshiiucffuhhsiiihnhhskhhiuceothhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejkeduleegkeejheegteegleetgffgkedtfeekhfejgfegteduveetudejiedugeenucffohhmrghinhepsghoshgthhdrtghomhdprghirhdqrghvihhonhhitghsrdgtohhmnecukfhppedtrddtrddtrddtpdefgedruddtfedrvdegtddruddtvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomhdprhgtphhtthhopehlihhnuhigqdhiihhosehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Hendrik,

On Wed, Jun 10, 2020 at 03:45:07PM +0200, Hendrik Hoeth wrote:
> Hi,
>
> I've discovered an over-/underflow problem for relative humidity
> measurements in drivers/iio/pressure/bmp280-core.c. At very low
> humidities the value measured by the sensor can fluctuate into the
> negative humidity range. The kernel driver then reports this as
> extremely large value (e.g. 4193085, corresponding to 4193% RH). The
> same probably happens at high humidity values, but with our climate
> chamber I was only able to look at the low end.
>
> To avoid this, the reference code in the BME-280 datasheet catches
> values < 0% RH and > 100% RH. These two lines are currently missing in
> the kernel driver.
>
> Attached you find a patch that fixed the problem for us. You can find
> the sensor datasheet at
> https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME280-DS002.pdf
> The code I'm talking about is in section 4.2.3 on page 25/26.
>
> Thanks a lot,
>
>    Hendrik

Seems this particular issue has been already fixed here:
dee2dabc0e4115b80945fe2c91603e634f4b4686 iio: bmp280: fix compensation of humidity

>
> --
> Garrecht Avionik GmbH | Wieslocher Str. 38 | 69190 Walldorf
> https://www.air-avionics.com/
> Tel.: +49 6224 98 96 999

> Fix underflow / overflow for humidity measurements
>
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 29c209cc1108..d1f36b044f05 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -270,6 +270,8 @@ static u32 bmp280_compensate_humidity(struct bmp280_data *data,
>  		* (((var * (s32)calib->H3) >> 11) + (s32)32768)) >> 10)
>  		+ (s32)2097152) * calib->H2 + 8192) >> 14);
>  	var -= ((((var >> 15) * (var >> 15)) >> 7) * (s32)calib->H1) >> 4;
> +	var = ((var < 0) ? 0 : var);
> +	var = ((var > 419430400) ? 419430400 : var);
>
>  	return var >> 12;
>  };

