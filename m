Return-Path: <linux-iio+bounces-8965-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A9E9684A0
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 12:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1E1283073
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 10:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06220140397;
	Mon,  2 Sep 2024 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCVlH7rO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A2513D503;
	Mon,  2 Sep 2024 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272783; cv=none; b=RxRWFyUqHWEL1Viaa4QG1Ebg2HKnNnxuQo6Jts/aQcdU3hISrhSCjHk13jCOFWbJ7VuXHmunuymGY9cnISFTcq5eTZ+5SRPFl3Y2RmvxlURos+7L7q1gz0/XDQ5f2WCRGSJuEVoKY8qs7s3XQRSGi3eAGavpHlFlDqPKzpWXLWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272783; c=relaxed/simple;
	bh=rEVUrFtiqwCQK98OkXBGgFn0TckxcxrYTuH5Y+CmOmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bmo+u/B8mYjdIH5RqaCIzqwVM4dDgyfNN+AWhUhLzjnHYe1+rYFvgCoL/o4P96w5vr5WaaOngJsjxh1ODn2ry/3NrGooVVZD3UmgkGu+btjwiG085UuK+D4sD5uIgrpxEZv2y+pOtjXzBXBpDsGEUFtE6qk1szP4BddT3pVGo6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCVlH7rO; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d679b094ffso2921854a91.1;
        Mon, 02 Sep 2024 03:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725272782; x=1725877582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEVUrFtiqwCQK98OkXBGgFn0TckxcxrYTuH5Y+CmOmg=;
        b=WCVlH7rOen4j4La3ofGdk7Vo2T0v8QIk2Vuyf86yViilXkX54VNi496dHtx9KHwQI+
         LfwR/i64AcLP5Sv4BvGFsPU+tbu9PLTgoLSjgjKUer1E5uL8e+BrgEPtj6KPOIqeHqlM
         8sTNz5H7YkyvF9eDcUCnoK+LLy1kDGuVkMCDUxTjpsSBYLwE5OxpfLkjxhZLxsjBCuZW
         UHBBJ2tWUpet9DG8yxreHgjgAvdQZO6mjqyos43kPgWHTGWjbMcm+XoI9y/DDi934Bew
         cUd4qHBXyg7khMpGQTbtNO3vSYq4DXcdoMua/+nY+c1M9NEEfyyPTs16XITXbcZzZxI6
         aakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725272782; x=1725877582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEVUrFtiqwCQK98OkXBGgFn0TckxcxrYTuH5Y+CmOmg=;
        b=VynCAYddYscwuTSSp6T/GfXPghnfV8/JJt8YpsxbWoNUG2hkJGHxRX+WAvBtWB++gP
         JpMS8QaqiO0UU0g7y83yNeB7iY3XyLjzbM41/aSF5oqeWeraNJ4KiTjXR7V8NdRVeRY3
         15lXewtpuiai40Wz376RqVYjIXffNy1+COlFwtqGDkPnPz1W9plra9vyKIBc+nhYVMbv
         BzS2u9qNwMUg2tkCYBA47HKcn/PD7TG8FR/O8RHU1NAjbjkiJUvCmq8G/+K4MzCfkql1
         JYJE59cGvO3KGkco+9sLuzj0ZYLwzQu5/7Vyl6tun5IIr2yG6G6rTO1OnoIMlWDkI0Af
         Jong==
X-Forwarded-Encrypted: i=1; AJvYcCVB9W3VNcisT7Dtu86xWxYiWrGFgW80XOp+tpEzUzLuXn2yucEY2VqOhfj+k8+anh5MtmdLNUcbzrEpME0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzAeU6uXeSER2YgA3M8SYNyfIV0XO2JTJE3cbQCR/odbidBWfc
	oUdBlk9xsqlZvd0oRtKaDmxC/NIGvi2dZbhbfElIMWlMUXg6KEk5n5pGyAb3ceob7HogmWF6RZ/
	GsrbuWyAC3DfLKM1nhg6yflFrp+c=
X-Google-Smtp-Source: AGHT+IEPhac+QAJrkwVet7td/SZbTiMHeIm9vqlVo8UnQ+hYeO4t2l/y1yDBmugTMSfkx0PKz7nbLoF/pSytr/jSg5Y=
X-Received: by 2002:a17:90a:cf09:b0:2d3:dd71:7b5b with SMTP id
 98e67ed59e1d1-2d8564c1e60mr11920909a91.42.1725272781724; Mon, 02 Sep 2024
 03:26:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901091214.15199-1-gye976@gmail.com> <533802b3-3034-4b7c-b903-72608917e2f0@web.de>
 <CAKbEznv-TmCr2FAodrM2SKK5A5pbV9p5-OvXPdmuk_4xXmh=Rw@mail.gmail.com>
 <7b827ee0-9116-4e8c-96e1-1fa5f7267f33@web.de> <CAKbEznu=+Bkw4kmoo7qG9h2wM=2XV54j_SYzHMAH1uWhtUPCvg@mail.gmail.com>
 <3c60e167-7815-49c8-89f1-fe1139879d6b@web.de>
In-Reply-To: <3c60e167-7815-49c8-89f1-fe1139879d6b@web.de>
From: gyeyoung <gye976@gmail.com>
Date: Mon, 2 Sep 2024 10:26:10 +0900
Message-ID: <CAKbEznvpazyV905CFOp_sDs+S=ihhXe2QH=Gc38oitjFFKOW=A@mail.gmail.com>
Subject: Re: iio: imu: inv_mpu6050: Remove duplicate code between labels
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 3:00=E2=80=AFPM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
>
> >>> Hello, I apologize for the insufficient explanation.
> >>
> >> How will the commit message be improved further?
> =E2=80=A6
> > Since the code is short,
>
> This implementation detail can be nice.
>
>
> > I think it's fine for now.
>
> Please reconsider such a view once more.
> Are imperative wordings also more desirable for a better change descripti=
on?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.11-rc6#n45
>
> Regards,
> Markus

Hello, as a newbie, thanks for providing several guidelines, But I
just suggested a minor thing as, and since the maintainer made the
decision and approved, I did not feel the need to go any further.

