Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF31D2272AE
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 01:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgGTXRH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jul 2020 19:17:07 -0400
Received: from crapouillou.net ([89.234.176.41]:40192 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727986AbgGTXRG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Jul 2020 19:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595287023; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QAeOX6l8QHvY1cS+Pj+8mgaWEO4yfMys+MgR7AGFpTc=;
        b=U53XZbq33UJn2lny40KSf1gG/0qtpEB2GbT6b/g3WuYiLhArTZjfEvus04HJ76lUp2ELdI
        qryOCWQRCzY/7j2oWBwxjB8oEslzgv72Mrp2TKghohFenpaw77ekGim+49jvdD+SceJ9f5
        9Y6+UNrfdR3sLZVpbmNTBOWkHX5SjQQ=
Date:   Tue, 21 Jul 2020 01:16:55 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 2/2] iio: afe: rescale: Implement write_raw
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Peter Rosin <peda@axentia.se>, od@zcrc.me,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <7CJSDQ.D8SUUUMJPNE02@crapouillou.net>
In-Reply-To: <20200215183249.2100b6e9@archlinux>
References: <20200210225438.112660-1-paul@crapouillou.net>
        <20200210225438.112660-2-paul@crapouillou.net>
        <20200215183249.2100b6e9@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Le sam. 15 f=E9vr. 2020 =E0 18:32, Jonathan Cameron <jic23@kernel.org> a=20
=E9crit :
> On Mon, 10 Feb 2020 19:54:38 -0300
> Paul Cercueil <paul@crapouillou.net> wrote:
>=20
>>  Implement write_raw by converting the value if writing the scale, or
>>  just calling the managed channel driver's write_raw otherwise.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   drivers/iio/afe/iio-rescale.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>=20
>>  diff --git a/drivers/iio/afe/iio-rescale.c=20
>> b/drivers/iio/afe/iio-rescale.c
>>  index 95802d9ee25e..a48f6af9316d 100644
>>  --- a/drivers/iio/afe/iio-rescale.c
>>  +++ b/drivers/iio/afe/iio-rescale.c
>>  @@ -35,6 +35,27 @@ struct rescale {
>>   	int *scale_data;
>>   };
>>=20
>>  +static int rescale_write_raw(struct iio_dev *indio_dev,
>>  +			     struct iio_chan_spec const *chan,
>>  +			     int val, int val2, long mask)
>>  +{
>>  +	struct rescale *rescale =3D iio_priv(indio_dev);
>>  +	unsigned long long tmp;
>>  +
>>  +	switch (mask) {
>>  +	case IIO_CHAN_INFO_SCALE:
>>  +		tmp =3D val * 1000000000LL;
>>  +		do_div(tmp, rescale->numerator);
>>  +		tmp *=3D rescale->denominator;
>>  +		do_div(tmp, 1000000000LL);
>>  +		return iio_write_channel_attribute(rescale->source, tmp, 0,
>>  +						   IIO_CHAN_INFO_SCALE);
>=20
> Why is val2 always 0?  Won't that only work if the backend device
> has integer scales?

Sorry, somehow I didn't see your answer.

Indeed, this will only work if the backend device has integer scales,=20
but what should I do? Just pass 'val2' instead of 0? Will the value be=20
correct if I only apply the scale ratio to 'val'?

Cheers,
-Paul


>>  +	default:
>>  +		return iio_write_channel_attribute(rescale->source,
>>  +						   val, val2, mask);
>>  +	}
>>  +}
>>  +
>>   static int rescale_convert(struct rescale *rescale, int type,
>>   			   const int val, const int val2,
>>   			   int *val_out, int *val2_out)
>>  @@ -110,6 +131,7 @@ static int rescale_read_avail(struct iio_dev=20
>> *indio_dev,
>>   }
>>=20
>>   static const struct iio_info rescale_info =3D {
>>  +	.write_raw =3D rescale_write_raw,
>>   	.read_raw =3D rescale_read_raw,
>>   	.read_avail =3D rescale_read_avail,
>>   };
>=20


