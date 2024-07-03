Return-Path: <linux-iio+bounces-7193-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010BC925387
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 08:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24AC01C2251B
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 06:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B502B12E1DB;
	Wed,  3 Jul 2024 06:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DhfptBEK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131DBC2F2
	for <linux-iio@vger.kernel.org>; Wed,  3 Jul 2024 06:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719987284; cv=none; b=SqsUh8fER6J5Slh4cLApOXFQTbbwO5F+jyLV2vnSO9kNDnlGj3IUAe2MzopwVjTZkVjGyBDvV9bR/DXCTze2OeL+ahDQaTEMFPsCW9K0hTpqXwTbnvRvix//xjNrbm16rRg1qL76i6BSS/LOS6mdiT3dUq0rYjahNW+1Mr5/FbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719987284; c=relaxed/simple;
	bh=h3nYBkZyQm6AbFOiEdjwuGs75LEIdAIYcotgGzDddD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NaDlxZZbaTdC+g353EgXXMMyzDI/t6zR2c1+NmqgpvJ45Sh7Eg14/sbMei/4owt1w/mgCmNZ1OUoD7HJlWDd98DNWWD34W+8DP7Ul9Qc0sOK1TU8TLwewz2PqTv1udjKNlhDsQ7xXmTXzRaQokz6vVDo2nHlWle43kzatUUYliQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DhfptBEK; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-80f5d511679so106813241.1
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2024 23:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719987281; x=1720592081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTMF30007q4imLniEEOl7ToYvL7s2Aflh7ChDoa37vY=;
        b=DhfptBEK26omPfVwImyO2jwK0PYDPa4wB9H4Qlr6o14SGmKx0cWGuBHIXlxQ6oLxUN
         g8K61WgJ9jsiQrXRYW4clLvNh5aLRA21ItfbQVoJxU+atU8U67N1dGeekvJuiXGlh7Ks
         Lf0bph2HCMKwkozn3GLaH1UtbJvUKLQuGGdBOxgLPEOZJfP3E/pvvjxBjm9PyLWxkRMA
         +YQx5MdwAbyEanh9X0ezGyJ/5frLDIsh8OKRU5R8e/baqHXKOFKzmTnQUpthGUhJAwMS
         qnCaSG6tPKfxpl8cUbSDFBT33NzkntjpyheCenX3vv0Mcl5JjortuucnkQqtH+F11fjM
         r8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719987281; x=1720592081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTMF30007q4imLniEEOl7ToYvL7s2Aflh7ChDoa37vY=;
        b=vNpNWbdXmOcu71d/f/bEdEPltMTFcLKISS/mIyRkhbW2+pGLWtUMaSTOdZiLXJkZgJ
         /3mfwts7uFxoivTp9x9kajXaMD3PXlrMzKj5zRzBXRSxThncp+HzYRZB7EAr99fVkHo+
         ETUdK2gbYjOsIxVRgvl2RwQa+OYQFgCBAMQXvjRWcENOhgs9/0OTV29L5uLHcfKOU6Op
         6Pz3nr+DEquZXY+uutNnx/HXtKOaGrLt6/GODbrDopCkAiBD9KpLABVaqe50Oj4auraI
         AHZtLBkgjs1uYMBMj3EwRTmE/SuF86eARU9DFXRrxDja+vCkKrCQtAVjUkouA6p6HzsJ
         8E6g==
X-Gm-Message-State: AOJu0Yx1yc8qtEamYiSoOJ1gmTHq9PCrJXg1NDfHUZJ+TdBFqczOjSd2
	6/wZPDtTTuKPFITntCmV8HxpLMQvpCs4Adq9dQHDk3GpQ3rYDHDth1Fm50ayGnvrEc8Lq13kelD
	Jd/Ugzi6yvp0QkTk48Ap6dltwd+zMNtTPPPrnzw==
X-Google-Smtp-Source: AGHT+IHNQbRjjz+Ub/Cfgiv2LMHd+fD7uT+gIVCWJSvCrz74a8SKO0tTpCM/7/py7cbIxuCuFYgmx7HlTZtzC5BY4Xc=
X-Received: by 2002:a05:6102:160f:b0:48d:b0a3:fe17 with SMTP id
 ada2fe7eead31-48faf14127emr10384366137.3.1719987280961; Tue, 02 Jul 2024
 23:14:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com> <20240702-dev-iio-masklength-private-v1-3-98193bf536a6@analog.com>
In-Reply-To: <20240702-dev-iio-masklength-private-v1-3-98193bf536a6@analog.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Wed, 3 Jul 2024 09:14:28 +0300
Message-ID: <CA+GgBR8ALbq0aiNOUjiVG5rpoMUS17ghncPJB3C-CFh5ymKmmQ@mail.gmail.com>
Subject: Re: [PATCH 03/20] iio: buffer: make use of iio_get_masklength()
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Cosmin Tanislav <cosmin.tanislav@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Dmitry Rokosov <ddrokosov@sberdevices.ru>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 7:02=E2=80=AFPM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>
> Use iio_get_masklength() to access '.masklength' so it can be annotated
> as __private when there are no more direct users of it.
>
> While at it, remove some unneeded line breaks.
>

Reviewed-by: Alexandru Ardelean <aardelean@baylibre.com>

> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/buffer/industrialio-buffer-cb.c   |  2 +-
>  drivers/iio/buffer/industrialio-hw-consumer.c |  4 +--
>  drivers/iio/industrialio-buffer.c             | 50 ++++++++++++---------=
------
>  3 files changed, 26 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c b/drivers/iio/bu=
ffer/industrialio-buffer-cb.c
> index 4c12b7a94af59..4befc9f55201e 100644
> --- a/drivers/iio/buffer/industrialio-buffer-cb.c
> +++ b/drivers/iio/buffer/industrialio-buffer-cb.c
> @@ -77,7 +77,7 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct dev=
ice *dev,
>         }
>
>         cb_buff->indio_dev =3D cb_buff->channels[0].indio_dev;
> -       cb_buff->buffer.scan_mask =3D bitmap_zalloc(cb_buff->indio_dev->m=
asklength,
> +       cb_buff->buffer.scan_mask =3D bitmap_zalloc(iio_get_masklength(cb=
_buff->indio_dev),
>                                                   GFP_KERNEL);
>         if (cb_buff->buffer.scan_mask =3D=3D NULL) {
>                 ret =3D -ENOMEM;
> diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/iio/=
buffer/industrialio-hw-consumer.c
> index fb58f599a80b1..526b2a8d725d1 100644
> --- a/drivers/iio/buffer/industrialio-hw-consumer.c
> +++ b/drivers/iio/buffer/industrialio-hw-consumer.c
> @@ -52,6 +52,7 @@ static const struct iio_buffer_access_funcs iio_hw_buf_=
access =3D {
>  static struct hw_consumer_buffer *iio_hw_consumer_get_buffer(
>         struct iio_hw_consumer *hwc, struct iio_dev *indio_dev)
>  {
> +       unsigned int mask_longs =3D BITS_TO_LONGS(iio_get_masklength(indi=
o_dev));
>         struct hw_consumer_buffer *buf;
>
>         list_for_each_entry(buf, &hwc->buffers, head) {
> @@ -59,8 +60,7 @@ static struct hw_consumer_buffer *iio_hw_consumer_get_b=
uffer(
>                         return buf;
>         }
>
> -       buf =3D kzalloc(struct_size(buf, scan_mask, BITS_TO_LONGS(indio_d=
ev->masklength)),
> -                     GFP_KERNEL);
> +       buf =3D kzalloc(struct_size(buf, scan_mask, mask_longs), GFP_KERN=
EL);
>         if (!buf)
>                 return NULL;
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio=
-buffer.c
> index 0138b21b244f0..389bfb238b510 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -473,18 +473,19 @@ static bool iio_validate_scan_mask(struct iio_dev *=
indio_dev,
>  static int iio_scan_mask_set(struct iio_dev *indio_dev,
>                              struct iio_buffer *buffer, int bit)
>  {
> +       unsigned int masklength =3D iio_get_masklength(indio_dev);
>         const unsigned long *mask;
>         unsigned long *trialmask;
>
> -       if (!indio_dev->masklength) {
> +       if (!masklength) {
>                 WARN(1, "Trying to set scanmask prior to registering buff=
er\n");
>                 return -EINVAL;
>         }
>
> -       trialmask =3D bitmap_alloc(indio_dev->masklength, GFP_KERNEL);
> +       trialmask =3D bitmap_alloc(masklength, GFP_KERNEL);
>         if (!trialmask)
>                 return -ENOMEM;
> -       bitmap_copy(trialmask, buffer->scan_mask, indio_dev->masklength);
> +       bitmap_copy(trialmask, buffer->scan_mask, masklength);
>         set_bit(bit, trialmask);
>
>         if (!iio_validate_scan_mask(indio_dev, trialmask))
> @@ -492,12 +493,11 @@ static int iio_scan_mask_set(struct iio_dev *indio_=
dev,
>
>         if (indio_dev->available_scan_masks) {
>                 mask =3D iio_scan_mask_match(indio_dev->available_scan_ma=
sks,
> -                                          indio_dev->masklength,
> -                                          trialmask, false);
> +                                          masklength, trialmask, false);
>                 if (!mask)
>                         goto err_invalid_mask;
>         }
> -       bitmap_copy(buffer->scan_mask, trialmask, indio_dev->masklength);
> +       bitmap_copy(buffer->scan_mask, trialmask, masklength);
>
>         bitmap_free(trialmask);
>
> @@ -517,7 +517,7 @@ static int iio_scan_mask_clear(struct iio_buffer *buf=
fer, int bit)
>  static int iio_scan_mask_query(struct iio_dev *indio_dev,
>                                struct iio_buffer *buffer, int bit)
>  {
> -       if (bit > indio_dev->masklength)
> +       if (bit > iio_get_masklength(indio_dev))
>                 return -EINVAL;
>
>         if (!buffer->scan_mask)
> @@ -733,8 +733,7 @@ static int iio_compute_scan_bytes(struct iio_dev *ind=
io_dev,
>         int length, i, largest =3D 0;
>
>         /* How much space will the demuxed element take? */
> -       for_each_set_bit(i, mask,
> -                        indio_dev->masklength) {
> +       for_each_set_bit(i, mask, iio_get_masklength(indio_dev)) {
>                 length =3D iio_storage_bytes_for_si(indio_dev, i);
>                 if (length < 0)
>                         return length;
> @@ -855,6 +854,7 @@ static int iio_verify_update(struct iio_dev *indio_de=
v,
>                              struct iio_device_config *config)
>  {
>         struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio=
_dev);
> +       unsigned int masklength =3D iio_get_masklength(indio_dev);
>         unsigned long *compound_mask;
>         const unsigned long *scan_mask;
>         bool strict_scanmask =3D false;
> @@ -863,7 +863,7 @@ static int iio_verify_update(struct iio_dev *indio_de=
v,
>         unsigned int modes;
>
>         if (insert_buffer &&
> -           bitmap_empty(insert_buffer->scan_mask, indio_dev->masklength)=
) {
> +           bitmap_empty(insert_buffer->scan_mask, masklength)) {
>                 dev_dbg(&indio_dev->dev,
>                         "At least one scan element must be enabled first\=
n");
>                 return -EINVAL;
> @@ -917,7 +917,7 @@ static int iio_verify_update(struct iio_dev *indio_de=
v,
>         }
>
>         /* What scan mask do we actually have? */
> -       compound_mask =3D bitmap_zalloc(indio_dev->masklength, GFP_KERNEL=
);
> +       compound_mask =3D bitmap_zalloc(masklength, GFP_KERNEL);
>         if (!compound_mask)
>                 return -ENOMEM;
>
> @@ -927,20 +927,19 @@ static int iio_verify_update(struct iio_dev *indio_=
dev,
>                 if (buffer =3D=3D remove_buffer)
>                         continue;
>                 bitmap_or(compound_mask, compound_mask, buffer->scan_mask=
,
> -                         indio_dev->masklength);
> +                         masklength);
>                 scan_timestamp |=3D buffer->scan_timestamp;
>         }
>
>         if (insert_buffer) {
>                 bitmap_or(compound_mask, compound_mask,
> -                         insert_buffer->scan_mask, indio_dev->masklength=
);
> +                         insert_buffer->scan_mask, masklength);
>                 scan_timestamp |=3D insert_buffer->scan_timestamp;
>         }
>
>         if (indio_dev->available_scan_masks) {
>                 scan_mask =3D iio_scan_mask_match(indio_dev->available_sc=
an_masks,
> -                                               indio_dev->masklength,
> -                                               compound_mask,
> +                                               masklength, compound_mask=
,
>                                                 strict_scanmask);
>                 bitmap_free(compound_mask);
>                 if (!scan_mask)
> @@ -1005,6 +1004,7 @@ static int iio_buffer_add_demux(struct iio_buffer *=
buffer,
>  static int iio_buffer_update_demux(struct iio_dev *indio_dev,
>                                    struct iio_buffer *buffer)
>  {
> +       unsigned int masklength =3D iio_get_masklength(indio_dev);
>         int ret, in_ind =3D -1, out_ind, length;
>         unsigned int in_loc =3D 0, out_loc =3D 0;
>         struct iio_demux_table *p =3D NULL;
> @@ -1016,17 +1016,13 @@ static int iio_buffer_update_demux(struct iio_dev=
 *indio_dev,
>
>         /* First work out which scan mode we will actually have */
>         if (bitmap_equal(indio_dev->active_scan_mask,
> -                        buffer->scan_mask,
> -                        indio_dev->masklength))
> +                        buffer->scan_mask, masklength))
>                 return 0;
>
>         /* Now we have the two masks, work from least sig and build up si=
zes */
> -       for_each_set_bit(out_ind,
> -                        buffer->scan_mask,
> -                        indio_dev->masklength) {
> +       for_each_set_bit(out_ind, buffer->scan_mask, masklength) {
>                 in_ind =3D find_next_bit(indio_dev->active_scan_mask,
> -                                      indio_dev->masklength,
> -                                      in_ind + 1);
> +                                      masklength, in_ind + 1);
>                 while (in_ind !=3D out_ind) {
>                         ret =3D iio_storage_bytes_for_si(indio_dev, in_in=
d);
>                         if (ret < 0)
> @@ -1036,8 +1032,7 @@ static int iio_buffer_update_demux(struct iio_dev *=
indio_dev,
>                         /* Make sure we are aligned */
>                         in_loc =3D roundup(in_loc, length) + length;
>                         in_ind =3D find_next_bit(indio_dev->active_scan_m=
ask,
> -                                              indio_dev->masklength,
> -                                              in_ind + 1);
> +                                              masklength, in_ind + 1);
>                 }
>                 ret =3D iio_storage_bytes_for_si(indio_dev, in_ind);
>                 if (ret < 0)
> @@ -1646,6 +1641,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct=
 iio_buffer *buffer,
>                                              int index)
>  {
>         struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio=
_dev);
> +       unsigned int masklength =3D iio_get_masklength(indio_dev);
>         struct iio_dev_attr *p;
>         const struct iio_dev_attr *id_attr;
>         struct attribute **attr;
> @@ -1708,8 +1704,8 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct=
 iio_buffer *buffer,
>                                 iio_dev_opaque->scan_index_timestamp =3D
>                                         channels[i].scan_index;
>                 }
> -               if (indio_dev->masklength && !buffer->scan_mask) {
> -                       buffer->scan_mask =3D bitmap_zalloc(indio_dev->ma=
sklength,
> +               if (masklength && !buffer->scan_mask) {
> +                       buffer->scan_mask =3D bitmap_zalloc(masklength,
>                                                           GFP_KERNEL);
>                         if (!buffer->scan_mask) {
>                                 ret =3D -ENOMEM;
> @@ -1879,7 +1875,7 @@ void iio_buffers_free_sysfs_and_mask(struct iio_dev=
 *indio_dev)
>  bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
>                                    const unsigned long *mask)
>  {
> -       return bitmap_weight(mask, indio_dev->masklength) =3D=3D 1;
> +       return bitmap_weight(mask, iio_get_masklength(indio_dev)) =3D=3D =
1;
>  }
>  EXPORT_SYMBOL_GPL(iio_validate_scan_mask_onehot);
>
>
> --
> 2.45.2
>
>
>

