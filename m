Return-Path: <linux-iio+bounces-26624-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5A1C9BABA
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 14:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 675893481EB
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 13:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742B931CA42;
	Tue,  2 Dec 2025 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIh8HXe6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6AC31A056
	for <linux-iio@vger.kernel.org>; Tue,  2 Dec 2025 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764683436; cv=none; b=ICdGnrIEgF8sThfpS6kfLmWdhw7tIg9rubRlypgSrpvdvpAitQYM/6r3dIBsL/8NYtp/3o839ymMs/++/nklRdIcNV+0wJ7QUc3DTccm85zzkuIsTweuLMoKwY6K4l0qOovQuywJ+Cx0FsJj5DCvaogtJPpaaF/IxJvNKsEwB14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764683436; c=relaxed/simple;
	bh=LhaFwAdu/Fz6q5nxDw8k/AUqHqbHJARKQ2qgwoUK78o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JBbS+NmVi2M90VFthGqp+k2WMpc5tuvftvDL2OUX5kkQ4B8RUkwL9jYG9oy7BovvHmEQMx7H7/IJYbD7+cere0Oa+WkFfEAU+2Hufv//lydb0nQUMrz0Ajtbx8QzXU8PC9HHofPBCttrxgBg4WRCAR2z5LkeDnSK9A3Iegksn9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIh8HXe6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477b1cc8fb4so33647505e9.1
        for <linux-iio@vger.kernel.org>; Tue, 02 Dec 2025 05:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764683433; x=1765288233; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8gqmfPqUGJNnpZYL2jaQaSraxMW5RhwWoqjqG64qTZU=;
        b=gIh8HXe6XUGI5pLRDPYPiY2EPuwp3VIdC3D4XSIb1oC/wf9RmeQB/Gdk11m/rkjfk2
         rupijm/SNtmZct6rlm5tBdlIGaq+CnmIwx6TnziwvaEqosTDLtRb9QlKjlFwrlPDZhvQ
         7VrFq4B3oAGg1Boqhpfu5NDmNyz53G6gqtcWvIiiztmz4wst1MEGCXfZy/kthQrSHUNh
         KfcRSXYSrjc4qgfloza7QZEC1fPjqQoP+KqjsI+45QziNLQ6VKEi4KzjImRdcUXlZ+X9
         3cv32QPRQky27k5/ip4keN6l0HRTQO7z2dac+78RBy/dRfZM6kReSwbhMWDSq6W1QdQk
         EPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764683433; x=1765288233;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gqmfPqUGJNnpZYL2jaQaSraxMW5RhwWoqjqG64qTZU=;
        b=jCqkMDrkrPZrxmKTEO8T6Hukujl/IH7jDhcF4eVlPGeqYHYgQYjH7NbHh8/iYc/5kS
         f9ohXOrYOOTqzD+07hc7WgeG6nw4Xxhb9rdEv0lR1LTOMcHqmYN2g9+3UtrxU7jUCSvm
         hX0/72nYimlZG3gnRoZ3Sr3fJhbmqdRkAmcfbD+Aq+AeUDf2Bky2Xv12c1PYX927Nm1G
         Dq6NbNVE4jfiShvdte7cllCmoIL5VmVCWvkm1S8y/DP0sxLSC/jCDyWmRJPA6re7aXW3
         6yk4rcWDu+X0aUQiRknLfQ4M8maZhgqWEQjrbEk8eBft8Ipgs0GXvJTWC2PIjzP/yAuQ
         X0Ew==
X-Forwarded-Encrypted: i=1; AJvYcCW6crr/7MTzTtXFe5ysBq+y/evxEFNQdKvmW5wDcLCTBrMPnPQRMS/j/muJzs5LQ85WjcwWbbrqvXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOnxOEtHIdZrsTNMlPljOJI1IdXIhs2p2sRaRGjKomoNu3UuY4
	A46NCGszeLq63sMHMRb5n/c41k0UzZe/MzVUdR+8X7VsI7SXfIVdFXwc
X-Gm-Gg: ASbGnctkJbpC62doNQy+urLJmyWBwcIXyJQI+0/WHVYhwICdTIzsIsg5s3dKJq5oxYN
	Q+JSluqLQ5KqI5dJzfTlD89aLIct8Zgrkq7vFXKtjL4vZf52vxBQNHbzl2V+KG6D4Z0o3UTFB9F
	ttAXBz0NOU9x7eyigVu4MDQdxPN02dQ/5SHOZChGJcqKV46pGQlo1E+zg1WZ45q25Z9I3F2y6E+
	cX7pmFLezUwMGZXypWAv1cRk01X7I1LQFqEwPDlkcPXB40rbQOYBpWacpXlzWvWDbjJyFn5PAa7
	J0BQVYdgGgmUueOGVFGoJAKTkL0Qwj728zmg1J5BpagJS0PJwskpssWuAz8jtyUlkVfw7XSH8lx
	3QPZ/Cme80cx+hoLKHRXX3gUa+HPUEBfbfo9O1tm/UwAbcZT0SdHFCJDtiLZBmh9gctSO8/2Mz+
	u8fL6giO38pbnir8tZpFw=
X-Google-Smtp-Source: AGHT+IEV6IUEQ4zmnpCvt9yp7MvRVVkLGg7uNh0UVfL2Eu28c00bREziwfDzSdssdx2H79r09ZOyfA==
X-Received: by 2002:a05:600c:4694:b0:46e:4246:c90d with SMTP id 5b1f17b1804b1-47904ad06f3mr293663915e9.11.1764683432791;
        Tue, 02 Dec 2025 05:50:32 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479111438b9sm341578365e9.2.2025.12.02.05.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 05:50:32 -0800 (PST)
Message-ID: <6143064d409b8325bbbb2ddb1d468d5303b4303a.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] iio: adc: ad9467: fix ad9434 vref mask
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,  David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean	 <alexandru.ardelean@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Tue, 02 Dec 2025 13:51:12 +0000
In-Reply-To: <20251202-ad9434-fixes-v2-1-fa73d4eabbea@vaisala.com>
References: <20251202-ad9434-fixes-v2-0-fa73d4eabbea@vaisala.com>
	 <20251202-ad9434-fixes-v2-1-fa73d4eabbea@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-02 at 12:53 +0000, Tomas Melin wrote:
> The mask setting is 5 bits wide for the ad9434
> (ref. data sheet register 0x18 FLEX_VREF). Apparently the settings
> from ad9265 were copied by mistake when support for the device was added
> to the driver.
>=20
> Fixes: 4606d0f4b05f ("iio: adc: ad9467: add support for AD9434 high-speed=
 ADC")
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> ---
> =C2=A0drivers/iio/adc/ad9467.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index f7a9f46ea0dc405e25f312197df4b2131871b4bc..2d8f8da3671dac61994a1864a=
82cdbef7f54c1af 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -95,7 +95,7 @@
> =C2=A0
> =C2=A0#define CHIPID_AD9434			0x6A
> =C2=A0#define AD9434_DEF_OUTPUT_MODE		0x00
> -#define AD9434_REG_VREF_MASK		0xC0
> +#define AD9434_REG_VREF_MASK		GENMASK(4, 0)

In theory we should fix it using the same mask style as the other variants =
and then moving all to
GENMASK(). However, I do not feel strong about it and I can send a follow u=
p. Hence:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0
> =C2=A0/*
> =C2=A0 * Analog Devices AD9467 16-Bit, 200/250 MSPS ADC

