Return-Path: <linux-iio+bounces-20182-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BF1ACC7F9
	for <lists+linux-iio@lfdr.de>; Tue,  3 Jun 2025 15:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4933A27B7
	for <lists+linux-iio@lfdr.de>; Tue,  3 Jun 2025 13:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4397B231828;
	Tue,  3 Jun 2025 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="QhJAu2f1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977682253EC;
	Tue,  3 Jun 2025 13:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748957798; cv=none; b=qq8H6ZfSpexaXIRkecPEAxIl6JbvcGaA/uXyBoDM44nRwZMQ2KBuI3uZHelhrN4PM3LBEuoZSS6xw0h/RiYYxRtNp0UTFyQn6eHUrFiIQXr920vNRXquroxi91yM95mvkuTZCEIoDkmYSLz8RK+STHIUeCGu43lSSCYYgkfF3kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748957798; c=relaxed/simple;
	bh=u8bo3OjBKLU25bFgIAgJKN30zbeJrVdkYwBGgX+OFbU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pix9yBTQvUkvLe2lOjMUSkoKk0P5keY4XFecAXOoQzpjHUYAztO6AhpJwEdL087Oy2NVq0rCHEDhhKKDzd4WSM9wtO58KmivbZOVBz93RlkUoEw0YAHQUQn5ic20aR1jKqkKQD1CWpnc4ho4Z99lp/ZJ7pxUiiqwtq2lPuB/Wsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=QhJAu2f1; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1748957781; x=1749216981;
	bh=u8bo3OjBKLU25bFgIAgJKN30zbeJrVdkYwBGgX+OFbU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=QhJAu2f16w6861P/LsAFJGRMIXZtAYN4wFH99SwJ90CKVVjL8XYxGdvoZRB2Hek3G
	 0lN1SZDnfAVw8d4PSoQFM7yYv0VZ+N9JboN4Si5voIMhMThN4qELqngbIl8Wm+sCxI
	 I2Zy3mSLsf2qY+1w7Awd85JL2mcCUqn3fKNhWEwqQNcaUr1mV5kJEfMcgpFRwicWEW
	 oWo3FUkcuYHGs2Ji4lw/qadN+orbh8XuYRGa8+OEdARVcLPHY80ntfDJ1G3hT4CDSz
	 jVmCM8RKaYNZRL9qpyvSq2X+uTJ2JshzqJH+G79gPo5AOUsWwHlkwOYpR7SuJMW+v/
	 Ie4EChrPu/TpA==
Date: Tue, 03 Jun 2025 13:36:15 +0000
To: David Lechner <dlechner@baylibre.com>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: fxls8962af: Fix use after free in fxls8962af_fifo_flush
Message-ID: <5zdrnf75n2nfuk3bjzynnj2b57fkptk3lltjf4xaloxorzk27w@6qwdcn5tfynz>
In-Reply-To: <b1f0dbee-13bd-4e5c-90b9-c6d88cb15971@baylibre.com>
References: <20250603-fxlsrace-v2-1-5381b36ba1db@geanix.com> <b1f0dbee-13bd-4e5c-90b9-c6d88cb15971@baylibre.com>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: bea842e6bfb0e313869a8703f93e9a8f3731ba7e
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2025 at 08:29:51AM +0100, David Lechner wrote:
> On 6/3/25 7:25 AM, Sean Nyekjaer wrote:
> > fxls8962af_fifo_flush() uses indio_dev->active_scan_mask (with
> > iio_for_each_active_channel()) without making sure the indio_dev
> > stays in buffer mode.
> > There is a race if indio_dev exits buffer mode in the middle of the
> > interrupt that flushes the fifo. Fix this by calling
> > synchronize_irq() to ensure that no interrupt is currently running when
> > disabling buffer mode.
> >
> > Unable to handle kernel NULL pointer dereference at virtual address 000=
00000 when read
> > [...]
> > _find_first_bit_le from fxls8962af_fifo_flush+0x17c/0x290
> > fxls8962af_fifo_flush from fxls8962af_interrupt+0x80/0x178
> > fxls8962af_interrupt from irq_thread_fn+0x1c/0x7c
> > irq_thread_fn from irq_thread+0x110/0x1f4
> > irq_thread from kthread+0xe0/0xfc
> > kthread from ret_from_fork+0x14/0x2c
> >
> > Fixes: 79e3a5bdd9ef ("iio: accel: fxls8962af: add hw buffered sampling"=
)
> > Cc: stable@vger.kernel.org
> > Suggested-by: David Lechner <dlechner@baylibre.com>
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > ---
> > Changes in v2:
> > - As per David's suggestion; switched to use synchronize_irq() instead.
> > - Link to v1: https://lore.kernel.org/r/20250524-fxlsrace-v1-1-dec506dc=
87ae@geanix.com
> Were you able to find a way to reproduce the bug well enough to
> test this?
>=20

Yeah. Sorry I didn't included the reproducer :)

I added:
diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls89=
62af-core.c
index f2558fba491d..ce9a14245f83 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -1040,6 +1040,8 @@ static irqreturn_t fxls8962af_interrupt(int irq, void=
 *p)
 =09unsigned int reg;
 =09int ret;
=20
+=09usleep_range(10000, 15000);
+
 =09ret =3D regmap_read(data->regmap, FXLS8962AF_INT_STATUS, &reg);
 =09if (ret)
 =09=09return IRQ_NONE;

And it was reproduceable within 10 secs:
root@localhost:/sys/bus/iio/devices/iio:device0/buffer0#
while true; do echo 1 > enable; sleep 1; echo 0 > enable; sleep 1; done

With synchronize_irq(data->irq); I have not been able to reproduce it.

/Sean


