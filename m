Return-Path: <linux-iio+bounces-23433-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FB7B3C8E4
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 09:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53DA1B256A4
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 07:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F315927C854;
	Sat, 30 Aug 2025 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzTEfo6d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E012264A3;
	Sat, 30 Aug 2025 07:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756540011; cv=none; b=f7xX5prjTVn2iMYdA9geV1CDcrH8zv9EnOTZdW/HAJzcUZWYrqE937IFFuNCshsfwWCMSGbLjjWEMzwTjojWKp3Px95ZhJY8pVp3BjrQcoO7jPDCd4jtILvYHtqcidXvzkiHzfDAdbItMJTkbwqE4hwLubv9JlKyOn6Pz32Kkmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756540011; c=relaxed/simple;
	bh=joqA3WBk7uZDgfCA474wYs9Yexu7WW7ZJa/JQJXBojs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VzXr8ckInRrxlR1oiVl5p7K8nBYR/Hdr91LfzJpV3PK1pmEYn++1v1qOyyekzDtbWvgPw+I/xXhZhHC4Q+FHIpBGBYl0LAeqmLF7+kDmSUvfUrzvd65ztRZ3f8XXo6SkU836OcJISYErsqhm5CynnaqxKgxnXTJDv02LEG9ZzYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzTEfo6d; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afe9358fe77so408496866b.1;
        Sat, 30 Aug 2025 00:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756540008; x=1757144808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gksmX//afEFXTpT9qikoMfE6YMYjCcvIqKqPnbndjIg=;
        b=FzTEfo6dH1zwRKJSGe6tf88rW1BzrDBup/zbtHY69hb6T4NuGIlinfZtIL7ZWi+ad6
         aajCVS5G6OTqMPGICoqPACzYZ9tNm0witkwJiNSfPuc1ZF97SqaEotO7sJGTNiviRsQw
         0XIWSejUoxydCYQYfp4e+3RbNTACDB65NJe8gGc5tfXGeaBHcC9nf8CWuWVP7QmrepD/
         hsaBuX9k02GhYUy1BgprJXYYeCes48ieVaIPTFvS+vr0AvTSm7cREyzCw623taGsQ0BO
         TSHR9r3tc+onsi/5vIQXRwL60KvoN/LSMLf++96cE5lnaOviB9xPaJY5E5cVX2nt6X8D
         bVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756540008; x=1757144808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gksmX//afEFXTpT9qikoMfE6YMYjCcvIqKqPnbndjIg=;
        b=lZT7RBNkIOJIofO8KuJLPa1qSKlMBhxN/X/EzwcmfRVsEBVzQYTli5nHasS4cCqRAH
         +deNz/j1rAahFJ15JpbOQtwmeUzNCpvBooHNG9swQrjj6U2p7COse+i+D5HC2O6X9IDn
         xoKzpHW4DnzrnVg7voQxuOS+vnk+r+vhASa5tc1KMTGXaovH+yZ6jX3macK2x3ogbVpt
         Tq2ggDI3ZgEejrPZmdoza4EtE1oP0vsQ9KOjOH9SCQQfppFnqfqpgkj0mECGJfD6/hcn
         aIUxaFOy7UxJtFvEgaLHEkNABblD1rPGgwQlr9FjUopgCgLhHnB85ijSQi5OHvUfRI68
         /7tQ==
X-Forwarded-Encrypted: i=1; AJvYcCU00yRwmk9jvYaTj5wCgIS6A/NQnfZU6zE8+8ULA6afYeNS5VPe/zvL5wXuOGHFr+YSiPYr801DH3AeVHQ1@vger.kernel.org, AJvYcCUSJBrxHr8DTikfiu+c2S71S3xfeBGECQLHhaGgWXEKt9aPUD8/LDxDERqUIuhERYhDc5LmrG6whS2D@vger.kernel.org, AJvYcCWZ8HW0HDZNWSxem4Od56Nx47oHKlr/J1UvsBVsRAJoeCx6qShazkHZil2N4QJ+qdDPpjxQihG44yLT@vger.kernel.org, AJvYcCXOc7iSWYpFBFnKnp9g6iAKarLc0VNszxkSpy/4HVtOBrv+6/NGi30M7P3Iz9MoMbH+nIF47PBnr7iy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7vNBqj35u0Pq8HuO30zzMTnOeJbZx0AWzx06U6u7FtyGZp4Xc
	pEWdGnb0jVS1gcFP9Ty3iqLgZRp/fhMeJDIm/9yBU1DpiyDmqpujCPuJpshxTo+msfXZRkIgWop
	n+7z3BXCQsE32XVOHs3BQD/HNYqRm5Gg=
X-Gm-Gg: ASbGncttHNDBzObJdW0IGM1gzzDSIe3BNjmYmfUc+HF2SSHQZwEb7mBZGnJAnmGKWTd
	Gcl42+woHpTK85HjxBbwUnlEPt4YDZw3ZLAKvYZd/Idf/ow0LXUPBLaglfo5CvdOVvUNrAj2Kxk
	vmc3qm9Jkht8VPnDlDj179jE/UNufOxNQQIWfs/T1/0d6XPC9xvi8cTWYfqrOcemXhdAXC/L6gX
	/BSUXc=
X-Google-Smtp-Source: AGHT+IHLzOD/D3jEmGgz82HPiOxb2uycjGsV7OfoYxh7M5Fydb9RtUTa8j3fiOzoBEO33RqMZwJlGaOedPnxFrEffPg=
X-Received: by 2002:a17:907:7e85:b0:afe:9ae1:114b with SMTP id
 a640c23a62f3a-b01d973f4b0mr113693766b.40.1756540008426; Sat, 30 Aug 2025
 00:46:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756511030.git.marcelo.schmitt@analog.com> <47b2cf01555c31126bc2133526317c7829cb59ab.1756511030.git.marcelo.schmitt@analog.com>
In-Reply-To: <47b2cf01555c31126bc2133526317c7829cb59ab.1756511030.git.marcelo.schmitt@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Aug 2025 10:46:12 +0300
X-Gm-Features: Ac12FXw8gqRcCqiIz6LmDFBy64KDow5ZwkmjjRFsNp6APgoSqzFOQB-UC1Pp9Fo
Message-ID: <CAHp75VcnE4-nMrL7HS4UeNCtb1w-kQRjkixROS4jociQJurdbA@mail.gmail.com>
Subject: Re: [PATCH 13/15] iio: adc: ad4030: Enable dual data rate
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, jic23@kernel.org, Michael.Hennerich@analog.com, 
	nuno.sa@analog.com, eblanc@baylibre.com, dlechner@baylibre.com, 
	andy@kernel.org, corbet@lwn.net, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, broonie@kernel.org, Jonathan.Cameron@huawei.com, 
	andriy.shevchenko@linux.intel.com, ahaslam@baylibre.com, 
	sergiu.cuciurean@analog.com, marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 3:45=E2=80=AFAM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> Set AD4030 series device to do two data bit transitions per clock cycle p=
er
> active lane when specified by firmware. The dual data rate (DDR) feature =
is
> available only for host clock mode and echo clock mode.

...

>  struct ad4030_state {

>         enum ad4030_out_mode mode;
>         enum ad4030_lane_mode lane_mode;
>         enum ad4030_clock_mode clock_mode;
> +       bool ddr;

I believe you run `pahole` each time you modify the data type like this.

>         /* offload sampling spi message */
>         struct spi_transfer offload_xfer;
>         struct spi_message offload_msg;

...

>         else
>                 offload_bpw  =3D data_width / (1 << st->lane_mode);

With the previous comment WRT right shift...

> +       if (st->ddr)
> +               offload_bpw  /=3D 2;

...this also can use right shift, but I understand that 2 is more
explicit to show the point of DDR (as "double").

...

> +       /* DDR is only valid for echo clock and host clock modes */
> +       if (ret =3D=3D AD4030_ECHO_CLOCK_MODE || ret =3D=3D AD4030_CLOCK_=
HOST_MODE) {
> +               st->ddr =3D device_property_read_bool(dev, "adi,dual-data=
-rate");
> +               reg_modes |=3D FIELD_PREP(AD4030_REG_MODES_MASK_DDR_MODE,=
 st->ddr);

FIELD_MODIFY()?

> +       }

--=20
With Best Regards,
Andy Shevchenko

