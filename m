Return-Path: <linux-iio+bounces-18442-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E92FA951AF
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 15:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34F83AC04B
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B71264F80;
	Mon, 21 Apr 2025 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIIzskxG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC812AF1E;
	Mon, 21 Apr 2025 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745242243; cv=none; b=nmvC0UDHt2wcsRJOR12hF2qljNGhfHxiGkEtLF1OZdKhTzyBaTV5+RBEUZacD2XcjM4yAHdBgeXBdRQe6wpOxAi7M/7y0b0v7cBpKfVHz1gMViOIDr2V/pRpyr5kvC4egflCkuFdYG5mfaswDyzibpAQmBZ2Qo71sGjRxWnfdus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745242243; c=relaxed/simple;
	bh=0i0TyAPOXKI3l8ZynRkKZgCnay0DHc9wh7EcFzo8lK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvTrMk7oR9AHLAFCSpxC/Xm06H1SnQEN8HaolvBzS9/xywnzEZahaxJGa863SG0H+rfc0C5f8azYQYdT6P9OWgAPyVlccN4UMrQYuzErn1pPHKjcipnCb7kFlWfvN0bOhGGDLd4V3zL58Nq8uynTKg0OiHvN2nSYoytQkhHnaTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIIzskxG; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4775ce8a4b0so71710781cf.1;
        Mon, 21 Apr 2025 06:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745242240; x=1745847040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zQCssDwzH4/Q4JlbcmWxYd7mPnpwvZY0f5zJ4LwIRE=;
        b=FIIzskxG6z6FqpaENYENnJaVcuPe78Sm+o3JtIvW85Bvy8BTTFMuq6JRrvI2zDVWC3
         8+cMAoqzDEJWI7pT3jns4qyjCfVJyiCjTB5BF16pTZBJvFbdrcwsdd7tNL7GN0AVH+kQ
         9cLCM6cElAkmb8qW9crZT1qN6YFAzAsDTY4bl74NyTbJd7w+g/UNmzW21XrTlt42Hg9K
         A6/n71s6ziTA0ugxj/mmvOZUYruAYcGiLgq//WYzfdi+p51h1jhOaGs7AzuoKqYiqg3d
         mGW2Gbg5jXDMWmSPN5jSqK2rR4hnyovzx/Nd91F7Bikl70Y4Sd3VzU8n8HrwwqlXJf0n
         MJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745242240; x=1745847040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zQCssDwzH4/Q4JlbcmWxYd7mPnpwvZY0f5zJ4LwIRE=;
        b=rthsrcItdyvR1Epl399lpVdlU8oosL7mBLAXlpu1tfv1pVW39Gf8tjUgb99QtzlK+k
         X5u8meUSiCT+SbaWQNGAoYsxqaMldU17OAwrzwe4ChXHDBbg+HY0Pb0R+BLy50qOuM4p
         v4ackNq7dsjb636zu3w2+AT+aWHxmzIjl/hfHnr5p+/ly2va/DLHoLDmIyxfQUf3ac/d
         bvHEod1/q6UMP/1ana73g1u3auxdQY9j7gJ6xA8ygsO7JJ8bb4y3FwnHsbqry6C2Ganm
         2Tqn8qvY9JgqNHHkvuhAQ4XPUpHXrl02R5wwgjTVs7gtlIuBoi18KB2S+dU9JX8+FSDS
         ddrg==
X-Forwarded-Encrypted: i=1; AJvYcCU8yuSAITTPFuSbf0sR2PW5xpUdhWms6aXE0DgWroonMYlZthlbxMhrbuiK8+k5Vy8j0qhQ9y1e@vger.kernel.org, AJvYcCUu9VQNmVN2Up2XwJxpPzPYFyWU52TWDFLCpwTenSdIcqHAVfI9GDrWp947xm2fTyQr5XYS93bbYVcm9Dgl@vger.kernel.org, AJvYcCVtmTD9NfIodLGaFaFbRy//AtkN3v5hsbJk2BjA3vQx5T/do5JHhP1qFZloJpZdcyZfcS+kfRoC/+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4+LxLfwk7UZ9ewmqoUeBNEg9BjHDaNLRNqB6++rNF6NOKDE03
	N1gduC3oJ4kYNYddWaOJWl9cMfmroxaR2CuEgDdQe1wSwdi7mQtgpW/yY/U3sL8sNss7Tjmvsru
	gywn7xrvyeyGbOwaJ0+asbKYc3s5n+w9A+E5xaQ==
X-Gm-Gg: ASbGncsSlox/5rGrbxW64pTbLz0w8LzRElPnlqPzTa5trY+aIR5F7iFFC05QnKU1jzZ
	iXd8L37SSi71++eCuO0WeGAwGkuMUn06xa6RS2AMq24ceiFl5UDB78k3RYbrueozBMJ4w4pxECW
	0shvidjZkQDCLsv7A9UxChjVZMCvt8d1J89EvqeVS6dUsN+HkU5BUIsQ==
X-Google-Smtp-Source: AGHT+IEm/xmZibX65FV52m6B71Cf1v/smej0rvz4PepDzm+vnpKDYokJmknT/gvG+/daSiiMQVPrZ+vfMBcrOATxF+Y=
X-Received: by 2002:a05:622a:c5:b0:476:6f90:395e with SMTP id
 d75a77b69052e-47aec394390mr200563501cf.21.1745242239708; Mon, 21 Apr 2025
 06:30:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421122819.907735-1-gshahrouzi@gmail.com> <CAKUZ0zKgvwhzgq8+_HG845QDze2SGN2fPwdXuN=UkATea6Nuag@mail.gmail.com>
 <2025042153-rearrange-shakable-e404@gregkh>
In-Reply-To: <2025042153-rearrange-shakable-e404@gregkh>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Mon, 21 Apr 2025 09:30:28 -0400
X-Gm-Features: ATxdqUGnztcWcF1N5kH7d2yvCEfHpZd5DNAmlQzLZRVaObw_MrkullbHFSfrZtw
Message-ID: <CAKUZ0z+8XQo3P47Q53kg4YSowvAG+RisUfUMFWmpdKbHipSBOA@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: adis16201: Use IIO_VAL_INT for temperature scale
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 9:16=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Apr 21, 2025 at 08:33:00AM -0400, Gabriel Shahrouzi wrote:
> > Not sure this is worth mentioning but one of the emails from using
> > get_maintainer.pl on the patch listed a deprecated email:
> > gregkh@suse.de.
>
> How?  Doesn't do that for me:
>
> > >  drivers/iio/accel/adis16201.c | 2 +-
>
> $ ./scripts/get_maintainer.pl drivers/iio/accel/adis16201.c
> Lars-Peter Clausen <lars@metafoo.de> (maintainer:ANALOG DEVICES INC IIO D=
RIVERS)
> Michael Hennerich <Michael.Hennerich@analog.com> (maintainer:ANALOG DEVIC=
ES INC IIO DRIVERS)
> Jonathan Cameron <jic23@kernel.org> (maintainer:IIO SUBSYSTEM AND DRIVERS=
)
> linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS)
> linux-kernel@vger.kernel.org (open list)
> ANALOG DEVICES INC IIO DRIVERS status: Supported
>
> How did you run this?
I ran it on the patch: get_maintainer.pl
0001-iio-accel-adis16201-Use-IIO_VAL_INT-for-temperature-.patch
Lars-Peter Clausen <lars@metafoo.de> (maintainer:ANALOG DEVICES INC IIO DRI=
VERS)
Michael Hennerich <Michael.Hennerich@analog.com> (maintainer:ANALOG
DEVICES INC IIO DRIVERS)
Jonathan Cameron <jic23@kernel.org> (maintainer:IIO SUBSYSTEM AND
DRIVERS,blamed_fixes:1/1=3D100%)
Greg Kroah-Hartman <gregkh@suse.de> (blamed_fixes:1/1=3D100%)
linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS)
linux-kernel@vger.kernel.org (open list)
ANALOG DEVICES INC IIO DRIVERS status: Supported

Running it only on the file the patch modifies gives the same result
that you got.
>
> thanks,
>
> greg k-h

