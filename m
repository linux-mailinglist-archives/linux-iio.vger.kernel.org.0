Return-Path: <linux-iio+bounces-26138-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B3BC47564
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 15:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 759C2349D47
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 14:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AF9313E3F;
	Mon, 10 Nov 2025 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uuh7JrkT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB821E885A
	for <linux-iio@vger.kernel.org>; Mon, 10 Nov 2025 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786190; cv=none; b=odxwiis1zn91TO6YxDhJu0VlMPKl8H1fYc8PrQ5ARh/hGu2LJANiZDJcfPO4lvfsH3qn3rbuIkHG3hKO0daq53qn2TbXQJApPD8NTYZhwzzVoGyI3tU0V0R1q3hB+YzvW9VzXnMOOKsrMt49CoZwTijdQrH3m2rtA2Rxl16azZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786190; c=relaxed/simple;
	bh=PyrUyZt1KXdmHL8ZKhHDOfbDbrsNYwct4PjGJS3obe8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hywTA0ifz3UqGl2Rq7k22KOfiHROKsEWiacbYrYSP/cC1ridamRlU15sbGFaL99x4UcIoFxRfK4QAw7zevBA/Qbsv9yrDLm6PMHz6EVlhc9J20AsFe2+j3I6qHNgTWJuRFjcGh+hA3L+7bBtnRgfL7iPnblWte0HetXRWrnQ608=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uuh7JrkT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b3ad51fecso851804f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 10 Nov 2025 06:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762786185; x=1763390985; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UUTsjPuq5IEg7AJZaGEawlugjH0SqT6TpHHFp6KpABQ=;
        b=Uuh7JrkT8Kyd3pZUkzZ4upCElVjWcnehxMrWtcyiQw3v1dHYpDtPe17SSqnx/7it2x
         miaQoVYsJ6VoJk8iPVzOrJggOAjcqcLWd3TCW6ADiv0vkDSL22cM/LZ0lhXzujimkbQk
         L3nbKNLIuKtlzlOMLmqoY1+kd+81mud3QvdpqTMebdzJpOYumZhOmdcxXOxG+579CvbX
         Nv0seP5hsOFkCqvVURk/Wr9zgOvytsfiNztkUl5utypVzhV9h3pXRNT3VAB7I2hEjc+l
         nXd4k8kTpP7Gp7df+Qx/wTT3Wa2wdqTnCcexaAiWAraYhHKxyChfa1Sxj//Js7wcYSt3
         1C3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786185; x=1763390985;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUTsjPuq5IEg7AJZaGEawlugjH0SqT6TpHHFp6KpABQ=;
        b=O74j+5v9/LpEIdqn9J0kFFwj2zNxsaHBnwYEtMwKAv/XgdEjRTd1SNWop6FGE3KgUH
         k5knqYbhdACQ6rW+xj9zUJXHatJg8ue7EaOTg8ArF0MYznihzl+Xoc6YBc6Il/QuCiQd
         8QQxuqaWVHWjV3LhkAkW4KCBa4P8PkODWT4wb0nLpEthzpYCtiRkNdqwRFcIzgC7FgOd
         fW1yR7aPJZdoKVfpUX3eqolXPpmr/uhlgm4z7x6YhJf/lyCy8mtBuDXDyrG82U2sS3E6
         T05jD7WCpzLAJEy5suVZYn23+bgcEiaO99B/brl5VfdVBoGLAUXoxeN/WXy67vaWaGeP
         v0BA==
X-Gm-Message-State: AOJu0YxM6M3A8KSCzrIDeqosBhtVJ8QoK4jrZpm0zlKxe+iHJEOBvXga
	lWtUSxzhB3S3sKkH2ldt4L9z6zndLrm5e0Gp6V/AIxi+J5DpoTtSIVFG
X-Gm-Gg: ASbGnctzh+ugsu1jWcjwgBZW1I/UPChcxsyCInYtjAah3ASwOXfCSd86o/lUi2PH1Q+
	hXSMeT5DCEGQwlUbJrh3XktJoBKiwG6zZffguIPxoJpMkXi/55p6ckZRbXthCukfdY9ZZ/BHbEy
	plX7Ea6qCtP4DRG4t8Vs5cKecO4nconfdVijXfp8tOwe0Uo+6ouTX+DeD2+j3AS22+wSy/qt5v2
	R7wemfwheSlN2zsIOUy2Rtv/f5La3eH8VRk57PTzJFt+NuLT+hXUPeTQPKlqYOol6C4unW0CyD/
	mYDXG13Iub1yz4uccFbhzR6WG6p+sCBh1x6sSq213+cIqd1+k5WqlSBmEGWI+5g5SjRmP06tynJ
	jP1Lw/8rgDVhuNg/BPFsUClcFzUP0pW4hyuTButG6+MZ4KYEg/62SHsgWbfCyhbAHLbrP/JRhy3
	0yEbqZX1EA
X-Google-Smtp-Source: AGHT+IELre3k/Ybgp83pqzytOhWu+YaCKhxQ36NRAH8s58X0T74e+3oEYogMVn9EIsnJ1kyTRxHHWA==
X-Received: by 2002:a05:6000:22c8:b0:429:d6fa:da20 with SMTP id ffacd0b85a97d-42b2dc31fe4mr7011373f8f.25.1762786185297;
        Mon, 10 Nov 2025 06:49:45 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675cd25sm22834283f8f.22.2025.11.10.06.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 06:49:45 -0800 (PST)
Message-ID: <c8e0ea2d1859042bdc19a635718572f0e91d9889.camel@gmail.com>
Subject: Re: [PATCH v4 1/2] iio: trigger: add missing mutex_destroy in
 iio_trig_release
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Ma Ke <make24@iscas.ac.cn>, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org
Date: Mon, 10 Nov 2025 14:50:22 +0000
In-Reply-To: <20251110035701.36691-1-make24@iscas.ac.cn>
References: <20251110035701.36691-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-10 at 11:57 +0800, Ma Ke wrote:
> Add missing mutex_destroy() call in iio_trig_release() to properly
> clean up the mutex initialized in viio_trigger_alloc(). Ensure proper
> resource cleanup and follows kernel practices.
>=20
> Found by code review.
>=20
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v4:
> - split the patch into two independent patches and modified according to =
developer's suggestions;
> Changes in v3:
> - modified the patch;
> Changes in v2:
> - modified the patch, thanks for developer's suggestions.
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/industrialio-trigger.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industriali=
o-trigger.c
> index 54416a384232..5baa83349e8f 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -524,6 +524,7 @@ static void iio_trig_release(struct device *device)
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CONFIG_IIO_CONSUMERS_PER_TR=
IGGER);
> =C2=A0	}
> =C2=A0	kfree(trig->name);
> +	mutex_destroy(&trig->pool_lock);
> =C2=A0	kfree(trig);
> =C2=A0}
> =C2=A0

