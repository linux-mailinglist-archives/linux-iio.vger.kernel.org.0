Return-Path: <linux-iio+bounces-1046-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F3B8163F4
	for <lists+linux-iio@lfdr.de>; Mon, 18 Dec 2023 02:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 955D51C212D7
	for <lists+linux-iio@lfdr.de>; Mon, 18 Dec 2023 01:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4D51FB5;
	Mon, 18 Dec 2023 01:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Bc6t++zF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29941FA3
	for <linux-iio@vger.kernel.org>; Mon, 18 Dec 2023 01:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cc2238f597so26396811fa.3
        for <linux-iio@vger.kernel.org>; Sun, 17 Dec 2023 17:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702861859; x=1703466659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWcdDo2z23MEfFIIUBfnzGwWCiSyQqp5Xjc/Ssdnk14=;
        b=Bc6t++zFTSrr6kkQmwXyt4dlIToxtEhkw+2I4J4F2Phgb5v+sGykmzesxAxoBRtLi/
         tkZ7xYnFU/WtTPW3eGVxJm7jfTEa7bClGPnGU8lAwW+2PQZXPMc/19mYbVcxQg6kYWh5
         RjmdnnPFpG16EVLtBevXDKlhrMY8+bpzW+vmbpquBPvmCDlqTHSOG6RnHKmn2gpQU1Jd
         G18iu6SvtNIVyfmTHXIP+S6NPeIOAGT99lMvQpdRUibPswmr7z3MfvK9ngiKoZoBL9V+
         7xdTGD+dup6qccTKumheuyZ3yMtXhKjwuOTr/cAwecTMOvWKIBVaufGObhGgvB2p5yC8
         mW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702861859; x=1703466659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWcdDo2z23MEfFIIUBfnzGwWCiSyQqp5Xjc/Ssdnk14=;
        b=WV+au2OCs1vJJHheOmZrUfxZ85EftgwWdAm8RwKg3O9QiBKfuoPJjwuH0iyoIz3TTe
         2Rt+iauFcxDtwNmw8sY3vT45dIEHI6WzkP+c/GJZp4V7MAuAcRhxpJ1VZ/H63pebKAn/
         ChRz8J/COT3tjtgODhgWHiTUOpbS+zI/7SJKkVWyfQro30QkulMya3Ec/LCrDEmvnez/
         ioVC4DsN5jKpkEKaszumJjXBciwfUaHoM2S3twkFoLU8O52Zsvy9MhBUQHeeOJhcj6Ij
         +mbPCzx3oJ21g3IB392m5tDch0SvDJSRVsdhjNsZbTbrSSqULo1ayOURvovqypI8qZ3I
         RygA==
X-Gm-Message-State: AOJu0YxxUIEA8pJ+KrmDGGcDsMyNa8Hi8GAs7SSEWu9tUiuLA630mLI+
	0rXiDyB4h32OGLAZAA4dBr6BD5bmUx21+nDI90gU52550367cPqh
X-Google-Smtp-Source: AGHT+IH8Dfr+uZcfU2b6wwwmH9yyhwWkVfQnCWdJdvO6S/5SoR2RQeMoZKIC2SomfTYD7+RS9L/PrEw2Nl7gW5vUVD0=
X-Received: by 2002:a2e:8608:0:b0:2cc:652b:9fd4 with SMTP id
 a8-20020a2e8608000000b002cc652b9fd4mr320268lji.79.1702861858930; Sun, 17 Dec
 2023 17:10:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217173548.112701-1-jic23@kernel.org>
In-Reply-To: <20231217173548.112701-1-jic23@kernel.org>
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 17 Dec 2023 19:10:48 -0600
Message-ID: <CAMknhBF1fyop-s38psUmKc8KVZ30psEtica3g2tZPczYN70=DA@mail.gmail.com>
Subject: Re: [RFC PATCH V2 00/10] IIO: Use the new cleanup.h magic
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 11:36=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> A lot of the advantages of the automated cleanup added for locks and simi=
lar
> are not that useful in IIO unless we also deal with the
> iio_device_claim_direct_mode() / iio_device_release_direct_mode()
> calls that prevent IIO device drivers from transitioning into buffered
> mode whilst calls are in flight + prevent sysfs reads and writes from
> interfering with buffered capture if it is enabled.
>
> Relies on Peter Zilstra's conditional cleanup handling which is queued
> up for the merge window in the tip tree. This series is based on
> a merge of tip/master into iio/togreg.
>
> All comments welcome. If this looks positive I'll make use of it in a
> lot more drivers, but hopefully these give an idea of how it will work.
>
> The need to always handle what happens after
> iio_device_claim_direct_scoped() {} is a little irritating but the
> compiler will warn if you don't do it and it's not obvious how to
> let the compiler know the magic loop (hidden in the cleanup.h macros)
> always runs once.  Example:
>
>         iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
>                 return 42;
>         }
>         /* Can't actually get here, but compiler moans if no return val *=
/
>         return -EINVAL;

Maybe better would be?

        unreachable();

> }

